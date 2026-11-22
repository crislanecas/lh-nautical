-- Retorna uma lista de clientes único com o produto comprado correspondente
SELECT DISTINCT
    o.customer_id,
    p.id AS product_id
FROM orders AS o
JOIN order_items AS oi
    ON oi.order_id = o.id
JOIN product_variants AS pv
    ON pv.id = oi.product_variant_id
JOIN products AS p
    ON p.id = pv.product_id
ORDER BY
    o.customer_id,
    p.id;

-- Retorno o ID do produto
SELECT
    id,
    name
FROM products
WHERE name = 'Motor de Popa 1949';
