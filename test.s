						
AREA
						;Name	this block of code ARMex
ENTRY                             ;Mark first instruction to execute
						MOV		r1, #0x300    ;primera direccion
						MOV		r0, #2        ;Iniciar el valor del primer numero
						STR		r0, [r1], #4  ; guardar con autoincremento
						ADD		r0, r0, #1    ;incrementar r0
populate
						AND		r2, r0, #1    ; aplicar mascara para verr si es par
						CMP		r2, #0        ; si es cero es par.
						BNE		continue_populate
						MOV		r2, #1
						STR		r2, [r1], #4  ; guardar con autoincremento
						B		next_number_to_populate
continue_populate
						STR		r0, [r1], #4  ; guardar con autoincremento
next_number_to_populate
						ADD		r0, r0, #1    ;incrementar r0
						CMP		r0, #256
						BGT		init_erasthotenes
						B		populate
init_erasthotenes
						MOV		r1, #0x304   ; Inicar puntero a memoria en 0x204 comenzamos con 3
						MOV		r8, #0       ; iniciar i = 0, i es usado cpara p*(p + i)
						
erasthotenes
						LDR		r7, [r1]     ; p
						ADD		r9, r7, r8   ; p + i
						MOV		r10, r7      ; p guardar el numero temporal r7
multiply
						CMP		r9, #1       ; r9 == 1 ?, si es verdad se termina la iteracion para multiplicar
						BEQ		continue
						ADD		r10, r10, r7 ; p + p
						SUB		r9, r9, #1   ; r9--
						CMP		r10, #256        ; comparar a ver si llego al limite  ------------------256
						BGT		next_not_mnarked ; ir al siguiente numero no marcado.
						B		multiply
continue
						CMP		r10, #256        ; comparar a ver si llego al limite ------------------256
						BGT		next_not_mnarked ; ir al siguiente numero no marcado.
						SUB		r0, r10,#2       ; (pi+1 - pi)
						LSL		r0, r0, #2       ; (pi+1 - pi)*4 para direccionar memoria
						Add		r0, r0, #0x300   ;
						MOV		r10, #0x1        ; establecer este valor como no primo
						STR		r10,  [r0]       ; store value
						ADD		r8, r8, #1       ; incrementar el siguiente i
						B		erasthotenes
next_not_mnarked
						ADD		r1, r1, #4       ; cambaiar a la siguiente celda
						LDR		r7, [r1]         ; cargar el numero en el registro 7
						CMP		r7, #1           ; comparar si es marcado
						BEQ		next_not_mnarked ; continuar buscando
						CMP		r7, #17          ; llegamos al final y no encontramos mas numneros sin marcar ------------------256
						BGT		initvars_LFRS           ; llegamos al final y finalizamos
						MOV		r8, #0           ; iniciar i = 0, i es usado cpara p*(p + i)
						B		erasthotenes     ; utilizar este valor obtenido.
						
						;Apartir	de esta seccion r0 sera la alineacion de la memoria que inicia en 0x300
initvars_LFRS
						MOV		r2, #78 	    ; Se define primer pseudoaleatorio Navarro = [78]
						LSL		r2, r2, #24       ; BBBB BBBB 0X0 0x0 0x0 0X0 0x0 0x0
						MOV		r6, #1
						MOV		r1, #0x700
						MOV		r8, #0x300
						
generate_new_random
						ADD		r6,r6,#1
						ROR		r3, r2, #9  ; Tomamos el bit 8 y lo llevamos al frente (A)
						ROR		r4, r2, #11 ; Tomamos el bit 6 de R2 y lo llevamos al frente (B)
						EOR		r5, r3, r4  ; XOR  A xor B = (C)
						ROR		r4, r2, #12 ; Tomamos el bit 5 de R12 y lo llevamos al frente (D)
						EOR		r5, r5,r4   ; C xor D = (F)
						ROR		r4, r2, #13 ; tomo el bit 4 de r2 y lo llevo al frente (E)
						EOR		r5, r5, r4  ; e xor f = G
						MOV		r3, #1      ; inicializamos r3 con 1
						ROR		r3, r3, #1  ; llevamos ese 1 al frente 1000000..0
						AND		r5, r5, r3  ; (MSB)xxxxx...x and 100000...0 = (MSB1)00000...0
						LSR		r2, r2, #1  ; desplazar siempre con cero hacia la derecha 0(MSB2)xxxxx...x
						ADD		r2, r2, r5  ; sumar 0(MSB2)xxxxx...x + (MSB1)00000...0  = (MSB1)(MSB2)xxxxx...x Nuevo pseudoaleatorio
						MOV		r7, r2      ; init r7
						LSR		r7, r7, #24 ; only 8 bits
						SUB		r9, r7, #2  ; obtener diferencia respecto a dos.
						LSL		r9, r9, #2  ; (diff)*4 para direccionar memoria
						Add		r9, r9, #0x300 ; indexe
						LDR		r10, [r9]   ;cargar dicho numero en r10
						CMP		r10, #1     ;Verifica si es 1
						BEQ		continue_seek_sprime_number
						CMP		r10, #0     ;no agregar valores cero
						BEQ		continue_seek_sprime_number
save_prime_number
						STR		r7, [r1], #4  ; auto incremento
continue_seek_sprime_number
						CMP		r6, #100
						BEQ		finish
						B		generate_new_random
finish
						END
