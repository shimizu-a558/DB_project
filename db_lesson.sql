Q1
CREATE TABLE `departments`(    
`department_id` INT AUTO_INCREMENT PRIMARY KEY,
`name` varchar(225) NOt NUll,
`created_at` timestamp NOt NUll DEFAULT CURRENT_TIMESTAMP,
`updated_at` timestamp NOt NUll DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

Q2
ALTER TABLE people add department_id INT unsigned AFTER `email`;

Q3追加する部署一覧(departments)
INSERT INTO `departments` (name,)
VALUES
('営業'),
('開発'),
('経理'),
('人事'),
('情報システム');

追加する人の条件(people)
INSERT INTO `people` (`name`, `email`, `department_id`, `age`, `gender`)
VALUES
('佐藤 健一', 'sato@beyond-works.co.jp', 1, 29, 1),
('高橋 美咲', 'takahashi@beyond-works.co.jp', 1, 31, 2),
('伊藤 翔太', 'ito@beyond-works.co.jp', 1, 27, 1),
('渡辺 結衣', 'watanabe@beyond-works.co.jp', 2, 26, 2),
('山本 大輔', 'yamamoto@beyond-works.co.jp', 2, 33, 1),
('中村 彩花', 'nakamura@beyond-works.co.jp', 2, 28, 2),
('小林 誠', 'kobayashi@beyond-works.co.jp', 2, 37, 1),
('加藤 陽子', 'kato@beyond-works.co.jp', 3, 40, 2),
('吉田 拓海', 'yoshida@beyond-works.co.jp', 4, 30, 1),
('山田 麻衣', 'yamada@beyond-works.co.jp', 5, 35, 2
);


INSERT INTO `reports` (`person_id`, `content`) 
VALUES
(11, '新規開拓リストを作成し、見込み顧客10社へ架電を行いました。'),
(12, '既存顧客のフォローアップ訪問を行い、追加プランの提案をしました。'),
(13, 'ユーザー認証周りのリファクタリングとコードレビューを実施しました。'),
(14, 'APIのレスポンス速度改善に向けた負荷テストを実施しました。'),
(15, '月次決算の仕訳データ確認と請求書の発行業務を行いました。'),
(16, '来週の商談に向けたプレゼン資料の作成とデモ環境の準備をしました。'),
(1, '展示会出展に向けたパンフレットの修正依頼と見積もり確認を行いました。'),
(2, '社内管理ツールのUI改善案を作成し、デザインレビューを行いました。'),
(3, '新機能開発の要件定義書をまとめ、関係部署とのすり合わせを行いました。'),
(4, '本番データベースのバックアップ設定の見直しと定期点検を実施しました。');


Q4
SELECT * FROM `people` WHERE `person_id` BETWEEN 1 AND 6;

UPDATE `people` SET `department_id` = 1 WHERE `person_id` = 1;
UPDATE `people` SET `department_id` = 1 WHERE `person_id` = 2;
UPDATE `people` SET `department_id` = 2 WHERE `person_id` = 3;
UPDATE `people` SET `department_id` = 2 WHERE `person_id` = 4;
UPDATE `people` SET `department_id` = 3 WHERE `person_id` = 6;

Q5
SELECT DISTINCT `age`, `gender`, `name` FROM people WHERE gender = 1 ORDER BY age DESC;

メモ
DISTINCT＝重複をまとめる
SELECT * FROM people WHERE gender = 1;
ORDER BY age DESC;

Q6
SELECT
  `name`, `email`, `age`
「name」「email」「age」で振り分けられている上で、このカラムたちを選んでいる状態。

FROM
  `people`
「people」テーブルに所属していることを指す。

WHERE
  `department_id` = 1
カラムの部署IDで、１番の「営業」を振り分けられているものを指定。この1はレコードに反映される。
ORDER BY
  `created_at`;
レコードがいつ作成された登録日時を記録するカラム。

Q7
SELECT `age`, `gender`, `name` FROM people
WHERE (gender = 2 AND age BETWEEN 20 AND 29) 
OR (gender = 1 AND age BETWEEN 40 AND 49
);

メモ
SELECT `name` FROM people WHERE gender = 2 AND age BETWEEN 20 AND 29;
SELECT `name` FROM people WHERE gender = 1 AND age BETWEEN 40 AND 49;
Q8
SELECT * FROM people WHERE department_id = 1 ORDER BY age DESC;

Q9
SELECT AVG(age) AS average_age FROM people WHERE gender = 2 AND department_id = 2;

メモ
SELECT AVG(age) AS average_age FROM people GROUP BY gender;
A. 29.3333 

Q10
SELECT p.name, d.name, r.content FROM people p INNER JOIN departments d USING (department_id) INNER JOIN reports r USING (person_id);

メモ
外部結合
SELECT p.person_id, p.name, r.content FROM people p LEFT OUTER JOIN reports r USING (person_id);
片方だけT
LEFT OUTER JOIN
両方T
INNER JOIN
単体英字
P＝people r=reports d=department

Q11
SELECT p.name FROM people p LEFT OUTER JOIN reports r USING (person_id) WHERE r. report_id is NUll;