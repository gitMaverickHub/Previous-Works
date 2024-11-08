// Maverick Boyle 426005784

// File name: div.asm

// The program calculates the quotient from a division operation. 
// The values of dividend a and divisor b are stored in RAM[0] (R0) and RAM[1] (R1), respectively. 
// The dividend a is a non-negative integer, and the divisor b is a positive integer. 
// Store the quotient in RAM[2] (R2). Ignore the remainder.


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
M=0     //Quotient = 0

@0
D=M     //D=dividend

@END
D;JLE   //If D(the dividend) is less than or equal to 0, jump to END

(DECREMENT)
@1
D=D-M   
@0
M=D     //Update Dividend

@2
M=M+1   //Increment Quotient

@0
D=M     //D=the new dividend

@DECREMENT
D;JGT   //If D(the new dividend) is greater than 0, jump to DECREMENT
@END
D;JEQ   //If D(the new dividend) is equal to 0, then jump to END

@2
M=M-1

(END)
@9999
D=M
@0
M=D

@9998
D=M
@1
M=D

@END
0; JMP