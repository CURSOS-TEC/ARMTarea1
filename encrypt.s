AREA
			;		Name this block of code ARMex
ENTRY                   ; Mark first instruction to execute
start
			;		Set the data of Hello; world!EOL
			
			
			MOV		r0, #72       ; Valor inicial de la letra [H]
			MOV		r1, #0x300      ; la dirección donde va a estar el valor inical
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #104      ; Valor semilla de la letra [e]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #108       ; Valor semilla de la letra [l]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #108       ; Valor semilla de la letra [l]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #111       ; Valor semilla de la letra [o]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #44       ; Valor semilla de la letra [;]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #32       ; Valor semilla de la letra [_]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #87       ; Valor semilla de la letra [W]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #111       ; Valor semilla de la letra [o]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #114       ; Valor semilla de la letra [r]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #108       ; Valor semilla de la letra [l]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #100      ; Valor semilla de la letra [d]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #33       ; Valor semilla de la letra [!]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
			MOV		r0, #0x0A     ; Valor semilla de la letra [EOL]
			STR		r0, [R1]      ; Almacenar los datos en la dirección
			ADD		r1, r1, #4    ; preparar la siguiente dirección de memoria a guardar.
			
process
			MOV		r1, #0x300    ; Reiniciar R1 en 0x200
			LDR		r7, [r1]      ; Guardar en R7 Cada caracter de la palabra
			MOV		r2, #78 	    ; Se define primer pseudoaleatorio Navarro = [78]
			ADD		r7, r7,#29    ; Se le suma 29 en decimal
			EOR		r7, r7,r2     ; Se aplica  ((r7 + 0x29d) xor r2)
			STR		r7, [R1]      ; Guardar en la dirección de memoria de R1
			
LOOP_ENCRYPT
			ADD		r1, r1, #4  ; preparar la siguiente dirección de memoria a guardar.
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
			
			LDR		r7, [r1]      ; Guardar en R7 el siguiente caracter de la palabra
			ADD		r7, r7,#29    ; Se le suma 29 en decimal a r7
			EOR		r7, r7,r2     ; Se aplica  ((r7 + 0x29d) xor r2)
			STR		r7, [R1]      ; Guardar en la dirección de memoria de R1
			CMP		r1, #0x334
			BEQ		INIT_DECRYPT
			B		LOOP_ENCRYPT
			
INIT_DECRYPT
			
			MOV		r1, #0x300    ; Reiniciar R1 en 0x200
			LDR		r7, [r1]      ; Guardar en R7 Cada caracter de la palabra
			MOV		r2, #78 	    ; Se define primer pseudoaleatorio Navarro = [78]
			EOR		r7, r7,r2     ; Se aplica  (r7 xor r2)
			SUB		r7, r7,#29    ; Se le suma 29 en decimal
			STR		r7, [R1]      ; Guardar en la dirección de memoria de R1
			
LOOP_DECRYPT
			ADD		r1, r1, #4  ; preparar la siguiente dirección de memoria a guardar.
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
			
			
			LDR		r7, [r1]      ; Guardar en R7 el siguiente caracter de la palabra
			EOR		r7, r7,r2     ; Se aplica  (r7  xor r2 )
			SUB		r7, r7,#29    ; Se le resta 29 en decimal a r7
			STR		r7, [R1]      ; Guardar en la dirección de memoria de R1
			CMP		r1, #0x334
			BEQ		finish
			B		LOOP_DECRYPT
finish
			END
