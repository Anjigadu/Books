-- Single Row Processing - Insert with direct SELECT
DECLARE
  n_count NUMBER; -- n_count is used for the SQL Row count
  FUNCTION add_emp(
      v_ename emp.ename%TYPE,
      v_job emp.job%TYPE,
      n_mgr emp.mgr%TYPE,
      d_hiredate emp.hiredate%TYPE,
      n_sal emp.sal%TYPE,
      n_comm emp.comm%TYPE )
    RETURN NUMBER
  IS
  BEGIN
    prin('Hello');
    INSERT INTO emp
      (empno, ename, job, mgr, hiredate, sal, comm, deptno
      )
    SELECT dua.emp_empno_sequence.NEXTVAL,
      v_ename,
      v_job,
      n_mgr,
      d_hiredate,
      n_sal,
      n_comm,
      dep.deptno
    FROM SYS.dual dua,
      dept dep
    WHERE dep.dname = 'OPERATIONS';
  END add_emp;
n_count := sql%rowcount;
prin('n_count     is  ' || n_count);
RETURN n_count;
EXCEPTION
WHEN OTHERS THEN
  raise_application_error(-20000, SQLERRM);
END;  
END add_emp;
--END;
/