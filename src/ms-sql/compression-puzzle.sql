declare @input nvarchar(max) 
declare @result_expected nvarchar(max)
declare @i int
declare @prev char
declare @c int
declare @curr char
declare @result nvarchar(max)

set @input = 'AAABBAAC'
set @result_expected = '3A2B2A1C'
set @c = 0
set @i = 1
set @prev = substring(@input, @i, 1) 

while @i <= len(@input) + 1
begin
	set @curr =  substring(@input, @i, 1)

	if(@curr = @prev)
		begin
			set @c = @c +1
		end
	
	else if((@curr != @prev)) 
		begin
			set @result = concat(isnull(@result,''), @c, @prev)
			set @c = 1
			set @prev = substring(@input, @i, 1)
		end
	
	set @i = @i + 1

end

if(@result = '3A2B2A1C')
	select @result
else
	raiserror('Expected result: %s',1,1,'3A2B2A1C')




	