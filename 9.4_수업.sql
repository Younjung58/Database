create table sstu(
no number,
name varchar2(5 char),
tel varchar2(13));

create table pp(no number, e_name varchar2(4), e_point number(3));

insert into sstu values(1,'hong','1111');
insert into sstu values(2,'kim','2222');
insert into sstu values(3,'lee','3333');
insert into pp values(1,'java','70');
insert into pp values(1,'html','90');
insert into pp values(3,'java','80');
commit;
select * from sstu;
select * from pp;

-- join: 한개 이상의 테이블을 논리적으로 합치는 것
-- 종류
-- full join: 두개의 테이블을 모두 합치는 것
--            결과는 n*m의 수만큼 조인이 되어 튜플이 만들어진다.
-- inner join: 조건을 제시한다. 조건에 참일 경우만 조인한다.
--             종류는 동등이너조인(==), 비동등이너조인(!=)이 있다.
-- outer join: 이너조인 + 조인에 참여하지 않은 튜플까지 출력
--             종류는 테이블 조인의 위치에 따라서 
--             left outer join, right outer join
-- 공부의 방향 / 핵심은 '어떤 테이블을 조인할까? 어떤 조인을 사용할까?'

-- 먼저 FULL JOIN해본다.. 절대 현업에서는 하지말것!. 속도 느려짐.
select * from sstu,pp;

select s.no, s.name, p.no, p.e_name, p.e_point
from sstu s, pp p;

-- INNER JOIN(동등이너조인)
select s.no, s.name, p.no, p.e_name, p.e_point
from sstu s, pp p
where s.no = p.no;
  -- 동등이너조인은 다음과 같은 표기법도 있다.(inner join - on)
select s.no, s.name, p.no, p.e_name, p.e_point
from sstu s     -- left table을 from에
inner join pp p     -- right table을 join자리에
on s.no = p.no;

-- OUTER JOIN
select s.no, s.name, p.no, p.e_name, p.e_point
from sstu s
left outer join pp p        -- left outer join / left table : sstu
on s.no = p.no;
-- join에 참여안된 컬럼은 null로 나옴

select s.no, s.name, p.no, p.e_name, p.e_point
from sstu s
right outer join pp p        -- right outer join / right table : pp
on s.no = p.no;

-- 실습
-- 시험을 본 학생들의 이름과 과목과 점수를 출력하시오
-- 2개의 테이블을 합쳐야 하죠 // 조인.. 그런데 같은 컬럼을 합치죠 -- 이너조인
select s.name, p.e_name, p.e_point
from sstu s, pp p
where s.no = p.no;
-- 홍길동의 이름과 과목과 점수를 출력하시오. 이너조인 필요
select s.name, p.e_name, p.e_point
from sstu s, pp p
where s.no = p.no and s.name='hong';
-- 시험을 치루지 않은 학생들의 이름을 출력하시오.
-- 이너조인에 참여하지 않은 튜플의 정보이므로 아우터 조인
-- 1. left outer join해결
select s.name
from sstu s
left outer join pp p
on s.no = p.no
where p.no is null;

-- 정리
-- JOIN의 정의
-- JOIN의 종류
-- 조인의 종류를 언제 사용하는지? 샘플...