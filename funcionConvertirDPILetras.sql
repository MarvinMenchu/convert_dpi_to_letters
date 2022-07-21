CREATE OR REPLACE FUNCTION convertDpiToLetters(numberDpi character varying)
    RETURNS character varying
AS $$
DECLARE
    letters character varying := '';
    primeraParte character varying := '';
    segundaParte character varying := '';
    terceraParte character varying := '';
    num1 integer;
    num2 integer;
    num3 integer;
BEGIN
    -- Con expresion regular evaluamos que el dato recibido tenga el formato 9999 99999 9999
  if (numberDpi ~ '[0-9]{4}\s[0-9]{5}\s[0-9]{4}$') is true then
    -- obtengo las tres partes de la estructura de numero del DPI y convertirno en numero
    num1 := cast(substring(numberDpi, 1, 4) as decimal);
    num2 := cast(substring(numberDpi, 6, 5) as decimal);
    num3 := cast(substring(numberDpi, 12, 4) as decimal);
    
    -- convertimos la PRIMERA parte en letras y agregamos el texto 'CERO'
    if num1 = 0 then
        primeraParte := 'CERO CERO CERO CERO ';
    elsif num1 between 1 and 9 then
        primeraParte := 'CERO CERO CERO ' || f_convnl(num1);
    elsif num1 between 10 and 99 then
        primeraParte := 'CERO CERO ' || f_convnl(num1);
    elsif num1 between 100 and 999 then
        primeraParte := 'CERO ' || f_convnl(num1);
    else
        primeraParte := f_convnl(num1);
    end if;
    
    -- convertimos la SEGUNDA parte en letras y agregamos el texto 'CERO'
    if num2 = 0 then
        segundaParte := 'CERO CERO CERO CERO CERO ';
    elsif num2 between 1 and 9 then
        segundaParte := 'CERO CERO CERO CERO ' || f_convnl(num2);
    elsif num2 between 10 and 99 then
        segundaParte := 'CERO CERO CERO ' || f_convnl(num2);
    elsif num2 between 100 and 999 then
        segundaParte := 'CERO CERO ' || f_convnl(num2);
    elsif num2 between 1000 and 9999 then
        segundaParte := 'CERO ' || f_convnl(num2);
    else
        segundaParte := f_convnl(num2);
    end if;
    
    -- convertimos la TERCERA parte en letras y agregamos el texto 'CERO'
    if num3 = 0 then
        terceraParte := 'CERO CERO CERO CERO ';
    elsif num3 between 1 and 9 then
        terceraParte := 'CERO CERO CERO ' || f_convnl(num3);
    elsif num3 between 10 and 99 then
        terceraParte := 'CERO CERO ' || f_convnl(num3);
    elsif num3 between 100 and 999 then
        terceraParte := 'CERO ' || f_convnl(num3);
    else
        terceraParte := f_convnl(num3);
    end if;
    
    letters := primeraParte || ' ESPACIO ' || segundaParte || ' ESPACIO ' || terceraParte;
  else
    letters := 'NUMERO DPI CON FORMATO INCORRECTO!';
  end if;
    --RAISE NOTICE letters;
    RETURN upper(letters);
END;
$$
LANGUAGE PLPGSQL;

select convertDpiToLetters('1906 76744 0701');