-- Calcula o faturamento por canal
SELECT
    channel,
    SUM(total) AS faturamento
FROM orders
GROUP BY channel
ORDER BY faturamento DESC;


-- Faturamento por categoria
SELECT
    c.id AS category_id,
    c.name AS category_name,
    SUM(oi.line_total) AS faturamento
FROM order_items oi
JOIN product_variants pv
    ON pv.id = oi.product_variant_id
JOIN products p
    ON p.id = pv.product_id
JOIN categories c
    ON c.id = p.category_id
GROUP BY
    c.id,
    c.name
ORDER BY faturamento DESC
LIMIT 5;


-- Faturamento por produto
SELECT
    p.id AS product_id,
    p.name AS product_name,
    SUM(oi.line_total) AS faturamento
FROM order_items oi
JOIN product_variants pv
    ON pv.id = oi.product_variant_id
JOIN products p
    ON p.id = pv.product_id
GROUP BY
    p.id,
    p.name
ORDER BY faturamento DESC
LIMIT 5;


-- Faturamento por clientes
SELECT
    c.id AS customer_id,
    c.legal_name AS cliente,
    SUM(o.total) AS faturamento,
    COUNT(DISTINCT o.id) AS pedidos
FROM orders AS o
INNER JOIN customers AS c
    ON c.id = o.customer_id
GROUP BY
    c.id,
    c.legal_name
ORDER BY
    faturamento DESC,
    c.id ASC
LIMIT 5;