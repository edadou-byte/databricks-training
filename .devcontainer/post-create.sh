#!/bin/bash

set -e

echo "🚀 Installing Spark and Python dependencies..."

# Update pip
pip install --upgrade pip

# Install Python data science and Spark packages
pip install \
    pyspark==3.5.0 \
    jupyterlab==4.0.9 \
    pandas==2.1.4 \
    numpy==1.26.2 \
    matplotlib==3.8.2 \
    seaborn==0.13.0 \
    scikit-learn==1.3.2 \
    plotly==5.18.0 \
    pyarrow==14.0.1 \
    findspark==2.0.1 \
    black==23.12.1 \
    pylint==3.0.3 \
    ipywidgets==8.1.1

# Download and install Spark
echo "📦 Downloading Apache Spark..."
SPARK_VERSION="3.5.0"
HADOOP_VERSION="3"
cd /tmp
wget -q https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
sudo mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark
sudo chown -R vscode:vscode /opt/spark
rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# Create Jupyter config directory
mkdir -p ~/.jupyter

# Create Jupyter Lab config
cat > ~/.jupyter/jupyter_lab_config.py << 'EOF'
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = 8888
c.ServerApp.open_browser = False
c.ServerApp.allow_root = True
c.ServerApp.token = ''
c.ServerApp.password = ''
EOF

# Create a sample notebook
mkdir -p ~/notebooks
cat > ~/notebooks/01_spark_introduction.ipynb << 'EOF'
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Introduction à PySpark\n",
    "\n",
    "Ce notebook présente les bases de PySpark pour le Data Engineering et la Data Science."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "from pyspark.sql import SparkSession\n",
    "import pandas as pd\n",
    "import numpy as np\n",
    "\n",
    "# Créer une session Spark\n",
    "spark = SparkSession.builder \\\n",
    "    .appName(\"Introduction PySpark\") \\\n",
    "    .master(\"local[*]\") \\\n",
    "    .config(\"spark.driver.memory\", \"2g\") \\\n",
    "    .getOrCreate()\n",
    "\n",
    "print(f\"Spark version: {spark.version}\")\n",
    "print(f\"Spark UI: http://localhost:4040\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Créer un DataFrame Spark simple\n",
    "data = [(\"Alice\", 28, \"Data Engineer\"),\n",
    "        (\"Bob\", 35, \"Data Scientist\"),\n",
    "        (\"Charlie\", 32, \"Data Analyst\")]\n",
    "\n",
    "columns = [\"nom\", \"age\", \"role\"]\n",
    "\n",
    "df = spark.createDataFrame(data, columns)\n",
    "df.show()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Opérations basiques\n",
    "df.printSchema()\n",
    "df.describe().show()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": [
    "# Arrêter la session Spark\n",
    "# spark.stop()"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.11.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
EOF

echo "✅ Installation terminée !"
echo ""
echo "📝 Pour démarrer Jupyter Lab, exécutez :"
echo "   jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root"
echo ""
echo "🌐 Jupyter Lab sera accessible sur : http://localhost:8888"
echo "🔥 Spark UI sera accessible sur : http://localhost:4040"