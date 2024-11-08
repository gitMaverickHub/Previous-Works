// Maverick Boyle 426005784

// File name: mod.asm

// This program calculates the modulo of two given numbers a and b, which is a%b in math. 
// The value of a is stored in RAM[0] (R0), and the value of b is stored in RAM[1] (R1). 
// The value a is non-negative integer and b is positive integer. 
// The modulo value is stored in RAM[2] (R2).


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
M=0     //Reaminder = 0

@0
D=M     //D=dividend

@END
D;JLE   //If D(the dividend) is equal to 0, jump to END

(DECREMENT)
@1
D=D-M   
@0
M=D     //Update Dividend

@DECREMENT
D;JGT   //If D(the new dividend) is greater than 0, jump to DECREMENT
@END
D;JEQ   //If D(the new dividend) is equal to 0, jump to END

@1
D=M
@0
M=M+D
D=M
@2
M=D     //New Dividend is equal to remainder

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
0;JMP