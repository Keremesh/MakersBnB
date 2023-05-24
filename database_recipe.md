# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
1. As a user, I'd like to sign up to MakerBNB

2. As a user I'd like to create single or multiple spaces on MakersBNB

3. As a user, I'd like to offer a range of dates in which my space is available.

4. As a user I'd like to request to hire any space for one night

5. As a user I'd like to approve a request for my space

6. As a user I should only be able to book available spaces

7. As a user, I'd like my space to remain available for all bookings until I accept the request.

8. As a user, I want to provide information about my space including name, a short description and price per night.

```
Nouns:
user, spaces, MakersBnB, dates, range, approval, price, descrtiption, name. 
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
|  users                | email | password | name | username |
|  spaces               | title | description |  price | address |  available_dates | user_id (owner) |
|  reservations          | start_date | end_date | space_id | user_id (guest)|

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: users
id: SERIAL
email: varchar UNIQUE
password: varchar
name: text
username: varchar UNIQUE

Table: spaces
id: SERIAL
title: text
description: text
price: money
address: varchar UNIQUE
available_dates: tsrange
user_id: int

Table: reservations
start_date: timestamp
end_date: timestamp
space_id: int
user_id: int

```

## 4. Decide on The Tables Relationship

```
# EXAMPLE

1. Users can have many spaces, and many reservations <!-- (foreign keys in spaces and reservations) -->
2. Spaces belongs to users. Spaces can have many reservations
3. Reservations belongs to users and spaces

-> Therefore, the foreign keys are on spaces and reservations tables.


## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: users_table.sql

-- Create the table without the foreign key first.
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email varchar UNIQUE,
  password text,
  name text,
  username varchar UNIQUE
);

CREATE TABLE spaces (
  id SERIAL PRIMARY KEY,
  title text,
  description text,
  price money,
  address varchar UNIQUE,
  available_dates tsrange,
  user_id int,
  constraint fk_user foreign key(user_id)
      references users(id)
      on delete cascade
);

CREATE TABLE reservations (
  id SERIAL PRIMARY KEY,
  start_date timestamp,
  end_date timestamp,
  space_id int,
  user_id int,
  CONSTRAINT fk_user FOREIGN KEY(user_id)
      REFERENCES users(id)
      ON DELETE CASCADE,
  CONSTRAINT fk_space FOREIGN KEY(space_id)
      REFERENCES spaces(id)
      ON DELETE CASCADE
);


```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```

