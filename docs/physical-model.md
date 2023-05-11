## Физическая модель

#### `stop`:
| **Название** 	| **Описание**                     	| **Тип данных** 	| **Ограничение** 	|
|--------------	|----------------------------------	|----------------	|-----------------	|
| stop_id      	| ID остановки                     	| INTEGER        	| PRIMARY KEY     	|
| stop_nm      	| название остановки               	| VARCHAR(30)    	| NOT NULL          |
| bus_flg      	| является ли остановка автобусной 	| BOOLEAN        	| NOT NULL        	|

#### `route`:
| **Название**    	| **Описание**           	| **Тип данных** 	| **Ограничение** 	|
|-----------------	|------------------------	|----------------	|-----------------	|
| route_id        	| ID маршрута            	| INTEGER        	| PRIMARY KEY     	|
| route_nm        	| название маршрута      	| VARCHAR(30)    	| NOT NULL        	|
| initial_stop_id 	| ID начальной остановки 	| INTEGER        	| FOREIGN KEY     	|
| final_stop_id   	| ID конечной            	| INTEGER        	| FOREIGN KEY     	|

#### `vodila`:
| **Название** 	| **Описание** 	| **Тип данных** 	| **Ограничение** 	|
|--------------	|--------------	|----------------	|-----------------	|
| vodila_id    	| ID водителя  	| INTEGER        	| PRIMARY KEY     	|
| vodila_nm    	| ФИО водителя 	| VARCHAR(30)    	|                 	|
| experience   	| годы стажа   	| INTEGER        	| DEFAULT         	|

#### `transport`:
| **Название** 	| **Описание** 	| **Тип данных** 	| **Ограничение** 	| 
|--------------	|--------------	|----------------	|-----------------	|
| transport_id 	| ID траспорта                    	| INTEGER        	| PRIMARY KEY     	|
| vodila_id    	| ID водителя                     	| INTEGER        	| FOREIGN KEY     	|
| bus_flg      	| является ли транспорт автобусом 	| BOOLEAN        	| NOT NULL        	|

#### `trip`:
| **Название** 	| **Описание**                   	| **Тип данных** 	| **Ограничение** 	|
|--------------	|--------------------------------	|----------------	|-----------------	|
| trip_id      	| ID поездки                     	| INTEGER        	| PRIMARY KEY     	|
| transport_id 	| ID траспорта                   	| INTEGER        	| FOREIGN KEY     	|
| route_id     	| ID маршрута                    	| INTEGER        	| FOREIGN KEY     	|
| curr_stop_id 	| последняя пройденная остановка 	| INTEGER        	| FOREIGN KEY     	|

#### `trip_history`:
| **Название** 	| **Описание**                 	| **Тип данных** 	| **Ограничение** 	|
|--------------	|------------------------------	|----------------	|-----------------	|
| trip_id      	| ID поездки                   	| INTEGER        	| FOREIGN KEY     	|
| curr_stop_id 	| остановка до curr_stop_id    	| INTEGER        	| FOREIGN KEY     	|
| update_dttm  	| время изменения curr_stop_id 	| TIMESTAMP      	| NOT NULL        	|

#### `bus_info`:
| **Название** 	| **Описание**                     	| **Тип данных** 	| **Ограничение** 	| 
|--------------	|---------------------------------------	|-------------	|-------------	|
| transport_id 	| ID траспорта                          	| INTEGER     	| FOREIGN KEY 	|
| bus_no       	| номер авто                            	| VARCHAR(30) 	| UNIQUE      	|
| fuel         	| тип топлива: petrol, gas, electricity 	| INTEGER     	|             	|
| capacity     	| пассажировместимость                    	| INTEGER     	|             	|

#### `metro_info`:
| **Название** 	| **Описание**                  	| **Тип данных** 	| **Ограничение** 	|
|--------------	|-------------------------------	|----------------	|-----------------	|
| transport_id 	| ID траспорта                  	| INTEGER        	| FOREIGN KEY     	|
| cars_cnt     	| число вагонов                 	| INTEGER        	|                 	|
| capacity     	| пассажировместимость            	| INTEGER        	|                 	|
| depot        	| депо поезда                   	| VARCHAR(30)    	|                 	|
