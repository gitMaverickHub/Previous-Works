// Maverick Boyle 426005784
// Filename = div.tst

load div.asm,
output-file div.out,
compare-to div.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2;

set RAM[0] 1,   // Set test arguments
set RAM[1] 1,
set RAM[2] -1;  // Test that program initialized product to 0
repeat 20 {
  ticktock;
}
set RAM[0] 1,   // Restore arguments in case program used them as loop counter
set RAM[1] 1,
output;

set PC 0,
set RAM[0] 2,   // Set test arguments
set RAM[1] 2,
set RAM[2] -1;  // Ensure that program initialized product to 0
repeat 50 {
  ticktock;
}
set RAM[0] 2,   // Restore arguments in case program used them as loop counter
set RAM[1] 2,
output;

set PC 0,
set RAM[0] 0,   // Set test arguments
set RAM[1] 2,
set RAM[2] -1;  // Ensure that program initialized product to 0
repeat 80 {
  ticktock;
}
set RAM[0] 0,   // Restore arguments in case program used them as loop counter
set RAM[1] 2,
output;

set PC 0,
set RAM[0] 19,   // Set test arguments
set RAM[1] 8,
set RAM[2] -1;  // Ensure that program initialized product to 0
repeat 80 {
  ticktock;
}
set RAM[0] 19,   // Restore arguments in case program used them as loop counter
set RAM[1] 8,
output;

set PC 0,
set RAM[0] 20,   // Set test arguments
set RAM[1] 10,
set RAM[2] -1;  // Ensure that program initialized product to 0
repeat 80 {
  ticktock;
}
set RAM[0] 20,   // Restore arguments in case program used them as loop counter
set RAM[1] 10,
output;