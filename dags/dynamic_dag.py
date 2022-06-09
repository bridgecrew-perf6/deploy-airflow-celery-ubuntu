from datetime import datetime
from airflow.models import DAG
from airflow.operators.bash_operator import BashOperator

default_args = {
    "retries": 3,
    "retry_delay": 5,
    "owner": "airflow",    
}

schedule = "*/1 * * * *" # at every min


def create_dag(dag_id, default_args, schedule):
    with DAG(
        dag_id=dag_id,
        default_args=default_args,
        start_date=datetime(2022, 1, 1),
        schedule_interval=schedule,
        catchup=False,
    ) as dag:
        task_1 = BashOperator(task_id="task_1", bash_command="sleep 5")
        task_2 = BashOperator(task_id="task_2", bash_command="sleep 5")
        task_3 = BashOperator(task_id="task_3", bash_command="sleep 5")
        task_4 = BashOperator(task_id="task_4", bash_command="sleep 5")
    task_1 >> task_2 >> task_3 >> task_4
    return dag


for n in range(1,10):
    dag_id = f"dag_test_{n}"
    globals()[dag_id] = create_dag(dag_id, default_args, schedule)
