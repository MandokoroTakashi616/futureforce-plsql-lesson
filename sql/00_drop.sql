-- レッスンで作ったプロシージャ・ファンクション・パッケージ・トリガーを削除する
-- （トリガーが残ると、他の問題の実行結果が変わってしまうため）
BEGIN
  FOR r IN (SELECT object_type, object_name
              FROM user_objects
             WHERE object_type IN ('TRIGGER', 'PACKAGE', 'PROCEDURE', 'FUNCTION')
             ORDER BY DECODE(object_type, 'TRIGGER', 1, 'PACKAGE', 2, 3)) LOOP
    EXECUTE IMMEDIATE 'DROP ' || r.object_type || ' "' || r.object_name || '"';
  END LOOP;
END;
/

-- Oracle 23ai の DROP TABLE IF EXISTS を使う
DROP TABLE IF EXISTS inventory_logs PURGE;
DROP TABLE IF EXISTS order_items PURGE;
DROP TABLE IF EXISTS orders PURGE;
DROP TABLE IF EXISTS customers PURGE;
DROP TABLE IF EXISTS inventory PURGE;
DROP TABLE IF EXISTS products PURGE;
DROP TABLE IF EXISTS categories PURGE;
