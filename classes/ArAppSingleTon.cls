public with sharing class ArAppSingleTon {
	public ArAppSingleTon() {}

	public static String randomStringGenerator(){
		String hashString = '1000' + String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS'));
		Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(hashString));
		String randomUUID = EncodingUtil.convertToHex(hash);
		return randomUUID;
	}

	/*public static String finalSoaper(String body){

		String finalSoaperString = '';
                /* Blob b = Blob.valueOf(finalSoaperString);
        System.debug('Singleton ->' + '<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:web=\"http://ws.service.rabit.com/\">' +
                '<soapenv:Body>' +
                	body +
                '</soapenv:Body>' +
                '</soapenv:Envelope>'); 	

		return finalSoaperString;
	}

	public static String userLogin(String userMail, String encodedPassword, String secCode){

		String userLoginBody =  '<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:web=\"http://ws.service.rabit.com/\">' +
                '<soapenv:Body>' +
                '<usermail>' + userMail + '</usermail>' +
                '<password>' + encodedPassword + '</password>' +
                '<seccode>' + secCode + '</seccode>' +
                '</soapenv:Body>' +
                '</soapenv:Envelope>';

		return userLoginBody;
	}*/

}