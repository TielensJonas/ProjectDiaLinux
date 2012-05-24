#!/bin/bash
#inlezen van de gegevens.
echo "Voer een aanspreking in"
read Aanspr
echo "Voer je voornaam in"
read Vnaam
echo "Voer je achternaam in"
read Anaam
echo "Voer je email in"
read EMAIL

#Spaties uit voor en achternaam doen voor de bestandsnaam.
voorachter="$Vnaam $Anaam"
bestandsnaam=`echo "$voorachter" | sed 's/ //g'`
#kopieren van de .tex file met de aangepaste bestandsnaam
cp ProjectDiaLinux.tex $bestandsnaam.tex
#wijzig author in bestand ( zoeken op de naam )
sed -i -E 's/\Jonas Tielens/\ '$Vnaam' '$Anaam'/g' /home/jonastielens/ProjectDiaLinux/$bestandsnaam.tex

#builden van .pdf in latex
pdflatex $bestandsnaam
bibtex $bestandsnaam
makeindex $bestandsnaam
pdflatex $bestandsnaam
pdflatex $bestandsnaam

# Email bericht versturen.
SUBJECT="Opdracht1.5bashscript"
EMAILMESSAGE="$Aanspr $Vnaam $Anaam \nIn de bijlage kan u het PDF-bestand vinden van mijn project."
echo -e $EMAILMESSAGE | mutt -s $SUBJECT -a /home/jonastielens/ProjectDiaLinux/$bestandsnaam.pdf -- $EMAIL 
