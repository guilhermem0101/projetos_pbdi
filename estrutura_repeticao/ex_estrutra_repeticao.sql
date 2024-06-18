CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior INT) RETURNS INT AS
$$
BEGIN
    RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;

--   1
DO
$$
DECLARE
    i INT;
BEGIN
    
    FOR i IN 1..100 LOOP
        
        IF i % 2 = 0 THEN
            RAISE NOTICE '%', i;
        END IF;
    END LOOP;
END;
$$;



--   2
DO
$$
DECLARE
    num INT;
    contador_positivos INT := 0;
BEGIN
    -- Gerando 6 números aleatórios e contando quantos são positivos
    FOR i IN 1..6 LOOP
        SELECT valor_aleatorio_entre(-50, 50) INTO num;
        IF num > 0 THEN
            contador_positivos := contador_positivos + 1;
        END IF;
    END LOOP;
    RAISE NOTICE 'Números positivos: %', contador_positivos;
END;
$$;


--  3
DO
$$
DECLARE
    x INT;
    y INT;
    soma INT := 0;
    menor INT;
    maior INT;
BEGIN
    -- Gerando dois números aleatórios
    SELECT valor_aleatorio_entre(1, 100) INTO x;
    SELECT valor_aleatorio_entre(1, 100) INTO y;

    -- Determinando o menor e o maior
    IF x < y THEN
        menor := x;
        maior := y;
    ELSE
        menor := y;
        maior := x;
    END IF;

    -- Somando os números ímpares entre menor e maior
    FOR i IN menor+1..maior-1 LOOP
        IF i % 2 <> 0 THEN
            soma := soma + i;
        END IF;
    END LOOP;

    RAISE NOTICE 'Soma dos ímpares entre % e %: %', menor, maior, soma;
END;
$$;

--  4
DO
$$
DECLARE
    x INT;
    y INT;
    menor INT;
    maior INT;
    soma INT := 0;
BEGIN
    -- Gerando dois números aleatórios
    SELECT valor_aleatorio_entre(1, 100) INTO x;
    SELECT valor_aleatorio_entre(1, 100) INTO y;

    -- Determinando o menor e o maior
    IF x < y THEN
        menor := x;
        maior := y;
    ELSE
        menor := y;
        maior := x;
    END IF;

    -- Exibindo a sequência e somando os valores
    FOR i IN menor..maior LOOP
        RAISE NOTICE '%', i;
        soma := soma + i;
    END LOOP;

    RAISE NOTICE 'Soma: %', soma;
END;
$$;

--  5
DO
$$
DECLARE
    matriz INT[3][3];
    determinante INT;
BEGIN
    -- Preenchendo a matriz com valores aleatórios
    FOR i IN 1..3 LOOP
        FOR j IN 1..3 LOOP
            matriz[i][j] := valor_aleatorio_entre(1, 12);
        END LOOP;
    END LOOP;

    -- Exibindo a matriz
    RAISE NOTICE 'Matriz 3x3:';
    FOR i IN 1..3 LOOP
        RAISE NOTICE '% % %', matriz[i][1], matriz[i][2], matriz[i][3];
    END LOOP;

    -- Calculando o determinante usando a Regra de Sarrus
    determinante := matriz[1][1] * matriz[2][2] * matriz[3][3]
                  + matriz[1][2] * matriz[2][3] * matriz[3][1]
                  + matriz[1][3] * matriz[2][1] * matriz[3][2]
                  - matriz[1][3] * matriz[2][2] * matriz[3][1]
                  - matriz[1][2] * matriz[2][1] * matriz[3][3]
                  - matriz[1][1] * matriz[2][3] * matriz[3][2];

    RAISE NOTICE 'Determinante: %', determinante;
END;
$$;