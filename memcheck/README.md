## Preduslovi pokretanja memcheck-a

Na mašini na kojoj se skripta pokreće potrebno je instalirati Valgrind i Memcheck alate.

```bash
sudo apt-get install valgrind
sudo apt-get install memcheck
```

### Pokretanje
Nakon kloniranja repozitorijuma potrebno je pozicionirati se u folder /memcheck.
Pre pokretanja skripti, potrebno je podesiti im prava pristupa.

```bash
cd memchecm

chmod +x memcheck.sh
chmod +x memcheck_analyze.sh

```

Pokrećemo skriptu `memcheck.sh`. Ova skripta pokrece alat `memcheck` koji sluzi za detekciju curenja memorije i greski sa memorijom. Izlaz alata se cuva u `memcheck_*.out` fajlovima.
Za jednostavnu proveru da li je doslo do greske ili curenja memorije moze se pokrenuti `memcheck_analyze.sh` skripta, koja prasira prethodno pomenute izlaze i proverava da li neki od njih sadrzi informaciju o greskama ili curenju memorije.

```bash
./memcheck.sh
./memcheck_analyze.sh

```
