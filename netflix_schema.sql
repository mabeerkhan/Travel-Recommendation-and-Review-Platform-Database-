DROP DATABASE netflix;
CREATE DATABASE netflix;
USE netflix;

CREATE TABLE series (
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE content (
	id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    release_date DATE NOT NULL,
    country VARCHAR(255),
    plot TEXT,
    rating FLOAT,
    series_id INT NOT NULL,
    PRIMARY KEY (id),
    CHECK (rating >= 1 AND rating <= 10),
    FOREIGN KEY (series_id) REFERENCES series(id)
);

CREATE TABLE crew (
	id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    family_name VARCHAR(255) NOT NULL,
    birthdate date,
    PRIMARY KEY (id)
);

CREATE TABLE customer (
	id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    family_name VARCHAR(255) NOT NULL,
	email VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (email)
);

CREATE TABLE subscription_plan (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
    cost INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name),
    CHECK (cost >= 0)
);

CREATE TABLE content_role (
	role_name VARCHAR(255) NOT NULL,
    content_id INT NOT NULL,
    crew_id INT NOT NULL,
	FOREIGN KEY (content_id) REFERENCES content(id),
    FOREIGN KEY (crew_id) REFERENCES crew(id)
);

CREATE TABLE series_role (
	role_name VARCHAR(255) NOT NULL,
    series_id INT NOT NULL,
    crew_id INT NOT NULL,
	FOREIGN KEY (series_id) REFERENCES series(id),
    FOREIGN KEY (crew_id) REFERENCES crew(id)
);

CREATE TABLE watched (
	watched_time timestamp NOT NULL,
    content_id INT NOT NULL,
    customer_id INT NOT NULL,
	FOREIGN KEY (content_id) REFERENCES content(id),
	FOREIGN KEY (customer_id) REFERENCES customer(id)
);

CREATE TABLE rated (
	user_rating SMALLINT NOT NULL,
    content_id INT NOT NULL,
    customer_id INT NOT NULL,
	FOREIGN KEY (content_id) REFERENCES content(id),
	FOREIGN KEY (customer_id) REFERENCES customer(id),
    PRIMARY KEY (content_id, customer_id)
);

CREATE TABLE subscription (
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    subscription_plan_id INT NOT NULL,
    customer_id INT NOT NULL,
	FOREIGN KEY (subscription_plan_id) REFERENCES subscription_plan(id),
	FOREIGN KEY (customer_id) REFERENCES customer(id),
    PRIMARY KEY (subscription_plan_id, customer_id)
);

CREATE TABLE content_type (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE content_to_type (	
    content_id INT NOT NULL,
    type_id INT NOT NULL,
	FOREIGN KEY (content_id) REFERENCES content(id),
	FOREIGN KEY (type_id) REFERENCES content_type(id)
);

CREATE TABLE content_genre (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE content_to_genre (	
    content_id INT NOT NULL,
    genre_id INT NOT NULL,
	FOREIGN KEY (content_id) REFERENCES content(id),
	FOREIGN KEY (genre_id) REFERENCES content_genre(id)
);

CREATE TABLE subscription_type (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE subscription_to_type (
    content_id INT NOT NULL,
    subscription_id INT NOT NULL,
	FOREIGN KEY (content_id) REFERENCES content(id),
	FOREIGN KEY (subscription_id) REFERENCES subscription_type(id)
);