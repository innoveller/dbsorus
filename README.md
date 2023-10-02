# DbSorus

- [What is DbSorus?](#what-is-dbsorus)
- [Installation](#installation)
- [Documentation](#documentation)

## What is DbSorus?

For integration tests with actual databases, DbSorus helps you load initial data to a PostgreSQL database using markdown tables.

Working with SQL insert statements as seed scripts can be hard since the seed data cannot be easily visualized when tests are being developed or traced back after results.

With DbSorus, test developers can describe seed data in Markdown file. 
Only relevant columns for the tests need to be in the Markdown tables. 
DbSorus will fill up the not relevant columns with fake values.

### Example

Suppose we have the following movie table in the database.
```
CREATE TABLE movie
(
    movie_id        integer,    
    title           text,
    released_year   integer,
    country_code    varchar(2), 
    total_reviews   integer not null,
    PRIMARY KEY  (movie_id)
);
```
The initial seed data can be described in markdown file.


```markdown
@table:movie

| movie_id | title           | released_year | country_code |
|----------|-----------------|---------------|--------------|
| 1        | The Godfather   | 1972          | US           |
| 2        | The Dark Knight | 2008          | US           |
| 3        | Titanic         | 1997          | US           |

```

Then you can invoke DbSours to load initial data to the exisiting database.
```
DbSorus.configure(Thread.currentThread().getContextClassLoader())
                .dataSource(jdbcUrl, dbUsername, dbPassword)
                .seedPath("path-to/seed-tables.md")
                .load();
```

DbSorus will compose and execute the following insert statements against the database.
```
INSERT INTO movie 
(movie_id, title, released_year, country_code, total_reviews) 
VALUES 
('1', 'The Godfather', '1972', 'US', 0),
('2', 'The Dark Knight', '2008', 'US', 0),
('3', 'Titanic', '1997', 'US', 0);
```


## Installation

### Maven

```xml
<repositories>
    <repository>
        <id>jitpack.io</id>
        <url>https://jitpack.io</url>
    </repository>
</repositories>
```

```xml
<dependency>
    <groupId>com.github.innoveller</groupId>
    <artifactId>dbsorus</artifactId>
    <version>0.1.2</version>
</dependency>
```

### sbt

Add it in your build.sbt at the end of resolvers:
```sbt
resolvers += "jitpack" at "https://jitpack.io"
```
Add the dependency
```sbt
libraryDependencies += "com.github.innoveller" % "dbsorus" % "0.1.2"
```

## Directives

### Integer Directive
```
@integer:admin-user-id
@integer:agent-user-id
```

### UUID Directive

```
@uuid:order-1
@uuid:product-x
```

### Example:
```markdown
@table:movie

| movie_id | title           | released_year |
|----------|-----------------|---------------|
| @uuid:x  | The Godfather   | 1972          |
| @uuid:y  | The Dark Knight | 2008          |

@table:best_picture_winner

| year | movie_id |
|------|----------|
| 1973 | @uuid:x  |

```
The following will be inserted into actual database.

#### movie

| movie_id                              | title           | released_year |
|---------------------------------------|-----------------|---------------|
| 8a3857ba-5f81-11ee-8c99-0242ac120002  | The Godfather   | 1972          |
| a287b298-5f81-11ee-8c99-0242ac120002  | The Dark Knight | 2008          |

#### best_picture_winner

| year | movie_id                              |
|------|---------------------------------------|
| 1973 | 8a3857ba-5f81-11ee-8c99-0242ac120002  |

### Date Time Directive
Supports ISO-8601 Duration Format

https://www.digi.com/resources/documentation/digidocs//90001488-13/reference/r_iso_8601_duration_format.htm

Local Date
```
@date:today
@date:today+P1D
@date:today+P1Y6M
@date:today-P1M
```

Local Date Time
```
@datetime:now
@datetime:now+PT1H
@datetime:now+PT10M
```

Instant
```
@instant:now
@instant:now+PT1H
@instant:now+PT10M
```

### Series Directive

Series directives support for both integers and dates.
```
@series:1000..2000
@series:2023-01-01..2023-01-03
```
### Example
```markdown
@table:room_rate

| room_id | date                            | amount |
|---------|---------------------------------|--------|
| 1       |  @series:2023-01-01..2023-01-03 | 120    |
| 1       |  @series:2023-01-04..2023-01-06 | 150    |

```
Result will be the table with generated dates.

| room_id | date       | amount |
|---------|------------|--------|
| 1       | 2023-01-01 | 120    |
| 1       | 2023-01-02 | 120    |
| 1       | 2023-01-03 | 120    |
| 1       | 2023-01-04 | 150    |
| 1       | 2023-01-05 | 150    |
| 1       | 2023-01-06 | 150    |

---

Thanks for reading!

🎁
