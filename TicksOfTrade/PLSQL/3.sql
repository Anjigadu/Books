00800 1301 1301
 

CREATE OR REPLACE PACKAGE worker
AS
  -- Return the next ID sequence value
  FUNCTION get_id
    RETURN emp.empno%TYPE;
END worker;
/
CREATE OR REPLACE PACKAGE BODY worker
AS
  -- FUNCTIONS
  FUNCTION get_id
    RETURN emp.empno%TYPE
  IS
    n_id emp.empno%TYPE;
  BEGIN
    SELECT emp_empno_sequence.nextval INTO n_id FROM SYS.DUAL;
    RETURN n_id;
  END get_id;
END worker;
/
