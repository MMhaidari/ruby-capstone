--Create database
CREATE DATABASE my_catalog;

-- Create item table
CREATE TABLE item (
  id INT PRIMARY KEY,
  genre_id INT REFERENCES genre(id),
  publish_date DATE,
  archived BOOLEAN,
);

-- Create music albums table
CREATE TABLE music_albums (
  id INT PRIMARY KEY,
  publish_date DATE NOT NULL DEFAULT DATE,
  on_spotify BOOLEAN,
  archived BOOLEAN,
  genre_id INT,
  CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES genres(id)
);

-- Create genres table
CREATE TABLE genres (
  id INT PRIMARY KEY,
  name VARCHAR(100),
);
-- Create database for the movies
Create database catalog_of_my_things;

--Create source table
CREATE TABLE SOURCE(
  ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
  NAME VARCHAR(150));

--Create table Movies
CREATE TABLE MOVIES(ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
  SOURCE_ID INT, 
  NAME VARCHAR(150), 
  PUBLISH_DATE DATE, SILENT BOOLEAN, 
  CONSTRAINT FK_SOURCE FOREIGN KEY(SOURCE_ID) REFERENCES SOURCE(ID));



