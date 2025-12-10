"""Spark job skeleton to build Customer 360 feature store tables."""
from pyspark.sql import SparkSession
from pyspark.sql.functions import countDistinct, sum as _sum, max as _max

spark = SparkSession.builder.appName("feature_store_builder").getOrCreate()

orders = spark.read.parquet("s3://REPLACE/orders/curated/")
events = spark.read.parquet("s3://REPLACE/events/curated/")

features = (
    orders.groupBy("customer_id")
    .agg(
        _sum("order_amount").alias("total_spend"),
        countDistinct("order_id").alias("order_count"),
        _max("order_date").alias("last_order_date"),
    )
)

features.write.mode("overwrite").parquet("s3://REPLACE/feature_store/customer_features/")
