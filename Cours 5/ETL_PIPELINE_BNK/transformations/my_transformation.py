# Import modules
from pyspark import pipelines as dp
from pyspark.sql.functions import *
from pyspark.sql.types import DoubleType, IntegerType, StringType, StructType, StructField

# Define a streaming table to ingest data from a volume
schema = StructType(
  [
    StructField("id", IntegerType(), True),
    StructField("first_name", StringType(), True),
    StructField("last_name", StringType(), True),
    StructField("email", StringType(), True),
    StructField("bnk_name", StringType(), True),
    StructField("bnk_sa", StringType(), True),
    StructField("bnk_city", StringType(), True),
    StructField("bnk_cc", StringType(), True),
  ]
)

# Access a parameter from pipeline configuration
volume_path = spark.conf.get("volume_path")

# Definie une table users_raw qui contient toutes les colonnes du json sans vérifications
@dp.table(
  comment="Raw data from a JSON file containing user and bank informations"
)
def users_raw():
    return spark.readStream.format("json").schema(schema).load(volume_path)
  
# Definie une vue materialisé users avec des vérifications sur les colonnes first_name, last_name et email
@dp.materialized_view(
  comment="Users data"
)
@dp.expect("valid_first_name", "first_name IS NOT NULL")
@dp.expect("valid_last_name", "last_name IS NOT NULL")
@dp.expect("valid_email", "email IS NOT NULL")
def users():
  return (
    spark.read.table("users_raw")
      .select("id", "first_name", "last_name", "email")
  )

# Definie une vue materialisé users_bank avec des vérifications sur les colonnes bank_name, bank_street_adress, ... et renomme les colonnes
@dp.materialized_view(
  comment="Users bank data"
)
@dp.expect("valid_bank_name", "bank_name IS NOT NULL")
@dp.expect("valid_bank_street_name", "bank_street_address IS NOT NULL")
@dp.expect("valid_bank_city", "bank_city IS NOT NULL")
@dp.expect("valid_bank_country_code", "bank_country_code IS NOT NULL")
def users_bank():
  return (
    spark.read.table("users_raw")
      .withColumnRenamed("bnk_name", "bank_name")
      .withColumnRenamed("bnk_sa", "bank_street_address")
      .withColumnRenamed("bnk_city", "bank_city")
      .withColumnRenamed("bnk_cc", "bank_country_code")
      .select("id", "bank_name", "bank_street_address", "bank_city", "bank_country_code")
  )

