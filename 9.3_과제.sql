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

insert into muser values(muser_no.nextval,'870205-1','�̽���',1,10000,34);
insert into muser values(muser_no.nextval,'880405-1','������',2,20000,31);
insert into muser values(muser_no.nextval,'770715-2','���̼�',4,40000,32);
insert into muser values(muser_no.nextval,'010205-3','������',1,10000,30);
insert into muser values(muser_no.nextval,'810205-2','������',2,20000,34);
insert into muser values(muser_no.nextval,'820219-2','���¿�',3,30000,35);
insert into muser values(muser_no.nextval,'020205-3','�����',1,10000,30);
insert into muser values(muser_no.nextval,'970214-2','������',2,20000,31);
insert into muser values(muser_no.nextval,'040205-4','������',4,40000,31);
insert into muser values(muser_no.nextval,'770225-1','���翵',5,50000,30);
insert into muser values(muser_no.nextval,'770905-2','�̽ż�',4,40000,34);
insert into muser values(muser_no.nextval,'050208-3','�̹߲�',2,20000,30);
insert into muser values(muser_no.nextval,'051205-4','�̿���',1,10000,34);
insert into muser values(muser_no.nextval,'891215-1','���¾�',3,30000,30);
insert into muser values(muser_no.nextval,'670805-1','������',2,20000,34);
insert into muser values(muser_no.nextval,'840207-1','���̷�',1,10000,35);
insert into muser values(muser_no.nextval,'770405-1','��õ��',1,10000,31);

--1 grade�� 3�� ����� ��� ����ΰ���?
select count(*) from muser where grade=3;

--2 grade�� 1,2,4�� ������� salary�� ����� ���Ͻÿ�.
select avg(salary) salary��� from muser where grade=1 or grade=2 or grade=4;

--3 salary�� 20000 �̸��� ����� �� ����Դϱ�?
select count(*) from muser where salary<20000;

--4 salary�� 30000 �̻��� ����� salary ����� ���Ͻÿ�.
select avg(salary) salary��� from muser where salary>=30000;

--5 77����߿�  salary�� ���� ���� ����� �̸��� ���̿� salary�� ����Ͻÿ�.
--����
select name �̸�, min(salary) from muser where substr(reg_num,1,2)='77';
--��������: min�̶�� �Լ��� ����Ҷ� �Ű������� ������ salary���� �ְ�, �׿����� ���ϰ����� salary �ּҰ����� �����Ա⶧��
--   ��, name�� ���ǿ� �´� ��� �� salary�� �ּҰ��� �޾ƿ� ��, ���ϰ����� ���� �޾ƿ��� ���ϱ⶧���� 
--   DB�� ���忡���� �ش� salary�� ���ϴ� �̸��� ���̸� �����;��Ѵٴ� �ν��� ����. ���� '���ϱ׷��� �׷��Լ��� �ƴ�'�̶�� ������ �߻�.
--   �׷��⿡ �̿� ���� �ش�����, 
--   (������������ ���ϰ����� ���� salary�� �ش��ϴ� ����� �̸��� ���� - ������ 
--   / '77'����� �ش��ϸ�(where), ���߿��� �ּ�salary ���ϰ��� �޾� ������ ���̺�(b)- �������� �� �з��Ͽ� ������ ��)

--�ش�
select name �̸�, 
case when substr(reg_num,3,2)< to_char(sysdate,'MM') or (substr(reg_num,3,2) = to_char(sysdate,'MM') and substr(reg_num,5,2)<=to_char(sysdate,'DD'))
            then 124-substr(reg_num,1,2)
           when substr(reg_num,3,2)> to_char(sysdate,'MM') or (substr(reg_num,3,2) = to_char(sysdate,'MM') and substr(reg_num,5,2)>to_char(sysdate,'DD'))
            then 124-substr(reg_num,1,2)-1
      end as ���� ,
      salary �ּ�salary from muser a, 
(select min(salary) �ּ�salary from muser where substr(reg_num,1,2)='77') b
where a.salary = b.�ּ�salary and substr(reg_num,1,2)='77';

--6 ��� ����� �̸���, ����(���� �� ������� 0205)�� ����Ͻÿ�.
select name �̸�, substr(reg_num,3,4) ���� from muser;

--7 ������ ��� �޿��� ���Ͻÿ�.
select avg(salary) ������ձ޿� from muser where substr(reg_num,8,1)='1' or substr(reg_num,8,1)='3';

--8 ��ü ��ձ޿����� ���� �޿��� �޴� ����� �̸���, �޿��� ����Ͻÿ�
select name �̸�, salary �޿�
from muser
where (select avg(salary) from muser)<salary;

--9 ��ü ��ձ޿����� ���� �޿��� �޴� ����� �̸���, �޿�, ��ձ޿��� ����Ͻÿ�
--��ü ��ձ޿����� ���� �޿� �޴� ����� ��ձ޿�(��������)
select avg(salary) ��ձ޿�
from muser
where (select avg(salary) from muser)<salary; 
-- ��������
select name �̸�, salary �޿�, 
(select avg(salary)
from muser
where (select avg(salary) from muser)<salary) as ��ձ޿�
from muser
where (select avg(salary) from muser)<salary;

--10 �������� ��ձ޿����� ���� ���������� ��� ����Դϱ�
-- ������ ���(��������)
select avg(salary) ��������ձ޿� from muser where substr(reg_num,8,1)='2' or substr(reg_num,8,1)='4';
--��������
select count(*) from muser
where
(select avg(salary) ��������ձ޿� from muser where substr(reg_num,8,1)='2' or substr(reg_num,8,1)='4')<salary
and (substr(reg_num,8,1)='1' or substr(reg_num,8,1)='3');

--11 grade�� ��� �޿��� ����ϼ���..
select grade, avg(salary) ��ձ޿� from muser group by grade;

--12 �׷캰 ��ձ޿��� ��ü ��պ��� ���� �׷��� ����Ͻÿ�.
select grade from muser
group by grade
having avg(salary)>(select avg(salary) from muser);

--13 �������� ���� ������ ����Ͻÿ�. (��� ���´� �̸�, ����(grade*salary*time)
select name �̸�, (grade*salary*time) ����
from muser;

--14 �������� ������ ����Ͻÿ�. (��� ���� �̸�, ����(������ ���Ǵ� ���� ����Ѵ�)
select name �̸�,
case when substr(reg_num,8,1) = '1' or substr(reg_num,8,1)= '3' then '��'
    when substr(reg_num,8,1) = '2' or substr(reg_num,8,1) = '4' then '��' end as ����
from muser;

--15 time�� �ٹ��ð�, �ٹ��ð��� 31�̻��� ����� �̸��� ����Ͻÿ�.
select name �̸� from muser
where time>=31;

--16 ¦���⵵�� �¾ ������� �̸��� ��� ����Ͻÿ�.
select name �̸� from muser
where (mod(substr(reg_num,1,2),2)=0);

--17 �������� ��������� ����Ͻÿ�. (��� ���´� �̸��� �������(97��1��2��))
select name �̸�, 
(concat(substr(reg_num,1,2),'��'))||
(concat(substr(reg_num,3,2),'��'))||
(concat(substr(reg_num,5,2),'��')) �������
from muser;

--18 ���������� ���Ƹ� �����ϱ� ���� ��å���� time�� 2�ð������ϱ�� �ߴ�. �̸� ó�� �Ͻÿ�.
select id,reg_num,name,grade,salary,
case when substr(reg_num,8,1) = '1' or substr(reg_num,8,1)= '3' then time
    when substr(reg_num,8,1) = '2' or substr(reg_num,8,1) = '4' then time+2 
    end as ��åtime
from muser;

--19 ���̺� �ο����� ����Դϱ�
select substr(reg_num,1,2) �⵵, count(*) �ο��� 
from muser
group by substr(reg_num,1,2);

--20 2�г�׷�� 4�г� �׷��� ��� ����Դϱ�
select count(*)
from muser
where grade='2' or grade='4';

--
--
--�߰�����
--
--#1) ��� ����� �¾ �� ���ñ��� �� ���� �������� ����Ͻÿ�
--(�������: �̸�, �ֹι�ȣ, ���ݱ�����ƿ¿���)
select name �̸�, reg_num �ֹι�ȣ,
round(months_between(sysdate,substr(reg_num,1,6))) ���ݱ�����ƿ¿���
from muser;


-- ���ܷ�, �Լ������(�� �ۼ� ��� Ȯ��)
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
end as �� from muser;

--#2) time�� ���̷� ��. 30~31���� ��ƿ� ������ ��, 32�� �̻��� ��ƿ� ������ �� ���ϱ�
--����1
select sum(time*12) �����
from muser
where time<32;
--����2
select sum(time*12) ��������
from muser
where time>=32;
--��������
select
distinct(select sum(time*12)
from muser
where time<32) �����_31����,
(select sum(time*12)
from muser
where time>=32) ��������_32�̻�
from muser;

--#3) ���ɺ� �޿��� ��, over()�Լ� �̿�
select distinct(time) ����, sum(salary) over(partition by time) as ���� from muser;

--#4) ���ɺ� �ο���, over()�Լ� �̿�
select distinct(time) ����, count(*) over(partition by time) as ���ɺ��ο��� from muser;

--#5) ��޺� �޿��� �ְ�޿�, over()�Լ� �̿�
select distinct(grade) ���, max(salary)over(partition by grade) as �ְ�޿� from muser;

--#6) ���۰˻��Ͽ� ����Ŭ �Լ� ����
--1. trunc(10/3)  -> 10�� 3���� ���� ���� ���ϴ� �Լ�
--2. mod(10,3) -> 10�� 3���� ���� �������� ���ϴ� �Լ�
--3. substr(�Ű�����, ������ġ, ���ⰹ��)  -> substr('abcd',1,2)�� ����� 'ab'
--4. avg(�÷���) -> �ش� �÷��� Ʃ�ð��� ����� ���ϴ� �Լ�
--5. months_between(��¥1, ��¥2) -> �� ��¥ ������ '��'�� ���̸� ������
--6. distinct(�÷���) -> �ش� �÷����� �ߺ��Ǵ� ���� �ѹ��� ���
--7. over() -> order by, group by ���������� �����ϱ� ���� �Լ���,
--             count(*)/max(�÷�)/sum(�÷�) ... over(partition by ~) �̷������� ����
--             ������ �׷��� over ������ �Լ������� �ش� �� ����Ǿ� ����� ���ϵȴ�.
--             count(*)/max(�÷�)/sum(�÷�) ... over(order by ~ asc/desc)
--             �̷������� ���� �ۼ��� ������ over ������ �Լ����� �ش� �� ����Ǿ� ����� ���ϵȴ�.