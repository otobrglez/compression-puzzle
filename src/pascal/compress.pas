var inputstring, expectedresult, currentresult: string;
    len, ii : integer;
    prevchar : char;
    temp : string;
begin
  inputstring := 'AAABBAAC';
  expectedresult := '3A2B2A1C';
  len := 0;
  prevchar := inputstring[1];
  currentresult := '';
  
  for ii := 1 to length(inputstring) do 
  begin
    if prevchar = inputstring[ii] then
    begin
      len := len + 1;
    end else begin
      str(len, temp);
      currentresult := currentresult + temp + prevchar;
      len := 1;
    end;
    prevchar := inputstring[ii]
  end;
  
  str(len, temp);
  currentresult := currentresult + temp + prevchar;
  
  if currentresult = expectedresult then write('OK: ' + currentresult)
  else write('NAPAKA. Namesto ' + expectedresult + ' je rezultat ' + currentresult);
end.

