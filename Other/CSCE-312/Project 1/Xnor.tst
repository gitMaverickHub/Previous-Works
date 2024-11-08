// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/01/Xnor.tst

load Xnor.hdl,
output-file Xnor.out,
compare-to Xnor.cmp,
output-list a%B3.1.3 b%B3.1.3 out%B3.1.3;

// example tst command given
set a 0,
set b 0,
eval,
output;

// now complete the remaining tst commands
// example tst command given
set a 0,
set b 1,
eval,
output;

// example tst command given
set a 1,
set b 0,
eval,
output;

// example tst command given
set a 1,
set b 1,
eval,
output;