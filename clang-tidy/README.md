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
`modernize-use-override`: Preporučuje upotrebu override ključne reči za metode koje nadmašuju virtuelne metode iz bazne klase.
`modernize-use-nullptr`: Preporučuje upotrebu nullptr umesto NULL ili 0 za pokazivače.
`readability-const-return-type`: Povećava čitljivost preporukom za dodavanje const kvalifikatora na povratne tipove metoda kada je to moguće.
`performance-for-range-copy`: Povećava performanse preporukom za upotrebu const reference u for petljama kada se prolazi kroz kolekcije.

```bash
./clang-tidy.sh
```
Rezultati se cuvaju u `clang-tidy-output.txt`
