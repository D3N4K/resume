-- Ошибка при удалении схемы (SQL Error [3F000]: ERROR: schema "zoo" does not exist)
-- Возникает при запуске вашего скрипта в БД, в которой нет схемы zoo.
-- Исправить можно, использовав конструкцию DROP SCHEMA IF EXISTS
--DROP SCHEMA zoo CASCADE;
DROP SCHEMA IF EXISTS zoo CASCADE;
CREATE SCHEMA zoo;

---------------------------------------- СЕКЦИЯ ПРО ЖИВНОСТЬ

-- Вид животного
-- Исправлено имя таблицы (просто с точки зрения английского языка)
-- Мы же описываем предметную область
-- Убрана ссылка на methods_nutrition
-- Климатическая зона заменена на Нуждается ли в обогреве? (Только это было в ТЗ)
-- Также Является ли хищником? Если нет, то травоядное :)
DROP TABLE IF EXISTS zoo.specie;
CREATE TABLE zoo.specie
(
 specie_id bigint primary key,
 "name" varchar(100) not null,
 is_predator bool DEFAULT FALSE,
 warm_aviary bool DEFAULT FALSE
);

-- Животные
-- Исправлены имена столбцов: id_type_of_animal -> spiece_id (Есть же ан-- Ошибка при удалении схемы (SQL Error [3F000]: ERROR: schema "zoo" does not exist)
-- Возникает при запуске вашего скрипта в БД, в которой нет схемы zoo.
-- Исправить можно, использовав конструкцию DROP SCHEMA IF EXISTS
--DROP SCHEMA zoo CASCADE;
DROP SCHEMA IF EXISTS zoo CASCADE;
CREATE SCHEMA zoo;

---------------------------------------- СЕКЦИЯ ПРО ЖИВНОСТЬ

-- Вид животного
-- Исправлено имя таблицы (просто с точки зрения английского языка)
-- Мы же описываем предметную область
-- Убрана ссылка на methods_nutrition
-- Климатическая зона заменена на Нуждается ли в обогреве? (Только это было в ТЗ)
-- Также Является ли хищником? Если нет, то травоядное :)
DROP TABLE IF EXISTS zoo.specie;
CREATE TABLE zoo.specie
(
 specie_id bigint primary key,
 "name" varchar(100) not null,
 is_predator bool DEFAULT FALSE,
 warm_aviary bool DEFAULT FALSE
);

-- Животные
-- Исправлены имена столбцов: id_type_of_animal -> spiece_id (Есть же английский язык, поправьте меня если я не прав)
-- Не было FK к Видам животных
-- У ВАС:
--  (SQL Error [42830]: ERROR: there is no unique constraint matching given keys for referenced table "animals")
-- ПРИЧИНА:
-- 	Возникает из-за того, что ограничение внешнего ключа (FK) должно ссылаться на уникальную запись в “родительской” таблице.
-- 	У вас в родительской таблице первичный ключ состоит из id_animal и gender, а ссылаетесь только на id.
-- РЕШЕНИЕ:
-- 	Начиная с postgres версии 12 можно ссылаться на секционированную таблицу.
-- 	Можно добавить в feeding_schedule столбец gender и сделать FK по 2 столбцам.
-- 	Можно также подумать над реализацией разбиения Animals по половому признаку связми 1:1
-- 	Такая проблема будет везде, где вы ссылаетесь на таблицу animals.
DROP TABLE IF EXISTS zoo.animal;
CREATE TABLE zoo.animal
(
    "id" bigint generated ALWAYS AS IDENTITY PRIMARY key,
    "name" varchar(100) not null,
	date_of_birthday date not null DEFAULT now()::date,
    date_of_appearance date not null,
    maturity bool not null,
    gender varchar(6) NOT NULL CHECK (gender IN ('female', 'male')),
    specie_id bigint not NULL REFERENCES zoo.specie(specie_id)
);

CREATE OR REPLACE FUNCTION zoo.animal_distribution() RETURNS trigger AS
$$
BEGIN
    IF NEW.gender = 'male' THEN
        INSERT INTO zoo.animal_male(id) SELECT NEW.id WHERE NOT EXISTS (SELECT 1 FROM zoo.animal_male WHERE id = NEW.id);
    ELSIF NEW.gender = 'female' THEN
        INSERT INTO zoo.animal_female(id) SELECT NEW.id WHERE NOT EXISTS (SELECT 1 FROM zoo.animal_female WHERE id = NEW.id);
    END IF;
    RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER distribute_animal_gender
AFTER INSERT ON zoo.animal
FOR EACH ROW EXECUTE FUNCTION zoo.animal_distribution();

-- Реализация через 1:1
-- Самцы
DROP TABLE IF EXISTS animals_male;
CREATE TABLE zoo.animal_male (
	id bigint PRIMARY KEY,
	FOREIGN KEY (id) REFERENCES zoo.animal(id)
);

-- Самки
DROP TABLE IF EXISTS animal_female;
CREATE TABLE zoo.animal_female(
	id bigint PRIMARY KEY,
	FOREIGN KEY (id) REFERENCES zoo.animal(id)
);

--Детёныши
-- Тут, по-моему мнению, уникальность определяется самим детёнышом
-- Поэтому не надо сурогатного ключа
-- Поменял название (дело вкуса, вообще есть определенные стандарты)
-- Тут тоже была бы проблема в связи с животными из-за ключа секционирования
DROP TABLE IF EXISTS zoo.baby;
CREATE TABLE zoo.baby
(
-- id_childbirth bigint primary key,
 baby_id bigint PRIMARY KEY references zoo.animal(id),
 father_id bigint references zoo.animal_male(id),
 mother_id bigint references zoo.animal_female(id)
);


-- Соседства\Совместимость
-- id соседства тут не нужно
-- Это М:М связь Вида самой с собой, поэтому ключом является Вид1 Вид2
-- Названия в ед числе
-- Опустим в БД совместимость при расселение по вольерам\клеткам, т.к. на уровне БД тяжело это продумать
-- + Нет карты вольеров и по ТЗ не описано это, но можем дополнить вместе, будет весело
-- Вынесем это в питон(наверное, если успеем)
DROP TABLE IF EXISTS zoo.neighborhood;
CREATE TABLE zoo.neighborhood
(
  spiece_id bigint references zoo.specie(specie_id),
  compatible_spiece bigint references zoo.specie(specie_id),
  PRIMARY KEY(spiece_id, compatible_spiece)
);

---------------------------------------- Клетки\Вольеры
--Вольеры
-- Имя в ед числе
DROP TABLE IF EXISTS zoo.aviary;
CREATE TABLE zoo.aviary
(
  aviary_id bigint primary key,
  heating bool DEFAULT FALSE
);

--Обитатели вольера
-- Убрали совместимость
-- Переименовали аккуратнее
-- Изменили ключ
-- Так как у вас его и не было :)
DROP TABLE IF EXISTS zoo.aviary_inhabitant;
CREATE TABLE zoo.aviary_inhabitant
(
  animal_id bigint REFERENCES zoo.animal(id),
  aviary_id bigint references zoo.aviary(aviary_id),
  start_date date DEFAULT now()::date,
  end_date date DEFAULT NULL,
  PRIMARY KEY(animal_id, aviary_id, start_date)
);


---------------------------------------- Зоопарк + обмен
--Зоопарки
-- Нейминг) Зу-зу
DROP TABLE IF EXISTS zoo.zoo;
CREATE TABLE zoo.zoo
(
 id bigint primary key,
 "name" varchar(100) not null,
 country varchar(30) not null,
 city varchar(30) not null
);

--Обмен
-- Не нашёл таблицы references zoo.change(id_change) not null
-- И зачем оно тут?
DROP TABLE IF EXISTS zoo.exchange;
CREATE TABLE zoo.exchange
(
 exchange_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY key,
 animal_id bigint references zoo.animal(id) not null,
 zoo_id bigint references zoo.zoo(id),
 "action" varchar(10) CHECK ("action" IN ('given away', 'adopted')),
 deal_date date NOT null
);

---------------------------------------- Кормление\Меню\Поставщики\Корм и тд
-- Способы питания
-- Смысл таблицы? Про что это? Я уже забыл
-- Ещё и название странное :)
--DROP TABLE IF EXISTS zoo.methods_of_nutrition;
--CREATE TABLE zoo.methods_of_nutrition
--(
-- id_method bigint primary key,
-- name_method varchar(50) not null
--);

--Тип корма
-- Нейминг
DROP TABLE IF EXISTS zoo.food_type;
CREATE TABLE zoo.food_type
(
 id bigint primary key,
 "name" varchar(50) not null
);

--Корм.
DROP TABLE IF EXISTS zoo.food;
CREATE TABLE zoo.food
(
 id bigint primary key,
 type_id bigint references zoo.food_type(id) not null,
 "name" varchar(50) not null
);

--Поставщики
DROP TABLE IF EXISTS zoo.provider;
CREATE TABLE zoo.provider
(
 id bigint primary key,
 "name" varchar(100) not null
);

--Поставки
-- Изменил нейминг
-- Ключ первичный, так как ваш не позволял одному и тому же поставщику поставить один и тот же корм
-- + доп поля
DROP TABLE IF EXISTS zoo.delivery;
CREATE TABLE zoo.delivery
(
 food_id bigint references zoo.food(id),
 provider_id bigint references  zoo.provider(id),
 delivery_date date not null,
 price money NOT null,
 weight numeric(10,2) NOT NULL,
 PRIMARY KEY(food_id, provider_id, delivery_date)
);

--Меню
-- Тут правки по ТЗ + связь с животным
-- Но по идее надо с видом животного и его физ. состоянием
DROP TABLE IF EXISTS zoo.menu;
CREATE TABLE zoo.menu
(
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 animal_specie bigint REFERENCES zoo.specie(specie_id),
 physical_condition varchar(10) NOT NULL, -- тут возможно и таблицу состояний можно сделать
 food_id bigint REFERENCES zoo.food(id),
 season varchar(10) NOT null CHECK (season IN ('all-season','autumn','spring','summer','winter')),
 weight numeric(10,2) NOT NULL
);

--Кормление
-- Поменял ключи, имена
DROP TABLE IF EXISTS zoo.feeding;
CREATE TABLE zoo.feeding
(
 feeding_date timestamp DEFAULT now(),
 menu_id bigint REFERENCES zoo.menu(id),
 animal_id bigint REFERENCES zoo.animal(id),
 PRIMARY KEY(feeding_date, menu_id, animal_id)
);

---------------------------------------- Работники
--Сотрудники
-- Тут оставил пример с секционированием + немного избыточности в плане добавления должности в связанных таблицах
-- Этот пример лучше, чем у пола животного, поэтому тут можно и не переделывать на 1:1
DROP TABLE IF EXISTS zoo.staff;
CREATE TABLE zoo.staff
(
  id bigint,
  surname varchar(100) not null,
  "name" varchar(100) not null,
  patronymic varchar(100),
  gender varchar(1) not null,
  date_of_birth date not null,
  date_of_employment date not null,
  salary money not null,
  post varchar(22) not null CHECK(post IN ('cleaner','trainer','veterinarian','administrative workers','construction repairmen')),
  PRIMARY KEY (id, post)
) PARTITION BY LIST(post);

DROP TABLE IF EXISTS zoo.cleaner;
CREATE TABLE zoo.cleaner PARTITION OF zoo.staff FOR VALUES IN ('cleaner');

DROP TABLE IF EXISTS zoo.trainer;
CREATE TABLE zoo.trainer PARTITION OF zoo.staff FOR VALUES IN ('trainer');

DROP TABLE IF EXISTS zoo.veterinarian;
CREATE TABLE zoo.veterinarian PARTITION OF zoo.staff FOR VALUES IN ('veterinarian');

DROP TABLE IF EXISTS zoo.administration_workers;
CREATE TABLE zoo.administration_workers PARTITION OF zoo.staff FOR VALUES IN ('administrative workers');

DROP TABLE IF EXISTS zoo.construction_repairmen;
CREATE TABLE zoo.construction_repairmen PARTITION OF zoo.staff FOR VALUES IN ('construction repairmen');


--График дрессировок
DROP TABLE IF EXISTS zoo.training_schedule;
CREATE TABLE zoo.training_schedule
(
 staff_id bigint NOT null,
 staff_post varchar(50) NOT NULL,
 animal_id bigint REFERENCES zoo.animal(id),
 training_date timestamp NOT NULL,
 PRIMARY KEY(staff_id, animal_id, training_date),
 FOREIGN KEY(staff_id, staff_post) REFERENCES zoo.staff("id", post)
);

--Уборка вольеров
DROP TABLE IF EXISTS zoo.cleaning_schedule;
CREATE TABLE zoo.cleaning_schedule
(
 staff_id bigint NOT null,
 staff_post varchar(50) NOT NULL,
 aviary_id bigint REFERENCES zoo.aviary(aviary_id),
 cleaning_date timestamp NOT NULL,
 PRIMARY KEY(staff_id, aviary_id, cleaning_date),
 FOREIGN KEY(staff_id, staff_post) REFERENCES zoo.staff("id", post)
);

DROP TABLE IF EXISTS zoo.medical_intervention;
CREATE TABLE zoo.medical_intervention
(
 medical_intervention_id bigint NOT NULL,
 name_of_intervention varchar(50) NOT NULL,
 staff_id bigint NOT NULL,
 staff_post varchar(50) NOT NULL,
 medical_contraindications text NOT NULL,
 PRIMARY KEY(medical_intervention_id,name_of_intervention),
 FOREIGN KEY(staff_id, staff_post) REFERENCES zoo.staff("id", post)
 )PARTITION BY LIST(name_of_intervention);

DROP TABLE IF EXISTS zoo.мedical_examination;
CREATE TABLE zoo.мedical_examination PARTITION OF zoo.medical_intervention FOR VALUES IN ('Medical examination');

DROP TABLE IF EXISTS zoo.treatment;
CREATE TABLE zoo.treatment PARTITION OF zoo.medical_intervention FOR VALUES IN ('Treatment');

DROP TABLE IF EXISTS zoo.vaccination;
CREATE TABLE zoo.vaccination PARTITION OF zoo.medical_intervention FOR VALUES IN ('Vaccination');



--DROP TABLE IF EXISTS zoo.animal;
--СREATE TABLE zoo.animal
--(
-- animal_id bigint NOT NULL,
-- date_of_birth timestamp NOT NULL,
-- animal_id bigint NOT NULL  REFERENCES zoo.animal("id"),
-- PRIMARY KEY(animal_id)
--);


DROP TABLE IF EXISTS zoo.medical_examination_records;
CREATE TABLE zoo.medical_examination_records
(
 medical_intervention_id bigint NOT NULL,
 medical_intervention_name varchar(50) NOT NULL,
 height float NOT NULL,
 weight float NOT NULL,
 condition_of_the_animal text NOT NULL,
 survey_date timestamp NOT NULL DEFAULT now()::date,
 animal bigint NOT NULL,
 FOREIGN KEY(animal) REFERENCES  zoo.animal(id),
  FOREIGN KEY(medical_intervention_id, medical_intervention_name)
	REFERENCES zoo.medical_intervention(medical_intervention_id, name_of_intervention)
);


DROP TABLE IF EXISTS zoo.disease_records;
CREATE TABLE zoo.disease_records
(
 medical_intervention_id bigint NOT NULL,
 medical_intervention_name varchar(50) NOT NULL,
 date_of_onset timestamp NOT NULL,
 condition_of_the_animal text NOT NULL,
 survey_date timestamp NOT NULL DEFAULT now()::date,
 animal bigint NOT NULL,
 hospital bool NOT NULL,
 date_of_recovery timestamp,
 FOREIGN KEY(animal) REFERENCES  zoo.animal(id),
  FOREIGN KEY(medical_intervention_id, medical_intervention_name)
 REFERENCES zoo.medical_intervention(medical_intervention_id, name_of_intervention)
);



DROP TABLE IF EXISTS zoo.vaccination_record;
CREATE TABLE zoo.vaccination_record
(
 medical_intervention_id bigint NOT NULL,
 medical_intervention_name varchar(50) NOT NULL,
 condition_of_the_animal text NOT NULL,
 vaccination_date timestamp NOT NULL DEFAULT now()::date,
 animal bigint NOT NULL,
 reaction_to_vaccination text NOT NULL,
 FOREIGN KEY(animal) REFERENCES  zoo.animal(id),
  FOREIGN KEY(medical_intervention_id, medical_intervention_name)
 REFERENCES zoo.medical_intervention(medical_intervention_id, name_of_intervention)
);

INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (1,'Panthera leo',TRUE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (2,'Elephas maximus',FALSE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (3,'Ailuropoda melanoleuca',FALSE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (4,'Panthera tigris',TRUE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (5,'Crocodylidae',TRUE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (6,'Gorilla',FALSE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (7,'Aquila',TRUE,FALSE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (8,'Macropodidae',FALSE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (9,'Equus zebra',FALSE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (10,'Giraffa camelopardalis',FALSE,TRUE);

INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Bimbo', '2007-11-17'::date, '2010-11-17'::date, TRUE, 'male', 1);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Abigail', '2011-01-17'::date, '2011-01-17'::date, FALSE, 'female', 2);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Biscuit', '2008-03-17'::date, '2011-03-17'::date, TRUE, 'male', 3);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Amelli', '2011-05-17'::date, '2011-05-17'::date, FALSE, 'female', 4);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Chip', '2024-01-23'::date, '2024-02-17'::date, TRUE, 'male', 5);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Breena', '2011-09-17'::date, '2011-09-17'::date, FALSE, 'female', 6);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('April', '2011-11-17'::date, '2011-11-17'::date, TRUE, 'male', 7);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Emma', '2012-01-17'::date, '2012-01-17'::date, FALSE, 'female', 8);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Archie', '2009-03-17'::date, '2012-03-17'::date, TRUE, 'male', 9);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Grace', '2012-05-17'::date, '2012-05-17'::date, FALSE, 'female', 10);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Flower', '2009-07-17'::date, '2012-07-17'::date, TRUE, 'female', 1);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Dingo', '2012-09-17'::date, '2012-09-17'::date, FALSE, 'male', 2);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Mindy', '2009-11-17'::date, '2012-11-17'::date, TRUE, 'female', 3);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Flash', '2013-01-17'::date, '2013-01-17'::date, FALSE, 'male', 4);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Rosie', '2013-03-17'::date, '2013-03-17'::date, TRUE, 'female', 5);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Iron', '2013-05-17'::date, '2013-05-17'::date, FALSE, 'male', 6);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Zoe', '2013-07-17'::date, '2015-05-17'::date, TRUE, 'female', 7);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Jerry', '2013-09-17'::date, '2013-09-17'::date, FALSE, 'male', 8);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Spring', '2013-11-17'::date, '2013-11-17'::date, TRUE, 'female', 9);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Lipton', '2014-01-17'::date, '2014-01-17'::date, FALSE, 'male', 10);
INSERT INTO zoo.animal(name, date_of_birthday, date_of_appearance, maturity, gender, specie_id) VALUES ('Sofa', '2023-11-17'::date, '2023-11-17'::date, FALSE, 'female', 9);


INSERT INTO zoo.aviary(aviary_id, heating) VALUES (1,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (2,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (3,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (4,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (5,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (6,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (7,FALSE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (8,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (9,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (10,TRUE);

INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (1,1,'2010-11-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (2,2,'2011-01-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (3,3,'2011-03-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (4,4,'2011-05-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (5,5,'2011-07-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (6,6,'2011-09-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (7,7,'2011-11-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (8,8,'2012-01-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (9,9,'2012-03-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (10,10,'2012-05-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (11,1,'2012-07-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (12,2,'2012-09-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (13,3,'2012-11-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (14,4,'2013-01-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (15,5,'2013-03-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (16,6,'2013-05-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (17,7,'2013-07-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (18,8,'2013-09-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (19,9,'2013-11-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (20,10,'2014-01-17'::date,null);



INSERT INTO zoo.food_type(id, name) VALUES (1,'Vegetable');
INSERT INTO zoo.food_type(id, name) VALUES (2,'Live food');
INSERT INTO zoo.food_type(id, name) VALUES (3,'Meat');
INSERT INTO zoo.food_type(id, name) VALUES (4,'Compound feed 1');
INSERT INTO zoo.food_type(id, name) VALUES (5,'Compound feed 2');
INSERT INTO zoo.food_type(id, name) VALUES (6,'Compound feed 3');
INSERT INTO zoo.food_type(id, name) VALUES (7,'Compound feed 4');
INSERT INTO zoo.food_type(id, name) VALUES (8,'Compound feed 5');
INSERT INTO zoo.food_type(id, name) VALUES (9,'Compound feed 6');
INSERT INTO zoo.food_type(id, name) VALUES (10,'Compound feed 7');


INSERT INTO zoo.food(id, type_id, name) VALUES(1,1,'Carrot');
INSERT INTO zoo.food(id, type_id, name) VALUES(2,2,'Mice');
INSERT INTO zoo.food(id, type_id, name) VALUES(3,3,'Beef');
INSERT INTO zoo.food(id, type_id, name) VALUES(4,4,'PC 1');
INSERT INTO zoo.food(id, type_id, name) VALUES(5,5,'PC 1-1');
INSERT INTO zoo.food(id, type_id, name) VALUES(6,6,'PCS 1-2');
INSERT INTO zoo.food(id, type_id, name) VALUES(7,7,'PC 2');
INSERT INTO zoo.food(id, type_id, name) VALUES(8,8,'PC 3');
INSERT INTO zoo.food(id, type_id, name) VALUES(9,9,'PC 4');
INSERT INTO zoo.food(id, type_id, name) VALUES(10,10,'PC 5');
INSERT INTO zoo.food(id, type_id, name) VALUES(11,1,'Hay');
INSERT INTO zoo.food(id, type_id, name) VALUES(12,2,'Mealworms');
INSERT INTO zoo.food(id, type_id, name) VALUES(13,3,'Veal');
INSERT INTO zoo.food(id, type_id, name) VALUES(14,4,'PC 6');
INSERT INTO zoo.food(id, type_id, name) VALUES(15,5,'PC 7');
INSERT INTO zoo.food(id, type_id, name) VALUES(16,6,'PC 8');
INSERT INTO zoo.food(id, type_id, name) VALUES(17,7,'PC 10');
INSERT INTO zoo.food(id, type_id, name) VALUES(18,8,'PC 11');
INSERT INTO zoo.food(id, type_id, name) VALUES(19,9,'PC 12');
INSERT INTO zoo.food(id, type_id, name) VALUES(20,10,'PC 13');
INSERT INTO zoo.food(id, type_id, name) VALUES(21,1,'Bamboo');
INSERT INTO zoo.food(id, type_id, name) VALUES(22,2,'Wax worms');
INSERT INTO zoo.food(id, type_id, name) VALUES(23,3,'Pork');
INSERT INTO zoo.food(id, type_id, name) VALUES(24,4,'PC 10-1');
INSERT INTO zoo.food(id, type_id, name) VALUES(25,5,'PC 11-1');
INSERT INTO zoo.food(id, type_id, name) VALUES(26,6,'PC 11-2');
INSERT INTO zoo.food(id, type_id, name) VALUES(27,7,'PC 12-1');
INSERT INTO zoo.food(id, type_id, name) VALUES(28,8,'PC 13-1');
INSERT INTO zoo.food(id, type_id, name) VALUES(29,9,'PC 14');
INSERT INTO zoo.food(id, type_id, name) VALUES(30,10,'PC 20');

INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (1,'ok',1,'all-season',0.15);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (2,'ok',2,'winter',0.25);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (3,'ok',3,'autumn',0.35);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (4,'ok',4,'summer',0.45);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (5,'ok',5,'spring',0.55);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (6,'ill',6,'all-season',0.65);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (7,'ill',7,'winter',0.75);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (8,'ok',8,'autumn',0.85);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (9,'ok',9,'summer',0.95);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (10,'ok',10,'spring',1.05);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (10,'ok',11,'all-season',1.15);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (9,'ok',12,'winter',1.25);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (8,'ill',13,'autumn',1.35);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (7,'ill',14,'summer',1.45);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (6,'ok',15,'spring',1.55);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (5,'ok',16,'all-season',1.65);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (4,'ok',17,'winter',1.75);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (3,'ok',18,'autumn',1.85);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (2,'ok',19,'summer',1.95);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (1,'ill',20,'spring',2.05);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (4,'ill',21,'all-season',2.15);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (3,'ok',22,'winter',2.25);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (2,'ok',23,'autumn',2.35);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (1,'ok',24,'summer',2.45);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (10,'ok',25,'spring',2.55);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (9,'ok',26,'all-season',2.65);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (8,'ill',27,'winter',2.75);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (7,'ill',28,'autumn',2.85);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (6,'ok',29,'summer',2.95);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (5,'ok',30,'spring',3.05);

INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 11:20:11', 1, 1);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 11:40:11', 2, 2);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 12:00:11', 3, 3);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 12:20:11', 4, 4);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 12:40:11', 5, 5);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 13:00:11', 6, 6);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 13:20:11', 7, 7);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 13:40:11', 8, 8);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 14:00:11', 9, 9);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 14:20:11', 10, 10);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 14:40:11', 11, 11);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 15:00:11', 12, 12);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 15:20:11', 13, 13);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 15:40:11', 14, 14);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 16:00:11', 15, 15);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 16:20:11', 16, 16);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 16:40:11', 17, 17);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 17:00:11', 18, 18);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 17:20:11', 19, 19);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 17:40:11', 20, 20);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 18:00:11', 21, 1);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 18:20:11', 22, 2);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 18:40:11', 23, 3);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 19:00:11', 24, 4);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 19:20:11', 25, 5);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 19:40:11', 26, 6);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 20:00:11', 27, 7);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 20:20:11', 28, 8);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 20:40:11', 29, 9);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 21:00:11', 30, 10);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 21:20:11', 1, 11);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 21:40:11', 2, 12);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 22:00:11', 3, 13);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 22:20:11', 4, 14);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 22:40:11', 5, 15);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 23:00:11', 6, 16);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 23:20:11', 7, 17);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 23:40:11', 8, 18);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-23 00:00:11', 9, 19);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-23 00:20:11', 10, 20);


INSERT INTO zoo.provider(id, name) VALUES (1, 'Pet Paradise');
INSERT INTO zoo.provider(id, name) VALUES (2, 'Paws and Claws Emporium');
INSERT INTO zoo.provider(id, name) VALUES (3, 'Furry Friends Haven');
INSERT INTO zoo.provider(id, name) VALUES (4, 'The Critter Corner');
INSERT INTO zoo.provider(id, name) VALUES (5, 'Whiskers & Wags');
INSERT INTO zoo.provider(id, name) VALUES (6, 'Creature Comforts Co.');
INSERT INTO zoo.provider(id, name) VALUES (7, 'The Pet Haven');
INSERT INTO zoo.provider(id, name) VALUES (8, 'Animal Antics Store');
INSERT INTO zoo.provider(id, name) VALUES (9, 'Happy Tails Emporium');
INSERT INTO zoo.provider(id, name) VALUES (10, 'Paw Prints Boutique');
INSERT INTO zoo.provider(id, name) VALUES (11, 'The K9 Kingdom');
INSERT INTO zoo.provider(id, name) VALUES (12, 'The Purrfect Place');
INSERT INTO zoo.provider(id, name) VALUES (13, 'Furball Frenzy');
INSERT INTO zoo.provider(id, name) VALUES (14, 'Feathers & Fins Emporium');
INSERT INTO zoo.provider(id, name) VALUES (15, 'Pet Palooza Store');
INSERT INTO zoo.provider(id, name) VALUES (16, 'Wild Whiskers Shop');
INSERT INTO zoo.provider(id, name) VALUES (17, 'The Pet Nest');
INSERT INTO zoo.provider(id, name) VALUES (18, 'Safari Pets Store');
INSERT INTO zoo.provider(id, name) VALUES (19, 'Wags to Whiskers');
INSERT INTO zoo.provider(id, name) VALUES (20, 'Critter Craze Corner');
INSERT INTO zoo.provider(id, name) VALUES (21, 'The Paw Pad');
INSERT INTO zoo.provider(id, name) VALUES (22, 'Furry Fins Market');
INSERT INTO zoo.provider(id, name) VALUES (23, 'Creature Comfort Co.');
INSERT INTO zoo.provider(id, name) VALUES (24, 'The Loyal Companion');
INSERT INTO zoo.provider(id, name) VALUES (25, 'Happy Hounds Haven');
INSERT INTO zoo.provider(id, name) VALUES (26, 'Purrfect Paws Boutique');
INSERT INTO zoo.provider(id, name) VALUES (27, 'Animal Magic Store');
INSERT INTO zoo.provider(id, name) VALUES (28, 'The Critter Clubhouse');
INSERT INTO zoo.provider(id, name) VALUES (29, 'Whisker Wonderland');
INSERT INTO zoo.provider(id, name) VALUES (30, 'Furry Friends’ Faves');

INSERT INTO zoo.baby(baby_id, father_id, mother_id) VALUES (21,9,19);

INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (1,4);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (2,8);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (3,10);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (4,6);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (5,8);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (6,9);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (7,1);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (8,4);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (9,2);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (10,2);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (9,8);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (10,9);

INSERT INTO zoo.zoo(id, name, country, city) VALUES (1, 'Central Park Zoo', 'United States', 'New York');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (2, 'Toronto Zoo', 'Canada', 'Toronto');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (3, 'London Zoo', 'United Kingdom', 'London');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (4, 'Taronga Zoo', 'Australia', 'Sydney');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (5, 'Berlin Zoological Garden', 'Germany', 'Berlin');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (6, 'Paris Zoological Park', 'France', 'Paris');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (7, 'Ueno Zoo', 'Japan', 'Tokyo');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (8, 'Beijing Zoo', 'China', 'Beijing');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (9, 'Sao Paulo Zoo', 'Brazil', 'Sao Paulo');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (10, 'Sanjay Gandhi National Park', 'India', 'Mumbai');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (11, 'St.Peterburg Zoo', 'Russia', 'St. Petersburg');


INSERT INTO zoo.exchange(animal_id, zoo_id, action, deal_date) VALUES (1,3,'given away','07.02.2024');
INSERT INTO zoo.exchange(animal_id, zoo_id, action, deal_date) VALUES (5,3,'adopted','23.01.2024');

INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (1, 1, '2023-11-17'::date, 5400, 200);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (2, 2, '2024-02-13'::date, 5600, 226);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (3, 3, '2024-01-08'::date, 5800, 252);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (4, 4, '2024-02-16'::date, 6000, 278);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (5, 5, '2023-12-21'::date, 6200, 304);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (6, 6, '2024-01-02'::date, 6400, 330);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (7, 7, '2023-12-17'::date, 6600, 356);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (8, 8, '2023-12-01'::date, 6800, 382);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (9, 9, '2024-02-19'::date, 7000, 408);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (10, 10, '2024-02-12'::date, 7200, 434);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (11, 11, '2023-12-31'::date, 7400, 460);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (12, 12, '2023-12-17'::date, 7600, 486);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (13, 13, '2023-12-23'::date, 7800, 512);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (14, 14, '2024-02-11'::date, 8000, 538);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (15, 15, '2024-02-12'::date, 8200, 564);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (16, 16, '2023-12-12'::date, 8400, 590);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (17, 17, '2024-02-03'::date, 8600, 616);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (18, 18, '2024-01-17'::date, 8800, 642);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (19, 19, '2023-12-03'::date, 9000, 668);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (20, 20, '2024-02-03'::date, 9200, 694);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (21, 21, '2023-12-31'::date, 9400, 720);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (22, 22, '2023-12-15'::date, 9600, 746);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (23, 23, '2024-01-10'::date, 9800, 772);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (24, 24, '2023-12-03'::date, 10000, 798);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (25, 25, '2023-11-26'::date, 10200, 824);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (26, 26, '2024-02-06'::date, 10400, 850);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (27, 27, '2023-12-13'::date, 10600, 876);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (28, 28, '2024-01-06'::date, 10800, 902);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (29, 29, '2024-01-07'::date, 11000, 928);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (30, 30, '2023-12-25'::date, 11200, 954);

INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (1,'Brooks','Jacob','Claire','F','1973-10-05'::date,'2011-03-07'::date,156121,'veterinarian');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (2,'Davis','Alexandra','Anna','F','1966-07-09'::date,'2017-02-21'::date,61095,'cleaner');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (3,'Edwards','Noah','Emily','F','1990-10-18'::date,'2022-06-16'::date,219837,'administrative workers');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (4,'Clark','Julian','Hannah','M','1959-02-11'::date,'2016-02-12'::date,27457,'trainer');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (5,'Davis','Isabella','James','F','1974-09-01'::date,'2012-07-27'::date,149053,'administrative workers');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (6,'Cruz','Amelia','Avery','M','1960-05-18'::date,'2022-03-18'::date,47552,'construction repairmen');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (7,'Clark','Claire','Jacob','F','1987-01-23'::date,'2004-01-16'::date,55446,'construction repairmen');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (8,'Green','Hannah','Natalie','M','1950-08-06'::date,'2013-06-09'::date,92644,'construction repairmen');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (9,'Baker','Hannah','William','M','1966-04-04'::date,'2010-12-17'::date,32918,'cleaner');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (10,'Adams','Chloe','Ava','F','1967-12-11'::date,'2010-08-10'::date,89885,'veterinarian');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (11,'Flores','Lucas','Jason','M','1972-02-21'::date,'2018-08-07'::date,193129,'veterinarian');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (12,'Davis','Anthony','Ryan','F','1973-10-05'::date,'2022-05-28'::date,102276,'construction repairmen');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (13,'Hughes','Matthew','Claire','M','2002-12-09'::date,'2022-06-16'::date,248170,'veterinarian');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (14,'Wilson','Jacob','Christopher','F','1996-01-12'::date,'2017-01-09'::date,38476,'veterinarian');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (15,'Johnson','Anna','Jacob','M','1980-01-29'::date,'2005-02-15'::date,201133,'cleaner');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (16,'Gray','Jack','Elizabeth','F','1975-07-19'::date,'2004-04-12'::date,236232,'veterinarian');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (17,'Jones','Avery','Mia','M','1962-06-03'::date,'2017-10-03'::date,214539,'cleaner');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (18,'Jones','Liam','Claire','F','1986-10-16'::date,'2022-04-05'::date,45853,'administrative workers');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (19,'Clark','Anthony','Daniel','M','1963-04-15'::date,'2005-10-25'::date,176382,'trainer');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (20,'Gonzalez','Julia','Jennifer','M','1987-05-17'::date,'2021-10-21'::date,73515,'administrative workers');

INSERT INTO zoo.training_schedule(staff_id, staff_post, animal_id, training_date) VALUES (4, 'trainer', 11, '2023-10-24'::date);
INSERT INTO zoo.training_schedule(staff_id, staff_post, animal_id, training_date) VALUES (19, 'trainer', 13, '2023-10-19'::date);

INSERT INTO zoo.cleaning_schedule(staff_id, staff_post, aviary_id, cleaning_date) VALUES (2, 'cleaner', 1, '2024-01-07'::date);
INSERT INTO zoo.cleaning_schedule(staff_id, staff_post, aviary_id, cleaning_date) VALUES (9, 'cleaner', 2, '2024-02-08'::date);
INSERT INTO zoo.cleaning_schedule(staff_id, staff_post, aviary_id, cleaning_date) VALUES (15, 'cleaner', 3, '2024-02-10'::date);

INSERT INTO zoo.medical_intervention(medical_intervention_id, name_of_intervention, staff_id, staff_post, medical_contraindications) VALUES (1, 'Medical examination', 1, 'veterinarian', 'If the animal doesn''t move much');
INSERT INTO zoo.medical_intervention(medical_intervention_id, name_of_intervention, staff_id, staff_post, medical_contraindications) VALUES (2, 'Treatment', 11, 'veterinarian', 'None');
INSERT INTO zoo.medical_intervention(medical_intervention_id, name_of_intervention, staff_id, staff_post, medical_contraindications) VALUES (3, 'Vaccination', 13, 'veterinarian', 'None');

INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, animal, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-03-19'::date, 'Sickly look', '2023-03-27'::date, 1, True, '2023-03-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, animal, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-04-19'::date, 'Loss of consciousness', '2023-04-28'::date::date, 2, True, '2023-04-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, animal, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-05-19'::date, 'Sickly look', '2023-05-30'::date, 3, True, '2023-05-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, animal, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-06-19'::date, 'Loss of consciousness', '2023-07-01'::date, 4, True, '2023-06-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, animal, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-07-19'::date, 'Sickly look', '2023-08-02'::date, 5, False, '2023-07-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, animal, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-08-19'::date, 'Loss of consciousness', '2023-09-03'::date, 6, False, '2023-08-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, animal, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-09-19'::date, 'Sickly look', '2023-10-05'::date, 7, False, '2023-09-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, animal, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-10-19'::date, 'Loss of consciousness', '2023-11-06'::date, 8, False, '2023-10-19'::date);

INSERT INTO zoo.vaccination_record(medical_intervention_id, medical_intervention_name, condition_of_the_animal, vaccination_date, animal, reaction_to_vaccination) VALUES(3, 'Vaccination', 'Normal', '2023-01-09'::date, 9, 'Normal');
INSERT INTO zoo.vaccination_record(medical_intervention_id, medical_intervention_name, condition_of_the_animal, vaccination_date, animal, reaction_to_vaccination) VALUES(3, 'Vaccination', 'Normal', '2023-01-10'::date, 10, 'Normal');
INSERT INTO zoo.vaccination_record(medical_intervention_id, medical_intervention_name, condition_of_the_animal, vaccination_date, animal, reaction_to_vaccination) VALUES(3, 'Vaccination', 'Normal', '2023-01-11'::date, 11, 'Rashes');
INSERT INTO zoo.vaccination_record(medical_intervention_id, medical_intervention_name, condition_of_the_animal, vaccination_date, animal, reaction_to_vaccination) VALUES(3, 'Vaccination', 'Normal', '2023-01-12'::date, 12, 'Normal');
INSERT INTO zoo.vaccination_record(medical_intervention_id, medical_intervention_name, condition_of_the_animal, vaccination_date, animal, reaction_to_vaccination) VALUES(3, 'Vaccination', 'Loss of consciousness', '2023-01-13'::date, 13, 'Normal');

INSERT INTO zoo.medical_examination_records(medical_intervention_id, medical_intervention_name, height, weight, condition_of_the_animal, survey_date, animal) VALUES(1, 'Medical examination', 150, 37, 'Normal', '2023-05-17'::date, 20);
INSERT INTO zoo.medical_examination_records(medical_intervention_id, medical_intervention_name, height, weight, condition_of_the_animal, survey_date, animal) VALUES(1, 'Medical examination', 60, 90, 'Normal', '2023-10-14'::date, 21);
INSERT INTO zoo.medical_examination_records(medical_intervention_id, medical_intervention_name, height, weight, condition_of_the_animal, survey_date, animal) VALUES(1, 'Medical examination', 89, 32, 'Rashes', '2023-03-12'::date, 19);
INSERT INTO zoo.medical_examination_records(medical_intervention_id, medical_intervention_name, height, weight, condition_of_the_animal, survey_date, animal) VALUES(1, 'Medical examination', 158, 48, 'Normal', '2023-05-17'::date, 18);
INSERT INTO zoo.medical_examination_records(medical_intervention_id, medical_intervention_name, height, weight, condition_of_the_animal, survey_date, animal) VALUES(1, 'Medical examination', 150, 45.5, 'Normal', '2023-10-14'::date, 17);
INSERT INTO zoo.medical_examination_records(medical_intervention_id, medical_intervention_name, height, weight, condition_of_the_animal, survey_date, animal) VALUES(1, 'Medical examination', 60, 43, 'Normal', '2023-03-12'::date, 16);
глийский язык, поправьте меня если я не прав)
-- Не было FK к Видам животных
-- У ВАС:
--  (SQL Error [42830]: ERROR: there is no unique constraint matching given keys for referenced table "animals")
-- ПРИЧИНА:
-- 	Возникает из-за того, что ограничение внешнего ключа (FK) должно ссылаться на уникальную запись в “родительской” таблице.
-- 	У вас в родительской таблице первичный ключ состоит из id_animal и gender, а ссылаетесь только на id.
-- РЕШЕНИЕ:
-- 	Начиная с postgres версии 12 можно ссылаться на секционированную таблицу.
-- 	Можно добавить в feeding_schedule столбец gender и сделать FK по 2 столбцам.
-- 	Можно также подумать над реализацией разбиения Animals по половому признаку связми 1:1
-- 	Такая проблема будет везде, где вы ссылаетесь на таблицу animals.
DROP TABLE IF EXISTS zoo.animal;
CREATE TABLE zoo.animal
(
    "id" bigint generated ALWAYS AS IDENTITY PRIMARY key,
    "name" varchar(100) not null,
    date_of_appearance date not null,
    maturity bool not null,
    gender varchar(6) NOT NULL CHECK (gender IN ('female', 'male')),
    specie_id bigint not NULL REFERENCES zoo.specie(specie_id)
);

CREATE OR REPLACE FUNCTION zoo.animal_distribution() RETURNS trigger AS
$$
BEGIN
    IF NEW.gender = 'male' THEN
        INSERT INTO zoo.animal_male(id) SELECT NEW.id WHERE NOT EXISTS (SELECT 1 FROM zoo.animal_male WHERE id = NEW.id);
    ELSIF NEW.gender = 'female' THEN
        INSERT INTO zoo.animal_female(id) SELECT NEW.id WHERE NOT EXISTS (SELECT 1 FROM zoo.animal_female WHERE id = NEW.id);
    END IF;
    RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER distribute_animal_gender
AFTER INSERT ON zoo.animal
FOR EACH ROW EXECUTE FUNCTION zoo.animal_distribution();

-- Реализация через 1:1
-- Самцы
DROP TABLE IF EXISTS animals_male;
CREATE TABLE zoo.animal_male (
	id bigint PRIMARY KEY,
	FOREIGN KEY (id) REFERENCES zoo.animal(id)
);

-- Самки
DROP TABLE IF EXISTS animal_female;
CREATE TABLE zoo.animal_female(
	id bigint PRIMARY KEY,
	FOREIGN KEY (id) REFERENCES zoo.animal(id)
);

--Детёныши
-- Тут, по-моему мнению, уникальность определяется самим детёнышом
-- Поэтому не надо сурогатного ключа
-- Поменял название (дело вкуса, вообще есть определенные стандарты)
-- Тут тоже была бы проблема в связи с животными из-за ключа секционирования
DROP TABLE IF EXISTS zoo.baby;
CREATE TABLE zoo.baby
(
-- id_childbirth bigint primary key,
 baby_id bigint PRIMARY KEY references zoo.animal(id),
 father_id bigint references zoo.animal_male(id),
 mother_id bigint references zoo.animal_female(id)
);


-- Соседства\Совместимость
-- id соседства тут не нужно
-- Это М:М связь Вида самой с собой, поэтому ключом является Вид1 Вид2
-- Названия в ед числе
-- Опустим в БД совместимость при расселение по вольерам\клеткам, т.к. на уровне БД тяжело это продумать
-- + Нет карты вольеров и по ТЗ не описано это, но можем дополнить вместе, будет весело
-- Вынесем это в питон(наверное, если успеем)
DROP TABLE IF EXISTS zoo.neighborhood;
CREATE TABLE zoo.neighborhood
(
  spiece_id bigint references zoo.specie(specie_id),
  compatible_spiece bigint references zoo.specie(specie_id),
  PRIMARY KEY(spiece_id, compatible_spiece)
);

---------------------------------------- Клетки\Вольеры
--Вольеры
-- Имя в ед числе
DROP TABLE IF EXISTS zoo.aviary;
CREATE TABLE zoo.aviary
(
  aviary_id bigint primary key,
  heating bool DEFAULT FALSE
);

--Обитатели вольера
-- Убрали совместимость
-- Переименовали аккуратнее
-- Изменили ключ
-- Так как у вас его и не было :)
DROP TABLE IF EXISTS zoo.aviary_inhabitant;
CREATE TABLE zoo.aviary_inhabitant
(
  animal_id bigint REFERENCES zoo.animal(id),
  aviary_id bigint references zoo.aviary(aviary_id),
  start_date date DEFAULT now()::date,
  end_date date DEFAULT NULL,
  PRIMARY KEY(animal_id, aviary_id, start_date)
);


---------------------------------------- Зоопарк + обмен
--Зоопарки
-- Нейминг) Зу-зу
DROP TABLE IF EXISTS zoo.zoo;
CREATE TABLE zoo.zoo
(
 id bigint primary key,
 "name" varchar(100) not null,
 country varchar(30) not null,
 city varchar(30) not null
);

--Обмен
-- Не нашёл таблицы references zoo.change(id_change) not null
-- И зачем оно тут?
DROP TABLE IF EXISTS zoo.exchange;
CREATE TABLE zoo.exchange
(
 exchange_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY key,
 animal_id bigint references zoo.animal(id) not null,
 zoo_id bigint references zoo.zoo(id),
 "action" varchar(10) CHECK ("action" IN ('given away', 'adopted')),
 deal_date date NOT null
);

---------------------------------------- Кормление\Меню\Поставщики\Корм и тд
-- Способы питания
-- Смысл таблицы? Про что это? Я уже забыл
-- Ещё и название странное :)
--DROP TABLE IF EXISTS zoo.methods_of_nutrition;
--CREATE TABLE zoo.methods_of_nutrition
--(
-- id_method bigint primary key,
-- name_method varchar(50) not null
--);

--Тип корма
-- Нейминг
DROP TABLE IF EXISTS zoo.food_type;
CREATE TABLE zoo.food_type
(
 id bigint primary key,
 "name" varchar(50) not null
);

--Корм.
DROP TABLE IF EXISTS zoo.food;
CREATE TABLE zoo.food
(
 id bigint primary key,
 type_id bigint references zoo.food_type(id) not null,
 "name" varchar(50) not null
);

--Поставщики
DROP TABLE IF EXISTS zoo.provider;
CREATE TABLE zoo.provider
(
 id bigint primary key,
 "name" varchar(100) not null
);

--Поставки
-- Изменил нейминг
-- Ключ первичный, так как ваш не позволял одному и тому же поставщику поставить один и тот же корм
-- + доп поля
DROP TABLE IF EXISTS zoo.delivery;
CREATE TABLE zoo.delivery
(
 food_id bigint references zoo.food(id),
 provider_id bigint references  zoo.provider(id),
 delivery_date date not null,
 price money NOT null,
 weight numeric(10,2) NOT NULL,
 PRIMARY KEY(food_id, provider_id, delivery_date)
);

--Меню
-- Тут правки по ТЗ + связь с животным
-- Но по идее надо с видом животного и его физ. состоянием
DROP TABLE IF EXISTS zoo.menu;
CREATE TABLE zoo.menu
(
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 animal_specie bigint REFERENCES zoo.specie(specie_id),
 physical_condition varchar(10) NOT NULL, -- тут возможно и таблицу состояний можно сделать
 food_id bigint REFERENCES zoo.food(id),
 season varchar(10) NOT null CHECK (season IN ('all-season','autumn','spring','summer','winter')),
 weight numeric(10,2) NOT NULL
);

--Кормление
-- Поменял ключи, имена
DROP TABLE IF EXISTS zoo.feeding;
CREATE TABLE zoo.feeding
(
 feeding_date timestamp DEFAULT now(),
 menu_id bigint REFERENCES zoo.menu(id),
 animal_id bigint REFERENCES zoo.animal(id),
 PRIMARY KEY(feeding_date, menu_id, animal_id)
);

---------------------------------------- Работники
--Сотрудники
-- Тут оставил пример с секционированием + немного избыточности в плане добавления должности в связанных таблицах
-- Этот пример лучше, чем у пола животного, поэтому тут можно и не переделывать на 1:1
DROP TABLE IF EXISTS zoo.staff;
CREATE TABLE zoo.staff
(
  id bigint,
  surname varchar(100) not null,
  "name" varchar(100) not null,
  patronymic varchar(100),
  gender varchar(1) not null,
  date_of_birth date not null,
  date_of_employment date not null,
  salary money not null,
  post varchar(22) not null CHECK(post IN ('cleaner','trainer','veterinarian','administrative workers','construction repairmen')),
  PRIMARY KEY (id, post)
) PARTITION BY LIST(post);

DROP TABLE IF EXISTS zoo.cleaner;
CREATE TABLE zoo.cleaner PARTITION OF zoo.staff FOR VALUES IN ('cleaner');

DROP TABLE IF EXISTS zoo.trainer;
CREATE TABLE zoo.trainer PARTITION OF zoo.staff FOR VALUES IN ('trainer');

DROP TABLE IF EXISTS zoo.veterinarian;
CREATE TABLE zoo.veterinarian PARTITION OF zoo.staff FOR VALUES IN ('veterinarian');

DROP TABLE IF EXISTS zoo.administration_workers;
CREATE TABLE zoo.administration_workers PARTITION OF zoo.staff FOR VALUES IN ('administrative workers');

DROP TABLE IF EXISTS zoo.construction_repairmen;
CREATE TABLE zoo.construction_repairmen PARTITION OF zoo.staff FOR VALUES IN ('construction repairmen');


--График дрессировок
DROP TABLE IF EXISTS zoo.training_schedule;
CREATE TABLE zoo.training_schedule
(
 staff_id bigint NOT null,
 staff_post varchar(50) NOT NULL,
 animal_id bigint REFERENCES zoo.animal(id),
 training_date timestamp NOT NULL,
 PRIMARY KEY(staff_id, animal_id, training_date),
 FOREIGN KEY(staff_id, staff_post) REFERENCES zoo.staff("id", post)
);

--Уборка вольеров
DROP TABLE IF EXISTS zoo.cleaning_schedule;
CREATE TABLE zoo.cleaning_schedule
(
 staff_id bigint NOT null,
 staff_post varchar(50) NOT NULL,
 aviary_id bigint REFERENCES zoo.aviary(aviary_id),
 cleaning_date timestamp NOT NULL,
 PRIMARY KEY(staff_id, aviary_id, cleaning_date),
 FOREIGN KEY(staff_id, staff_post) REFERENCES zoo.staff("id", post)
);

DROP TABLE IF EXISTS zoo.medical_intervention;
CREATE TABLE zoo.medical_intervention
(
 medical_intervention_id bigint NOT NULL,
 name_of_intervention varchar(50) NOT NULL,
 staff_id bigint NOT NULL,
 staff_post varchar(50) NOT NULL,
 medical_contraindications text NOT NULL,
 PRIMARY KEY(medical_intervention_id,name_of_intervention),
 FOREIGN KEY(staff_id, staff_post) REFERENCES zoo.staff("id", post)
 )PARTITION BY LIST(name_of_intervention);

DROP TABLE IF EXISTS zoo.мedical_examination;
CREATE TABLE zoo.мedical_examination PARTITION OF zoo.medical_intervention FOR VALUES IN ('Medical examination');

DROP TABLE IF EXISTS zoo.treatment;
CREATE TABLE zoo.treatment PARTITION OF zoo.medical_intervention FOR VALUES IN ('Treatment');

DROP TABLE IF EXISTS zoo.vaccination;
CREATE TABLE zoo.vaccination PARTITION OF zoo.medical_intervention FOR VALUES IN ('Vaccination');



DROP TABLE IF EXISTS zoo.medical_records;
CREATE TABLE zoo.medical_records
(
 medical_records_id bigint NOT NULL,
 date_of_birth timestamp NOT NULL,
 animal_id bigint NOT NULL  REFERENCES zoo.animal("id"),
 PRIMARY KEY(medical_records_id)
);


DROP TABLE IF EXISTS zoo.medical_examination_records;
CREATE TABLE zoo.medical_examination_records
(
 medical_intervention_id bigint NOT NULL,
 medical_intervention_name varchar(50) NOT NULL,
 height float NOT NULL,
 weight float NOT NULL,
 condition_of_the_animal text NOT NULL,
 survey_date timestamp NOT NULL DEFAULT now()::date,
 medical_records bigint NOT NULL,
 FOREIGN KEY(medical_records) REFERENCES  zoo.medical_records(medical_records_id),
  FOREIGN KEY(medical_intervention_id, medical_intervention_name)
	REFERENCES zoo.medical_intervention(medical_intervention_id, name_of_intervention)
);


DROP TABLE IF EXISTS zoo.disease_records;
CREATE TABLE zoo.disease_records
(
 medical_intervention_id bigint NOT NULL,
 medical_intervention_name varchar(50) NOT NULL,
 date_of_onset timestamp NOT NULL,
 condition_of_the_animal text NOT NULL,
 survey_date timestamp NOT NULL DEFAULT now()::date,
 medical_records bigint NOT NULL,
 hospital bool NOT NULL,
 date_of_recovery timestamp,
 FOREIGN KEY(medical_records) REFERENCES  zoo.medical_records(medical_records_id),
  FOREIGN KEY(medical_intervention_id, medical_intervention_name)
 REFERENCES zoo.medical_intervention(medical_intervention_id, name_of_intervention)
);



DROP TABLE IF EXISTS zoo.vaccination_record;
CREATE TABLE zoo.vaccination_record
(
 medical_intervention_id bigint NOT NULL,
 medical_intervention_name varchar(50) NOT NULL,
 condition_of_the_animal text NOT NULL,
 vaccination_date timestamp NOT NULL DEFAULT now()::date,
 medical_records bigint NOT NULL,
 reaction_to_vaccination text NOT NULL,
 FOREIGN KEY(medical_records) REFERENCES  zoo.medical_records(medical_records_id),
  FOREIGN KEY(medical_intervention_id, medical_intervention_name)
 REFERENCES zoo.medical_intervention(medical_intervention_id, name_of_intervention)
);

INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (1,'Panthera leo',TRUE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (2,'Elephas maximus',FALSE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (3,'Ailuropoda melanoleuca',FALSE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (4,'Panthera tigris',TRUE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (5,'Crocodylidae',TRUE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (6,'Gorilla',FALSE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (7,'Aquila',TRUE,FALSE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (8,'Macropodidae',FALSE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (9,'Equus zebra',FALSE,TRUE);
INSERT INTO zoo.specie(specie_id, name, is_predator, warm_aviary) VALUES (10,'Giraffa camelopardalis',FALSE,TRUE);

INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Bimbo','17.11.2010',TRUE,'male',1);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Abigail','17.01.2011',FALSE,'female',2);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Biscuit','17.03.2011',TRUE,'male',3);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Amelli','17.05.2011',FALSE,'female',4);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Chip','17.07.2011',TRUE,'male',5);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Breena','17.09.2011',FALSE,'female',6);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('April','17.11.2011',TRUE,'male',7);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Emma','17.01.2012',FALSE,'female',8);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Archie','17.03.2012',TRUE,'male',9);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Grace','17.05.2012',FALSE,'female',10);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Flower','17.07.2012',TRUE,'female',1);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Dingo','17.09.2012',FALSE,'male',2);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Mindy','17.11.2012',TRUE,'female',3);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Flash','17.01.2013',FALSE,'male',4);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Rosie','17.03.2013',TRUE,'female',5);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Iron','17.05.2013',FALSE,'male',6);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Zoe','17.07.2013',TRUE,'female',7);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Jerry','17.09.2013',FALSE,'male',8);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Spring','17.11.2013',TRUE,'female',9);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Lipton','17.01.2014',FALSE,'male',10);
INSERT INTO zoo.animal(name, date_of_appearance, maturity, gender, specie_id) VALUES ('Sofa','17.11.2023',FALSE,'female',9);

INSERT INTO zoo.aviary(aviary_id, heating) VALUES (1,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (2,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (3,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (4,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (5,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (6,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (7,FALSE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (8,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (9,TRUE);
INSERT INTO zoo.aviary(aviary_id, heating) VALUES (10,TRUE);

INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (1,1,'2010-11-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (2,2,'2011-01-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (3,3,'2011-03-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (4,4,'2011-05-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (5,5,'2011-07-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (6,6,'2011-09-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (7,7,'2011-11-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (8,8,'2012-01-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (9,9,'2012-03-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (10,10,'2012-05-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (11,1,'2012-07-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (12,2,'2012-09-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (13,3,'2012-11-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (14,4,'2013-01-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (15,5,'2013-03-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (16,6,'2013-05-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (17,7,'2013-07-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (18,8,'2013-09-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (19,9,'2013-11-17'::date,null);
INSERT INTO zoo.aviary_inhabitant(animal_id, aviary_id, start_date, end_date) VALUES (20,10,'2014-01-17'::date,null);



INSERT INTO zoo.food_type(id, name) VALUES (1,'Vegetable');
INSERT INTO zoo.food_type(id, name) VALUES (2,'Live food');
INSERT INTO zoo.food_type(id, name) VALUES (3,'Meat');
INSERT INTO zoo.food_type(id, name) VALUES (4,'Compound feed 1');
INSERT INTO zoo.food_type(id, name) VALUES (5,'Compound feed 2');
INSERT INTO zoo.food_type(id, name) VALUES (6,'Compound feed 3');
INSERT INTO zoo.food_type(id, name) VALUES (7,'Compound feed 4');
INSERT INTO zoo.food_type(id, name) VALUES (8,'Compound feed 5');
INSERT INTO zoo.food_type(id, name) VALUES (9,'Compound feed 6');
INSERT INTO zoo.food_type(id, name) VALUES (10,'Compound feed 7');


INSERT INTO zoo.food(id, type_id, name) VALUES(1,1,'Carrot');
INSERT INTO zoo.food(id, type_id, name) VALUES(2,2,'Mice');
INSERT INTO zoo.food(id, type_id, name) VALUES(3,3,'Beef');
INSERT INTO zoo.food(id, type_id, name) VALUES(4,4,'PC 1');
INSERT INTO zoo.food(id, type_id, name) VALUES(5,5,'PC 1-1');
INSERT INTO zoo.food(id, type_id, name) VALUES(6,6,'PCS 1-2');
INSERT INTO zoo.food(id, type_id, name) VALUES(7,7,'PC 2');
INSERT INTO zoo.food(id, type_id, name) VALUES(8,8,'PC 3');
INSERT INTO zoo.food(id, type_id, name) VALUES(9,9,'PC 4');
INSERT INTO zoo.food(id, type_id, name) VALUES(10,10,'PC 5');
INSERT INTO zoo.food(id, type_id, name) VALUES(11,1,'Hay');
INSERT INTO zoo.food(id, type_id, name) VALUES(12,2,'Mealworms');
INSERT INTO zoo.food(id, type_id, name) VALUES(13,3,'Veal');
INSERT INTO zoo.food(id, type_id, name) VALUES(14,4,'PC 6');
INSERT INTO zoo.food(id, type_id, name) VALUES(15,5,'PC 7');
INSERT INTO zoo.food(id, type_id, name) VALUES(16,6,'PC 8');
INSERT INTO zoo.food(id, type_id, name) VALUES(17,7,'PC 10');
INSERT INTO zoo.food(id, type_id, name) VALUES(18,8,'PC 11');
INSERT INTO zoo.food(id, type_id, name) VALUES(19,9,'PC 12');
INSERT INTO zoo.food(id, type_id, name) VALUES(20,10,'PC 13');
INSERT INTO zoo.food(id, type_id, name) VALUES(21,1,'Bamboo');
INSERT INTO zoo.food(id, type_id, name) VALUES(22,2,'Wax worms');
INSERT INTO zoo.food(id, type_id, name) VALUES(23,3,'Pork');
INSERT INTO zoo.food(id, type_id, name) VALUES(24,4,'PC 10-1');
INSERT INTO zoo.food(id, type_id, name) VALUES(25,5,'PC 11-1');
INSERT INTO zoo.food(id, type_id, name) VALUES(26,6,'PC 11-2');
INSERT INTO zoo.food(id, type_id, name) VALUES(27,7,'PC 12-1');
INSERT INTO zoo.food(id, type_id, name) VALUES(28,8,'PC 13-1');
INSERT INTO zoo.food(id, type_id, name) VALUES(29,9,'PC 14');
INSERT INTO zoo.food(id, type_id, name) VALUES(30,10,'PC 20');

INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (1,'ok',1,'all-season',0.15);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (2,'ok',2,'winter',0.25);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (3,'ok',3,'autumn',0.35);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (4,'ok',4,'summer',0.45);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (5,'ok',5,'spring',0.55);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (6,'ill',6,'all-season',0.65);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (7,'ill',7,'winter',0.75);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (8,'ok',8,'autumn',0.85);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (9,'ok',9,'summer',0.95);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (10,'ok',10,'spring',1.05);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (10,'ok',11,'all-season',1.15);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (9,'ok',12,'winter',1.25);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (8,'ill',13,'autumn',1.35);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (7,'ill',14,'summer',1.45);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (6,'ok',15,'spring',1.55);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (5,'ok',16,'all-season',1.65);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (4,'ok',17,'winter',1.75);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (3,'ok',18,'autumn',1.85);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (2,'ok',19,'summer',1.95);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (1,'ill',20,'spring',2.05);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (4,'ill',21,'all-season',2.15);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (3,'ok',22,'winter',2.25);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (2,'ok',23,'autumn',2.35);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (1,'ok',24,'summer',2.45);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (10,'ok',25,'spring',2.55);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (9,'ok',26,'all-season',2.65);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (8,'ill',27,'winter',2.75);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (7,'ill',28,'autumn',2.85);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (6,'ok',29,'summer',2.95);
INSERT INTO zoo.menu(animal_specie, physical_condition, food_id, season, weight) VALUES (5,'ok',30,'spring',3.05);

INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 11:20:11', 1, 1);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 11:40:11', 2, 2);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 12:00:11', 3, 3);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 12:20:11', 4, 4);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 12:40:11', 5, 5);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 13:00:11', 6, 6);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 13:20:11', 7, 7);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 13:40:11', 8, 8);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 14:00:11', 9, 9);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 14:20:11', 10, 10);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 14:40:11', 11, 11);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 15:00:11', 12, 12);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 15:20:11', 13, 13);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 15:40:11', 14, 14);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 16:00:11', 15, 15);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 16:20:11', 16, 16);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 16:40:11', 17, 17);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 17:00:11', 18, 18);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 17:20:11', 19, 19);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 17:40:11', 20, 20);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 18:00:11', 21, 1);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 18:20:11', 22, 2);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 18:40:11', 23, 3);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 19:00:11', 24, 4);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 19:20:11', 25, 5);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 19:40:11', 26, 6);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 20:00:11', 27, 7);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 20:20:11', 28, 8);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 20:40:11', 29, 9);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 21:00:11', 30, 10);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 21:20:11', 1, 11);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 21:40:11', 2, 12);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 22:00:11', 3, 13);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 22:20:11', 4, 14);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 22:40:11', 5, 15);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 23:00:11', 6, 16);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 23:20:11', 7, 17);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-22 23:40:11', 8, 18);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-23 00:00:11', 9, 19);
INSERT INTO zoo.feeding(feeding_date, menu_id, animal_id) VALUES ('2024-02-23 00:20:11', 10, 20);


INSERT INTO zoo.provider(id, name) VALUES (1, 'Pet Paradise');
INSERT INTO zoo.provider(id, name) VALUES (2, 'Paws and Claws Emporium');
INSERT INTO zoo.provider(id, name) VALUES (3, 'Furry Friends Haven');
INSERT INTO zoo.provider(id, name) VALUES (4, 'The Critter Corner');
INSERT INTO zoo.provider(id, name) VALUES (5, 'Whiskers & Wags');
INSERT INTO zoo.provider(id, name) VALUES (6, 'Creature Comforts Co.');
INSERT INTO zoo.provider(id, name) VALUES (7, 'The Pet Haven');
INSERT INTO zoo.provider(id, name) VALUES (8, 'Animal Antics Store');
INSERT INTO zoo.provider(id, name) VALUES (9, 'Happy Tails Emporium');
INSERT INTO zoo.provider(id, name) VALUES (10, 'Paw Prints Boutique');
INSERT INTO zoo.provider(id, name) VALUES (11, 'The K9 Kingdom');
INSERT INTO zoo.provider(id, name) VALUES (12, 'The Purrfect Place');
INSERT INTO zoo.provider(id, name) VALUES (13, 'Furball Frenzy');
INSERT INTO zoo.provider(id, name) VALUES (14, 'Feathers & Fins Emporium');
INSERT INTO zoo.provider(id, name) VALUES (15, 'Pet Palooza Store');
INSERT INTO zoo.provider(id, name) VALUES (16, 'Wild Whiskers Shop');
INSERT INTO zoo.provider(id, name) VALUES (17, 'The Pet Nest');
INSERT INTO zoo.provider(id, name) VALUES (18, 'Safari Pets Store');
INSERT INTO zoo.provider(id, name) VALUES (19, 'Wags to Whiskers');
INSERT INTO zoo.provider(id, name) VALUES (20, 'Critter Craze Corner');
INSERT INTO zoo.provider(id, name) VALUES (21, 'The Paw Pad');
INSERT INTO zoo.provider(id, name) VALUES (22, 'Furry Fins Market');
INSERT INTO zoo.provider(id, name) VALUES (23, 'Creature Comfort Co.');
INSERT INTO zoo.provider(id, name) VALUES (24, 'The Loyal Companion');
INSERT INTO zoo.provider(id, name) VALUES (25, 'Happy Hounds Haven');
INSERT INTO zoo.provider(id, name) VALUES (26, 'Purrfect Paws Boutique');
INSERT INTO zoo.provider(id, name) VALUES (27, 'Animal Magic Store');
INSERT INTO zoo.provider(id, name) VALUES (28, 'The Critter Clubhouse');
INSERT INTO zoo.provider(id, name) VALUES (29, 'Whisker Wonderland');
INSERT INTO zoo.provider(id, name) VALUES (30, 'Furry Friends’ Faves');

INSERT INTO zoo.baby(baby_id, father_id, mother_id) VALUES (21,9,19);

INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (1,4);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (2,8);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (3,10);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (4,6);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (5,8);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (6,9);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (7,1);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (8,4);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (9,2);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (10,2);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (9,8);
INSERT INTO zoo.neighborhood(spiece_id, compatible_spiece) VALUES (10,9);

INSERT INTO zoo.zoo(id, name, country, city) VALUES (1, 'Central Park Zoo', 'United States', 'New York');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (2, 'Toronto Zoo', 'Canada', 'Toronto');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (3, 'London Zoo', 'United Kingdom', 'London');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (4, 'Taronga Zoo', 'Australia', 'Sydney');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (5, 'Berlin Zoological Garden', 'Germany', 'Berlin');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (6, 'Paris Zoological Park', 'France', 'Paris');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (7, 'Ueno Zoo', 'Japan', 'Tokyo');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (8, 'Beijing Zoo', 'China', 'Beijing');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (9, 'Sao Paulo Zoo', 'Brazil', 'Sao Paulo');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (10, 'Sanjay Gandhi National Park', 'India', 'Mumbai');
INSERT INTO zoo.zoo(id, name, country, city) VALUES (11, 'St.Peterburg Zoo', 'Russia', 'St. Petersburg');


INSERT INTO zoo.exchange(animal_id, zoo_id, action, deal_date) VALUES (1,3,'given away','07.02.2024');
INSERT INTO zoo.exchange(animal_id, zoo_id, action, deal_date) VALUES (5,3,'adopted','23.01.2024');

INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (1, 1, '2023-11-17'::date, 5400, 200);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (2, 2, '2024-02-13'::date, 5600, 226);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (3, 3, '2024-01-08'::date, 5800, 252);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (4, 4, '2024-02-16'::date, 6000, 278);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (5, 5, '2023-12-21'::date, 6200, 304);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (6, 6, '2024-01-02'::date, 6400, 330);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (7, 7, '2023-12-17'::date, 6600, 356);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (8, 8, '2023-12-01'::date, 6800, 382);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (9, 9, '2024-02-19'::date, 7000, 408);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (10, 10, '2024-02-12'::date, 7200, 434);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (11, 11, '2023-12-31'::date, 7400, 460);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (12, 12, '2023-12-17'::date, 7600, 486);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (13, 13, '2023-12-23'::date, 7800, 512);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (14, 14, '2024-02-11'::date, 8000, 538);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (15, 15, '2024-02-12'::date, 8200, 564);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (16, 16, '2023-12-12'::date, 8400, 590);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (17, 17, '2024-02-03'::date, 8600, 616);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (18, 18, '2024-01-17'::date, 8800, 642);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (19, 19, '2023-12-03'::date, 9000, 668);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (20, 20, '2024-02-03'::date, 9200, 694);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (21, 21, '2023-12-31'::date, 9400, 720);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (22, 22, '2023-12-15'::date, 9600, 746);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (23, 23, '2024-01-10'::date, 9800, 772);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (24, 24, '2023-12-03'::date, 10000, 798);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (25, 25, '2023-11-26'::date, 10200, 824);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (26, 26, '2024-02-06'::date, 10400, 850);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (27, 27, '2023-12-13'::date, 10600, 876);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (28, 28, '2024-01-06'::date, 10800, 902);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (29, 29, '2024-01-07'::date, 11000, 928);
INSERT INTO zoo.delivery(food_id, provider_id, delivery_date, price, weight) VALUES (30, 30, '2023-12-25'::date, 11200, 954);

INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (1,'Brooks','Jacob','Claire','F','1973-10-05'::date,'2011-03-07'::date,156121,'veterinarian');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (2,'Davis','Alexandra','Anna','F','1966-07-09'::date,'2017-02-21'::date,61095,'cleaner');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (3,'Edwards','Noah','Emily','F','1990-10-18'::date,'2022-06-16'::date,219837,'administrative workers');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (4,'Clark','Julian','Hannah','M','1959-02-11'::date,'2016-02-12'::date,27457,'trainer');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (5,'Davis','Isabella','James','F','1974-09-01'::date,'2012-07-27'::date,149053,'administrative workers');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (6,'Cruz','Amelia','Avery','M','1960-05-18'::date,'2022-03-18'::date,47552,'construction repairmen');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (7,'Clark','Claire','Jacob','F','1987-01-23'::date,'2004-01-16'::date,55446,'construction repairmen');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (8,'Green','Hannah','Natalie','M','1950-08-06'::date,'2013-06-09'::date,92644,'construction repairmen');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (9,'Baker','Hannah','William','M','1966-04-04'::date,'2010-12-17'::date,32918,'cleaner');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (10,'Adams','Chloe','Ava','F','1967-12-11'::date,'2010-08-10'::date,89885,'veterinarian');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (11,'Flores','Lucas','Jason','M','1972-02-21'::date,'2018-08-07'::date,193129,'veterinarian');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (12,'Davis','Anthony','Ryan','F','1973-10-05'::date,'2022-05-28'::date,102276,'construction repairmen');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (13,'Hughes','Matthew','Claire','M','2002-12-09'::date,'2022-06-16'::date,248170,'veterinarian');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (14,'Wilson','Jacob','Christopher','F','1996-01-12'::date,'2017-01-09'::date,38476,'veterinarian');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (15,'Johnson','Anna','Jacob','M','1980-01-29'::date,'2005-02-15'::date,201133,'cleaner');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (16,'Gray','Jack','Elizabeth','F','1975-07-19'::date,'2004-04-12'::date,236232,'veterinarian');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (17,'Jones','Avery','Mia','M','1962-06-03'::date,'2017-10-03'::date,214539,'cleaner');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (18,'Jones','Liam','Claire','F','1986-10-16'::date,'2022-04-05'::date,45853,'administrative workers');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (19,'Clark','Anthony','Daniel','M','1963-04-15'::date,'2005-10-25'::date,176382,'trainer');
INSERT INTO zoo.staff(id,surname,name,patronymic,gender,date_of_birth,date_of_employment,salary,post) VALUES (20,'Gonzalez','Julia','Jennifer','M','1987-05-17'::date,'2021-10-21'::date,73515,'administrative workers');

INSERT INTO zoo.training_schedule(staff_id, staff_post, animal_id, training_date) VALUES (4, 'trainer', 11, '2023-10-24'::date);
INSERT INTO zoo.training_schedule(staff_id, staff_post, animal_id, training_date) VALUES (19, 'trainer', 13, '2023-10-19'::date);

INSERT INTO zoo.cleaning_schedule(staff_id, staff_post, aviary_id, cleaning_date) VALUES (2, 'cleaner', 1, '2024-01-07'::date);
INSERT INTO zoo.cleaning_schedule(staff_id, staff_post, aviary_id, cleaning_date) VALUES (9, 'cleaner', 2, '2024-02-08'::date);
INSERT INTO zoo.cleaning_schedule(staff_id, staff_post, aviary_id, cleaning_date) VALUES (15, 'cleaner', 3, '2024-02-10'::date);

INSERT INTO zoo.medical_intervention(medical_intervention_id, name_of_intervention, staff_id, staff_post, medical_contraindications) VALUES (1, 'Medical examination', 1, 'veterinarian', 'If the animal doesn''t move much');
INSERT INTO zoo.medical_intervention(medical_intervention_id, name_of_intervention, staff_id, staff_post, medical_contraindications) VALUES (2, 'Treatment', 11, 'veterinarian', 'None');
INSERT INTO zoo.medical_intervention(medical_intervention_id, name_of_intervention, staff_id, staff_post, medical_contraindications) VALUES (3, 'Vaccination', 13, 'veterinarian', 'None');

INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (1, '2007-11-17'::date, 1);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (2, '2011-01-17'::date, 2);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (3, '2008-03-17'::date, 3);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (4, '2011-05-17'::date, 4);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (5, '2024-01-23'::date, 5);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (6, '2011-09-17'::date, 6);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (7, '2011-11-17'::date, 7);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (8, '2012-01-17'::date, 8);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (9, '2009-03-17'::date, 9);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (10, '2012-05-17'::date, 10);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (11, '2009-07-17'::date, 11);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (12, '2012-09-17'::date, 12);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (13, '2009-11-17'::date, 13);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (14, '2013-01-17'::date, 14);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (15, '2010-03-17'::date, 15);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (16, '2013-05-17'::date, 16);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (17, '2013-07-17'::date, 17);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (18, '2013-09-17'::date, 18);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (19, '2010-11-17'::date, 19);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (20, '2014-01-17'::date, 20);
INSERT INTO zoo.medical_records(medical_records_id, date_of_birth, animal_id) VALUES (21, '2023-11-17'::date, 21);

INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, medical_records, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-03-19'::date, 'Sickly look', '2023-03-27'::date, 1, True, '2023-03-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, medical_records, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-04-19'::date, 'Loss of consciousness', '2023-04-28'::date::date, 2, True, '2023-04-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, medical_records, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-05-19'::date, 'Sickly look', '2023-05-30'::date, 3, True, '2023-05-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, medical_records, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-06-19'::date, 'Loss of consciousness', '2023-07-01'::date, 4, True, '2023-06-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, medical_records, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-07-19'::date, 'Sickly look', '2023-08-02'::date, 5, False, '2023-07-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, medical_records, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-08-19'::date, 'Loss of consciousness', '2023-09-03'::date, 6, False, '2023-08-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, medical_records, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-09-19'::date, 'Sickly look', '2023-10-05'::date, 7, False, '2023-09-19'::date);
INSERT INTO zoo.disease_records(medical_intervention_id, medical_intervention_name, date_of_onset, condition_of_the_animal, survey_date, medical_records, hospital, date_of_recovery) VALUES (2,'Treatment', '2023-10-19'::date, 'Loss of consciousness', '2023-11-06'::date, 8, False, '2023-10-19'::date);

INSERT INTO zoo.vaccination_record(medical_intervention_id, medical_intervention_name, condition_of_the_animal, vaccination_date, medical_records, reaction_to_vaccination) VALUES(3, 'Vaccination', 'Normal', '2023-01-09'::date, 9, 'Normal');
INSERT INTO zoo.vaccination_record(medical_intervention_id, medical_intervention_name, condition_of_the_animal, vaccination_date, medical_records, reaction_to_vaccination) VALUES(3, 'Vaccination', 'Normal', '2023-01-10'::date, 10, 'Normal');
INSERT INTO zoo.vaccination_record(medical_intervention_id, medical_intervention_name, condition_of_the_animal, vaccination_date, medical_records, reaction_to_vaccination) VALUES(3, 'Vaccination', 'Normal', '2023-01-11'::date, 11, 'Rashes');
INSERT INTO zoo.vaccination_record(medical_intervention_id, medical_intervention_name, condition_of_the_animal, vaccination_date, medical_records, reaction_to_vaccination) VALUES(3, 'Vaccination', 'Normal', '2023-01-12'::date, 12, 'Normal');
INSERT INTO zoo.vaccination_record(medical_intervention_id, medical_intervention_name, condition_of_the_animal, vaccination_date, medical_records, reaction_to_vaccination) VALUES(3, 'Vaccination', 'Loss of consciousness', '2023-01-13'::date, 13, 'Normal');

INSERT INTO zoo.medical_examination_records(medical_intervention_id, medical_intervention_name, height, weight, condition_of_the_animal, survey_date, medical_records) VALUES(1, 'Medical examination', 150, 37, 'Normal', '2023-05-17'::date, 20);
INSERT INTO zoo.medical_examination_records(medical_intervention_id, medical_intervention_name, height, weight, condition_of_the_animal, survey_date, medical_records) VALUES(1, 'Medical examination', 60, 90, 'Normal', '2023-10-14'::date, 21);
INSERT INTO zoo.medical_examination_records(medical_intervention_id, medical_intervention_name, height, weight, condition_of_the_animal, survey_date, medical_records) VALUES(1, 'Medical examination', 89, 32, 'Rashes', '2023-03-12'::date, 19);
INSERT INTO zoo.medical_examination_records(medical_intervention_id, medical_intervention_name, height, weight, condition_of_the_animal, survey_date, medical_records) VALUES(1, 'Medical examination', 158, 48, 'Normal', '2023-05-17'::date, 18);
INSERT INTO zoo.medical_examination_records(medical_intervention_id, medical_intervention_name, height, weight, condition_of_the_animal, survey_date, medical_records) VALUES(1, 'Medical examination', 150, 45.5, 'Normal', '2023-10-14'::date, 17);
INSERT INTO zoo.medical_examination_records(medical_intervention_id, medical_intervention_name, height, weight, condition_of_the_animal, survey_date, medical_records) VALUES(1, 'Medical examination', 60, 43, 'Normal', '2023-03-12'::date, 16);
