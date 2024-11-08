load AddSub4.hdl,
output-file AddSub4.out,
compare-to AddSub4.cmp,
output-list a%B1.4.1 b%B1.4.1 sub%B1.1.1 out%B1.4.1 carry%B3.1.3;

set a %B0001,
set b %B0001,
set sub 0,
eval,
output;

set a %B0001,
set b %B1111,
set sub 1,
eval,
output;

set a %B1001,
set b %B0111,
set sub 0,
eval,
output;

set a %B1101,
set b %B1001,
set sub 1,
eval,
output;