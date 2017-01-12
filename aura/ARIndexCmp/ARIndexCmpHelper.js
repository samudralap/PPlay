({
    validateLogin : function(component) {
        var URLS = ["login.autorabit.com",
                    "se.autorabit.com",
                    "na1.autorabit.com",
                    "na3.autorabit.com",
                    "ns5.autorabit.com",
                    "na9.autorabit.com",
                    "na11.autorabit.com"];
        var isDataCorrect = true;
        var instanceURLField = component.find("logininstanceurl");
        var instanceURL = instanceURLField.get("v.value");
        //Validating INSTANCE->URL
        if ($A.util.isEmpty(instanceURL)){
            isDataCorrect = false;
            instanceURLField.set("v.errors", [{message:"Instance URL can't be blank."}]);
        }
        else {
            instanceURL = instanceURL.trim().toLowerCase();
            var isInstanceURLValid = false;
            for(var i=0;i<URLS.length;i++){
                if(URLS[i] == instanceURL){
                    isInstanceURLValid = true;
                    break;
                }
            }
            if(isInstanceURLValid){
                instanceURLField.set("v.errors", null);
                component.set("v.loginData.InstanceURL__c", instanceURL);
            }else{
                isDataCorrect = false;
                instanceURLField.set("v.errors", [{message:"Invalid URL"}]);
            }
            
        }
        
        //Validating User Email
        var userEmailField = component.find("loginusermail");
        var userEmail = userEmailField.get("v.value");
        var emailPattern = new RegExp("^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$");
        if ($A.util.isEmpty(userEmail)){
            isDataCorrect = false;
            userEmailField.set("v.errors", [{message:"Username can't be blank."}]);
        } else {
            userEmail = userEmail.trim().toLowerCase(); 
            if(emailPattern.test(userEmail)){
                userEmailField.set("v.errors", null);
                component.set("v.loginData.UserEmail__c", userEmail);
            } else{
                isDataCorrect = false;
                userEmailField.set("v.errors", [{message:"Invalid Username"}]);
            }
        }
        
        //Validating User Password
        var userPasswordField = component.find("loginuserpassword");
        var userPassword = userPasswordField.get("v.value");
        if ($A.util.isEmpty(userPassword)){
            isDataCorrect = false;
            userPasswordField.set("v.errors", [{message:"Password can't be blank."}]);
        } else{
            userPasswordField.set("v.errors", null);
        }
        
        return isDataCorrect;
    },
    
    loginCallOut : function(component, loginData, helper){
        var loginErrorDiv = component.find("loginerrordiv");
        loginErrorDiv.set("v.value", "");
        var action = component.get("c.loginValidate");
        action.setParams({
            "url": loginData.InstanceURL__c,
            "userEmail": loginData.UserEmail__c,
            "userPassword": loginData.UserPassword__c
        });
        action.setCallback(this, function(response){
            var loginErrorDiv = component.find("loginerrordiv");
            loginErrorDiv.set("v.value", "");
            if (component.isValid() && response.getState() == "SUCCESS") {
                var parser = new DOMParser();
                var xmlDoc = parser.parseFromString(response.getReturnValue(),"text/xml");
                var faultCodeNodes = xmlDoc.getElementsByTagName("faultcode");
                if(faultCodeNodes.length > 0){
                    var faultCodeNode = faultCodeNodes[0];
                    var faultCodeString = xmlDoc.getElementsByTagName("faultstring")[0];
                    alert(faultCodeNode.firstChild.data + " -> " + faultCodeString.firstChild.data);
                } else{
                    helper.parseLoginXMLResponse(component, helper ,response.getReturnValue());
                }
                //alert("Response from java class: " + response.getState());
            }
        });
        $A.enqueueAction(action);
    },
    
    parseLoginXMLResponse : function(component, helper, xmlString){
        var spinnerDivTarget = component.find('spinnerDiv');
        $A.util.addClass(spinnerDivTarget, 'hide');
        
        var parser = new DOMParser();
        var xmlDoc = parser.parseFromString(xmlString,"text/xml");
        var userNode = xmlDoc.getElementsByTagName("user");
        if(userNode.length > 0){
            var firstNameNode = userNode[0].getElementsByTagName("firstname")[0];
            var lastNameNode = userNode[0].getElementsByTagName("lastname")[0];
            
            alert("Hi  " + userNode[0].getAttribute("email") + " " + 
                  firstNameNode.firstChild.data + " " +
                  lastNameNode.firstChild.data);
        } else if(userNode.length == 0){
            helper.printReturnTagErrorResponse(component, helper, xmlString);
        }
        
        
    },
    
    printReturnTagErrorResponse : function(component, helper, xmlString){
        
        
        var parser = new DOMParser();
        var xmlDoc = parser.parseFromString(xmlString,"text/xml");
        var returnTagNode = xmlDoc.getElementsByTagName("return")[0];
        var loginErrorDiv = component.find("loginerrordiv");
        
        //================================ TODO://      
        switch (returnTagNode.firstChild.data) {
            case "Login failed; Invalid userID or password":
                var d = document.createElement('div');
                //loginErrorDiv.set("v.value", "Please visit <a href=\"https://" + component.find("logininstanceurl").get("v.value") + "\" >" + component.find("logininstanceurl").get("v.value") + "</a> to reset password");
                
                
                loginErrorDiv.set("v.value", returnTagNode.firstChild.data.replace(";", ""));
                break;
                
            case "Account is locked":
            case "Empty Security Code":
            case "Invalid Security Code":
                loginErrorDiv.set("v.value", "Please visit <a href=\"https://" + component.find("logininstanceurl").get("v.value") + "\" /> to reset password");
                break;
        }
        
    },
    
    sampleTest : function(){
        alert("from another function ");
    },
})