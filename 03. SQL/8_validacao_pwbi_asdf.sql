-- Verifica se o produto existe
SELECT
    id,
    name,
    category_id
FROM products
WHERE name = 'asdf';

-- Verifica se há vendas do produto 
SELECT
    pv.id AS variant_id,
    pv.product_id,
    pv.sale_price,
    pv.cost_price,
    oi.quantity
FROM product_variants AS pv
JOIN order_items AS oi
    ON oi.product_variant_id = pv.id
WHERE pv.product_id IN (
    SELECT id
    FROM products
    WHERE name = 'asdf'
);

SELECT
    p.id AS product_id,
    p.name AS product_name,
    COUNT(DISTINCT pv.id) AS qtd_variantes,
    SUM(oi.quantity) AS total_itens,
    COUNT(*) AS linhas_order_items,
    COUNT(DISTINCT oi.order_id) AS pedidos_distintos
FROM order_items oi
JOIN product_variants pv
    ON pv.id = oi.product_variant_id
JOIN products p
    ON p.id = pv.product_id
WHERE LOWER(TRIM(p.name)) = 'asdf'
GROUP BY
    p.id,
    p.name
ORDER BY
    total_itens DESC;
	
-- Verifique todas as variantes de asdf
SELECT
    p.id AS product_id,
    p.name AS product_name,
    pv.id AS product_variant_id,
    SUM(oi.quantity) AS quantidade_por_variante,
    COUNT(*) AS linhas_order_items
FROM order_items oi
JOIN product_variants pv
    ON pv.id = oi.product_variant_id
JOIN products p
    ON p.id = pv.product_id
WHERE LOWER(TRIM(p.name)) = 'asdf'
GROUP BY
    p.id,
    p.name,
    pv.id
ORDER BY
    quantidade_por_variante DESC;