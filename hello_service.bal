
import ballerina/http;
import ballerina/io;
import ballerina/log;
import wso2/github4;
import wso2/twilio;

string path = "app.bal";
endpoint twilio:Client twilioClient {
    accountSId:"ACa1770e9d17a7e3aa12ac29b5f40e33ff",
    authToken:"ca5a082803a59ae32fcb81ce919582d9",
    xAuthyKey:"c2c85b2178e4c444fbb975ba55b4994b"
};

endpoint http:Listener listener {
    port:9090
};

service<http:Service> twilio bind listener {
    twilioSms (endpoint caller, http:Request request) {
        http:Response response = new;

        var fromMobile = "+15023736442";
        var toMobile = "+94716426869";


        var message = "chansi won 1million !!! most ugliest person in mora";

        var details = twilioClient->sendSms(fromMobile, toMobile, message);
        match details {
            twilio:SmsResponse smsResponse => io:println(smsResponse);
            twilio:TwilioError twilioError => io:println(twilioError);
            
        }
                         io:println("ok!");

       _ = caller -> respond(response);

    }
}
