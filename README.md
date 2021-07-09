# Projet M1 TAL : Synthèse de la Parole

## Présentation

Le projet "synthèse de la parole" vise à mettre en place une chaîne de traitement du signal afin de réaliser une synthèse "text-to-speech" en langue française. L'automatisation de cette synthèse est réalisée au moyen de langage de programmation dédié en traitement du signal, Praat.

*****

## Mode d'emploi

1. Ouvrez le logiciel Praat, sinon [téléchargez ici](https://www.fon.hum.uva.nl/praat/).
2. Ouvrez le script : Open -> Read from file -> Qi_WANG.praat
3. Exécutez le script : Run -> Run
4. Dans la boîte de dialogue, sentez libre de faire des opérations suivantes :
    * Insérez la phrase que vous souhaitez. Attention, pensez à **changer la lettre initiale en minuscule** et **supprimer les points de ponctuation et l'espace à l'issu du dernier mot** pour que le programme fonctionne mieux.
    * Cochez "oui" pour **ajouter un silence de 0.5 seconde** au début de la phrase.
    * Cochez "augmenter f0" pour **augmenter le F0** (F0, soit la Fréquence Fondamentale, désigne le nombre de vibrations par secondes, par exemple 95 Hz = 95 vibrations par seconde).
    * Cochez "abaisser f0" pour **abaisser le F0**.
    * Cochez "prolonger la durée" pour **prolonger la durée (ralentir la vitesse de la phrase)**.

*****

## Corpus

### Mots choisis

* Sujets / pronoms : je, nous, tu, il, Paul, quelqu'un, ce.
* Verbes / locutions verbales : est, fais, connais, manque, (d')établir, avoir envie de.
* Noms : groupe, rock, bassiste, batteur, guitare.
* Conjonctions de subordination/coordination : que, et, ou.
* Déterminants : un, une.
* Adposition : de.

### Phrases sélectionnées

* nous avons envie d'établir un groupe de rock
* je fais de la guitare
* Paul est batteur
* et il nous manque un ou une bassiste
* est-ce que tu connais quelqu'un
  
### Exemples des nouvelles phrases composées

* Paul est bassiste
* et il est batteur
* il connaît quelqu'un
  
*****

## Modification de dictionnaire

### Remplacement des phonèmes

* o~ => X
* e~ => Y

### Ajout et modification des éléments

* est-ce	=> Es
* d'établir	=> detabliR
* avons => zavX