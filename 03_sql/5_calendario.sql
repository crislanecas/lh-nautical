-- Questão 5.1: Cria CTE calendario 
WITH calendario AS (
    SELECT
        data::date, -- Transforme o valor timestamp em apenas uma data pura (sem horas/minutos)
        CASE EXTRACT(ISODOW FROM data)
            WHEN 1 THEN 'Segunda-feira'
            WHEN 2 THEN 'Terça-feira'
            WHEN 3 THEN 'Quarta-feira'
            WHEN 4 THEN 'Quinta-feira'
            WHEN 5 THEN 'Sexta-feira'
            WHEN 6 THEN 'Sábado'
            WHEN 7 THEN 'Domingo'
        END AS dia_semana
    FROM generate_series( -- Gera uma serie com início, fim e intervalo
        (SELECT MIN(created_at)::date FROM orders),
        CURRENT_DATE,
        INTERVAL '1 day'
    ) AS data
)
SELECT *
FROM calendario;

-- Questão 5.1: Cria CTE vendas_diarias
WITH vendas_diarias AS (
	SELECT
	    created_at::date AS data,
	    SUM(total) AS valor_venda
	FROM orders
	WHERE channel = 'pos'
	GROUP BY created_at::date
)
SELECT *
FROM vendas_diarias
ORDER BY data;

-- Questão 5.1: Média de vendas por dia da semana
WITH calendario AS (
    SELECT
        data::date AS data,
        CASE EXTRACT(ISODOW FROM data)
            WHEN 1 THEN 'Segunda-feira'
            WHEN 2 THEN 'Terça-feira'
            WHEN 3 THEN 'Quarta-feira'
            WHEN 4 THEN 'Quinta-feira'
            WHEN 5 THEN 'Sexta-feira'
            WHEN 6 THEN 'Sábado'
            WHEN 7 THEN 'Domingo'
        END AS dia_semana
    FROM generate_series(
        (SELECT MIN(created_at)::date FROM orders),
        (SELECT MAX(created_at)::date FROM orders),
        INTERVAL '1 day'
    ) AS data
),
vendas_diarias AS (
    SELECT
        created_at::date AS data,
        SUM(total) AS valor_venda
    FROM orders
    WHERE channel = 'pos'
    GROUP BY created_at::date
),
calendario_vendas AS (
    SELECT
        c.data,
        c.dia_semana,
        COALESCE(v.valor_venda, 0) AS valor_venda
    FROM calendario c
    LEFT JOIN vendas_diarias v
        ON c.data = v.data
)
SELECT
    dia_semana,
    AVG(valor_venda) AS media_vendas
FROM calendario_vendas
GROUP BY dia_semana
ORDER BY media_vendas DESC;