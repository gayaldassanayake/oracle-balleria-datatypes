import ballerina/sql;
import ballerina/io;
import ballerina/java.jdbc;

function executeNumericProcedure(jdbc:Client jdbcClient) returns error?{
    io:println("\n------------------------------------");
    io:println("Numeric Procedure Execution Started!\n");

    sql:ParameterizedCallQuery query = `CALL NUMERICPROC(   
        ${NUMBER_IN}, ${NUMBER_INOUT}, ${NUMBER_OUT},
        ${FLOAT_IN}, ${FLOAT_INOUT}, ${FLOAT_OUT},
        ${BINARY_FLOAT_IN}, ${BINARY_FLOAT_INOUT}, ${BINARY_FLOAT_OUT},
        ${BINARY_DOUBLE_IN}, ${BINARY_DOUBLE_INOUT}, ${BINARY_DOUBLE_OUT}      
        )`;

    sql:ProcedureCallResult result = check jdbcClient->call(query);

    io:println(NUMBER_INOUT.get(float), " ", NUMBER_OUT.get(float));
    io:println(FLOAT_INOUT.get(float), " ", FLOAT_OUT.get(float));
    io:println(BINARY_FLOAT_INOUT.get(float), " ", BINARY_FLOAT_OUT.get(float));
    io:println(BINARY_DOUBLE_INOUT.get(float), " ", BINARY_DOUBLE_OUT.get(float));

}

function executeCharacterProcedure(jdbc:Client jdbcClient) returns error?{
    
    io:println("\n------------------------------------");
    io:println("Numeric Procedure Execution Started!\n");

    sql:ParameterizedCallQuery query = `CALL CHARACTERPROC(   
        ${VARCHAR2_IN}, ${VARCHAR2_INOUT}, ${VARCHAR2_OUT},
        ${VARCHAR_IN}, ${VARCHAR_INOUT}, ${VARCHAR_OUT},
        ${NVARCHAR2_IN}, ${NVARCHAR2_INOUT}, ${NVARCHAR2_OUT},
        ${CHAR_IN}, ${CHAR_INOUT}, ${CHAR_OUT},
        ${NCHAR_IN}, ${NCHAR_INOUT}, ${NCHAR_OUT}      
        )`;

    sql:ProcedureCallResult result = check jdbcClient->call(query);

    io:println(VARCHAR2_INOUT.get(string), " ", VARCHAR2_OUT.get(string));
    io:println(VARCHAR_INOUT.get(string), " ", VARCHAR_OUT.get(string));
    io:println(NVARCHAR2_INOUT.get(string), " ", NVARCHAR2_OUT.get(string));
    io:println(CHAR_INOUT.get(string), " ", CHAR_OUT.get(string));
    io:println(NCHAR_INOUT.get(string), " ", NCHAR_OUT.get(string));
    
}

# The `printExecuteProcedureResult` function that prints out the result of the procedure execution
# + procedurename - type string - name of the procedure
# + err - type error? - error during execution
function printExecuteProcedureResult(string procedurename, error? err){
    if (err is error) {
            io:println("\n"+procedurename, " procedre execution failed! ", err);
    } else {
        io:println("\n"+procedurename, " procedure execution success! ", err);
    }
}

# The `executeAllProcedures` function that calls all the procedure execution functions
# + jdbcClient - type jdbc:Client - jdbc client instance
# + return - error?
function executeAllProcedures(jdbc:Client jdbcClient) returns error?{
    error? err;

    err = executeNumericProcedure(jdbcClient);
    printExecuteProcedureResult("NUMERIC", err);

    // err = executeCharacterProcedure(jdbcClient);
    // printExecuteProcedureResult("CHARACTER", err);
}