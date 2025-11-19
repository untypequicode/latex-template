# Template LaTeX pour documents académiques

Template LaTeX structuré pour la création de rapports, devoirs et documents académiques avec compilation automatisée.

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
pdflatex main.tex  # Deux fois pour les références
```

### 3. Édition du contenu

Ajoutez votre contenu dans `src/content/` :

- `01.tex` : Première section
- `02.tex` : Deuxième section
- Créez autant de fichiers `.tex` que nécessaire

Incluez-les dans `src/main.tex` :

```latex
\input{content/01}
\input{content/02}
\input{content/03}  % nouveau fichier
```

## 📁 Structure

```
src/
├── env.sty              # Configuration du projet (à personnaliser)
├── env.example.sty      # Exemple de configuration
├── main.tex             # Document principal
├── preamble.tex         # Packages et configuration LaTeX
├── titlepage.tex        # Page de titre
├── justfile             # Commandes de build
└── content/             # Contenu du document
    ├── 01.tex
    └── 02.tex
```

## 🔧 Commandes utiles

```bash
just build     # Compiler le PDF
just watch     # Recompiler automatiquement à chaque modification
just clean     # Nettoyer les fichiers auxiliaires
just cleanall  # Tout nettoyer (y compris le PDF)
```

## 🎨 Personnalisation

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
- Deux compilations sont nécessaires pour résoudre les références croisées

## 🛠️ Dépendances

- **Avec Nix** : `nix-shell` installe tout automatiquement
- **Sans Nix** :
  - LaTeX (distribution complète recommandée)
  - [just](https://github.com/casey/just) (gestionnaire de commandes)
  - `inotifywait` (optionnel, pour `just watch`)
