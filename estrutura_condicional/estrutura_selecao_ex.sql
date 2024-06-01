USE estrutura_condicional


CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior INT) RETURNS INT AS
$$
BEGIN
    RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;


--1.1 Faça um programa que exibe se um número inteiro é múltiplo de 3.
DO $$
    DECLARE 
        numero INT;
    BEGIN
        numero := valor_aleatorio_entre(1, 100);
        RAISE NOTICE 'O valor gerado é: %', numero;
        IF numero % 3 = 0 THEN
            RAISE NOTICE 'O numero é muitiplo de 3';

            ELSE  RAISE NOTICE 'O numero Não é muitiplo de 3';
        END IF;
    END;
$$


DO $$
    DECLARE 
        numero INT;
    BEGIN
        numero := valor_aleatorio_entre(1, 100);
        RAISE NOTICE 'O valor gerado é: %', numero;
        CASE WHEN numero % 3 = 0 THEN 
            RAISE NOTICE 'O numero é muitiplo de 3';

            ELSE  RAISE NOTICE 'O numero Não é muitiplo de 3';
        END CASE;
    END;
$$

--1.2 Faça um programa que exibe se um número inteiro é múltiplo de 3 ou de 5.
DO $$
    DECLARE 
        numero INT;
    BEGIN
        numero := valor_aleatorio_entre(1, 100);
        RAISE NOTICE 'O valor gerado é: %', numero;
        IF numero % 3 = 0 THEN
            RAISE NOTICE 'O numero é muitiplo de 3';
        ELSIF numero % 5 = 0 THEN
            RAISE NOTICE 'O numero é muitiplo de 5';
        ELSE  RAISE NOTICE 'O numero Não é muitiplo de 3 nem 5';
        END IF;
    END;
$$


DO $$
    DECLARE 
        numero INT;
    BEGIN
        numero := valor_aleatorio_entre(1, 100);
        RAISE NOTICE 'O valor gerado é: %', numero;
        CASE WHEN numero % 3 = 0 THEN 
                RAISE NOTICE 'O numero é muitiplo de 3';
            WHEN numero % 5 = 0 THEN
                RAISE NOTICE 'O numero é muitiplo de 5';
            ELSE  
                RAISE NOTICE 'O numero Não é muitiplo de 3 Nem de 5';
        END CASE;
    END;
$$


--1.3 Faça um programa que opera de acordo com o menu. 

DO $$
DECLARE
    op1 INTEGER;
    op2 INTEGER;
    operacao INTEGER;
    resultado NUMERIC;
    operacao_texto TEXT;
BEGIN
    -- Defina os valores dos operandos e da operação desejada
    op1 := valor_aleatorio_entre (1, 100);        -- Primeiro operando
    op2 := valor_aleatorio_entre (1, 100);        -- Segundo operando
    operacao := 3;    -- Escolha a operação (1=Soma, 2=Subtração, 3=Multiplicação, 4=Divisão)

    -- Estrutura de controle para selecionar a operação
    IF operacao = 1 THEN
        resultado := op1 + op2;
        operacao_texto := ' + ';
    ELSIF operacao = 2 THEN
        resultado := op1 - op2;
        operacao_texto := ' - ';
    ELSIF operacao = 3 THEN
        resultado := op1 * op2;
        operacao_texto := ' * ';
    ELSIF operacao = 4 THEN
        IF op2 = 0 THEN
            RAISE NOTICE 'Erro: Divisão por zero';
            RETURN;
        ELSE
            resultado := op1 / op2;
            operacao_texto := ' / ';
        END IF;
    ELSE
        RAISE NOTICE 'Operação inválida';
        RETURN;
    END IF;

    -- Exibir o resultado
    RAISE NOTICE '% % % = %', op1, operacao_texto, op2, resultado;
END $$;


DO $$
DECLARE
    op1 INTEGER;
    op2 INTEGER;
    operacao INTEGER;
    resultado NUMERIC;
    operacao_texto TEXT;
BEGIN
    -- Defina os valores dos operandos e da operação desejada
    op1 := valor_aleatorio_entre (1, 100); -- Primeiro operando e
    op2 := valor_aleatorio_entre (1, 100); -- Segundo operando 
    operacao := 3;                       -- Escolha a operação (1=Soma, 2=Subtração, 3=Multiplicação, 4=Divisão)

    -- Estrutura de controle CASE WHEN para selecionar a operação
    CASE 
        WHEN operacao = 1 THEN
            resultado := op1 + op2;
            operacao_texto := ' + ';
        WHEN operacao = 2 THEN
            resultado := op1 - op2;
            operacao_texto := ' - ';
        WHEN operacao = 3 THEN
            resultado := op1 * op2;
            operacao_texto := ' * ';
        WHEN operacao = 4 THEN
            IF op2 = 0 THEN
                RAISE NOTICE 'Erro: Divisão por zero';
                RETURN;
            ELSE
                resultado := op1 / op2;
                operacao_texto := ' / ';
            END IF;
        ELSE
            RAISE NOTICE 'Operação inválida';
            RETURN;
    END CASE;

    -- Exibir o resultado
    RAISE NOTICE '% % % = %', op1, operacao_texto, op2, resultado;
END $$;

--1.4
DO $$
    DECLARE 
        valor INT;
        valor_venda INT;
    BEGIN
        valor := valor_aleatorio_entre(1, 100);
        RAISE NOTICE 'O valor gerado é: %', valor;
        IF valor < 20 THEN
            valor_venda := valor * 0.45 + valor;
            RAISE NOTICE 'O valor de venda é %', valor_venda;
        ELSE  
            valor_venda := valor * 0.30 + valor;
            RAISE NOTICE 'O valor de venda é %', valor_venda; 
        END IF;
    END;
$$

