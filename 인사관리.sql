SELECT *
FROM employees;
--1번
SELECT employee_id, last_name, salary,department_id
FROM employees
WHERE salary >7000
AND last_name like 'H%';

--2번
SELECT employee_id
        ,last_name
        ,first_name
        ,job_id
        ,salary
        ,department_id
FROM employees
WHERE  salary >5000
AND department_id =  50
OR department_id = 60;

--3번
SELECT last_name
        ,salary
        ,CASE
        WHEN salary <=5000 THEN (salary*1.2)
        WHEN salary BETWEEN 5001 AND 10000 THEN(salary*1.15)
        WHEN salary BETWEEN 10001 AND 15000 THEN(salary*1.1)
        WHEN salary >=15001 THEN salary
        END up_salary
FROM employees;
--4번
SELECT d.department_id
        ,d.department_name
        ,e.city
FROM departments d
JOIN locations e ON e.location_id = d.location_id;
--5번

select employee_id
        ,last_name
        ,job_id
from employees
where department_id =(select department_id
        from departments
        where department_name= 'IT');
--6번
select employee_id
        ,first_name
        ,last_name
        ,email
        ,phone_number
        ,to_char(hire_date,'DD-MON-RR') hire_date
        ,job_id
from employees
where hire_date < '2014-01-01'
AND job_id = 'ST_CLERK';

--7번
SELECT last_name
        ,job_id
        ,salary
        ,substr(commission_pct,1) commission_pct
FROM employees
WHERE commission_pct is not null
ORDER BY salary desc;

--8번
CREATE TABLE prof (
    profno number(4),
    name varchar2(15) not null,
    id varchar2(15) not null,
    hiredate date,
    pay number(4)
);

--9번
INSERT INTO prof values(1001,'Mark', 'm1001', '07/03/01', 800);
INSERT INTO prof (profno,name,id,hiredate)
values(1003,'Adam', 'a1003', '11/03/02');

SELECT *
FROM prof;

UPDATE prof
SET pay = 1200
WHERE profno = 1001;

DELETE FROM prof
WHERE profno = 1003;

--10번
ALTER TABLE prof
ADD primary key(profno);

ALTER TABLE prof
ADD (GENDER CHAR(3));

ALTER TABLE prof
MODIFY (name varchar2(20));
