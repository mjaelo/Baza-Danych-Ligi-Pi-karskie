--reset tabeli 
delete from Mecz

set @czas  = 1 + ABS(CHECKSUM(NEWID()) % 90)
set @id_m  = 1
set @id_gosc  = 2
set @id_gosp  = 1
set @id_zaw  = 1
set @sezon  = 2010

set @limit_zaw  = (Select [Limit Zawodnikow w Druzynie]from Limity where [ID Ligi]=@id_ligi)	
set @limit_dr  =(Select [Limit Druzyn w Lidze] from Limity where [ID Ligi]=@id_ligi)		
set @limit_lat  =(Select [Limit Lat]  from Limity where [ID Ligi]=@id_ligi)

set @random  = 1 + ABS(CHECKSUM(NEWID()) % 9) --losowa liczba 1-9
set @gol_gosp =1
set @gol_gosc =0



WHILE @sezon <= @limit_lat
BEGIN
	set @id_gosp=1
	set @id_m=1
	while @id_gosp<=@limit_dr
	begin
		set @id_gosc=1
		while @id_gosc<=@limit_dr
		begin
			set @gol_gosp =  ABS(CHECKSUM(NEWID()) % 5)
			set @gol_gosc = ABS(CHECKSUM(NEWID()) % 5)
			if(@id_gosc!=@id_gosp)
			begin
				insert into Mecz values (@id_gosp,@id_gosc, @id_m,@sezon,@gol_gosc,@gol_gosp);
				set @id_m=@id_m+1
			end;
			set @id_gosc= @id_gosc+1
		end;
		set @id_gosp=@id_gosp+1
	end;
	SET @sezon = @sezon + 1
END;
delete from Mecz where Sezon=@limit_lat+1 --bo generuje sie 1 pozycja za duzo

-- trzeb pomieszac id zaw z pozycja itp w latach



--select * from Mecz;


