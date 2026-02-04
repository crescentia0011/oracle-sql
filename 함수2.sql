SELECT
    e.*,
    dname,
    loc
FROM
    emp  e,
    dept d
WHERE
    e.deptno = d.deptno;

--ANSI vs. ORACLE
SELECT
    *
FROM
         emp e
    JOIN dept d ON e.deptno = d.deptno
WHERE
    job = 'SALESMAN';

SELECT
    *
FROM
    student;

-- student(profno), professor(profno)
SELECT
    studno,
    s.name,
    nvl(to_char(s.profno), '담당교수없음 ') 교수번호,
    nvl(f.name, '담당교수없음 ')            교수이름
FROM
    student   s
    LEFT OUTER JOIN professor f ON s.profno = f.profno;

--학생번호, 학생이름, 담당교수이름 / 담당교수 없음
--0615,addasdssd , sdadsads

SELECT
    studno
    || ', '
    || s.name
    || ', '
    || nvl(f.name, '담당교수없음 ') 교수이름
FROM
    student   s
    LEFT OUTER JOIN professor f ON s.profno = f.profno;

--nvl(), decode(), case when end
--student 지역번호 구분
SELECT
    jumin
FROM
    student;

SELECT
    name,
    tel,
    CASE ( substr(tel, 1, instr(tel, ')', 1) - 1) )
        WHEN '02'  THEN
            'seoul'
        WHEN '051' THEN
            'busan'
        WHEN '053' THEN
            'daegu'
        WHEN '031' THEN
            'kyunggi'
        WHEN '055' THEN
            'kyunnam'
        ELSE
            'etc'
    END 지역명
FROM
    student;

SELECT
    name,
    substr(jumin, 3, 2),
    CASE
        WHEN substr(jumin, 3, 2) BETWEEN '01' AND '03' THEN
            '1/4분기'
        WHEN substr(jumin, 3, 2) BETWEEN '04' AND '06' THEN
            '2/4분기'
        WHEN substr(jumin, 3, 2) BETWEEN '07' AND '09' THEN
            '3/4분기'
        WHEN substr(jumin, 3, 2) BETWEEN '10' AND '12' THEN
            '4/4분기'
    END 분기
FROM
    student;

SELECT
    empno,
    ename,
    sal,
    CASE
        WHEN sal BETWEEN 1 AND 1000    THEN
            'LEVEL 1'
        WHEN sal BETWEEN 1001 AND 2000 THEN
            'LEVEL 2'
        WHEN sal BETWEEN 2001 AND 3000 THEN
            'LEVEL 3'
        WHEN sal BETWEEN 3001 AND 4000 THEN
            'LEVEL 4'
        ELSE
            'LEVEL 5'
    END "LEVEL"
FROM
    emp;

SELECT
    job,
    COUNT(job),
    SUM(sal),
    round((AVG(sal)), 1) avg,
    MIN(hiredate),
    MAX(hiredate)
FROM
    emp
GROUP BY
    job;

SELECT
    *
FROM
    dept;

SELECT
    *
FROM
    emp;
--부서별 급여합계, 평균급여, 인원
SELECT  d.dname,
        e.*
FROM  (
        SELECT
            deptno,
            SUM(sal)           sum,
            round(AVG(sal), 1) avg,
            COUNT(*)           count
        FROM
            emp
        GROUP BY
            deptno
    ) e
    JOIN dept d ON e.deptno = d.deptno;
    ------------------------
SELECT
    d.dname,
    SUM(e.sal) 급여합계,
    round(AVG(e.sal+nvl(comm,0)), 1) 평균급여,
    COUNT(e.deptno) 부서별인원
FROM
    emp  e,
    dept d
WHERE
    e.deptno = d.deptno
GROUP BY
    d.dname;
    
-- rollup()
-- 부서별 직무 평균급여, 사원수,
select deptno
        ,job
        ,avg(sal)
        ,count(*)
FROM emp
GROUP BY deptno
        ,job
union
-- 부서별 평균급여, 사원수.
SELECT
    deptno,
    '--소계--',
    round(AVG(e.sal+nvl(comm,0)), 1) 평균급여,
    COUNT(*) 부서별인원
FROM
    emp  e
GROUP BY
    deptno
union
--평균급여, 사원수.
SELECT
    99,
    ' 전체집계',
    round(AVG(e.sal+nvl(comm,0)), 1) 평균급여,
    COUNT(*) 인원
FROM
    emp  e
ORDER BY 1;

--rollup

SELECT deptno
        ,job
        ,avg(sal)
        ,count(*)
FROM emp
GROUP BY rollup(deptno,job)
ORDER BY 1;

-- 게시판(board)
-- 글번호, 제목, 작성자, 글내용, 작성시간--, 조회수, 수정시간, 수정자...
DROP TABLE board;
CREATE TABLE board(
    board_no number(10) primary key,--글번호,
    title varchar2(300) not null,-- 제목,
    writer varchar2(50) not null,--작성자,
    content varchar2(1000) not null,--글내용,
    created_at date default sysdate);--작성시간
    --테이블 칼럼 추가
    ALTER TABLE board
    ADD (click_count number);
    --테이블 칼럼 수정
    ALTER TABLE board
    modify content varchar2(2000);
    ALTER TABLE board
    modify click_count number default 0;
    --테이블 정보 보기
    desc board;
INSERT INTO board(board_no, title, writer, content) 
values(3, 'test', 'user01','연습글입니다');

SELECT *
FROM board;

update board
set title = 'test3'
where board_no = 3;

update board
set title = 'test3'
where board_no = 3;

update board
set click_count =0;

