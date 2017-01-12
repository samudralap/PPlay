({
    loginAuthorizer : function(component, event, helper) {
        if(helper.validateLogin(component)){
            var spinnerDivTarget = component.find('spinnerDiv');
            $A.util.removeClass(spinnerDivTarget, 'hide');
            $A.util.addClass(spinnerDivTarget, 'show');
            
            var loginFieldsData = component.get("v.loginData");
            helper.loginCallOut(component, JSON.parse(JSON.stringify(loginFieldsData)), helper);
        }
    },
    doInit : function(component, event, helper) {
        var loginErrorDiv = component.find("loginerrordiv");
        loginErrorDiv.set("v.value", '');
        
        var spinnerDivTarget = component.find('spinnerDiv');
        $A.util.addClass(spinnerDivTarget, 'hide');
    },
    
    formPress : function(component, event, helper) {
        if (event.keyCode === 13) {
            if(helper.validateLogin(component)){
                var spinnerDivTarget = component.find('spinnerDiv');
                $A.util.removeClass(spinnerDivTarget, 'hide');
                $A.util.addClass(spinnerDivTarget, 'show');
                
                var loginFieldsData = component.get("v.loginData");
                helper.loginCallOut(component, JSON.parse(JSON.stringify(loginFieldsData)), helper);
            }
        }
    },
    
    passwordField : function(component, event, helper) {
        //console.log('sampath');
    },
    
})