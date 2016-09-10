CREATE TABLE `community` (
    `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    `name` TEXT NOT NULL,
    `code` INTEGER NOT NULL UNIQUE
);

CREATE TABLE `province` (
    `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    `name` TEXT NOT NULL,
    `code` INTEGER NOT NULL UNIQUE,
    `community_id` INTEGER NOT NULL,
    FOREIGN KEY(`community_id`) REFERENCES community(id)
);

CREATE TABLE `municipality` (
    `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    `name` TEXT NOT NULL,
    `code` INTEGER NOT NULL UNIQUE,
    `province_id` INTEGER NOT NULL,
    FOREIGN KEY(`province_id`) REFERENCES province(id)
);

CREATE TABLE `place` (
    `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    `name` TEXT NOT NULL,
    `code` INTEGER NOT NULL UNIQUE,
    `municipality_id` INTEGER NOT NULL,
    FOREIGN KEY(`municipality_id`) REFERENCES municipality(id)
);
