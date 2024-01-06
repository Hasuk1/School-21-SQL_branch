DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TYPE status AS ENUM ('0','1','2');
CREATE TYPE inp_out AS ENUM ('1','2');

CREATE TABLE IF NOT EXISTS Peers(
    Nickname VARCHAR PRIMARY KEY,
    Birthday DATE
);

CREATE TABLE IF NOT EXISTS  Tasks(
    Title VARCHAR UNIQUE,
    ParentTask VARCHAR,
    MaxXP INT,
    CONSTRAINT check_equality CHECK (ParentTask != Title)
);

CREATE TABLE IF NOT EXISTS  Checks(
    id SERIAL PRIMARY KEY,
    Peer VARCHAR,
    Task VARCHAR,
    "Date" DATE,
    CONSTRAINT peers_checks FOREIGN KEY (Peer) REFERENCES Peers(Nickname),
    CONSTRAINT tasks_title_task FOREIGN KEY (Task) REFERENCES Tasks(Title)
);

CREATE TABLE IF NOT EXISTS  P2P(
    id SERIAL PRIMARY KEY,
    "Check" INT ,
    CheckingPeer VARCHAR ,
    "State" status,
    "Time" TIME ,
    CONSTRAINT unique_check_id FOREIGN KEY (CheckingPeer) REFERENCES Peers(Nickname),
    CONSTRAINT p2p_id_checks FOREIGN KEY ("Check") REFERENCES Checks(id)
);

CREATE TABLE IF NOT EXISTS  Verter(
    id SERIAL PRIMARY KEY,
    "Check" INT ,
    "State" status,
    "Time" TIME ,
    CONSTRAINT id_checks FOREIGN KEY ("Check") REFERENCES Checks(id)
);

CREATE TABLE IF NOT EXISTS  TransferredPoints(
    id SERIAL PRIMARY KEY,
    CheckingPeer VARCHAR ,
    CheckedPeer VARCHAR ,
    PointsAmount INT  default 0,
    CONSTRAINT p1_checking_peer FOREIGN KEY (CheckingPeer) REFERENCES Peers(Nickname),
    CONSTRAINT p1_checked_peer FOREIGN KEY (CheckedPeer) REFERENCES Peers(Nickname),
    CONSTRAINT unique_pair CHECK (CheckingPeer != CheckedPeer)
);

CREATE TABLE IF NOT EXISTS Friends(
    id SERIAL PRIMARY KEY,
    Peer1 VARCHAR ,
    Peer2 VARCHAR ,
    CONSTRAINT p1_friend FOREIGN KEY (Peer1) REFERENCES Peers(Nickname),
    CONSTRAINT p2_friend FOREIGN KEY (Peer2) REFERENCES Peers(Nickname),
    CONSTRAINT unique_pair CHECK (Peer1 != Peer2)
);

CREATE TABLE IF NOT EXISTS Recommendations(
    id SERIAL PRIMARY KEY,
    Peer VARCHAR ,
    RecommendedPeer VARCHAR ,
    CONSTRAINT peers_nickname FOREIGN KEY (Peer) REFERENCES Peers(Nickname),
    CONSTRAINT recommended_nickname FOREIGN KEY (RecommendedPeer) REFERENCES Peers(Nickname),
    CONSTRAINT unique_pair CHECK (Peer != RecommendedPeer)
);

CREATE TABLE IF NOT EXISTS  XP(
    id SERIAL PRIMARY KEY,
    "Check" INT ,
    XPAmount INT  default 0,
    CONSTRAINT id_checks FOREIGN KEY ("Check") REFERENCES Checks(id)
);

CREATE TABLE IF NOT EXISTS TimeTracking(
    id SERIAL PRIMARY KEY,
    Peer VARCHAR,
    "Date" DATE,
    "Time" TIME,
    "state" inp_out, /* 1 - input, 2 - output */
    CONSTRAINT t_t_peers_nickname FOREIGN KEY (Peer) REFERENCES Peers(Nickname)
);