# Tema2IOCLA-Stegano
[Tema2 Introducerea in Organizarea Calculatoarelor si Limbaj de Asamblare (2019-2020, seria CB)] 


#### IMPLEMENTARE TASK1

Task-ul 1 presupune implementarea unui Bruteforce pe XOR cu cheie de un octet.
S-a realizat functia task1 care obtine cheia si linia la care se afla mesajul
care contine cuvantul ```"revient"```. Aceasta testeaza pentru fiecare numar din 
intervalul [0-255] daca acesta este cheia. Labelul find_key parcurge reprezentarea
imaginii pt fiecare numar din acel interval pana gaseste cheia valida.
Parcurgerea se face tinand cont de ```img_heigth``` si ```img_width```. Se testeaza prima 
oara caracterul 'r', in cazul in care se gaseste testandu-se si fiecare litera
din "revient" (in ```test_revient```). Daca se gaseste doar partial cuvantul "revient"
se continua cautarea de la pozitia urmatoare. Daca s-a gasit cuvantul se retin
in eax cheia si linia la care s-a gasit mesajul si se iese.
Functia ```print_message``` afiseaza mesajul de la linia gasita dupa xorarea fiecarui
element cu cheia pana la intalnirea terminatorului de sir.

#### IMPLEMENTARE TASK2

Task-ul 2 preupune decodificarea mesajului cu cheia gasita anterior, adaugarea
unui mesaj pe linia urmatoare celei pe care se afla mesajul gasit inainte si
apoi codificarea folosind o noua cheie. Se extrage linia si cheia apeland
task1. Functia task2 aplica xor pe imagine prin parcurgerea ei si modifica
in reprezentarea ei elementul curent cu cel xorat. Apoi la linia corespunzatoare
se pune mesajul ```"C'est un proverbe francais."```. Se calculeaza noua cheie cu formula
data si se parcurge iar imaginea, facandu-se xor din nou pe imagine, de data
aceasta cu noua cheie. La terminarea parcurgerii se apeleaza  ```print_image``` si se iese.
