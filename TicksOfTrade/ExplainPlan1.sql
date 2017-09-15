EXPLAIN PLAN FOR SELECT e.DEPTNO FROM emp e, dept d WHERE e.DEPTNO = d.DEPTNO ORDER BY e.EMPNO;

select plan_table_output from table(dbms_xplan.display('plan_table',null,'TYPICAL'));

select plan_table_output from table(dbms_xplan.display_cursor(null,null,'TYPICAL'));