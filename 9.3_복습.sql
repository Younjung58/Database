commit;

select * from muser;

--1 grade�� 3�� ����� ��� ����ΰ���?
select count(*)      -- ���ϴ� ���� �ο���.. �ο����� �÷����� �ذ� �Ұ�(�Լ����)
from muser     
where grade=3;      --grade 3�� ����� Ʃ���� ���� �����̶� �� �� ����

--2 grade�� 1,2,4�� ������� salary�� ����� ���Ͻÿ�.
select avg(salary)
from muser
where grade in(1,2,4);  --Ʃ��
--where grade=1 or grade=2 or grade=4;
--group by   --�׷��� ����: �׷캰 ������ ���
--order by

--3 salary�� 20000 �̸��� ����� �� ����Դϱ�?
select count(*)     -- ���ϴ� ���� �ο���.. �ο����� �÷����� �ذ� �Ұ�(�Լ����)
from muser
where salary<20000;
--group by
--order by

--5 77����߿�  salary�� ���� ���� ����� �̸��� ���̿� salary�� ����Ͻÿ�.
select   --�̸��� ���̿� salary
from muser
where    --77����߿�
--gruop by
--order by
/* 77��� ���� �׽�Ʈ ���� */
select substr(reg_num,1,2) from muser;  --�߰� �ܰ�
-- �������� ����...
select   --�̸��� ���̿� salary
from muser
where substr(reg_num,1,2)='77'    --77����߿�
/* 77��� ���� �׽�Ʈ ���� */
-- 77����߿�  salary�� ���� ���� ����� �̸��� ���̿� salary�� ����Ͻÿ�.
-- 77����߿��� ���� ���� salary �̾� ������.
select min(salary)
from muser
where substr(reg_num,1,2)='77';
-- ���� ���� salary�� �˸� ���� ���� salary�� ��������
-- ���� ���� salary�� �޴� ����� Ʃ���� ������ �� �ִ�.
select *
from muser
where substr(reg_num,1,2)='77' and salary=10000;
-- 10000�� ����� �����ϸ� �ȵȴ�. ���������� ����
select name �̸�, reg_num ����, salary �޿�
from muser
where substr(reg_num,1,2)='77' and salary=(
    select min(salary)
    from muser
    where substr(reg_num,1,2)='77');
-- ���̸� ����Ѵ�.. �׷��� �� ���ϴ� �ֹι�ȣ�� ���
-- �÷����� �ذ� �����Ѱ�? ����? �Լ�? �������� > ���İ� �Լ��� �ʿ�
select 1900+substr(reg_num,1,2) from muser;
select * from muser;
-- �м�: ����� 1900�� �����ϸ� 2000�� ���� ����ڴ� ���������Ͱ� ��
-- ���ǿ� ���� 1900�Ǵ� 2000�� �÷��� ����� �Ѵ�.
-- �˻���: ����Ŭ ���ǿ� ����    -> decode�Լ� ã��->���
select substr(reg_num,8,1) from muser;
select substr(reg_num,8,1) a,
       decode (substr(reg_num,8,1),'1',1900,'2',1900,2000) b
from muser;
select substr(reg_num,8,1) a,
       decode (substr(reg_num,8,1),'1',1900,'2',1900,2000) b,
       decode (substr(reg_num,8,1),'1',1900,'2',1900,2000)+substr(reg_num,1,2) c
from muser;
-- ���� ������ ������ ���ϴ�.
select name �̸�, 
    (extract (year from sysdate))-
    (decode (substr(reg_num,8,1),'1',1900,'2',1900,2000)+substr(reg_num,1,2))����, 
    salary �޿�
from muser
where substr(reg_num,1,2)='77' and salary=(
    select min(salary)
    from muser
    where substr(reg_num,1,2)='77');
-- ���� �� �� �ִ� ����
select name �̸�, min(salary) 
from muser 
where substr(reg_num,1,2)='77';     -- ���������� ������� ������

--7 ������ ��� �޿��� ���Ͻÿ�
select avg(salary)      --��ձ޿�
from muser
where substr(reg_num,8,1) in('1','3');
        -- ����? �÷����� �ȵȴ�. �����̳� �Լ��� ��������.. �Լ��� ���� ���
--group by
--order by

