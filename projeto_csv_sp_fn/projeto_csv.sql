CREATE TABLE tb_student_prediction(
	id_student  SERIAL PRIMARY KEY,
	age INT,
	gender INT,
	salary INT,
	prep_exam INT,
	notes INT,
	grade INT
);

--Exibe o número de estudantes maiores de idade
DO
$$
DECLARE
    cur_student REFCURSOR;
    idade INT;
    contador INT := 0;
BEGIN
    OPEN cur_student FOR 
    SELECT age FROM tb_student_prediction;

    LOOP
        FETCH cur_student INTO idade;
        IF idade > 18 THEN
            contador := contador + 1;
        ELSE  RAISE NOTICE '';
        END IF;
        EXIT WHEN NOT FOUND;
        
    END LOOP;
    RAISE NOTICE '%', contador;
END;
$$

-- Exibe o percentual de estudantes de cada sexo.
DO
$$
DECLARE
    cur_student REFCURSOR;
    genero INT;
    contador INT := 0;
BEGIN
    OPEN cur_student FOR 
    SELECT gender FROM tb_student_prediction;

    LOOP
        FETCH cur_student INTO idade;
        IF genero = 1 THEN
            contador := contador + 1;
        ELSE  RAISE NOTICE '';
        END IF;
        EXIT WHEN NOT FOUND;
        
    END LOOP;
    RAISE NOTICE '%', contador;
END;
$$