
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

declare @id_ligi int =2

:r "D:\studia\sem4\baza danych\proj\zapelnij_limity.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_zaw.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_druzyny.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_poz.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_pomoc.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_mecz.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_wyd.sql"
:r "D:\studia\sem4\baza danych\proj\zapelnij_lige.sql"