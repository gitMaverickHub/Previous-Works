load RCA4.hdl,
output-file RCA4.out,
compare-to RCA4.cmp,
output-list a%B2.4.3 b%B2.4.3 cout%B3.1.4 sum%B2.4.3;

set a %B0000,
set b %B0000,
eval,
output;

set a %B0000,
set b %B0001,
eval,
output;

set a %B0001,
set b %B0000,
eval,
output;

set a %B1000,
set b %B0001,
eval,
output;

set a %B0001,
set b %B1000,
eval,
output;

set a %B0101,
set b %B1010,
eval,
output;

set a %B1010,
set b %B0101,
eval,
output;

set a %B1111,
set b %B1111,
eval,
output;