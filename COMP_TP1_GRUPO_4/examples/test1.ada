-- examples/test1.ada
procedure Main is
begin
    x := 10;
    y := x + 5 * 2;
    
    if x > 5 then
        Put_Line("x is greater than 5");
    else
        Put_Line("x is 5 or less");
    end if;
    
    while x > 0 loop
        x := x - 1;
    end loop;
end;