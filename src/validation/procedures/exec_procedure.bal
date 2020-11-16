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
    io:println("Character Procedure Execution Started!\n");

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

function executeDatetimeProcedure(jdbc:Client jdbcClient) returns error?{
    
    io:println("\n------------------------------------");
    io:println("Datetime Procedure Execution Started!\n");

    sql:ParameterizedCallQuery query = `CALL DATETIMEPROC(   
        ${DATETIME_IN}, ${DATETIME_INOUT}, ${DATETIME_OUT},
        ${TIMESTAMP_IN}, ${TIMESTAMP_INOUT}, ${TIMESTAMP_OUT}, 
        ${TIMESTAMPTZ_IN}, ${TIMESTAMPTZ_INOUT}, ${TIMESTAMPTZ_OUT}, 
        ${TIMESTAMPTZL_IN}, ${TIMESTAMPTZL_INOUT}, ${TIMESTAMPTZL_OUT},
        ${INTERVALY2M_IN} ${INTERVALY2M_INOUT}, ${INTERVALY2M_OUT},
        ${INTERVALD2S_IN}, ${INTERVALD2S_INOUT}, ${INTERVALD2S_OUT}
        )`;

    sql:ProcedureCallResult result = check jdbcClient->call(query);

    io:println(DATETIME_INOUT.get(string), " ", DATETIME_OUT.get(string));
    io:println(TIMESTAMP_INOUT.get(string), " ", TIMESTAMP_OUT.get(string));
    io:println(TIMESTAMPTZ_INOUT.get(string), " ", TIMESTAMPTZ_OUT.get(string));
    io:println(TIMESTAMPTZL_OUT.get(string), " ", TIMESTAMPTZL_OUT.get(string));
    io:println(INTERVALY2M_INOUT.get(string), " ", INTERVALY2M_OUT.get(string));
    io:println(INTERVALD2S_INOUT.get(string), " ", INTERVALD2S_OUT.get(string));
    
}

function executeBLOBProcedure(jdbc:Client jdbcClient) returns error?{
    
    io:println("\n------------------------------------");
    io:println("BLOB Procedure Execution Started!\n");

    sql:ParameterizedCallQuery query = `CALL BLOBPROC(   
        ${BLOB_IN}, ${BLOB_INOUT}, ${BLOB_OUT}
        )`;

    sql:ProcedureCallResult result = check jdbcClient->call(query);

    io:println(BLOB_INOUT.get(string), " ", BLOB_OUT.get(string));
    
}

function executeCLOBProcedure(jdbc:Client jdbcClient) returns error?{
    
    io:println("\n------------------------------------");
    io:println("CLOB Procedure Execution Started!\n");

    sql:ParameterizedCallQuery query = `CALL CLOBPROC(   
        ${CLOB_IN}, ${CLOB_INOUT}, ${CLOB_OUT}
        )`;

    sql:ProcedureCallResult result = check jdbcClient->call(query);

    io:println(CLOB_INOUT.get(string), " ", CLOB_OUT.get(string));
    
}

function executeNCLOBProcedure(jdbc:Client jdbcClient) returns error?{
    
    io:println("\n------------------------------------");
    io:println("NCLOB Procedure Execution Started!\n");

    sql:ParameterizedCallQuery query = `CALL CLOBPROC(   
        ${NCLOB_IN}, ${NCLOB_INOUT}, ${NCLOB_OUT}
        )`;

    sql:ProcedureCallResult result = check jdbcClient->call(query);

    io:println(NCLOB_INOUT.get(string), " ", NCLOB_OUT.get(string));
    
}

function executeLongProcedure(jdbc:Client jdbcClient) returns error?{
    
    io:println("\n------------------------------------");
    io:println("LONG Procedure Execution Started!\n");

    sql:ParameterizedCallQuery query = `CALL LONGPROC(  
        ${LONG_IN}, ${LONG_INOUT}, ${LONG_OUT}
        )`;

    sql:ProcedureCallResult result = check jdbcClient->call(query);

    io:println(LONG_INOUT.get(string), " ", LONG_OUT.get(string));
    
}


function executeRawProcedure(jdbc:Client jdbcClient) returns error?{
    
    io:println("\n------------------------------------");
    io:println("RAW Procedure Execution Started!\n");

    sql:ParameterizedCallQuery query = `CALL RAWPROC(  
        ${RAW_IN}, ${RAW_INOUT}, ${RAW_OUT} ,
        ${LONGRAW_IN}, ${LONGRAW_INOUT}, ${LONGRAW_OUT}
        )`;

    sql:ProcedureCallResult result = check jdbcClient->call(query);

    io:println(RAW_INOUT.get(string), " ", RAW_OUT.get(string));
    io:println(LONGRAW_INOUT.get(string), " ", LONGRAW_OUT.get(string));
    
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

    // err = executeNumericProcedure(jdbcClient);
    // printExecuteProcedureResult("NUMERIC", err);

    // err = executeCharacterProcedure(jdbcClient);
    // printExecuteProcedureResult("CHARACTER", err);

    // err = executeDatetimeProcedure(jdbcClient);
    // printExecuteProcedureResult("DATETIME", err);

    err = executeBLOBProcedure(jdbcClient);
    printExecuteProcedureResult("BLOB", err);

    // err = executeCLOBProcedure(jdbcClient);
    // printExecuteProcedureResult("CLOB", err);

    // err = executeNCLOBProcedure(jdbcClient);
    // printExecuteProcedureResult("NCLOB", err);

    err = executeLongProcedure(jdbcClient);
    printExecuteProcedureResult("LONG", err);

    // err = executeRawProcedure(jdbcClient);
    // printExecuteProcedureResult("RAW", err);
}