CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  email varchar UNIQUE,
  password varchar,
  name text,
  username varchar UNIQUE
);

CREATE TABLE IF NOT EXISTS spaces (
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

CREATE TABLE IF NOT EXISTS reservations (
  id SERIAL PRIMARY KEY,
  start_date timestamp,
  end_date timestamp,
  space_id int,
  user_id int,
  constraint fk_user foreign key(user_id)
      references users(id)
      on delete cascade,

  constraint fk_space foreign key(space_id)
      references spaces(id)
      on delete cascade
);