--cursor vinculado (bound)
--exibir nome de canal concatenado a seu numero de inscritos
DO $$
DECLARE 
	--cursor bound (vinculado)
	--1. declaração (ainda não aberto)
	cur_nomes_e_inscritos CURSOR FOR 
	SELECT youtuber, subscribers FROM tb_youtubers;
	tupla RECORD;
	resultado TEXT DEFAULT '';

BEGIN
	--2. Abertura do cursor
	OPEN cur_nomes_e_inscritos;
	FETCH cur_nomes_e_inscritos INTO tupla;
	WHILE FOUND LOOP
		--concatenção, operador ||
		resultado := resultado || tupla.youtuber || ':' || tupla.subscribers || ', ';
		FETCH cur_nomes_e_inscritos INTO tupla;
	END LOOP;
	CLOSE cur_nomes_e_inscritos;
	RAISE NOTICE  '%', resultado;
END;
$$




DO $$
DECLARE
	--1. Declaração
	cur_nomes_a_partir_de REFCURSOR;
	v_youtubers VARCHAR(200);
	v_ano INT := 2008;
	v_nome_tabela VARCHAR(200) := 'tb_youtubers';
BEGIN
	--2. Abertura do cursor
	OPEN cur_nomes_a_partir_de FOR EXECUTE
	format(
		'
			SELECT youtuber
			FROM %s
			WHERE started >= $1
		', v_nome_tabela
	) USING v_ano;
	LOOP
		FETCH cur_nomes_a_partir_de INTO v_youtubers;
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', v_youtubers;
	END LOOP;
	--4. Fechamento do cursor 
	CLOSE cur_nomes_a_partir_de;
END;
$$


DO $$
DECLARE
	-- 1, Delaração do cursor (cursor não vinculado)
	cur_nomes_youtubers REFCURSOR;
	v_youtuber VARCHAR(200);

BEGIN
	-- 2, Abertua do cursor
	OPEN cur_nomes_youtubers FOR 
		SELECT youtuber FROM tb_youtubers;
		
	-- 3. Recuperação de dados de interesse
	LOOP
		FETCH cur_nomes_youtubers INTO v_youtuber;
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', v_youtuber;
	END LOOP;
	--4. Fechar o cursor
	CLOSE cur_nomes_youtubers;
END;
$$





CREATE TABLE tb_youtubers(
	cod_top_youtubers SERIAL PRIMARY KEY,
	rank int,
	youtuber VARCHAR(200),
	subscribers INT,
	video_viws VARCHAR(200),
	video_count INT,
	category VARCHAR(200),
	started INT
);


ALTER TABLE tb_youtubers ALTER COLUMN video_viws TYPE BIGINT USING video_viws::bigint;


SELECT * FROM tb_youtubers