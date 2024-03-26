


--1.1
DO
$$
DECLARE 
	N NUMERIC :=random();
BEGIN
	RAISE NOTICE '%', FLOOR(N*100);
	RAISE NOTICE 'Meu primeiro bloco anônimo';
END;
$$

--1.2
DO
$$
DECLARE 
	N NUMERIC :=random();
BEGIN
	RAISE NOTICE '%', N*10;
	RAISE NOTICE 'Meu primeiro bloco anônimo';
END;
$$

--1.3
DO
$$
DECLARE 
	C NUMERIC :=random();
	limite_inferior INTEGER := 20;
	limite_superior  INTEGER := 30;
	F INTEGER;
BEGIN 
	F :=(limite_inferior + FLOOR(C* (limite_superior - limite_inferior + 1)))*9/5 +32;
	RAISE NOTICE '%', F;
END;
$$

--1.4
DO
$$
DECLARE 
	A NUMERIC := 1 + random()*10;
	B NUMERIC :=1 + random()*10;
	C NUMERIC :=1 + random()*10;
	delta NUMERIC;
BEGIN 
	delta := B*B - 4 * A * C;
	RAISE NOTICE '%', delta;
END;
$$

--1.5
DO
$$
DECLARE
    numero INTEGER := FLOOR(1 + random() * 10);
    raiz_cubica NUMERIC;
	raiz_quadrada NUMERIC;
BEGIN
    raiz_cubica := POWER(numero - 1, 1.0/3); 
	raiz_quadrada := SQRT(numero + 1); 
    RAISE NOTICE '% % %', numero, raiz_quadrada, raiz_cubica;
	
END;
$$

--1.6
DO
$$
DECLARE
    lado1 INTEGER := FLOOR(1 + random() * 10);
	lado2 INTEGER := FLOOR(1 + random() * 10);
    valor_metro NUMERIC;
	area NUMERIC;
BEGIN
	area := lado1 * lado2;
	valor_metro := (60 + (random() * (70 - 61))) * area;
	
    RAISE NOTICE '% % %', valor_metro, lado1, lado2;
	
END;
$$

--1.7
DO
$$
DECLARE
    nascimento NUMERIC := 1980 + floor(random() * (2000 - 1981));
	ano_atual NUMERIC := 2010 + floor(random() * (2020 - 2011));
	idade INTEGER;
BEGIN
	idade := ano_atual - nascimento;
	
    RAISE NOTICE '% % %', nascimento, ano_atual, idade;
	
END;
$$
