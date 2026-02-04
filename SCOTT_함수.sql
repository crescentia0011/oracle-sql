--substr
SELECT
      'hello, world',
      substr ('hello, world', 3, 6) substr1, -- +값이면 왼쪽 순번/
      substr ('hello, world', -5, 5) substr2 -- -값이면 오른쪽부터 왼쪽순번.
,
      substr ('2026-02-03', -5, 2) mm,
      instr ('02)3456-2345', ')', 1) instr1,
      instr ('031)2345-2312', ')', 1) instr2
FROM
      dual;

-- 주전공(210) ->전화번호, 지역번호 구분.
SELECT
      name,
      deptno1,
      tel,
      substr (tel, 1, instr (tel, '-', 1) -1) 지역번호
FROM
      student
WHERE
      deptno1 = 201;

SELECT
      name,
      deptno1,
      tel,
      instr (tel, ')', 1),
      instr (tel, '-', 1),
      substr (
            tel,
            (instr (tel, ')', 1) + 1),
            (instr (tel, '-', 1) - instr (tel, ')', 1) -1)
      ) 중간번호,
      substr (tel, (instr (tel, '-', 1) + 1)) 끝자리
FROM
      student
WHERE
      deptno1 = 201;

--lpad/rpad
SELECT
      lpad ('hello', 5, '*')
FROM
      dual;

SELECT
      lpad (ename, 9, '12345678'),
      rpad (ename, 10, '-')
FROM
      emp
WHERE
      deptno = 10;

SELECT
      rpad (ename, 9, (substr ('123456789', lengthb (ename))))
FROM
      emp
WHERE
      deptno = 10;

-- trim('값', '찾을문자열')
SELECT
      rtrim ('Hello', 'o')
FROM
      dual;

--replace('값', '찾을문자열', '대체문자열')
SELECT
      replace ('Hello', 'o', 'o, World')
FROM
      dual;

SELECT
      replace (ename, substr (ename, 1, 2), '**') replace,
      substr (ename, 1, 2)
FROM
      emp
WHERE
      deptno = 10;

SELECT
      ename
FROM
      emp
WHERE
      deptno = 20;

SELECT
      replace (ename, substr (ename, 2, 2), '--')
FROM
      emp
WHERE
      deptno = 20;

SELECT
      name,
      replace (jumin, substr (jumin, 7, 13), '-/-/-/-')
FROM
      student
WHERE
      deptno1 = 101;

SELECT
      name,
      TEL,
      replace (
            TEL,
            substr (
                  TEL,
                  instr (tel, ')', 1) + 1,
                  instr (tel, '-'),
                  -1
            ),
            '*'
      )
FROM
      student
WHERE
      deptno1 = 102;

SELECT
      name,
      tel,
      replace (
            tel,
            substr (
                  tel,
                  (instr (tel, ')', 1) + 1),
                  (instr (tel, '-', 1) - instr (tel, ')', 1) -1)
            ),
            '***'
      )
FROM
      student
WHERE
      deptno1 = 102;

SELECT
      name,
      tel,
      replace (
            tel,
            substr (tel, (instr (tel, '-', 1) + 1)),
            '****'
      )
FROM
      student
WHERE
      deptno1 = 101;

-- round(123.4)
SELECT
      round(123.456, 1) round,
      trunc (123.4567, 2) trunc,
      mod(12, 5),
      ceil(12.3),
      floor(12.3),
      power(3, 2),
      to_char (trunc (sysdate, 'hh'), 'rrrr/mm/dd hh24:mi:ss') --년/월/일/시/분/초
FROM
      dual;

SELECT
      Add_Months (sysdate, 1) next_month --28일
,
      months_between (sysdate + 10, sysdate) months
FROM
      dual;

SELECT
      empno,
      ename,
      trunc (months_between (sysdate, hiredate) / 12) || '년' || trunc (mod(months_between (sysdate, hiredate), 12)) || '개월' 근속년수 --사원번호. 이름, 근속년수 (23년)
FROM
      emp;

SELECT
      * --교수번호, 이름, 입사일자, 급여(30년 이상)
FROM
      professor;

SELECT
      profno,
      name,
      hiredate,
      pay,
      (trunc (months_between (sysdate, hiredate) / 12)) 근속년수
FROM
      professor P
WHERE
      (
            trunc (months_between (sysdate, hiredate) / 12) >= 30
      )
ORDER BY
      근속년수 DESC;

SELECT
      P.*
FROM
      professor P;

--학과
SELECT
      *
FROM
      department;

SELECT
      profno,
      name,
      p.deptno,
      d.deptno,
      dname
FROM
      professor p,
      department d
WHERE
      p.deptno = d.deptno
      AND d.dname = 'Computer Engineering';

SELECT
      profno,
      name,
      hiredate,
      position,
      pay,
      p.deptno
FROM
      professor p,
      department d
WHERE
      p.deptno = d.deptno
      AND d.dname = 'Software Engineering'
      AND (
            trunc (months_between (sysdate, hiredate) / 12) >= 20
      );

SELECT
      profno,
      name,
      hiredate,
      position,
      pay,
      p.deptno,
      dname,
      trunc (months_between (sysdate, hiredate) / 12) 근속년수
FROM
      professor p,
      department d
WHERE
      p.deptno = d.deptno
      AND p.deptno = 103
      AND (
            trunc (months_between (sysdate, hiredate) / 12) >= 20
      );

select
      *
from
      emp,
      dept
where
      emp.deptno = dept.deptno
order by
      emp.empno;

--sales부서에서 근속년수 40년 이상인 사람 사번,이름,급여,부서명
select
      e.empno,
      e.ename,
      e.sal,
      d.dname
from
      emp e,
      dept d
where
      e.deptno = d.deptno
      AND d.dname = 'SALES'
      AND (
            trunc (months_between (sysdate, hiredate) / 12) >= 40
      )
ORDER BY
      e.empno;

select
      2 + to_number ('2', 9),
      concat (2, '2'),
      sysdate
from
      dual
where
      sysdate > '2026/02/03';

-- to_char(날짜, 포맷문자)
SELECT
      sysdate,
      to_char (sysdate, 'RRRR-MM-DD HH24:MI:SS'),
      to_char (sysdate, 'year'),
      to_date ('05/2024/03', 'mm/rrrr/dd')
FROM
      dual;

-- to_char
SELECT
      to_char (12345.6789, '0999999.999999') --반올림 한 연산결과를 문자로 출력
FROM
      dual;

select
      *
from
      student
where
      to_char (birthday, 'mm') = '01';

select
      empno,
      ename,
      hiredate
from
      emp
where
      to_char (hiredate, 'mm') = '01'
      or to_char (hiredate, 'mm') = '02'
      or to_char (hiredate, 'mm') = '03';

-- nvl()
SELECT
      nvl (10, 0) --null ? 0: 10
FROM
      dual;

SELECT
      pay + nvl (bonus, 0) "월급"
FROM
      professor;

--student(profno)
SELECT
      name,
      nvl (profno, 9999) 담당교수번호
FROM
      student;

--
SELECT
      name,
      (nvl (to_char (profno || ''), '담당교수없음'))
FROM
      student;

--decode(a,b,'같은조건',다른조건)
SELECT
      decode (10, 20, '같다', '다르다') -- 10 == 20 ? '같다.' :'다르다'
FROM
      dual;

SELECT
      profno,
      decode (profno, null, 9999, profno)
FROM
      student
ORDER BY
      profno DESC;

SELECT
      decode ('C', 'A', '현재A', 'B', '현재B', '기타')
FROM
      dual;

SELECT
      deptno,
      name,
      decode (deptno, 101, 'Computer Engineering')
FROM
      professor;

SELECT
      deptno,
      name,
      decode (deptno, 101, 'Computer Engineering', 'ETC')
FROM
      professor;

SELECT
      deptno,
      name,
      decode (
            deptno,
            101,
            'Computer Engineering',
            102,
            'Multimedia Engineering',
            103,
            'Software Engineering',
            'ETC'
      )
FROM
      professor;

SELECT
      deptno,
      name,
      decode (
            deptno,
            101,
            decode (name, 'Audie Murphy', 'BEST!'),
            NULL
      )
FROM
      professor;

SELECT
      deptno,
      name,
      decode (
            deptno,
            101,
            decode (name, 'Audie Murphy', 'BEST!', 'GOOD!'),
            NULL
      )
FROM
      professor;

SELECT
      deptno,
      name,
      decode (
            deptno,
            101,
            decode (name, 'Audie Murphy', 'BEST!', 'GOOD!'),
            'N/A'
      )
FROM
      professor;

SELECT
      name,
      jumin,
      decode (substr (jumin, 7, 1), 1, 'MAN', 'WOMAN')
FROM
      student;

select
      birthday
FROM
      student;

-- 학생테이블의 생년월일을 기준으로 1~3 => 1/4분기, 4~6=> 2/4, 7~9, 10~11

SELECT
      name
     ,CEIL(
           TO_NUMBER (TO_CHAR (birthday, 'MM')) / 3
           )||'/4분기' AS 분기설정
FROM
      student;
      
 select name
        ,to_char(birthday, 'Q') || '/4' 분기
        ,birthday
from
      student;     
      