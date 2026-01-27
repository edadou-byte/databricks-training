# 🚀 Utilisation avec GitHub Codespaces

Ce guide explique comment utiliser ce Dev Container avec GitHub Codespaces.

## ✅ Avantages de Codespaces

- ✨ Environnement prêt à l'emploi en quelques minutes
- 💻 Pas besoin de Docker local
- 🌍 Accessible depuis n'importe où (navigateur ou VS Code)
- 🔄 Configuration identique pour toute l'équipe
- 💰 60 heures gratuites par mois (compte GitHub gratuit)

## 🎯 Démarrage rapide

### 1. Créer un Codespace

**Option A - Depuis GitHub.com** :
```
1. Allez sur votre repository GitHub
2. Cliquez sur "Code" (bouton vert)
3. Onglet "Codespaces"
4. "Create codespace on main"
```

**Option B - Depuis VS Code** :
```
1. Installez l'extension "GitHub Codespaces"
2. Cmd/Ctrl + Shift + P
3. "Codespaces: Create New Codespace"
4. Sélectionnez votre repository
```

### 2. Configuration automatique

Le Codespace va automatiquement :
- ✅ Installer Python 3.11
- ✅ Installer Java 17
- ✅ Télécharger et configurer Apache Spark
- ✅ Installer toutes les bibliothèques Python (pandas, numpy, etc.)
- ✅ Configurer Jupyter Lab
- ✅ Créer un notebook d'exemple

⏱️ **Temps de build initial** : ~5-8 minutes (seulement la première fois)

### 3. Démarrer Jupyter Lab

Une fois le Codespace prêt :

```bash
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
```

GitHub Codespaces ouvrira automatiquement une fenêtre avec Jupyter Lab ! 🎉

## 🔧 Configuration des ressources

### Machines disponibles

Par défaut, le `.devcontainer` demande :
- **2 CPUs**
- **4 GB RAM**
- **16 GB Storage**

On peut augmenter pour plus de performances

1. Modifiez `.devcontainer/devcontainer.json`
2. Changez `hostRequirements` :

```json
"hostRequirements": {
  "cpus": 2,
  "memory": "4gb",
  "storage": "16gb"
}
```

### Types de machines Codespaces

| Type | vCPU | RAM | Stockage | Utilisation |
|------|------|-----|----------|-------------|
| 2-core | 2 | 8 GB | 32 GB | Tests légers |
| **4-core** | 4 | 16 GB | 32 GB | **Recommandé pour Spark** |
| 8-core | 8 | 32 GB | 64 GB | Gros datasets |

## 🌐 Accès aux services

GitHub Codespaces gère automatiquement le forwarding des ports :

- **Jupyter Lab** : Port 8888 → URL automatique fournie par GitHub
- **Spark UI** : Port 4040 → Visible dans l'onglet "Ports" de VS Code

### Voir les ports :
1. Dans VS Code Codespaces, ouvrez l'onglet "PORTS" (en bas)
2. Cliquez sur l'icône 🌐 pour ouvrir le service dans le navigateur

## 💡 Bonnes pratiques Codespaces

### ⚡ Optimisation des coûts

```bash
# Arrêter votre Codespace quand vous ne l'utilisez pas
# Il s'arrête automatiquement après 30 min d'inactivité

# Supprimer un Codespace inutilisé
# Depuis GitHub.com → Settings → Codespaces
```

### 💾 Persistance des données

- ✅ Vos notebooks dans le repository sont sauvegardés
- ✅ Les fichiers dans votre workspace sont persistés
- ⚠️ Les données en dehors du workspace peuvent être perdues

**Recommandation** : Créez un dossier `data/` dans votre repository pour vos datasets.

### 🔄 Rebuild du container

Si vous modifiez `.devcontainer/devcontainer.json` :

```
1. Cmd/Ctrl + Shift + P
2. "Codespaces: Rebuild Container"
```

## 📊 Exemple d'utilisation complète

### 1. Créer un nouveau notebook

```bash
cd ~/notebooks
# ou depuis Jupyter Lab : New → Notebook
```

### 2. Code Spark dans Codespaces

```python
from pyspark.sql import SparkSession

# Configuration optimisée pour Codespaces
spark = SparkSession.builder \
    .appName("MonProjet") \
    .master("local[2]") \
    .config("spark.driver.memory", "4g") \
    .config("spark.executor.memory", "2g") \
    .getOrCreate()

# Vérifier que Spark fonctionne
df = spark.range(1000000)
print(f"Nombre de lignes : {df.count()}")

# Accéder au Spark UI
print("Spark UI disponible sur le port 4040")
```

### 3. Sauvegarder votre travail

```bash
git add notebooks/
git commit -m "Ajout de mes notebooks"
git push
```

## 🐛 Dépannage Codespaces

### Le build est lent
- **Normal** la première fois (~5-8 min)
- Les builds suivants utilisent le cache (~30 sec)

### Jupyter ne démarre pas
```bash
# Vérifier que le port est libre
lsof -i :8888

# Redémarrer Jupyter
pkill jupyter
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser
```

### Spark manque de mémoire
```python
# Réduire la mémoire Spark
spark = SparkSession.builder \
    .config("spark.driver.memory", "2g") \
    .config("spark.executor.memory", "1g") \
    .getOrCreate()
```

### Problème de permissions
```bash
# Si un dossier n'est pas accessible
sudo chown -R vscode:vscode /workspace
```

## 📈 Monitoring des ressources

```bash
# Voir l'utilisation CPU/RAM
htop

# Voir l'espace disque
df -h

# Voir les processus Spark
jps
```

## 🔐 Secrets et variables d'environnement

Pour ajouter des secrets (API keys, etc.) :

1. GitHub.com → Settings → Codespaces
2. "New secret"
3. Accessible via `os.environ['MON_SECRET']` dans Python

## 📚 Ressources

- [Documentation Codespaces](https://docs.github.com/en/codespaces)
- [Tarification Codespaces](https://docs.github.com/en/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces)
- [Dev Container Spec](https://containers.dev/)

## ⚙️ Configuration avancée

### Prebuilds (optionnel)

Pour des builds encore plus rapides, activez les prebuilds :

1. Repository → Settings → Codespaces
2. "Set up prebuild"
3. Configurez les déclencheurs (push sur main, etc.)

Les builds seront préparés à l'avance ! ⚡

---

**🎓 Bon apprentissage avec Spark sur Codespaces !**