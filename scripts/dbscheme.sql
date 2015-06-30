CREATE TABLE projects(
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE tasks(
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT
);
