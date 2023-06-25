;ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
;  ///////////////// librerias a utilizar //////////////////////////
    include \masm32\include\masm32rt.inc
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл


title Proyecto
.data
; asignacion de los datos    
 x dd "h"
    Emp STRUCT
        Num     DWORD ?
        Nombre  DWORD ?
        Edad    DWORD ?
    Emp ENDS
 cuenta Emp {3,x,10}
    
.code                  
   
start:
        
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
    call main
    inkey
    invoke ExitProcess, 0
    exit

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл


main proc    
    LOCAL Rct :Emp
    
    mov Rct.Num, 1
    mov Rct.Nombre, 2
    mov Rct.Edad, 3
    mov eax,0

    print "Test de pruebas",13,10
    Mov eax, [cuenta.Num]
    Mov [cuenta.Num], eax
    print "Numero: ",10,13
    print str$(cuenta.Num),13,10
    ;print str$(eax),13,10,0
    mov eax,0

    Mov eax, [cuenta.Nombre]
    Mov [cuenta.Nombre], eax
    print "Nombre: ",10,13
    print str$(cuenta.Nombre),13,10
    
    ;Mov eax, [cuenta.Nombre]
    ;Mov [cuenta.Nombre], eax
    ;print "Nombre: ",10,13
    ;print str$(cuenta.Nombre),13,10
    ;print Emp.Nombre
    mov eax,0

    Mov eax, [cuenta.Edad]
    Mov [cuenta.Edad], eax
    print "Edad: ",10,13
    print str$(cuenta.Edad),13,10
    ;print Emp.Edad

    inkey
main endp

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

end start



