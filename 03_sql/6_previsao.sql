-- Filtra todas as vendas do produto
SELECT
    o.id AS order_id,
    o.created_at,
    oi.quantity,
    p.id AS product_id,
    p.name AS product_name
FROM orders AS o
JOIN order_items AS oi
    ON oi.order_id = o.id
JOIN product_variants AS pv
    ON pv.id = oi.product_variant_id
JOIN products AS p
    ON p.id = pv.product_id
WHERE p.name = 'Bússola de Bordo 702';

-- Agrupa todas as vendas por mês
SELECT
    DATE_TRUNC('month', o.created_at)::date AS mes,
    SUM(oi.quantity) AS unidades_vendidas
FROM orders AS o
JOIN order_items AS oi
    ON oi.order_id = o.id
JOIN product_variants AS pv
    ON pv.id = oi.product_variant_id
JOIN products AS p
    ON p.id = pv.product_id
WHERE p.name = 'Bússola de Bordo 702'
GROUP BY DATE_TRUNC('month', o.created_at)
ORDER BY mes;

-- Filtra os dados para treino
SELECT
    DATE_TRUNC('month', o.created_at)::date AS mes,
    SUM(oi.quantity) AS unidades_vendidas
FROM orders AS o
JOIN order_items AS oi
    ON oi.order_id = o.id
JOIN product_variants AS pv
    ON pv.id = oi.product_variant_id
JOIN products AS p
    ON p.id = pv.product_id
WHERE p.name = 'Bússola de Bordo 702'
  AND o.created_at < '2026-01-01'
GROUP BY DATE_TRUNC('month', o.created_at)
ORDER BY mes;

-- Filtra os dados para teste
SELECT
    DATE_TRUNC('month', o.created_at)::date AS mes,
    SUM(oi.quantity) AS unidades_vendidas
FROM orders AS o
JOIN order_items AS oi
    ON oi.order_id = o.id
JOIN product_variants AS pv
    ON pv.id = oi.product_variant_id
JOIN products AS p
    ON p.id = pv.product_id
WHERE p.name = 'Bússola de Bordo 702'
  AND o.created_at >= '2026-01-01' AND o.created_at < '2026-04-01'
GROUP BY DATE_TRUNC('month', o.created_at)
ORDER BY mes;

-- Classifica o base entre treino e teste
WITH vendas_mensais AS (
    SELECT
        DATE_TRUNC('month', o.created_at)::date AS mes,
        SUM(oi.quantity) AS unidades_vendidas
    FROM orders AS o
    JOIN order_items AS oi
        ON oi.order_id = o.id
    JOIN product_variants AS pv
        ON pv.id = oi.product_variant_id
    JOIN products AS p
        ON p.id = pv.product_id
    WHERE p.name = 'Bússola de Bordo 702'
      AND o.created_at < '2026-04-01'
    GROUP BY DATE_TRUNC('month', o.created_at)
)
SELECT
    mes,
    unidades_vendidas,
    CASE
        WHEN mes <= '2025-12-01' THEN 'treino'
        ELSE 'teste'
    END AS conjunto
FROM vendas_mensais
ORDER BY mes;