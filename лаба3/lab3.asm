;Mormul Elizabeth Laboratorna robota 3
;Ex Y=2^x+30   find x when y > 100

.386 ; Set code generation for 80386 processor and above
.model flat, stdcall ; Use flat memory model with stdcall calling convention
option casemap:none ; Set case sensitivity for symbols to none
include C:\masm32\include\windows.inc ; Include Windows API declarations
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc 
include C:\masm32\include\fpu.inc ; Include FPU instructions and declarations
includelib C:\masm32\lib\kernel32.lib ; Include kernel32 library
includelib C:\masm32\lib\user32.lib 
includelib C:\masm32\lib\fpu.lib ; Include FPU library

.data ; Define the data segment
CrLf equ 0A0Dh ; Define carriage return and line feed characters
_X dt 7.0 ; Define a double precision floating-point number with initial value 6.0
_x DWORD 1.0 ; Define a single precision floating-point number with initial value 1.0
_const1 DWORD 2.0  ; Define a constant value 2.0 as single precision floating-point
_const2 DWORD 30.0  ; Define a constant value 30.0 as single precision floating-point
_step DWORD 1.0  ; Define a step size as single precision floating-point
_num DWORD 100.0  ; Define the threshold value as single precision floating-point
info db "Mormul Elizabeth Student of KNEU IITE",10,10, ; Define a string with a line feed and carriage return at the end
"Y=2^x+30 where Y > 100",10,10,
"x = " ; Define a message string to be displayed with the result
_res1 db 14 DUP(0),10,13 ; Define a string with a length of 14 characters filled with 0s, and line feed and carriage return at the end
ttl db "Processing numbers on a coprocessor in a loop",0 ; Defines a string that will be used as the caption for the message box.

.code
  _start: 
 fninit  ; Initialize the FPU
 mov ecx, 6  ; Initialize the loop counter to 6
 ; Y=2^x+30 where Y > 100
 math:
 fld _const1 ; Load 2.0 onto the FPU stack
 fld _x ; Load x onto the FPU stack
 fyl2x ; Compute 2.0^x using the FPU instruction fyl2x
 fld _const2 ; Load 30.0 onto the FPU stack
 fadd ; Compute 2^x+30 using the FPU instruction fadd
 fcomp _num ; Compare the result with 100
 ja quit ; Jump to quit if the result is greater than 100
 fninit ; Clears the FPU stack
    fld _x ; Pushes the current value of x onto the FPU stack
    fadd _step ; Adds 1.0 to the current value of x
    fstp _x ; Stores the new value of x in the variable _x
    loop math ; Repeats the "math" block of code until ECX becomes 0

quit:
 fld _x ; Store the value of _x on the top of the FPU stack
 fstp _X ; Pop the value from the top of the FPU stack and store it in _X
 
invoke FpuFLtoA,offset _X,10,offset _res1,SRC1_REAL or SRC2_DIMM 
mov word ptr _res1 + 14, CrLf ; Move the carriage return and line feed characters to the end of the string stored in _res1
invoke MessageBox, 0, offset info, offset ttl, MB_ICONINFORMATION ; Display the string stored in 'info' as a message box with the caption stored in 'ttl'
invoke ExitProcess, 0 ; Terminate the program and exit to the operating system
end _start ; End of the _start procedure.