import ballerina/sql;

// ---------------NUMERIC -----------------------
sql:DoubleValue NUMBER_IN = new(98765431.234324);
sql:InOutParameter NUMBER_INOUT= new(-343943.2334);
sql:DoubleOutParameter NUMBER_OUT = new();

sql:DoubleValue FLOAT_IN = new(98765431.234324);
sql:InOutParameter FLOAT_INOUT = new(-343943.2334);
sql:DoubleOutParameter FLOAT_OUT = new();

sql:DoubleValue BINARY_FLOAT_IN = new(98765431.234324);
sql:InOutParameter BINARY_FLOAT_INOUT = new(-343943.2334);
sql:DoubleOutParameter BINARY_FLOAT_OUT = new();

sql:DoubleValue BINARY_DOUBLE_IN = new(98765431.234324);
sql:InOutParameter BINARY_DOUBLE_INOUT = new(-343943.2334);
sql:DoubleOutParameter BINARY_DOUBLE_OUT = new();

// ---------------CHARACTER -----------------------
sql:VarcharValue VARCHAR2_IN = new("Hello there text");
sql:InOutParameter VARCHAR2_INOUT= new("In out text");
sql:VarcharOutParameter VARCHAR2_OUT = new();

sql:VarcharValue VARCHAR_IN = new("Hello there text");
sql:InOutParameter VARCHAR_INOUT= new("In out text");
sql:VarcharOutParameter VARCHAR_OUT = new();

sql:NVarcharValue NVARCHAR2_IN = new("Hello there text");
sql:InOutParameter NVARCHAR2_INOUT= new("In out text");
sql:NVarcharOutParameter NVARCHAR2_OUT = new();

sql:CharValue CHAR_IN = new("Hello there text");
sql:InOutParameter CHAR_INOUT= new("In out text");
sql:CharOutParameter CHAR_OUT = new();

sql:NCharValue NCHAR_IN = new("Hello there text");
sql:InOutParameter NCHAR_INOUT= new("In out text");
sql:NCharOutParameter NCHAR_OUT = new();