drop table users;
drop table carinfo;

create table users(
id varchar2(8), 
name varchar2(10), 
addr varchar2(10));

create table carinfo(
c_num varchar2(4),   --자동차 번호
c_name varchar2(10),  -- 자동차 종류
id varchar2(8));
 
insert into users values ('1111','kim','수원');
insert into users values ('2222','lee','서울');
insert into users values ('3333','park','대전');
insert into users values ('4444','choi','대전');

insert into carinfo values ('1234','중형','1111');
insert into carinfo values ('3344','소형','1111');
insert into carinfo values ('5566','중형','3333');
insert into carinfo values ('6677','중형','3333');
insert into carinfo values ('7788','중형','4444');
insert into carinfo values ('8888','중형','5555');

select * from users;
select * from carinfo;

commit;

--위 자료를 회원이 등록한 자동차 정보이다.
--1. 회원의 이름과 주소를 출력하시오.
select name 이름, addr 주소 from users;

--2. 회원의 이름과 소유한 자동차 번호를 출력하시오.
-- 자동차 있는 회원만
select u.name,c.c_num
from users u, carinfo c
where u.id=c.id;

--자동차 없는 회원도
select a.name 이름, b.c_num 자동차번호 
from users a
left outer join carinfo b
on a.id=b.id;

--3. 자동차 번호가 7788인 소유자의 이름과 주소를 출력하시오.

-- 첫번째방법. 조인을 해서 조건절로 7788인 자동차의 소유자의 정보를 출력 > 조인
select u.name, u.addr
from users u, carinfo c
where u.id=c.id and c.c_num='7788';

-- 두번째방법. 7788소유자의 회원아이디를 검색한 후 결과값을 본 쿼리의 조건 > 서브쿼리
select name 이름, addr 주소
from users
where id=(
select id from carinfo where c_num='7788');

--4. 자동차를 소유하지 않은 사람의 이름과 주소를 출력하시오.

-- 이름과 주소는 users // 자동차를 소유하지 않은 사람이라는 조건
--      carinfo 테이블을 참조해 봐야.. 이너조인, 아우터조인..

-- 문제를 잘 해석하면 한 튜플에서 이름은 있지만, 
-- 자동차에 관련된 항목이 null인것을 찾아야함을 판단할 수 있음
-- (users테이블을 carinfo에 left join으로 진행)

-- 1단계. 아우터조인을 통해 참여하지 않은 튜플(null값)을 확인
select u.*, c.*
from users u
left outer join carinfo c
on u.id=c.id
where c_name is null;

-- 2단계. 원하는 값만을 출력
select a.name 이름, a.addr 주소
from users a
left outer join carinfo b
on a.id=b.id
where c_num is null;
-- left outer join을 아래와 같은 방법으로도 나타낼 수 있음
select u.name 이름, u.addr 주소
from users u, carinfo c
where u.id = c.id(+) and c_name is null;

--5. 회원별 등록한 자동차 수를 출력하시오.
select a.name 회원, count(*) 자동차수
from users a
inner join carinfo b
on a.id=b.id
group by a.name;
-- 문제: 동명이인일 수도 있으니 u.id로 그룹을 하자.

select a.name 회원, count(*) 자동차수
from users a
inner join carinfo b
on a.id=b.id
group by a.id;
-- 문제: select의 a.name은 다중행이여서 출력시 에러발생
--  -> id와 name을 하나의 속성으로 생각하여 그룹화하자(group by를 복합속성으로 정의하자)

select a.name 회원, count(*) 자동차수
from users a
inner join carinfo b
on a.id=b.id
group by (a.id,a.name);
-- 문제: 0대를 등록한 회원은 아예 출력이 안되는데, 모든 회원에 대해서 자동차를 알고싶다.
-- null값이 있는 튜플은 카운트 안하는 방법에 대해 검색
-- count(특정컬럼)을 사용하면 그 컬럼에서 null값은 카운트 하지 않을 수 있음
-- 해결 후 쿼리 재작성(자동차수가 0대인 것도 나올 수 있도록..)

-- 최종
select a.name 회원, count(b.c_num) 자동차수
from users a
left outer join carinfo b
on a.id=b.id
group by (a.id,a.name);

--6. 2대 이상을 소유한 회원의 이름과 소유한 자동차 수를 출력하시오.
select a.name 회원, count(*) 자동차수
from users a 
right outer join carinfo b
on a.id=b.id 
group by (a.id, a.name) having (count(*)>=2);

--7. 자동차는 등록되어 있는데 소유자가 없는 자동차 번호를 출력하시오.
-- 팁, 먼저 보는 테이블과 나중에 보는 테이블의 순서를 기억..
-- 먼저 보는 테이블은 carinfo, 두번째로 보는 테이블은 users
-- 자동차가 등록되어 있는데 소유자가 누구냐? 이너조인
-- 이너조인에 참여하지 못하는 튜플을 원한다.. 아우터조인..
-- 아우터 조인일때는 어떤 테이블을 left로 볼 것인가?? 첫번째 left로 지정
select a.c_num 자동차번호
from carinfo a
left outer join users b
on a.id=b.id
where b.id is null;

-- 다른표기
select c.c_num 자동차번호
from carinfo c, users u
where c.id = u.id(+) and u.id is null;

-- 다음 부터는 3개 테이블을 조인하는 문제입니다.

-- companycar 회사에서 구매한 자동차를 의미, 
--carinfo는 직원에게 배정한 자동차

--다음 테이블을 생성하시오.
create table companycar(     -- 자동차 정보
c_num varchar2(4),   -- 차번호
c_com varchar2(30), 
c_name varchar2(10),  -- 차이름
c_price number);  -- 차 가격

--다음 튜플을 삽입하세요
insert into companycar values ('1234','현다','소나타',1000);
insert into companycar values ('3344','기와','축제',2000);
insert into companycar values ('7788','기와','레2',800);
insert into companycar values ('9900','현다','그랭저',2100);
select * from companycar;
commit;

--8. 배정 자동차의 차번호, 제조사, 자동차명, 가격을 출력하시오.

-- carinfo 배정 자동차의 정보로 가정... 차번호는 carinfo로 해결이 가능하지만
-- 제조사와 자동차명과 가격은 companycar 테이블에 있음 -> 이너조인
select b.c_num 차번호, a.c_com 제조사, a.c_name 자동차명, a.c_price 가격
from companycar a, carinfo b
where a.c_num = b.c_num;

--9. 회사에서구매는 하였지만 배정되지 않은 자동차의 차번호, 제조자, 자동차 이름을 출력
select b.c_num, b.c_com, b.c_name
from carinfo a
right outer join companycar b
on a.c_num=b.c_num
where a.id is null;

--10. 자동차 가격이 1000만원 이상인 자동차의 자동차 번호를 출력하시오.
select c_num 자동차번호
from companycar
where c_price>=1000;

--11. 배정된 자동차 중에 회사에서 구매한 자동차가 아닌 자동차 번호를 출력하시오.
select a.c_num 자동차번호
from carinfo a
left outer join companycar b
on a.c_num=b.c_num
where b.c_com is null;

--12. 모든 사람의 정보를 출력하시오. 이름, 배정받은 자동차번호, 자동차이름
select e.name 이름, r.c_num 자동차번호, r.c_name 자동차이름
from users e
left outer join 
(select a.c_num, b.c_name, a.id
from carinfo a
left outer join companycar b
on a.c_num=b.c_num) r
on e.id=r.id;
