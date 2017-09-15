CREATE OR REPLACE TRIGGER abcdTrigger 
BEFORE INSERT ON          abcd
FOR EACH ROW

BEGIN
 if upper(:new.name) = 'Jonathan dfdfdf' then
   raise_application_error(600, "there is an error ");
 end if;
END;
/
 
 
 
SELECT * FROM emp ORDER BY EMPNO; 

DECLARE
/**
Hi Hello How are you?
**/
BEGIN
-- You write your executable code here
  NULL;
EXCEPTION
  when NO_DATA_FOUND then
    RAISE_APPLICATION_ERROR(-20000, 'Chummaaaa...heee...');
END;
/


SET SERVEROUTPUT ON SIZE 1000000;
BEGIN
  SYS.DBMS_OUTPUT.put_line('Hello Raj!');
EXCEPTION  
  when NO_DATA_FOUND then
   RAISE_APPLICATION_ERROR(-12000, 'Hi.....');
END;
/


set serveroutput on size 1000000
begin
SYS.DBMS_OUTPUT.put_line('Hi there genius!');
end;
/


set serveroutput on size 1000000
begin
  SYS.DBMS_OUTPUT.put_line('Hello Raj!');
end;
/

nValue := to_Number('23232');

SELECT to_Number('0x2') from dual;

CREATE OR REPLACE FUNCTION to_Number_or_Null( alphaNum IN VARCHAR2) 
  RETURN NUMBER IS
  /**
   This is an errorless to_Number
  **/
  BEGIN
      DBMS_OUTPUT.PUT_LINE('Inside inner block.');
      --RETURN TO_NUMBER('100.00', '9G999D99');
      RETURN TO_NUMBER(alphaNum);
      DBMS_OUTPUT.PUT_LINE('Unreachable statement.');
      EXCEPTION
       when OTHERS then
        RETURN NULL;
 END to_Number_or_Null;
 /
 
SELECT to_Number_or_Null('10000') from dual;

SELECT TO_DATE('26/01/1975', 'DD/MM/YYYY') FROM DUAL;

CREATE OR REPLACE FUNCTION to_Date_or_Null(dateStr IN VARCHAR2) 
RETURN string IS
/**
If I recieve dataStr as 26/01/1975, I would return 26-Jan-1975
**/
BEGIN
    DBMS_OUTPUT.PUT_LINE('Inside inner block.');
    RETURN TO_DATE(dateStr, 'dd/mm/yyyy');
    EXCEPTION
      WHEN OTHERS THEN
        --RAISE_APPLICATION_ERROR(-20000, 'Account past due.');
        RETURN NULL;
  END to_Date_or_Null;
/  

SELECT to_Date_or_Null('26/01/1975') FROM dual;

--Unit testing for to_Date_or_Null
BEGIN
  SYS.DBMS_OUTPUT.PUT_LINE(to_Date_or_Null('26/01/1975'));
  SYS.DBMS_OUTPUT.PUT_LINE(to_Date_or_Null('29/10/2001'));
END;  
/

CREATE OR REPLACE PROCEDURE prin(content1 IN VARCHAR2) IS
BEGIN
  SYS.DBMS_OUTPUT.PUT_LINE(content1);
END ;
/

-- Unit test prin procedure
DECLARE
 testSpaceLine VARCHAR2(100);
BEGIN
  -- init the testSpaceLine
  for i in 1..99 loop
    testSpaceLine := testSpaceLine || ' ';
  end loop;
  prin('Hello');
  prin(to_date('26/01/1975', 'dd/mm/yyyy'));
  prin('Raj' || testSpaceLine || 'esh');
  prin(testSpaceLine||'                         ');
END;  
/


declare
 v_max_line varchar2(32767);
begin
-- The next three lines initialize the
-- variable v_max_line with 32,767 spaces.
for i in 1..32767 loop
 v_max_line := v_max_line || ' ';
end loop;
end;

--Demonstrate the use of TYPE and :=
DECLARE
 n_empno    EMP.EMPNO%TYPE := 1;
BEGIN 
 NULL;
END;
/

-- Learn Table Types
DECLARE
TYPE table_emp IS TABLE OF emp.ename%TYPE INDEX BY BINARY_INTEGER;
t_name                    table_emp;
n_name                    BINARY_INTEGER; -- position/rowid for the row
BEGIN
 t_name(1) := 'R';
 t_name(10) := 'A';
 n_name := t_name.first();
 prin(t_name(1));
 prin('There are ' || t_name.count() || ' records in the associative array t_name'); 
 prin(t_name.last());
 if t_name.exists(10) then 
    prin('Element 10 exists ' );
 end if;
END;
/

-- Learn Row Types
DECLARE
TYPE table_emp IS TABLE OF emp%ROWTYPE INDEX BY BINARY_INTEGER;
t_name                    table_emp;
n_name                    BINARY_INTEGER; -- position/rowid for the row
BEGIN
 t_name(1).ename := 'R';
 t_name(10).ename := 'A';
 n_name := t_name.first();
 prin(n_name);
END;
/

--Record Type
DECLARE
TYPE record_empname IS RECORD (
 r_empno emp.empno%TYPE,
 r_ename emp.ename%TYPE,
 r_job   emp.job%TYPE
);

TYPE table_emp IS TABLE of record_empname INDEX BY BINARY_INTEGER;

t_name     table_emp;
BEGIN
 t_name(1).r_empno := 1;
 t_name(1).r_ename := 'R';
 t_name(1).r_job   := 'q'; 
 --prin(t_name(1).r_empno || '  ' || t_name(1).r_ename '  ' || t_name(1).r_job );
 prin('EMP NO ' || t_name(1).r_empno || ' NAME ' || t_name(1).r_ename || ' Job ' || t_name(1).r_job );
END;
/

-- Understand Paramters - IN, OUT, IN OUT
CREATE OR REPLACE PACKAGE package_demo AS

FUNCTION f(
ai              IN     VARCHAR2(100),
ao                 OUT VARCHAR2(100),
aio             IN OUT VARCHAR2(100)
)
RETURN VARCHAR2 IS
BEGIN
NULL;
END;

END package_demo;

CREATE OR REPLACE PACKAGE package_demo
AS
  /*
  parameter.pks
  by Donald J. Bales on 2014-10-20
  A packge to test parameter scope
  */
  -- A function that execises the scope of parameters
  FUNCTION f(
      aiv_in IN VARCHAR2,
      aov_out OUT VARCHAR2,
      aiov_inout IN OUT VARCHAR2)
    RETURN VARCHAR2;
  -- A procedure that execises the scope of parameters
  PROCEDURE in_out_inout(
      aiv_in IN VARCHAR2,
      aov_out OUT VARCHAR2,
      aiov_inout IN OUT VARCHAR2); 
END package_demo;
/

-- Trying to create Package bodies
CREATE OR REPLACE PACKAGE body PARAMETER1
AS
  -- A function that exercises the scope of parameters
  FUNCTION in_out_inout(
      aiv_in IN VARCHAR2,
      aov_out OUT VARCHAR2,
      aiov_inout IN OUT VARCHAR2)
    RETURN VARCHAR2
  IS
  BEGIN
    RETURN 'OK'; -- a function must return a value!
  END in_out_inout;
  PROCEDURE in_out_inout(
      aiv_in IN VARCHAR2,
      aov_out OUT VARCHAR2,
      aiov_inout IN OUT VARCHAR2)
  IS
  BEGIN
  NULL;
  END in_out_inout;
END PARAMETER1;
/

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
    RETURN 'OK'; -- a function must return a value!
  END in_out_inout;
  PROCEDURE in_out_inout(
      aiv_in IN VARCHAR2,
      aov_out OUT VARCHAR2,
      aiov_inout IN OUT VARCHAR2)
  IS
  BEGIN
  NULL;
  END in_out_inout;
END PARAMETER;
/

--Trying to create Package and Package bodies
CREATE OR REPLACE PACKAGE package_demo AS

FUNCTION fForFun(av_in     IN      VARCHAR2,
                 av_out        OUT VARCHAR2,
                 av_inout  IN  OUT VARCHAR2) 
                 RETURN VARCHAR2;
PROCEDURE pForPeppaPig(av_in    IN       VARCHAR2,
                       av_out       OUT  VARCHAR2,
                       av_inout IN  OUT  VARCHAR2);
END package_demo;
/

-- Package body for package_demo
CREATE OR REPLACE PACKAGE BODY package_demo AS

FUNCTION fForFun(av_in     IN     VARCHAR2,
                 av_out       OUT VARCHAR2,
                 av_inout  IN OUT VARCHAR2) 
 RETURN VARCHAR2 IS 
 BEGIN
  prin('Function Before Assignments');
  prin('av_in is  ' || av_in);
  prin('av_out is ' || av_out);
  prin('av_inout is ' || av_inout);
  
  av_out := av_in;
  av_inout := av_inout || ' ' || av_in;
  
  prin('Function After Assignments');
  prin('av_in is    ' || av_in);
  prin('av_out is   ' || av_out);
  prin('av_inout is ' || av_inout);
 RETURN 'OK';
 END fForFun;
 
PROCEDURE pForPeppaPig(av_in     IN      VARCHAR2,
                       av_out       OUT  VARCHAR2,
                       av_inout  IN OUT  VARCHAR2) IS
 BEGIN
  prin('Procedure Before Assignments');
  prin('av_in is  ' || av_in);
  prin('av_out is ' || av_out);
  prin('av_inout is ' || av_inout);
  
  av_out := av_in;
  av_inout := av_inout || ' ' || av_in;
  
  prin('Procedure After Assignments');
  prin('av_in is    ' || av_in);
  prin('av_out is   ' || av_out);
  prin('av_inout is ' || av_inout);
 END pForPeppaPig;
END package_demo;
/

-- Unit Testing Package_Demo
DECLARE
  v_in      VARCHAR2(20) := 'V_IN';
  v_out     VARCHAR2(20)  := 'V_OUT';
  v_inout   VARCHAR2(20)  := 'V_INOUT';
  v_return  VARCHAR2(20)  := 'V_RETURN';
BEGIN
  prin('In Unit testing');
  prin('Initialising the variables with the following values');
  prin('v_in        ' || v_in );
  prin('v_out       ' || v_out );
  prin('v_inout     ' || v_inout );
  prin('v_return    ' || v_return );
  v_return := package_demo.fForFun(v_in, v_out, v_inout);
  prin('After fForFun, the values are ');
  prin('v_in        ' || v_in );
  prin('v_out       ' || v_out );
  prin('v_inout     ' || v_inout );
  prin('v_return    ' || v_return );
  package_demo.pForPeppaPig(v_in, v_out, v_inout);
  prin('v_in        ' || v_in );
  prin('v_out       ' || v_out );
  prin('v_inout     ' || v_inout );
  prin('v_return    ' || v_return );
END;
/

-- Single Row Processing - Inserts
DECLARE
  n_empno emp.empno%TYPE;
  v_ename emp.ename%TYPE;
  v_job emp.job%TYPE;
  n_mgr emp.mgr%TYPE;
  d_hiredate emp.hiredate%TYPE;
  n_sal emp.sal%TYPE;
  n_comm emp.comm%TYPE;
  n_deptno emp.deptno%TYPE;
  n_count NUMBER; -- n_count is used for the SQL Row count
BEGIN
  prin('Hellooo');
  -- Nested Begin to find empno
  BEGIN
    SELECT emp_empno_sequence.NEXTVAL INTO n_empno FROM SYS.DUAL;
  EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20000, SQLERRM || ' SELECT emp_empno_sequence FROM DUAL');
  END;
  -- Subtract 90 days from the current date as hiredate
  BEGIN
    SELECT SYSDATE-90 INTO d_hiredate FROM SYS.DUAL;
  EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20000, SQLERRM || ' sdsdsd ');
  END;
  -- Nested Begin to find out the value for Dept number
  BEGIN
    SELECT deptno INTO n_deptno FROM dept WHERE dname = 'RESEARCH';
  EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20000, SQLERRM || ' SELECT deptno FROM dept');
  END;

    v_ename    := 'Mike Woods';
    v_job      := 'CLERK';
    n_mgr      := 7782 ;
    d_hiredate := to_date('26011975','DDMMYYYY');
    n_sal      := 5000;
    n_comm     := 20;  

  prin('n_empno     is  ' || n_empno);
  prin('v_ename     is  ' || v_ename);
  prin('v_job       is  ' || v_job);
  prin('n_mgr       is  ' || n_mgr);
  prin('d_hiredate  is  ' || d_hiredate);
  prin('n_sal       is  ' || n_sal);
  prin('n_comm      is  ' || n_comm);
  prin('n_deptno    is  ' || n_deptno);
  INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES(n_empno, v_ename, v_job, n_mgr, d_hiredate, n_sal, n_comm, n_deptno);
  n_count := sql%rowcount;
  prin('n_count     is  ' || n_count);
END;
/

-- Single Row Processing - Insert with direct SELECT
DECLARE
  n_count NUMBER; -- n_count is used for the SQL Row count
  FUNCTION add_emp(
      v_ename emp.ename%TYPE )
    RETURN NUMBER
  IS
  BEGIN
    prin('Hello');
    INSERT INTO emp
      (empno,
      ename,
      deptno
      )
    SELECT emp_empno_sequence.NEXTVAL,
      v_ename,
      dep.deptno
    FROM SYS.dual dua, dept dep
    WHERE dep.dname = 'OPERATIONS';
    n_count        := sql%rowcount;
    prin('n_count     is  ' || n_count);
    RETURN n_count;
  EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20000, SQLERRM);
  END add_emp;
BEGIN
  prin('Hi');
  prin(add_emp('Adrian'));
END;
/


--Multi Row Processing - Cursors
DECLARE
  CURSOR c_emp (v_job IN emp.job%TYPE)
  IS
    SELECT ename, sal FROM emp WHERE job LIKE v_job || '%' ORDER BY empno;
  v_ename emp.ename%TYPE;  
  n_sal emp.sal%TYPE;  
BEGIN
  OPEN c_emp('SALESMAN');
  LOOP
    FETCH c_emp INTO v_ename, n_sal;
    IF c_emp%NOTFOUND THEN    
      CLOSE c_emp;
      EXIT;
    END IF;
    prin(v_ename || '     ' || n_sal);
  END LOOP;  
END;
/

CREATE OR REPLACE PACKAGE emppackage
AS
  FUNCTION get_id
    RETURN emp.empno%TYPE;
END emppackage;
/
CREATE OR REPLA'CE PACKAGE BODY emppackage
AS
  FUNCTION get_id
    RETURN emp.empno%TYPE
  IS
    n_id emp.empno%TYPE;
  BEGIN
    SELECT EMP_EMPNO_SEQUENCE.nextval INTO n_id FROM SYS.DUAL;
    --n_id1 := 10;
    retutn n_id;
  END get_id;
END emppackage;
/

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

