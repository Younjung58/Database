# Database
<img src="https://img.shields.io/badge/database-20232a.svg?style=for-the-badge&logo=database&logoColor=61DAFB" />
<h3>고찰</h3>
<div>
<pre>
배운 내용들을 학습하고, 그러한 내용을 바탕으로 매일 실습을 하면서 중요하다고 느낀 부분
	1. select절이 각각이 의미하는 내용들을 정확하게 알아야 함
	2. 각 절이 사용되는 순서를 정확히 알아야함
이 두가지를 정확히 알아야 주어진 문제에서 어떤 부분을 어떤 절에 적용해야하는지 유연하게 생각이 가능하였다.
예를 들어 같은 조건이라도, where은 튜플을 선택하는 조건이고 having은 group by에서 그룹을 선정하는 기능을한다.
또한 where절이 먼저 이루어지고, 그 후에 group by->having의 순서로 select절의 순서가 진행된다.
ex) 등급의 그룹별로 평균 중에서 전체평균보다 높은 평균인 그룹만을 출력하시오
위와 같은 문제에서 '전체평균보다 높은 평균'만 보게 된다면 단순하게 조건으로 생각할 수 있지만,
(전체를 등급이라는 그룹으로 묶을 것)  
	: 즉, 여기에서는 from으로 가져오는 릴레이션의 전체 튜플이 대상이므로 where의 조건은 없다.
-> (그룹별로 평균을 계산하여 출력할 것)
	: 즉, 전체 튜플을 등급이라는 group으로 묶어서 평균을 계산하는 함수를 사용할 것이다.
-> (그 평균이 전체평균보다 높은 평균임을 참과 거짓으로 판별)
	: 즉, group의 출력 조건을 따질 수 있는 having을 사용
   .
   .
   .
이런식으로의 사고과정을 가능하게 하기 위해서는 저 두가지의 내용을 확실히 알아야 할 것이며
이러한 기본기를 탄탄하게 해야 더 복잡한 쿼리의 작성 및 이해가 가능할 것이라고 생각한다.
</div>
</pre>
<hr>
<pre>
<div>
JOIN을 배우면서 느낀것.
-> 테이블은 데이터의 중복을 최소화하여 무결성이 깨지는 것을 방지하기 위하여 분리한다.(정규화 과정)
   그렇게 분리한 하나 이상의 테이블을 JOIN을 이용하여 합치는 것인데, 테이블간 연결고리를 잘 찾아서 필요한 정보끼리 합치는 것이 중요하다.
   기준점으로 어떤 테이블의 어떤 값을 잡느냐에 따라서 결과가 완전 달라질 수 있다는 것을 실습을 통하여 깨달았다.
   	(예로, OUTER JOIN시에 RIGHT로 JOIN할것이냐 / LEFT로 JOIN할것이냐에 따라서 JOIN되지 않는 부분이 달라지기에, NULL값의 위치도 달라진다.)
   따라서 어떤 것을 기준점으로 잡아서, 어떤 내용으로 테이블을 만들 것인지(NULL값인 부분도 연결해서 새로운 테이블을 생성할 것인지) 등을
   쿼리 작성 전에 계획을 잘 짜야할 것 같다. 
   또한 3개 이상의 테이블을 JOIN해야 하는 상황에도, JOIN하는 순서에따라서 쿼리가 달라질 수 있기에 서브쿼리로 어떤 테이블을  만들것이며,
   그러한 테이블의 어떤 값으로 다른 테이블과 JOIN시에 사용할 수 있을지에 대해서도 구조를 잘 생각해야 할 것같다.
   실습을 계속하다보니 쿼리를 작성할 때 SELECT문의 구조와 순서에 대해 잘 알고 작성하는 것이 얼마나 중요한지 더 많이 느껴진다.
	(JOIN으로 가져온 테이블을 WHRER의 어떤 조건으로 튜플을 선정하고, SELECT로 그 튜플 중 어떤 부분을 출력할건지...등등)
</div>
</pre>
<h3>학습</h3>
<h4>-DB 학습(24.08.26)-</h4>
<pre>
DB(DataBase) : 자료를 영구적으로 저장하는 것   -> 정형 데이터, 비정형 데이터로 나뉨
그 중 정형데이터인 "관계형데이터베이스"--도구(정보를 훨씬 더 빠르고 편리하게 저장가능하게 도와주는 도구임)
---> Oracle(우리가 사용할 프로그램), Mysql, Maria(프로젝트시 사용 권장), Mssql   이 관계형데이터베이스 프로그램

ex) 저장할 자료: 고객의정보(릴레이션 이름)
	<표 - 전체: 릴레이션>
 번호(숫자)   /   이름(문자)  / 나이   / 주소  / 전화번호  를 정의해서 저장함
1                홍길동        37      수원     1111     ->  행 1
2                김길수        25      서울     2222     ->  행 2
3                홍길동        34      대전     3333     ->  행 3
(열1)	         (열2)       (열3)    (열4)    (열5)
-> 한글에 저장하면, 한글로 데이터베이스를 만든것.
    엑셀  ,,           , 엑셀로    ,,
<div>
- 관계형 데이터베이스 용어 -
릴레이션(테이블)---> 표 전체를 릴레이션(테이블)이라고 함
    -> 이러한 릴레이션은 행(로우, 3줄-> 분류기준인 줄은 행으로 포함X)과 열(컬럼, 5개)로 만들어짐.
    -> 행(로우)은 '저장할 대상의 자료'(의미있는 데이터만 행이라고 함. 즉 위에 항목은 포함 안되는 이유)
    -> 열(컬럼)은 '의미'를 가짐  -> 컬럼은 한글아니면 숫자를 지정할 수 있음
	-> ****** 즉, 컬럼에 속성과 제약조건(들어가는 값을 디테일하게 설정)을 지정할 수 있음 ******
	      (예를 들어 속성은 숫자로,
		제약조건은 not null(반드시 입력해야함) /
			  check(체크항목) /
		   	  unique(하나의 값만 가져야함-번호)->딱 하나의 값만 찾아내기 위한 값...
                   이런식)
    	-> + - 필요하면 숫자  /  필요없으면 문자로..   (예를 들어 전화번호의 경우는 덧셈.뺄셈 필요없으므로 문자로 지정 O)
    -> 무결성 위배: 결함이 없어야하는데 결함이 생김을 의미
          (예를들어 번호 3을 가진 사람이 2명 생긴 경우  ...  신뢰성이 깨졌다!)

-> 테이블을 만든다는 것은 컬럼을 만든다는 것을 의미함
    (로우가 없어도, 컬럼만 있는 테이블이 될 수 있음)
    (반대로 컬럼이 없고, 로우만 있다면, 테이블이 될 수 없음 -> 분류기준을 알 수 없음)
</div>
<div>
- 명령어 -
생각해낸 정보들로 테이블을 만드는 것 -> 개념적인 모델링
Create table :  내가 개념적으로 생각한 테이블을 실제로 만들거야.
-> Create table 고객의 정보(릴레이션 이름)	-> 실제로는 절대 한글로 입력하면 안됨! 영어로!)
    (컬럼명 속성 제약조건)
    번호 number unique key,    		-> 컬럼 1(중복불가)
    이름 varchar2(6)	 not null,    		-> 컬럼 2(6바이트, 한글 3글자까지 가능)(반드시 입력)
    나이 number(2)	defalut 1,    		-> 컬럼 3(두자리까지 가능)(처음부터 1의 값으로 시작)
    주소 varchar2(50)    	     	     	-> 컬럼 4(50바이트, 한글 25글자까지 가능)
);
</div>
</pre>
</hr>
<h4>-DB 학습(24.08.27)-</h4>
<pre>
<div>
CRUD(table에 CRUD작업을 하는 것)
-> C : row insert
-> R : row select
-> U : row update
-> D : row delete
    ↑  서버에서 처리해서 DB로
서버(java)
    ↑  서버로 데이터 전송
게시판(View) : 글쓰기(C), 글수정(U), 글삭제(D), 검색(S), 전체보기(S), 좋아요 누르기(C), 추천하기(C)

DB -> 정형(테이블과 같은 형태가 존재하는 데이터 / 사용하는 프로그램 : oracle, mysql,maria,mssql)  
         vs 비정형

테이블 -> 행(row)은 CRUD와 관련, 열(column)은 속성과 제약조건과 관련
         -> 키 : 컬럼에 부여하는 기능(기본키, 외래키)\

** 컬럼에 제약조건을 거는 것과, 어떠한 기능을 부여하는 것인 키와 다름

기본키 : 튜플(row)을 유일하게 식별할 수 있음,
           기본키로 index(색인)(검색속도가 향상)를 형성하여 저장함,
           null이 불가(즉, not null을 포함)함.
</div>
<div>
이름	 주소	 전화번호
홍길동     서울	  1111
일지매	 서울	  1111
홍길동	 수원	  2222

-> 이러한 테이블의 경우 문제점찾아보기
: update나 delete의 경우, 튜플을 유니크하게 식별하지 못하기 때문에 각 이상현상이 발생함.
-> 하지만 각각의 컬럼에 제약조건을 unique로 하게되면, 너무 제한적이여서 문제가 발생함
-> 유니크한 값인, 즉 고유한 ID와 같은 항목으로 컬럼을 하나 더 만들어서 이러한 문제를 해결할 수 있음
-> 튜플을 유니크하게 식별하기 위함,,
-> 테이블작성시 신경써야할 부분 : 갱신이상(이상현상)을 고려** + 쿼리의 속도가 빨라야함**
-> 이상현상은 unique가 해결할 수 있으며(유일성), 검색속도는 인덱스가 해결할 수 있음(속도향상).
---> 이러한 두가지 역할을 동시에 할 수 있는 것이 "기본키"임!!!!!!!!!  ★ ★ ★

create table m(
   ID varchar2(1) primary key,    ->  이런식으로 ID 에 기본키를 부여하여 코드를 작성할 수 있음
   name varchar2(2),
   add varchar2(10)
);

ex) 회사는 자동차를 등록한다. 한사람이 여러대 등록가능
 ID	이름	전번	카번호
 a	 홍	1111	  1
 a	 홍	1111	  2
-> 이상현상이 발생
-> unique값을 id에 부여하면 같은사람이 여러개의 차를 등록할 수 없음

테이블 설계시에, 이상현상을 고려(-> 1. 유일성을 보장 / 2. 데이터의 중복을 최소화 -> 정규화를 진행)
-> 테이블을 분리하여 작성 (정규화: 데이터 중복을 최소화하기 위해서!!!!★ ★ ★)
 1번테이블 (member,부모릴레이션)
 ID(기본키) 이름	전번
 a	   홍	1111
 b	   홍	2222

 2번테이블 (car, 자식릴레이션)
 카번호	ID(외래키)
  1	 a
  2	 a

-> 1번 테이블(member, 부모릴레이션) : ID(기본키로 지정) 이름 전번   -> 이렇게만 작성하여 데이터 중복을 막아줌
-> 2번 테이블(car, 자식릴레이션) : 카번호 ID(외래키) -> ID의 외래키로, 누구의 차인지 식별가능하게 해줌.(연관성부여)
    -> 외래키는 1번테이블의 ID를 참조한다.
    -> 자식릴레이션의 외래키로 지정된 컬럼은 부모릴레이션의 특정 컬럼을 참조한다.★ ★ ★(컬럼 to 컬럼)
</div>
</pre>
</hr>
<h4>-DB 학습(24.08.28)-</h4>
<pre>
<div>
ERD(프로젝트의 컨셉이 나오면 시나리오를 보고 이러한 데이터를 저장하기 위해 하는 것)
: E - 개체(독립적으로 존재할 수 있는 대상)
  / R - 관계 (개체와 개체가 가지는 관계, 혼자 독립할 수 없는 것을 의미)
  / D - diagram
: '개념적 설계'에 해당 (이 다음에 논리적(테이블 명세서)->물리적 단계(쿼리문 작성)임)

시나리오에서 독립적으로 존재할 수 있는 것
-> 개체 (하지만, 개체가 테이블과 같다는 말은 틀림)
     (테이블을 만들기 위한 과정으로, 도식화의 과정임. 즉 이 단계에서는 테이블이 존재하지 않음)
     (도식화된 개체가 테이블로 형성되지 못할 수 있음)

ex1) 고객의 출석에 대해서 관리하고 싶다(출석은 고객없이 독립적으로 존재할 수 없다-관계)
    고객(개체)  -  id(밑줄-기본키)   name    (속성값 2개, attribute)
        |
   <다이아몬드 - 출석>     -> 두 개체간의 관계성을 찾는 것.
        |  
    출석대장(개체) - 시간


ex2) 교수(id, 이름)는 논문을 작성. 논문은 작성일 아이디만 저장.
   교수(개체) - 아이디(밑줄-기본키)   이름    (속성값 2개, attribute)
        |
  <다이아몬드 - 작성>     -> 두 개체간의 관계성을 찾는 것.
        |  
   논문(개체) - 작성일  아이디 / 번호(unique한 속성필요)
</div>
<div>
-관계의 종류  --> 1:1 , 1:N, N:M
1:1의 관계에서는 굳이 테이블을 나누지않고, 하나의 테이블로 작성.
1:N이면, 1인 테이블이 부모, N의 테이블이 자식.
N:M이면, 각각 개체에 대한 테이블(총 2개)과,
            관계에 대한 테이블을 자식테이블로 작성(외래키 2개)(이 테이블의 단독적인 기본키 하나 추가로 생성)

--관계에도 속성이 들어갈 수 있음(다이아몬드에도 동그라미의 속성 붙일 수 있음)
   -> 이 속성은 N의 테이블의 속성으로 테이블 작성

  <관계구도 정리해보기>

![image](https://github.com/user-attachments/assets/2bdccf34-b576-490c-b910-98ecfdecf88b)


외래키 지정-> 참조하고 있는 부모의 내용이 삭제되면
-> 그에 따라서 자식 릴레이션 내용도 삭제: '외래키 지정내용~~~' + on delete cascade
-> 그에 따라서 자식 릴레이션 내용 null: '외래키 지정내용~~~' + on delete set null
ex) costraint fk_reg_cus foreign key(reg_event) references customer(id) on delete cascade
     또는
    costraint fk_reg_cus foreign key(reg_event) references customer(id) on delete set null
</div>
</pre>
<hr>

<h4>해당 내용들로 프로젝트 진행(ppt완성)</h4>
(24.08.29~24.08.30)
<div>
https://www.canva.com/design/DAGPMF4D-NU/67YfwQBeHmBVP7LDnCz6NA/edit?utm_content=DAGPMF4D-NU&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton
<pre>
-프로젝트 진행 중 자식 릴레이션의 이름을 모르는 문제가 발생-

select fk.owner,fk.constraint_name,pk.TABLE_NAME parent_table,fk.table_name child_table
FROM all_constraints fk, all_constraints pk 
WHERE fk.R_CONSTRAINT_NAME=pk.CONSTRAINT_NAME AND fk.CONSTRAINT_TYPE='R' and pk.TABLE_NAME='MEMBER'
ORDER BY fk.TABLE_NAME;

-> 위 코드로 자식 릴레이션 이름 찾을 수 있었음
</div>
</pre>
