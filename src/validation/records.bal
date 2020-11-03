type NumericRecord record {|
    int pk;
    decimal col_number;
    decimal col_float;
    float col_binary_float;
    float col_binary_double;
|};

type CharacterRecord record {|
    int pk;
    string col_varchar2;
    string col_varchar;
    string col_nvarchar2;
    string col_char;
    string col_nchar;
|};
//  "PK NUMBER GENERATED ALWAYS AS IDENTITY, "+
//         "COL_VARCHAR2  VARCHAR2(4000), " +
//         "COL_VARCHAR  VARCHAR2(4000), " +
//         "COL_NVARCHAR2 NVARCHAR2(2000), "+
//         "COL_CHAR CHAR(2000), "+
//         "COL_NCHAR NCHAR(1000), "+
//         "PRIMARY KEY(PK) "+