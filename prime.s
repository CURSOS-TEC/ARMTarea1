					
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
					BGT		finish           ; llegamos al final y finalizamos
					MOV		r8, #0           ; iniciar i = 0, i es usado cpara p*(p + i)
					B		erasthotenes     ; utilizar este valor obtenido.

					;Apartir de esta seccion r0 sera la alineacion de la memoria que inicia en 0x300
					
					
finish
					END
