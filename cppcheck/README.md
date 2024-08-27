## Preduslovi pokretanja za cppcheck

Na mašini na kojoj se skripta pokreće potrebno je instalirati cppcheck i cppcheck-htmlreport.

```bash
sudo apt-get install cppcheck cppcheck-htmlreport
```

### Pokretanje
Nakon kloniranja repozitorijuma potrebno je pozicionirati se u folder /cppcheck.
Pre pokretanja skripte, potrebno je podesiti joj prava pristupa.

```bash
cd cppcheck

chmod +x cppcheck.sh

```

Pokretanjem skripte `cppcheck.sh`, pokrece se alat cppcheck za staticku analizu koda (kod se analizira bez njegovog izvrsavanja). Ukoliko nije suprotno naglaseno, dodavanjem opcije -n, rezultati pokretanja ovog alata ce se cuvati i u vidu html fajlova u okviru direktorijuma `cppcheck_report`

```bash
./cppcheck.sh [-o output_file] [-n] source1 [source2 ...]
```
