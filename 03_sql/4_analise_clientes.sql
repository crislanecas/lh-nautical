-- Questão 4.1: Ticket Médio e a Diversidade de categorias por cliente
WITH clientes_vendas AS (
    SELECT
        o.customer_id,
        SUM(o.total) AS faturamento_total,
        COUNT(DISTINCT o.id) AS frequencia
    FROM orders AS o
    GROUP BY o.customer_id
),
diversidade_clientes AS (
    SELECT
        o.customer_id,
        COUNT(DISTINCT p.category_id) AS diversidade_categorias
    FROM orders AS o
    LEFT JOIN order_items AS oi
        ON oi.order_id = o.id
    LEFT JOIN product_variants AS pv
        ON pv.id = oi.product_variant_id
    LEFT JOIN products AS p
        ON p.id = pv.product_id
    GROUP BY o.customer_id
)
SELECT
    cv.customer_id,
    c.legal_name AS cliente,
    cv.faturamento_total,
    cv.frequencia,
    ROUND(
        cv.faturamento_total / NULLIF(cv.frequencia, 0),
        2
    ) AS ticket_medio,
    COALESCE(dc.diversidade_categorias, 0) AS diversidade_categorias
FROM clientes_vendas AS cv
LEFT JOIN diversidade_clientes AS dc
    ON dc.customer_id = cv.customer_id
LEFT JOIN customers AS c
    ON c.id = cv.customer_id
ORDER BY
    cv.customer_id;


-- Verifica possíveis duplicidades de variantes
SELECT
    pv.id AS product_variant_id,
    COUNT(*) AS qtd
FROM product_variants pv
GROUP BY pv.id
HAVING COUNT(*) > 1;

-- Questão 4.1: Identifica e filtra os 10 clientes "Fiéis" (maior Ticket Médio entre aqueles com diversidade >= 13 categorias)
WITH clientes_vendas AS (
    SELECT
        o.customer_id,
        SUM(o.total) AS faturamento_total,
        COUNT(DISTINCT o.id) AS frequencia
    FROM orders AS o
    GROUP BY o.customer_id
),
diversidade_clientes AS (
    SELECT
        o.customer_id,
        COUNT(DISTINCT p.category_id) AS diversidade_categorias
    FROM orders AS o
    LEFT JOIN order_items AS oi
        ON oi.order_id = o.id
    LEFT JOIN product_variants AS pv
        ON pv.id = oi.product_variant_id
    LEFT JOIN products AS p
        ON p.id = pv.product_id
    GROUP BY o.customer_id
)
SELECT
    cv.customer_id,
    c.legal_name AS cliente,
    cv.faturamento_total,
    cv.frequencia,
    ROUND(
        cv.faturamento_total / NULLIF(cv.frequencia, 0),
        2
    ) AS ticket_medio,
    dc.diversidade_categorias
FROM clientes_vendas AS cv
INNER JOIN diversidade_clientes AS dc
    ON dc.customer_id = cv.customer_id
LEFT JOIN customers AS c
    ON c.id = cv.customer_id
WHERE dc.diversidade_categorias >= 13
ORDER BY
    ticket_medio DESC,
    cv.customer_id ASC
LIMIT 10;


-- Questão 4.2: Identifique qual categoria de produto concentra a maior quantidade total de itens comprados
WITH clientes_vendas AS (
    SELECT
        o.customer_id,
        SUM(o.total) AS faturamento_total,
        COUNT(DISTINCT o.id) AS frequencia
    FROM orders AS o
    GROUP BY o.customer_id
),
diversidade_clientes AS (
    SELECT
        o.customer_id,
        COUNT(DISTINCT p.category_id) AS diversidade_categorias
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.id
    INNER JOIN product_variants AS pv
        ON pv.id = oi.product_variant_id
    INNER JOIN products AS p
        ON p.id = pv.product_id
    GROUP BY o.customer_id
),
top10_clientes AS (
    SELECT
        cv.customer_id,
        cv.faturamento_total,
        cv.frequencia,
        cv.faturamento_total / NULLIF(cv.frequencia, 0) AS ticket_medio,
        dc.diversidade_categorias
    FROM clientes_vendas AS cv
    INNER JOIN diversidade_clientes AS dc
        ON dc.customer_id = cv.customer_id
    WHERE dc.diversidade_categorias >= 13
    ORDER BY
        ticket_medio DESC,
        cv.customer_id ASC
    LIMIT 10
),
itens_top10 AS (
    SELECT
        p.category_id,
        c.name AS category_name,
        oi.quantity
    FROM top10_clientes AS t
    INNER JOIN orders AS o
        ON o.customer_id = t.customer_id
    INNER JOIN order_items AS oi
        ON oi.order_id = o.id
    INNER JOIN product_variants AS pv
        ON pv.id = oi.product_variant_id
    INNER JOIN products AS p
        ON p.id = pv.product_id
    INNER JOIN categories AS c
        ON c.id = p.category_id
)
SELECT
    category_id,
    category_name,
    SUM(quantity) AS total_itens
FROM itens_top10
GROUP BY
    category_id,
    category_name
ORDER BY
    total_itens DESC,
    category_id ASC;