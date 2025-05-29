# README – Projekt: Virtualiseringsteknik och Automation (Grupp 6)

## Gruppinformation
**Grupp 6 – Virtualiserad Infrastruktur med Lastbalansering**  
**Kurs:** Virtualiseringsteknik och Automation  
**Klass:** ITS24  
**Termin:** Våren 2025  
**Gruppmedlemmar:** Elvira Görl, Jacob Johansson, Sara Bruggeman

## Projektmål
Att designa, implementera och dokumentera en virtualiserad IT-infrastruktur bestående av:

- Flera virtuella maskiner (webbservrar)
- En lastbalanserare (NGINX)
- Automatisk distribution via GitHub
- Simulerad webbtjänst med klickbara HTML-element
- Dokumentation och testning enligt kursens krav

## Miljö och Verktyg

| Komponent        | Detaljer                            |
|------------------|-------------------------------------|
| Virtualisering   | VMware Workstation Pro              |
| OS               | Debian 12                           |
| Plattform        | Git + GitHub för versionshantering  |
| Webserver        | Apache2 på varje VM                 |
| Lastbalanserare  | NGINX på separat VM                 |
| Kod              | HTML                                |

## Infrastrukturdesign

- 3 virtuella maskiner:
  - **Web1**: Grupp 6:s huvudsida med 10+ klickbara HTML-sidor
  - **Web2**: Trollsida med rickrolls, fake admin-login och quiz
  - **LB**: Lastbalanserare konfigurerad med NGINX round-robin
- Nätverket är isolerat (host-only) med manuellt tilldelade IP-adresser

## Struktur (filträd)
```
debian-loadbalancer-webproject/
├── web1/
│   ├── faq.html
│   ├── index.html
│   ├── karriar.html
│   ├── kontakt.html
│   ├── omoss.html
│   ├── partners.html
│   ├── passwords.html
│   ├── root.html
│   ├── support.html
│   ├── tjanster.html
├── web2/
│   ├── index.html (rickrolls & quiz)
│   ├── quiz.html
├── shared-html/ (valfritt mount-läge)
├── Deploying Web Project.sh
├── README.md
```

## Git-baserad synk
- HTML-filer versioneras i Git
- `git pull` + `sudo cp` används för att distribuera nya filer till `/var/www/html/` på varje VM

### SSH-kommandon för uppdatering
**Web1:**
```bash
ssh admin12345@192.168.50.108
cd ~/debian-loadbalancer-webproject
git pull origin main
sudo cp web1/*.html /var/www/html/
```
**Web2:**
```bash
ssh admin12345@192.168.60.175
cd ~/debian-loadbalancer-webproject
git pull origin main
sudo cp web2/*.html /var/www/html/
```
**OBS:**
Vid uppdatering av specifika filer (t.ex. `omoss.html`) måste rätt HTML hämtas från sin originalmapp:
- Alla Web1-sidor ska hämtas från `web1/`
- `quiz.html` är exklusiv för Web2

## Funktioner

- Grupp 6 IT Service AB på Web1: Professionell hemsida med kontaktformulär
- Trollportal på Web2: Rickroll-länkar, fake-login, One Direction-quiz
- Quiz: HTML + JavaScript interaktivt frågespel
- Säkerhet: Portar begränsade, VMs körs isolerat

## Tester och Resultat

### Prestandatest

För att mäta systemets lastbalanseringsförmåga och svarstider använde vi `Apache Bench` (ab) mot lastbalanserarens IP-adress `192.168.50.77`.

```bash
ab -n 100 -c 10 http://192.168.50.77/
```

**Resultat:**

- **Totalt antal förfrågningar:** 100  
- **Samtidiga förfrågningar:** 10  
- **Fel:** 0  
- **Requests per second:** 32.50  
- **Medel svarstid:** 307 ms  
- **Längsta svarstid:** 3063 ms  
- **Överföringshastighet:** 86.06 KB/s  

Lastbalanseraren fördelade belastningen korrekt mellan Web1 och Web2. Svar från `curl`-loop alternerade mellan olika servrar, vilket bekräftade round-robin-konfigurationen.

Skärmdump från testet finns inkluderad i repot.

- Lastbalanseraren fördelar trafik korrekt mellan Web1 och Web2
- Sidorna fungerar både internt och via NGINX
- `ens33`-interface behövde ibland aktiveras manuellt efter reboot (åtgärdat)

## Utmaningar & Reflektioner

- Hantering av nätverksinterface efter reboot
- Versionskonflikter vid Git push löstes med rebase
- Balans mellan professionellt och roligt innehåll (rickrolls vs kontakt.html)
- Bibehålla struktur trots kreativ frihet

## Bilder och design

- Skärmdumpar finns av webbgränssnitt, terminal och inställningar i VMware.
- Kompletteras med bild på nätverksskiss vid behov.

## Bilagor

- Nätverksskiss (PNG/draw.io)
- Terminalutskrifter från testning
- Index.html från båda webservrarna

## Avslutning

Projektet har gett oss:
- Praktisk förståelse för virtualisering, lastbalansering och webbutveckling
- Erfarenhet av Git, bash-scripting och manuell driftsättning
- Ett udda men välfungerande system redo för redovisning




Grupp 6 – Elvira Görl, Jacob Johansson, Sara Bruggeman




