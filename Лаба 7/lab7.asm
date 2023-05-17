.686 				; create 32 bit code
.model flat, stdcall 			; 32 bit memory model
option casemap :none 			; case sensitive
include \masm32\include\windows.inc ; always first
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
.data 	        ; директива определения данныx
mas dd 200,-20,-50,0,-135,11,37,128,0,-1,1,234	;массив
N=($-mas)/type mas	;автоматичести подсчитываем размер массива
pos	dd 0		;кол-во положительных элементов
zer	dd 0		;кол-во нулевых элементов
negs dd 0		;кол-во отрицательных элементов
titl1 db "ЛР-7. Таблиця елементів масива A(i)",0 
_info db "Підрахувати кількість нульових, відємних та додатніх елементів в одновимірному масиві",0dh,0ah
	db "mas: " ,256 dup(0)
fmt	db 13,10,"В массиве %d додатніх, %d відємних  %d нулевих элемента.",0ah,0
fmt1 db '%d ',0		;для преобразования элемента массива
buf dd 128 dup(0)
.code  		 ; директива начала кода программы
_start: 	 ; метка начала программы с именем _startта
	mov ebx,0	;текущий индекс массива
lp: mov eax,mas[ebx*4]	;Берем очередной элемент с индексированием
	test eax,eax		;проверяем его
	jnz m1				;если не 0, перейти
	inc zer				;если 0, увеличить кол-во нулей
	jmp m2				;продолжить
m1: js m3				;если отрицательный, перейти
	inc pos				;если положительный, увеличить их количество
	jmp m2				;продолжить
m3:	inc negs			;если отрицательный, увеличить их количество
m2:	invoke wsprintf,offset buf,offset fmt1,eax	;преобразовать очередной элемент в строку
	invoke lstrcat,offset _info,offset buf		;дописать его к сообщению
	inc ebx				;увеличить индекс элемента
	cmp ebx,N			;пока не обработали весь массив
	jb lp				;продолжить
	invoke wsprintf,offset buf,offset fmt,pos,negs,zer	;сформировать результат
	invoke lstrcat,offset _info,offset buf				;дописать его к строке
invoke MessageBox,0,addr _info,addr titl1,MB_OK			;вывести на экран
invoke ExitProcess, 0
end _start  ; окончание программы с именем  _start
