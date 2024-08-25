# Analiza projekta 'Traffic Express'

GitHub repozitorijum posvećen izradi samostalnog praktičnog seminarskog rada za potrebe kursa Verifikacija softvera na master studijama Matematičkog fakulteta u Beogradu.
Praktični seminarski rad podrazumeva primenu alata za statičku i dinamičku verifikaciju softvera na izabranom studentskom projektu. 

**Autor: Teodora Vasić 1039/2023**

## Opis analiziranog projekta
**Trafic Express** je igra rađena po uzoru na društvenu igru Colt Express. Broj igrača je od 3 do 5. 

U beogradskoj gužvi, u 5 popodne, voz stoji zaglavljen sa 47 putnika u njemu. Nekoliko minuta kasnije, čuje se pucnjava i trčanje po krovu. Došli su teško naoružani banditi, da poštenim građanima otmu novac.
Svaki igrač je bandit i njegov cilj je da postane najbogatiji bandit u Beogradu!

Partija se sastoji od 5 rundi, a svaka runda ima dve faze:
- Faza 1: Svaki igrač postavlja 2-5 akcionih karata iz svoje ruke na zajedničku gomilu, pri čemu su karte okrenute nadole ili nagore, u zavisnosti od vrste runde. Umesto da igra kartu, igrač može i da vuče 3 karte iz svog špila.
- Faza 2: Akcione karte se prikazuju redosledom kojim su igrane i igrači biraju način na koji će ih odigrati.

Igra se odvija u vozu u kojem banditi mogu da se kreću iz jednog vagona u drugi, da trče po krovu, da udaraju druge bandite, pucaju u njih, pljačkaju druge putnike i pomeraju maršala. 
Voz ima onoliko vagona koliko je igrača, a svaki vagon ispunjen je draguljima, vrećama s novcem i koferima.

Svaki igrač počinje rundu sa 6 karata u ruci, pri čemu svaka karta označava jednu od ovih radnji. Na početku runde, otkriva karta koja prikazuje koliko će karata biti odigrano, da li će se igrati licem nagore ili nadole, pojedinačno ili u parovima, kao i koja će se akcija desiti na početku runde.
Igrač može da pokupi vreće, dragulje i kofere samo igranjem karte za krađu kada je u istom vagonu koji sadrži jedan od ovih predmeta - ali pošto svi planiraju da ukradu ovo blago, moraće da se kreće, udara i puca, ne bi li mu se ostali banditi sklonili s puta. Igrač može udariti nekoga samo u istom vagonu, a kada to uradi, bandit mora ispustiti blago.

Igrač može upucati nekog drugog igrača u susednom automobilu ili, ako je na krovu, bilo koga na vidiku. Kada to uradi, tom igraču daje jednu od svojih 6 karata metaka; ta karta se meša u protivničkom špilu, što mu verovatno daje mrtvu kartu u ruci, u budućem potezu i primorava da vuče karte umesto da igra. 
Ako se maršal nađe u istom vagonu kao i igrač, to je verovatno jer ga suparnici mame i rado će mu dati i metak. 

Na kraju igre, pobednik je igrač koji je sakupio najviše blaga!


## Osnovne informacije o analizi
[GitHub repozitorijum projekta](https://gitlab.com/matf-bg-ac-rs/course-rs/projects-2022-2023/01-traffic-express.git) 
[Commit sha](385edda7bb1f4d8c487d9f00193ca28c11517135) 

Sama analiza biće izvršena nad **main** granom. 
 