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
    # проверяет, что информация в bus_info соответствует автобусам,
    # а в metro_info - не автобусам : \
    
    assert select_df['real_bus_flg'].equals(select_df['expected_bus_flg'])
