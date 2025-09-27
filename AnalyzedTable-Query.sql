
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
  final.discount_percentage,

  CASE
    WHEN product.price <= 50000 THEN 0.1
    WHEN product.price BETWEEN 50001 AND 100000 THEN 0.15
    WHEN product.price BETWEEN 100001 AND 300000 THEN 0.2
    WHEN product.price BETWEEN 300001 AND 500000 THEN 0.25
    ELSE 0.3
  END AS persentase_gross_laba,

  final.price * (1 - final.discount_percentage) AS nett_sales,

  final.price * (1 - final.discount_percentage) * 
  CASE
    WHEN product.price <= 50000 THEN 0.1
    WHEN product.price BETWEEN 50001 AND 100000 THEN 0.15
    WHEN product.price BETWEEN 100001 AND 300000 THEN 0.2
    WHEN product.price BETWEEN 300001 AND 500000 THEN 0.25
    ELSE 0.3
  END AS nett_profit,

 final.rating AS rating_transaksi

FROM `rakamin-472807.kimia_farma.kf_final_transaction` final

JOIN `rakamin-472807.kimia_farma.kf_kantor_cabang` kantor 
  ON kantor.branch_id = final.branch_id

JOIN `rakamin-472807.kimia_farma.kf_product` product 
  ON product.product_id = final.product_id;
