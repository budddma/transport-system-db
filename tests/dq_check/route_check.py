import os
import pytest
from .. import execute_sql_to_df
from .. import read_sql


@pytest.fixture()
def select_script():
    path = os.getenv("SCRIPT_PATH")
    return read_sql(path)


@pytest.fixture()
def select_df(select_script, sqlalchemy_conn):
    return execute_sql_to_df(
        conn=sqlalchemy_conn,
        sql=select_script
    )


def test(select_df):
    # проверяет являются ли начальная и конечная остановки одновременно
    # автобусными или станицями метро
    
    assert select_df["init_bus_flg"].equals(select_df['final_bus_flg'])
