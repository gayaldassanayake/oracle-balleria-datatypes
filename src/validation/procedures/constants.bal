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

// -------------DATETIME----------------------------
sql:DateTimeValue DATETIME_TEMP = new("1000-01-01 09:33:45.00");
sql:TimestampValue TIMESTAMP_TEMP = new("1000-01-01 09:33:45.00");
sql:TimestampValue TIMESTAMP_TEMPTZ = new("1000-01-01 09:33:45.00");
sql:TimestampValue TIMESTAMP_TEMPTZL = new("1000-01-16 09:33:45.00");

sql:TimestampValue DATETIME_IN = new("2002-01-16 09:33:45.00");
sql:InOutParameter DATETIME_INOUT= new(DATETIME_TEMP);
sql:TimestampOutParameter DATETIME_OUT = new();

sql:TimestampValue TIMESTAMP_IN = new("2002-01-16 09:33:45.00");
sql:InOutParameter TIMESTAMP_INOUT= new(TIMESTAMP_TEMP);
sql:TimestampOutParameter TIMESTAMP_OUT = new();

sql:TimestampValue TIMESTAMPTZ_IN = new("2002-01-16 09:33:45.00");
sql:InOutParameter TIMESTAMPTZ_INOUT= new(TIMESTAMP_TEMPTZ);
sql:TimestampOutParameter TIMESTAMPTZ_OUT = new();

sql:TimestampValue TIMESTAMPTZL_IN = new("2002-01-16 09:33:45.00");
sql:InOutParameter TIMESTAMPTZL_INOUT= new(TIMESTAMP_TEMPTZL);
sql:TimestampOutParameter TIMESTAMPTZL_OUT = new();

sql:DateValue INTERVALY2M_IN = new("24-05");
sql:InOutParameter INTERVALY2M_INOUT = new("01-00");
sql:DateOutParameter INTERVALY2M_OUT = new();

sql:TimeValue INTERVALD2S_IN = new("4 5:12:10.22");
sql:InOutParameter INTERVALD2S_INOUT = new("4 5:12:10.22");
sql:TimeOutParameter INTERVALD2S_OUT = new();

// -------------BLOB----------------------------
byte[] blob=check readFileAsByte();
byte[] mediumBlob = stripArray(blob, 15000);
byte[] smallBlob = stripArray(blob, 500);

sql:BlobValue BLOB_IN = new(mediumBlob);
sql:InOutParameter BLOB_INOUT = new(smallBlob);
sql:BlobOutParameter BLOB_OUT = new();

// -------------CLOB----------------------------
string clob =check readFileAsCharacter();
string mediumClob = check 'string:fromBytes(stripArray(clob.toBytes(), 2000));

sql:ClobValue CLOB_IN = new(mediumClob);  
sql:InOutParameter CLOB_INOUT = new(mediumClob);
sql:ClobOutParameter CLOB_OUT = new();

// -------------NCLOB----------------------------

sql:NClobValue NCLOB_IN = CLOB_IN; 
sql:InOutParameter NCLOB_INOUT = CLOB_INOUT;
sql:NClobOutParameter NCLOB_OUT = new();

// -------------LONG----------------------------
sql:BlobValue LONG_IN = new(mediumBlob); 
sql:InOutParameter LONG_INOUT = new(smallBlob);
sql:BlobOutParameter LONG_OUT = new();

// -------------RAW----------------------------

sql:BlobValue RAW_IN = new(mediumBlob); 
sql:InOutParameter RAW_INOUT = new(smallBlob);
sql:BlobOutParameter RAW_OUT = new();

sql:BlobValue LONGRAW_IN = new(mediumBlob); 
sql:InOutParameter LONGRAW_INOUT = new(smallBlob);
sql:BlobOutParameter LONGRAW_OUT = new();

