-- 1. ������ �븮�̸鼭 ASIA������ �ٹ��ϴ� ��������
--    ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
--SOL.ORACLE 
SELECT * FROM EMPLOYEE;  -- EMP_ID  EMP_NAME, JOB_CODE          ,DEPT_CODE
SELECT * FROM JOB;       --                   JOB_CODE -->�μ���
SELECT * FROM DEPARTMENT; --                                     DEPT_TITLE -> ���޸�
SELECT * FROM LOCATION;  --                    
--<ORACLE>
SELECT E.EMP_ID, 
       E.EMP_NAME, 
       J.JOB_NAME , 
       D.DEPT_TITLE ,
       L.LOCAL_NAME ,
       E.SALARY
FROM EMPLOYEE E,
     JOB J,
     DEPARTMENT D,
     LOCATION L
WHERE E.JOB_CODE=J.JOB_CODE  -->> ���޸� ����.
 AND  DEPT_CODE=DEPT_ID      -->>�μ��� ����
 AND  LOCATION_ID=LOCAL_CODE -->>�ٹ������� ����
 AND  JOB_NAME ='�븮'
 AND  LOCAL_NAME LIKE '%ASIA%';

---ANSI---
SELECT EMP_ID, 
       EMP_NAME, 
       JOB_NAME , 
       DEPT_TITLE,
       LOCAL_NAME,
       SALARY
FROM EMPLOYEE
JOIN JOB USING    (JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION   ON(LOCATION_ID=LOCAL_CODE)
WHERE JOB_NAME ='�븮'
AND  LOCAL_NAME LIKE '%ASIA%';
    
-- 2. 70�����̸鼭 �����̰�, ���� ������ ��������
--    �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�
--<ORACLE>
SELECT E.EMP_NAME,
       E.EMP_NO,
       D.DEPT_TITLE,
       J.JOB_NAME
FROM EMPLOYEE E,
     DEPARTMENT D,
     JOB J
WHERE DEPT_CODE=DEPT_ID -->�μ��� ���
AND   E.JOB_CODE=J.JOB_CODE --> ���޸� ���
AND SUBSTR(EMP_NO,1,2)>=70 AND SUBSTR(EMP_NO,1,2)<80
AND SUBSTR(EMP_NO,8,1)=2 OR SUBSTR(EMP_NO,8,1)=4;


--<ANSI>
SELECT EMP_NAME,EMP_NO,DEPT_TITLE,JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE SUBSTR(EMP_NO,1,2)>=70 AND SUBSTR(EMP_NO,1,2)<80 
  AND SUBSTR(EMP_NO,8,1)=2 OR SUBSTR(EMP_NO,8,1)=4;

-- 3. �̸��� '��'�ڰ� ����ִ� ��������
--    ���, �����, ���޸��� ��ȸ�Ͻÿ�
--<ORACLE>
SELECT EMP_ID, 
       EMP_NAME, 
       JOB_NAME
FROM EMPLOYEE E,
     JOB J
WHERE E.JOB_CODE=J.JOB_CODE -->�μ� ���
AND EMP_NAME LIKE('%��%');

--ANSI
SELECT EMP_ID, 
       EMP_NAME, 
       JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE('%��%');

-- 4. �ؿܿ������� �ٹ��ϴ� ��������
--    �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
--<ORACLE>
SELECT EMP_NAME , 
       JOB_NAME , 
       DEPT_CODE, 
       DEPT_TITLE
FROM EMPLOYEE E,DEPARTMENT,JOB J
WHERE DEPT_CODE = DEPT_ID  -->�μ��� ��������
AND   E.JOB_CODE = J.JOB_CODE -->���޸� ��������
AND   DEPT_TITLE LIKE('%�ؿܿ���%');

--ANSI--
SELECT EMP_NAME , 
       JOB_NAME , 
       DEPT_CODE, 
       DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE DEPT_TITLE LIKE('%�ؿܿ���%');

-- 5. ���ʽ��� �޴� ��������
--    �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
--<ORACLE>
SELECT EMP_NAME, 
       BONUS, SALARY*12 ����, 
       DEPT_TITLE, 
       LOCAL_NAME
FROM EMPLOYEE,
     DEPARTMENT,
     LOCATION
WHERE DEPT_CODE=DEPT_ID --> �μ��� ���
AND   LOCAL_CODE = LOCATION_ID --> �ٹ�������
AND   BONUS IS NOT NULL;

--<ANSI>

SELECT EMP_NAME, 
       BONUS, 
       SALARY*12 ����, 
       DEPT_TITLE, 
       LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID)
WHERE BONUS IS NOT NULL;
--8ROWS
-- 6. �μ��� �ִ� ��������
--    �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
--<ORACLE>
SELECT E.EMP_NAME , 
       J.JOB_NAME ,
       DEPT_CODE  , 
       DEPT_TITLE , 
       LOCAL_NAME
FROM EMPLOYEE E,
     JOB J,
     DEPARTMENT D,
     LOCATION L
WHERE E.JOB_CODE=J.JOB_CODE --> ���޸� ���� DEPT_CODE(+)=DEPT_ID
  AND DEPT_CODE=DEPT_ID --> �μ��� ����
  AND LOCAL_CODE = LOCATION_ID
  AND DEPT_CODE IS NOT NULL;

--ANSI
SELECT EMP_NAME , 
       JOB_NAME ,
       DEPT_CODE  , 
       DEPT_TITLE , 
       LOCAL_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON(LOCAL_CODE=LOCATION_ID)
WHERE DEPT_CODE IS NOT NULL;


-- 7. '�ѱ�'�� '�Ϻ�'�� �ٹ��ϴ� �������� 
--    �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�
--<ORACLE>
SELECT EMP_NAME , 
       DEPT_TITLE ,
       LOCAL_NAME,
       NATIONAL_NAME
FROM EMPLOYEE E,
     DEPARTMENT,
     LOCATION L,
     NATIONAL N
WHERE DEPT_CODE=DEPT_ID --> �μ���
AND   LOCAL_CODE = LOCATION_ID --> �ٹ�����
AND   L.NATIONAL_CODE=N.NATIONAL_CODE
AND   (L.NATIONAL_CODE='KO'
OR     L.NATIONAL_CODE='JP');

--ANSI
SELECT EMP_NAME , 
       DEPT_TITLE ,
       LOCAL_NAME,
       NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_CODE='KO'
OR    NATIONAL_CODE='JP';



-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7�� ��������
--    �����, ���޸�, �޿��� ��ȸ�Ͻÿ�
--<ORACLE>
SELECT E.EMP_NAME, 
       J.JOB_CODE, 
       E.SALARY
FROM EMPLOYEE E,
     JOB J
WHERE E.JOB_CODE = J.JOB_CODE --> ���޸� ���
AND BONUS IS NULL   
AND (E.JOB_CODE = 'J4' 
OR   E.JOB_CODE = 'J7');

--ANSI
SELECT EMP_NAME,
       JOB_CODE,
       SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE BONUS IS NULL
AND (JOB_CODE = 'J4' 
OR   JOB_CODE = 'J7');
-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
--    �̶� ���п� �ش��ϴ� ����
--    �޿������ S1, S2�� ��� '���'
--    �޿������ S3, S4�� ��� '�߱�'
--    �޿������ S5, S6�� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�.
--<ORACLE>
SELECT E.EMP_ID, 
       E.EMP_NAME, 
       J.JOB_NAME, 
       S.SAL_LEVEL,
CASE WHEN SAL_LEVEL ='S1' OR SAL_LEVEL = 'S2' THEN '���' 
     WHEN SAL_LEVEL ='S3' OR SAL_LEVEL = 'S4' THEN '�߱�'
     WHEN SAL_LEVEL ='S5' OR SAL_LEVEL = 'S6' THEN '�ʱ�'
     END �޿����
FROM EMPLOYEE E,
     JOB J,
     SAL_GRADE S
WHERE E.JOB_CODE=J.JOB_CODE
AND SALARY BETWEEN MIN_SAL AND MAX_SAL;
     
--<ANSI> 
SELECT EMP_ID, 
       EMP_NAME, 
       JOB_NAME, 
       SAL_LEVEL,
CASE WHEN SAL_LEVEL ='S1' OR SAL_LEVEL = 'S2' THEN '���' 
     WHEN SAL_LEVEL ='S3' OR SAL_LEVEL = 'S4' THEN '�߱�'
     WHEN SAL_LEVEL ='S5' OR SAL_LEVEL = 'S6' THEN '�ʱ�'
     END �޿����
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);
-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ�
--     �̶�, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ�
--<ORACLE>
SELECT DEPT_TITLE, 
       SUM(SALARY) �ѱ޿�
FROM EMPLOYEE, 
     DEPARTMENT
WHERE DEPT_CODE = DEPT_ID --> �μ���
GROUP BY DEPT_TITLE
HAVING SUM(SALARY)>10000000;

--ANSI
SELECT DEPT_TITLE, 
       SUM(SALARY) �ѱ޿�
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);


-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��)�� ��ȸ�Ͻÿ�.
--      ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�.
--<ORACLE>
SELECT NVL(DEPT_TITLE,'��ġ��'), 
       FLOOR(AVG(SALARY))
FROM EMPLOYEE E,
     DEPARTMENT D
WHERE DEPT_ID(+)=DEPT_CODE
GROUP BY DEPT_TITLE;
       
--<ANSI>
SELECT NVL(DEPT_TITLE,'��ġ��'), 
       FLOOR(AVG(SALARY))
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_ID=DEPT_CODE)
GROUP BY DEPT_TITLE;

