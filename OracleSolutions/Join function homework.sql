-- 1. 직급이 대리이면서 ASIA지역에 근무하는 직원들의
--    사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회하시오
--SOL.ORACLE 
SELECT * FROM EMPLOYEE;  -- EMP_ID  EMP_NAME, JOB_CODE          ,DEPT_CODE
SELECT * FROM JOB;       --                   JOB_CODE -->부서명
SELECT * FROM DEPARTMENT; --                                     DEPT_TITLE -> 직급명
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
WHERE E.JOB_CODE=J.JOB_CODE  -->> 직급명 연동.
 AND  DEPT_CODE=DEPT_ID      -->>부서명 연동
 AND  LOCATION_ID=LOCAL_CODE -->>근무지역명 연동
 AND  JOB_NAME ='대리'
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
WHERE JOB_NAME ='대리'
AND  LOCAL_NAME LIKE '%ASIA%';
    
-- 2. 70년대생이면서 여자이고, 성이 전씨인 직원들의
--    사원명, 주민번호, 부서명, 직급명을 조회하시오
--<ORACLE>
SELECT E.EMP_NAME,
       E.EMP_NO,
       D.DEPT_TITLE,
       J.JOB_NAME
FROM EMPLOYEE E,
     DEPARTMENT D,
     JOB J
WHERE DEPT_CODE=DEPT_ID -->부서명 출력
AND   E.JOB_CODE=J.JOB_CODE --> 직급명 출력
AND SUBSTR(EMP_NO,1,2)>=70 AND SUBSTR(EMP_NO,1,2)<80
AND SUBSTR(EMP_NO,8,1)=2 OR SUBSTR(EMP_NO,8,1)=4;


--<ANSI>
SELECT EMP_NAME,EMP_NO,DEPT_TITLE,JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE SUBSTR(EMP_NO,1,2)>=70 AND SUBSTR(EMP_NO,1,2)<80 
  AND SUBSTR(EMP_NO,8,1)=2 OR SUBSTR(EMP_NO,8,1)=4;

-- 3. 이름에 '형'자가 들어있는 직원들의
--    사번, 사원명, 직급명을 조회하시오
--<ORACLE>
SELECT EMP_ID, 
       EMP_NAME, 
       JOB_NAME
FROM EMPLOYEE E,
     JOB J
WHERE E.JOB_CODE=J.JOB_CODE -->부서 출력
AND EMP_NAME LIKE('%형%');

--ANSI
SELECT EMP_ID, 
       EMP_NAME, 
       JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE('%형%');

-- 4. 해외영업팀에 근무하는 직원들의
--    사원명, 직급명, 부서코드, 부서명을 조회하시오
--<ORACLE>
SELECT EMP_NAME , 
       JOB_NAME , 
       DEPT_CODE, 
       DEPT_TITLE
FROM EMPLOYEE E,DEPARTMENT,JOB J
WHERE DEPT_CODE = DEPT_ID  -->부서명 가져오기
AND   E.JOB_CODE = J.JOB_CODE -->직급명 가져오기
AND   DEPT_TITLE LIKE('%해외영업%');

--ANSI--
SELECT EMP_NAME , 
       JOB_NAME , 
       DEPT_CODE, 
       DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE DEPT_TITLE LIKE('%해외영업%');

-- 5. 보너스를 받는 직원들의
--    사원명, 보너스, 연봉, 부서명, 근무지역명을 조회하시오
--<ORACLE>
SELECT EMP_NAME, 
       BONUS, SALARY*12 연봉, 
       DEPT_TITLE, 
       LOCAL_NAME
FROM EMPLOYEE,
     DEPARTMENT,
     LOCATION
WHERE DEPT_CODE=DEPT_ID --> 부서명 출력
AND   LOCAL_CODE = LOCATION_ID --> 근무지역명
AND   BONUS IS NOT NULL;

--<ANSI>

SELECT EMP_NAME, 
       BONUS, 
       SALARY*12 연봉, 
       DEPT_TITLE, 
       LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID)
WHERE BONUS IS NOT NULL;
--8ROWS
-- 6. 부서가 있는 직원들의
--    사원명, 직급명, 부서명, 근무지역명을 조회하시오
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
WHERE E.JOB_CODE=J.JOB_CODE --> 직급명 추출 DEPT_CODE(+)=DEPT_ID
  AND DEPT_CODE=DEPT_ID --> 부서명 추출
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


-- 7. '한국'과 '일본'에 근무하는 직원들의 
--    사원명, 부서명, 근무지역명, 근무국가명을 조회하시오
--<ORACLE>
SELECT EMP_NAME , 
       DEPT_TITLE ,
       LOCAL_NAME,
       NATIONAL_NAME
FROM EMPLOYEE E,
     DEPARTMENT,
     LOCATION L,
     NATIONAL N
WHERE DEPT_CODE=DEPT_ID --> 부서명
AND   LOCAL_CODE = LOCATION_ID --> 근무지명
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



-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7인 직원들의
--    사원명, 직급명, 급여를 조회하시오
--<ORACLE>
SELECT E.EMP_NAME, 
       J.JOB_CODE, 
       E.SALARY
FROM EMPLOYEE E,
     JOB J
WHERE E.JOB_CODE = J.JOB_CODE --> 직급명 출력
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
-- 9. 사번, 사원명, 직급명, 급여등급, 구분을 조회하는데
--    이때 구분에 해당하는 값은
--    급여등급이 S1, S2인 경우 '고급'
--    급여등급이 S3, S4인 경우 '중급'
--    급여등급이 S5, S6인 경우 '초급' 으로 조회되게 하시오.
--<ORACLE>
SELECT E.EMP_ID, 
       E.EMP_NAME, 
       J.JOB_NAME, 
       S.SAL_LEVEL,
CASE WHEN SAL_LEVEL ='S1' OR SAL_LEVEL = 'S2' THEN '고급' 
     WHEN SAL_LEVEL ='S3' OR SAL_LEVEL = 'S4' THEN '중급'
     WHEN SAL_LEVEL ='S5' OR SAL_LEVEL = 'S6' THEN '초급'
     END 급여등급
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
CASE WHEN SAL_LEVEL ='S1' OR SAL_LEVEL = 'S2' THEN '고급' 
     WHEN SAL_LEVEL ='S3' OR SAL_LEVEL = 'S4' THEN '중급'
     WHEN SAL_LEVEL ='S5' OR SAL_LEVEL = 'S6' THEN '초급'
     END 급여등급
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);
-- 10. 각 부서별 총 급여합을 조회하되
--     이때, 총 급여합이 1000만원 이상인 부서명, 급여합을 조회하시오
--<ORACLE>
SELECT DEPT_TITLE, 
       SUM(SALARY) 총급여
FROM EMPLOYEE, 
     DEPARTMENT
WHERE DEPT_CODE = DEPT_ID --> 부서명
GROUP BY DEPT_TITLE
HAVING SUM(SALARY)>10000000;

--ANSI
SELECT DEPT_TITLE, 
       SUM(SALARY) 총급여
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);


-- 11. 각 부서별 평균급여를 조회하여 부서명, 평균급여 (정수처리)로 조회하시오.
--      단, 부서배치가 안된 사원들의 평균도 같이 나오게끔 하시오.
--<ORACLE>
SELECT NVL(DEPT_TITLE,'배치전'), 
       FLOOR(AVG(SALARY))
FROM EMPLOYEE E,
     DEPARTMENT D
WHERE DEPT_ID(+)=DEPT_CODE
GROUP BY DEPT_TITLE;
       
--<ANSI>
SELECT NVL(DEPT_TITLE,'배치전'), 
       FLOOR(AVG(SALARY))
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_ID=DEPT_CODE)
GROUP BY DEPT_TITLE;

