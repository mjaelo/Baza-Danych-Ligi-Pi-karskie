--reset tabeli 
delete from Pozycja

set @limit_zaw  = (Select [Limit Zawodnikow w Druzynie]from Limity where [ID Ligi]=@id_ligi)	
set @poz =1

insert into Pozycja values (1,'Bramkarz');

WHILE @poz < @limit_zaw
BEGIN
	insert into Pozycja values (@poz+1,'Napastnik');
	if @limit_zaw>=@poz+2
		insert into Pozycja values (@poz+2,'Obronca');
	if @limit_zaw>=@poz+3
		insert into Pozycja values (@poz+3,'Pomocnik');
	set @poz=@poz +3
end;


select * from Pozycja