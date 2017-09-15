CREATE OR REPLACE PACKAGE body PARAMETER
AS
  /*
  parameter.pkb
  by Donald J. Bales on 2014-10-20
  A packge to test parameter scope
  */
  FUNCTION in_out_inout(
      aiv_in IN VARCHAR2,
      aov_out OUT VARCHAR2,
      aiov_inout IN OUT VARCHAR2)
    RETURN VARCHAR2
  IS
  BEGIN
    prin(chr(9)||'Before assignments...');
    prin(chr(9)||'Inside function in_out_inout, aiv_in = '||aiv_in);
    prin(chr(9)||'Inside function in_out_inout, aov_out = '||aov_out);
    prin(chr(9)||'Inside function in_out_inout, aiov_inout = '||aiov_inout);
    -- You can only assign a value (write) to an OUT
    -- parameter, you can't read it!
    aov_out := 'OUT';
    -- You can only read an IN parameter
    aiov_inout := aiv_in;
    -- You can read and write an IN OUT parameter
    aiov_inout := aiov_inout||'OUT';
    prin(chr(9)||'After assignments...');
    prin(chr(9)||'Inside function in_out_inout, aiv_in = '||aiv_in);
    prin(chr(9)||'Inside function in_out_inout, aov_out = '||aov_out);
    prin(chr(9)||'Inside function in_out_inout, aiov_inout = '||aiov_inout);
    RETURN 'OK'; -- a function must return a value!
  END in_out_inout;
  PROCEDURE in_out_inout(
      aiv_in IN VARCHAR2,
      aov_out OUT VARCHAR2,
      aiov_inout IN OUT VARCHAR2)
  IS
  BEGIN
    prin(chr(9)||'Before assignments...');
    prin(chr(9)||'Inside procedure in_out_inout, aiv_in = '||aiv_in);
    prin(chr(9)||'Inside procedure in_out_inout, aov_out = '||aov_out);
    prin(chr(9)||'Inside procedure in_out_inout, aiov_inout = '||aiov_inout);
    -- You can only assign a value (write) to an OUT
    -- parameter, you can't read it!
    aov_out := 'OUT';
    -- You can only read an IN parameter
    aiov_inout := aiv_in;
    -- You can read and write an IN OUT parameter
    aiov_inout := aiov_inout||'OUT';
    prin(chr(9)||'After assignments...');
    prin(chr(9)||'Inside procedure in_out_inout, aiv_in = '||aiv_in);
    prin(chr(9)||'Inside procedure in_out_inout, aov_out = '||aov_out);
    prin(chr(9)||'Inside procedure in_out_inout, aiov_inout = '||aiov_inout);
  END in_out_inout;
END PARAMETER;
/