CREATE TABLE projects(
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE tasks(
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT
);

CREATE TABLE `users` (
	id INTEGER PRIMARY KEY,
	name TEXT NOT NULL,
	google_data TEXT,
	img_url TEXT,
	google_id TEXT
);
