--reset tabeli 
delete from [Powiazanie Zawodnika z Druzyna]
insert into [Powiazanie Zawodnika z Druzyna] values (1,1,1,2010);

set @id_zaw  =
	(select max([Powiazanie Zawodnika z Druzyna].[ID Zawodnika])from [Powiazanie Zawodnika z Druzyna]);
set @id_poz =
	(select max([Powiazanie Zawodnika z Druzyna].[ID Pozycji])from [Powiazanie Zawodnika z Druzyna]);
set @id_dr =
	(select max([Powiazanie Zawodnika z Druzyna].[ID Druzyny])from [Powiazanie Zawodnika z Druzyna]);
set @Sezon =
	(select max([Powiazanie Zawodnika z Druzyna].Sezon)from [Powiazanie Zawodnika z Druzyna]);

set @limit_zaw  = (Select [Limit Zawodnikow w Druzynie]from Limity where [ID Ligi]=@id_ligi)	
set @limit_dr  =(Select [Limit Druzyn w Lidze] from Limity where [ID Ligi]=@id_ligi)		
set @limit_lat  =(Select [Limit Lat]  from Limity where [ID Ligi]=@id_ligi)
-- 16 zawodnikow w druzynie
-- 30 druzyn w lidze
-- 2019



WHILE @Sezon <= @limit_lat
BEGIN
   SET @id_zaw = @id_zaw+1;
   set @id_poz= @id_poz+1

   if @id_poz>@limit_zaw
		begin
		set @id_poz = 1
		if @id_dr !=0
			SET @id_dr = @id_dr+1 
		
		end;

   if @id_dr>@limit_dr 
   begin
		set @id_dr=0	-- bez druzyny
   end;

	if(@id_zaw>100)
	begin
		SET @Sezon = @Sezon + 1
		SET @id_dr = 1
		SET @id_poz = 1
		set @id_zaw=1
	end;

	insert into [Powiazanie Zawodnika z Druzyna] values (@id_zaw,@id_poz, @id_dr,@Sezon);
END;
delete from [Powiazanie Zawodnika z Druzyna] where Sezon=@limit_lat+1 --bo generuje sie 1 pozycja za duzo


--teraz transfery
set @random =0
set @rid  = 0
set @dru =0
set @Sezon=2011
while @Sezon<=@limit_lat
begin
	set @id_zaw=1
	while @id_zaw<101
	begin
		set @random = ABS(CHECKSUM(NEWID()) % 21) --losowa liczba 0-20
		if(@random>17)
		begin			
			set @rid = 1+ABS(CHECKSUM(NEWID()) % 100)--random id
			set @dru = (select [ID Druzyny] from [Powiazanie Zawodnika z Druzyna] 
				where [ID Zawodnika]=@id_zaw and Sezon=@Sezon)--obecna druzyna

			UPDATE [Powiazanie Zawodnika z Druzyna]
				SET [ID Zawodnika] = @id_zaw
				WHERE [ID Zawodnika] = @rid and [Sezon]= @Sezon;
			UPDATE [Powiazanie Zawodnika z Druzyna]
				set [ID Zawodnika] = @rid
				WHERE [ID Zawodnika] = @id_zaw and [Sezon]= @Sezon and [ID Druzyny]=@dru;
		end;
		set @id_zaw=@id_zaw+1
	end;
	set @Sezon=@Sezon+1
end;



select * from [Powiazanie Zawodnika z Druzyna]
where [ID Druzyny]!=0
order by [Sezon]



/*
select Imiê,Nazwisko,[Nazwa Druzyny],[Nazwa Pozycji],s.Sezon
from [Powiazanie Zawodnika z Druzyna] id,Zawodnicy z, Druzyny d,Pozycja p, Sezony s
where z.[ID Zawodnika]=id.[ID Zawodnika] 
and d.[ID Druzyny]=id.[ID Druzyny]
and p.[ID Pozycji]=id.[ID Pozycji]
and id.[ID Druzyny]=s.[ID Zwyciêscy]
order by s.sezon
*/
