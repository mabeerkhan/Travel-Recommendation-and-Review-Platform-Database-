DROP DATABASE ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE category (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE product (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    manufacturer VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    description TEXT,
    avg_rating DECIMAL(2, 1),
    PRIMARY KEY (id),
    CHECK (price >= 0)
);

CREATE TABLE customer (
    id INT AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    payment_method VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE review (
    id INT AUTO_INCREMENT,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    review_text TEXT,
    rating INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    CHECK (rating >= 1 AND rating <= 5)
);

CREATE TABLE order_status (
    id INT AUTO_INCREMENT,
    status VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE `order` (
    id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_datetime DATETIME NOT NULL,
    delivery_date DATE,
    total_cost DECIMAL(10, 2) NOT NULL,
    status_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (status_id) REFERENCES order_status(id),
    CHECK (total_cost >= 0),
    CHECK (delivery_date >= order_datetime)
);

CREATE TABLE belongs_to (
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (category_id) REFERENCES category(id)
);

CREATE TABLE contains (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES `order`(id),
    FOREIGN KEY (product_id) REFERENCES product(id),
    CHECK (quantity >= 1),
    CHECK (price >= 0)
);

CREATE TABLE wishlist (
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    added_date DATE NOT NULL,
    PRIMARY KEY (customer_id, product_id),
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);
