//hryyyyy
// A system package containing protocol access constructs
// Package objects referenced with 'http:' in code
import ballerina/http;
import ballerina/io;
import wso2/twilio;
import wso2/github4;
documentation {
   A service endpoint represents a listener.
}
endpoint http:Listener listener {
    port:8080
};

documentation {
   A service is a network-accessible API
   Advertised on '/hello', port comes from listener endpoint
}
endpoint github4:Client githubClient {
        clientConfig: {
            auth:{
                scheme:http:OAUTH2,
                accessToken:"718a18fb509be50dd65ef23c325666b1c1ccb6d3"
            }
        }
    };
endpoint twilio:Client twilioClient {
        accountSId:"ACa1770e9d17a7e3aa12ac29b5f40e33ff",
        authToken:"ca5a082803a59ae32fcb81ce919582d9"
    };
service<http:Service> jsons bind listener {

    documentation {
       A resource is an invokable API method
       Accessible at '/hello/sayHello
       'caller' is the client invoking this resource 

       P{{caller}} Server Connector
       P{{request}} Request
    }
    payload (endpoint caller, http:Request request) {
       http:Response response = new;
       var payload =  request.getJsonPayload();
       match payload {
           json myJsonPayload=>
            {
              //  io:println(myJsonPayload["commits"])
                foreach (commit in myJsonPayload["commits"]){
                    io:println(commit["author"]["name"]);
                    io:println(commit["message"]);
                    string sms = commit["author"]["name"].toString()+" saskiya made a new change("+commit["message"].toString()+")";
                    var details = twilioClient->sendSms("+15023736442", "+94716426869", untaint sms);
                    match details {
                        twilio:SmsResponse smsResponse => io:println(smsResponse);
                        twilio:TwilioError twilioError => io:println(twilioError);
                    }
                }
                response.setJsonPayload({"status":"ok"});
            }
            any =>
                {
                     io:println("invalid response");
                     response.setJsonPayload({"status":"error"});
                }
       }
   // io:println(payload);
      //  io:println(request);

        // Send a response back to caller
        // Errors are ignored with '_'
        // -> indicates a synchronous network-bound call
        _ = caller -> respond(response);
    }
}
