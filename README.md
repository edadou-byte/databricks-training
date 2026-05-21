# databricks-training

A personal repository of notebooks and supporting resources built while following **Databricks Academy** courses. It covers Python for Data Science & Engineering, Apache Spark development, Delta Lake, data modeling strategies, and practical ETL orchestration — all authored from scratch.

---

## Repository structure

```
databricks-training/
│
├── Formation/                        # Introductory Databricks course (5 lessons)
│   ├── Cours 1/                      # Databricks interface, Notebooks, Python & SQL basics
│   ├── Cours 2/                      # Python, Spark, SQL and DataFrames
│   ├── Cours 3/                      # Reading and writing DataFrames
│   ├── Cours 4/                      # Jobs and orchestration
│   └── Cours 5/                      # End-to-end ETL pipeline (banking dataset)
│       └── ETL_PIPELINE_BNK/
│           ├── explorations/         # SQL exploration scripts
│           └── transformations/      # PySpark transformation scripts
│
├── Spark Developer/                  # Spark Developer learning path
│   ├── Python pour Data Science et Data Engineering/   # Python fundamentals (NB00–NB13)
│   │   └── Topics: data types, control flow, functions, collections, loops,
│   │               exceptions, classes, libraries, Pandas, data visualization,
│   │               Pandas + Spark integration
│   ├── Introduction a Spark/         # Spark architecture, DataFrames, ETL operations
│   ├── Développement d'applications Spark/   # Aggregations, relational ops, complex types
│   ├── Optimisation et utilisation de Spark dans Databricks/  # Delta Lake + Spark optimization
│   └── Traitement et analyse de flux de données/   # Spark Structured Streaming + window aggregations
│
├── Delta Lake/                       # Delta Lake learning path
│   ├── NB01 - Delta Lake features with Databricks SQL
│   ├── NB02 - Data ingestion techniques
│   └── NB03 - Orchestration (full Bronze → Silver → Gold pipeline)
│
├── Data Modeling Strategies/         # Data modeling learning path
│   └── Modélisation de DWH/
│       ├── NB01 - Data Warehouse modeling
│       ├── NB02 - Dimensional modeling & ETL
│       ├── NB03 - Data Vault 2.0
│       └── NB04 - Feature Store
│
└── .devcontainer/                    # GitHub Codespaces configuration
    ├── devcontainer.json             # Dev container spec (Python 3.11, Java 17, Spark)
    ├── post-create.sh                # Auto-install script
    └── README.md                     # Codespaces usage guide
```

Each notebook folder includes a `Resources/` subfolder with datasets (CSV, JSON, Parquet) and setup notebooks required to run the exercises.

---

## Prerequisites

- A **Databricks workspace** (Community Edition or any paid tier)
- Git installed locally if you plan to clone

---

## Option 1 — Import into a Databricks workspace

### Step 1 — Clone or fork the repository

**Clone:**
```bash
git clone https://github.com/edadou-byte/databricks-training.git
```

**Fork** (to keep your own copy): click the **Fork** button on the GitHub repository page, then clone your fork.

### Step 2 — Import into Databricks

You can import notebooks individually or import the whole repo via Git integration.

#### Method A — Git integration (recommended)

This keeps your notebooks in sync with the repository directly from your Databricks workspace.

1. Open your Databricks workspace
2. Go to **Workspace** → **Repos** → **Add Repo**
3. Paste the repository URL:
   ```
   https://github.com/edadou-byte/databricks-training.git
   ```
   (or your fork URL)
4. Click **Create Repo**

The full folder structure will be available in your workspace under **Repos**.

#### Method B — Manual notebook import

To import a single notebook:

1. In your Databricks workspace, navigate to the target folder
2. Click **Import** (top right of the workspace explorer)
3. Select **File** and upload the `.ipynb` file
4. Click **Import**

### Step 3 — Upload resource files

Each notebook that requires datasets points to a local path configured in its companion `Setup.ipynb`. Before running a notebook:

1. Open the `Resources/NBxx/Setup.ipynb` file associated with the notebook
2. Run it — it will upload the required files to DBFS (Databricks File System)

### Step 4 — Attach a cluster and run

1. Open the notebook in Databricks
2. Attach it to a running cluster (or create one)
3. Run cells in order from top to bottom

---

## Courses covered

| Module | Topics |
|---|---|
| **Formation** | Databricks interface, Python & SQL basics, DataFrames, Jobs, ETL pipeline |
| **Python for Data Science & Engineering** | Data types, control flow, functions, OOP, Pandas, data visualization |
| **Introduction to Spark** | Spark architecture, DataFrame API, ETL with DataFrames |
| **Spark Application Development** | Aggregations, joins, complex data structures |
| **Spark Optimization** | Delta Lake integration, Spark performance tuning |
| **Structured Streaming** | Real-time processing, window aggregations |
| **Delta Lake** | Delta tables, data ingestion, Bronze/Silver/Gold pipeline |
| **Data Modeling Strategies** | DWH modeling, dimensional modeling, Data Vault 2.0, Feature Store |

---

## Notes

- Notebooks are written in **Python / PySpark** and **SQL**
- Each notebook is self-contained and follows the progression of the corresponding Databricks Academy course
- `Setup.ipynb` files must be run before their associated main notebook to properly initialize the environment and upload datasets
