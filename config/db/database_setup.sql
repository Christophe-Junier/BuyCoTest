create database db_buyco;
\connect db_buyco

CREATE TABLE boxes(
       id       integer NOT NULL PRIMARY KEY,
       type     varchar(50) NOT NULL,
       locked   boolean NOT NULL,
       height   decimal NOT NULL,
       width    decimal NOT NULL,
       depth    decimal NOT NULL,
       contents varchar(50) NOT NULL
);

 CREATE TABLE volumes(
        boxe_id integer references boxes(id),
        volume  decimal NOT NULL
 );

 CREATE TABLE origines(
        boxe_id     integer references boxes(id),
        line1       varchar(50) NOT NULL,
        line2       varchar(50) NOT NULL,
        city        varchar(50) NOT NULL,
        state       varchar(50) NOT NULL,
        postal_code varchar(50) NOT NULL,
        country     varchar(3) NOT NULL
 );
