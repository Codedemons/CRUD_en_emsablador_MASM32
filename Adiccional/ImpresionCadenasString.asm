include\masm32\include\masm32rt.inc

.data
       number DD 0
.code   
start:

    cls
    
    mov EBX,[number]
        
    
    .while EBX < 10
   
    mov [number],EBX
    print str$(number)," numero",13,10,0
    inc EBX
    .endw
    

    ccout "\t C style string formatting\n\t in MASM\n"
    
    inkey
    invoke ExitProcess,0
end start

