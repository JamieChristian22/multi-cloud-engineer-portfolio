"""Airflow DAG skeleton for multi-cloud replication of TLC taxi data."""
from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.operators.empty import EmptyOperator

with DAG(
    dag_id="global_ride_multicloud_replication",
    start_date=days_ago(1),
    schedule_interval="@daily",
    catchup=False,
    tags=["multicloud", "taxi", "replication"],
) as dag:

    start = EmptyOperator(task_id="start")
    replicate_to_azure = EmptyOperator(task_id="replicate_to_azure")
    replicate_to_gcp = EmptyOperator(task_id="replicate_to_gcp")
    validate_row_counts = EmptyOperator(task_id="validate_row_counts")
    end = EmptyOperator(task_id="end")

    start >> [replicate_to_azure, replicate_to_gcp] >> validate_row_counts >> end
