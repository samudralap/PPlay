@isTest
public class ARApexTest {
    static testMethod void checkRandomString(){
        ArAppSingleTon.randomStringGenerator();
        
    }
    
    static testMethod void loginDiner(){
        
        test.startTest();
			test.setMock(HttpCalloutMock.class, new testHttpCalloutMock());
			
			LoginActivity login = new LoginActivity();
			
			LoginActivity.loginValidate('','','');
			
			HttpRequest req = login.buildWebServiceRequest();
			
			//calloutViewer_Controller controller = new calloutViewer_Controller();
			//controller.getMethodOptions();
			//controller.requestEndpoint = 'https://api.stackexchange.com/2.2/questions/unanswered?site=salesforce';
			//controller.requestMethod = 'GET';
			//controller.requestBody = '';
			//controller.callout();
			//controller.deserializeQuestions();

		test.stopTest();
        
      //'
      
      //HttpRequest req = loginActivity.buildWebServiceRequest('http://183.82.4.69:8966/rabit/rabitservices?wsdl');
      //HttpResponse res = new HttpResponse();
      
      //LoginActivity.loginValidate('','','');
      
        //First, build the http request
      //HttpRequest req = loginActivity.buildWebServiceRequest();
      //Http h = new Http();
      
      
   
      //NOTE - WE DO NOT EXECUTE THE METHOD, invokeWebService. 
      
      //Now, since we can't execute the actual web service, 
      //write apex code to build a sample HttpResponse object
      //HttpResponse res = loginActivity.invokeWebService(h, req);
      //Apply test data and attributes to the HttpResponse object as needed
      
      
    }
    
}