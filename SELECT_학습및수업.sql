--릴레이션: HM
--NO   NAME   POINT   ADDR          -> <<테이블 설계>>
-- 1    홍길동     30      서울시
-- 2    일지매     50      수원시
-- 3    이지매     40      서울시
--<<튜플 조작>>
--
--1번문제. 점수가 50미만인 회원수(릴레이션, 튜플, 컬럼 사용)
--: 릴레이션에서 점수를 나타내는 컬럼의 값이 50미만인 튜플의 갯수
--: 1. 뽑아내야할 데이터에 따라 릴레이션, 튜플, 컬럼을 어떤 순서로 분석할 것인가를 결정(릴레이션->컬럼->튜플)
--2. 컬럼에서 어떤 값을 뽑아낼 것인가(point)
--3. 회원수를 뽑아낼 것(집계의 기능/ 최고값, 최소값, 평균치)
----> hm이라는 릴레이션에서 point 컬럼에서 50미만의 값을 조건으로 튜플을 찾아낸 다음에 집계함수를 써서 회원수를 카운트
--(집계함수를 쓰면 결과값은 1개만 출력됨) (최소값 OR 최대값 OR 평균값 OR ~한것의 갯수 등등->결과가 1개로 추려져서 나옴)
--
--
--2번문제. 점수가 50미만인 회원을 모두 출력(점수가 높은 순서대로(정렬))
--: 릴레이션에서 점수를 나타내는 컬럼의 값이 50미만인 튜플을 select하여 점수의 내림차순으로 나타냄
----> hm이라는 릴레이션에서 point컬럼에 50미만을 조건으로 걸어서 튜플을 찾아내서, 조건대로(높은 순서대로)정렬하기
--
--
--<SELECT절의 의미***>				      <1번 문제>	       	<2번문제>
--A. SELECT절 : 화면에 출력하고자하는부분을 정의                   COUNT()                  *
--B. FROM절 : 대상테이블(~로 부터 화면에 출력할거야를 의미)    HM			HM
--C. WHERE절 : 튜플 선정 조건                                           POINT<50   		POINT<50
--D. ORDER BY절 : 정렬							DESC
-----> 실행 순서**: B - C - A(바로 출력이 아니라, 출력 부분을 정의하기 때문, 어디출력할건지 알려줘) - D(정의 다음 정렬!)
--EX) SELECT ID,NAME FROOM MEMBER : 대상테이블은 MEMBER이고, 출력할 부분은 ID와 NAME이다.
--
--
--*** 오늘의 핵심: SELECT절의 의미 / 실행 순서 ***
--
--
--함수: 특정 기능을 가지고 있는 것.
--함수를 사용하는 것은 기능을 사용한 후 결과값인 리턴값을 구현하는 것.
--
--
--
--
---총정리-
--1. 테이블 관리 - CREATE TABLE, DROP TABLE, ALTER TABLE
--                  - 테이블(릴레이션), 속성(속성타입, 제약조건)
--	      - 타입 : INT, NUMBER, VARCHAR2, TIMESTAMP
--	      - 제약조건: 유일성(기본키, UNIQUE), NOT NULL, CHECK, DEFAULT
--	      - 키: 기본키 -> 유일성, NOT NULL,  인덱스형성(검색속도 향상 - WHERE절에서 사용)
--		    외래키 -> 컬럼 투 컬럼, 자식 릴레이션 컬럼이 부모 릴레이션의 컬럼을 참조한다.
--			(외래키 제약조건: CASCADE, SET NULL)
--	      - ERD: 개체와 개체의 관계 분석 1:1, 1:N, N:M 분석 후 테이블 형성
--
--테이블에 저장된 튜플의 조작
--
--
--
--삽입: INSERT
--
--갱신: UPDATE -> 특정 튜플을 선택하여 갱신하려면 WHERE절 사용
--
--삭제: DELETE -> 특정 튜플을 선택하여 삭제하려면 WHERE절 사용
--
--검색: SELECT -> 각 절의 의미를 암기, 절의 실행 순서 이해
--
--
--
--실행순서 / 절의 의미
--4	   SELECT절: 컬럼을 선택(별칭, 함수 등을 같이 사용할 수 있다.)
--1	   FROM절: 대상 테이블
--2	   WHERE절: 대상 테이블로부터 튜플을 선정할 조건
--3	   GROUP BY절: 그룹화
--5	   ORDER BY절: 출력할 때 정렬
----> 실행순서: FROM -> WHERE -> GROUP BY -> SELECT -> ORDER BY  **
--
--
--
--함수: 함수를 호출하고 함수의 기능을 실행하고 결과값을 리턴, 결과값을 리턴 받아서 처리한다.
--예를 들어, COUNT(*) 함수를 호출하면 튜플의 수를 카운팅하여 카운팅 결과값을 리턴한다.
--호출할 때 넘겨주는 값 -> 매개변수
--예를 들어서, CONCAT('이름','님')  일때, 함수는 CONCAT이고, 매개변수는 '이름', '님'(CONCAT은 2개만 가능)
--
--
--SELECT라는 '절'과 기능을 가진 '함수'가 합쳐져서(서로 다른 BLOCK이 합쳐져서, 따로따로 보기) 하나의 역할로 사용됨
--(즉, 함수는 어떤 절에서든 사용이 가능하다)  **

