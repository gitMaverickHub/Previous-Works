// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/01/Xnor.tst

load PriorityEncoder83.hdl,
output-file PriorityEncoder83.out,
compare-to PriorityEncoder83.cmp,
output-list a%B3.8.2 out%B4.3.4 idle%B4.1.3;

// example tst command given
set a %B00000000,
eval,
output;

// now complete the remaining tst commands
// example tst command given
set a %B00000001,
eval,
output;

// example tst command given
set a %B00000010,
eval,
output;

// example tst command given
set a %B00000100,
eval,
output;

// example tst command given
set a %B00001000,
eval,
output;

// example tst command given
set a %B00010000,
eval,
output;

// example tst command given
set a %B00100000,
eval,
output;

// example tst command given
set a %B01000000,
eval,
output;

// example tst command given
set a %B10000000,
eval,
output;