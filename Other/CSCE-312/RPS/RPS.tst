load RPS.hdl,
compare-to RPS.cmp,
output-file RPS.out,
output-list p1%B3.2.3 p2%B3.2.3 out%B3.1.3;

set p1 %B01,
set p2 %B10,
eval,
output;

// Build more testcases here:
set p1 %B01,
set p2 %B11,
eval,
output;

set p1 %B10,
set p2 %B01,
eval,
output;

set p1 %B10,
set p2 %B11,
eval,
output;

set p1 %B11,
set p2 %B01,
eval,
output;

set p1 %B11,
set p2 %B10,
eval,
output;