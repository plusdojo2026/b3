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
alert_amount int NOT NULL DEFAULT 10000,
alert_count int NOT NULL DEFAULT 20,
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
name_en varchar (100),		
price int ,		
category varchar (30),	
image_url VARCHAR(100),
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP		
);

INSERT INTO products (
    store_id,
    name_ja,
    name_en,
    price,
    category,
    image_url
) VALUES
-- コンビニの商品
(1, 'おにぎり（鮭）', 'Salmon Rice Ball', 150, 'food', 'food_konbini_onigiri'),
(1, '紅茶ペットボトル', 'Tea Bottle', 120, 'drink', 'petbottle_tea_koucha'),
(1, 'チョコレートバー', 'Chocolate Bar', 110, 'food', 'chocolate_bar'),
(1, 'カップラーメン', 'Cup Ramen', 198, 'food', 'food_cup_ramen_syouyu'),         
(1, 'ポテトチップス', 'Potato Chips', 158, 'food', 'potatochips'),

-- ドラッグストアの商品
(2, 'ハンドソープ', 'Hand Soap', 298, 'other', 'sekken_hand_soap_bottle'),
(2, 'ビタミンCサプリ', 'Vitamin C Supplement', 680, 'other', 'suppliment_pill_diet'),
(2, 'マスク（5枚入り）', 'Face Mask (5pcs)', 198, 'other', 'mask'),

-- セブンイレブン
(3, '手巻おにぎり 炭火焼銀しゃけ', 'Hand-Rolled Rice Ball Salmon', 232, 'food', 'temaki_salmon'),
(3, '手巻おにぎり 焼たらこ', 'Hand-Rolled Rice Ball Cod roe', 235, 'food', 'temaki_codRoe'),
(3, '手巻おにぎり 熟成仕立て紀州南高梅', 'Hand-Rolled Rice Ball Plum',196, 'food', 'temaki_plum'),
(3, '手巻おにぎり 具たっぷり辛子明太子', 'Hand-Rolled Rice Ball Spicy cod roe', 232, 'food', 'temaki_spicyCodRoe'),
(3, '手巻おにぎり ツナマヨネーズ', 'Hand-Rolled Rice Ball Tuna mayo',196 , 'food', 'temaki_tunamayo'),
(3, '手巻おにぎり 北海道昆布', 'Hand-Rolled Rice Ball Kelp',196 , 'food', 'temaki_kelp'),
(3, '手巻おにぎり 炭火牛焼肉', 'Hand-Rolled Rice Ball Grilled Beef',246, 'food', 'temaki_beef'),
(3, '手巻おにぎり 海老マヨネーズ', 'Hand-Rolled Rice Ball Shrimp Mayo',213, 'food', 'temaki_shrimpMayo'),
(3, '味付海苔おにぎり　明太子マヨネーズ', 'Seasoned Seaweed Rice Ball Spicy cod roe',213 , 'food', 'azinori_spicyCodRoe'),
(3, '直巻おむすび ねぎ塩豚タン', 'Seaweed-Wrapped Rice Ball Negi-Shio Pork Tongue',237 , 'food', 'zikamaki_negishio'),
(3, '直巻おむすび 和風ツナマヨネーズ', 'Seaweed-Wrapped Rice Ball Japanese-Style Tuna Mayo',213 , 'food', 'zikamaki_tunamayo'),
(3, '直巻おむすび とり五目', 'Seaweed-Wrapped Rice Ball Chicken and Mixed Vegetable',213, 'food', 'zikamaki_gomoku'),
(3, '小麦香る練乳ミルクフランス', 'France Bread with Condensed Milk Cream',159, 'food', 'kashipan_milkFrance'),
(3, '7Pダブルデニッシュ　チョコ＆バナナクリーム', 'Chocolate & Banana Cream Denish',170, 'food', 'kashipan_denishChocoBanana'),
(3, '7Pぐるぐるミルク', 'Milk Swirl Bread',127, 'food', 'kashipan_milkSwirl'),
(3, 'チョコクリームのふわもちちぎりパン', 'Soft & Chewy Pull-Apart Bread with Chocolate Cream',170, 'food', 'kashipan_chigiri'),
(3, 'ふんわりコッペ　つぶあん&マーガリン', 'Red Bean & Margarine Koppe Bread',127, 'food', 'kashipan_koppeAnn'),
(3, 'サクふわメロンパン', 'Melon Pan',127, 'food', 'kashipan_melon'),
(3, '7プレミアム　しっとり食感のたまご蒸しパン', 'Steamed Egg Cake',116, 'food', 'kashipan_mushipan'),
(3, 'チョコ&ホイップロール', 'Chocolate-Coated Whipped Cream Bun',159, 'food', 'kashipan_chocoWhipped'),
(3, '濃厚トマトソースの大きなピザパン', 'Pizza Bread',203, 'food', 'souzaipan_pizza'),
(3, 'こだわりソースのふんわりコロッケパン', 'Croquette Roll',181, 'food', 'souzaipan_croquette'),
(3, '粗挽きポークフランク粒マスタードマヨ使用', 'Pork Sausage Roll',213, 'food', 'souzaipan_porkSausage'),
(3, 'つゆまで旨い　牛丼', 'Beef Bowl',645, 'food', 'chilled_gyuudon'),
(3, '8品目の中華丼', 'Chinese-Style Rice Bowl',645, 'food', 'chilled_chuuka'),
(3, 'じっくり煮込んだポークカレー', 'Pork Curry',537, 'food', 'chilled_curry'),
(3, '味しみロースかつ丼', 'Pork Cutlet Rice Bowl',699, 'food', 'chilled_katsu'),
(3, '肉の旨味とデミグラスのコク　ミートソース', 'Meat Sauce Pasta',496, 'food', 'pasta_meatSauce'),
(3, 'ケチャップソースの大盛ナポリタン', 'Napolitan Pasta',537, 'food', 'pasta_napolitan'),
(8, 'ブリュード コーヒー', 'Brewed Coffee', 440, 'drink', 'brewed_coffee'),
(8, 'カフェ ミスト', 'Caffè Misto', 495, 'drink', 'cafe_misto'),
(8, 'ビター クリーム コーヒー', 'Bitter Cream Coffee', 590, 'drink', 'bitter_cream_coffee'),
(8, 'キャラメル マキアート', 'Caramel Macchiato', 580, 'drink', 'caramel_macchiato'),
(8, 'スターバックス ラテ', 'Starbucks Latte', 500, 'drink', 'starbucks_latte'),
(8, 'エスプレッソ アフォガート フラペチーノ', 'Espresso Affogato Frappuccino', 640, 'drink', 'espresso_affogato_frappuccino'),
(8, 'コーヒー フラペチーノ', 'Coffee Frappuccino', 555, 'drink', 'coffee_frappuccino');


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
('コンビニ麹町ステーション店', 'Kojimachi Station Convenience Store',
 '東京都千代田区麹町3-5-12', '3-5-12 Kojimachi, Chiyoda-ku, Tokyo',
 35.683404, 139.738650, 'both', 'credit, ic, qr'),

-- 架空の麴町ドラッグストア
('ドラッグストア麹町メディカル', 'Kojimachi Medical Drugstore',
 '東京都千代田区麹町4-2-8', '4-2-8 Kojimachi, Chiyoda-ku, Tokyo',
 35.685103, 139.735944, 'both', 'credit, qr'),
 
-- 麹町コンビニ(実在)
('セブンイレブン麹町駅前店', 'Seven Eleven Kojimachi Ekimae Store',
 '東京都千代田区二番町4-3', '4-3 Nibancho, Chiyoda-ku, Tokyo',
 35.68624786735896, 139.7366265884323, 'both,ATM', 'credit, ic, qr'),

-- 三菱UFJ銀行 麹町支店
('三菱UFJ銀行 麹町支店', 'MUFG Bank Kojimachi Branch',
 '東京都千代田区麹町4-1', '4-1 Kojimachi, Chiyoda-ku, Tokyo',
 35.683056, 139.737778, 'ATM', 'credit, ic, qr'),

-- みずほ銀行 麹町支店（ATM・外貨両替あり）
('みずほ銀行 麹町支店', 'Mizuho Bank Kojimachi Branch',
 '東京都千代田区麹町5-1', '5-1 Kojimachi, Chiyoda-ku, Tokyo',
 35.683511, 139.735123, 'ATM,exchange', 'cash'),

-- ZTTo morning(キャッシュレスのみ)
('ZTTo morning', 'ZTTo morning',
 '東京都千代田区平河町2-4-4 owns平河町 1F', '1F owns Hirakawacho, 2-4-4 Hirakawacho, Chiyoda-ku, Tokyo',
 35.683011, 139.739055, 'cashlessonly', 'credit, ic, qr'),

-- コインランドリーきよの（現金のみ）
('コインランドリーきよの', 'Coin Laundry Kiyono',
 '東京都千代田区平河町2-2-5', '2-2-5 Hirakawacho, Chiyoda-ku, Tokyo',
 35.681123, 139.740456, 'cashonly', 'cash'),
 
 ('スターバックス麹町店', 'Starbucks Kojimachi',
 '東京都千代田区麹町3-2-5', '3-2-5 Kojimachi, Chiyoda-ku, Tokyo',
 35.684948, 139.738676, 'both', 'credit, ic, qr');
 
 

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

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    'お祝い全般で避けられる金額',
    'Amounts to Avoid for Celebrations',
    'お祝いでは、「4」や「9」を含む金額は避けられることがあります。「4」は「死」、「9」は「苦」を連想させるため、縁起が悪いと考えられるためです。特に結婚祝いや出産祝いなど、明るい場面では、相手に不安な印象を与えないよう、避けておくと安心です。',
    'For celebrations in Japan, amounts that include the numbers 4 or 9 are sometimes avoided. This is because 4 can sound like “death” and 9 can sound like “suffering” in Japanese. Especially for happy occasions such as weddings or birth celebrations, it is safer to avoid these numbers so that the gift does not give a negative impression.',
    '冠婚葬祭'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '結婚祝いの品物、金額の相場と選び方',
    'How to Choose a Wedding Gift and Its Appropriate Price',
    '結婚祝いはご祝儀だけでなく、品物を贈るケースも多くあります。一般的な相場は友人で5,000〜10,000円、親族で10,000〜30,000円ほどですが、相手との関係性や年齢によっても変わります。特に若いカップルには、実用的な家電やキッチン用品が喜ばれる傾向があります。 ただし、あまり高価すぎる品物は相手に気を遣わせてしまうため、無理のない範囲で選ぶことが大切です。また、他の友人と連名で贈ると、予算を増やしつつ負担を減らせるメリットがあります。結婚祝いは「新生活を応援する気持ち」が伝わることが何より重要です。',
    'Wedding gifts are often given in the form of items rather than cash. Typical budgets range from 5,000–10,000 yen for friends and 10,000–30,000 yen for relatives. Practical items such as home appliances or kitchen tools are especially appreciated by young couples. However, overly expensive gifts may cause discomfort, so it’s best to choose something within a reasonable range. Group gifts from several friends can increase the budget while reducing individual burden. The most important aspect is expressing support for the couple’s new life.',
    '冠婚葬祭'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '割り勘の時の暗黙のルール',
    'Unspoken Rules for Splitting the Bill',
    '日本では、友人や同僚との食事で「割り勘」にすることがよくあります。基本的には人数で均等に分けますが、端数が出た場合は少し切り上げて払うのが自然です。また、年上の人や上司が少し多めに払うこともあります。支払い前に「割り勘でいい？」と一言確認すると安心です。',
    'In Japan, it is common to split the bill when eating with friends or coworkers. Usually, the total is divided equally by the number of people, but if there is a small extra amount, people often round up and pay a little more. Older people or bosses may also pay a little more. Before paying, it is a good idea to ask, “Is it okay to split the bill?”',
    '日常生活'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '会計時に使える一言',
    'Useful Phrases When Paying',
    '日本で会計をするときは、短い一言を知っているだけでスムーズに支払えます。「別々でお願いします」は、一人ずつ支払いたいときに使います。「一緒でお願いします」は、まとめて支払うときの表現です。また、現金で払う場合は「現金でお願いします」、カードで払う場合は「カードでお願いします」と伝えると安心です。',
    'When paying in Japan, knowing a few short phrases can make the process smoother. “Betsubetsu de onegai shimasu” means you want to pay separately. “Issho de onegai shimasu” means you want to pay together. If you are paying with cash, you can say “Genkin de onegai shimasu,” and if you are paying by card, you can say “Card de onegai shimasu.”',
    '日常生活'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '日本においてのチップ',
    'Is Tipping Necessary in Japan?',
    '日本では、飲食店やタクシーなどでチップを渡す習慣はほとんどありません。よいサービスを受けても、料金に含まれていると考えられるため、追加でお金を渡さなくても失礼にはなりません。むしろ、相手が戸惑ってしまう場合もあるため、基本的には表示された金額だけを支払えば大丈夫です。',
    'In Japan, tipping is usually not necessary at restaurants, taxis, or other services. Even if you receive good service, it is considered to be included in the price, so it is not rude to pay only the listed amount. In fact, giving a tip may sometimes confuse the staff. In most cases, you only need to pay the amount shown.',
    '日常生活'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '引っ越しのあいさつで渡す品物',
    'Gifts for Greeting New Neighbors',
    '日本では、引っ越し後に近所へあいさつをする習慣があります。渡す品物は高価なものでなく、500円〜1,000円程度のタオル、洗剤、お菓子などが一般的です。相手に気を使わせない金額にするのが大切です。特に集合住宅では、両隣や上下の部屋にあいさつしておくと、生活音などのトラブルを防ぎやすくなります。',
    'In Japan, people sometimes greet their neighbors after moving into a new home. The gift does not need to be expensive; towels, detergent, or sweets around 500 to 1,000 yen are common. It is important to choose something small so the other person does not feel uncomfortable. In apartments, greeting the neighbors next door and the rooms above and below can help prevent problems such as noise complaints.',
    '贈り物'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    'お返しの金額はどれくらいが適切？',
    'How Much Should You Spend on a Return Gift?',
    'お祝いをもらった際のお返しは、いただいた金額の「半返し」が基本です。ただし、相手が目上の場合は、あえて少し控えめにすることもあります。食品や日用品など、相手が負担に感じない品物を選ぶと喜ばれます。',
    'Return gifts typically cost about half the value of the gift received. However, when the giver is a superior, choosing a slightly less expensive item may be more appropriate. Practical items such as food or daily necessities are generally well received.',
    '贈り物'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    'プレゼントの予算を決めるコツ',
    'How to Set a Budget for Gifts',
    'プレゼントの予算は、相手との関係性やイベントの重要度によって変わります。友人なら3,000〜5,000円、家族なら5,000〜10,000円が目安です。高すぎると相手に気を遣わせるため、無理のない範囲で選ぶことが大切です。',
    'Gift budgets vary depending on your relationship and the occasion. For friends, 3,000–5,000 yen is typical, while family gifts often range from 5,000–10,000 yen. Avoid overly expensive gifts that may make the recipient uncomfortable.',
    '贈り物'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '経費で落とせるもの・落とせないもの',
    'What Can and Cannot Be Claimed as Business Expenses',
    '経費として認められるのは「業務に必要な支出」です。交通費や備品代は対象ですが、私的な飲食や個人的な買い物は経費にできません。領収書を必ず保管し、用途を明確にしておくとトラブルを防げます。',
    'Business expenses must be directly related to work. Transportation fees and office supplies are eligible, while personal meals or private purchases are not. Keeping receipts and clearly documenting the purpose helps avoid issues.',
    'ビジネス'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    'ビジネスランチの支払いマナー',
    'Payment Etiquette for Business Lunches',
    'ビジネスランチでは、基本的に招待した側が支払います。割り勘は避けたほうがよく、相手に気を遣わせないようスムーズに会計を済ませるのがポイントです。領収書は会社名で発行してもらうと経費処理がしやすくなります。',
    'In business lunches, the person who extended the invitation typically pays. Splitting the bill is generally avoided. Handling the payment smoothly prevents awkwardness. Requesting a receipt under the company name makes expense filing easier.',
    'ビジネス'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '領収書の正しいもらい方',
    'How to Properly Request a Receipt in Business',
    'ビジネスシーンでは、領収書を正しくもらうことが経費処理の基本です。宛名は会社名で記載してもらい、但し書きには「お品代」や「飲食代」など具体的な内容を書いてもらうと後の確認がスムーズです。金額・日付・店名が正しいかその場で確認する習慣をつけると安心です。',
    'In business settings, requesting a proper receipt is essential for expense processing. Ask the store to write your company name as the recipient and specify the purpose, such as “meal expense” or “goods purchased.” Always check the amount, date, and store name on the spot to avoid issues later.',
    'ビジネス'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '結婚式の費用、どこまで親に頼る？',
    'How Much Should Couples Rely on Parents for Wedding Costs?',
    '結婚式の費用は平均300〜400万円と高額で、親からの援助を受けるカップルも多くいます。しかし、援助を受けると「招待客のバランス」や「式の内容」について親の意見が強くなることもあります。金銭的な助けはありがたいものの、夫婦の意向を尊重してもらえるかどうかが重要です。援助を受ける場合は、事前に「どこまで口を出すか」を話し合っておくとトラブルを防げます。',
    'Weddings in Japan often cost 3–4 million yen, leading many couples to accept financial help from parents. However, parental contributions sometimes come with expectations regarding guest lists or ceremony details. While financial support is helpful, maintaining the couple’s autonomy is essential. Discussing boundaries beforehand prevents misunderstandings.',
    '恋愛・結婚'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '同棲カップルの家計管理ルール',
    'Money Rules for Couples Living Together',
    '同棲では、家賃や光熱費の分担方法を明確にしておくことが大切です。収入に応じて割合を決めたり、共通口座を作って管理する方法があります。曖昧にするとトラブルの原因になるため、最初に話し合っておくと安心です。',
    'For couples living together, it is important to clearly decide how to split rent and utilities. Some divide costs based on income ratios, while others use a shared bank account. Discussing these matters early helps prevent future conflicts.',
    '恋愛・結婚'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '婚約指輪の平均価格と選び方',
    'Average Cost and Tips for Choosing an Engagement Ring',
    '婚約指輪の平均価格は20〜40万円と言われています。ダイヤの大きさだけでなく、カットや透明度も価格に影響します。相手の好みを事前にリサーチし、無理のない予算で選ぶことが大切です。',
    'Engagement rings in Japan typically cost between 200,000 and 400,000 yen. The price depends not only on the size of the diamond but also on its cut and clarity. Knowing your partner’s preferences and choosing within your budget is key.',
    '恋愛・結婚'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '子供のお小遣い、いくらが適切か',
    'How Much Allowance Should Children Receive?',
    'お小遣いの金額は、子どもの年齢や家庭の方針によって大きく異なります。小学生なら月500〜1,000円、中学生なら2,000〜3,000円が一般的ですが、金額そのものよりも「お金の使い方を学ぶ機会」にすることが重要です。例えば、お小遣い帳をつけさせたり、欲しいものがあるときは計画的に貯金させたりすることで、自然と金銭感覚が身につきます。お小遣いは単なる支給ではなく、将来の自立につながる教育の一環として活用できます。',
    'Allowance amounts vary by age and family policy. While typical ranges are 500–1,000 yen for elementary students and 2,000–3,000 yen for middle schoolers, the real value lies in teaching money management. Encouraging children to keep a spending log or save for desired items helps them develop financial awareness. Allowances can serve as a practical tool for fostering independence.',
    '家庭・親戚'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '親戚づきあいにかかる意外な出費',
    'Unexpected Costs of Maintaining Family Relationships',
    '親戚との付き合いには、冠婚葬祭のご祝儀や香典、季節の贈り物、帰省時の手土産など、思っている以上に多くの出費が発生します。特に親族が多い家庭では、1年間で数万円から十数万円に達することも珍しくありません。突然の訃報や急な集まりがあると、予想外の出費が重なり、家計に負担がかかることもあります。こうした支出は避けにくいため、あらかじめ「親戚関連費」として年間予算を設定しておくと安心です。家計簿に専用の項目を作り、使った金額をその都度記録しておくことで、どの時期にどれくらいの出費が発生しやすいかが見えてきます。',
    'Maintaining relationships with relatives often involves more expenses than expected—wedding gifts, condolence money, seasonal presents, and souvenirs when visiting family. For households with many relatives, these costs can easily reach tens of thousands of yen annually. Sudden events, such as funerals or unexpected gatherings, can also create financial strain. Since these expenses are difficult to avoid, setting an annual budget specifically for “family-related costs” can provide peace of mind. By creating a dedicated category in your household ledger and recording each expense, you can identify patterns and anticipate high-cost periods.',
    '家庭・親戚'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '子どもの教育費の準備時期',
    'When Should Parents Start Saving for Education?',
    '子どもの教育費は、大学まで進む場合1,000万円以上かかることもあります。そのため、早めに準備を始めるほど負担が軽くなります。毎月少額でも積み立てておくと、長期間で大きな金額になります。学資保険や積立預金など、家庭に合った方法を選ぶことが大切です。',
    'Education costs can exceed 10 million yen if a child attends university. Starting early reduces the financial burden. Even small monthly savings accumulate significantly over time. Options like education insurance or savings plans help families prepare effectively.',
    '家庭・親戚'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '5円玉と50円玉に穴がある理由',
    'Why Do the 5-Yen and 50-Yen Coins Have Holes?',
    '日本の硬貨の中で穴が空いているのは5円玉と50円玉の2種類です。どちらも穴が空いている理由には、複数の背景があります。まず、穴を開けることで金属の使用量を減らし、製造コストを抑えるという実用的な目的があります。特に戦後の物資不足の時代には、少しでも材料を節約する工夫が求められていました。また、穴があることで触っただけで識別しやすくなり、視覚障害のある人にとっても判別しやすいというメリットがあります。5円玉は「ご縁」と語呂が良く、縁起の良い硬貨として神社のお賽銭に使われることも多く、文化的な意味合いも強い硬貨です。一方、50円玉はかつて100円玉と形状が似ていたため、識別しやすくする目的で穴が追加されました。つまり、5円玉と50円玉の穴は、コスト削減・識別性・文化的背景が組み合わさって生まれた、日本ならではのデザインといえます。',
    'In Japan, two coins have holes: the 5-yen coin and the 50-yen coin. The holes serve several purposes. First, they reduce the amount of metal needed, lowering production costs—an important factor in the postwar era when resources were limited. The holes also make the coins easier to identify by touch, which benefits visually impaired individuals. The 5-yen coin carries cultural significance as well, since “go-en” sounds like “good fortune” or “connection,” making it a popular offering at shrines. The 50-yen coin originally resembled the 100-yen coin, so a hole was added to improve distinguishability. In short, the holes in these coins reflect a blend of practicality, accessibility, and cultural meaning unique to Japan.',
    '雑学'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '日本のお札の肖像画が決まる仕組み',
    'How Portraits on Japanese Banknotes Are Chosen',
    '日本のお札に描かれる人物は、文化的・歴史的に大きな功績を残した人物から選ばれます。財務省と日本銀行が候補を検討し、偽造防止の観点からも「特徴的な顔立ち」であることが重視されます。また、著作権の問題がない人物であることも条件のひとつです。新紙幣の発行は数十年に一度で、社会の変化に合わせて見直されます。',
    'Portraits on Japanese banknotes are chosen from individuals who have made significant cultural or historical contributions. The Ministry of Finance and the Bank of Japan review candidates, prioritizing those with distinctive facial features to aid anti-counterfeiting. The person must also be free of copyright issues. New banknote designs are updated only once every few decades to reflect societal changes.',
    '雑学'
);

INSERT INTO columns (
    title_ja,
    title_en,
    column_ja,
    column_en,
    category
) VALUES
(
    '硬貨の素材が時代とともに変わる理由',
    'Why Coin Materials Change Over Time',
    '日本の硬貨は、時代の経済状況や金属価格の変動に合わせて素材が変更されることがあります。例えば、5円玉は戦後の物資不足を背景に黄銅が採用されました。500円玉は偽造防止のために素材や構造が何度も見直されています。硬貨の素材は、コスト・耐久性・偽造対策のバランスで決められています。',
    'The materials used for Japanese coins change depending on economic conditions and metal prices. For example, the 5-yen coin adopted brass after World War II due to material shortages. The 500-yen coin has undergone multiple redesigns to prevent counterfeiting. Coin materials are chosen based on cost, durability, and security considerations.',
    '雑学'
);

 

