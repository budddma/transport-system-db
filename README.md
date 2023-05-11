# База данных сети общественного транспорта

База данных включает одну схему `ts`, которая содержит 5 сущностей ([концептуальная модель](https://github.com/budddma/transport-system-db/blob/main/docs/conceptual-shit.png)), после нормализации – 8 таблиц ([логическая модель](https://github.com/budddma/transport-system-db/blob/main/docs/logical-model.png)). Во всех таблицах была использована 3НФ, т.к. атрибуты сразу не создавали транзитивных зависимостей. Таблица `trip` соответсвует SCD 4, история изменений хранится в `trip_history`.

Для удобства анализа представлена информация только о автобусных маршрутах и метро, но БД может быть лекго масштабируема на любые виды общественного транспорта путём замены флага `bus_flg` на enum типов транспорта.

**N.B.** Сущности `vodila`, `transport` и `trip` имеют однозначное соответствие. `trip_history` содержит предыдущую остановку и время ее переноса из `trip`.

---

#### Структура проекта
```shell
├── .gitlab-ci.yml           <- описание пайплайна для проекта (по шагам)
├── docs                     <- картинки и таблички
├── requirements.txt         <- зависимости для Python
├── scripts                  <- sql-скрипты
├── tests                    <- директория с Data Quality тестами
├── utils/pypsql.py          <- вспомогательный скрипт, чтобы не ставить дополнительно              
    └── conceptual-model.png    консольного клиента для Postgres (psql) 

```
