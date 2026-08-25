-- Verifica as variações do produto
SELECT
    id,
    name
FROM products
WHERE name = 'Bússola de Bordo 702'; -- id.p 74 e 240

SELECT
    id,
    product_id
FROM product_variants
WHERE product_id = 74; -- id.pv 174 e 148

SELECT
    id,
    product_id
FROM product_variants
WHERE product_id = 240; -- id.pv 486

-- Verifica se as três variantes do produto realmente possuem vendas
SELECT
    p.id AS product_id,
    p.name,
    pv.id AS product_variant_id,
    COUNT(oi.id) AS quantidade_itens
FROM products AS p
JOIN product_variants AS pv
    ON pv.product_id = p.id
LEFT JOIN order_items AS oi
    ON oi.product_variant_id = pv.id
WHERE p.name = 'Bússola de Bordo 702'
GROUP BY
    p.id,
    p.name,
    pv.id
ORDER BY
    p.id,
    pv.id;