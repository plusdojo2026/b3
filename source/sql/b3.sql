CREATE DATABASE b3;

USE b3;

create table users (		
id INTEGER AUTO_INCREMENT PRIMARY KEY,		
wallet_id int ,		
login_id varchar (20) UNIQUE KEY,		
password varchar (20),		
nickname varchar (30),		
display_mode varchar (10),		
night BOOLEAN ,		
language varchar(10) ,		
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP	
);

INSERT INTO users (
    wallet_id,
    login_id,
    password,
    nickname,
    display_mode,
    night,
    language
) VALUES
(1, 'komori21', 'komori0611', '美咲', 'green', FALSE, 'ja'),  /*小森美咲さん*/
(2, 'Leonardo', 'secret987', 'Leonardo', 'blue', TRUE, 'en'),/*レオナルド*/
(3, 'user1111', 'password', 'guest', 'green', FALSE, 'ja'); /*ゲスト*/

create table wallets (		
id int AUTO_INCREMENT PRIMARY KEY,		
ten_thousand_yen int ,		
five_thousand_yen int ,		
one_thousand_yen int ,		
five_hundred_yen int ,		
one_hundred_yen int ,		
fifty_yen int ,		
ten_yen int ,		
five_yen int ,		
one_yen int ,		
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP		
);

INSERT INTO wallets (
    ten_thousand_yen,
    five_thousand_yen,
    one_thousand_yen,
    five_hundred_yen,
    one_hundred_yen,
    fifty_yen,
    ten_yen,
    five_yen,
    one_yen
) VALUES

-- 現金多めの人(小森さん)
(3, 2, 5, 4, 10, 3, 20, 5, 50),

-- ほぼキャッシュレス(レオナルド)
(0, 0, 1, 0, 2, 0, 3, 0, 5),

-- 普通の社会人の財布例(ゲスト)
(1, 0, 3, 2, 5, 1, 8, 2, 10);


create table payments (		
id int AUTO_INCREMENT PRIMARY KEY,		
user_id int ,		
amount int ,		
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP		
);

INSERT INTO payments (
    user_id,
    amount
) VALUES
-- 小森さんがコンビニで買い物
(1, 980),

-- レオナルドがランチを購入
(2, 1200),

-- ゲストがカフェで支払い
(3, 650);

create table breakdowns (		
id int AUTO_INCREMENT PRIMARY KEY,		
payment_id int ,		
type_money int ,		
count_money int ,		
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP		
);

INSERT INTO breakdowns (
    payment_id,
    type_money,
    count_money
) VALUES
-- payment_id = 1（980円：500 + 100 + 100 + 100 + 50 + 10 + 10 + 10）
(1, 500, 1),
(1, 100, 3),
(1, 50, 1),
(1, 10, 3),

-- payment_id = 2（1200円：1000 + 100 + 100）
(2, 1000, 1),
(2, 100, 2),

-- payment_id = 3（650円：500 + 100 + 50）
(3, 500, 1),
(3, 100, 1),
(3, 50, 1);

create table products (		
id int AUTO_INCREMENT PRIMARY KEY,		
store_id int ,		
name_ja varchar (30),		
name_en varchar (30),		
price int ,		
categoly varchar (30),		
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP		
);

INSERT INTO products (
    store_id,
    name_ja,
    name_en,
    price,
    category
) VALUES
-- コンビニの商品
(1, 'おにぎり（鮭）', 'Salmon Rice Ball', 150, 'food'),
(1, '緑茶ペットボトル', 'Green Tea Bottle', 120, 'drink'),
(1, 'チョコレートバー', 'Chocolate Bar', 110, 'sweets'),
(1, 'カップラーメン', 'Cup Ramen', 198, 'food'),         
(1, 'ポテトチップス', 'Potato Chips', 158, 'sweets'),

-- ドラッグストアの商品
(2, 'ハンドソープ', 'Hand Soap', 298, 'daily'),
(2, 'ビタミンCサプリ', 'Vitamin C Supplement', 680, 'daily'),
(2, 'マスク（5枚入り）', 'Face Mask (5pcs)', 198, 'daily');

create table stores (		
id int AUTO_INCREMENT PRIMARY KEY,		
name_ja varchar (100),		
name_en varchar (100),		
address_ja varchar (100),		
address_en varchar (100),		
latitude DECIMAL (9,6),		
longitude DECIMAL (10,6),		
category varchar (100),		
cashless_type varchar (100),		
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP		
);

INSERT INTO stores (
    name_ja,
    name_en,
    address_ja,
    address_en,
    latitude,
    longitude,
    category,
    cashless_type
) VALUES
-- 架空の麴町コンビニ
('コンビニ麴町ステーション店', 'Kojimachi Station Convenience Store',
 '東京都千代田区麴町3-5-12', '3-5-12 Kojimachi, Chiyoda-ku, Tokyo',
 35.684512, 139.737821, 'both', 'credit, ic, qr'),

-- 架空の麴町ドラッグストア
('ドラッグストア麴町メディカル', 'Kojimachi Medical Drugstore',
 '東京都千代田区麴町4-2-8', '4-2-8 Kojimachi, Chiyoda-ku, Tokyo',
 35.685103, 139.735944, 'both', 'credit, qr');

create table columns (		
id int AUTO_INCREMENT PRIMARY KEY,		
title_ja varchar (100),		
title_en varchar (100),		
column_ja varchar (1000),		
column_en varchar (1000),		
category varchar (100),		
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP		
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    'ご祝儀袋の正しい選び方',
    'How to Choose the Right Gift Envelope',
    '結婚・出産・入学など、シーンによってご祝儀袋の選び方は異なります。結婚祝いには、一度きりのお祝いに使う「結び切り」や「あわじ結び」の水引を選びます。出産祝い・入学祝い・新築祝いなど、何度あっても喜ばしいお祝いには「蝶結び」の水引が適しています。また、包む金額に合わせて、袋の豪華さを選ぶことも大切です。',
    'The right gift envelope depends on the occasion, such as weddings, births, school entrance celebrations, and new home celebrations. For weddings, choose an envelope with a musubikiri or awaji-musubi cord, which means the celebration should happen only once. For happy events that may happen many times, such as births, school entrance celebrations, or new home celebrations, choose an envelope with a cho-musubi bow-shaped cord. It is also important to choose an envelope that matches the amount of money you are giving.',
    '冠婚葬祭'
);
