create table LOCATIE
(
  locatie_id number(4) primary key,
  judet varchar(20) not null,
  oras varchar2(30) not null,
  strada varchar2(50)
);

create table ANGAJATI
(
  angajat_id number(4) primary key, 
  nume varchar2(25),
  prenume varchar2(25), 
  salariu number(5) not null,
  dept_id number(4) not null references DEPARTAMENT(dept_id)
);

create table MANAGER
(
  angajat_id number(4) primary key references ANGAJATI(angajat_id), 
  comision number(2,2)
);

create table CONTRACT
(
  contract_id number(7) primary key, 
  manager_id number(4) not null references MANAGER(angajat_id),
  beneficiar_id number(3) not null references BENEFICIAR(beneficiar_id),
  suma number(8,2) not null, 
  cantitate number(4,2) not null,
  tip_marfa  varchar2(25) not null,
  oras_plecare varchar2(30) not null,
  oras_sosire varchar2(30) not null,
  zi_plecare date, 
  zi_sosire date
);
 
create table BENEFICIAR 
(
  beneficiar_id number(3) primary key,
  denumire varchar2(30) not null,
  persoana_contact varchar2(50) not null,
  telefon number(10) not null
);

create table DEPARTAMENT 
(
  dept_id number(4) primary key,
  locatie_id number(4) references LOCATIE(locatie_id),
  manager_id number(4) references MANAGER(angajat_id)
);

create table SOFER
(
  angajat_id number(4) primary key references ANGAJATI(angajat_id),
  manager_id number(4) references MANAGER(angajat_id),
  experienta number(2)
);



create table AUTOVEHICUL
(
  nr_inmatriculare varchar2(11) not null primary key,
  utilitate varchar2(25) not null,
  capacitate number(4,2) not null,
  consum_gol number(4,2),
  consum_plin number(4,2)
);

create table CURSA
( 
  cursa_id number(7) primary key,
  km number(6,2) not null,
  contract_id number(7) references CONTRACT(contract_id)
);

create table PLECARE
(
   nr_inmatriculare varchar2(11) not null references AUTOVEHICUL(nr_inmatriculare),
   sofer_id number(4) not null references SOFER(angajat_id),
   cursa_id number(7) not null references CURSA(cursa_id),
   cheltuieli number(5) not null,
   primary key(nr_inmatriculare, sofer_id, cursa_id)
);

create table REVIZII
(
  revizii_id number(4) primary key,
  cost number(5,2) not null,
  data_in date not null,
  data_out date not null,
  nr_inmatriculare varchar2(11) not null references AUTOVEHICUL(nr_inmatriculare)
);


create table ACCIDENTE
(
 accident_id number(4) primary key,
 loc varchar2(50),
 zi date not null
);

create table IMPLICARE
(  nr_inmatriculare varchar2(11) references AUTOVEHICUL(nr_inmatriculare),
   accident_id number(4) not null references ACCIDENTE(accident_id),
   primary key(nr_inmatriculare, accident_id)
);


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~INSERARE DATE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-------------------------------------- LOCATIE ------------------------------------------------------------------
insert into LOCATIE 
values (1,'Sector 1', 'Bucuresti','Bd.Pipera 2');

insert into LOCATIE 
values (2,'Sector 2', 'bucuresti','Bd. Ferdinand I 90');

insert into LOCATIE
values(3, 'Brasov', 'Brasov', 'Aleea Privighetorilor 2');

insert into LOCATIE 
values(4, 'Cluj', 'Cluj-Napoca', 'Bd. Nicolae Titulescu 44');

insert into LOCATIE
values(5, 'Constanta', 'Constanta', 'Str. Verde 12');

---------------------------------ANGAJATI + MANAGERI + SOFERI--------------------------------------------
insert into ANGAJATI 
values(100, 'Dumitru', 'Marian', 2500,200);

insert into SOFER
values(100, 103, 2);

insert into ANGAJATI 
values(101, 'Popescu', 'Ion', 3600, 202);

insert into SOFER
values(101, 110, 3);

insert into ANGAJATI 
values(102, 'Chirita', 'Simona', 12000, 201); -- chirita manager pe 201

insert into MANAGER
values(102, null);

insert into ANGAJATI
values(103, 'Podariu', 'Flavia', 12500, 200); -- podariu manager pe 200

insert into MANAGER
values(103, 0.1);

insert into ANGAJATI
values(104, 'Florea', 'Marius', 5000, 201);

insert into SOFER
values(104, 102, 4);

insert into ANGAJATI
values(105, 'Barbu', 'Tudor', 4780, 203);

insert into SOFER
values(105, 108, 4);

insert into ANGAJATI
values(106, 'Stan', 'Alexandru', 3730, 204);

insert into SOFER
values(106, 109, 3);

insert into ANGAJATI
values(107, 'Craciun', 'Andrei', 6100, 202);

insert into SOFER
values(107, 110, 6);

insert into ANGAJATI
values(108, 'Tabacu', 'Andreea', 9720, 203); -- tabacu manager pe 203

insert into MANAGER
values(108, 0.2);

insert into ANGAJATI
values(109, 'Iancu', 'Cristian', 8700, 204); --iancu manager pe 204

insert into MANAGER
values(109, 0.25);

insert into ANGAJATI
values(110, 'Farfurie', 'Gabriela', 10000, 202);  -- farfurie manager pe 202

insert into MANAGER
values(110, 0.1);

insert into ANGAJATI
values(111, 'Muntean', 'Sergiu', 3000, 201);

insert into SOFER
values(111, 102, 2);

insert into ANGAJATI
values(112, 'Pop', 'George',3400, 203);

insert into SOFER
values(112, 108, 3);

-------------------------------------------DEPARTAMENTE--------------------------------------
insert into DEPARTAMENT
values(200, 1, 103);

insert into DEPARTAMENT
values(201, 2, 102);

insert into DEPARTAMENT
values(202, 3, 109);

insert into DEPARTAMENT
values(203, 4, 108);

insert into DEPARTAMENT
values(204, 5, 110);
--------------------------------BENEFICIARI---------------------------------------------------------------
insert into BENEFICIAR
values(400, 'Metro', 'Marius Alexandrescu', '0723123123');

insert into BENEFICIAR
values(401, 'Good Catering', 'Teodora Pop', '0725678987');

insert into BENEFICIAR
values(402, 'IKEA', 'David Panait', '0765445932');

insert into BENEFICIAR
values(403, 'Linde', 'Tania Ardei', '0743778443');

insert into BENEFICIAR
values(404, 'Betty Ice', 'Felicia Dinescu', '0754123432');

insert into BENEFICIAR
values(405, 'Carturesti', 'Vlad Nistor', '0745678123');

------------------------------CONTRACTE-------------------------------------------------------------

insert into CONTRACT
values(300, 109, 404, 'temperatura controlata',20, 4124.98, 'Constanta', 'Bucuresti',to_date('02/03/2021', 'DD/MM/YYYY'), to_date('02/03/2021', 'DD/MM/YYYY'));

insert into CONTRACT
values(301, 103, 403, 'ADR', 14, 3700, 'Bucuresti', 'Constanta', to_date('02/03/2021', 'DD/MM/YYYY'), to_date('02/03/2021', 'DD/MM/YYYY'));

insert into CONTRACT
values(302, 108, 405, 'generala', 3.5, 967.8, 'Cluj-Napoca', 'Pitesti', to_date('23/03/2021', 'DD/MM/YYYY'), to_date('23/03/2021', 'DD/MM/YYYY'));

insert into CONTRACT
values(303, 110, 403, 'adr', 7.5, 1300,'Brasov', 'Craiova', to_date('23/03/2021', 'DD/MM/YYYY'),to_date('23/03/2021', 'DD/MM/YYYY'));

insert into CONTRACT
values(304, 108, 405, 'generala', 22, 6000, 'Cluj-Napoca', 'Ploiesti', to_date('12/04/2021', 'DD/MM/YYYY'), to_date('12/04/2021', 'DD/MM/YYYY'));

insert into CONTRACT
values(305, 102, 401, 'generala', 3.5, 120, 'Bucuresti', 'Brasov', to_date('10/05/2021', 'DD/MM/YYYY'), to_date('10/05/2021', 'DD/MM/YYYY'));

insert into CONTRACT
values(306, 103, 400, 'generala', 22, 4000, 'Bucuresti', 'Suceava',  to_date('10/05/2021', 'DD/MM/YYYY'), to_date('10/05/2021', 'DD/MM/YYYY'));

insert into CONTRACT 
values(307, 108, 401,'generala', 3.5, 300, 'Cluj-Napoca', 'Brasov',  to_date('10/05/2021', 'DD/MM/YYYY'), to_date('10/05/2021', 'DD/MM/YYYY'));

insert into CONTRACT 
values(308, 102, 400,'generala', 22, 3340,'Bucuresti', 'Constanta',  to_date('18/05/2021', 'DD/MM/YYYY'), to_date('18/05/2021', 'DD/MM/YYYY'));

insert into CONTRACT
values(309, 103, 401, 'temperatura controlata', 3.5, 160, 'Bucuresti', 'Targoviste',  to_date('18/05/2021', 'DD/MM/YYYY'), to_date('18/05/2021', 'DD/MM/YYYY'));

insert into CONTRACT
values(310, 103, 400, 'generala', 44, 9000, 'Bucuresti', 'Cluj-Napoca',  to_date('21/05/2021', 'DD/MM/YYYY'), to_date('21/05/2021', 'DD/MM/YYYY'));

-------------------------------AUTOVEHICULE-------------------------------------------------------------------------------------

insert into AUTOVEHICUL
values('B-602-MIS', 'generala', 22, 25, 40);

insert into AUTOVEHICUL
values('B-06-CYN', 'temperatura controlata', 3.5, 9.4, 14.7);

insert into AUTOVEHICUL
values('BV-47-OLF', 'ADR', 7.5, 16.2, 24.9);

insert into AUTOVEHICUL
values('CJ-76-FLM', 'generala', 22, 23.1, 38.5);

insert into AUTOVEHICUL
values('CT-34-JOP', 'temperatura controlata', 22, 26 , 39.9);

insert into AUTOVEHICUL
values('B-134-CVP', 'ADR', 15, 15.6, 26.3);

insert into AUTOVEHICUL
values('CJ-88-SSD', 'generala', 3.5, 8.9, 15.4);

----------------------------------------CURSE-----------------------------------------------------------------------------------

insert into CURSA
values(1000, 224, 300);

insert into CURSA
values(1001, 224, 301);

insert into CURSA
values(1002, 328, 302);

insert into CURSA
values(1003, 257, 303);

insert into CURSA
values(1004, 380, 304);

insert into CURSA
values(1005, 184, 305);

insert into CURSA
values(1006, 440, 306);

insert into CURSA
values(1007, 271, 307);

insert into CURSA
values(1008, 224, 308);

insert into CURSA
values(1009, 79, 309);

insert into CURSA
values(1010, 444, 310);

-------------------------------PLECARE------------------------------------------------------------------------------------------

insert into PLECARE
values('CT-34-JOP', 106, 1000, 304.64);  --consum 34%

insert into PLECARE
values('B-134-CVP' , 111, 1001, 197.12);  --consum 22%

insert into PLECARE
values('CJ-88-SSD', 105, 1002, 131.2); -- consum 10%

insert into PLECARE
values('CJ-88-SSD' , 112, 1002, 131.2);  --echipa din 2 soferi (cluj-pitesti)

insert into PLECARE
values('BV-47-OLF', 107, 1003, 255.97); -- consum 24.9%

insert into PLECARE
values('CJ-76-FLM', 105, 1004, 585.2); -- consum 38.5%

insert into PLECARE
values('CJ-76-FLM', 112, 1004, 585.2); 

insert into PLECARE
values('B-06-CYN', 104, 1005, 108.19); -- consum 0.147 

insert into PLECARE
values('B-602-MIS', 100, 1006, 704); 

insert into PLECARE
values('B-602-MIS', 111, 1006, 704); -- consum 40%

insert into PLECARE
values('CJ-88-SSD', 105, 1007,166.93);  --consum 15.4%  

insert into PLECARE
values('B-602-MIS', 104, 1008, 304.64);  -- consum 0.34 (autostrada => mai scade consumul) 

insert into PLECARE
values('B-06-CYN', 100, 1009, 46.45);   --consum 14.7%

insert into PLECARE
values('B-602-MIS', 100, 1010, 710.4);

insert into PLECARE
values('B-602-MIS', 104, 1010, 710.4);

insert into PLECARE
values('CJ-76-FLM', 105, 1010, 683.76);

insert into PLECARE
values('CJ-76-FLM', 112, 1010, 683.76);



----------------------------------------REVIZII---------------------------------------------------------------------------------

insert into REVIZII
values(500, 120, to_date('10/02/2021', 'DD/MM/YYYY'), to_date('10/02/2021', 'DD/MM/YYYY'),'B-602-MIS');

insert into REVIZII
values(501, 40, to_date('10/02/2021', 'DD/MM/YYYY'), to_date('10/02/2021', 'DD/MM/YYYY'),'B-06-CYN');

insert into REVIZII
values(502, 50, to_date('10/02/2021', 'DD/MM/YYYY'), to_date('10/02/2021', 'DD/MM/YYYY'),'BV-47-OLF');

insert into REVIZII
values(503, 120, to_date('10/02/2021', 'DD/MM/YYYY'), to_date('10/02/2021', 'DD/MM/YYYY'),'CJ-76-FLM');

insert into REVIZII
values(504, 120, to_date('10/02/2021', 'DD/MM/YYYY'), to_date('10/02/2021', 'DD/MM/YYYY'),'CT-34-JOP');

insert into REVIZII
values(505, 120, to_date('10/02/2021', 'DD/MM/YYYY'), to_date('10/02/2021', 'DD/MM/YYYY'),'B-134-CVP');

insert into REVIZII
values(506, 35, to_date('10/02/2021', 'DD/MM/YYYY'), to_date('10/02/2021', 'DD/MM/YYYY'),'CJ-88-SSD');


-----------------------------------------ACCIDENTE------------------------------------------------------------------------------

insert into ACCIDENTE
values(pk_acc.nextval, 'DNCB Mogosoaia', to_date('18/05/2021' ,'DD/MM/YYYY'));

insert into ACCIDENTE
values(pk_acc.nextval, 'DN7 Ramnicu Valcea', to_date('23/03/2021' ,'DD/MM/YYYY'));

insert into ACCIDENTE
values(pk_acc.nextval, 'Calea Turzii OMV', to_date('12/04/2021' ,'DD/MM/YYYY'));

insert into ACCIDENTE
values(pk_acc.nextval, 'Soseaua Mangaliei Constanta', to_date('02/03/2021' ,'DD/MM/YYYY'));

insert into ACCIDENTE
values(pk_acc.nextval, 'E68 Codlea', to_date('10/05/2021' ,'DD/MM/YYYY'));

--------------------------------------------IMPLICARE--------------------------------------------------------------------------

insert into IMPLICARE 
values('B-602-MIS', 100);

insert into IMPLICARE 
values('B-06-CYN', 100);

insert into IMPLICARE 
values('CJ-88-SSD', 101);

insert into IMPLICARE 
values('BV-47-OLF', 101);

insert into IMPLICARE 
values('CJ-76-FLM', 102);

insert into IMPLICARE 
values('B-134-CVP', 103);

insert into IMPLICARE 
values('CT-34-JOP', 103);

insert into IMPLICARE 
values('B-06-CYN', 104);

insert into IMPLICARE 
values('B-602-MIS', 104);

insert into IMPLICARE 
values('CJ-88-SSD', 104);