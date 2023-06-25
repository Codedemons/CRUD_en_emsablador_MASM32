include\masm32\include\masm32rt.inc

.data
    Message1 db "Vale verga todo",10,13,0
   
.code
start: 

    mov eax,0
    mov edx,0
    mov ebx,0
    mov ecx,0
    
    mov cx ,0
    mov al, 23 ; Numero
    mov bl, 2

    print "Vale verga todo",10,13 
    
    .repeat
    .if cx!=1
    
        div bl
        .if ah == 0
            mov cx,1
        .endif
     .endif
     inc bl
    .until bl < al




    .if cx == 0
        print "Numero si es primo",10,13
    .else
        print "Numero no es primo",10,13
    .endif

    inkey
end start