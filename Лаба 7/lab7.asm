.686 				; create 32 bit code
.model flat, stdcall 			; 32 bit memory model
option casemap :none 			; case sensitive
include \masm32\include\windows.inc ; always first
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
.data 	        ; ��������� ����������� �����x
mas dd 200,-20,-50,0,-135,11,37,128,0,-1,1,234	;������
N=($-mas)/type mas	;������������� ������������ ������ �������
pos	dd 0		;���-�� ������������� ���������
zer	dd 0		;���-�� ������� ���������
negs dd 0		;���-�� ������������� ���������
titl1 db "��-7. ������� �������� ������ A(i)",0 
_info db "ϳ��������� ������� ��������, ������ �� ������� �������� � ������������ �����",0dh,0ah
	db "mas: " ,256 dup(0)
fmt	db 13,10,"� ������� %d �������, %d ������  %d ������� ��������.",0ah,0
fmt1 db '%d ',0		;��� �������������� �������� �������
buf dd 128 dup(0)
.code  		 ; ��������� ������ ���� ���������
_start: 	 ; ����� ������ ��������� � ������ _start��
	mov ebx,0	;������� ������ �������
lp: mov eax,mas[ebx*4]	;����� ��������� ������� � ���������������
	test eax,eax		;��������� ���
	jnz m1				;���� �� 0, �������
	inc zer				;���� 0, ��������� ���-�� �����
	jmp m2				;����������
m1: js m3				;���� �������������, �������
	inc pos				;���� �������������, ��������� �� ����������
	jmp m2				;����������
m3:	inc negs			;���� �������������, ��������� �� ����������
m2:	invoke wsprintf,offset buf,offset fmt1,eax	;������������� ��������� ������� � ������
	invoke lstrcat,offset _info,offset buf		;�������� ��� � ���������
	inc ebx				;��������� ������ ��������
	cmp ebx,N			;���� �� ���������� ���� ������
	jb lp				;����������
	invoke wsprintf,offset buf,offset fmt,pos,negs,zer	;������������ ���������
	invoke lstrcat,offset _info,offset buf				;�������� ��� � ������
invoke MessageBox,0,addr _info,addr titl1,MB_OK			;������� �� �����
invoke ExitProcess, 0
end _start  ; ��������� ��������� � ������  _start
