import ballerina/java.jdbc;
import ballerina/io;
import ballerina/sql;

function userdefinedInsert(jdbc:Client jdbcClient) returns sql:Error?{
    sql:ExecutionResult result = check jdbcClient->execute("INSERT INTO USERDEFINED(COL_OBJECT, COL_VARRAY) VALUES("+
        "OBJECT_TYPE('Hello', 'Hello', 'Hello'),"+
        "VARRAY_TYPE(OBJECT_TYPE('Hello11', 'Hello12', 'Hello13'), OBJECT_TYPE('Hello21', 'Hello22', 'Hello23'), OBJECT_TYPE('Hello31', 'Hello32', 'Hello33'))"+
    ")");
}

function blobInsert (jdbc:Client jdbcClient)returns sql:Error?{
    error|byte[] blob=readFileAsByte();
    // string raw = "Hello world";

    if(blob is byte[]){
                 sql:ParameterizedQuery insertQuery = 
             `INSERT INTO BLOB(COL_BLOB) VALUES (${blob})`;
    
        sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);
    } else {
            io:println(blob);        
    }
}

function clobInsert (jdbc:Client jdbcClient)returns sql:Error?{
    string|error clob = readFileAsCharacter();

    if(clob is string){
         sql:ParameterizedQuery insertQuery = 
             `INSERT INTO CLOB(COL_CLOB) VALUES (${clob})`;
    
        sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);
    } else {
        io:println(clob);
    }
}

function nclobInsert (jdbc:Client jdbcClient)returns sql:Error?{
    string|error nclob = readFileAsCharacter();

    if(nclob is string){
         sql:ParameterizedQuery insertQuery = 
             `INSERT INTO NCLOB(COL_NCLOB) VALUES (${nclob})`;
    
        sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);
    } else {
        io:println(nclob);
    }
}

function rawInsert (jdbc:Client jdbcClient)returns sql:Error?{
    error|byte[] blob=readFileAsByte();

    if(blob is byte[]){
        byte[] raw = stripArray(blob, 10);

         sql:ParameterizedQuery insertQuery = 
             `INSERT INTO RAWT(COL_RAW, COL_LONG_RAW) 
             VALUES (${raw}, ${blob})`;
    
        sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);
    } else {
        io:println(blob);
    }
}


function bfileInsert (jdbc:Client jdbcClient)returns sql:Error?{
    string filepath = "src/validation/resources/";
        sql:ParameterizedQuery insertQuery = 
            `INSERT INTO BFILE(COL_BFILE) 
            VALUES (bfilename(${filepath}, 'bigfile.txt'))`;

    sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);
}

function longInsert (jdbc:Client jdbcClient) returns sql:Error?  {
    string|error long = readFileAsCharacter();

    if(long is string){
         sql:ParameterizedQuery insertQuery = 
             `INSERT INTO LONGTYPE(COL_LONG) 
             VALUES (${long})`;
    
        sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);
        
    } else {
        io:println(long);
    }
}

function anytypeInsert (jdbc:Client jdbcClient) returns sql:Error?  {
    
    sql:ExecutionResult result = check jdbcClient->execute(
    "INSERT INTO ANYTYPES (COL_ANYDATA1, COL_ANYDATA2, COL_ANYDATA3) VALUES ("+
    "SYS.ANYDATA.convertVarchar2('This is some data'), "+
    "SYS.ANYDATA.convertNumber(1234567890), "+
    "SYS.ANYDATA.convertDate(TO_DATE('01-JAN-2012','DD-MON-YYYY'))"+
    ")");

    io:println(result);
}

function xmltypeInsert(jdbc:Client jdbcClient) returns sql:Error?  {
    string param = "<Warehouse whNo=\"100\"> <Building>Owned</Building> </Warehouse>";

    sql:ParameterizedQuery insertQuery = `INSERT INTO XMLTYPES(COL_XMLTYPE) VALUES (XMLTYPE(${param}))`;
    sql:ExecutionResult result = check jdbcClient->execute(insertQuery);

    io:println(result);
}

function printDataInsertResult(string tablename, sql:Error? err){
    if (err is sql:Error) {
            io:println(tablename, " data insertion failed! ", err);
    } else {
        io:println(tablename, " data insertion success! ", err);
    }
}



//  "PK NUMBER GENERATED ALWAYS AS IDENTITY, "+
//         "COL_OBJECT OBJECT_TYPE, " +
//         "COL_VARRAY VARRAY_TYPE, " +
//         "PRIMARY KEY(PK) "+
//         ")"

function insertToAllTables(jdbc:Client jdbcClient){
    sql:Error? err;

    // err = userdefinedInsert(jdbcClient);
    // printDataInsertResult("USERDEFINED", err);

    // err = blobInsert(jdbcClient);
    // printDataInsertResult("BLOB", err);

    // err = clobInsert(jdbcClient);
    // printDataInsertResult("CLOB", err);

    // err = nclobInsert(jdbcClient);
    // printDataInsertResult("NCLOB", err);

    // err = rawInsert(jdbcClient);
    // printDataInsertResult("RAW", err);

    // err = bfileInsert(jdbcClient);
    // printDataInsertResult("BFILE", err);

    //  err = longInsert(jdbcClient);
    // printDataInsertResult("LONGTYPE", err);
    
    // err = anytypeInsert(jdbcClient);
    // printDataInsertResult("ANYTYPE", err);

    err = xmltypeInsert(jdbcClient);
    printDataInsertResult("XMLTYPES", err);
    
}