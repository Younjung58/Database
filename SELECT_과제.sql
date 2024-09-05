create table users(
no int primary key,
name varchar2(10),
addr varchar2(10),
point number,
grade varchar2(1),
jumin varchar2(8));

insert into users values (1,'kimsu','suwon',99.12,1,'820405-1');
insert into users values (2,'leesu','suwon city',89.00,2,'970805-2');
insert into users values (3,'choihee','seoul',88.21,1,'910204-2');
insert into users values (4,'leesil','suwon',77.62,4,'850405-1');
insert into users values (5,'james','seoul',60.22,1,'871105-1');
insert into users values (6,'parksuji','suwon',90.12,3,'880405-2');
insert into users values (7,'kimrae','yougin',89.96,3,'820105-1');
insert into users values (8,'sangJin','youngin',99.31,3,'990420-2');
insert into users values (9,'Leechan','incheon',79.12,2,'970605-2');
insert into users values (10,'kimmi','incheon',79.92,1,'810505-1');
insert into users values (11,'ryusu','seoul',85.32,4,'861205-2');
insert into users values (12,'Gosu',null,82.13,4,'810715-1');

-- 설명: 2 5 6 8 9 10 11 15 16

--1. 모든 사람들의 이름과 점수와 생년월일을 검색하시오.  
select name, point, jumin from users;

--2. 80점 이상의 사람의 이름과 주소, 점수를 검색하시오.
select name, addr, point from users where point>=80;
--2번 왜이렇게 했는가?
--참조해야할 대상 테이블은 users(from)이고, 
--참과 거짓으로 튜플을 나누어 출력할 부분인가를 결정할 수 있는 조건은 점수가 80점 이상인가(where)이며,
--최종 출력하고자 하는 부분은 이름(name),주소(addr), 점수(point)이다.(select)

--3. 이름이 kim으로 시작되는 사람의 이름과 주소와 점수를 검색하시오.
select name, addr, point from users where name like 'kim%';

--4. 현재 점수에서 +10으로 보정한 점수를 출력하시오. 원본 데이터에 반영되지 않습니다.
select point+10 from users;

--5. 1학년의 점수를 +1점씩 올려서 출력하세요. (단, 원본 데이터에 반영되지 않습니다.)
select point+1 from users where grade=1;
--5번 왜이렇게 했는가?
--참조해야할 대상 테이블은 users(from)이고, 
--참과 거짓으로 튜플을 나누어 출력할 부분인가를 결정할 수 있는 조건은 학년이 1학년인가(where)이며,
--최종 출력하고자 하는 부분은 점수를 1점씩 올린 것(point+1)이다.(select)

--6. B등급을 획득한 사람의 이름, 주소, 점수를 출력하세요 (B등급 80점 이상 90점 미만입니다)
select name, addr, point from users where point>=80 and point<90;
--6번 왜이렇게 했는가?
--참조해야할 대상 테이블은 users(from)이고, 
--참과 거짓으로 튜플을 나누어 출력할 부분인가를 결정할 수 있는 조건은 점수가 B등급인가,
--즉 점수가 80점이상 90점미만인가(where)이며,
--최종 출력하고자 하는 부분은 이름(name),주소(addr), 점수(point)이다.(select)

--7. 쿼리 결과 중 NULL은 실제 입력하지 않은 값입니다.
--   주소를 입력하지 않은 학생의 이름과, 주소, 학년, 점수, 주민번호를 출력하세요
select name, addr, grade, point, jumin from users where addr is null;

--8. 4학년의 점수를 10%로 올린 점수를 계산하세요.(단, 원본데이터는 반영되지 않는다)
select point*1.1 from users where grade=4;
--8번 왜이렇게 했는가?
--참조해야할 대상 테이블은 users(from)이고, 
--참과 거짓으로 튜플을 나누어 출력할 부분인가를 결정할 수 있는 조건은 학년이 4학년인가(where)이며,
--최종 출력하고자 하는 부분은 점수를 10%올린 점수(point*1.1)이다.(select)

--9. 점수가 낮은 학생부터 출력하세요.  번호, 이름, 주소, 포인트
select no, name, addr, point from users order by point asc;
--9번 왜이렇게 했는가?
--참조해야할 대상 테이블은 users(from)이고, 
--참과 거짓으로 튜플을 나누어 출력할 부분인가를 결정할 수 있는 조건은 없으며(where절 없음),
--최종 출력하고자 하는 부분은 번호(no), 이름(name), 주소(add), 포인트(point)이다.(select)
--또한 이를 출력하고 하는 튜플의 순서(정렬)은 점수가 낮은순서부터이다.(점수의 오름차순,point asc)(order by)

--10. 학년을 오름차순으로 정렬하시오, 단 학년이 동일 할 경우 포인트가 높은 사람이 먼저 출력됩니다.
--    출력은 번호, 이름, 학년, 포인트
select no, name, grade, point from users order by grade asc, point desc;
--10번 왜이렇게 했는가?
--참조해야할 대상 테이블은 users(from)이고, 
--참과 거짓으로 튜플을 나누어 출력할 부분인가를 결정할 수 있는 조건은 없으며(where절 없음),
--최종 출력하고자 하는 부분은 번호(no), 이름(name), 학년(grade), 포인트(point)이다.(select)
--또한 이를 출력하고 하는 튜플의 순서(정렬)은 학년의 오름차순이며(grade asc-정렬1조건), 
--학년 동일경우 포인트의 내림차순으로 다시 정렬되어 나타낸다.(point desc-정렬2조건)
--이 두가지의 정렬을 같이 나타내는 방식은 , 로 연결하는 것이다(order by 정렬1조건, 정렬2조건)

--11. 현재의 점수에서 -10을 보정한 결과 80점 이상인 사람의 이름과 점수, 보정한 결과 점수를 출력하세요.?
select name, point, point-10 보정한결과 from users where point-10>=80;

--12. 2학년의 모든 학생을 출력하시오 . 출력 컬럼명은
--    이름 주소 학년으로 출력하시오. 여기서 이름은 name컬럼, 주소는 addr컬럼, 학년은 grade컬럼을 의미
select name 이름, addr 주소, grade 학년 from users where grade=2;


--추가문제  -- 오라클 함수를 검색해 보세요
--13. 학생은 총 몇명입니까? 
select count(*) from users;
--14. 1학년은 총 몇명입니까?
select count(*) from users where grade=1;
--15. 모든 학생의 이름과 학년을 출력하시오. 단 이름은 모두 소문자로만 출력하시오. 
select lower(name), grade from users;
--15번 왜이렇게 했는가?
--참조해야할 대상 테이블은 users(from)이고, 
--참과 거짓으로 튜플을 나누어 출력할 부분인가를 결정할 수 있는 조건은 없으며(where절 없음),
--최종 출력하고자 하는 부분은 이름(name), 학년(grade)이다.(select)
--단, 이름은 출력할 때(select) 소문자로만 출력해야 하는데, 이는 수식으로 불가능하다.
--이를 가능하게 해주는 함수는 lower(name) 이다.

--16. 2학년 학생의 이름과 학년, 주소를 출력하시오. 보안을 위해서 주소는 앞글자 2글자만 출력하시오.
select name, grade, substr(addr,1,2) 주소 from users where grade=2;
--16번 왜이렇게 했는가?
--참조해야할 대상 테이블은 users(from)이고, 
--참과 거짓으로 튜플을 나누어 출력할 부분인가를 결정할 수 있는 조건은 학년이 2학년인가(grade=2)(where절),
--최종 출력하고자 하는 부분은 이름(name), 학년(grade), 주소(addr)이다.(select)
--단, 주소를 출력할 때(select) 앞 2글자만 출력해야 하는데, 이는 수식으로 불가능하다.
--이를 가능하게 해주는 함수는 substr이며, 매개변수가 3개이고 사용법은 substr(대상,시작위치,추출갯수)이므로 
--적용하면 substr(addr,1,2)이다.

--17. 모든 학생의 점수의 일의 자리는 절삭하시오. - 반올림 없음 (단, 원본 데이터에 반영되지 않습니다.)
select trunc(point,-1) from users;
--18. 모든 학생의 점수를 반올림하여 출력하시오. (단, 원본 데이터에 반영되지 않습니다.)
select round(point) from users;
--19. 2학년은 모두 몇명입니까?
select count(*) from users where grade=2;
--20. 1학년중 80점 이상은 몇명입니까?
select count(*) from users where grade=1 and point>=80;
--21. 3학년의 평균은 몇점입니까?
select avg(point) from users where grade=3;
--22. 전체 학생 중 최고점은 몇점입니까?
select max(point) from users;
--23. 2학년 중 가장 낮은 점수를 획득한 점수는 몇점입니까?
select min(point) from users where grade=2;

--못푸는 문제
--24. 보안을 위해서 주소를 모두 출력하지 않고 앞의 세 글자만 출력하고 뒤에 *를 하나 붙힌다.
--   (단, 원본 데이터에 반영되지 않습니다.)
--   예)suwon  >> su*
select concat(substr(addr,1,2),'*') 보안주소 from users;
--25. 이름의 맨 앞에 *를 맨 뒤에도*를 붙혀서 출력한다. (단, 원본 데이터에 반영되지 않습니다.)
select concat(concat('*',name),'*') 이름 from users;
--26. 생년월일을 그대로 출력하지 말고
--    xx 년  xx 월 xx 일 형식으로 출력한다. (단, 원본 데이터에 반영되지 않습니다. 성별은 무시한다)
select '19'||concat(substr(jumin,1,2),'년')||' '||concat(substr(jumin,3,2),'월')||' '||concat(substr(jumin,5,2),'일') 생년월일 from users;
--27. 이름, 포인트, 학년, 생년월일, 성별을 추가한다. 성별은 생년월일로 판단하며 마지막 숫자가1이면 남
--    2이면 여라고 표시한다. 
select name 이름, point 포인트, grade 학년, 
       '19'||concat(substr(jumin,1,2),'년')||' '||concat(substr(jumin,3,2),'월')||' '||concat(substr(jumin,5,2),'일') 생년월일,
       case when substr(jumin,8,1)='1' then '남' 
            when substr(jumin,8,1)='2' then '여'
            end as 성별
from users;