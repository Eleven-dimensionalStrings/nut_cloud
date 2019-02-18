/*DROP TABLE IF EXISTS user;*/

CREATE TABLE IF NOT EXISTS USER(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    isadmin INTEGER NOT NULL
);

/*DROP TABLE IF EXISTS logs;*/

CREATE TABLE IF NOT EXISTS LOGS(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userid INTEGER NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    FOREIGN KEY (userid) REFERENCES user (id)
);

/* app - pan */
/*DROP TABLE IF EXISTS panuser;*/

CREATE TABLE IF NOT EXISTS PANUSER(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userid INTEGER UNIQUE NOT NULL,
    FOREIGN KEY (userid) REFERENCES user (id)
);

/*DROP TABLE IF EXISTS Share_Info;*/

CREATE TABLE IF NOT EXISTS Share_Info(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    link TEXT NOT NULL,
    filename TEXT NOT NULL,
    userid INTEGER NOT NULL,
    password TEXT,
    expiretime TIMESTAMP,
    FOREIGN KEY (userid) REFERENCES user (id)
);

/* shop */

/*DROP TABLE IF EXISTS shopuser;*/

CREATE TABLE IF NOT EXISTS SHOPUSER(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userid INTEGER UNIQUE NOT NULL,
    phone TEXT NOT NULL,
    email TEXT NOT NULL,
    address TEXT NOT NULL,
    postalcode INTEGER NOT NULL,
    isadmin INTEGER NOT NULL,
    FOREIGN KEY (userid) REFERENCES user (id)
);

/*DROP TABLE IF EXISTS goods;*/

CREATE TABLE IF NOT EXISTS GOODS(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    value INTEGER NOT NULL,
    type TEXT,
    description TEXT,
    amount INTEGER,
    isOnsale INTEGER NOT NULL
);

DROP TABLE IF EXISTS ticket;

CREATE TABLE ticket(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    address TEXT NOT NULL,
    value INTEGER NOT NULL,
    userid INTEGER NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status INTEGER NOT NULL,
    FOREIGN KEY (userid) REFERENCES user (id)
);

/*DROP TABLE IF EXISTS cart;*/

CREATE TABLE IF NOT EXISTS cart(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ticketid INTEGER,
    goodid INTEGER NOT NULL,
    amount INTEGER NOT NULL,
    userid INTEGER NOT NULL,
    FOREIGN KEY (userid) REFERENCES user (id)
);

