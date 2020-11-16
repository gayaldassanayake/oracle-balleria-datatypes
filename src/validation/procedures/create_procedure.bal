import ballerina/sql;
import ballerina/io;
import ballerina/java.jdbc;

function createNumericProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["NUMBER", "FLOAT", "BINARY_FLOAT", "BINARY_DOUBLE"];
    string query = createProcedureQuery("NUMERICPROC", variables);
    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createCharacterProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["VARCHAR2", "VARCHAR", "NVARCHAR2", "CHAR", "NCHAR"];
    string query = createProcedureQuery("CHARACTERPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createDateTimeProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["DATE", "TIMESTAMP", "TIMESTAMP WITH TIME ZONE", "TIMESTAMP WITH LOCAL TIME ZONE", "INTERVAL YEAR TO MONTH", "INTERVAL DAY TO SECOND"];
    string query = createProcedureQuery("DATETIMEPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createBLOBProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["BLOB"];

    string query = createProcedureQuery("BLOBPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createCLOBProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["CLOB"];

    string query = createProcedureQuery("CLOBPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createNCLOBProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["NCLOB"];

    string query = createProcedureQuery("NCLOBPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createLongProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["LONG"];

    string query = createProcedureQuery("LONGPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createRawProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["RAW", "LONG RAW"];

    string query = createProcedureQuery("RAWPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createBfileProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["BFILE"];

    string query = createProcedureQuery("BFILEPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createRowIdProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["ROWID"];

    string query = createProcedureQuery("ROWIDPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createANSITypesProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["CHARACTER", "CHAR", "CHARACTER_VAR", "NATIONAL_CHARACTER", 
    "NATIONAL_CHAR", "NATIONAL_CHARACTER_VAR", "NATIONAL_CHAR_VAR", "NCHAR_VAR",
    "NUMERIC", "INTEGER", "INT", "SMALLINT", "FLOAT", "DOUBLE_PRECISION", "REAL",
    "DECIMAL"];

    string query = createProcedureQuery("ANSITYPESPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createSQLDSProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["CHARACTER", "VARCHAR", "LONG VARCHAR", "DECIMAL",
    "INTEGER", "SMALLINT", "FLOAT"];

    string query = createProcedureQuery("SQLDSTYPESPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createObjectProcedure(jdbc:Client jdbcClient) returns error? {
     sql:ExecutionResult result = check jdbcClient->execute("DROP TYPE OBJECT_TYPE FORCE");
    result = check jdbcClient->execute(
        "CREATE OR REPLACE TYPE OBJECT_TYPE OID '"+ OID +"' AS OBJECT(" +
        "ATTR1 VARCHAR(20), "+
        "ATTR2 VARCHAR(20), "+
        "ATTR3 VARCHAR(20), "+
        "MAP MEMBER FUNCTION GET_ATTR1 RETURN NUMBER "+
        ") "
    );
    string[] variables = ["OBJECT_TYPE"];

    string query = createProcedureQuery("OBJECTPROC", variables);

    result = check jdbcClient -> execute(query);
}

function createREFProcedure(jdbc:Client jdbcClient) returns error? {
     sql:ExecutionResult result = check jdbcClient->execute("DROP TYPE REF_TYPE FORCE");

    result = check jdbcClient->execute(
        "CREATE OR REPLACE TYPE REF_TYPE OID '"+ OID +"' AS OBJECT(" +
        "ATTR1 VARCHAR(20), "+
        "ATTR2 VARCHAR(20)   "+
        ") "
    );
    string[] variables = ["REF_TYPE"];

    string query = createProcedureQuery("REFSPROC", variables);

    result = check jdbcClient -> execute(query);
}

function createVarrayProcedure(jdbc:Client jdbcClient) returns error? {
    sql:ExecutionResult result = check jdbcClient->execute("DROP TYPE VARRTYPE FORCE");

    result = check jdbcClient->execute(
        " CREATE OR REPLACE TYPE VARRTYPE AS VARRAY(6) OF VARCHAR(100);"
        );
    
    string[] variables = ["VARRTYPE"];

    string query = createProcedureQuery("VARRAYSPROC", variables);

    result = check jdbcClient -> execute(query);
}

function createXMLProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["XMLTYPE", "URITYPE", "DBURITYPE", "DBURITYPE", "HTTPURITYPE"];

    string query = createProcedureQuery("XMLPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

function createGeometryProcedure(jdbc:Client jdbcClient) returns error? {
    string[] variables = ["SDO_GEOMETRY", "SDO_TOPO_GEOMETRY", "SDO_GEORASTER"];

    string query = createProcedureQuery("GEOMETRYPROC", variables);

    sql:ExecutionResult result = check jdbcClient -> execute(query);
}

 #   The `printCreateProcedureResult` function prints out the result of the procedure creation
 #  +  procedurename  -   type string - name of the procedure
 #  +  err  -   type error? - error during creation
function printCreateProcedureResult(string procedurename, error? err) {
    if (err is error) {
        io:println(procedurename, " procedure creation failed! ", err);
    } else {
        io:println(procedurename, " procedure creation success! ", err);
    }
}

 #   The `createAllProcedures` function  creates all the procedure execution functions
 #  +  jdbcClient  -   type jdbc:Client - jdbc client instance
 #  +  return  -   error?
function createAllProcedures(jdbc:Client jdbcClient) returns error? {
    error? err;
    // err = createNumericProcedure(jdbcClient);
    // printCreateProcedureResult("NUMERIC", err);
    // err = createCharacterProcedure(jdbcClient);
    // printCreateProcedureResult("CHARACTER", err);
    // err = createDateTimeProcedure(jdbcClient);
    // printCreateProcedureResult("DATETIME", err);
    // err = createBLOBProcedure(jdbcClient);
    // printCreateProcedureResult("BLOB", err);
    // err = createCLOBProcedure(jdbcClient);
    // printCreateProcedureResult("CLOB", err);
    // err = createNCLOBProcedure(jdbcClient);
    // printCreateProcedureResult("NCLOB", err);
    // err = createLongProcedure(jdbcClient);
    // printCreateProcedureResult("LONG", err);
    // err = createRawProcedure(jdbcClient);
    // printCreateProcedureResult("RAW", err);
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
