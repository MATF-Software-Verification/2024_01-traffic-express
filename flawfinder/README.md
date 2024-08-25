## Preduslovi pokretanja za flawfinder

Na mašini na kojoj se skripta pokreće potrebno je instalirati flawfinder.

```bash
sudo apt-get install flawfinder
```

### Pokretanje
Nakon kloniranja repozitorijuma potrebno je pozicionirati se u folder /flawfinder.
Pre pokretanja skripte, potrebno je podesiti joj prava pristupa.

```bash
cd flawfinder

chmod +x flawfinder.sh

```

Pokretanjem skripte `flawfinder.sh`, pokrece se alat flawfinder za analizu bezbednosnih ranjivosti u kodu. Rezultati analize se čuvaju u HTML fajlu koji se zatim automatski otvara u web pregledaču (Firefox).

```bash
./flawfinder.sh
```
Rezultati se cuvaju u `flawfinder_result.txt`