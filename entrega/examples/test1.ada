procedure Main is
   x : Integer := 10;
begin
   if x > 5 then
      Put_Line("x is greater than 5");
   else
      Put_Line("x is 5 or less");
   end if;
   
   while x > 0 loop
      x := x - 1;
   end loop;
end Main;