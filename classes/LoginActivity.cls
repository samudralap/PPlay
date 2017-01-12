public with sharing class LoginActivity {
	
	static String completeURL = '';
	
	@AuraEnabled
	public static Object loginValidate(String url, String userEmail, String userPassword){

		//System.debug(url + '->' + userEmail + '->' + userPassword);
		//return url + '->' + userEmail + '->' + userPassword;
		//userEmail = 'sampath.c@autorabit.com';
		//userPassword = 'Rabit@345';

        LoginActivity loginActivity = new LoginActivity();

		String randomUUID = ArAppSingleTon.randomStringGenerator();
		System.debug('Random ' + randomUUID);

		Blob userPasswordBlob = Blob.valueOf(userPassword);
		String tempEncodedPassword = EncodingUtil.base64Encode(userPasswordBlob);

		String encodedPassword = randomUUID.substring(0, 5) + tempEncodedPassword + randomUUID.substring(randomUUID.length() - 6, randomUUID.length() - 1);
		System.debug(' Username-> ' + userEmail +'encodedPassword-> ' + encodedPassword);
		completeURL = 'https://' + url + '/rabitservices?wsdl';
		HttpRequest req = loginActivity.buildWebServiceRequest();
		String reqBody = '<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:web=\"http://ws.service.rabit.com/\"><soapenv:Body><web:userLogin><usermail>'+userEmail+'</usermail><password>'+encodedPassword+'</password><seccode>  </seccode></web:userLogin></soapenv:Body></soapenv:Envelope>';
		req.setBody(reqBody);
		Http http = new Http();
		
			HttpResponse res = loginActivity.invokeWebService(http, req);
			System.debug('String: ' + res.toString());
			System.debug('StatusCode: ' + res.getStatusCode());
			System.debug('Status: ' + res.getStatus());
			System.debug('Body: ' + res.getBody());

			System.debug('Soap Body -?  ' + reqBody);
			return res.getBody();

		
		
	}
	
	public HttpRequest buildWebServiceRequest(){
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
	    req.setHeader('Content-Type', 'text/xml; charset=utf-8');   
        req.setEndpoint(completeURL); 
        return req;
    }

    public HttpResponse invokeWebService(Http h, HttpRequest req){
         HttpResponse res = h.send(req);
         return res;
    }

    
}