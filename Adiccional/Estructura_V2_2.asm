INCLUDE \masm32\INCLUDE\masm32rt.inc

TITLE Proyecto

.DATA
    Opc dd ? 
    Bucle dd ? 

    uno dd 1
	emp STRUCT
	  Num     DWORD ?
        Nombre  DD ?
        Edad    DWORD ?
    emp ENDS


    cuenta emp {}
.CODE           
   
START:
    CALL main
    inkey
    INVOKE ExitProcess, 0
    exit

	main PROC
               LOCAL hFile :DWORD                          ; file handle
               LOCAL bwrt  :DWORD                          ; variable for bytes written
               LOCAL cloc  :DWORD                          ; current location variable
               LOCAL txt   :DWORD                          ; text handle
               LOCAL flen  :DWORD                          ; file length variable
               LOCAL hMem  :DWORD                          ; allocated memory handle

            sas txt,"Test String"                       ; assign string to 
            .if rv(exist,"Struct.txt") != 0           ; if file already exists
              ;test fdelete("Struct.txt"), eax         ; delete it
            .endif

         .repeat
            ccout "\tSistema de Estrutura de datos\n\n"
            ccout "\t1.Registrar Datos\n\n"
            ccout "\t2.Consulta r Datos\n\n"
            ccout "\t3.Modificar Datos\n\n"
            ccout "\t4.Eliminar Datos\n\n"
		print "Opcion: "
            MOV Opc, input()
            switch$ Opc
              case$ '1'
                 ;cls   ;Limpiar pantalla
                  ccout "\t1.Registrar Datos\n\n"
                  mov hFile, fcreate("Struct.txt")          ; create the file            
		
	       	print "INGRESE NUMERO: "
        		MOV [cuenta.Num], input()
		      mov bwrt, fwrite(hFile,cuenta.Num,len(cuenta.Num))      

	       	print "INGRESE NOMBRE: "
        		MOV [cuenta.Nombre], input()
                  mov bwrt, fwrite(hFile,cuenta.Nombre,len(cuenta.Nombre))
	       	print "INGRESE EDAD: "
        		MOV [cuenta.Edad], input()
		      mov bwrt, fwrite(hFile,cuenta.Edad,len(cuenta.Edad))    

                  fclose hFile                                ; close the file
        		ccout "\n"
		
		      print "NUMERO: "
	       	printf("%s\n", [cuenta.Num]) ;con macro de C
    
        		print "NOMBRE: "
		      printf("%s\n", [cuenta.Nombre]) ;con macro de C
		
	       	print "EDAD: "
        		printf("%s\n", [cuenta.Edad]) ;con macro de C
    
	           	ccout "\n"

              case$ '2' 
                 ccout "\t2.Consulta r Datos\n\n"
                  mov hFile, fopen("Struct.txt")            ;  abrir el archivo existente de nuevo           
                  mov flen, fsize(hFile)                      ; obtener su longitud
                  mov hMem, alloc(flen)                       ; asignar un búfer de ese tamaño
                  mov bwrt, fread(hFile,hMem,flen)            ; leer datos del archivo en el búfer
                  fclose hFile                                ; cerar el documento
                  
                 invoke StripLF,hMem
                 
                  print hMem,13,10                            ; display text to console
 
                  free hMem                                   ; free the allocated memory
                  ccout "\n"
		
		      print "NUMERO: "
	       	printf("%s\n", [cuenta.Num]) ;con macro de C
    
        		print "NOMBRE: "
		      printf("%s\n", [cuenta.Nombre]) ;con macro de C
		
	       	print "EDAD: "
        		printf("%s\n", [cuenta.Edad]) ;con macro de C
    
	           	ccout "\n"


              case$ '3'
                  ccout "\t3.Modificar Datos\n\n"
              case$ '4'
                  ccout "\t4.Eliminar Datos\n\n"              
              default 
                  print "Error de datos "
            endsw$
            printf ("\tDesea Continuar\n")           
            printf ("\t1.si\n")           
            printf ("\t2.no\n")           

            print "Opcion: "
            MOV Bucle, input()
            switch$ Bucle
              case$ '1'
                  mov ebx,1                  
              default 
                  print "Gracias por usar el software "
                  mov ebx,0
            endsw$ 
      .until ebx==0   
                      
		inkey
	main ENDP

END START