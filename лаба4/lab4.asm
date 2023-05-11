;Mormul Elizabeth Laboratorna robota 4
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

.data ; data definition directive 
 _const0_12 DWORD 0.12 ;declaration of the constant
 _const0_15 DWORD 0.15 ;declaration of the constant
 borderLeft DWORD -2.0 ;declaration of the variable borderLeft
 borderRight DWORD 3.0 ;declaration of the variable borderRight
 _title db "Laboratorna robota 4",0 ; set the title for the message box
 strbuf dw ?,0 ; define a buffer for the message box output
 _text db "Mormul Elizabeth Student of KNEU IITE", 10,
  "Output result by MessageBox:", 10,
  "Y = x+cos(x)   x<-2.0", 10,
  "Y = arctg(x+0.12)   -2.0<=x<3.0", 10,
  "Y = ln(x+sqrt(x+0.15))   3.0<=x", 10,
  "Result: " ; set the message box output text
 _res db 10 DUP(0),10,13 ; Define a string with a length of 10 characters filled with 0s, and line feed and carriage return at the end
 MsgBoxCaption db "Result of comparison",0 ; Defines a string that will be used as the caption for the message box.
 MsgBoxText_1 db "x<-2.0",0 ; Defines a string that will be used as the message for the message box if the condition x<-2.0 is true.
 MsgBoxText_2 db "-2.0<=x<3.0", 0 ; Defines a string that will be used as the message for the message box if the condition -2.0<=x<3.0 is true.
 MsgBoxText_3 db "3.0<=x", 0 ; Defines a string that will be used as the message for the message box if the condition 3.0<=x is true.

.const 
 NULL equ 0 ; define a constant symbol named NULL and sets its value to 0.
 MB_OK equ 0 ; define a constant symbol named MB_OK and sets its value to 0. 

.code ; Command segment start directive
_start: ; Program start mark with the name _start
 
 main proc 
 LOCAL _x: DWORD ; declare a local variable named _x
 mov _x, sval(input("Enter x: ")) ; store answer in the local variable _x
 finit ;initializing the coprocessor
 fild _x ;loading x to the top of the stack
 fstp _x ;saving x with pushing it off the stack
 fld borderLeft ;loading a variable to the top of the stack
 fld _x ;loading x to the top of the stack, shifting the variable to st(1)
 fcompp ;comparing the top of the stack with the operan
 fstsw ax ;writes the value of the fpu status word to the register
 sahf ;write the contents of the register to the processor flag register 
 jb first ; jump
 fld borderRight ;write the variable to the top of the stack
 fld _x ;write the variable x to the top of the stack, the previous variable is in st(1)
 fcompp ;comparing the top of the stack with the operand
 fstsw ax ;writes the value of the fpu status word to the register
 sahf ;write the contents of the register to the processor flag register
 jbe second ; jump
  ;3.0<=x
  ;ln(x+sqrt(x+0.15))
  fld _x ;putting x to the top of the stack
  fld _x ;putting x to the top of the stack
  fadd _const0_15 ; add const0_15 to x
  fsqrt ; we perform the operation of taking the root
  fadd _x ; add x to sqrt(x+0.15)
  fldln2 ; we place the value of ln(2) on the top of the stack
  fxch ; we exchange the places of the value at the top of the stack and the penultimate value
  fyl2x ; perform the operation ln(z)*log2(2), where z = x+sqrt(x+0.15)
  invoke MessageBoxA, NULL, ADDR MsgBoxText_3, ADDR MsgBoxCaption, MB_OK 
  invoke FpuFLtoA, 0, 10, ADDR _res, SRC1_FPU or SRC2_DIMM
  invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
  invoke ExitProcess, 0
  jmp lexit ;go to the exit label (GOTO exit)
 
 first: 
  ;x<-2.0
  ;x+cos(x) 
  fld _x ;putting x to the top of the stack
  fld _x ; load x to the top of the stack
  fcos ; cos(x)
  fadd _x ; x + cos(x)
  invoke MessageBoxA, NULL, ADDR MsgBoxText_1, ADDR MsgBoxCaption, MB_OK 
  invoke FpuFLtoA, 0, 10, ADDR _res, SRC1_FPU or SRC2_DIMM
  invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
  invoke ExitProcess, 0 ; exit the program
  jmp lexit ;go to the exit label (GOTO exit)

 second:
  ;-2.0<=x<3.0
  ;arctg(x+0.12)
  fld _x ;putting x to the top of the stack
  fadd _const0_12 ; x+0.12
  fld1 ;to compute full arctangent.
  fpatan
  invoke MessageBoxA, NULL, ADDR MsgBoxText_2, ADDR MsgBoxCaption, MB_OK 
  invoke FpuFLtoA, 0, 10, ADDR _res, SRC1_FPU or SRC2_DIMM
  invoke MessageBox, 0, offset _text, offset _title, MB_ICONINFORMATION
  invoke ExitProcess, 0 ; exit the program
  jmp lexit ;go to the exit label (GOTO exit)

 lexit:
  ret
  main endp ; end of the function code
  ret ; OS control return
 
end _start ; End of the program

