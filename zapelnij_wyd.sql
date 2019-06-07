--reset tabeli 
delete from Wydarzenia

set @czas  = 1 + ABS(CHECKSUM(NEWID()) % 90)
set @id_m  = 1
set @id_poz  = 1+ABS(CHECKSUM(NEWID()) % 5)
set @id_gosc  = 1
set @id_gosp  = 2
set @id_zaw =1
set @gol  = 0
set @sezon  = 2010

set @limit_zaw  = (Select [Limit Zawodnikow w Druzynie]from Limity)	
set @limit_dr  =(Select [Limit Druzyn w Lidze] from Limity)		
set @limit_lat  =(Select [Limit Lat]  from Limity)

set @random  = 1 + ABS(CHECKSUM(NEWID()) % 9) --losowa liczba 1-9
set @ran2  =1
set @dl_meczu =90

WHILE @sezon <= @limit_lat
BEGIN
	set @id_m=1
	set @dl_meczu=90
	while @id_m<=@limit_dr*@limit_dr-@limit_dr
	begin
		set @id_gosc=(select [ID Goscia] from Mecz
			where [ID Meczu]=@id_m and Sezon=@sezon) 
		set @id_gosp=(select [ID Gospodarza] from Mecz
			where [ID Meczu]=@id_m and Sezon=@sezon) 
		set @dl_meczu=90
		--przedluzenie meczu
		 set @random =1 + ABS(CHECKSUM(NEWID()) % 5);
		 if @random=1
		 begin
			 set @dl_meczu=@dl_meczu+1+ABS(CHECKSUM(NEWID()) % 6)
			 insert into Wydarzenia values (90, 'Dogrywka',@id_m,0 ,0,@sezon)
		 end;

		--wyd gosc
		set @ran2 =1 + ABS(CHECKSUM(NEWID()) % 10)--ilosc wydarzen ktore nie sa gol
		while @ran2>0
		begin
			set @czas = 1 + ABS(CHECKSUM(NEWID()) % @dl_meczu)
			set @id_poz = 1+ABS(CHECKSUM(NEWID()) % @limit_zaw)
			set @id_zaw  =(select [ID Zawodnika] from [Powiazanie Zawodnika z Druzyna] 
			where [ID Druzyny]=@id_gosc and [ID Pozycji]=@id_poz and @sezon=Sezon)

			set @random =1 + ABS(CHECKSUM(NEWID()) % 15);
			if @random=1 
			 insert into Wydarzenia values (@czas, 'Aut',@id_m,@id_zaw ,@id_gosp,@sezon)
			if @random=2 
				insert into Wydarzenia values (@czas, 'Kontuzja',@id_m,@id_zaw ,@id_gosp,@sezon)
			if @random=3 
				insert into Wydarzenia values (@czas, 'Spalony',@id_m,@id_zaw ,@id_gosp,@sezon)
			if @random=4
				insert into Wydarzenia values (@czas, 'Reka',@id_m,@id_zaw ,@id_gosp,@sezon)
			if @random=5
				insert into Wydarzenia values (@czas, 'Faul',@id_m,@id_zaw ,@id_gosp,@sezon)
			if @random=6
				insert into Wydarzenia values (@czas, 'Rozny',@id_m,@id_zaw ,@id_gosp,@sezon)
			set @ran2=@ran2-1
		end;

		set @gol= (select [Wynik Goscia] from Mecz
			where [ID Meczu]=@id_m and Sezon=@sezon) 
		while @gol>0
		begin
			set @czas = 1 + ABS(CHECKSUM(NEWID()) % @dl_meczu)
			set @id_poz = 1+ABS(CHECKSUM(NEWID()) % @limit_zaw)
			set @id_zaw  =(select [ID Zawodnika] from [Powiazanie Zawodnika z Druzyna] 
			where [ID Druzyny]=@id_gosc and [ID Pozycji]=@id_poz and @sezon=Sezon)

			insert into Wydarzenia values (@czas, 'GOL',@id_m,@id_zaw ,@id_gosc,@sezon);
			set @gol=@gol-1
		end;

		--wyd gosp
		set @ran2 =1 + ABS(CHECKSUM(NEWID()) % 10)
		while @ran2>0
		begin
			set @czas = 1 + ABS(CHECKSUM(NEWID()) % @dl_meczu)
			set @id_poz = 1+ABS(CHECKSUM(NEWID()) % @limit_zaw)
			set @id_zaw  =(select [ID Zawodnika] from [Powiazanie Zawodnika z Druzyna] 
			where [ID Druzyny]=@id_gosp and [ID Pozycji]=@id_poz and @sezon=Sezon)

			set @random =1 + ABS(CHECKSUM(NEWID()) % 15);
			if @random=1 
				insert into Wydarzenia values (@czas, 'Aut',@id_m,@id_zaw ,@id_gosp,@sezon)
			if @random=2 
				insert into Wydarzenia values (@czas, 'Kontuzja',@id_m,@id_zaw ,@id_gosp,@sezon)
			if @random=3 
				insert into Wydarzenia values (@czas, 'Spalony',@id_m,@id_zaw ,@id_gosp,@sezon)
			if @random=4
				insert into Wydarzenia values (@czas, 'Reka',@id_m,@id_zaw ,@id_gosp,@sezon)
			if @random=5
				insert into Wydarzenia values (@czas, 'Faul',@id_m,@id_zaw ,@id_gosp,@sezon)
			if @random=6
				insert into Wydarzenia values (@czas, 'Rozny',@id_m,@id_zaw ,@id_gosp,@sezon)
			set @ran2=@ran2-1
		end;
		set @gol= (select [Wynik Gospodarza] from Mecz
			where [ID Meczu]=@id_m and Sezon=@sezon) 
		while @gol>0
		begin
			set @czas = 1 + ABS(CHECKSUM(NEWID()) % @dl_meczu)
			set @id_poz = 1+ABS(CHECKSUM(NEWID()) % @limit_zaw)
			set @id_zaw  =(select [ID Zawodnika] from [Powiazanie Zawodnika z Druzyna] 
			where [ID Druzyny]=@id_gosp and [ID Pozycji]=@id_poz and @sezon=Sezon)

			insert into Wydarzenia values (@czas, 'GOL',@id_m,@id_zaw ,@id_gosc,@sezon);
			set @gol=@gol-1
		end;
		set @id_m= @id_m+1
	end;
	SET @sezon = @sezon + 1
END;
delete from Wydarzenia where Sezon=@limit_lat+1 --bo generuje sie 1 pozycja za duzo


select * from Wydarzenia
order by Sezon,[ID Meczu],[Czas Wydarzenia]
--select Imie,Nazwisko,[Opis Wydarzenia],[ID Meczu] from Wydarzenia w,Zawodnicy z where w.[ID Zawodnika]=z.[ID Zawodnika]
