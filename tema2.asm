%include "include/io.inc"

extern atoi
extern printf
extern exit

; Functions to read/free/print the image.
; The image is passed in argv[1].
extern read_image
extern free_image
; void print_image(int* image, int width, int height);
extern print_image

; Get image's width and height.
; Store them in img_[width, height] variables.
extern get_image_width
extern get_image_height

section .data
	use_str db "Use with ./tema2 <task_num> [opt_arg1] [opt_arg2]", 10, 0

section .bss
    task:       resd 1
    img:        resd 1
    img_width:  resd 1
    img_height: resd 1

section .text


global task1
task1:
    push ebp
    mov ebp, esp
    mov ecx, 0    ;se cauta cheia cu ecx
    
find_key:
    cmp ecx, 255
    je exit_task1
    inc ecx       ;se incrementeaza ecx pana se gaseste cheia
    
    mov ebx, -1   ;in ebx se salveaza linia la care e mesajul
    
    xor esi, esi  ;folosit ca si indicele elementului curent
    xor edi, edi  ;folosit pt a retine indicele liniei curente
                  ;creste cu [img_width] la cresterea liniei
    sub edi, [img_width]    ;incepe de la -[img_width]

column1:
    ;parcurgere pe coloana
    inc ebx
    add edi, [img_width]
    xor edx, edx    ;folosit pt indicele elementului de pe linie
    
    cmp ebx, [img_height]   
    jge find_key
    
row1:
    ;parcurgere pe rand
    cmp edx, [img_width]
    jge column1
    
    mov eax, [img]
    mov eax, [eax + 4*esi]  ;obtinerea caracterului
    xor eax, ecx

    cmp eax, 'r'            ;comparare cu 'r' din "revient"
    je test_revient
    
continue_search:
    ;se continua parcurgerea
    inc esi
    inc edx
    jmp row1
    
test_revient:
    ;se testeaza daca am gasit cuvantul "revient"
    mov eax, [img]
    mov eax, [eax + 4*esi + 4]
    xor eax, ecx
    cmp eax, 'e'
    jne continue_search 
    
    mov eax, [img]
    mov eax, [eax + 4*esi + 8]
    xor eax, ecx
    cmp eax, 'v'
    jne continue_search
    
    mov eax, [img]
    mov eax, [eax + 4*esi + 12]
    xor eax, ecx
    cmp eax, 'i'
    jne continue_search
    
    mov eax, [img]
    mov eax, [eax + 4*esi + 16]
    xor eax, ecx
    cmp eax, 'e'
    jne continue_search
    
    mov eax, [img]
    mov eax, [eax + 4*esi + 20]
    xor eax, ecx
    cmp eax, 'n'
    jne continue_search
    
    mov eax, [img]
    mov eax, [eax + 4*esi + 24]
    xor eax, ecx
    cmp eax, 't'
    jne continue_search
    
    ;s-a gasit mesajul
    ;se salveaza cheia si linia in eax
    mov eax, ecx
    shl eax, 16
    add eax, ebx    
    
exit_task1:   
    leave
    ret


global print_message
print_message:

    push ebp
    mov ebp, esp
    mov ebx, [esp + 8]      ;linia
    mov ecx, [esp + 12]     ;cheia
    
    imul ebx, [img_width]
print_ch:
    ;afisarea fiecarui caracter din mesaj
    mov eax, [img]
    mov eax, [eax + 4*ebx]
    xor eax, ecx
    
    ;se testeaza daca este terminatorul de sir
    cmp eax, 0
    je exit_print_messaje
    
    ;afisare caracter
    PRINT_CHAR eax
    inc ebx
    jmp print_ch
 
 exit_print_messaje:
    leave 
    ret   


global task2
task2:
    push ebp
    mov ebp, esp
    mov esi, [esp + 8]      ;linia
    mov edi, [esp + 12]     ;cheia
    
    ;se obtine indicele de unde trebuie scris mesajul
    inc esi
    imul esi, [img_width]
    
    ;initializare registrii folositi la parcurgere
    mov ebx, -1
    mov ecx, 0

column2:
    ;parcurgere pe coloana
    inc ebx
    cmp ebx, [img_height]
    jge put_message
    
    xor edx, edx    ;folosit pt indicele elementului de pe linie

row2:
    ;parcurgere pe rand
    cmp edx, [img_width]
    jge column2

    mov eax, [img]    
    mov eax, [eax + 4*ecx]  ;obtinerea caracterului
    xor eax, edi            ;se aplica xor-ul
    
    push ebx
    mov ebx, eax    
    mov eax, [img]
    mov [eax + 4*ecx], ebx  ;se modifica in reprezentarea imaginii
    pop ebx

    inc edx
    inc ecx
    jmp row2
    
put_message:
    ;se pune mesajul pe linia dorita
    mov eax, [img]
    imul esi, 4
    mov [eax + esi], word 'C'
    mov [eax + esi + 4], word 39   ;caracterul apostrof
    mov [eax + esi + 8], word 'e'
    mov [eax + esi + 12], word 's'
    mov [eax + esi + 16], word 't'
    mov [eax + esi + 20], word ' '
    mov [eax + esi + 24], word 'u'
    mov [eax + esi + 28], word 'n'
    mov [eax + esi + 32], word ' '
    mov [eax + esi + 36], word 'p'
    mov [eax + esi + 40], word 'r'
    mov [eax + esi + 44], word 'o'
    mov [eax + esi + 48], word 'v'
    mov [eax + esi + 52], word 'e'    
    mov [eax + esi + 56], word 'r'
    mov [eax + esi + 60], word 'b'
    mov [eax + esi + 64], word 'e'
    mov [eax + esi + 68], word ' '
    mov [eax + esi + 72], word 'f'
    mov [eax + esi + 76], word 'r'
    mov [eax + esi + 80], word 'a'
    mov [eax + esi + 84], word 'n'
    mov [eax + esi + 88], word 'c'
    mov [eax + esi + 92], word 'a'
    mov [eax + esi + 96], word 'i'
    mov [eax + esi + 100], word 's'
    mov [eax + esi + 104], word '.'
    mov [eax + esi + 108], word 0  
get_new_key:
    ;se calculeaza noua cheie dupa formula data
    xor edx, edx
    mov eax, edi
    add eax, eax
    add eax, 3
    mov ecx, 5
    div ecx
    sub eax, 4  
 
    mov esi, eax        ;se retine in esi rezultatul
    
    mov ebx, -1
    xor ecx, ecx  
    
column3:
    ;parcurgere pe coloana
    inc ebx
    xor edx, edx  
    cmp ebx, [img_height]
    jge exit_task2
   
row3:
    ;parcurgere pe rand
    cmp edx, [img_width]
    jge column3
    
    mov eax, [img]
    mov eax, [eax + 4*ecx]
    xor eax, esi        ;se aplica xor-ul
 
    mov edi, eax
    mov eax, [img]
    mov [eax + 4*ecx], edi  ;modificarea in reprezentarea imaginii
    
    inc edx
    inc ecx
    jmp row3

exit_task2:
    ;afisare imagine si iesire
    push dword[img_height]
    push dword[img_width]
    push dword[img]
    call print_image
    add esp, 12
    
    leave
    ret
    

global main
main:
    ; Prologue
    ; Do not modify!
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 1
    jne not_zero_param

    push use_str
    call printf
    add esp, 4

    push -1
    call exit

not_zero_param:
    ; We read the image. You can thank us later! :)
    ; You have it stored at img variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img], eax

    ; We saved the image's dimensions in the variables below.
    call get_image_width
    mov [img_width], eax

    call get_image_height
    mov [img_height], eax

    ; Let's get the task number. It will be stored at task variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 8]
    call atoi
    add esp, 4
    mov [task], eax

    ; There you go! Have fun! :D
    mov eax, [task]
    cmp eax, 1
    je solve_task1
    cmp eax, 2
    je solve_task2
    cmp eax, 3
    je solve_task3
    cmp eax, 4
    je solve_task4
    cmp eax, 5
    je solve_task5
    cmp eax, 6
    je solve_task6
    jmp done

solve_task1:

    call task1
    
    mov bx, ax      ;extragere cheie
    shr eax, 16
    mov cx, ax      ;extragere linie
    
    push ecx
    push ebx
    call print_message  ;afisarea imaginii
    pop ebx
    pop ecx
    
    ;afisarea cheii si liniei la care se afla mesajul
    NEWLINE    
    PRINT_UDEC 4, ecx
    NEWLINE
    PRINT_UDEC 4, ebx

    jmp done
solve_task2:
       
    call task1

    mov bx, ax      ;extragere cheie
    shr eax, 16
    mov cx, ax      ;extragere linie    
    
    push ecx
    push ebx
    call task2      ;modifica imaginea cum este specificat
    pop ebx
    pop ecx
    
    jmp done
solve_task3:
    ; TODO Task3
    jmp done
solve_task4:
    ; TODO Task4
    jmp done
solve_task5:
    ; TODO Task5
    jmp done
solve_task6:
    ; TODO Task6
    jmp done

    ; Free the memory allocated for the image.
done:
    push DWORD[img]
    call free_image
    add esp, 4

    ; Epilogue
    ; Do not modify!
    xor eax, eax
    leave
    ret
    
