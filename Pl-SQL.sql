DECLARE
 studentInfo STUDENT%rowtype;
 weightsInfo WEIGHTS%rowtype;
 studentAvg NUMBER; 
 midtermWeight WEIGHTS.MidPct%type;
 finalWeight   WEIGHTS.FinPct%type;
 homeworkWeight WEIGHTS.HWPct%type;
CURSOR weightCur IS (SELECT * FROM WEIGHTS); 
CURSOR StudentCur IS (SELECT * FROM STUDENT);

 
BEGIN 
FOR weightsInfo IN weightCur LOOP
    midtermWeight := weightsInfo.MidPct;
    finalWeight   := weightsInfo.FinPct;
    homeworkWeight := weightsInfo.HWPct;
END LOOP;
     DBMS_OUTPUT.PUT_LINE('Weights are' || ' ' ||  midtermWeight || ',' || finalWeight || ',' ||  homeworkWeight  );

 FOR studentInfo IN  StudentCur LOOP
    studentAvg := (midtermWeight/100 * studentInfo.Midterm + finalWeight/100 * studentInfo.Final + homeworkWeight/100 * studentInfo.Homework);
    IF studentAvg >= 89 THEN
   DBMS_OUTPUT.PUT_LINE(studentInfo.ID || ' ' || studentInfo.Name || ' ' || studentAvg || ' ' || 'A');
    ELSIF studentAvg >= 80  THEN
   DBMS_OUTPUT.PUT_LINE(studentInfo.ID || ' ' || studentInfo.Name || ' ' || studentAvg || ' ' || 'B');
     ELSIF studentAvg >= 65 THEN
   DBMS_OUTPUT.PUT_LINE(studentInfo.ID || ' ' || studentInfo.Name || ' ' || studentAvg  || ' ' || 'C');
     ELSE  
    DBMS_OUTPUT.PUT_LINE(studentInfo.ID || ' ' || studentInfo.Name || ' ' || studentAvg  || ' ' || 'F');
    END IF;      
END LOOP;
END;
/ 
