"t0" = (x > 5)
ifz t0 goto L0
param "x is greater than 5"
call Put_Line, 1
goto L1
L0:
param "x is 5 or less"
call Put_Line, 1
L1:
L2:
"t1" = (x > 0)
ifz t1 goto L3
"t2" = (x - 1)
"x" = t2
goto L2
L3:
