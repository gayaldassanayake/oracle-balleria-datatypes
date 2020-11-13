import ballerina/sql;
import ballerina/io;
import ballerina/java.jdbc;


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
        params+= "\nIN_"+variables[i]+" IN "+variables[i]+", ";
        params+= "\nINOUT_"+variables[i]+" IN OUT "+variables[i]+", ";
        params+= "\nOUT_"+variables[i]+" OUT "+variables[i];
        if(i<variables.length()-1){
            params+=", ";
        }
        i+=1;
    }
    params+="\n) ";

    string body = "\nAS BEGIN ";

    i = 0;
    while(i<variables.length()){
        body+= "\nSELECT IN_"+variables[i]+ " INTO INOUT_" +variables[i]+ " FROM SYS.DUAL; ";
        body+= "\nSELECT IN_"+variables[i]+ " INTO OUT_" +variables[i]+ " FROM SYS.DUAL; ";
        i+=1;
    }
    
    body+= "\nEND; ";

    query = signature + name + params + body;

    return query;
}

function createNumericProcedure(jdbc:Client jdbcClient) returns error?{

    string[] variables = ["NUMBER","FLOAT", "BINARY_FLOAT", "BINARY_DOUBLE"];
    string query = createProcedureQuery("NUMERICPROC", variables);

    sql:ExecutionResult result = check jdbcClient->execute(query);
}

function createCharacterProcedure(jdbc:Client jdbcClient) returns error?{
    string[] variables = ["VARCHAR2", "VARCHAR", "NVARCHAR2", "CHAR", "NCHAR"];
    string query = createProcedureQuery("CHARACTERPROC", variables);

    sql:ExecutionResult result = check jdbcClient->execute(query);
}

// function createDateTimeProcedure(jdbc:Client jdbcClient) returns error?{
//     string[] variables = ["DATE", "TIMESTAMP", "TIMESTAMP (9) WITH TIME ZONE", 
//         "TIMESTAMP (9) WITH LOCAL TIME ZONE", "INTERVAL YEAR TO MONTH", 
//         "INTERVAL DAY(9) TO SECOND(9)"];
//     string query = createProcedureQuery("DATETIMEPROC", variables);

//     sql:ExecutionResult result = check jdbcClient->execute(query);
// }

function createLOBProcedure(jdbc:Client jdbcClient) returns error?{
    string[] variables = ["RAW", "CLOB", "NCLOB", "BLOB", "BFILE",
                 "LONG", "LONG RAW"];

    string query = createProcedureQuery("LOBPROC", variables);

    sql:ExecutionResult result = check jdbcClient->execute(query);
}


# The `printCreateProcedureResult` function that prints out the result of the procedure creation
# + procedurename - type string - name of the procedure
# + err - type error? - error during creation
function printCreateProcedureResult(string procedurename, error? err){
    if (err is error) {
            io:println(procedurename, " procedure creation failed! ", err);
    } else {
        io:println(procedurename, " procedure creation success! ", err);
    }
}

# The `createAllProcedures` function that creates all the procedure execution functions
# + jdbcClient - type jdbc:Client - jdbc client instance
# + return - error?
function createAllProcedures(jdbc:Client jdbcClient) returns error?{
    error? err;

    // err = createNumericProcedure(jdbcClient);
    // printCreateProcedureResult("NUMERIC", err);

    // err = createCharacterProcedure(jdbcClient);
    // printCreateProcedureResult("CHARACTER", err);

    // err = createDateTimeProcedure(jdbcClient);
    // printCreateProcedureResult("DATETIME", err);

    err = createLOBProcedure(jdbcClient);
    printCreateProcedureResult("DATETIME", err);
}




















// function anydatasetProcedureCreate(jdbc:Client jdbcClient)returns error?{
//     sql:ExecutionResult result = check jdbcClient->execute(
//      "DECLARE "+
//         "atyp anytype; "+
//         "outset anydataset ; "+
//         "BEGIN "+
        
//         "begin "+
//             "anytype.begincreate( dbms_types.typecode_object, atyp ); "+
//             "atyp.addattr "+
//             "( 'f1' "+
//             ", dbms_types.typecode_number "+
//             ", null "+
//             ", null "+
//             ", null "+
//             ", null "+
//             ", null "+
//             ") ; "+
//             "atyp.addattr "+
//             "( 'f2' "+
//             ", dbms_types.typecode_varchar2 "+
//             ", NULL "+
//             ", NULL "+
//             ", 100 "+
//             ", null "+
//             ", null "+
//             ") ; "+
//             "atyp.endcreate; "+
//         "end; "+
        
//         "anydataset.begincreate( dbms_types.typecode_object, atyp, outset ); "+
//         "for i in 1 .. 5 "+
//         "loop "+
//             "outset.addinstance; "+
//             "outset.piecewise(); "+
//             "outset.setnumber( i ); "+
//             "outset.setvarchar2( 'row: ' || to_char( i ) ); "+

//         "end loop; "+
//         "outset.endcreate; "+
//         "dbms_output.put_line( 'Finished' ); "+
//         "END ; "
//     );
//     io:println(result);

// }
