load fastRCA12.hdl,
compare-to fastRCA12.cmp,
output-file fastRCA12.out,
output-list A%B3.12.3 B%B3.12.3 SUM%B3.12.3 COUT%B3.1.3;

set A %B000000000000,
set B %B000000000000,
eval,
output;

set A %B111111111111,
set B %B111111111111,
eval,
output;

set A %B100010001000,
set B %B100010001000,
eval,
output;

set A %B100101011000,
set B %B001010101011,
eval,
output;