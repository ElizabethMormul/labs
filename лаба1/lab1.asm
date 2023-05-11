;Програма 1.2. Рішення  рівняння 2ab-18c/d   на masm32:
.686
.model flat, stdcall
option casemap:none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
firstfunc PROTO _const1:DWORD,_a1:DWORD,_b1:DWORD,_const2:DWORD,_c1:DWORD,_d1:DWORD 
.data   ;2ab-18c/d
const1 dd 2 
a1 dd 5 
b1 dd 3 
const2 dd 18 
c1 dd 4 
d1 dd 8 
_temp1 dd ?,0
_title db "Лабораторна робота №1. Арифм. операції",0
strbuf dw ?,0
_text db "masm32. Вивід результата 2ab-18c/d через MessageBox:",0ah,"Результат: %d — ціла частина",0ah, 0ah,
"СТУДЕНТ КНЕУ  IITE",0
.code
firstfunc proc _const1:DWORD,_a1:DWORD,_b1:DWORD,_const2:DWORD,_c1:DWORD,_d1:DWORD
mov eax,_const1; 
mul _a1 
mul _b1 
mov _temp1, eax 
mov eax, _const2 
mul _c1 
div _d1 
sub _temp1, eax
ret
firstfunc endp

start:
invoke firstfunc, const1,a1,b1,const2,c1,d1
invoke wsprintf, ADDR strbuf, ADDR _text, _temp1
invoke MessageBox, NULL, addr strbuf, addr _title, MB_ICONINFORMATION
invoke ExitProcess, 0
END start
