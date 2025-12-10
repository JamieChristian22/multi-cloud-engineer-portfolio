"""PySpark Glue job skeleton for cleaning NYC TLC taxi data."""
import sys
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from pyspark.sql.functions import col, hour

args = getResolvedOptions(sys.argv, ["JOB_NAME", "SOURCE_PATH", "TARGET_PATH"])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

df = spark.read.format("parquet").load(args["SOURCE_PATH"])
df_clean = (
    df.dropna(subset=["tpep_pickup_datetime", "tpep_dropoff_datetime"])
      .withColumn("pickup_hour", hour(col("tpep_pickup_datetime")))
)

df_clean.write.mode("overwrite").format("parquet").partitionBy("pickup_hour").save(
    args["TARGET_PATH"]
)

job.commit()
