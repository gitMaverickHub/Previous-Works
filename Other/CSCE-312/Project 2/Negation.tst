//Negation.tst

load Negation.hdl,
output-file Negation.out,
compare-to Negation.cmp,
output-list in%B1.16.1 out%B1.16.1;

//in=1
set in %B0000000000000001,
eval,
output;

//in=255
set in %B0000000011111111,
eval,
output;

//in=256
set in %B0000000100000000,
eval,
output;

//in=-1
set in %B1111111111111111,
eval,
output;

//in=21845
set in %B0101010101010101,
eval,
output;

//in=-21846
set in %B1010101010101010,
eval,
output;

//in=-57
set in %B1111111111000111,
eval,
output;

//in=-7169
set in %B1110001111111111,
eval,
output;

//Write more tst commands and also complete the .cmp file accordingly