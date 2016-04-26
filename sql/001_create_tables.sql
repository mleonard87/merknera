DROP TABLE move;
DROP TABLE game_bot;
DROP TABLE game;
DROP TABLE bot;
DROP TABLE game_type;
DROP TABLE merknera_user;
 

CREATE TABLE merknera_user (
  id               SERIAL PRIMARY KEY NOT NULL
, username         VARCHAR(250) UNIQUE NOT NULL
, token            CHAR(50) UNIQUE NOT NULL
, created_datetime TIMESTAMP WITH TIME ZONE DEFAULT (now()) NOT NULL
);

CREATE INDEX ON merknera_user (username);

CREATE INDEX ON merknera_user (token);

CREATE TABLE game_type (
  id               SERIAL PRIMARY KEY NOT NULL
, mnemonic         VARCHAR(50) UNIQUE NOT NULL
, name             VARCHAR(250) NOT NULL
, created_datetime TIMESTAMP WITH TIME ZONE DEFAULT (now()) NOT NULL
);

CREATE INDEX ON game_type (mnemonic);

CREATE TABLE bot (
  id                   SERIAL PRIMARY KEY NOT NULL
, name                 VARCHAR(250) NOT NULL
, version              VARCHAR(100) NOT NULL
, game_type_id         INTEGER REFERENCES game_type (id) NOT NULL
, user_id              INTEGER REFERENCES merknera_user (id) NOT NULL
, rpc_endpoint         VARCHAR(500) NOT NULL
, programming_language VARCHAR(250)
, website              VARCHAR(500) NULL
, status               VARCHAR(20) NOT NULL CHECK (status IN ('ONLINE', 'OFFLINE', 'ERROR'))
, created_datetime     TIMESTAMP WITH TIME ZONE DEFAULT (now()) NOT NULL
);

CREATE TABLE game (
  id               SERIAL PRIMARY KEY NOT NULL
, game_type_id     INTEGER REFERENCES game_type (id) NOT NULL
, status           VARCHAR(50) DEFAULT 'NOT STARTED' NOT NULL CHECK (status IN ('NOT STARTED', 'IN PROGRESS', 'COMPLETE'))
, state            JSONB NOT NULL
, created_datetime TIMESTAMP WITH TIME ZONE DEFAULT (now()) NOT NULL
);

CREATE TABLE game_bot (
  id               SERIAL PRIMARY KEY NOT NULL
, game_id          INTEGER NOT NULL
, bot_id           INTEGER NOT NULL
, play_sequence    INTEGER NOT NULL
, created_datetime TIMESTAMP WITH TIME ZONE DEFAULT (now()) NOT NULL
, UNIQUE (game_id, bot_id)
);

CREATE INDEX ON game_bot (game_id);

CREATE TABLE move (
  id               SERIAL PRIMARY KEY NOT NULL
, game_bot_id      INTEGER REFERENCES game_bot (id) NOT NULL
, status           VARCHAR(20) DEFAULT 'AWAITING' NOT NULL CHECK (status IN ('AWAITING', 'COMPLETE'))
, created_datetime TIMESTAMP WITH TIME ZONE DEFAULT (now()) NOT NULL
);


