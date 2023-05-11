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
    # проверяет соответсвие 1 к 1 записей в таблицах vodila, transport, trip
    # и зависимости bus_info, metro_inf и trip_history
    
    assert select_df.query("table_nm == 'vodila'")['cnt'].iloc[0] == select_df.query("table_nm == 'transport'")['cnt'].iloc[0]
    assert select_df.query("table_nm == 'trip'")['cnt'].iloc[0] == select_df.query("table_nm == 'transport'")['cnt'].iloc[0]
    assert select_df.query("table_nm == 'bus_info'")['cnt'].iloc[0] <= select_df.query("table_nm == 'transport'")['cnt'].iloc[0]
    assert select_df.query("table_nm == 'metro_info'")['cnt'].iloc[0] <= select_df.query("table_nm == 'transport'")['cnt'].iloc[0]
    assert select_df.query("table_nm == 'trip_history'")['cnt'].iloc[0] <= select_df.query("table_nm == 'trip'")['cnt'].iloc[0]
