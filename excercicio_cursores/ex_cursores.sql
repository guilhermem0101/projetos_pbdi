--EX. 1
DO $$
DECLARE
	v_video_count INT:=1000;
	v_category TEXT[] := ARRAY['Sports', 'Music'];
	cur_rank_youtubers CURSOR (contagem INT, categorias TEXT[])FOR
		SELECT rank, youtuber FROM tb_youtubers 
		WHERE video_count >= contagem AND category = ANY(categorias);
	tupla RECORD;
	resultado TEXT DEFAULT '';
BEGIN 
	OPEN cur_rank_youtubers(v_video_count, v_category);
	
	
	FETCH cur_rank_youtubers INTO tupla;
	WHILE FOUND LOOP
		--concatenção, operador ||
		resultado := resultado || tupla.rank || ', ' || tupla.youtuber || ', ';
		FETCH cur_rank_youtubers INTO tupla;
	END LOOP;
	CLOSE cur_rank_youtubers;
	RAISE NOTICE  '%', resultado;
END;
$$


--EX. 2
DO $$
DECLARE
	-- 1, Delaração do cursor (cursor não vinculado)
	cur_nomes_youtubers_reverse REFCURSOR;
	v_youtuber VARCHAR(200);
BEGIN
	-- 2, Abertua do cursor
	OPEN cur_nomes_youtubers_reverse FOR 
		SELECT youtuber FROM tb_youtubers
		ORDER BY youtuber;
		
	-- 3. Movendo o cursor para a última linha
	MOVE LAST IN cur_nomes_youtubers_reverse;
	
	-- 4. Recuperação de dados de interesse
	LOOP
		FETCH PRIOR FROM cur_nomes_youtubers_reverse INTO v_youtuber;
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', v_youtuber;		
	END LOOP;
	--5. Fechar o cursor
	CLOSE cur_nomes_youtubers_reverse;
END;
$$




