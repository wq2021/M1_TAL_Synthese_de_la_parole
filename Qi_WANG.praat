clearinfo

# 1.Création de la boîte de dialogue # 

form Synthèse de la parole

comment  Insérez une phrase (ou des mots) à synthétiser :
text sequence nous avons envie d'établir un groupe de rock

comment  Vous voulez ajouter le silence au début ?
boolean oui

comment  Modifiez la prosodie si vous voulez :
boolean augmenter_f0
boolean abaisser_f0
boolean prolonger_la_durée

comment Nommez le nouveau son (*.wav): 
word Nom blabla.wav

endform

# 2.Ouverture des fichiers #

texto = Read from file: "son/WQ.TextGrid"
son = Read from file: "son/WQ.wav"
dico = Read Table from tab-separated file: "dico2.txt"
tableau = Create Sound from formula: "sineWithNoise", 1, 0, 0.01, 44100, "0"
silence = Create Sound from formula: "sineWithNoise", 1, 0, 0.5, 44100, "0"


# 3.Segmentation des mots #

phrase_phonetique$ = ""
sequence$ = sequence$ + " "


   
 while sequence$ != "" 

	index_premier_espace = index(sequence$," ")
	premier_mot$ = left$(sequence$,index_premier_espace-1)

	reste$ = right$(sequence$,length(sequence$)-index_premier_espace)

   select 'dico'
   extraction = Extract rows where column (text): "orthographe", "is equal to", premier_mot$
   transcription$ = Get value: 1, "phonetique"

   phrase_phonetique$ = phrase_phonetique$ + transcription$
   sequence$ = reste$
   
 endwhile 
  

# 4.Synthèse #

clearinfo
pause Maintenant on commence à synthétiser: /'phrase_phonetique$'/

printline ----------------------------------------------------

select 'texto'
nombre_dans_intervalle = Get number of intervals: 1


longeur_mot = length(phrase_phonetique$)


for y from 1 to longeur_mot-1

	chaine$ = mid$(phrase_phonetique$,y,2)
	carac1$ = left$(chaine$,1)
	carac2$ = right$(chaine$,1)

printline Le diphone : 'chaine$'
printline Le 1er phonème est 'carac1$' et le 2eme phonème est 'carac2$'

  for x from 1 to nombre_dans_intervalle-1
	  select 'texto'
	  etiquette1$ = Get label of interval: 1, x
	  etiquette2$ = Get label of interval: 1, x+1

	if etiquette1$ = carac1$ and etiquette2$ = carac2$

		debut_temps1 = Get start time of interval: 1, x
		debut_temps2 = Get start time of interval: 1, x+1
		fin_temps2 = Get end time of interval: 1, x+1

		milieu_carac1 = (debut_temps1+debut_temps2)/2
		milieu_carac2 = (debut_temps2+fin_temps2)/2

        select 'son'
        intersection_au_pluriel = To PointProcess (zeroes): 1, "yes", "no"
 
		 select intersection_au_pluriel
        index_intersection1 = Get nearest index: milieu_carac1
        milieu_carac1 = Get time from index: index_intersection1

        index_intersection2 = Get nearest index: milieu_carac2
        milieu_carac2 = Get time from index: index_intersection2


		select 'son' 
		extrait_son = Extract part: milieu_carac1, milieu_carac2, "rectangular", 1, "no"
		 
       select 'tableau'
		plus 'extrait_son'
		tableau = Concatenate

       printline --------------------------------------------------------

		endif 
	endfor
endfor


# 5. Modification prosodique #

# 5.1 Augmentation de F0 #

if ( augmenter_f0 )

select 'tableau'

fichier_modifiable = To Manipulation: 0.01, 75, 600
pitch_tier = Extract pitch tier
Shift frequencies: 0, 1000, 30, "Hertz"

select 'fichier_modifiable'
plus 'pitch_tier'
Replace pitch tier

select 'fichier_modifiable'
tableau = Get resynthesis (overlap-add)

endif

# 5.2 Abaissement de F0 #

if ( abaisser_f0 )

select 'tableau'

fichier_modifiable = To Manipulation: 0.01, 75, 600
pitch_tier = Extract pitch tier
Shift frequencies: 0, 1000, -30, "Hertz"

select 'fichier_modifiable'
plus 'pitch_tier'
Replace pitch tier

select 'fichier_modifiable'
tableau = Get resynthesis (overlap-add)

endif


# 5.3 Modification de Durée #

if ( prolonger_la_durée )

select 'tableau'
fichier_modifiable = To Manipulation: 0.01, 75, 600
duration_tier = Extract duration tier
Remove points between: 0, 40
Add point: 0.5, 2

select 'fichier_modifiable'
plus 'duration_tier'
Replace duration tier

select 'fichier_modifiable'
tableau = Get resynthesis (overlap-add)

endif


# 5.4 Ajout du Silence #

if ( oui )

 select 'silence'
 plus 'tableau'
 tableau = Concatenate
 
endif

# 6. Sauvegarder le nouveau son #

select 'tableau'
Save as WAV file: "'nom$'"