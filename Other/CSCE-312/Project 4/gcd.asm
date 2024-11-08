// Maverick Boyle 426005784

// File name: gcd.asm

// This program calculates the greatest common divisor (gcd) of two given 
// non-negative integers, which are stored in RAM[0] (R0) and RAM[1] (R1). 
// The gcd is stored in RAM[2] (R2).



// Put your code below this line

@0
D=M
@9999
M=D

@1
D=M
@9998
M=D

@2
M=0     //GCD = 0

(MOD)
@0
D=M     //D=dividend

(DECREMENT)
@1
D=D-M   
@0
M=D     //Update Dividend

@DECREMENT
D;JGT   //If D(the new dividend) is greater than 0, jump to DECREMENT
@GCD
D;JEQ   //If D(the new dividend) is equal to 0, jump to GCD

@1
D=M
@0
M=M+D
D=M
@2
M=D     

@1
D=M
@0
M=D
@2
D=M
@1
M=D
@MOD
0;JMP

(GCD)
@1
D=M
@2
M=D

@9999
D=M
@0
M=D

@9998
D=M
@1
M=D

(END)
@END
0;JMP