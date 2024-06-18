
CREATE TABLE tb_estudantes(
	student_id SERIAL PRIMARY KEY,
	salary INT,
	mother_edu INT,
	father_edu INT,
	prep_study INT,
	prep_exam INT,
	grade INT
);


--Escreva procedure que exibe o número de alunos aprovados e cujos pais são phds
CREATE OR REPLACE PROCEDURE sp_alunos_aprovados(
	 OUT contagem INT
) LANGUAGE plpgsql
AS $$
BEGIN
	SELECT COUNT(*)
	INTO contagem
	FROM tb_estudantes
	WHERE father_edu = 6 and mother_edu = 6 and grade > 0;
END;
$$

DO $$
DECLARE
contagem INT;
BEGIN
	CALL sp_alunos_aprovados(contagem);
	RAISE NOTICE 'Alunos aprovados com pais PHDs : %', contagem;
END;
$$

