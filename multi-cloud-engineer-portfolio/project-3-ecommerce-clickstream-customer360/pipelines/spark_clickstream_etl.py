"""Spark job skeleton for clickstream ETL into a multi-cloud lakehouse."""
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, to_timestamp

spark = SparkSession.builder.appName("clickstream_etl").getOrCreate()

source_path = "s3://REPLACE/clickstream/raw/"  # or abfss://, gs://
target_path = "s3://REPLACE/clickstream/curated/"

df = spark.read.json(source_path)
df_clean = (
    df.withColumn("event_time", to_timestamp(col("event_time")))
      .withColumn("event_date", col("event_time").cast("date"))
)

(df_clean.write
    .mode("append")
    .partitionBy("event_date")
    .format("parquet")
    .save(target_path)
)
