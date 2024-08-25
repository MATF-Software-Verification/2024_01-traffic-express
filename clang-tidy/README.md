## Preduslovi pokretanja za clang-tidy

Na mašini na kojoj se skripta pokreće potrebno je instalirati clang-tidy.

```bash
sudo apt-get install clang-tidy
```

### Pokretanje
Nakon kloniranja repozitorijuma potrebno je pozicionirati se u folder /clang-tidy.
Pre pokretanja skripte, potrebno je podesiti joj prava pristupa.

```bash
cd clang-tidy

chmod +x clang-tidy.sh

```

Pokretanjem skripte `clang-tidy.sh`, pokrece se build aplikacije i nakon toga pokrece clang-tidy sa sledecim opcijama:
`modernize-use-override` koja proverava da li se `override` koristi na ispravan nacin i na ispravnim mestima, sto popravlja citljivost koda i sprecava potencijalne bagove.
`modernize-use-nullptr` koja predlaze da se upotreba `NULL` zameni za upotrebu `nullptr` koja je bezbedna konstantna vrednost za null u modernom C++
`readability-const-return-type` koja zahteva da metode koje vraćaju pokazivače ili reference koriste const za povratni tip kada je to primenjivo, čime se poboljšava čitljivost i tačnost koda.

```bash
./clang-tidy.sh
```
Rezultati se cuvaju u `clang-tidy-output.txt`