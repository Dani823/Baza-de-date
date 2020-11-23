# am creat baza de date in mysql cu sintaxa "create database"
CREATE DATABASE Campus_studentesc;

# am creat cele 10 tabele cu sintaxa "create table"
CREATE TABLE UNIVERSITATE(
ID_UNIVERSITATE VARCHAR(20)  PRIMARY KEY NOT NULL, 
NUME_UNIVERSITATE  VARCHAR(100) NOT NULL,
ADRESA_UNIVERSITATE VARCHAR(100) NOT NULL,
TELEFON_UNIVERSITATE varchar(30) NOT NULL
);


CREATE TABLE FACULTATE(
ID_FACULTATE VARCHAR(20) PRIMARY KEY NOT NULL,
NUME_FACULTATE VARCHAR(50) NOT NULL,
ADRESA_FACULTATE VARCHAR(100) NOT NULL,
LOCURI_CAMIN VARCHAR(20) NOT NULL,
ID_UNIVERSITATE VARCHAR(20) NOT NULL
);
#am folosit sintaxa "alter table" pentru a remedia unele greseli aflate pe parcurs, pentru a sterge, adauga sau a face cheie straine pe coloane
ALTER TABLE  facultate 
DROP COLUMN LOCURI_CAMIN;
ALTER TABLE facultate 
ADD CONSTRAINT COD_UNIVERSITATE
  FOREIGN KEY (ID_UNIVERSITATE)
  REFERENCES universitate (ID_UNIVERSITATE);
 
  
  CREATE TABLE camin (
  ID_CAMIN VARCHAR(30) NOT NULL,
  NUME_CAMIN VARCHAR(45) NOT NULL,
  NR_CAMERE VARCHAR(45) NOT NULL,
  ADRESA_CAMIN VARCHAR(100) NOT NULL,
  TELEFON_CAMIN VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID_CAMIN));
  ALTER TABLE camin 
ADD COLUMN COD_ID_UNIVERSITATE VARCHAR(45) NOT NULL AFTER TELEFON_CAMIN
;
ALTER TABLE camin 
ADD CONSTRAINT COD_ID_UNIVERSITATE
  FOREIGN KEY (COD_ID_UNIVERSITATE)
  REFERENCES universitate (ID_UNIVERSITATE);

  
  CREATE TABLE administrator (
  ID_ADMINISTRATOR VARCHAR(20) NOT NULL,
  NUME_ADMINISTRATOR VARCHAR(45) NOT NULL,
  PRENUME_ADMINISTRATOR VARCHAR(45) NOT NULL,
  TELEFON_ADMINISTRATOR VARCHAR(45) NOT NULL,
  SALARIU_ADMINISTRATOR VARCHAR(45) NULL,
  ADRESA_ADMINISTRATOR VARCHAR(45) NULL,
  ID_CAMIN VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID_ADMINISTRATOR));
ALTER TABLE administrator 
ADD CONSTRAINT ID_CAMIN
  FOREIGN KEY (ID_CAMIN)
  REFERENCES camin (ID_CAMIN);
  
  
  CREATE TABLE cantina (
  ID_CANTINA VARCHAR(20) NOT NULL,
  NUME_CANTINA VARCHAR(45) NULL,
  LOCATIE_CANTINA VARCHAR(45) NULL,
  ID_UNIVERSITATE VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID_CANTINA),
  CONSTRAINT ID_UNIVERSITATE
    FOREIGN KEY (ID_UNIVERSITATE)
    REFERENCES universitate (ID_UNIVERSITATE));
    
    
    CREATE TABLE student (
  ID_STUDENT VARCHAR(45) NOT NULL,
  NUME_STUDENT VARCHAR(45) NOT NULL,
  PRENUME_STUDENT VARCHAR(45) NOT NULL,
  VARSTA_STUDENT INT NOT NULL,
  GEN VARCHAR(20) NOT NULL,
  ADRESA_STUDENT VARCHAR(45) NOT NULL,
  NR_TEL_STUDENT INT NOT NULL,
  ID_CANTINA VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID_STUDENT),
  CONSTRAINT ID_CANTINA
    FOREIGN KEY (ID_CANTINA)
    REFERENCES cantina (ID_CANTINA));
    ALTER TABLE student 
ADD COLUMN COD_CAMIN_STUDENT VARCHAR(45) NULL AFTER ID_CANTINA;
ALTER TABLE student 
ADD CONSTRAINT COD_CAMIN_STUDENT
  FOREIGN KEY (COD_CAMIN_STUDENT)
  REFERENCES camin (ID_CAMIN);
  ALTER TABLE student 
ADD COLUMN AN_STUDIU VARCHAR(45) NOT NULL AFTER NR_TEL_STUDENT;
ALTER TABLE student 
ADD COLUMN COD_FACULTATE_STUDENT VARCHAR(45) NOT NULL AFTER ID_CANTINA;
ALTER TABLE student 
ADD CONSTRAINT COD_FACULTATE_STUDENT
  FOREIGN KEY (COD_FACULTATE_STUDENT)
  REFERENCES facultate (ID_FACULTATE);
  ALTER TABLE student
ADD COLUMN NR_STUDENT VARCHAR(45) NOT NULL AFTER COD_CAMIN_STUDENT;



    CREATE TABLE camera (
  ID_CAMERA VARCHAR(45) NOT NULL,
  TIP_CAMERA VARCHAR(45) NOT NULL,
  LOCURI_LIBERE_CAMERA VARCHAR(45) NOT NULL,
  GRUP_SANITAR VARCHAR(45) NOT NULL,
  COD_CAMIN VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID_CAMERA),
  CONSTRAINT COD_CAMIN
    FOREIGN KEY (COD_CAMIN)
    REFERENCES camin (ID_CAMIN));
    ALTER TABLE camera 
CHANGE COLUMN LOCURI_LIBERE_CAMERA LOCURI_LIBERE_CAMERA VARCHAR(45) NULL ;


CREATE TABLE activitati (
  ID_ACTIVITATE VARCHAR(45) NOT NULL,
  DENUMIRE_ACTIVITATE VARCHAR(45) NOT NULL,
  ID_STUDENT VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID_ACTIVITATE),
  CONSTRAINT ID_STUDENT
    FOREIGN KEY (ID_STUDENT)
    REFERENCES student (ID_STUDENT));
    ALTER TABLE activitati 
CHANGE COLUMN DENUMIRE_ACTIVITATE DENUMIRE_ACTIVITATE VARCHAR(45) NULL ;
ALTER TABLE activitati 
CHANGE COLUMN DENUMIRE_ACTIVITATE DENUMIRE_ACTIVITATE VARCHAR(100) NULL DEFAULT NULL ;



CREATE TABLE repartitie (
  FORMA_INVATAMANT VARCHAR(20) NOT NULL,
  COD_UNIVERSITATE_REPARTITIE VARCHAR(45) NOT NULL,
  COD_FACULTATE_REPARTITIE VARCHAR(45) NOT NULL,
  COD_STUDENT_REPARTITIE VARCHAR(45) NOT NULL,
  PRIMARY KEY (FORMA_INVATAMANT),
  CONSTRAINT COD_UNIVERSITATE_REPARTITIE
    FOREIGN KEY (COD_UNIVERSITATE_REPARTITIE)
    REFERENCES universitate (ID_UNIVERSITATE),
  CONSTRAINT COD_FACULTATE_REPARTITIE
    FOREIGN KEY (COD_FACULTATE_REPARTITIE)
    REFERENCES facultate (ID_FACULTATE),
  CONSTRAINT COD_STUDENT_REPARTITIE
    FOREIGN KEY (COD_STUDENT_REPARTITIE)
    REFERENCES student (ID_STUDENT));
    ALTER TABLE repartitie 
DROP FOREIGN KEY COD_UNIVERSITATE_REPARTITIE;
ALTER TABLE repartitie 
DROP COLUMN COD_UNIVERSITATE_REPARTITIE;
ALTER TABLE repartitie 
ADD COLUMN FRECVENTA_INVATAMANT VARCHAR(45) NOT NULL AFTER FORMA_INVATAMANT;
ALTER TABLE repartitie 
DROP FOREIGN KEY COD_FACULTATE_REPARTITIE;
ALTER TABLE repartitie 
DROP COLUMN COD_FACULTATE_REPARTITIE;



  CREATE TABLE locuri_camin (
  NR_LOCURI_CAMIN INT NOT NULL,
  LOCURI_LIBERE VARCHAR(45) NOT NULL,
  COD_UNIVERSITATE_CAMIN VARCHAR(45) NOT NULL,
  COD_FACULTATE_CAMIN VARCHAR(45) NOT NULL,
  COD_LOCURI_CAMIN VARCHAR(45) NOT NULL,
  PRIMARY KEY (NR_LOCURI_CAMIN),
  CONSTRAINT COD_UNIVERSITATE_CAMIN
    FOREIGN KEY (COD_UNIVERSITATE_CAMIN)
    REFERENCES universitate (ID_UNIVERSITATE),
  CONSTRAINT COD_FACULTATE_CAMIN
    FOREIGN KEY (COD_FACULTATE_CAMIN)
    REFERENCES facultate (ID_FACULTATE),
  CONSTRAINT COD_LOCURI_CAMIN
    FOREIGN KEY (COD_LOCURI_CAMIN)
    REFERENCES camin (ID_CAMIN));
    ALTER TABLE locuri_camin 
DROP FOREIGN KEY COD_FACULTATE_CAMIN;
ALTER TABLE locuri_camin 
DROP COLUMN COD_FACULTATE_CAMIN;

#am folosit sintaxa "insert" pentru a introduce datele in tabel pe linii si coloane
INSERT INTO universitate (ID_UNIVERSITATE, NUME_UNIVERSITATE, ADRESA_UNIVERSITATE, TELEFON_UNIVERSITATE) VALUES ('U1', 'UNIVERSITATEA_TEHNICA_CONSTRUCTII', 'BD_LACUL_TEI_NR_15', '0242.131.756');
INSERT INTO universitate (ID_UNIVERSITATE, NUME_UNIVERSITATE, ADRESA_UNIVERSITATE, TELEFON_UNIVERSITATE) VALUES ('U2', 'ACADEMIA_DE_STUDII_ECONOMICE', 'Caderea Bastiliei nr 2-10, sala 0217, sector 1, Bucuresti', '0231.145.574');
INSERT INTO universitate (ID_UNIVERSITATE, NUME_UNIVERSITATE, ADRESA_UNIVERSITATE, TELEFON_UNIVERSITATE) VALUES ('U3', 'UNIVERSITATEA_POLITEHNICA', 'Splaiul Independentei nr 313 Sector 6 Bucuresti Romania', '0245.524.145');
#am folosit comanda update pentru a schimba datele din tabel 
UPDATE universitate SET ADRESA_UNIVERSITATE = 'Splaiul Independentei nr 313 Sector 6 Bucuresti Romania' WHERE (ID_UNIVERSITATE = 'U3');
UPDATE universitate SET NUME_UNIVERSITATE = 'UNIVERSITATEA_TEHNICA_CONSTRUCTII_BUCURESTI' WHERE (ID_UNIVERSITATE = 'U1');



INSERT INTO facultate (ID_FACULTATE, NUME_FACULTATE, ADRESA_FACULTATE, ID_UNIVERSITATE) VALUES ('F1', 'Hidrotehnica', 'Bd Lacul Tei, Nr 3', 'U1');
INSERT INTO facultate (ID_FACULTATE, NUME_FACULTATE, ADRESA_FACULTATE, ID_UNIVERSITATE) VALUES ('F2', 'Bucharest Business School', '2-2A Calea Grivitei Bucharest Romania ', 'U2');
INSERT INTO facultate (ID_FACULTATE, NUME_FACULTATE, ADRESA_FACULTATE, ID_UNIVERSITATE) VALUES ('F3', 'Cibernetica, Statistica si Informatica Economica', 'Cladirea Virgil Madgearu, Calea Dorobanti, 15-17, Sector 1, Bucuresti, 010552', 'U2');
INSERT INTO facultate (ID_FACULTATE, NUME_FACULTATE, ADRESA_FACULTATE, ID_UNIVERSITATE) VALUES ('F4', 'Civile', 'Bd Lacul Tei, Nr 4', 'U1');
INSERT INTO facultate (ID_FACULTATE, NUME_FACULTATE, ADRESA_FACULTATE, ID_UNIVERSITATE) VALUES ('F5', 'Automatica si Calculatoare', 'Splaiul Independentei nr. 313, sector6, Bucuresti, CP 060042', 'U3');
INSERT INTO facultate (ID_FACULTATE, NUME_FACULTATE, ADRESA_FACULTATE, ID_UNIVERSITATE) VALUES ('F6', 'Cai ferate, drumuri, poduri(CFDP)', 'Bd Lacul Tei, Nr 5', 'U1');
INSERT INTO facultate (ID_FACULTATE, NUME_FACULTATE, ADRESA_FACULTATE, ID_UNIVERSITATE) VALUES ('F7', 'Facultatea de Contabilitate si Informatica de Gestiune', 'Str. Caderera Bastiliei nr. 2-10,Sector 1, Bucuresti, cod postal 010374', 'U2');
INSERT INTO facultate (ID_FACULTATE, NUME_FACULTATE, ADRESA_FACULTATE, ID_UNIVERSITATE) VALUES ('F8', 'Facultatea de Economie Teoretica si Aplicata', 'Calea Dorobanti nr. 15-17, sector 1, Bucuresti, cod postal 010552', 'U2');
INSERT INTO facultate (ID_FACULTATE, NUME_FACULTATE, ADRESA_FACULTATE, ID_UNIVERSITATE) VALUES ('F9', 'Facultatea de Inginerie Electrica', 'Splaiul Independentei 313, sector 6, Bucuresti, cod 060042, corp EA 123 ', 'U3');
INSERT INTO facultate (ID_FACULTATE, NUME_FACULTATE, ADRESA_FACULTATE, ID_UNIVERSITATE) VALUES ('F10', 'Facultatea de Energetica', 'Splaiul Independentei 313, sector 6, cod postal 060042, Bucuresti, corp EI 101 ', 'U3');
UPDATE facultate SET NUME_FACULTATE = 'Facultatea de Energetica' WHERE (ID_FACULTATE = 'F10');



INSERT INTO cantina (ID_CANTINA, NUME_CANTINA, LOCATIE_CANTINA, ID_UNIVERSITATE) VALUES ('C1', 'CATINA_STUDENTEASCA_UTCB', 'BD_LACUL_TEI_116_BUCURESTI', 'U1');
INSERT INTO cantina (ID_CANTINA, NUME_CANTINA, LOCATIE_CANTINA, ID_UNIVERSITATE) VALUES ('C2', 'CANTINA_STUDENTEASCA_MOXA', 'MIHAIL_MOXA_3-7', 'U2');
INSERT INTO cantina (ID_CANTINA, NUME_CANTINA, LOCATIE_CANTINA, ID_UNIVERSITATE) VALUES ('C3', 'CANTINA_POLITEHNICA', 'ALEXANDRU_VAIDA-VOIEVOD_TIMISOARA', 'U3');


INSERT INTO camin (ID_CAMIN, NUME_CAMIN, NR_CAMERE, ADRESA_CAMIN, TELEFON_CAMIN, COD_ID_UNIVERSITATE) VALUES ('CA1', 'CAMIN_STUDENTESC_NR2', '400', 'BD_LACUL_TEI_123_BUCURESTI', '0242.514.758', 'U1');
INSERT INTO camin (ID_CAMIN, NUME_CAMIN, NR_CAMERE, ADRESA_CAMIN, TELEFON_CAMIN, COD_ID_UNIVERSITATE) VALUES ('CA2', 'CAMIN_STUDENTESC_NR4', '600', 'STR_INGINERILOR_TEI_NR9', '0341.421.001', 'U1');
INSERT INTO camin (ID_CAMIN, NUME_CAMIN, NR_CAMERE, ADRESA_CAMIN, TELEFON_CAMIN, COD_ID_UNIVERSITATE) VALUES ('CA3', 'CAMIN_STUDENTESC_NR3', '800', 'STR_INGINERILOR_TEI_NR6', '0114.745.002', 'U1');
INSERT INTO camin (ID_CAMIN, NUME_CAMIN, NR_CAMERE, ADRESA_CAMIN, TELEFON_CAMIN, COD_ID_UNIVERSITATE) VALUES ('CA4', 'CAMIN_STUDENTESC_NR7', '50', 'ALEEA_OSTENI_NR24', '0343.197.115', 'U1');
INSERT INTO camin (ID_CAMIN, NUME_CAMIN, NR_CAMERE, ADRESA_CAMIN, TELEFON_CAMIN, COD_ID_UNIVERSITATE) VALUES ('CA5', 'COMPLEXUL_STUDENTESC_REGIE', '1000', 'SPLAIUL_INDEPENDENTEI_280-290', '0242.645.421', 'U3');
INSERT INTO camin (ID_CAMIN, NUME_CAMIN, NR_CAMERE, ADRESA_CAMIN, TELEFON_CAMIN, COD_ID_UNIVERSITATE) VALUES ('CA6', 'CAMIN_BELVEDERE_A2_VECHI', '300', 'STR_INGINER_CRISTIAN_PASCAL_29', '0311.151.224', 'U2');
INSERT INTO camin (ID_CAMIN, NUME_CAMIN, NR_CAMERE, ADRESA_CAMIN, TELEFON_CAMIN, COD_ID_UNIVERSITATE) VALUES ('CA7', 'CAMIN_BELVEDERE_A6', '300', 'STR_CHIBZUINTEI_NR2', '0331.426.995', 'U2');
INSERT INTO camin (ID_CAMIN, NUME_CAMIN, NR_CAMERE, ADRESA_CAMIN, TELEFON_CAMIN, COD_ID_UNIVERSITATE) VALUES ('CA8', 'Noul_Local', '400', 'Splaiul Independentei nr 313, sector 6', '0241.115.112', 'U3');
INSERT INTO camin (ID_CAMIN, NUME_CAMIN, NR_CAMERE, ADRESA_CAMIN, TELEFON_CAMIN, COD_ID_UNIVERSITATE) VALUES ('CA9', 'LEU', '200', 'B-dul Iuliu Maniu 1-3, sector 6', '0241.115.225', 'U3');


INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S1', 'OVIDIU', 'ION', '19', 'M', 'STR_PANSELUTELOR_NR15', '0731258416', '1', 'C1', 'F1', 'CA2');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S2', 'FLORICA', 'VASILICA', '20', 'F', 'STR_SFINTIRII_NR4', '0721456957', '2', 'C1', 'F2', 'CA4');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT) VALUES ('S7', 'IONEL', 'APOSTOL', '22', 'M', 'STR_VIRGIL_IANTU, NR 115', '0732452369', '3', 'C2', 'F7');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT) VALUES ('S11', 'VALERIU', 'FLORIN', '21', 'M', 'STR_SERPENTINELOR, NR 8', '0733621454', '2', 'C3', 'F10');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT) VALUES ('S12', 'EMINESCU', 'MIHAI', '23', 'M', 'STR_RUINE, NR 9', '0733128544', '4', 'C2', 'F8');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S3', 'TULUCA', 'VIORICA', '22', 'F', 'STR_FERICIRII_NR3', '0721563298', '4', 'C2', 'F3', 'CA6');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S4', 'ESPERANSA', 'ESTERA', '21', 'F', 'STR_MATEI-VOIEVOD_NR112', '0741268954', '3', 'C3', 'F5', 'CA5');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S5', 'MARIA', 'ANTOANETA', '20', 'F', 'STR_LACRAMIOAREI, NR 12', '0722512364', '2', 'C3', 'F9', 'CA9');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S6', 'VASILE', 'CALARETU', '18', 'M', 'STR_VISINII, NR 7', '0722658964', '1', 'C3', 'F10', 'CA8');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S8', 'VASILICA', 'IONELA', '23', 'F', 'STR_HEN, NR 2', '0314523667', '4', 'C1', 'F4', 'CA4');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S9', 'ALEXANDRU', 'LAURENTIU', '22', 'M', 'STR_HAIMANA, NR 7', '0754213669', '4', 'C1', 'F6', 'CA4');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S10', 'ANDREI', 'FIOR', '21', 'M', 'STR_NARCISELOR, NR 112', '0242156223', '3', 'C3', 'F5', 'CA5');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S13', 'POPESCU', 'ANA', '24', 'F', 'STR_HOLGATA, NR14', '0722456329', '4', 'C2', 'F8', 'CA7');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S14', 'STANCU', 'RAMONA', '22', 'F', 'STR_CARACATITA, NR 12', '0771597632', '3', 'C3', 'F5', 'CA5');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S15', 'PAVEL', 'ROMEO', '18', 'M', 'STR_PISICII, NR 108', '0745124889', '1', 'C1', 'F6', 'CA3');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S16', 'BADESCU', 'COSMINA', '16', 'F', 'STR_HUNDOR, NR 45', '0725633147', '1', 'C3', 'F10', 'CA8');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S17', 'WALTER', 'SILVIAN', '19', 'M', 'STR_MATLA, NR 23', '0722945678', '2', 'C2', 'F2', 'CA7');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S18', 'ELISABETA', 'CRISTINA', '20', 'F', 'STR_COPACILOR, NR 54', '0733265419', '2', 'C2', 'F3', 'CA6');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S19', 'VERONICA', 'MARTA', '21', 'F', 'STR_NEIGHBOR, NR 33', '0711432007', '3', 'C3', 'F9', 'CA5');
INSERT INTO student (ID_STUDENT, NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU, ID_CANTINA, COD_FACULTATE_STUDENT, COD_CAMIN_STUDENT) VALUES ('S20', 'PETRONEL', 'AUREL', '22', 'M', 'STR_PLOPILOR, NR 12A', '0212365774', '4', 'C2', 'F8', 'CA7');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S1');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S10');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S11');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S12');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S13');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S14');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S15');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S16');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S17');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S18');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S19');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S2');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S20');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S3');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S4');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S5');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S6');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S7');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S8');
UPDATE student SET NR_STUDENT = '1' WHERE (ID_STUDENT = 'S9');




INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('TAXA', 'ZI', 'S1');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('BUGET', 'ZI', 'S2');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('TAXA1', 'FARA FREC', 'S3');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('TAXA2', 'FARA FREC', 'S4');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('BUGET1', 'ZI', 'S5');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('BUGET2', 'ZI', 'S6');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('BUGET3', 'ZI', 'S7');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('TAXA3', 'FARA FREC', 'S8');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('TAXA4', 'FARA FREC', 'S9');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('BUGET4', 'ZI', 'S10');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('TAXA5', 'FARA FREC', 'S11');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('TAXA6', 'FARA FREC', 'S12');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('BUGET5', 'ZI', 'S13');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('TAXA7', 'FARA FREC', 'S14');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('TAXA8', 'ZI', 'S15');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('TAXA9', 'FARA FREC', 'S16');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('TAXA10', 'FARA FREC', 'S17');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('BUGET6', 'ZI', 'S18');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('TAXA11', 'FARA FREC', 'S19');
INSERT INTO repartitie (FORMA_INVATAMANT, FRECVENTA_INVATAMANT, COD_STUDENT_REPARTITIE) VALUES ('BUGET7', 'ZI', 'S20');



INSERT INTO locuri_camin (NR_LOCURI_CAMIN, LOCURI_LIBERE, COD_UNIVERSITATE_CAMIN, COD_LOCURI_CAMIN) VALUES ('121785', '45', 'U1', 'CA1');
INSERT INTO locuri_camin (NR_LOCURI_CAMIN, LOCURI_LIBERE, COD_UNIVERSITATE_CAMIN, COD_LOCURI_CAMIN) VALUES ('100000', '1000', 'U1', 'CA2');
INSERT INTO locuri_camin (NR_LOCURI_CAMIN, LOCURI_LIBERE, COD_UNIVERSITATE_CAMIN, COD_LOCURI_CAMIN) VALUES ('50000', '98', 'U1', 'CA3');
INSERT INTO locuri_camin (NR_LOCURI_CAMIN, LOCURI_LIBERE, COD_UNIVERSITATE_CAMIN, COD_LOCURI_CAMIN) VALUES ('25778', '21', 'U1', 'CA4');
INSERT INTO locuri_camin (NR_LOCURI_CAMIN, LOCURI_LIBERE, COD_UNIVERSITATE_CAMIN, COD_LOCURI_CAMIN) VALUES ('25000', '9', 'U3', 'CA5');
INSERT INTO locuri_camin (NR_LOCURI_CAMIN, LOCURI_LIBERE, COD_UNIVERSITATE_CAMIN, COD_LOCURI_CAMIN) VALUES ('1000', '100', 'U2', 'CA6');
INSERT INTO locuri_camin (NR_LOCURI_CAMIN, LOCURI_LIBERE, COD_UNIVERSITATE_CAMIN, COD_LOCURI_CAMIN) VALUES ('1565', '23', 'U2', 'CA7');
INSERT INTO locuri_camin (NR_LOCURI_CAMIN, LOCURI_LIBERE, COD_UNIVERSITATE_CAMIN, COD_LOCURI_CAMIN) VALUES ('2091', '90', 'U3', 'CA8');
INSERT INTO locuri_camin (NR_LOCURI_CAMIN, LOCURI_LIBERE, COD_UNIVERSITATE_CAMIN, COD_LOCURI_CAMIN) VALUES ('1024', '12', 'U3', 'CA9');


  
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM1', '3 PERS', 'MODUL', 'CA2');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, LOCURI_LIBERE_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM2', '3 PERS', '1', 'MODUL', 'CA2');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM3', '2 PERS', 'ETAJ', 'CA1');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, LOCURI_LIBERE_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM4', '4 PERS', '2', 'ETAJ', 'CA1');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, LOCURI_LIBERE_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM5', '5 PERS', '2', 'ETAJ', 'CA6');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM6', '2 PERS', 'CAMERA', 'CA7');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM7', '1 PERS', 'CAMERA', 'CA3');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, LOCURI_LIBERE_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM8', '5 PERS ', '5', 'MODUL', 'CA9');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM9', '4 PERS', 'CAMERA', 'CA2');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM10', '5 PERS', 'MODUL', 'CA2');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, LOCURI_LIBERE_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM11', '3 PERS', '2', 'CAMERA', 'CA1');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, LOCURI_LIBERE_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM12', '5 PERS', '1', 'CAMERA', 'CA4');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, LOCURI_LIBERE_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM13', '4 PERS', '4', 'MODUL', 'CA4');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, LOCURI_LIBERE_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM14', '3 PERS', '1', 'CAMERA', 'CA7');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM15', '3 PERS', 'ETAJ', 'CA8');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM16', '3 PERS', 'CAMERA', 'CA9');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM17', '4 PERS', 'CAMERA', 'CA9');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM18', '3 PERS', 'CAMERA', 'CA6');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, LOCURI_LIBERE_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM19', '4 PERS', '2', 'ETAJ', 'CA6');
INSERT INTO camera (ID_CAMERA, TIP_CAMERA, LOCURI_LIBERE_CAMERA, GRUP_SANITAR, COD_CAMIN) VALUES ('CAM20', '4 PERS', '3', 'CAMERA', 'CA4');


INSERT INTO administrator (ID_ADMINISTRATOR, NUME_ADMINISTRATOR, PRENUME_ADMINISTRATOR, TELEFON_ADMINISTRATOR, SALARIU_ADMINISTRATOR, ADRESA_ADMINISTRATOR, ID_CAMIN) VALUES ('A1', 'OVIDIU', 'ION', '0732569854', '3200 LEI', 'STR_LACRAMIOAREI, NR 115', 'CA1');
INSERT INTO administrator (ID_ADMINISTRATOR, NUME_ADMINISTRATOR, PRENUME_ADMINISTRATOR, TELEFON_ADMINISTRATOR, ID_CAMIN) VALUES ('A2', 'ANTONELA', 'FLORENTINA', '0242513664', 'CA2');
INSERT INTO administrator (ID_ADMINISTRATOR, NUME_ADMINISTRATOR, PRENUME_ADMINISTRATOR, TELEFON_ADMINISTRATOR, SALARIU_ADMINISTRATOR, ADRESA_ADMINISTRATOR, ID_CAMIN) VALUES ('A3', 'MARIN', 'ALEXANDRA', '0731456228', '2500 LEI', 'STR_INIMIOAREI, NR 122', 'CA3');
INSERT INTO administrator (ID_ADMINISTRATOR, NUME_ADMINISTRATOR, PRENUME_ADMINISTRATOR, TELEFON_ADMINISTRATOR, ID_CAMIN) VALUES ('A4', 'LAURENTIU', 'SERBAN', '0722451754', 'CA4');
INSERT INTO administrator (ID_ADMINISTRATOR, NUME_ADMINISTRATOR, PRENUME_ADMINISTRATOR, TELEFON_ADMINISTRATOR, ID_CAMIN) VALUES ('A5', 'VLAICU', 'AUREL', '0785996542', 'CA5');
INSERT INTO administrator (ID_ADMINISTRATOR, NUME_ADMINISTRATOR, PRENUME_ADMINISTRATOR, TELEFON_ADMINISTRATOR, SALARIU_ADMINISTRATOR, ID_CAMIN) VALUES ('A6', 'GABES', 'RAMONA', '0755147856', '3400 LEI', 'CA6');
INSERT INTO administrator (ID_ADMINISTRATOR, NUME_ADMINISTRATOR, PRENUME_ADMINISTRATOR, TELEFON_ADMINISTRATOR, ID_CAMIN) VALUES ('A7', 'ZEINA', 'ROXANA', '0725463197', 'CA7');
INSERT INTO administrator (ID_ADMINISTRATOR, NUME_ADMINISTRATOR, PRENUME_ADMINISTRATOR, TELEFON_ADMINISTRATOR, ID_CAMIN) VALUES ('A8', 'RADA', 'ALEXANDRU', '0726359874', 'CA8');
INSERT INTO administrator (ID_ADMINISTRATOR, NUME_ADMINISTRATOR, PRENUME_ADMINISTRATOR, TELEFON_ADMINISTRATOR, SALARIU_ADMINISTRATOR, ID_CAMIN) VALUES ('A9', 'DUMITRACHE', 'DANIEL', '0714369587', '5000 LEI', 'CA9');


INSERT INTO activitati (ID_ACTIVITATE, ID_STUDENT) VALUES ('AC1', 'S1');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC2', 'PLIMBAT IN PARC', 'S2');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC3', 'CINEMA, PLIMBAT IN PARC', 'S3');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC4', 'CINEMA', 'S4');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC5', 'TENIS DE MASA', 'S5');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC6', 'TENIS DE CAMP', 'S6');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC7', 'FOTBAL', 'S7');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC8', 'FOTBAL', 'S8');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC9', 'BASCHET', 'S9');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC10', 'TENIS DE MASA', 'S10');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC11', 'HOCHEI', 'S11');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC12', 'FITNES', 'S12');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC13', 'FITNES', 'S13');
INSERT INTO activitati (ID_ACTIVITATE, ID_STUDENT) VALUES ('AC14', 'S14');
INSERT INTO activitati (ID_ACTIVITATE, ID_STUDENT) VALUES ('AC15', 'S15');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC16', 'HOCHEI', 'S16');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC17', 'FOTBAL, BASCHET', 'S17');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC18', 'PLIMBARE IN PARC, FOTBAL, HOCHEI, BASCHET', 'S18');
INSERT INTO activitati (ID_ACTIVITATE, DENUMIRE_ACTIVITATE, ID_STUDENT) VALUES ('AC19', 'GIMNASTICA AEROBICA', 'S19');
INSERT INTO activitati (ID_ACTIVITATE, ID_STUDENT) VALUES ('AC20', 'S20');

#am creat cele 10 selecturi pentru a vizualiza datele din fiecare tabel
select * from universitate;
select * from facultate;
select * from student;
select * from repartitie;
select * from activitati;
select * from administrator;
select * from camera;
select * from camin;
select * from cantina;
select * from locuri_camin;

select NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, ADRESA_STUDENT, NR_TEL_STUDENT, AN_STUDIU
from student
order by nume_student, PRENUME_STUDENT desc;

select NUME_STUDENT,PRENUME_STUDENT
from student
where NUME_STUDENT like 'V%';

select NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, GEN, AN_STUDIU, NR_TEL_STUDENT, ADRESA_STUDENT
from student
where VARSTA_STUDENT >='18';

#am creat un select pentru a vizualiza legatura dintre studentii respectivi cu facultatile la care sunt inscrisi
select NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT as REUN
from student 
union 
select NUME_FACULTATE
from facultate;


select count(NUME_STUDENT) from student;
select count(NUME_FACULTATE) from facultate;
select count(NUME_UNIVERSITATE) from universitate;
select count(NUME_ADMINISTRATOR) from administrator;
select count(NUME_CANTINA) from cantina;
select count(NUME_CAMIN) from camin;
select count(LOCURI_LIBERE_CAMERA) from camera where LOCURI_LIBERE_CAMERA >0;


select TIP_CAMERA,GRUP_SANITAR, LOCURI_LIBERE_CAMERA from camera
where TIP_CAMERA  between '1 PERS' and '3 PERS' and LOCURI_LIBERE_CAMERA>0;


  select 'Studentul '|| A.NUME_STUDENT || ' este inscris in facultatea ' || D.NUME_FACULTATE || 'din universitatea ' || B.NUME_UNIVERSITATE || ' '
 as text from facultate D, student A, universitate B 
where A.COD_FACULTATE_STUDENT = D.ID_FACULTATE   and B.ID_UNIVERSITATE = D.ID_UNIVERSITATE;

SELECT NUME_STUDENT, PRENUME_STUDENT, VARSTA_STUDENT, AN_STUDIU,  NUME_CAMIN
FROM STUDENT, CAMIN
WHERE COD_CAMIN_STUDENT = ID_CAMIN;

SELECT NUME_STUDENT, PRENUME_STUDENT, GEN,VARSTA_STUDENT, AN_STUDIU, NUME_FACULTATE,NUME_UNIVERSITATE, ADRESA_UNIVERSITATE
FROM STUDENT, UNIVERSITATE C, FACULTATE D
WHERE COD_FACULTATE_STUDENT = ID_FACULTATE AND D.ID_UNIVERSITATE = C.ID_UNIVERSITATE
HAVING AN_STUDIU >2 ORDER BY AN_STUDIU DESC;



select 'Administratorul '|| A.NUME_ADMINISTRATOR || 'este repartizat in caminul ' || B.NUME_CAMIN ||  ' '
 as text from administrator A, camin B
where A.ID_CAMIN = B.ID_CAMIN ;

select sum(NR_STUDENT) as number
from student;

select NUME_ADMINISTRATOR,PRENUME_ADMINISTRATOR,NUME_CAMIN,SALARIU_ADMINISTRATOR, SALARIU_ADMINISTRATOR*0.16
from administrator D,camin B
WHERE D.ID_CAMIN=B.ID_CAMIN AND SALARIU_ADMINISTRATOR>0;

SELECT NUME_STUDENT, NUME_FACULTATE
FROM student p
JOIN facultate b
ON p.COD_FACULTATE_STUDENT=b.ID_FACULTATE;


select NUME_STUDENT,PRENUME_STUDENT,NUME_FACULTATE  from student,facultate  where NUME_FACULTATE in ('Civile');
select NUME_STUDENT,PRENUME_STUDENT,NUME_FACULTATE,NUME_UNIVERSITATE  from student p,facultate b,universitate c  where b.NUME_FACULTATE in ('Automatica si calculatoare') and p.COD_FACULTATE_STUDENT=b.ID_FACULTATE and b.ID_UNIVERSITATE=c.ID_UNIVERSITATE;

select NUME_STUDENT, NUME_ADMINISTRATOR
from student, administrator
where NUME_STUDENT like 'a%' and NUME_ADMINISTRATOR like 'a%';

create view ORDSTUDENT as
select NUME_STUDENT,PRENUME_STUDENT,AN_STUDIU from student
where AN_STUDIU > '2';

create view ORDCAMIN as
select NUME_CAMIN, NR_CAMERE,TELEFON_CAMIN from camin
where NR_CAMERE between 300 AND 1000;

create view ORDACTIV as
select NUME_STUDENT, PRENUME_STUDENT,AN_STUDIU,DENUMIRE_ACTIVITATE from student B,activitati A
where A.ID_STUDENT=B.ID_STUDENT AND DENUMIRE_ACTIVITATE LIKE 'FOTBAL';

SELECT NUME_STUDENT,PRENUME_STUDENT,NUME_FACULTATE
FROM student A CROSS JOIN facultate B WHERE A.COD_FACULTATE_STUDENT=B.ID_FACULTATE;

select a.NUME_STUDENT,a.PRENUME_STUDENT,
a.VARSTA_STUDENT,a.ADRESA_STUDENT,b.NUME_UNIVERSITATE,b.ADRESA_UNIVERSITATE
from student a cross join universitate b,facultate c WHERE c.ID_UNIVERSITATE=b.ID_UNIVERSITATE AND a.COD_FACULTATE_STUDENT=c.ID_FACULTATE ;

select * from repartitie
 inner join student on repartitie.cod_student_repartitie=student.id_student;

select * from repartitie
 inner join student on repartitie.cod_student_repartitie=student.id_student where FRECVENTA_INVATAMANT='zi' order by NUME_STUDENT asc;

 
 select * from repartitie
 inner join student on repartitie.cod_student_repartitie=student.id_student where FORMA_INVATAMANT like 'taxa%' order by NUME_STUDENT;

CREATE index studentt
on student(NUME_STUDENT,PRENUME_STUDENT);
ALTER TABLE student 
DROP INDEX studentt;

CREATE index studentt
on student(NUME_STUDENT,PRENUME_STUDENT,ADRESA_STUDENT);

CREATE INDEX UNIVERSITATE_ADRESA
ON universitate(NUME_UNIVERSITATE, ADRESA_UNIVERSITATE);

CREATE synonym ST for student;
CREATE synonym FC for facultate;
CREATE synonym l_c for locuri_camin;
CREATE synonym cam for camera;
CREATE synonym ca for camin;
CREATE synonym 'admin' for administrator;
CREATE synonym ut for universitate;
CREATE synonym rep for repartitie;