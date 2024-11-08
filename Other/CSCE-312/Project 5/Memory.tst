load Memory.hdl,
output-file Memory.out,
compare-to Memory.cmp,
output-list in%D1.6.1 load%B2.1.2 address%B1.16.1 out%D1.16.1;

echo "Before you run this script, select the 'Screen' option from the 'View' menu";

set in -1,				// Set RAM[0] = -1
set load 1,
set address 0,
tick,
output;
tock,
output;


