drop table users;
drop table carinfo;

create table users(
id varchar2(8), 
name varchar2(10), 
addr varchar2(10));

create table carinfo(
c_num varchar2(4),   --�ڵ��� ��ȣ
c_name varchar2(10),  -- �ڵ��� ����
id varchar2(8));
 
insert into users values ('1111','kim','����');
insert into users values ('2222','lee','����');
insert into users values ('3333','park','����');
insert into users values ('4444','choi','����');

insert into carinfo values ('1234','����','1111');
insert into carinfo values ('3344','����','1111');
insert into carinfo values ('5566','����','3333');
insert into carinfo values ('6677','����','3333');
insert into carinfo values ('7788','����','4444');
insert into carinfo values ('8888','����','5555');

select * from users;
select * from carinfo;

commit;

--�� �ڷḦ ȸ���� ����� �ڵ��� �����̴�.
--1. ȸ���� �̸��� �ּҸ� ����Ͻÿ�.
select name �̸�, addr �ּ� from users;

--2. ȸ���� �̸��� ������ �ڵ��� ��ȣ�� ����Ͻÿ�.
-- �ڵ��� �ִ� ȸ����
select u.name,c.c_num
from users u, carinfo c
where u.id=c.id;

--�ڵ��� ���� ȸ����
select a.name �̸�, b.c_num �ڵ�����ȣ 
from users a
left outer join carinfo b
on a.id=b.id;

--3. �ڵ��� ��ȣ�� 7788�� �������� �̸��� �ּҸ� ����Ͻÿ�.

-- ù��°���. ������ �ؼ� �������� 7788�� �ڵ����� �������� ������ ��� > ����
select u.name, u.addr
from users u, carinfo c
where u.id=c.id and c.c_num='7788';

-- �ι�°���. 7788�������� ȸ�����̵� �˻��� �� ������� �� ������ ���� > ��������
select name �̸�, addr �ּ�
from users
where id=(
select id from carinfo where c_num='7788');

--4. �ڵ����� �������� ���� ����� �̸��� �ּҸ� ����Ͻÿ�.

-- �̸��� �ּҴ� users // �ڵ����� �������� ���� ����̶�� ����
--      carinfo ���̺��� ������ ����.. �̳�����, �ƿ�������..

-- ������ �� �ؼ��ϸ� �� Ʃ�ÿ��� �̸��� ������, 
-- �ڵ����� ���õ� �׸��� null�ΰ��� ã�ƾ����� �Ǵ��� �� ����
-- (users���̺��� carinfo�� left join���� ����)

-- 1�ܰ�. �ƿ��������� ���� �������� ���� Ʃ��(null��)�� Ȯ��
select u.*, c.*
from users u
left outer join carinfo c
on u.id=c.id
where c_name is null;

-- 2�ܰ�. ���ϴ� ������ ���
select a.name �̸�, a.addr �ּ�
from users a
left outer join carinfo b
on a.id=b.id
where c_num is null;
-- left outer join�� �Ʒ��� ���� ������ε� ��Ÿ�� �� ����
select u.name �̸�, u.addr �ּ�
from users u, carinfo c
where u.id = c.id(+) and c_name is null;

--5. ȸ���� ����� �ڵ��� ���� ����Ͻÿ�.
select a.name ȸ��, count(*) �ڵ�����
from users a
inner join carinfo b
on a.id=b.id
group by a.name;
-- ����: ���������� ���� ������ u.id�� �׷��� ����.

select a.name ȸ��, count(*) �ڵ�����
from users a
inner join carinfo b
on a.id=b.id
group by a.id;
-- ����: select�� a.name�� �������̿��� ��½� �����߻�
--  -> id�� name�� �ϳ��� �Ӽ����� �����Ͽ� �׷�ȭ����(group by�� ���ռӼ����� ��������)

select a.name ȸ��, count(*) �ڵ�����
from users a
inner join carinfo b
on a.id=b.id
group by (a.id,a.name);
-- ����: 0�븦 ����� ȸ���� �ƿ� ����� �ȵǴµ�, ��� ȸ���� ���ؼ� �ڵ����� �˰�ʹ�.
-- null���� �ִ� Ʃ���� ī��Ʈ ���ϴ� ����� ���� �˻�
-- count(Ư���÷�)�� ����ϸ� �� �÷����� null���� ī��Ʈ ���� ���� �� ����
-- �ذ� �� ���� ���ۼ�(�ڵ������� 0���� �͵� ���� �� �ֵ���..)

-- ����
select a.name ȸ��, count(b.c_num) �ڵ�����
from users a
left outer join carinfo b
on a.id=b.id
group by (a.id,a.name);

--6. 2�� �̻��� ������ ȸ���� �̸��� ������ �ڵ��� ���� ����Ͻÿ�.
select a.name ȸ��, count(*) �ڵ�����
from users a 
right outer join carinfo b
on a.id=b.id 
group by (a.id, a.name) having (count(*)>=2);

--7. �ڵ����� ��ϵǾ� �ִµ� �����ڰ� ���� �ڵ��� ��ȣ�� ����Ͻÿ�.
-- ��, ���� ���� ���̺�� ���߿� ���� ���̺��� ������ ���..
-- ���� ���� ���̺��� carinfo, �ι�°�� ���� ���̺��� users
-- �ڵ����� ��ϵǾ� �ִµ� �����ڰ� ������? �̳�����
-- �̳����ο� �������� ���ϴ� Ʃ���� ���Ѵ�.. �ƿ�������..
-- �ƿ��� �����϶��� � ���̺��� left�� �� ���ΰ�?? ù��° left�� ����
select a.c_num �ڵ�����ȣ
from carinfo a
left outer join users b
on a.id=b.id
where b.id is null;

-- �ٸ�ǥ��
select c.c_num �ڵ�����ȣ
from carinfo c, users u
where c.id = u.id(+) and u.id is null;

-- ���� ���ʹ� 3�� ���̺��� �����ϴ� �����Դϴ�.

-- companycar ȸ�翡�� ������ �ڵ����� �ǹ�, 
--carinfo�� �������� ������ �ڵ���

--���� ���̺��� �����Ͻÿ�.
create table companycar(     -- �ڵ��� ����
c_num varchar2(4),   -- ����ȣ
c_com varchar2(30), 
c_name varchar2(10),  -- ���̸�
c_price number);  -- �� ����

--���� Ʃ���� �����ϼ���
insert into companycar values ('1234','����','�ҳ�Ÿ',1000);
insert into companycar values ('3344','���','����',2000);
insert into companycar values ('7788','���','��2',800);
insert into companycar values ('9900','����','�׷���',2100);
select * from companycar;
commit;

--8. ���� �ڵ����� ����ȣ, ������, �ڵ�����, ������ ����Ͻÿ�.

-- carinfo ���� �ڵ����� ������ ����... ����ȣ�� carinfo�� �ذ��� ����������
-- ������� �ڵ������ ������ companycar ���̺� ���� -> �̳�����
select b.c_num ����ȣ, a.c_com ������, a.c_name �ڵ�����, a.c_price ����
from companycar a, carinfo b
where a.c_num = b.c_num;

--9. ȸ�翡�����Ŵ� �Ͽ����� �������� ���� �ڵ����� ����ȣ, ������, �ڵ��� �̸��� ���
select b.c_num, b.c_com, b.c_name
from carinfo a
right outer join companycar b
on a.c_num=b.c_num
where a.id is null;

--10. �ڵ��� ������ 1000���� �̻��� �ڵ����� �ڵ��� ��ȣ�� ����Ͻÿ�.
select c_num �ڵ�����ȣ
from companycar
where c_price>=1000;

--11. ������ �ڵ��� �߿� ȸ�翡�� ������ �ڵ����� �ƴ� �ڵ��� ��ȣ�� ����Ͻÿ�.
select a.c_num �ڵ�����ȣ
from carinfo a
left outer join companycar b
on a.c_num=b.c_num
where b.c_com is null;

--12. ��� ����� ������ ����Ͻÿ�. �̸�, �������� �ڵ�����ȣ, �ڵ����̸�
select e.name �̸�, r.c_num �ڵ�����ȣ, r.c_name �ڵ����̸�
from users e
left outer join 
(select a.c_num, b.c_name, a.id
from carinfo a
left outer join companycar b
on a.c_num=b.c_num) r
on e.id=r.id;
