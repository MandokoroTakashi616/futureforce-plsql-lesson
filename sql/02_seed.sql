INSERT INTO categories VALUES (1, '周辺機器');
INSERT INTO categories VALUES (2, 'ディスプレイ');
INSERT INTO categories VALUES (3, 'アクセサリ');

INSERT INTO products VALUES ( 1, 'ワイヤレスマウス',       1,  2980, 'Y');
INSERT INTO products VALUES ( 2, 'メカニカルキーボード',   1, 12800, 'Y');
INSERT INTO products VALUES ( 3, 'USB-Cハブ',              1,  4500, 'Y');
INSERT INTO products VALUES ( 4, '27インチモニター',       2, 32800, 'Y');
INSERT INTO products VALUES ( 5, 'モニターアーム',         2,  6980, 'Y');
INSERT INTO products VALUES ( 6, 'ノートPCスタンド',       3,  3480, 'Y');
INSERT INTO products VALUES ( 7, 'ケーブル収納ボックス',   3,  1980, 'Y');
INSERT INTO products VALUES ( 8, 'Webカメラ',              1,  8900, 'Y');
INSERT INTO products VALUES ( 9, 'デスクマット',           3,  2480, 'Y');
INSERT INTO products VALUES (10, 'ヘッドセット',           1,  9800, 'N');

INSERT INTO inventory (product_id, stock_quantity) VALUES ( 1, 25);
INSERT INTO inventory (product_id, stock_quantity) VALUES ( 2,  3);
INSERT INTO inventory (product_id, stock_quantity) VALUES ( 3,  0);
INSERT INTO inventory (product_id, stock_quantity) VALUES ( 4,  8);
INSERT INTO inventory (product_id, stock_quantity) VALUES ( 5, 12);
INSERT INTO inventory (product_id, stock_quantity) VALUES ( 6, 40);
INSERT INTO inventory (product_id, stock_quantity) VALUES ( 7,  5);
INSERT INTO inventory (product_id, stock_quantity) VALUES ( 8,  2);
INSERT INTO inventory (product_id, stock_quantity) VALUES ( 9, 60);
INSERT INTO inventory (product_id, stock_quantity) VALUES (10,  0);

INSERT INTO customers (customer_id, customer_name, email, prefecture, created_at)
  VALUES (1, '山田 太郎', 'taro.yamada@example.com',  '東京都', DATE '2026-06-01');
INSERT INTO customers (customer_id, customer_name, email, prefecture, created_at)
  VALUES (2, '佐藤 花子', 'hanako.sato@example.com',  '大阪府', DATE '2026-06-15');
INSERT INTO customers (customer_id, customer_name, email, prefecture, created_at)
  VALUES (3, '鈴木 一郎', 'ichiro.suzuki@example.com', '福岡県', DATE '2026-07-02');
INSERT INTO customers (customer_id, customer_name, email, prefecture, created_at)
  VALUES (4, '高橋 美咲', 'misaki.takahashi@example.com', '北海道', DATE '2026-07-20');
INSERT INTO customers (customer_id, customer_name, email, prefecture, created_at)
  VALUES (5, '田中 健',   'ken.tanaka@example.com',   '愛知県', DATE '2026-08-05');

INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
  VALUES (1001, 1, DATE '2026-08-01', 'SHIPPED',    8440);
INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
  VALUES (1002, 2, DATE '2026-08-03', 'PAID',      39780);
INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
  VALUES (1003, 1, DATE '2026-08-10', 'PENDING',   12800);
INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
  VALUES (1004, 3, DATE '2026-08-12', 'CANCELLED',  8900);
INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
  VALUES (1005, 4, DATE '2026-08-15', 'PAID',      12900);

INSERT INTO order_items VALUES (1001, 1, 1, 2,  2980);
INSERT INTO order_items VALUES (1001, 2, 9, 1,  2480);
INSERT INTO order_items VALUES (1002, 1, 4, 1, 32800);
INSERT INTO order_items VALUES (1002, 2, 5, 1,  6980);
INSERT INTO order_items VALUES (1003, 1, 2, 1, 12800);
INSERT INTO order_items VALUES (1004, 1, 8, 1,  8900);
INSERT INTO order_items VALUES (1005, 1, 6, 2,  3480);
INSERT INTO order_items VALUES (1005, 2, 7, 3,  1980);

COMMIT;
