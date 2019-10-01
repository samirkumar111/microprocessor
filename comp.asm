.model small
display macro msg
lea dx,msg
mov ah,09h
int 21h
endm

.data
   msg1 db 0dh,0ah,"Same string$"
   msg2 db 0dh,0ah,"Different string$"
   msg3 db 0dh,0ah,"Enter first string: $"
   msg4 db 0dh,0ah,"Enter the second string: $"
   str1 db 10h dup(0)
   str2 db 10h dup(0)
   len1 dw 0
   len2 dw 0

.code
     mov ax,@data
     mov ds,ax
     display msg3
     mov si,00h

back1: mov ah,01h
       int 21h
       cmp al,0dh
       jz next
       mov str1[si],al
       inc si
       inc len1
       jmp back1

next: display msg4
      mov si,00h
back2: mov ah,01h
       int 21h
       cmp al,0dh
       jz next1
       mov str2[si],al
       inc si
       inc len2
       jmp back2
 next1: mov ax,len1
        cmp ax,len2
        jne fail
        mov si,00h
        mov cx,00h
l1: mov al,str1[si]
   cmp al,str2[si]
   jnz fail
   inc si
   inc di
   inc cx
   cmp cx,len2
   jc l1
   display msg1
   jmp last

fail: display msg2
last: mov ah,4ch
      int 21h
      end