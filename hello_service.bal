
//huyuddlojojjjhh

import ballerina/config;
import ballerina/http;
import ballerina/io;
import wso2/github4;
import ballerina/time;
import wso2/twilio;
import ballerina/log;


 
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
endpoint github4:Client githubClient {
        clientConfig: {
            auth:{
                scheme:http:OAUTH2,
                accessToken:" ece1ecdb9b17ef99e1003c3a5a8340a47a42bd63 "
            }
        }
    };

    github4:Repository repository = {};
    var repo = githubClient->getRepository("marshi96/x");
    match repo {
        github4:Repository rep => {
            repository = rep;
        }
        github4:GitClientError err => {
            io:println(err);
        }
    }

    var time = repository.updatedAt;

    

    if (time != repository.updatedAt) {

        // Do the SMS
           var fromMobile = "+15023736442";
        var toMobile = "+94716426869";



        var message = "heyyy saski idiot You have new commit FML";

        
       var details = twilioClient->sendSms(fromMobile, toMobile, message);
        match details {
            twilio:SmsResponse smsResponse => io:println(smsResponse);
            twilio:TwilioError twilioError => io:println(twilioError);

            
        } 
        
    }

    io:println(repository.updatedAt);



     
         
       

    }


    
}
 function main(string... args) {
  
    

} 
