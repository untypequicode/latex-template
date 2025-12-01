# Template LaTeX pour documents académiques

Template LaTeX structuré et auto-documenté pour la création de rapports, devoirs et documents académiques avec compilation automatisée.

Le PDF généré sert lui-même de documentation complète avec des exemples concrets pour chaque fonctionnalité LaTeX.

## 📚 Documentation intégrée

Ce template est **auto-documenté** : compilez-le une fois pour générer un PDF contenant des exemples concrets de toutes les fonctionnalités LaTeX :

- Tableaux simples et avancés
- Insertion de figures et images
- Listes à puces, numérotées et de descriptions
- Mise en forme du texte et blocs de code
- Équations mathématiques (en ligne, numérotées, matrices)
- Références croisées entre sections, tableaux et équations
- Liens hypertextes et notes de bas de page
- Système de bibliographie complet avec citations

**Consultez le PDF généré pour voir tous ces exemples en action !**

## 🚀 Démarrage rapide

### 1. Configuration de l'environnement

Le fichier `src/env.sty` centralise toutes les métadonnées du document :

```bash
cd src
cp env.example.sty env.sty  # Si pas déjà fait
```

Modifiez `src/env.sty` avec vos informations :

```latex
\renewcommand{\envTitle}{Mon rapport de projet}
\renewcommand{\envAuthor}{Prénom Nom}
\renewcommand{\envCourse}{INF-1234: Algorithmique}
\renewcommand{\envFaculty}{Faculté de Génie}
\renewcommand{\envProfessor}{Prof. Dupont}
\renewcommand{\envTeam}{Équipe Alpha}
\renewcommand{\envRemise}{18 novembre 2025}

% Configuration de la police
\renewcommand{\envFontFamily}{times}  % "default" ou "times"
\renewcommand{\envFontSize}{12}       % 10, 11, 12, etc.

\renewcommand{\envTeamEntries}{%
  201234 & Alice Exemple \\%
  201235 & Bob Exemple   \\%
}
```

### 2. Compilation

**Avec Nix (recommandé)** :

```bash
nix-shell
cd src
just build
```

**Sans Nix** (nécessite LaTeX et just) :

```bash
cd src
just build
```

**Manuellement** :

```bash
cd src
pdflatex main.tex
biber main           # Traite la bibliographie
pdflatex main.tex    # Intègre la bibliographie
pdflatex main.tex    # Finalise les références
```

### 3. Édition du contenu

Le template inclut des sections de démonstration qui servent de documentation :

- `01.tex` : Tableaux et figures
- `02.tex` : Listes et mise en forme du texte
- `03.tex` : Équations mathématiques
- `04.tex` : Références croisées et liens
- `05.tex` : Gestion de la bibliographie

**Pour votre propre document**, remplacez simplement le contenu de ces fichiers ou créez de nouveaux fichiers `.tex`.

Incluez-les dans `src/main.tex` :

```latex
\input{content/01}
\input{content/02}
\input{content/03}  % nouveau fichier
```

### 4. Gestion de la bibliographie

Le template inclut un système de bibliographie avec **biblatex** et **biber**.

**Ajouter des références** :

Modifiez `src/references.bib` et ajoutez vos sources :

```bibtex
@article{mon_article,
  author  = {Nom, Prénom},
  title   = {Titre de l'article},
  journal = {Nom du Journal},
  year    = {2024},
  volume  = {42},
  pages   = {123--145}
}
```

**Citer dans le document** :

```latex
Selon \cite{mon_article}, cette approche est efficace.
Plusieurs études \cite{ref1,ref2,ref3} montrent que...
```

**Personnaliser le fichier de bibliographie** :

Dans `src/env.sty`, vous pouvez spécifier un autre fichier :

```latex
\renewcommand{\envBibFile}{mes-references.bib}
```

**Types de références supportés** : article, book, incollection, online, inproceedings, phdthesis, et plus. Voir `src/references.bib` pour des exemples.

## 📁 Structure

```
src/
├── env.sty              # Configuration du projet (à personnaliser)
├── env.example.sty      # Exemple de configuration
├── main.tex             # Document principal
├── preamble.tex         # Packages et configuration LaTeX
├── titlepage.tex        # Page de titre
├── references.bib       # Fichier de bibliographie
├── justfile             # Commandes de build
└── content/             # Contenu du document (exemples auto-documentés)
    ├── 01.tex           # Tableaux et figures
    ├── 02.tex           # Listes et mise en forme
    ├── 03.tex           # Équations mathématiques
    ├── 04.tex           # Références croisées et liens
    └── 05.tex           # Bibliographie
```

## 🔧 Commandes utiles

```bash
just build     # Compiler le PDF
just watch     # Recompiler automatiquement à chaque modification
just clean     # Nettoyer les fichiers auxiliaires
just cleanall  # Tout nettoyer (y compris le PDF)
```

## 🎨 Personnalisation

### Police et typographie

Le template permet de personnaliser la police et sa taille dans `src/env.sty` :

```latex
% Police par défaut (Computer Modern)
\renewcommand{\envFontFamily}{default}

% Ou Times New Roman
\renewcommand{\envFontFamily}{times}

% Taille de police (10pt, 11pt, 12pt, etc.)
\renewcommand{\envFontSize}{12}
```

**Options disponibles :**

- `envFontFamily` : `default` (Computer Modern) ou `times` (Times New Roman)
- `envFontSize` : toute valeur numérique (recommandé : 10, 11, 12)

### Logo

1. Placez votre logo dans `src/img/logo.png`
2. Ajustez dans `env.sty` :

```latex
\renewcommand{\envLogoFile}{img/mon-logo.pdf}
\renewcommand{\envLogoScale}{0.15}
```

### Images

Ajoutez vos images dans `src/img/` et référencez-les :

```latex
\includegraphics[width=0.8\textwidth]{mon-image.png}
```

## ⚙️ CI/CD (GitHub Actions)

Le workflow `.github/workflows/build-latex.yml` compile automatiquement le PDF à chaque push et le rend disponible dans les artifacts.

### Configuration du build avec `latex.build`

Le fichier `src/latex.build` configure comment le workflow CI/CD compile votre projet :

```bash
justfile=justfile         # Nom du justfile à utiliser
output=main.pdf           # Nom du PDF généré
#just_target=build        # (Optionnel) Cible just spécifique
```

**Variables disponibles** :

- `justfile` : chemin vers le justfile (défaut : `justfile`)
- `output` : nom du PDF de sortie attendu (défaut : `main.pdf`)
- `just_target` : cible just à exécuter (défaut : utilise la cible par défaut du justfile)

**Exemples de personnalisation** :

```bash
# Pour un projet avec sortie personnalisée
output=rapport-final.pdf

# Pour utiliser une cible just spécifique
just_target=pdf

# Pour un justfile alternatif
justfile=build/custom.just
```

Le workflow détecte automatiquement tous les fichiers `latex.build` dans `src/` et compile chaque projet indépendamment.

## 📝 Notes

- Les numéros de sections n'apparaissent pas dans le document mais restent dans la table des matières
- Le document est configuré pour le français par défaut
- Plusieurs compilations sont nécessaires pour résoudre les références croisées et la bibliographie (automatique avec `just build`)

## 🛠️ Dépendances

- **Avec Nix** : `nix-shell` installe tout automatiquement
- **Sans Nix** :
  - LaTeX (distribution complète recommandée)
  - [just](https://github.com/casey/just) (gestionnaire de commandes)
  - `inotifywait` (optionnel, pour `just watch`)
