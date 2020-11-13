import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;

# The `initializeClient` function initializes an instance of jdbc connector
# + return - sql:Error| jdbc:Client
function initializeClient() returns sql:Error| jdbc:Client {
    jdbc:Client jdbcClient = check new ("jdbc:oracle:thin:@//localhost:1521/ORCLCDB.localdomain", "admin", "password");
    io:println("JDBC client with user/password created.");
    return jdbcClient;
}

# The `closeClient` function closes the instance of jdbc connector
# + return - sql:Error?
function closeClient(jdbc:Client jdbcClient) returns sql:Error?{
    check jdbcClient.close();
}

# The `process` function sends a 50,000 character strip of read long character stream
# + return - @untainted string|error
function process(io:ReadableCharacterChannel sc) returns @untainted string|error {

    string greetingText = check sc.read(50000) ;
    return greetingText;
    
}

# The `closeRf` function closes the large byte file
# + rf type io:ReadableByteChannel - readableByteChannel object
function closeRf(io:ReadableByteChannel rf){
    var cr = rf.close();
    if (cr is error) {
        io:println("Error occurred while closing the channel: ", cr);
    }
}

# The `closeRc` function closes the large character file
# + ch type io:ReadableCharacterChannel - ReadableCharacterChannel object
function closeRc(io:ReadableCharacterChannel ch) {
    var cr = ch.close();
    if (cr is error) {
        io:println("Error occurred while closing the channel: ", cr);
    }
}

# The `readFileAsByte` function reads the input file as of bytes
# + return error| byte[]
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

# The `readFileAsCharacter` function reads the input file as of characters
# + return error| string
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

# The `stripArray` function closes the large character file
# + arr type byte[] - the byte array that needs to be stripped
# + len type int - the length of the byte array
# + return stripped array
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


# The `createParameterName` function that formats the parameter names
# + datatype - type string - name of the datatype that is used to create param name 
# + return - the parameter name
function createParameterName(string datatype)returns string{
    string trimmedType = datatype.trim();
    string returnString = "";
    int i = 0;
    while(i< trimmedType.length()){
        if(trimmedType[i]==" "){
            returnString+="_";
        } else{
            returnString+=trimmedType[i];
        }
        i+=1;
    }

    return returnString;
}

# The `createProcedureQuery` function stitches the procedure queries at runtime
# + name - type string - name of the procedure 
# + variables - type string[] - data types of the parameters of the procedure
# + return - the procedure query
function createProcedureQuery(string name, string[] variables) returns string{
    string query;
    string signature = "CREATE OR REPLACE PROCEDURE ";
    string params = " (";
    
    int i = 0;
    while(i<variables.length()){
        params+= "\nIN_"+createParameterName(variables[i])+" IN "+variables[i]+", ";
        params+= "\nINOUT_"+createParameterName(variables[i])+" IN OUT "+variables[i]+", ";
        params+= "\nOUT_"+createParameterName(variables[i])+" OUT "+variables[i];
        if(i<variables.length()-1){
            params+=", ";
        }
        i+=1;
    }
    params+="\n) ";

    string body = "\nAS BEGIN ";

    i = 0;
    while(i<variables.length()){
        body+= "\nSELECT IN_"+createParameterName(variables[i])+ " INTO INOUT_" +createParameterName(variables[i])+ " FROM SYS.DUAL; ";
        body+= "\nSELECT IN_"+createParameterName(variables[i])+ " INTO OUT_" +createParameterName(variables[i])+ " FROM SYS.DUAL; ";
        i+=1;
    }
    
    body+= "\nEND; ";

    query = signature + name + params + body;

    return query;
}