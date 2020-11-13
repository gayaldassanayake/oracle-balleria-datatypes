import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;

function initializeClient() returns sql:Error| jdbc:Client {
    jdbc:Client jdbcClient = check new ("jdbc:oracle:thin:@//localhost:1521/ORCLCDB.localdomain", "admin", "password");
    io:println("JDBC client with user/password created.");
    return jdbcClient;
}

function closeClient(jdbc:Client jdbcClient) returns sql:Error?{
    check jdbcClient.close();
}

function process(io:ReadableCharacterChannel sc) returns @untainted string|error {

    string greetingText = check sc.read(50000) ;
    return greetingText;
    
}

function closeRf(io:ReadableByteChannel rf){
    var cr = rf.close();
    if (cr is error) {
        io:println("Error occurred while closing the channel: ", cr);
    }
}

function closeRc(io:ReadableCharacterChannel ch) {
    var cr = ch.close();
    if (cr is error) {
        io:println("Error occurred while closing the channel: ", cr);
    }
}

function readFileAsByte() returns @untainted error|byte[] {
    

    io:ReadableByteChannel readableFieldResult =
                                 check io:openReadableFile("src/validation/resources/bigfile.txt");
    var result = readableFieldResult.read(50000);

    if (result is error) {
        io:println("error occurred while processing chars ", result);
    } else {
        io:println("File processing complete.");
    }

    closeRf(readableFieldResult);

    return result;
}


function readFileAsCharacter() returns @untainted error|string {
    

    io:ReadableByteChannel readableFieldResult =
                                 check io:openReadableFile("src/validation/resources/bigfile.txt");
    io:ReadableCharacterChannel sourceChannel =
                                new (readableFieldResult, "UTF-8");

    var result = process(sourceChannel);
    string data = "";
    if (result is error) {
        io:println("error occurred while processing chars ", result);
    } else {
        data = result;
    }

    closeRc(sourceChannel);

    return data;

}

function stripArray(byte[] arr, int len) returns byte[] {
    int i = 0;
    byte[] strippedArray = arr.filter(function (int value) returns boolean{
            if(i< len){
                i+=1;
                return (true);
            }
            return(false);
        });

    return strippedArray;
}