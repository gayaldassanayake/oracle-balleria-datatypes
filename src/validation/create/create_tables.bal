import ballerina/sql;
import ballerina/io;
import ballerina/java.jdbc;

function initializeTableNumeric(jdbc:Client jdbcClient)returns sql:Error?{
    sql:ExecutionResult result = check jdbcClient->execute("BEGIN DROPTABLE('NUMERIC'); END;");
    result = check jdbcClient->execute("CREATE TABLE NUMERIC(" +
        "PK NUMBER GENERATED ALWAYS AS IDENTITY, "+
        "COL_NUMBER  NUMBER, " +
        "COL_FLOAT  FLOAT, " +
        "COL_LONG LONG, "+
        "COL_BINARY_FLOAT BINARY_FLOAT, "+
        "COL_BINARY_DOUBLE BINARY_DOUBLE"+
        ")"
        );
}

function initializeTableCharacter(jdbc:Client jdbcClient)returns sql:Error?{
    sql:ExecutionResult result = check jdbcClient->execute("BEGIN DROPTABLE('CHARACTER'); END;");
    result = check jdbcClient->execute("CREATE TABLE CHARACTER(" +
        "PK NUMBER GENERATED ALWAYS AS IDENTITY, "+
        "COL_VARCHAR2  VARCHAR2(4000), " +
        "COL_VARCHAR  VARCHAR2(4000), " +
        "COL_NVARCHAR2 NVARCHAR2(2000), "+
        "COL_CHAR CHAR(2000), "+
        "COL_NCHAR NCHAR(1000)"+
        ")"
        );
}

function initializeTableDateTime(jdbc:Client jdbcClient)returns sql:Error?{
    sql:ExecutionResult result = check jdbcClient->execute("BEGIN DROPTABLE('DATETIME'); END;");
    result = check jdbcClient->execute("CREATE TABLE DATETIME(" +
        "PK NUMBER GENERATED ALWAYS AS IDENTITY, "+
        "COL_DATE  DATE, " +
        "COL_TIMESTAMP_1  TIMESTAMP (9), " +
        "COL_TIMESTAMP_2  TIMESTAMP (9) WITH TIME ZONE, " +
        "COL_TIMESTAMP_3  TIMESTAMP (9) WITH LOCAL TIME ZONE, " +
        "COL_INTERVAL_YEAR_TO_MONTH INTERVAL YEAR TO MONTH, "+
        "COL_INTERVAL_DAY_TO_SECOND INTERVAL DAY(9) TO SECOND(9) "+
        ")"
        );
}

function initializeTableLOB(jdbc:Client jdbcClient)returns sql:Error?{
    sql:ExecutionResult result = check jdbcClient->execute("BEGIN DROPTABLE('LOB'); END;");
    result = check jdbcClient->execute("CREATE TABLE LOB(" +
        "PK NUMBER GENERATED ALWAYS AS IDENTITY, "+
        "COL_RAW  RAW(2000), " +
        "COL_LONG_RAW  LONG RAW, " +
        "CLOB  CLOB, " +
        "NCLOB  NCLOB, " +
        "BLOB BLOB, " +
        "BFILE  BFILE " +
        ")"
        );
}

function initializeTableANSITypes(jdbc:Client jdbcClient)returns sql:Error?{
    sql:ExecutionResult result = check jdbcClient->execute("BEGIN DROPTABLE('ANSITYPES'); END;");
    result = check jdbcClient->execute("CREATE TABLE ANSITYPES(" +
        "PK NUMBER GENERATED ALWAYS AS IDENTITY, "+
        "COL_CHARACTER  CHARACTER(256), " +
        "COL_CHARACTER_VAR  CHARACTER VARYING(256), " +

        "COL_NATIONAL_CHARACTER  NATIONAL CHARACTER(256), " +
        "COL_NATIONAL_CHAR  NATIONAL CHAR(256), " +

        "COL_NATIONAL_CHARACTER_VAR  NATIONAL CHARACTER VARYING(256), " +
        "COL_NATIONAL_CHAR_VAR  NATIONAL CHAR VARYING(256), " +
        "COL_NCHAR_VAR  NCHAR VARYING(256), " +

        "COL_NUMERIC  NUMERIC, " +
        "COL_DECIMAL  DECIMAL, " +

        "COL_INTEGER  INTEGER, " +
        "COL_INT  INT, " +
        "COL_SMALLINT  SMALLINT, " +

        "COL_FLOAT  FLOAT, " +
        "COL_DOUBLE_PRECISION  DOUBLE PRECISION, " +
        "COL_REAL  REAL " +

        ")"
        );
}

function initializeTableSQLDSTypes(jdbc:Client jdbcClient)returns sql:Error?{
    sql:ExecutionResult result = check jdbcClient->execute("BEGIN DROPTABLE('SQLDS'); END;");
    result = check jdbcClient->execute("CREATE TABLE SQLDS(" +
        "PK NUMBER GENERATED ALWAYS AS IDENTITY, "+
        "COL_CHARACTER  CHARACTER(255), " +
        "COL_LONG_VARCHAR  LONG VARCHAR " +
        ")"
        );
}


function printTableCreationResult(string tablename, sql:Error? err){
    if (err is sql:Error) {
            io:println(tablename, " table initialization failed! ", err);
        } else {
            io:println(tablename, " table initialization success! ", err);
        }
}

function initializeAllTables(jdbc:Client jdbcClient){
    sql:Error? err;

    err = initializeTableCharacter(jdbcClient);
    printTableCreationResult("Character", err);

    err = initializeTableNumeric(jdbcClient);
    printTableCreationResult("Numeric", err);

    err = initializeTableDateTime(jdbcClient);
    printTableCreationResult("DateTime", err);
        
    err = initializeTableLOB(jdbcClient);
    printTableCreationResult("LOB", err);

    err = initializeTableANSITypes(jdbcClient);
    printTableCreationResult("ANSITYPES", err);

    err = initializeTableSQLDSTypes(jdbcClient);
    printTableCreationResult("SQLDSTYPES", err);
}

// type NumericEnum record {|
//     int employee_id;
//     string first_name;
//     string last_name;
//     string email;
//     int job_id;
//     decimal salary;
// |};

// type CharacterEnum record {|
//     int pk;

// |};

