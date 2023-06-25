;ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
;  ///////////////// librerias a utilizar //////////////////////////
    include \masm32\include\masm32rt.inc
; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл


title Proyecto
.data
; asignacion de los datos    
 x dd "ana"
 
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
    LOCAL txt  :DWORD
     sas txt,"hola"
   

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

    ;Mov [cuenta.Nombre],"hola"
    
    print "Nombre: ",10,13
    ;print str$(cuenta.Nombre),13,10
    ;print ADDR [cuenta.Nombre],13,10
    printf("%s\tcadena\n",cuenta.Nombre);  
    ;printf("%s\tcadena\n",x);  

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



