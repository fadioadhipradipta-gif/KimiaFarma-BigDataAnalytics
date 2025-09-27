--CREATE TABLE `rakamin-472807.kimia_farma.kf_analyzed_table` AS
SELECT 
  final.transaction_id,
  final.date,
  kantor.branch_id,
  kantor.branch_name,
  kantor.kota,
  kantor.provinsi,
  kantor.rating AS rating_cabang,
  final.customer_name,
  product.product_id, 
  product.product_name,
  product.price AS actual_price,

  CAST(final.discount_percentage AS DECIMAL) AS discount_percentage,

  CAST(CASE 
    WHEN product.price <= 50000 THEN 0.1 --10%
    WHEN product.price > 50000 AND product.price <= 100000 THEN 0.15 --15%
    WHEN product.price > 100000 AND product.price <= 300000 THEN 0.2 --20%
    WHEN product.price > 300000 AND product.price <= 500000 THEN 0.25 --25%
    WHEN product.price > 500000 THEN 0.3 --30%
  END AS DECIMAL) AS persentase_gross_laba,

  CAST(final.price*(1-final.discount_percentage) AS DECIMAL) AS nett_sales,

  CAST(final.price*(1-final.discount_percentage)* 
  CASE 
    WHEN product.price <=50000 THEN 0.1
    WHEN product.price > 50000 AND product.price <= 100000 THEN 0.15
    WHEN product.price > 100000 AND product.price <= 300000 THEN 0.2
    WHEN product.price > 300000 AND product.price <= 500000 THEN 0.25
    WHEN product.price > 500000 THEN 0.3
  END AS DECIMAL) AS nett_profit,

  CAST(final.rating AS DECIMAL) AS rating_transaksi

FROM `rakamin-472807.kimia_farma.kf_final_transaction` final
JOIN `rakamin-472807.kimia_farma.kf_kantor_cabang` kantor ON kantor.branch_id = final.branch_id
JOIN `rakamin-472807.kimia_farma.kf_product` product ON product.product_id = final.product_id;