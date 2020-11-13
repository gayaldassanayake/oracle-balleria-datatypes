import ballerina/io;
import ballerina/sql;
import ballerina/java.jdbc;

# `main` is the Driver function of the project
#
public function main() {
    sql:Error| jdbc:Client jdbcClient = initializeClient();
    if(jdbcClient is jdbc:Client){  
        error? e;

        // uncomment to create tables with different data type categories
        // initializeAllTables(jdbcClient);

        // uncomment to insert data into all tables
        // insertToAllTables(jdbcClient);

        // uncomment to select data from tables
        // selectFromAllTables(jdbcClient);
        
        // uncomment to create all procedures
        e = createAllProcedures(jdbcClient);

        // uncomment to execure all procedures
        e = executeAllProcedures(jdbcClient);

        e = closeClient(jdbcClient);

        if(e is error){
            io:println(e);
        }

    } else{
        io:println("Error creating jdbc client");
    }
}
