create table muser(
id int,
reg_num varchar2(8) not null,
name varchar2(10 char),
grade int,
salary int,
time int);

create sequence muser_no
increment by 1
start with 10
;

select * from muser;

insert into muser values(muser_no.nextval,'870205-1','이승진',1,10000,34);
insert into muser values(muser_no.nextval,'880405-1','박이진',2,20000,31);
insert into muser values(muser_no.nextval,'770715-2','최이수',4,40000,32);
insert into muser values(muser_no.nextval,'010205-3','류진아',1,10000,30);
insert into muser values(muser_no.nextval,'810205-2','오현식',2,20000,34);
insert into muser values(muser_no.nextval,'820219-2','정승우',3,30000,35);
insert into muser values(muser_no.nextval,'020205-3','이재수',1,10000,30);
insert into muser values(muser_no.nextval,'970214-2','박지영',2,20000,31);
insert into muser values(muser_no.nextval,'040205-4','정은아',4,40000,31);
insert into muser values(muser_no.nextval,'770225-1','정재영',5,50000,30);
insert into muser values(muser_no.nextval,'770905-2','이신수',4,40000,34);
insert into muser values(muser_no.nextval,'050208-3','이발끈',2,20000,30);
insert into muser values(muser_no.nextval,'051205-4','이욱이',1,10000,34);
insert into muser values(muser_no.nextval,'891215-1','지승아',3,30000,30);
insert into muser values(muser_no.nextval,'670805-1','현진수',2,20000,34);
insert into muser values(muser_no.nextval,'840207-1','최이런',1,10000,35);
insert into muser values(muser_no.nextval,'770405-1','이천안',1,10000,31);

--1 grade가 3인 사람은 모두 몇명인가요?
select count(*) from muser where grade=3;

--2 grade가 1,2,4인 사람들의 salary의 평균을 구하시오.
select avg(salary) salary평균 from muser where grade=1 or grade=2 or grade=4;

--3 salary가 20000 미만인 사람은 총 몇명입니까?
select count(*) from muser where salary<20000;

--4 salary가 30000 이상인 사람의 salary 평균을 구하시오.
select avg(salary) salary평균 from muser where salary>=30000;

--5 77년생중에  salary가 가장 적은 사람의 이름과 나이와 salary를 출력하시오.
--오답
select name 이름, min(salary) from muser where substr(reg_num,1,2)='77';
--에러이유: min이라는 함수를 사용할때 매개변수의 값으로 salary만을 주고, 그에대한 리턴값으로 salary 최소값만을 가져왔기때문
--   즉, name은 조건에 맞는 사람 중 salary의 최소값을 받아올 때, 리턴값으로 같이 받아오지 못하기때문에 
--   DB의 입장에서는 해당 salary에 속하는 이름과 나이를 가져와야한다는 인식이 없음. 따라서 '단일그룹의 그룹함수가 아님'이라는 에러가 발생.
--   그렇기에 이에 대한 해답으로, 
--   (서브쿼리에서 리턴값으로 받은 salary에 해당하는 사람의 이름과 나이 - 본쿼리 
--   / '77'년생에 해당하며(where), 그중에서 최소salary 리턴값을 받아 생성한 테이블(b)- 서브쿼리 로 분류하여 생각할 것)

--해답
select name 이름, 
case when substr(reg_num,3,2)< to_char(sysdate,'MM') or (substr(reg_num,3,2) = to_char(sysdate,'MM') and substr(reg_num,5,2)<=to_char(sysdate,'DD'))
            then 124-substr(reg_num,1,2)
           when substr(reg_num,3,2)> to_char(sysdate,'MM') or (substr(reg_num,3,2) = to_char(sysdate,'MM') and substr(reg_num,5,2)>to_char(sysdate,'DD'))
            then 124-substr(reg_num,1,2)-1
      end as 나이 ,
      salary 최소salary from muser a, 
(select min(salary) 최소salary from muser where substr(reg_num,1,2)='77') b
where a.salary = b.최소salary and substr(reg_num,1,2)='77';

--6 모든 사람의 이름과, 생일(월과 일 예를들어 0205)를 출력하시오.
select name 이름, substr(reg_num,3,4) 생일 from muser;

--7 남자의 평균 급여를 구하시오.
select avg(salary) 남자평균급여 from muser where substr(reg_num,8,1)='1' or substr(reg_num,8,1)='3';

--8 전체 평균급여보다 높은 급여를 받는 사람의 이름과, 급여를 출력하시오
select name 이름, salary 급여
from muser
where (select avg(salary) from muser)<salary;

--9 전체 평균급여보다 높은 급여를 받는 사람의 이름과, 급여, 평균급여를 출력하시오
--전체 평균급여보다 높은 급여 받는 사람의 평균급여(서브쿼리)
select avg(salary) 평균급여
from muser
where (select avg(salary) from muser)<salary; 
-- 최종쿼리
select name 이름, salary 급여, 
(select avg(salary)
from muser
where (select avg(salary) from muser)<salary) as 평균급여
from muser
where (select avg(salary) from muser)<salary;

--10 여직원의 평균급여보다 높은 남자직원은 모두 몇명입니까
-- 여직원 평균(서브쿼리)
select avg(salary) 여직원평균급여 from muser where substr(reg_num,8,1)='2' or substr(reg_num,8,1)='4';
--최종쿼리
select count(*) from muser
where
(select avg(salary) 여직원평균급여 from muser where substr(reg_num,8,1)='2' or substr(reg_num,8,1)='4')<salary
and (substr(reg_num,8,1)='1' or substr(reg_num,8,1)='3');

--11 grade별 평균 급여를 출력하세요..
select grade, avg(salary) 평균급여 from muser group by grade;

--12 그룹별 평균급여가 전체 평균보다 높은 그룹을 출력하시오.
select grade from muser
group by grade
having avg(salary)>(select avg(salary) from muser);

--13 직원들의 월급 명세서를 출력하시오. (출력 형태는 이름, 월급(grade*salary*time)
select name 이름, (grade*salary*time) 월급
from muser;

--14 직원들의 성별을 출력하시오. (출력 형태 이름, 성별(성별은 남또는 여로 출력한다)
select name 이름,
case when substr(reg_num,8,1) = '1' or substr(reg_num,8,1)= '3' then '남'
    when substr(reg_num,8,1) = '2' or substr(reg_num,8,1) = '4' then '여' end as 성별
from muser;

--15 time은 근무시간, 근무시간이 31이상인 사람의 이름을 출력하시오.
select name 이름 from muser
where time>=31;

--16 짝수년도에 태어난 사람들의 이름을 모두 출력하시오.
select name 이름 from muser
where (mod(substr(reg_num,1,2),2)=0);

--17 직원들의 생년월일을 출력하시오. (출력 형태는 이름과 생년월일(97년1월2일))
select name 이름, 
(concat(substr(reg_num,1,2),'년'))||
(concat(substr(reg_num,3,2),'월'))||
(concat(substr(reg_num,5,2),'일')) 생년월일
from muser;

--18 여직원들의 육아를 지원하기 위한 정책으로 time을 2시간가산하기로 했다. 이를 처리 하시오.
select id,reg_num,name,grade,salary,
case when substr(reg_num,8,1) = '1' or substr(reg_num,8,1)= '3' then time
    when substr(reg_num,8,1) = '2' or substr(reg_num,8,1) = '4' then time+2 
    end as 정책time
from muser;

--19 나이별 인원수는 몇명입니까
select substr(reg_num,1,2) 년도, count(*) 인원수 
from muser
group by substr(reg_num,1,2);

--20 2학년그룹과 4학년 그룹은 모두 몇명입니까
select count(*)
from muser
where grade='2' or grade='4';

--
--
--추가문제
--
--#1) 모든 사람이 태어난 후 오늘까지 몇 달이 지났는지 출력하시오
--(출력형태: 이름, 주민번호, 지금까지살아온월수)
select name 이름, reg_num 주민번호,
round(months_between(sysdate,substr(reg_num,1,6))) 지금까지살아온월수
from muser;


-- 번외로, 함수만들기(위 작성 결과 확인)
select name,
case when 
substr(reg_num,8,1)='1' or substr(reg_num,8,1)='2'
then 
(case when substr(reg_num,3,2)>= to_char(sysdate,'MM')
then ((124-substr(reg_num,1,2))*12)+12+to_char(sysdate,'MM')-substr(reg_num,3,2)
when substr(reg_num,3,2)< to_char(sysdate,'MM')
then ((124-substr(reg_num,1,2))*12)+to_char(sysdate,'MM')-substr(reg_num,3,2)
end)
when substr(reg_num,8,1)='3' or substr(reg_num,8,1)='4'
then
(case when substr(reg_num,3,2)>= to_char(sysdate,'MM')
then ((24-substr(reg_num,1,2))*12)+12+to_char(sysdate,'MM')-substr(reg_num,3,2)
when substr(reg_num,3,2)< to_char(sysdate,'MM')
then ((24-substr(reg_num,1,2))*12)+to_char(sysdate,'MM')-substr(reg_num,3,2)
end)
end as 월 from muser;

--#2) time을 나이로 봄. 30~31세의 살아온 월수의 합, 32세 이상의 살아온 월수의 합 구하기
--서브1
select sum(time*12) 어린집단
from muser
where time<32;
--서브2
select sum(time*12) 많은집단
from muser
where time>=32;
--최종쿼리
select
distinct(select sum(time*12)
from muser
where time<32) 어린집단_31이하,
(select sum(time*12)
from muser
where time>=32) 많은집단_32이상
from muser;

--#3) 연령별 급여의 합, over()함수 이용
select distinct(time) 연령, sum(salary) over(partition by time) as 총합 from muser;

--#4) 연령별 인원수, over()함수 이용
select distinct(time) 연령, count(*) over(partition by time) as 연령별인원수 from muser;

--#5) 등급별 급여의 최고급여, over()함수 이용
select distinct(grade) 등급, max(salary)over(partition by grade) as 최고급여 from muser;

--#6) 구글검색하여 오라클 함수 정리
--1. trunc(10/3)  -> 10을 3으로 나눈 몫을 구하는 함수
--2. mod(10,3) -> 10을 3으로 나눈 나머지를 구하는 함수
--3. substr(매개변수, 시작위치, 추출갯수)  -> substr('abcd',1,2)의 결과는 'ab'
--4. avg(컬럼명) -> 해당 컬럼의 튜플값의 평균을 구하는 함수
--5. months_between(날짜1, 날짜2) -> 두 날짜 사이의 '월'의 차이를 구해줌
--6. distinct(컬럼명) -> 해당 컬럼에서 중복되는 값을 한번만 출력
--7. over() -> order by, group by 서브쿼리를 개선하기 위한 함수로,
--             count(*)/max(컬럼)/sum(컬럼) ... over(partition by ~) 이런식으로 쓰면
--             지정한 그룹이 over 앞쪽의 함수에서만 해당 및 적용되어 결과가 리턴된다.
--             count(*)/max(컬럼)/sum(컬럼) ... over(order by ~ asc/desc)
--             이런식으로 쓰면 작성된 정렬이 over 앞쪽의 함수에만 해당 및 적용되어 결과가 리턴된다.