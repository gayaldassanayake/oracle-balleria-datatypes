import ballerina/java.jdbc;
import ballerina/io;
import ballerina/sql;

function numericSelect(jdbc:Client jdbcClient){
    stream<record{} | error> resultStream = jdbcClient->query("select * from NUMERIC", NumericRecord);
    stream<NumericRecord, sql:Error> numericStream = <stream<NumericRecord, sql:Error>> resultStream;

    error? e = numericStream.forEach(function(NumericRecord numeric) {
        io:println(numeric.col_float);
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

function selectFromAllTables(jdbc:Client jdbcClient){
    numericSelect(jdbcClient);
    characterSelect(jdbcClient);
}