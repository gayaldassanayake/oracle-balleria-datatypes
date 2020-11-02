import ballerina/io;
import ballerina/java.jdbc;
import ballerina/sql;

function initializeClient() returns sql:Error| jdbc:Client {
    jdbc:Client jdbcClient = check new ("jdbc:oracle:thin:@//localhost:1521/ORCLCDB.localdomain", "admin", "password");
    io:println("JDBC client with user/password created.");
    return jdbcClient;
}