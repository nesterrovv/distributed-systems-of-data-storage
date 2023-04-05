CREATE TABLE квартал
(
    id       SERIAL PRIMARY KEY,
    название TEXT NOT NULL
);

CREATE TABLE квартал_квартал
(
    id          SERIAL PRIMARY KEY,
    квартал1_id INTEGER REFERENCES квартал ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
    квартал2_id INTEGER REFERENCES квартал ON DELETE CASCADE ON UPDATE CASCADE NOT NULL check (квартал2_id != квартал1_id)
);

--Улицы
CREATE TABLE улица
(
    id         SERIAL PRIMARY KEY,
    имя        TEXT                                                           NOT NULL,
    квартал_ID INTEGER REFERENCES квартал ON DELETE CASCADE ON UPDATE CASCADE NOT NULL
);
