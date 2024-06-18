CREATE FUNCTION fn_hello ( ) RETURNS TEXT
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN 'Hello, functions';
END;
$$

SELECT fn_hello ();

--chamando com bloco anônimo
DO $$
DECLARE
resultado TEXT;
BEGIN
    --não pode, call somente para procs
    --CALL fn_hello();
    --executa descartando..
    PERFORM fn_hello();
    --assim pode
    resultado := fn_hello();
    RAISE NOTICE '%', resultado;
    --assim também
    SELECT fn_hello() INTO resultado;
    RAISE NOTICE '%', resultado;
END;
$$


