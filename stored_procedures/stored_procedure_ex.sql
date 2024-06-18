-- 1.1 Adicione uma tabela de log ao sistema do restaurante. Ajuste cada procedimento para que ele registre
-- - a data em que a operação aconteceu
-- - o nome do procedimento executado
CREATE TABLE log_operacoes (
    id SERIAL PRIMARY KEY,
    dt_operacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    procedimento VARCHAR(255) NOT NULL
);

-- 

--1.2 Adicione um procedimento ao sistema do restaurante. 
CREATE OR REPLACE PROCEDURE sp_contar_pedidos_cliente(
    IN p_cod_cliente INT
) LANGUAGE plpgsql AS $$
DECLARE
    v_total_pedidos INT;
BEGIN
    SELECT COUNT(*) INTO v_total_pedidos
    FROM pedido
    WHERE cod_cliente = p_cod_cliente;

    RAISE NOTICE 'Total de pedidos do cliente %: %', p_cod_cliente, v_total_pedidos;

    -- Registrar log
    INSERT INTO log_operacoes (nome_procedimento) VALUES ('sp_contar_pedidos_cliente');
END;
$$;

-- 1.3 Procedimento para contar pedidos com variável de saída
CREATE OR REPLACE PROCEDURE sp_contar_pedidos_cliente_out(
    IN p_cod_cliente INT,
    OUT p_total_pedidos INT
) LANGUAGE plpgsql AS $$
BEGIN
    SELECT COUNT(*) INTO p_total_pedidos
    FROM pedido
    WHERE cod_cliente = p_cod_cliente;

    -- Registrar log
    INSERT INTO log_operacoes (nome_procedimento) VALUES ('sp_contar_pedidos_cliente_out');
END;
$$;

-- 1.4 Procedimento com parâmetro INOUT
CREATE OR REPLACE PROCEDURE sp_contar_pedidos_cliente_inout(
    INOUT p_cod_cliente INT
) LANGUAGE plpgsql AS $$
BEGIN
    SELECT COUNT(*) INTO p_cod_cliente
    FROM pedido
    WHERE cod_cliente = p_cod_cliente;

    -- Registrar log
    INSERT INTO log_operacoes (nome_procedimento) VALUES ('sp_contar_pedidos_cliente_inout');
END;
$$;

-- 1.5 Procedimento com parâmetro VARIADIC
CREATE OR REPLACE PROCEDURE sp_cadastrar_clientes_variadic(
    INOUT p_mensagem TEXT,
    VARIADIC p_nomes VARCHAR[]
) LANGUAGE plpgsql AS $$
DECLARE
    v_nome VARCHAR;
BEGIN
    FOREACH v_nome IN ARRAY p_nomes
    LOOP
        INSERT INTO tb_cliente (nome) VALUES (v_nome);
    END LOOP;

    p_mensagem := 'Os clientes: ' || array_to_string(p_nomes, ', ') || ' foram cadastrados';

    -- Registrar log
    INSERT INTO log_operacoes (nome_procedimento) VALUES ('sp_cadastrar_clientes_variadic');
END;
$$;

-- 1.6 Blocos anônimos para executar cada procedimento
DO $$
DECLARE
    v_resultado VARCHAR(500);
BEGIN
    CALL sp_obter_notas_para_compor_o_troco(v_resultado, 587);
    RAISE NOTICE 'Resultado: %', v_resultado;
END;
$$
--
DO $$
BEGIN
    CALL sp_contar_pedidos_cliente(1);
END;
$$
---
DO $$
DECLARE
    v_total_pedidos INT;
BEGIN
    CALL sp_contar_pedidos_cliente_out(1, v_total_pedidos);
    RAISE NOTICE 'Total de pedidos: %', v_total_pedidos;
END;
$$
---
DO $$
DECLARE
    v_cod_cliente INT := 1;
BEGIN
    CALL sp_contar_pedidos_cliente_inout(v_cod_cliente);
    RAISE NOTICE 'Total de pedidos: %', v_cod_cliente;
END;
$$
---
DO $$
DECLARE
    v_mensagem TEXT;
BEGIN
    CALL sp_cadastrar_clientes_variadic(v_mensagem, 'Pedro', 'Ana', 'João');
    RAISE NOTICE '%', v_mensagem;
END;
$$
------