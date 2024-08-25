## Preduslovi pokretanja callgrind-a

Na mašini na kojoj se skripta pokreće potrebno je instalirati Valgrind i KCacheGrind alate.

```bash
sudo apt-get install valgrind
sudo apt-get install kcachegrind
```

### Pokretanje
Nakon kloniranja repozitorijuma potrebno je pozicionirati se u folder /callgrind.
Pre pokretanja skripti, potrebno je podesiti im prava pristupa.

```bash
cd callgrind

chmod +x build_callgrind.sh
chmod +x callgrind.sh

```

Prvo pokrećemo skriptu za izgradnju projekta `build_callgrind.sh`.
Ukoliko je ona uspešno izvršena, pokrećemo skriptu `callgrind.sh` koja radi profajliranje. Prilikom pokretanja skripte, možete koristiti opcije -a koja omogućava callgrind_annotate radi generisanja čitljivijeg izveštaja i -k za omogućavanje KCacheGrind vizualizacije. Ukoliko pokrenete skriptu sa -k opcijom, pokrenuće se KCachegrind konzola.
Nakon toga pokrećemo skriptu `clean_callgrind.sh` koja će ukloniti sve nepotrebne fajlove.

```bash
./build_callgrind.sh
./callgrind.sh [-a] [-k]

...

./clean_callgrind.sh

```

Skripte ce izvršiti build projekta u DEBUG režimu i pokrenuće callgrind alat nad izvršnom datotekom koja je prethodno kreirana.

Izlaz callgrind alata nalazi se u okviru direktorijuma /callgrind u .out fajlovima. 
