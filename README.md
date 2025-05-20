# Grupp 6 – Virtualiserad Infrastruktur med Lastbalansering

### Kurs: Virtualiseringsteknik och Automation  
### Klass: ITS24  
### Termin: Våren 2025

---

## Projektmål

Att designa, implementera och dokumentera en virtualiserad IT-infrastruktur bestående av:

- Flera virtuella maskiner (webbservrar)
- En lastbalanserare (NGINX)
- Automatisk distribution via GitHub
- Simulerad webbtjänst med klickbara HTML-element
- Dokumentation och testning enligt kursens krav

---

## Miljö och Verktyg

| Komponent        | Detaljer                            |
|------------------|-------------------------------------|
| Virtualisering   | VMware Workstation Pro              |
| OS               | Debian 12                           |
| Plattform        | Git + GitHub för versionshantering  |
| Webserver        | Apache2 på varje VM                 |
| Lastbalanserare  | NGINX på separat VM                 |
| Kod              | HTML                                |

---

## Infrastrukturdesign

- 3 virtuella maskiner:
  - Web1: Grupp 6:s huvudsida med 10+ klickbara HTML-sidor
  - Web2: Trollsida med rickrolls, fake admin-login och quiz
  - LB: Lastbalanserare konfigurerad med NGINX round-robin
- Nätverket är isolerat (host-only) med manuellt tilldelade IP-adresser

---

## Struktur (filträd)

debian-loadbalancer-webproject/
├── web1/
│ ├── faq.html
│ ├── index.html
│ ├── karriar.html
│ ├── kontakt.html
│ ├── omoss.html
│ ├── partners.html
│ ├── passwords.html
│ ├── root.html
│ ├── support.html
│ ├── tjanster.html
├── web2/
│ ├── index.html (rickrolls & quiz)
│ ├── quiz.html
├── shared-html/ (valfritt mount-läge)
├── Deploying Web Project.sh
├── README.md

---

### Git-baserad synk:

- HTML-filer versioneras i Git
- git pull + sudo cp används för att distribuera nya filer till /var/www/html/ på varje VM

---

### SSH-kommando för uppdatering:

Web1  
ssh admin12345@192.168.50.108  
cd ~/debian-loadbalancer-webproject  
git pull origin main  
sudo cp web1/*.html /var/www/html/

Web2  
ssh admin12345@192.168.60.175  
cd ~/debian-loadbalancer-webproject  
git pull origin main  
sudo cp web2/*.html /var/www/html/

OBS!  
Vid uppdatering av specifika filer (t.ex. om `omoss.html` uppdateras) måste rätt HTML hämtas från dess originalmapp:

- Alla Web1-sidor (t.ex. `omoss.html`, `kontakt.html`, etc.) ska hämtas från `web1/` – även när de ska kopieras till Web2
- `quiz.html` är exklusiv för Web2 och hämtas från `web2/` – även om den ska visas på Web1

Detta är för att undvika versionskonflikter och hålla innehållet synkroniserat mellan maskiner.


---

## Funktioner

- Grupp 6 IT Service AB på Web1: En professionell hemsida med kontaktformulär och information
- Trollportal på Web2: Rickroll-länkar, quiz, fake-login, löjligt lång One Direction-zon
- Quiz: HTML + JavaScript interaktivt quiz om One Direction
- Säkerhet: Alla portar begränsade, VMs körs isolerat

---

## Tester och Resultat

- Lastbalanseraren fördelar trafik korrekt mellan Web1 och Web2
- Alla sidor fungerar från både intern IP och via NGINX
- Missar: Vid reboot måste ens33 ibland aktiveras manuellt(borde vara löst nu)

---

## Utmaningar & Reflektioner

- Hantering av nätverksinterface efter reboot (ens33)
- Versionskonflikter vid Git-pushar behövde lösas med rebase
- Att få quizet och webbside-element att kännas proffsiga men kul
- Att bibehålla struktur trots kaosidéer (rickrolls och One Direction)

---

## Avslutning

Projektet har gett oss:

- Praktisk förståelse för virtualisering, lastbalansering och webbutveckling
- Erfarenhet av Git, bash-scripting och manuell driftsättning
- Ett udda men genomarbetat system redo för redovisning

---

Grupp 6 – Elvira Görl, Jacob Johansson, Sara Bruggeman




