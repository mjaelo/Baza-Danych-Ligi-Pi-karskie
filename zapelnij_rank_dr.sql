--reset tabeli 
delete from [Ranking Druzyn]

set @id_dr  = ABS(CHECKSUM(NEWID()) % 5)
set @sezon  = (Select [Rok Pierwszy]from Limity where [ID Ligi]=@id_ligi)	
set @id_zaw =1

set @limit_zaw  = (Select [Limit Zawodnikow w Druzynie]from Limity where [ID Ligi]=@id_ligi)	
set @limit_dr  =(Select [Limit Druzyn w Lidze] from Limity where [ID Ligi]=@id_ligi)		
set @limit_lat  =(Select [Limit Lat]  from Limity where [ID Ligi]=@id_ligi)

set @max_z =0
set @max_d =0
set @max_id =0
set @temp =0

WHILE @sezon <= @limit_lat
BEGIN
	set @id_dr= 1
	set @temp=0
	set @max_d=0
	While @id_dr<=@limit_dr
	begin
		set @temp=
			(select count([Wynik Gospodarza]) from Mecz 
			where [Wynik Gospodarza]>[Wynik Goscia] and Sezon=@sezon and [ID Gospodarza]=@id_dr)
			+
			(select count([Wynik Goscia]) from Mecz 
			where [Wynik Goscia]>[Wynik Gospodarza] and Sezon=@sezon and [ID Goscia]=@id_dr)
		--if @id_dr=10 select @temp,@sezon
		insert into [Ranking Druzyn] values (@sezon,@id_dr,@temp);
		if @temp>@max_d
		begin
			set @max_d =@temp
			set @max_id=@id_dr
		end;
		set @id_dr = @id_dr+1
	end;
	--select @max_id,@max_d,@sezon
	set @id_dr=@max_id

	--insert into [Ranking Druzyn] values (@sezon,@id_dr,@max_d);
	set @sezon=@sezon +1
end;


/*
select * from [Ranking Druzyn]
order by sezon, [Wygrane Mecze Druzyny]
*/

