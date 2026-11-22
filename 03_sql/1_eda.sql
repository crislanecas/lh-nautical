-- Questão 1.1: Intervalo de datas analisado (data mínima e máxima) e valor mínimo, máximo e médio
SELECT
    MIN(created_at) AS data_minima,
    MAX(created_at) AS data_maxima,
    MIN(total) AS valor_minimo,
    MAX(total) AS valor_maximo,
    AVG(total) AS valor_medio
FROM orders;

-- Questão 1.2: Calcula a quantidade total de linhas
SELECT COUNT(*) AS quantidade_linhas
FROM orders;


-- Questão 1.3: Calcula a distribuição dos dados 
SELECT
    MIN(total) AS minimo,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total) AS q1,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY total) AS mediana,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total) AS q3,
    MAX(total) AS maximo,
    AVG(total) AS media
FROM orders;

-- Questão 1.3: Conta os valores nulos
SELECT
    COUNT(*) AS total_linhas,
    COUNT(*) - COUNT(id) AS nulos_id,
    COUNT(*) - COUNT(order_number) AS nulos_order_number,
    COUNT(*) - COUNT(channel) AS nulos_channel,
    COUNT(*) - COUNT(customer_id) AS nulos_customer_id,
    COUNT(*) - COUNT(salesperson_id) AS nulos_salesperson_id,
    COUNT(*) - COUNT(location_id) AS nulos_location_id,
    COUNT(*) - COUNT(status) AS nulos_status,
    COUNT(*) - COUNT(subtotal) AS nulos_subtotal,
    COUNT(*) - COUNT(discount_amount) AS nulos_discount_amount,
    COUNT(*) - COUNT(total) AS nulos_total,
    COUNT(*) - COUNT(placed_at) AS nulos_placed_at,
    COUNT(*) - COUNT(created_at) AS nulos_created_at,
    COUNT(*) - COUNT(updated_at) AS nulos_updated_at
FROM orders;

-- Questão 1.3: Verificar valores inconsistentes
SELECT
    COUNT(*) FILTER (WHERE total <= 0) AS total_menor_igual_zero,
    COUNT(*) FILTER (WHERE subtotal < 0) AS subtotal_negativo,
    COUNT(*) FILTER (WHERE discount_amount < 0) AS desconto_negativo,
    COUNT(*) FILTER (WHERE total < subtotal) AS total_menor_que_subtotal
FROM orders;

-- Questão 1.3: Verifica se o total = subtotal - desconto
SELECT
    COUNT(*) AS total_linhas,
    COUNT(*) FILTER (
        WHERE total = subtotal - discount_amount
    ) AS total_consistente,
    COUNT(*) FILTER (
        WHERE total <> subtotal - discount_amount
    ) AS total_inconsistente
FROM orders;