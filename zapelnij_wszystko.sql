create database Liga
go
use Liga
go
create table Liga.dbo.Druzyny
(
[Nazwa Druzyny] ntext,
[Miasto] ntext,
[ID Druzyny] int
);

create table Liga.dbo.Limity
(
[Rok Pierwszy] int,
[Limit Lat] int,
[Limit Zawodnikow w Druzynie] int,
[Limit Druzyn w Lidze] int,
[ID Ligi] int,
[Nazwa Ligi] ntext
);

create table Liga.dbo.Mecz
(
[ID Gospodarza] int,
[ID Goscia] int,
[ID Meczu] int,
[Wynik Gospodarza] int,
[Wynik Goscia] int,
[Sezon] int,
);

create table Liga.dbo.Pozycja
(
[ID Pozycji] int,
[Nazwa Pozycji] ntext
);

create table Liga.dbo.[Powiazanie Zawodnika z Druzyna]
(
[ID Zawodnika] int,
[ID Pozycji] int,
[ID Druzyny] int,
[Sezon] int
);

create table Liga.dbo.[Ranking Druzyn]
(
[ID Druzyny] int,
[Wygrane Mecze] int,
[Sezon] int,
);

create table Liga.dbo.[Ranking Pilkarzy]
(
[ID Zawodnika] int,
[Strzelone Gole] int,
[Sezon] int,
);

create table Liga.dbo.Wydarzenia
(
[Czas Wydarzenia] int,
[Opis Wydarzenia] ntext,
[ID Meczu] int,
[ID Zawodnika] int,
[ID Druzyny] int,
[Sezon] int,
);

create table Liga.dbo.Zawodnicy
(
[Imie] ntext,
[Nazwisko] ntext,
[ID Zawodnika] int
);


declare @czas int = 0
declare @id_m int = 1
declare @id_poz int = 0
declare @id_gosc int = 1
declare @id_gosp int = 2
declare @id_zaw int=1
declare @gol int = 0
declare @id_dr int=0
declare @sezon int = 0

declare @limit_zaw int = 0
declare @limit_dr int =0
declare @limit_lat int =0

declare @random int = 0
declare @ran2 int =1
declare @dl_meczu int=90

declare @poz int =1
declare @rid int = 0
declare @dru int=0

declare @gol_gosp int=1
declare @gol_gosc int=0

declare @max_z int=0
declare @max_d int=0
declare @max_id int=0
declare @temp int=0

declare @id_ligi int =1
declare @rok_pierwszy int =(Select [Rok Pierwszy]from Limity where [ID Ligi]=@id_ligi)	

:r "D:\studia\sem4\baza danych\proj\zapelnij_limity.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_zaw.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_druzyny.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_poz.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_pomoc.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_mecz.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_wyd.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_rank_dr.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_rank_zaw.sql"

/*
select * from Limity
select * from Druzyny
select * from Zawodnicy
select * from Pozycja
select * from [Powiazanie Zawodnika z Druzyna]
where [ID Druzyny]!=0
order by [Sezon]
select * from Mecz;
select * from Wydarzenia
order by Sezon,[ID Meczu],[Czas Wydarzenia]
select * from [Ranking Pilkarzy]
order by Sezon,[Strzelone Gole]
select * from [Ranking Druzyn]
order by sezon, [Wygrane Mecze Druzyny]*/


--przydatne komendy
/*
select Imiê,Nazwisko,[Nazwa Pozycji],[Nazwa Druzyny],id.Sezon
from [Powiazanie Zawodnika z Druzyna] id,Zawodnicy z, Druzyny d,Pozycja p
where z.[ID Zawodnika]=id.[ID Zawodnika] 
and d.[ID Druzyny]=id.[ID Druzyny]
and p.[ID Pozycji]=id.[ID Pozycji]
order by id.sezon
*/

/*
select Imie,Nazwisko,[Opis Wydarzenia],[Czas Wydarzenia],[Nazwa Druzyny]
from Wydarzenia w,Zawodnicy z,Druzyny d
where w.[ID Zawodnika]=z.[ID Zawodnika] and d.[ID Druzyny]=w.[ID Druzyny]
*/

/*
select [ID Meczu],Miasto,[Wynik Gospodarza],[Wynik Goscia],Sezon,[Nazwa Ligi] from Mecz m ,Druzyny d,Limity l
where d.[ID Druzyny]=m.[ID Gospodarza] and m.Sezon=2010 and l.[ID Ligi] =@id_ligi
*/

/*
select [Nazwa Ligi] from Limity
where [ID Ligi]=@id_ligi
*/


