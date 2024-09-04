--JOIN: �Ѱ� �̻��� ���̺��� �������� ��ġ�� ����
--(���� �����ϴ� ��, �������� �ʴ� �� ->������ / ��� �����ϴ� �� -> ����)
--: � �÷��� �������� ��ĥ ���ΰ�,,
--���̺� 1: �л�
--NO	NAME	TEL
--1	ȫ	1111
--2	��	2222
--3	��	3333
--
--
--���̺� 2: ����
--�л�NO	����	����
--1	JAVA	70
--1	HTML	80
--3	JAVA	90
--
--
--Q. 1�� �л��� �̸��� ����� ������ ���
--**
--1 FULL JOIN : ���δ� JOIN�ؼ� ����� ����� ��(A���̺� ROW��*B���̺� ROW��)
--SELECT A.NAME, B.����, B.����
--FROM �л�A, ���� B
--WHERE
--
--
--2 INNER JOIN : ����� �Ӽ��� ��� JOIN�ϴ� ��(������ ���� �� ���� �͸� JOIN)
--SELECT A.NAME, B.����, B.����
--FROM �л�A, ���� B
--WHERE A.NO=B.�л�NO
--
--
--** TABLE�� ��� ��ġ
--FORM�� ���� ���̺��� LEFT TABLE
--JOIN�� ���� ���̺��� RIGHT TABLE��
---> �������,
--select s.no, s.name, p.no, p.e_name, p.e_point
--from sstu s     (--> left table�� from���� �ڸ���)
--inner join pp p    (-- right table�� join�ڸ���)
--on s.no = p.no;
--
--
--3 OUTER JOIN : �̳����� + ���ο� �������� ���� Ʃ�ñ��� ����� �� ���
--��ġ�� ���� LEFT OUTER JOIN / RIGHT OUTER JOIN���� ��������
--���ǿ� ���� ���� Ʃ���� '���̺� 1�� ����(LEFT) -> ���̺� 2�� ����(RIGHT)�� JOIN' �Ѵٸ� 'RIGHT OUTER JOIN'
--���ǿ� ���� ���� Ʃ���� '���̺� 2�� ����(RIGHT) -> ���̺� 1�� ����(LEFT)�� JOIN' �Ѵٸ� 'LEFT OUTER JOIN'

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

-- join: �Ѱ� �̻��� ���̺��� �������� ��ġ�� ��
-- ����
-- full join: �ΰ��� ���̺��� ��� ��ġ�� ��
--            ����� n*m�� ����ŭ ������ �Ǿ� Ʃ���� ���������.
-- inner join: ������ �����Ѵ�. ���ǿ� ���� ��츸 �����Ѵ�.
--             ������ �����̳�����(==), �񵿵��̳�����(!=)�� �ִ�.
-- outer join: �̳����� + ���ο� �������� ���� Ʃ�ñ��� ���
--             ������ ���̺� ������ ��ġ�� ���� 
--             left outer join, right outer join
-- ������ ���� / �ٽ��� '� ���̺��� �����ұ�? � ������ ����ұ�?'

-- ���� FULL JOIN�غ���.. ���� ���������� ��������!. �ӵ� ������.
select * from sstu,pp;

select s.no, s.name, p.no, p.e_name, p.e_point
from sstu s, pp p;

-- INNER JOIN(�����̳�����)
select s.no, s.name, p.no, p.e_name, p.e_point
from sstu s, pp p
where s.no = p.no;
  -- �����̳������� ������ ���� ǥ����� �ִ�.(inner join - on)
select s.no, s.name, p.no, p.e_name, p.e_point
from sstu s     -- left table�� from��
inner join pp p     -- right table�� join�ڸ���
on s.no = p.no;

-- OUTER JOIN
select s.no, s.name, p.no, p.e_name, p.e_point
from sstu s
left outer join pp p        -- left outer join / left table : sstu
on s.no = p.no;
-- join�� �����ȵ� �÷��� null�� ����

select s.no, s.name, p.no, p.e_name, p.e_point
from sstu s
right outer join pp p        -- right outer join / right table : pp
on s.no = p.no;

-- �ǽ�
-- ������ �� �л����� �̸��� ����� ������ ����Ͻÿ�
-- 2���� ���̺��� ���ľ� ���� // ����.. �׷��� ���� �÷��� ��ġ�� -- �̳�����
select s.name, p.e_name, p.e_point
from sstu s, pp p
where s.no = p.no;
-- ȫ�浿�� �̸��� ����� ������ ����Ͻÿ�. �̳����� �ʿ�
select s.name, p.e_name, p.e_point
from sstu s, pp p
where s.no = p.no and s.name='hong';
-- ������ ġ���� ���� �л����� �̸��� ����Ͻÿ�.
-- �̳����ο� �������� ���� Ʃ���� �����̹Ƿ� �ƿ��� ����
-- 1. left outer join�ذ�
select s.name
from sstu s
left outer join pp p
on s.no = p.no
where p.no is null;

-- ����
-- JOIN�� ����
-- JOIN�� ����
-- ������ ������ ���� ����ϴ���? ����...