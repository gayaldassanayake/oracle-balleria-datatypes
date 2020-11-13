import ballerina/sql;
import ballerina/io;
import ballerina/java.jdbc;


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

function createDateTimeProcedure(jdbc:Client jdbcClient) returns error?{
    string[] variables = ["DATE", "TIMESTAMP", "TIMESTAMP WITH TIME ZONE", 
        "TIMESTAMP WITH LOCAL TIME ZONE", "INTERVAL YEAR TO MONTH", 
        "INTERVAL DAY TO SECOND"];
    string query = createProcedureQuery("DATETIMEPROC", variables);

    sql:ExecutionResult result = check jdbcClient->execute(query);
}

function createLOBProcedure(jdbc:Client jdbcClient) returns error?{
    string[] variables = ["RAW", "CLOB", "NCLOB", "BLOB", "BFILE",
                 "LONG", "LONG RAW"];

    string query = createProcedureQuery("LOBPROC", variables);

    sql:ExecutionResult result = check jdbcClient->execute(query);
}


# The `printCreateProcedureResult` function prints out the result of the procedure creation
# + procedurename - type string - name of the procedure
# + err - type error? - error during creation
function printCreateProcedureResult(string procedurename, error? err){
    if (err is error) {
            io:println(procedurename, " procedure creation failed! ", err);
    } else {
        io:println(procedurename, " procedure creation success! ", err);
    }
}

# The `createAllProcedures` function  creates all the procedure execution functions
# + jdbcClient - type jdbc:Client - jdbc client instance
# + return - error?
function createAllProcedures(jdbc:Client jdbcClient) returns error?{
    error? err;

    err = createNumericProcedure(jdbcClient);
    printCreateProcedureResult("NUMERIC", err);

    err = createCharacterProcedure(jdbcClient);
    printCreateProcedureResult("CHARACTER", err);

    err = createDateTimeProcedure(jdbcClient);
    printCreateProcedureResult("DATETIME", err);

    err = createLOBProcedure(jdbcClient);
    printCreateProcedureResult("LOB", err);
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
