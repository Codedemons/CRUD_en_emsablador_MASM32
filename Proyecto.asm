  INCLUDE \masm32\INCLUDE\masm32rt.inc
    
    
  .DATA
        Opc dd ?  ;//variable para el switch opcional
        Bucle dd ? ;//variable para el switch despedida
        consoleTitle db "Proyecto",0; //variable para titulo de la ventana

           ;//Estrutura
        emp STRUCT
      	Num     DWORD ?  ;//Campo de estrutura
            Nombre  DD ?     ;//Campo de estrutura
            Edad    DWORD ?  ;//Campo de estrutura
        emp ENDS
    
        cuenta emp {} ;//inicialion vacia de la estrutura

 .CODE           
       
   START:
           mov edx, offset consoleTitle; //llama a la variabla titulo
           call procSetTitle; //llama a la funcion
           mov eax,0
           mov ebx,0
           mov ecx,0
           mov edx,0
    	
       CALL main
       inkey
       INVOKE ExitProcess, 0
       exit
    
     main PROC        
                   LOCAL fname :DWORD                          ;nombre archivo
                   LOCAL hFile :DWORD                          ; identificador de archivo
                   LOCAL bwrt  :DWORD                          ; variable para bytes escritos
                   LOCAL cloc  :DWORD                          ; variable de ubicación actual
                   ;LOCAL flen  :DWORD                          ; variable de longitud de archivo
                   LOCAL hMem  :DWORD                          ; identificador de memoria asignada
                   LOCAL limit :DWORD                          ; limite de datos o contiene ','
    
                   LOCAL rslt  :DWORD
                   LOCAL hArr  :DWORD
                   LOCAL void  :DWORD
                   LOCAL acnt  :DWORD
                   LOCAL atot  :DWORD               
    		       LOCAL fArr	:DWORD
       		 LOCAL value:DWORD
                   LOCAL nam	:DWORD    

                   LOCAL edad:DWORD
                   LOCAL mods :DWORD
                   LOCAL spac  :DWORD
                   LOCAL pbuf  :DWORD
                   LOCAL buffer[512] :TCHAR


                   ;//asignacion de nombre
                   
              	 sas fname,"MyFile.txt" ;//nombre del archivo    
              	 sas limit,","  

                   ;//comprueba la existencia del archivo
                  .if rv(exist,fname) != 0            ; test if file exists
                      mov hFile, fopen(fname)           ; open it if it does
                  .else
                      mov hFile, fcreate(fname)         ; otherwise create a new file
                  .endif
                  fclose hFile   
    
                
             .repeat    ;//bucle condicional de opciones 
                ccout "\tSistema de Estrutura de datos\n\n"
                ccout "\t1.Registrar Datos\n\n"
                ccout "\t2.Consultar Datos\n\n"
                ccout "\t3.Modificar Datos\n\n"
                ccout "\t4.Eliminar Datos\n\n"
                
    		print "Opcion: "
                MOV Opc, input()
                switch$ Opc ;//switch de opciones a demas codigo
                  case$ '1'
                      cls   ;Limpiar pantalla
    
                      ccout "\t1.Registrar Datos\n\n"
    
                      mov hFile,fopen(fname) ;//abre el archivo



       	          print "INGRESE NUMERO: "
        		    MOV [cuenta.Num], input() ;//iingresa datos a la estrutura
        
    	       	    print "INGRESE NOMBRE: "
            	    MOV [cuenta.Nombre], input() ;//iingresa datos a la estrutura
                                        
      	          print "INGRESE EDAD: "
            	    MOV [cuenta.Edad], input() ;//iingresa datos a la estrutura
    
                      ;//encuntra la posicion final en el archivo
                      mov cloc, fseek(hFile,0,FILE_END)

                      ;//escribe la estrutura en el archivo   
                      mov bwrt, fwrite(hFile,cuenta.Num,len(cuenta.Num)) 
                      mov bwrt, fwrite(hFile,limit,len(limit))                           
                      mov bwrt, fwrite(hFile,cuenta.Nombre,len(cuenta.Nombre))
                      mov bwrt, fwrite(hFile,limit,len(limit))                           
       	          mov bwrt, fwrite(hFile,cuenta.Edad,len(cuenta.Edad))
       
                      ;//hace un salto de linea en el archivo
                      fprint hFile," "
                       
                      fclose hFile                                ; close the file
    
  
            	    ccout "\n"		
                      ;//imprime los datos de la estrutura
    		          print "NUMERO: "
	       	    printf("%s\n", [cuenta.Num]) ;con macro de C
    
        		    print "NOMBRE: "
		          printf("%s\n", [cuenta.Nombre]) ;con macro de C
		
	       	    print "EDAD: "
        		    printf("%s\n", [cuenta.Edad]) ;con macro de C
    

    	           	    ccout "\n"
    
                  case$ '2' 
                      cls
                      ccout "\t2.Consultar Datos\n\n"
                      ;//Coloca datos en la pila
                      PUSH EBX
    			    PUSH ESI
    			    PUSH EDI
                      ;//imvoca los salto de lineas
    			    INVOKE GetTickCount
    			    ;//Coloca datos en la pila
                      PUSH EAX
    
         		    ; --------------------
       		    ; cargar archivo en matriz o arreglo
    			    ; --------------------
    			    MOV hArr, arrfile$(fname) ;//almacena el contenido del archivo en un arreglo
    			    MOV acnt, arrcnt$(hArr)             ; obtener el número de miembros de la matriz
    
       		    INVOKE GetTickCount

                      ;//Recupera un dato de la pila
    			    POP ECX
                      ;//realiza una resta
    		  	    SUB EAX, ECX	

                      ;//incrementa para que aparezca el ultimo dato del archivo  
                      inc acnt
    			    MOV EBX, 1                      ; establecer el índice en 1 para una matriz basada en 1

                        ;//imprime los datos del archivo cargado al arreglo
    				.WHILE EBX < acnt
  					printf("\nEmpleados %d: %s", EBX,arrget$(hArr, EBX))                                                            

    					INC EBX
    					MOV EAX, 0d
    					MOV ECX, 0d
    					MOV EDX, 0d
    				.ENDW

 
    			    ccout "\n"
    			    MOV void, arrfree$(hArr)            ;; desasignar toda la matriz
    			    
                      ;//Recupera un dato de la pila
    			    POP EDI
    			    pop ESI
    			    POP EBX    			
                      ccout "\n"
                      
                  case$ '3'
                      cls
                      ccout "\t3.Modificar Datos\n\n"

                      ;//Coloca datos en la pila
                      push ebx
                      push esi
                      push edi
              	
                      ;//imvoca los salto de lineas
                      invoke GetTickCount
                      ;//Coloca datos en la pila
                      push eax
         		    ; --------------------
       		    ; cargar archivo en matriz o arreglo
    			    ; --------------------
                      mov hArr, arrfile$(fname)         ;//almacena el contenido del archivo en un arreglo              
                      mov acnt, arrcnt$(hArr)       ; obtener el número de miembros de la matriz
              
                      invoke GetTickCount
                      
                      ;//Recupera un dato de la pila
                      pop ecx
                      
                      ;//realiza una resta
                      sub eax, ecx
              
                      mov ebx, 1                                            ; establecer el índice en 1 para una matriz basada en 1

                      ;//bucle en sintasis ensablador para imprimir las fila del archivo
                    @@:
                      print arrget$(hArr,ebx),13,10   ; mostrar cada línea en la matriz
                      add ebx, 1
                      cmp ebx, acnt
                      jle @B

                      ;//Recupera un dato de la pila
                      pop edi
                      pop esi
                      pop ebx

                      ;//Coloca datos en la pila

                      push ebx
                      push esi
                      push edi

                                       
                      ;//bucle en sintasis ensablador para meter los datos del archivos en un arreglo
                      mov ebx, 1              ; establecer el índice en 1 para una matriz basada en 1
                    @@:
                      mov void, arrset$(hArr,arrget$(hArr,ebx),str$(arrget$(hArr,ebx)))  ; escribir datos terminados en cero en cada miembro de la matriz
                      add ebx, 1
                      cmp ebx, acnt
                      jle @B
                    

                      ;//metodo de busquedad en el arreglo                  			
			    ccout "\nBUSCAR NUMERO: "

                      ;//almacena un dato
			    MOV fArr, input()

			    MOV EBX, 1             ; establecer el índice en 1 para una matriz basada en 1

                      ;//cambia el dato del arreglo con el dato que se ingrese
		   	    .REPEAT
   				MOV value, sval(fArr) ;//convierte la cadena en entero
   				MOV EDX, [value]
   				
   				.IF EBX == EDX
   					;//imprime el campo buscado
                              printf("\nEmpleado %d: %s", EBX, arrget$(hArr, EBX))
                              ;//imprime el numero buscado o de empleado
                              printf("\nEmpleado %d: \n", EBX)     		                           
                       	      print "INGRESE NOMBRE: "
                              ;//almacena un dato
                              mov nam, input();                                    
       	       	      print "INGRESE EDAD: "
                              ;//almacena un dato
                             	mov edad, input();
                              ;//asigna un dato a una variable
                              mov spac, chr$(",")
                              ;//Convierta la dirección de una variable local en una variable de puntero.
                              mov pbuf, ptr$(buffer)
                              ;//unes los datos ingresado mas laa coma en a una sola cadena
                              mov pbuf, cat$(pbuf,ustr$(ebx),spac,nam,spac,edad)
                              ;//inserta la cadena en el arreglo remplazando la obtenida anteriormente   					
                              MOV void, arrset$ (hArr, EBX, pbuf) ;asigación al array
                              ;//imprime el arreglo nuevamente
   					printf("\nEmpleado %d: %s", EBX, arrget$(hArr, EBX))
   					ccout "\n"
   				.ENDIF
   
   				INC EBX
   				MOV EAX, 0d
   				MOV ECX, 0d
   				MOV EDX, 0d
   			  .UNTIL EBX > acnt



                    mov atot, arrtotal$(hArr,1)             ; obtener la longitud para asignar, incluido el CRLF final
                    mov hMem, alloc(atot)                   ; asignar esa cantidad de memoria
                    mov void, arr2text$(hArr,hMem)          ; escribe toda la matriz en la memoria con CRLF adjunto a cada línea
              
                    mov void, OutputFile(fname,hMem,atot)   ; escribir búfer en disco
              
                    free hMem                               ; liberar la memoria intermedia
              
                    print "archivo escrito con CRLF",13,10
                    print str$(atot)," bytes escritos en disco",13,10
              
                    mov void, arrfree$(hArr)                ; elimine todos los miembros de la matriz y la matriz de puntero principal


                    ;//Recupera un dato de la pila
                    pop edi
              	  pop esi
                    pop ebx
                                       
                  case$ '4'
                      cls
                      ccout "\t4.Eliminar Datos\n\n"                                        
                      ;//Coloca datos en la pila
                      push ebx
                      push esi
                      push edi
              	    
                      ;//imvoca los salto de lineas
              	    invoke GetTickCount
                      push eax
              
                      ; --------------------
       		    ; cargar archivo en matriz o arreglo
    			    ; --------------------

                      mov hArr, arrfile$(fname)  ;//almacena el contenido del archivo en un arreglo                         
                      mov acnt, arrcnt$(hArr)     ; obtener el número de miembros de la matriz
              
                      invoke GetTickCount   

                      ;//Recupera un dato de la pila
                      pop ecx
                      ;//realiza una resta
                      sub eax, ecx
              
                      mov ebx, 1                       ; establecer el índice en 1 para una matriz basada en 1
                      
                      ;//bucle en sintasis ensablador para imprimir las fila del archivo                    
                     @@:
                      print arrget$(hArr,ebx),13,10   ;  ; mostrar cada línea en la matriz
                      add ebx, 1
                      cmp ebx, acnt
                      jle @B
                
             
                      ;//Recupera un dato de la pila
                      pop edi
                      pop esi
                      pop ebx

                      ;//Coloca datos en la pila
                      push ebx
                      push esi
                      push edi
              
                      mov ebx, 1                              ; ; establecer el índice en 1 para una matriz basada en 1
                     @@:
                      mov void, arrset$(hArr,arrget$(hArr,ebx),str$(arrget$(hArr,ebx)))   ;   escribir datos terminados en cero en cada miembro de la matriz
                      add ebx, 1
                      cmp ebx, acnt
                      jle @B
                  
                  			
    			    ccout "\nBuscar Empleado a Eliminar: "
                      ;//almacena un dato
			    MOV fArr, input()
			    MOV EBX, 1

                       ;//cambia el dato del arreglo con el dato en ceros
			    .REPEAT
				MOV value, sval(fArr)
				MOV EDX, [value]
				
				.IF EBX == EDX
					printf("\nEmpleado %d: %s", EBX, arrget$(hArr, EBX))
					MOV void, arrset$ (hArr, EBX, "0,0,0") ;asigación al array
					printf("\nEmpleado %d: %s", EBX, arrget$(hArr, EBX))
					ccout "\n"
				.ENDIF

				INC EBX
				MOV EAX, 0d
				MOV ECX, 0d
				MOV EDX, 0d
			   .UNTIL EBX > acnt		


                  mov atot, arrtotal$(hArr,1)              ; obtener la longitud para asignar, incluido el CRLF final
                  mov hMem, alloc(atot)                    ; asignar esa cantidad de memoria
                  mov void, arr2text$(hArr,hMem)           ; escribe toda la matriz en la memoria con CRLF adjunto a cada línea
              
                  mov void, OutputFile(fname,hMem,atot)   ; escribir búfer en disco
              
                  free hMem                               ; ; liberar la memoria intermedia
              
                  print "File written with CRLF",13,10
                  print str$(atot)," bytes written to disk",13,10
              
                  mov void, arrfree$(hArr)                ; ; elimine todos los miembros de la matriz y la matriz de puntero principal

                 ;//Recupera un dato de la pila
                  pop edi
              	pop esi
                  pop ebx

                  
              
                  default 
                      print "Error de datos "
                endsw$
                
                mov eax,0
                mov ebx,0
                mov ecx,0
                mov edx,0
                printf ("\tDesea Continuar\n")           
                printf ("\t1.si\n")           
                printf ("\t2.no\n")           
    
                print "Opcion: "
                MOV Bucle, input()
                switch$ Bucle
                  case$ '1'
                      cls
                      mov ebx,1              
                  default 
                      print "Gracias por usar el software "
                      mov ebx,0
                      inkey "por su tiempo"
                      INVOKE ExitProcess, 0
                      exit
       
                endsw$ 
          .until ebx==0   
                          
    		inkey
    	main ENDP
    
           procSetTitle proc
               pushad
                cld;
                INVOKE SetConsoleTitle, edx;
                popad;
                ret
           procSetTitle endp;
  
    
    
END START
