# CLAUDE.md

Инструкции для Claude Code при работе с проектом gtrd-site (BE5-приложение, база GTRD).

## Подключение к БД

- Профиль соединения: `local_mysql` из `src/connectionProfiles.local.yaml` (выбран в `src/profile.local`): `jdbc:mysql://localhost:3306/gtrd_current`, user/pass `gtrd`/`gtrd`.
- На этой машине **нет mysql CLI** (ни Windows, ни WSL). Запросы к БД выполнять через Python:
  ```python
  "/c/Program Files/Python/python.exe"  # pymysql установлен
  import pymysql
  c = pymysql.connect(host='localhost', user='gtrd', password='gtrd', database='gtrd_current')
  ```

## Схемы сущностей (src/meta/entities/*.yaml)

Правило: yaml-сущность должна **точно** соответствовать реальной схеме БД. Норма проверки:
`mvn be5:sync` → BUILD SUCCESS **без** блока "The following statements should be executed to update database scheme".

Процесс описания таблицы:

1. Взять реальную структуру: `SHOW CREATE TABLE <t>;` (через pymysql, см. выше).
2. Описать в `src/meta/entities/<t>.yaml`:
   - PK: `primaryKey: <col>` на уровне сущности + `primaryKey: true` у колонки;
   - `canBeNull: true` — nullable-колонки;
   - описание колонки — ключ **`doc`** (НЕ `description` — парсер отклоняет);
   - допустимые ключи колонки: `canBeNull, reference, oldNames, defaultValue, autoIncrement, name, doc, extras, placeholder, type, primaryKey`;
   - enum-колонка: `type: ENUM('reviewed', 'unreviewed')` — значения в кавычках через запятую. Голый `ENUM` не работает (sync ломается на `IN ()`).
   - индексы (не-PK): блок `indices:` на уровне сущности рядом с `scheme` (ключ `indexes:` отклоняется):
     ```yaml
     indices:
     - species:
         columns: species
     ```
3. Проверить: `mvn be5:sync`. Если вывел DDL-различия — доработать yaml, а **не** применять `-DBE5_FORCE_UPDATE=true` (он меняет БД под yaml).

Рабочий эталон: `src/meta/entities/uniprot.yaml`. Примеры в референсном проекте: `C:\projects\lk\registry\src\meta\entities`.
