BEGIN TRANSACTION;

CREATE TABLE payment (
        payment_id SERIAL NOT NULL,
        price numeric (5, 2) NOT NULL,
        tax numeric (3, 2) NOT NULL,
        pay_date DATE NOT NULL,
        CONSTRAINT pk_payment_payment_id PRIMARY KEY (payment_id)
);

CREATE TABLE address (
        address_id SERIAL NOT NULL,
        address VARCHAR (50) NOT NULL,
        address_2 VARCHAR (50),
        state VARCHAR(20) NOT NULL,
        city VARCHAR (50) NOT NULL,
        zip VARCHAR (10) NOT NULL,
        CONSTRAINT pk_address_address_id PRIMARY KEY (address_id)
);

CREATE TABLE owner (
        owner_id SERIAL NOT NULL,
        first_name VARCHAR(64) NOT NULL,
        last_name VARCHAR(64) NOT NULL,
        address_id INTEGER NOT NULL,
        CONSTRAINT pk_owner_owner_id PRIMARY KEY (owner_id),
        CONSTRAINT fk_address_id FOREIGN KEY (address_id) REFERENCES address(address_id)      
);

CREATE TABLE pet (
        pet_id SERIAL NOT NULL,
        pet_name VARCHAR(64),
        pet_age SMALLINT,
        pet_type VARCHAR(64),
        visit_date DATE,
        owner_id INTEGER,
        CONSTRAINT pk_pet_pet_id PRIMARY KEY (pet_id),
        CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owner(owner_id) 
);

CREATE TABLE hospital (
        hospital_id SERIAL NOT NULL,
        address_id INTEGER NOT NULL,
        CONSTRAINT pk_hospital_hospital_id PRIMARY KEY (hospital_id),
        CONSTRAINT fk_address_id FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE visit (
        visit_id SERIAL NOT NULL,
        visit_date DATE NOT NULL,
        pet_id INTEGER NOT NULL,
        CONSTRAINT pk_visit_visit_id PRIMARY KEY (visit_id),
        CONSTRAINT fk_pet_id FOREIGN KEY (pet_id) REFERENCES pet(pet_id)
);

CREATE TABLE procedure (
        procedure_id SERIAL NOT NULL,
        procedure_name VARCHAR(64) NOT NULL,
        payment_id INTEGER,
        CONSTRAINT pk_procedure_procedure_id PRIMARY KEY (procedure_id),
        CONSTRAINT fk_payment_id FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);

CREATE TABLE procedure_visit (
        procedure_id INTEGER NOT NULL,
        visit_id INTEGER NOT NULL,
        CONSTRAINT fk_procedure_id FOREIGN KEY (procedure_id) REFERENCES procedure(procedure_id),
        CONSTRAINT fk_visit_id FOREIGN KEY (visit_id) REFERENCES visit(visit_id)
);

COMMIT;

ROLLBACK;