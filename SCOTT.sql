--Orecle(DBMS) -  version(21c) - xe(database명)
-- user(scott) - 테이블.
-- Structured Query Language (SQL)
SELECT studno, name --칼럼명(전체)
FROM student; --테이블.

-- 1.table = professor 테이블 전체 칼럼 조회
SELECT * 
FROM professor;

--2) 학생 -> 학생번호, 이름, 학년
SELECT studno, name, grade
FROM student;

--숙제완료함
SELECT name || '의 아이디는 ' || id as "전체설명" --별칭(alias)
        ,grade "학년"
FROM student;

--james Seo의 아이디는 75true 이고 4학년 입니다. => alias (학년설명)

SELECT name || '의 아이디는 ' || id || '이고' || grade || '학년 입니다.'
 as "학년설명"
FROM student;

--james Seo의 '아이디'는 75true 이고 4학년 입니다. => alias (학년설명)

SELECT name || '의 ''아이디''는 ' || id || '이고' || grade || '학년 입니다.'
 as "학년설명"
FROM student;

SELECT DISTINCT grade  --중복된 값 제거.
FROM student;

SELECT *
FROM emp;

SELECT name || ' ID:' ||id|| 'WEIGHT is '|| weight ||'kg'as "ID AND WEIGHT"
FROM student;

SELECT *
FROM emp;

SELECT ename ||'('|| job|| ')' ||', ' || ename || '''' || job ||''''
as "NAME AND JOB"

FROM emp;

--WHERE절
SELECT *
FROM student
WHERE weight BETWEEN 60 AND 70
AND deptno1 in (101, 201);

SELECT *
FROM student
WHERE deptno2 is NOT null;

--비교연산자 연습1) EMP테이블 급여 칼럼 3000보다 큰 직원,

SELECT  ename, sal
FROM emp
WHERE sal >3000;
--비교연산자 연습2) emp테이블 보너스 있는 사람들만 출력

SELECT *
FROM emp
WHERE comm is not null;

--비교연산자 연습3) student테이블 주전공학과 : 101, 102, 103인 학생

SELECT *
FROM student
WHERE deptno1 IN(101,102,103);


--AND / OR
-- IF (sal > 100 && height > 170)
SELECT studno
    ,name
    ,grade
    ,height
    ,weight
    
FROM student
WHERE (height > 170
OR weight >60)
AND (grade = 4 OR height > 150);

--급여가 2000이상인 직원, 커미션(급여 + 커미션)

SELECT ename ,  sal, comm
FROM emp
WHERE sal >2000 or sal+comm > 2000;

-- 교수 연봉이 5000 이상만 보너스 3번
SELECT name,
    pay*12 as 연봉,
    bonus*3 as 연간보너스,
    pay*12+bonus*3 as 연간합계
FROM professor
WHERE((PAY*12)>=3000
AND bonus is null)
OR ((PAY*12)+(BONUS*3)>=3000
AND bonus is not null)
ORDER BY 4;

--문자열일 경우에 LIKE 연산자.
SELECT *
FROM student
WHERE name like '%on____%';

--date
SELECT *
FROM professor
WHERE hiredate > to_date('99-01-01', 'rr-mm-dd')
ORDER BY hiredate; --1970.01.01

--학생테이블, 전화번호(지역번호 02, 031, 051, 052, 053)
--부산(051)에 거주하는 사람의 학생들을 조회
SELECT *
FROM student
WHERE Tel like '051%';

--이름 M으로 시작 8개 이상인 사람만 조회.
SELECT *
FROM student
WHERE name like 'M________%';

--주민번호 10월달에 태어난 사람 조회
SELECT *
FROM student
WHERE jumin like '__10%';

SELECT (ename ||'`s sal is $' || sal) as "NAME And Sal"
FROM emp;







