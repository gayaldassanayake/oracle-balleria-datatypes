import ballerina/java.jdbc;
import ballerina/io;
import ballerina/sql;

function numericSelect(jdbc:Client jdbcClient){
    stream<record{} | error> resultStream = jdbcClient->query("select * from NUMERIC", NumericRecord);
    stream<NumericRecord, sql:Error> numericStream = <stream<NumericRecord, sql:Error>> resultStream;

    error? e = numericStream.forEach(function(NumericRecord numeric) {
        io:println(numeric.col_number);
        io:println(numeric.col_float);
        io:println(numeric.col_binary_float);
        io:println(numeric.col_binary_double);
    });
    if (e is error) {
        io:println(e);
    } 
}

function characterSelect(jdbc:Client jdbcClient){
    stream<record{} | error> resultStream = jdbcClient->query("select * from CHARACTER", CharacterRecord);
    stream<CharacterRecord, sql:Error> characterStream = <stream<CharacterRecord, sql:Error>> resultStream;
    error? e = characterStream.forEach(function(CharacterRecord character) {
        io:println(character.col_varchar2);
        io:println(character.col_varchar);
        io:println(character.col_nvarchar2);
        io:println(character.col_char);
        io:println(character.col_nchar);
    });
    if (e is error) {
        io:println(e);
    } 
}

function datetimeSelect(jdbc:Client jdbcClient){
    stream<record{} | error> resultStream = jdbcClient->query("select * from DATETIME", DatetimeRecord);
    stream<DatetimeRecord, sql:Error> datetimeStream = <stream<DatetimeRecord, sql:Error>> resultStream;
    string timeFormat = "yyyy-MM-dd HH:mm:ss.SSZ";
//   time:Time|time:Error time = ;
    error? e = datetimeStream.forEach(function(DatetimeRecord datetime) {
        io:println(datetime.col_date);
        io:println(datetime.col_timestamp_1);
        io:println(datetime.col_timestamp_2);
        io:println(datetime.col_timestamp_3);
        io:println(datetime.col_interval_year_to_month);
        io:println(datetime.col_interval_day_to_second);
    });
    if (e is error) {
        io:println(e);
    } 
}

function LOBSelect(jdbc:Client jdbcClient){
    stream<record{} | error> resultStream = jdbcClient->query("select * from DATETIME", LOBRecord);
    stream<LOBRecord, sql:Error> lobStream = <stream<LOBRecord, sql:Error>> resultStream;
    error? e = lobStream.forEach(function(LOBRecord lob) {
        io:println(lob.col_long_row);
        io:println(lob.col_clob);
        io:println(lob.col_nclob);
        io:println(lob.col_blob);
        io:println(lob.col_bfile);
    });
    if (e is error) {
        io:println(e);
    } 
}

// update with user defined types later
function rowIdSelect(jdbc:Client jdbcClient){
    stream<record{}, error> resultStream = jdbcClient->query("Select pk, ROWID from NUMERIC");

    error? e = resultStream.forEach(function (record {} result){
        io:println(result);

    });

    if(e is error){
        io:println(e);
    }
}

function ansiSelect(jdbc:Client jdbcClient){
    stream<record{} | error> resultStream = jdbcClient->query("select * from ANSITYPES", ANSIRecord);
    stream<ANSIRecord, sql:Error> ansiStream = <stream<ANSIRecord, sql:Error>> resultStream;
    error? e = ansiStream.forEach(function(ANSIRecord ansi) {
        io:println(ansi.col_character);
        io:println(ansi.col_character_var);
        io:println(ansi.col_national_character);
        io:println(ansi.col_national_char);

        io:println(ansi.col_national_character_var);
        io:println(ansi.col_national_char_var);
        io:println(ansi.col_nchar_var);
        io:println(ansi.col_numeric);

        io:println(ansi.col_decimal);
        io:println(ansi.col_integer);
        io:println(ansi.col_int);
        io:println(ansi.col_smallint);

        io:println(ansi.col_float);
        io:println(ansi.col_double_precision);
        io:println(ansi.col_real);
    });
    if (e is error) {
        io:println(e);
    } 
}

function sqldsSelect(jdbc:Client jdbcClient){
    stream<record{} | error> resultStream = jdbcClient->query("select * from SQLDS", SQLDSRecord);
    stream<SQLDSRecord, sql:Error> sqldsStream = <stream<SQLDSRecord, sql:Error>> resultStream;
    error? e = sqldsStream.forEach(function(SQLDSRecord sqlds) {
        io:println(sqlds.col_character);
        io:println(sqlds.col_long_varchar);
    });
    if (e is error) {
        io:println(e);
    } 
}

function userdefinedSelect(jdbc:Client jdbcClient){

    
    // stream<record{}, error> resultStream = jdbcClient->query("select * from USERDEFINED");   
    // io:println(resultStream);
    // error? e = resultStream.forEach(function (record {} result){
    //     // io:println(result);
    // }); 
    // stream<record{} | error> resultStream = jdbcClient->query("select * from USERDEFINED", userdefinedRecord);
    // stream<userdefinedRecord, sql:Error> userdefinedStream = <stream<userdefinedRecord, sql:Error>> resultStream;
    // error? e = userdefinedStream.forEach(function(userdefinedRecord usrdef) {
    //     io:println(usrdef.col_object.attr1);
    //     // io:println(usrdef.col_varray);
    //     // usrdef.col_varray = forEach(function(Col_object obj){

        // })
    // });
    // if (e is error) {
    //     io:println(e);
    // } 
}

function blobSelect(jdbc:Client jdbcClient){
    stream<record{} | error> resultStream = jdbcClient->query("select * from BLOB", blobRecord);
    stream<blobRecord, sql:Error> blobStream = <stream<blobRecord, sql:Error>> resultStream;
    error? e = blobStream.forEach(function(blobRecord blobr) {
        io:println(stripArray(blobr.col_blob, 20));
    });
    if (e is error) {
        io:println(e);
    } 
}

function clobSelect(jdbc:Client jdbcClient){
    stream<record{} | error> resultStream = jdbcClient->query("select * from CLOB", clobRecord);
    stream<clobRecord, sql:Error> clobStream = <stream<clobRecord, sql:Error>> resultStream;
    error? e = clobStream.forEach(function(clobRecord clobr) {
        io:println(clobr.length());
    });
    if (e is error) {
        io:println(e);
    } 
}

function nclobSelect(jdbc:Client jdbcClient){
    stream<record{} | error> resultStream = jdbcClient->query("select * from NCLOB", nclobRecord);
    stream<nclobRecord, sql:Error> nclobStream = <stream<nclobRecord, sql:Error>> resultStream;
    error? e = nclobStream.forEach(function(nclobRecord nclobr) {
        io:println(nclobr.length());
    });
    if (e is error) {
        io:println(e);
    } 
}

function rawSelect(jdbc:Client jdbcClient){
    stream<record{} | error> resultStream = jdbcClient->query("select * from RAWT", rawRecord);
    stream<rawRecord, sql:Error> rawStream = <stream<rawRecord, sql:Error>> resultStream;
    error? e = rawStream.forEach(function(rawRecord rawr) {
        io:println(stripArray(rawr.col_long_raw, 20));
        io:println(rawr.col_raw);
    });
    if (e is error) {
        io:println(e);
    } 
}

function bfileSelect(jdbc:Client jdbcClient){
    // stream<record{} | error> resultStream = jdbcClient->query("select * from BFILE", bfileRecord);
    // stream<bfileRecord, sql:Error> bfileSttream = <stream<bfileRecord, sql:Error>> resultStream;
    // error? e = bfileSttream.forEach(function(bfileRecord bfiler) {
    //     io:println(stripArray(bfiler.col_bfile, 20));
    // });
    // if (e is error) {
    //     io:println(e);
    // }

    stream<record{}, error> resultStream = jdbcClient->query("Select * from BFILE");

    error? e = resultStream.forEach(function (record {} result){
        io:println(result["COL_BFILE"]);
    });
     if (e is error) {
        io:println(e);
    }
}

function anytypeSelect(jdbc:Client jdbcClient){

    stream<record{} , error> resultStream = jdbcClient->query(
        "SELECT PK, "+
       "SYS.ANYDATA.getTypeName(COL_ANYDATA1) AS type_name1 , SYS.ANYDATA.getTypeName(COL_ANYDATA2) AS type_name2, "+
       "SYS.ANYDATA.getTypeName(COL_ANYDATA3) AS type_name3 "+
        "FROM ANYTYPES ORDER BY PK");

    

    error? e = resultStream.forEach(function (record {} result){
        io:println(result);
    });

     if (e is error) {
        io:println(e);
    }
}

function selectFromAllTables(jdbc:Client jdbcClient){
    // numericSelect(jdbcClient);
    // characterSelect(jdbcClient);
    // datetimeSelect(jdbcClient);
    // rowIdSelect(jdbcClient);
    // ansiSelect(jdbcClient);
    // sqldsSelect(jdbcClient);
    // // userdefinedSelect(jdbcClient);
    // blobSelect(jdbcClient);
    // clobSelect(jdbcClient);
    // nclobSelect(jdbcClient);
    // rawSelect(jdbcClient);
    // bfileSelect(jdbcClient);
    anytypeSelect(jdbcClient);
}

//lob
//long
//rowid
//userdefined
//anytype
//xml
//geometry