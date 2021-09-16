DECLARE
  height INTEGER := &X;
  area INTEGER := 6;
  width area%type; 
BEGIN
  -- Width is area divided by height
  width := area/height;
  DBMS_OUTPUT.PUT_LINE('Width: ' || TO_CHAR(width));
END;
/

