import ballerina/io;
import ballerina/sql;
import ballerina/java.jdbc;

public function main() {
    sql:Error| jdbc:Client jdbcClient = initializeClient();
    if(jdbcClient is jdbc:Client){
        initializeAllTables(jdbcClient);
    } else{
        io:println("Error creating jdbc client");
    }
}

function simpleQuery(jdbc:Client jdbcClient){

    stream<record{}, error> resultStream = jdbcClient->query("Select * from EMPLOYEE");

    error? e = resultStream.forEach(function (record {} result){
        io:println("Hello ", "FirstName:", result["FIRST_NAME"]);

    });
}

function typedQuery(jdbc:Client jdbcClient){
    stream<record{} | error> resultStream = jdbcClient->query("select * from Employee", Employee);
    stream<Employee, sql:Error> employeeStream = <stream<Employee, sql:Error>> resultStream;

    error? e = employeeStream.forEach(function(Employee employee) {
        io:println(employee.salary);
    });
    if (e is error) {
        io:println(e);
    } 
}

function initializeTable(jdbc:Client jdbcClient)returns sql:Error?{
    sql:ExecutionResult result = check jdbcClient->execute("BEGIN DROPTABLE('EMPLOYEE'); END;");
    result = check jdbcClient->execute("CREATE TABLE Employee(" +
        "employee_id NUMBER GENERATED ALWAYS AS IDENTITY, first_name  VARCHAR2(300)," +
        "last_name  VARCHAR2(300), email VARCHAR2(300), job_id NUMBER, SALARY FLOAT)");
    result = check jdbcClient->execute("INSERT INTO Employee (first_name," +
        "last_name, email, job_id,salary) VALUES ('Peter', " +
        "'Stuart', 'abc@gmail.com' ,1, 5000.75)");
    result = check jdbcClient->execute("INSERT INTO Employee (first_name," +
        "last_name, email, job_id,salary) VALUES ('Kamal', " +
        "'Perera', 'abc@gmail.com' ,1, 5000.85)");
}

type Employee record {|
    int employee_id;
    string first_name;
    string last_name;
    string email;
    int job_id;
    decimal salary;
|};


