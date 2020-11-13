import ballerina/java.jdbc;
import ballerina/io;
import ballerina/time;
import ballerina/sql;

function numericInsert(jdbc:Client jdbcClient) returns sql:Error?{
    decimal number = 2343425454.6;
    decimal 'float = 343; 
    decimal binary_float = 343;
    decimal binary_double = 343;

    sql:ParameterizedQuery insertQuery = 
             `INSERT INTO NUMERIC(COL_NUMBER, COL_FLOAT, COL_BINARY_FLOAT, COL_BINARY_DOUBLE) VALUES (${number}, ${'float}, ${binary_float}, ${binary_double})`;
     sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);
}

function characterInsert(jdbc:Client jdbcClient) returns sql:Error?{
    string varchar2 = "Hello, world!";
    string varchar = "Hello, world!";
    string nvarchar2 = "Hello, world!";
    string char = "Hello, world!";
    string nchar = "Hello, world!";    

    sql:ParameterizedQuery insertQuery = 
             `INSERT INTO CHARACTER(COL_VARCHAR2, COL_VARCHAR, COL_NVARCHAR2, COL_CHAR, COL_NCHAR) VALUES (${varchar2}, ${varchar}, ${nvarchar2}, ${char}, ${nchar})`;
     sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);
}

function datetimeInsert(jdbc:Client jdbcClient) returns error?{

     time:Time|error timeCreated = time:createTime(2017, 3, 28, 23, 42, 45,
        554, "America/Panama");

    if(timeCreated is time:Time){
        string date = "05-JAN-2020 10:35:10 AM";
        string timestamp1 = "05-JAN-2020 10:35:10 AM";
        string timestamp2 = "05-JAN-2020 10:35:10 AM +05:30";
        string timestamp3 = "05-JAN-2020 10:35:10 AM";
        string interval_year_to_month = "14-2";
        string interval_day_to_second = "4 5:12:10.22";

        sql:ParameterizedQuery insertQuery = 
            `INSERT INTO DATETIME(COL_DATE) 
            VALUES (${date})`;
        sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);
    }
}

function ANSIInsert(jdbc:Client jdbcClient) returns error?{
    string character = "Hello, world!";
    string char = "Hello, world!";
    string charactervar = "Hello, world!";
    string nationalchar = "Hello, world!";
    string nationalcharactervar = "Hello, world!";
    string nationalcharVar = "Hello, world!";
    string ncharvar = "Hello, world!";

    decimal numeric = 1234134;
    decimal integer = 1234134;
    decimal 'int = 1234134;
    decimal smallint = 1234134;
    decimal 'float = 1234134;
    decimal doubleprecision = 1234134;
    decimal real = 1234134;
    decimal 'decimal = 1234134;
  
    sql:ParameterizedQuery insertQuery = 
             `INSERT INTO ANSITYPES(COL_CHARACTER, COL_CHARACTER_VAR, COL_NATIONAL_CHARACTER, COL_NATIONAL_CHAR, COL_NATIONAL_CHARACTER_VAR, 
             COL_NATIONAL_CHAR_VAR, COL_NCHAR_VAR, COL_NUMERIC, COL_DECIMAL, COL_INTEGER, COL_INT, COL_SMALLINT, COL_FLOAT, COL_DOUBLE_PRECISION, COL_REAL) 
             VALUES (${character}, ${char}, ${charactervar}, ${nationalchar}, ${nationalcharactervar}, ${nationalcharVar}, ${nationalcharVar},
             ${numeric}, ${integer}, ${'int}, ${smallint}, ${'float}, ${doubleprecision}, ${real}, ${'decimal})`;
     sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);


}

function SQLDSInsert(jdbc:Client jdbcClient) returns error?{
    string character = "Hello, world!";
    string long_varchar = "Hello, world!";
    
  
    sql:ParameterizedQuery insertQuery = 
             `INSERT INTO SQLDS(COL_CHARACTER, COL_LONG_VARCHAR) VALUES (${character}, ${long_varchar})`;
     sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);
}

function varrayInsert(jdbc:Client jdbcClient) returns sql:Error?{
    string[] col_vvcarr = ["Hello", "World"];
    int[] col_numarr = [3,4,5];
    sql:ArrayValue intarr = new(col_vvcarr);
    sql:ArrayValue stringarr = new(col_numarr);
    sql:ParameterizedQuery insertQuery = 
             `insert into varraytable( COL_NUMARR)
                values(${intarr})`;
    sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);
   
}

function userdefinedInsert(jdbc:Client jdbcClient) returns sql:Error?{
    string attr1 = "Hello1";
    string attr2 = "Hello2";
    string attr3 = "Hello3";

    sql:ParameterizedQuery insertQuery = `INSERT INTO USERDEFINED(COL_OBJECT) VALUES(OBJECT_TYPE(${attr1}, ${attr2}, ${attr3}))`;
    sql:ExecutionResult result = check jdbcClient->execute(insertQuery);
}

function blobInsert (jdbc:Client jdbcClient)returns sql:Error?{
    error|byte[] blob=readFileAsByte();

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

function anytypeInsert (jdbc:Client jdbcClient) returns error?  {
    string stringparam = "This is some data";
    int intparam = 12324354354;
    string date = "9-SEP-2020";

    sql:ParameterizedQuery insertQuery = 
             `INSERT INTO ANYTYPES (COL_ANYDATA1, COL_ANYDATA2, COL_ANYDATA3) VALUES (
    SYS.ANYDATA.convertVarchar2(${stringparam}), 
    SYS.ANYDATA.convertNumber(${intparam}), 
    SYS.ANYDATA.convertDate(TO_DATE(${date},'DD-MON-YYYY')),
    )`;
    
    sql:ExecutionResult result = check jdbcClient->execute(insertQuery);

    io:println(result);
}

function xmltypeInsert(jdbc:Client jdbcClient) returns sql:Error?  {
    string xmlparam = "<Warehouse whNo= '100'> <Building>Owned</Building> </Warehouse>";
    string httpuriparam = "https://ballerina.io/swan-lake/learn/by-example/xml-access.html";
    string xdburiparam = "/home/oe/doc1.xml#/orders/order_item";
    string dburiparam = "/oradb/ORACLE/XMLTYPES/ROW[PK=2]/COL_XMLTYPE";

    sql:ParameterizedQuery insertQuery = `INSERT INTO XMLTYPES(COL_XMLTYPE, COL_HTTPURITYPE, COL_XDBURITYPE, COL_DBURITYPE, COL_URI_TYPE) 
        VALUES (XMLTYPE(${xmlparam}), HTTPURITYPE(${httpuriparam}), XDBURITYPE(${xdburiparam}), DBURITYPE(${dburiparam}), UriFactory.getUri(${dburiparam}))`;
    sql:ExecutionResult result = check jdbcClient->execute(insertQuery);

    io:println(result);
}

function GeometryInsert(jdbc:Client jdbcClient) returns error?{
    int sgo_gtype = 2003;
    string sdo_srid = "NULL";
    string sdo_point = "NULL";
    string elem_arr = "1,1003,1";
    string ordinate_arr = "3,3, 6,3, 6,5, 4,5, 3,3";

    //     INSERT INTO GEOMETRYTYPES(COL_SDO_GEOMETRY) VALUES(
    //          SDO_GEOMETRY(
    //              2001, 8307, 
    //      SDO_POINT_TYPE (-71.4242,42.3826,NULL), NULL, NULL)
    // )
  
    // sql:ParameterizedQuery insertQuery = 
    //          `INSERT INTO GEOMETRYTYPES(COL_SDO_GEOMETRY) VALUES(
    //     SDO_GEOMETRY(
    //         ${sgo_gtype},
    //         ${sdo_srid},
    //         ${sdo_point},
    //         SDO_ELEM_INFO_ARRAY(${elem_arr}), 
    //         SDO_ORDINATE_ARRAY(${ordinate_arr})
    //     )
    // )`;

    int tg_type = 3;
    int tg_id = 1;
    int tg_layer_id = 1;
    int topology_id = 1;

    //     INSERT INTO GEOMETRYTYPES(COL_SDO_TOPO_GEOMETRY) VALUES (
    //   SDO_TOPO_GEOMETRY(
    //     3, -- Topology geometry type (polygon/multipolygon)
    //     1, -- TG_LAYER_ID for this topology (from ALL_SDO_TOPO_METADATA)
    //     SDO_TOPO_OBJECT_ARRAY (
    //       SDO_TOPO_OBJECT (3, 3), -- face_id = 3
    //       SDO_TOPO_OBJECT (6, 3))) -- face_id = 6
    // );

    // sql:ParameterizedQuery insertQuery = 
    //          `INSERT INTO GEOMETRYTYPES(COL_SDO_TOPO_GEOMETRY) VALUES(
    //     SDO_GEOMETRY(
    //         ${tg_type},
    //         ${tg_id},
    //         ${tg_layer_id},
    //         ${topology_id}
    //     )
    // )`;
    //  sql:ExecutionResult| sql:Error result = check jdbcClient->execute(insertQuery);
}


function nestedTableInsert(jdbc:Client jdbcClient)returns error?{
    int areaid = 1;
    string area = "Europe";
    country[] countries = [
        {    country_id:"IT",
            country_name:"Italy",
            locations:[
           { 
               location_id : 1000,
                street_address: "1297 Via Cola di Rie",   
                postal_code:"00989",      
                city:"Roma",             
                state_province:""
            }
            ]
        },
        {    country_id:"UK",
            country_name:"United Kingdom",
            locations:[
           { 
               location_id : 2400,
                street_address: "8204 Arthur St",   
                postal_code:"",      
                city:"London",             
                state_province:"London"
            },
            { 
               location_id : 2500,
                street_address: "Magdalen Centre, The Oxford Science Park",   
                postal_code:"OX9 9ZB",      
                city:"Oxford",             
                state_province:"Oxford"
            }
            ]
        }
    ];

    sql:ParameterizedQuery insertQuery = `INSERT INTO NESTEDTABLE 
        VALUES(${areaid}, ${area}, nt_country_typ( 
            country_typ( ${countries[0].country_id}, ${countries[0].country_name}, nt_location_typ (
                location_typ(${countries[0].locations[0].location_id}, ${countries[0].locations[0].street_address}, ${countries[0].locations[0].postal_code}, ${countries[0].locations[0].city}, ${countries[0].locations[0].state_province})
                )
            )
        )
    )`;

    sql:ExecutionResult result = check jdbcClient->execute(insertQuery);
}



# The `printDataInsertResult` function that prints out the result of the data insertion
# + tablename - type string - name of the table
# + err - type error? - error during execution
function printDataInsertResult(string tablename, error? err){
    if (err is error) {
            io:println(tablename, " data insertion failed! ", err);
    } else {
        io:println(tablename, " data insertion success! ", err);
    }
}

# The `insertToAllTables` function that calls all the data insertion functions
# + jdbcClient - type jdbc:Client - jdbc client instance
function insertToAllTables(jdbc:Client jdbcClient){
    error? err;

    err = numericInsert(jdbcClient);
    printDataInsertResult("NUMERIC", err);
    
    err = characterInsert(jdbcClient);
    printDataInsertResult("CHARACTER", err);

    err = datetimeInsert(jdbcClient);
    printDataInsertResult("DATETIME", err);

    err = ANSIInsert(jdbcClient);
    printDataInsertResult("ANSI", err);

    err = SQLDSInsert(jdbcClient);
    printDataInsertResult("SQLDS", err);

    err = GeometryInsert(jdbcClient);
    printDataInsertResult("GEOMETRY", err);

    err = userdefinedInsert(jdbcClient);
    printDataInsertResult("USERDEFINED", err);

    err = blobInsert(jdbcClient);
    printDataInsertResult("BLOB", err);

    err = clobInsert(jdbcClient);
    printDataInsertResult("CLOB", err);

    err = nclobInsert(jdbcClient);
    printDataInsertResult("NCLOB", err);

    err = rawInsert(jdbcClient);
    printDataInsertResult("RAW", err);

    err = bfileInsert(jdbcClient);
    printDataInsertResult("BFILE", err);

     err = longInsert(jdbcClient);
    printDataInsertResult("LONGTYPE", err);
    
    err = anytypeInsert(jdbcClient);
    printDataInsertResult("ANYTYPE", err);

    err = xmltypeInsert(jdbcClient);
    printDataInsertResult("XMLTYPES", err);

    err = varrayInsert(jdbcClient);
    printDataInsertResult("VARRAY", err);

    err = nestedTableInsert(jdbcClient);
    printDataInsertResult("NESTEDTABLE", err);

    
    
}