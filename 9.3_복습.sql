commit;

select * from muser;

--1 grade가 3인 사람은 모두 몇명인가요?
select count(*)      -- 원하는 값은 인원수.. 인원수는 컬럼으로 해결 불가(함수사용)
from muser     
where grade=3;      --grade 3인 사람은 튜플의 선정 조건이라 볼 수 있음

--2 grade가 1,2,4인 사람들의 salary의 평균을 구하시오.
select avg(salary)
from muser
where grade in(1,2,4);  --튜닝
--where grade=1 or grade=2 or grade=4;
--group by   --그룹의 정의: 그룹별 집계일 경우
--order by

--3 salary가 20000 미만인 사람은 총 몇명입니까?
select count(*)     -- 원하는 값은 인원수.. 인원수는 컬럼으로 해결 불가(함수사용)
from muser
where salary<20000;
--group by
--order by

--5 77년생중에  salary가 가장 적은 사람의 이름과 나이와 salary를 출력하시오.
select   --이름과 나이와 salary
from muser
where    --77년생중에
--gruop by
--order by
/* 77년생 쿼리 테스트 시작 */
select substr(reg_num,1,2) from muser;  --중간 단계
-- 본쿼리에 적용...
select   --이름과 나이와 salary
from muser
where substr(reg_num,1,2)='77'    --77년생중에
/* 77년생 쿼리 테스트 시작 */
-- 77년생중에  salary가 가장 적은 사람의 이름과 나이와 salary를 출력하시오.
-- 77년생중에서 가장 작은 salary 뽑아 내본다.
select min(salary)
from muser
where substr(reg_num,1,2)='77';
-- 가장 작은 salary를 알면 가장 작은 salary를 조건으로
-- 가장 작은 salary를 받는 사람의 튜플을 선정할 수 있다.
select *
from muser
where substr(reg_num,1,2)='77' and salary=10000;
-- 10000은 상수로 지정하면 안된다. 서브쿼리를 생각
select name 이름, reg_num 나이, salary 급여
from muser
where substr(reg_num,1,2)='77' and salary=(
    select min(salary)
    from muser
    where substr(reg_num,1,2)='77');
-- 나이를 출력한다.. 그런데 위 퀄니는 주민번호를 출력
-- 컬럼으로 해결 가능한가? 수식? 함수? 서브쿼리 > 수식과 함수가 필요
select 1900+substr(reg_num,1,2) from muser;
select * from muser;
-- 분석: 상수로 1900을 보정하면 2000년 이후 출생자는 오류데이터가 됨
-- 조건에 따라서 1900또는 2000을 플러스 해줘야 한다.
-- 검색어: 오라클 조건에 따라서    -> decode함수 찾음->사용
select substr(reg_num,8,1) from muser;
select substr(reg_num,8,1) a,
       decode (substr(reg_num,8,1),'1',1900,'2',1900,2000) b
from muser;
select substr(reg_num,8,1) a,
       decode (substr(reg_num,8,1),'1',1900,'2',1900,2000) b,
       decode (substr(reg_num,8,1),'1',1900,'2',1900,2000)+substr(reg_num,1,2) c
from muser;
-- 최종 쿼리에 대입해 봅니다.
select name 이름, 
    (extract (year from sysdate))-
    (decode (substr(reg_num,8,1),'1',1900,'2',1900,2000)+substr(reg_num,1,2))나이, 
    salary 급여
from muser
where substr(reg_num,1,2)='77' and salary=(
    select min(salary)
    from muser
    where substr(reg_num,1,2)='77');
-- 오류 낼 수 있는 쿼리
select name 이름, min(salary) 
from muser 
where substr(reg_num,1,2)='77';     -- 에러원인은 다중행과 단일행

--7 남자의 평균 급여를 구하시오
select avg(salary)      --평균급여
from muser
where substr(reg_num,8,1) in('1','3');
        -- 남자? 컬럼으로 안된다. 수식이나 함수나 서브쿼리.. 함수와 수식 사용
--group by
--order by

