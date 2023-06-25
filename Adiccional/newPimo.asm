include \masm32\include\masm32rt.inc

.data
i DD 0


.code
start:
  cls     
  mov eax,0
  mov ebx,1
  mov ecx,0
  mov edx,0
  mov eax,1
  .repeat 
    print str$(ebx),32     
    mov eax,ebx
    call ADD_div
    print " ",10,13
    inc ebx                                                               
  .until ebx==20
  
  JMP end_div; salta hasta end_sample
    ADD_div:
             mov i,ebx                                        
             mov edx,0
             mov ebx,2
             mov ecx,0                                         
            .repeat                    
               mov edx,0
               div bx
                ;mov ecx,1
                .if edx == 0
                    mov ecx,1
                .endif
                           
            .until ebx <= 20
            .if ecx == 1
                print "si es primo",32                    
            .else
                print "no es primo",32
            .endif
        mov ebx,i
        RETN     
  end_div:      
  inkey      
	INVOKE ExitProcess, 0


end start
