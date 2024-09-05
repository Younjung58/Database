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
   그렇게 분리한 하나 이상의 테이블을 JOIN을 이용하여 합치는 것인데, 
   테이블간 연결고리를 잘 찾아서 필요한 정보끼리 합치는 것이 중요하다.
   기준점으로 어떤 테이블의 어떤 값을 잡느냐에 따라서 결과가 완전 달라질 수 있다는 것을 실습을 통하여 깨달았다.
   (예로, OUTER JOIN시에 RIGHT로 JOIN할것이냐 / LEFT로 JOIN할것이냐에 따라서 
	JOIN되지 않는 부분이 달라지기에, NULL값의 위치도 달라진다.)
   따라서 어떤 것을 기준점으로 잡아서, 어떤 내용으로 테이블을 만들 것인지
	(NULL값인 부분도 연결해서 새로운 테이블을 생성할 것인지) 등을
         쿼리 작성 전에 계획을 잘 짜야할 것 같다. 
   또한 3개 이상의 테이블을 JOIN해야 하는 상황에도, JOIN하는 순서에따라서 쿼리가 달라질 수 있기에 
	서브쿼리로 어떤 테이블을  만들것이며, 그러한 테이블의 어떤 값으로 다른 테이블과 JOIN시에 사용할 수 있을지에 대해서도 
	구조를 잘 생각해야 할 것같다.
   실습을 계속하다보니 쿼리를 작성할 때 SELECT문의 구조와 순서에 대해 잘 알고 작성하는 것이 얼마나 중요한지 더 많이 느껴진다.
	(JOIN으로 가져온 테이블을 WHRER의 어떤 조건으로 튜플을 선정하고, SELECT로 그 튜플 중 어떤 부분을 출력할건지...등등)
</div>
</pre>
<hr>
<h3>프로젝트</h3>
<div>
<h4>1차 프로젝트 진행(핵심은 관계구도및 기본키, 외래키 사용)</h4>
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
<hr>
<h3>추가학습</h3>
<div>
프로젝트를 준비하며 관계구도에 대해서 정확한 이해가 필요하다고 생각하여 직접 그려보면서 추가학습.
	
<관계구도 정리>

![image](https://github.com/user-attachments/assets/2bdccf34-b576-490c-b910-98ecfdecf88b)

</div>
