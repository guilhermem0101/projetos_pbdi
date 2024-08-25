
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


-- Escreva um stored procedure que disponibiliza, utilizando um parâmetro em modo OUT, o número de alunos aprovados dentre aqueles que estudam sozinhos.

SELECT * from tb_estudantes;
CREATE OR REPLACE PROCEDURE sp_aprovados_sozinhos(
	 OUT contagem INT
) LANGUAGE plpgsql
AS $$
BEGIN
	SELECT COUNT(*)
	INTO contagem
	FROM tb_estudantes
	WHERE prep_study = 1 AND grade > 0;
END;
$$

DO $$
DECLARE
contagem INT;
BEGIN
	CALL sp_aprovados_sozinhos(contagem);
	RAISE NOTICE 'Alunos aprovados que estudam sós : %', contagem;
END;
$$



-- Dentre os alunos que têm salário maior que 410, quantos costumams e preparar com frequência (regularmente) para os exames? Escreva uma função que devolva esse número.
CREATE OR REPLACE FUNCTION fn_renda_aprovados() RETURNS INT
AS $$
DECLARE
	contagem INT;
BEGIN
	SELECT COUNT(*) 
	FROM tb_estudantes
	WHERE salary = 5 and grade > 0 and prep_exam = 2
    INTO contagem;
	
	RETURN contagem;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE 
	renda_aprovados INT;
BEGIN
	renda_aprovados := fn_renda_aprovados();
	RAISE NOTICE 'Alunos aprovados com renda maior que 410 é : %', renda_aprovados;
END;
$$