CREATE TABLE products(
	id serial PRIMARY KEY,
	name TEXT NOT NULL,
	specs JSONB NOT NULL
);


INSERT INTO products(name, specs)
VALUES
(
    'Smartphone',
    '{
        "brand": "Acme",
        "model": "X200",
        "dimensions": {"width": 70, "height": 150, "depth": 8},
        "features": ["4G", "Bluetooth", "Wifi"],
        "warranty": "2 years"
    }'
);

SELECT * FROM products WHERE id=1;

SELECT 
	id,
	specs->>'brand' AS Brand,
	specs->'features' AS features,
	specs#>'{dimensions,width}' AS width
FROM products;


-- filtering
SELECT * FROM products
WHERE specs->>'warranty' = '2 years';

SELECT * FROM products
WHERE specs @> '{"brand": "Acme"}'

SELECT * FROM products
WHERE specs ? 'brand'

SELECT * FROM products
WHERE specs->'features' ? 'Wifi'

UPDATE products
SET specs = jsonb_set(
	specs,
	'{dimensions, depth}',
	'10',
	false
)
WHERE id = 1;


UPDATE products
SET specs = jsonb_set(
	specs,
	'{features}',
	(specs->'features') || '"Battery"',
	false
)
WHERE id = 1;

UPDATE products
SET specs = jsonb_set(
	specs,
	'{brand}',
	'"Delta"',
	false
)
WHERE id=2;

UPDATE products
SET specs = specs || '{"price": 1200}'
WHERE id = 1;

UPDATE products
SET specs = specs || '{"color": "black"}'

UPDATE products
SET specs = specs - 'price'
WHERE id =1;

UPDATE products
SET specs = specs #- '{dimensions, depth}'
WHERE id=1

SELECT * FROM products;

