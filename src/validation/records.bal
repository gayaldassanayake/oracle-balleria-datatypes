import ballerina/time;

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

type DatetimeRecord record {|
    int pk;
    time:Time col_date;
    time:Time col_timestamp_1;
    string col_timestamp_2;
    string col_timestamp_3;
    string col_interval_year_to_month;
    string col_interval_day_to_second;
|};

type LOBRecord record {|
    int pk;
    string col_long_row;
    string col_clob;
    string col_nclob;
    string col_blob;
    string col_bfile;
|};


// update with userdefined
type RowIdRecord record{|
    int pk;
    string rowid;
    string urowid;
|};


type ANSIRecord record {|
    int pk;
    string col_character;
    string col_character_var;
    string col_national_character;
    string col_national_char;
    string col_national_character_var;
    string col_national_char_var;
    string col_nchar_var;
    decimal col_numeric;
    decimal col_decimal;
    decimal col_integer;
    decimal col_int;
    decimal col_smallint;
    decimal col_float;
    decimal col_double_precision;
    decimal col_real;
|};

type SQLDSRecord record {|
    int pk;
    string col_character;
    string col_long_varchar;
|};


type Col_object record {|
    string attr1;
    string attr2;
    string attr3;
|};

type userdefinedRecord record {|
    int pk;
    Col_object col_object;
    Col_object[] col_varray;
|};

type blobRecord record {|
    int pk;
    byte[] col_blob;
|};

type clobRecord record {|
    int pk;
    string col_clob;
|};

type nclobRecord record {|
    int pk;
    string col_nclob;
|};

type rawRecord record {|
    int pk;
    byte[] col_raw;
    byte[] col_long_raw;
|};

type bfileRecord record {|
    int pk;
    byte[] col_bfile;
|};

