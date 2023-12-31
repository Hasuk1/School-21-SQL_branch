# **Работа с базами данных (SQL)**

## **Проекты**

|**Project**| **Status**|
| ------ | ------ |
| `SQL1` [Bootcamp](https://github.com/Hasuk1/base_cmd_SQL/tree/main/src/Bootcamp)|1500 XP, 100%|
| `SQL2` [Info21 v1.0](https://github.com/Hasuk1/School-21-SQL_branch/tree/main/src/Info21%20v1.0)|600 XP, 120%|
| `SQL2` [ReatailAnalytics v1.0]()|In progress|

## **Введение**

`SQL (Structured Query Language)` - это язык программирования, используемый для работы с реляционными базами данных. Он предоставляет набор команд и инструкций для создания, изменения, управления и извлечения данных из базы данных.

SQL позволяет выполнять различные операции с данными, такие как создание таблиц, добавление, обновление и удаление записей, выполнение запросов для выборки данных иногое другое. Он широко применяется в различных областях, связанных с хранением иправлением данными, включая веб-разработку, анализ данных, бизнес-интеллект другие.

### **Примеры некоторых распространенных операторов SQL:**
```SQL
SELECT --(для выборки данных)
INSERT --(для добавления новых записей)
UPDATE --(для обновления существующих записей)
DELETE --(для удаления записей)
```
### **Часто используемые базы данных:**
- MySQL
- PostgreSQL
- Oracle
- MS SQL Server 
- SQLite
- dBase
- Hadoop
- MaxDB
- MariaDB
- Openbase

## **Общая структура баз данных**

`База данных` - это организованная коллекция структурированных данных, которая позволяет эффективно хранить,правлять и извлекать информацию. Она представляетобой систему, в которой данные организованы в таблицы или другие структуры, связанные между собой по определенным правилам. Базы данных используются дляранения информации в различных областях, таких как бизнес, наука, государственноеправление и другие. Они позволяют эффективно обрабатывать большие объемы данных, обеспечивать целостность и безопасность информации, а также выполнять запросы и анализировать данные для получения нужной информации.

## **Создание БД, таблиц и работа с ними**

### **Создание и удаление БД**
Чтобы создать базу данных, существует следущий SQL-запрос:
```SQL
CREATE DATABASE <db_name>;
```
Для удлание базы данных, уже используется следущий SQL-запрос:
```SQL
DROP DATABASE <db_name>;
```

Наиболее используемые типа данных для таблиц в базе данных:
- INT (числа)
- VARCHAR (строки до 255 символов)
- TEXT (большой текст)
- DATE (даты)

### **Создание таблицы**
```SQL
CREATE TABLE <table_name>(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30),
    bio TEXT,
    birth DATE/DATETIME,
    PRIMARY KEY(id)
);
```
>` NOT NULL` (не может быть пустым)

> `AUTO_INCREMENT` (каждая строка поля будет увеличиваться на один)

> `PRIMARY KEY(id)` (указанное поле не может повторяться)

> `VARCHAR(30)` - указывает максимальный размер строки

### **Удаление таблицы**
```SQL
DROP TABLE <table_name>;
```
### **Добавление поля в уже созданную таблицу**
```SQL
ALTER TABLE <table_name> ADD <var_name> VARCHAR/INT/...;
```

### **Удаление поля в уже созданной таблице**
```SQL
ALTER TABLE <table_name> DROP COLUMN <var_name>;
```

## **Добавление и обновление записей в БД**

### **Добавление записи **

```SQL
INSERT INTO <table_name> (<var_name>, ...) VALUES ('val', ...), (),..
```

### **Изменение поля**

```SQL
ALTER TABLE <table_name> CHANGE <var_name> <new_var_name> INT/... NOT NULL;
```

### **Обновление данных**

```SQL
UPDATE  `<table_name>` SET `<var_name>` = 'name' WHERE id = 1 AND age = 44;
```

## **Удаление данных из БД**

Для удаление данных из БД используется несколько операторов: Delete, Truncate и Alter. Последний для удаления колонок, а остальные для удаление записей, а также очистки таблицы от всего.

### **Команда Delete**

Команда Delete используется для удаление записей из таблицы. В команде можно указать параметр Where, чтобы удалить лишь те элементы, которые подходят под условие.

```SQL
-- Удаление всех записей из таблицы
DELETE FROM <var_name>;

-- Удаление лишь некоторых
DELETE FROM  WHERE id > 5;
```

### **Команда Truncate**

Команда Truncate используется для очистки таблицы от всех записей.

```SQL
TRUNCATE <var_name>;
```

Разница команд `Delete` и `Truncate` в том, что после Delete данные еще можно восстановить, а после Truncate нельзя. Из этого вытекает, что удаление данных черех Truncate происходит быстрее.

## **Выборка данных из БД. WHERE, ORDER, LIMIT.**

### Команда SELECT

```SQL
-- Выбор всех записей
SELECT * FROM <table_name>;

-- Выбор всех записей, но лишь некоторые поля
SELECT <var_name>, <var_name> FROM <table_name>;

-- Выбор лишь некоторых записей
SELECT * FROM <table_name> WHERE id > 6 AND id < 8;
```

### **Выборка по параметру**

```SQL
SELECT * FROM <table_name> WHERE <var_name> = 'val';

SELECT * FROM <table_name> WHERE <var_name> = 'val' AND id > 2;
```

### **Сортировка**

```SQL
SELECT * FROM <table_name> ORDER BY id;

-- Сортировка по убыванию
SELECT * FROM <table_name> ORDER BY id DESC;

-- Сортировка вместе с оператором Where
SELECT * FROM <table_name> WHERE id > 9 ORDER BY id DESC;
```

### **Лимит по выбору**

```SQL
-- Вывод лишь одной записи
SELECT * FROM <table_name> ORDER BY id LIMIT 1;

-- Вывод 5 последних записей
SELECT * FROM <table_name> ORDER BY id LIMIT 5;

-- Пропуск первых 7 записей и вывод последующих 8
SELECT * FROM <table_name> ORDER BY id DESC LIMIT 7, 8;
```

## **Создание индексов и работа с ними**

Создание и применение индекса к полю ускоряет поиск данных в этом поле. Рекомендуется избегать создания индексов для каждого поля, чтобы не негативно сказывалось на оптимизации базы данных.

### **Создание индекса**

```SQL
CREATE INDEX <index_name>
ON <table_name> (<var_name>);
```

### **Ключ Foreign**

`Foreign Key (внешний ключ)` - это столбец или набор столбцов в таблице базы данных, который устанавливает связь между двумя таблицами. Он определяет отношение между двумя таблицами, где значения в столбце с внешним ключом соответствуют значениям в столбце первичного ключа другой таблицы.

Внешний ключ используется для обеспечения целостности данных поддержания связей между таблицами. Он обеспечивает ссылочную целостность, что означает, что значения в столбце с внешним ключом должны быть либо равны значениям в столбце первичного ключа другой таблицы, либо быть NULL (если разрешено).

Пример использования внешнего ключа: предположим, у нас есть таблицы "Заказы" иКлиенты". В таблице "Заказы" мы можем иметь столбец "ID клиента", который является внешним ключом, связывающим каждый заказ с конкретным клиентом из таблицы "Клиенты Это позволяетам легко получать информацию о клиенте, связанную с каждым заказом.

Использование внешних ключей помогает обеспечить целостность данных, предотвращает ошибки и обеспечивает связи между таблицами базе данных.

### **Пример использования FOREIGN KEY**

```SQL
CREATE TABLE Orders (
 id int NOT NULL,
 OrderNumber int NOT NULL,
 PersonID int,
 PRIMARY KEY (OrderID),
 FOREIGN KEY (PersonID) REFERENCES users(id)
);
```

## **Объединение данных. JOIN (INNER, LEFT, RIGHT)**

В SQL, оператор JOIN используется для объединения данных из двух или более таблиц на основе определенного условия.н позволяет комбинировать строки из разных таблиц в один результат запроса.

JOIN выполняет соединение строк из таблиц на основе совпадения значений в указанных столбцах. Существуют различные типы JOIN, включая:

- `INNER JOIN` (внутреннее соединение): Возвращает только те строки, которые имеютовпадающие значения в обоих таблицах.

- `LEFT JOIN` (левое соединение):озвращает все строки из левой таблицы и соответствующие строки из правой таблицы. Если нет совпадающих значений, то для правой таблицы будут возвращены NULL значения.

- `RIGHT JOIN` (правое соединение): Возвращает все строки из правой таблицы и соответствующие строки из левой таблицы. Если нет совпадающих значений, то для левой таблицы будут возвращены NULL значения.

- `FULL JOIN` (полное соединение): Возвращает все строки из обеих таблиц,опоставляя их по совпадающим значениям. Если нет совпадающих значений, то дляедостающих значений будут возвращены NULL значения.

![joins](misc/type_JOINS.png)

`JOIN-условие` определяется с помощью ключевого слова ON, где указывается условие сравнения столбцов для объединения таблиц.

### Пример использования оператора JOIN:
```SQL
SELECT *
FROM Table1
INNER JOIN Table2 ON Table1.column = Table2.column;
```
В этом примере выполняется внутреннее соединение между Table1 и Table2 на основе совпадения значений в столбцах column. Результатом будет набор строк, содержащих данные из обеих таблиц,де значения столбца column совпадают.

Чаще всего используется формат Inner Join.
```SQL
SELECT Orders.ID, Customers.Name, Orders.OrderDate, Orders.Total
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.ID;
```

## **Псевдонимы, функции и Group By**

Псевдонимы (AS) используются для указания нового имени для поля или таблицы.

```SQL
SELECT biNameField AS bf FROM table;

SELECT o.personID AS id FROM ordersUsersTable AS o;
```

### **Основные функции для быстрой работы с данными:**

- count - подсчет элементов;
- min (max) - минимальный и максимальный элемент в определенном поле;
- avg - среднее арифметическое;
- sum - сумма всех элементов;
- ucase - всё в верхний регистр;
- lcase - всё в нижний регистр;

```SQL
SELECT MIN(price) AS 'Минимальная цена' FROM table;
```

### **Группирование данных**

```SQL
SELECT MIN(price) AS 'Минимальная цена', price AS 'Цена' FROM table GROUP BY price;
```

## **Все основные операции**

![base_cmd_SQL](misc/base_cmd_SQL.jpeg)
