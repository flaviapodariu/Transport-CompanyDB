--11
--1) Afisati numele, orasul in care s-au angajat toti soferii comapaniei, precum si numele managerului lor.
select initcap(a.nume) as "Nume sofer",a.angajat_id as "ID sofer", initcap(l.oras) as "Oras", initcap(b.nume) as "Nume manager", 
       b.angajat_id as "ID Manager"
from angajati a, locatie l,sofer s, departament d, angajati b
where a.angajat_id = s.angajat_id  -- angajatul sa fie sofer
and a.dept_id = d.dept_id          -- join cu tabela de departament 
and l.locatie_id  = d.locatie_id   -- datorita joinului de sus acum am gasit locatia angajatului
and b.angajat_id = s.manager_id    -- b.angajat_id este managerul si trebuie sa fie acelasi cu managerul soferului
order by 1;

--2) Afisati numele managerilor care au incheiat contracte asociate unor curse de cel putin 250 km in ultima luna.

select nume || ' '|| prenume as "Manager"
from angajati 
where angajat_id in (select m.angajat_id
                     from manager m, contract c, cursa cr
                     where m.angajat_id = c.manager_id  -- angajatul trebuie sa fie cel care incheie contractul
                     and c.contract_id = cr.contract_id -- join cu tabela de cursa ca sa pot gasi nr de km
                     and cr.km >= 250  -- conditia pt nr de km
                     and c.zi_plecare > add_months(sysdate, -1));  -- ziua de plecare sa fie mai mare decat data de acum o luna
                    

--3)  Afisati numele tuturor managerilor care castiga mai mult decat media salariilor cu bonus adaugat. Bonusul consta in
-- cresterea salariului vechi cu un procent echivalent cu comisionul castigat.

with temp1(sal_mng) as (select avg(a1.salariu + (a1.salariu)* NVL(m1.comision, 0))  -- comisionul poate fi null 
                        from angajati a1, manager m1
                        where a1.angajat_id = m1.angajat_id  -- angajatul sa fie manager 
                        )
select distinct initcap(a.nume) ||' '|| initcap(a.prenume) as "Salariat",m.comision,  a.salariu
from angajati a, manager m, sofer s, temp1
where a.angajat_id = m.angajat_id --angajatul sa fie manager
and a.salariu > sal_mng           -- se compara salariul cu  cel calculat mai sus
order by
( case
  when m.comision is null then a.salariu   -- ordonez rezultatele dupa comision daca acesta exista
  else m.comision                           -- altfel ordonez dupa salariul fara bonus
  end
);
                 
 
--4) Afisati informatii despre autovehiculele de 22 de tone care au fost in curse mai lungi de 200km
-- si au consumul mediu mai mic decat media consumurilor medii ale tuturor autovehiculelor de 22 de tone.
                 
with temp(cons_mediu) as (select avg((consum_gol + consum_plin)/2)
                          from autovehicul
                          where capacitate = 22
                         )
select distinct a.nr_inmatriculare, a.utilitate
from autovehicul a, temp
where a.capacitate = 22
and (a.consum_gol+a.consum_plin)/2 <= cons_mediu
and a.nr_inmatriculare in 
    (select p.nr_inmatriculare
     from plecare p, cursa c
     where p.nr_inmatriculare = a.nr_inmatriculare   -- masina selectata sa fie cea din plecarea curenta
     and p.cursa_id = c.cursa_id                     -- joinul cu tabela de curse
     and c.km > 200                                  -- conditia de numar de km
     );
                                           
     
--5)Afisati utilitatea autovehiculelor si numarul de revizii efectuate la fiecare categorie de autovehicul, mai putin 'ADR'.
-- In plus, se va afisa si totalul in lei pentru fiecare tip de autovehicul.

select a.utilitate as "Tip auto", count(revizii_id) as "Numar revizii", decode(sum(cost), 0, 0, sum(cost)) as "Total - lei"
from revizii r, autovehicul a
where a.nr_inmatriculare = r.nr_inmatriculare -- join cu tabela de revizii
group by(a.utilitate)
having lower(a.utilitate) <> 'adr'  -- ignoram masinile cu utilitatea adr
order by count(revizii_id);         -- ordonez crescator dupa numarul reviziilor
       
--12       
----- updates------------- 
update beneficiar
set persoana_contact = 'Radu Marin'
where beneficiar_id = 403;

update locatie
set strada = 'Apusului 7'
where locatie_id = 5;

update sofer
set experienta = 3
where angajat_id = 100;

-- 13
create sequence pk_acc
start with 100
increment by 1
cache 5;
