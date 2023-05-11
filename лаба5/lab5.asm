.486 ;sets the CPU to 80486 instruction set mode
.model flat, stdcall ;sets the memory model to flat and the calling convention to stdcall
option casemap :none ;sets the case sensitivity option for symbols to none 
include \masm32\include\windows.inc ; connecting the windows.inc program file
include \masm32\macros\macros.asm ; MASM support macros
include \masm32\include\masm32.inc ; connecting the program file masm.inc
include \masm32\include\gdi32.inc ; connecting the program file gdi32.inc
include \masm32\include\fpu.inc ; connecting the program file fpu.inc
include \masm32\include\user32.inc ; connecting the user32.inc program file
include \masm32\include\kernel32.inc ; connecting the program file kernel32.inc
include c:\masm32\include\msvcrt.inc ; connecting the msvcrt.inc program file               
includelib c:\masm32\lib\msvcrt.lib ; connecting the msvcrt.lib library
includelib c:\masm32\lib\fpu.lib ; connecting the fpu.lib library
includelib \masm32\lib\masm32.lib ; connecting the masm32.lib library
includelib \masm32\lib\gdi32.lib ; connecting the gdi32.lib library
includelib \masm32\lib\user32.lib ; connecting the user32.lib library
includelib \masm32\lib\kernel32.lib ; connecting the kernel32.lib library
uselib masm32, comctl32, ws2_32 

.data ; data definition directive
_const_4 DWORD 4.0
_const_8 DWORD 8.0 
_const_5 DWORD 5.0
_result DWORD 1.0 
_i dd 0 
_endVal dd 4 
_i1 DWORD 0.0 
_title db "Laboratorna robota 5",0 
strbuf dw ?,0
_text db "Mormul Elizabeth Student of KNEU IITE",10,
"Output result by MessageBox:",10, 
"Y = k TT(l=i) (l^2 + 4l + 8) / (l-5)",10,
"Result: " 
_res1 db 14 DUP(0),10,13

.code ; Command segment start directive
start: ; Program start mark with the name start
	mov edx, 1 ;writing 1 to the edx register
	mov ebx, _endVal 
	mov ecx, _i
	finit ;initialization of coprocessor

	.WHILE edx == 1 ; setting the condition for starting the cycle

	.IF ecx == 5 ; the condition under which the numbers at which division by zero occurs will be bypassed	 	 	
	loop m1  		
	.ENDIF ; the end of condition IF		
	fld _i1 ; load i1 to the top of the stack
	fmul _i1 ; i^2
	fld _i1 ; load i1 to the top of the stack
	fmul _const_4 ; 4l
	fadd _const_8 ; 4l+8
	fadd ; l^2 + 4l + 8
	fld _i1 ; load i1 to the top of the stack
	fsub _const_5 ; l-5
	fdiv ; (l^2 + 4l + 8) / (l-5)
	fld _result ; load _result to the top of the stack
	fmul ; result *= (l^2 + 4l + 8) / (l-5) 
	fstp _result ; save value in variable _result
	
	m1: ;operations with values to perform the next iteration
	add ecx,1
	add _i,1
	fld1
	fld _i1                  
	fadd             
	fstp _i1

	.IF ecx > ebx ;condition for exiting the loop
	fld _result                  
	.BREAK
	.ENDIF
	.ENDW

	invoke FpuFLtoA, 0, 10, ADDR _res1, SRC1_FPU or SRC2_DIMM
	invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
	invoke ExitProcess, 0 ; exit the program
 
end start ;End of the program