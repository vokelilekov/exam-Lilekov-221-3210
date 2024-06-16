-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: std-mysql    Database: std_2472_exam
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('00a4f8f5ab10');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_genre`
--

DROP TABLE IF EXISTS `book_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_genre` (
  `book_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`book_id`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `book_genre_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `book_genre_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_genre`
--

LOCK TABLES `book_genre` WRITE;
/*!40000 ALTER TABLE `book_genre` DISABLE KEYS */;
INSERT INTO `book_genre` VALUES (13,1),(16,1),(17,1),(18,1),(20,1),(17,2),(19,2),(20,2),(22,2),(23,2),(24,2),(25,2),(13,4),(16,4),(13,5),(21,5),(18,6),(21,6),(19,7);
/*!40000 ALTER TABLE `book_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `year` int(11) NOT NULL,
  `publisher` varchar(200) NOT NULL,
  `author` varchar(200) NOT NULL,
  `pages` int(11) NOT NULL,
  `cover_id` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cover_id` (`cover_id`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`cover_id`) REFERENCES `covers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (13,'Игра престолов','Перед вами — величественное шестикнижие \"***Песнь льда и огня***\". Эпическая, чеканная сага о мире Семи Королевств. О мире суровых земель вечного холода и радостных земель вечного лета. Мире лордов и героев, воинов и магов, чернокнижников и убийц — всех, кого свела воедино Судьба во исполнение древнего пророчества. О мире опасных приключений, великих деяний и тончайших политических интриг.',1999,'АСТ','Мартин Джордж Р.Р.',600,'713f9bb5-ebd8-4b06-bfdc-7a3414ec521d'),(16,'451 градус по Фаренгейту','**451° по Фаренгейту** — температура, при которой воспламеняется и горит бумага. Философская антиутопия Брэдбери рисует беспросветную картину развития постиндустриального общества: это мир будущего, в котором все письменные издания безжалостно уничтожаются специальным отрядом пожарных, а хранение книг преследуется по закону, интерактивное телевидение успешно служит всеобщему оболваниванию, карательная психиатрия решительно разбирается с редкими инакомыслящими, а на охоту за неисправимыми диссидентами выходит электрический пес…\nРоман, принесший своему творцу мировую известность.\nСенсационным было заявление Брэдбери в 2007 году, что «451° по Фаренгейту» понимают неправильно. Эта книга не о правительственной цензуре, это история о том, как телевидение уничтожает интерес к чтению книг.\nВ начале 1950-х большинство американцев в глаза не видело телевизора, однако Брэдбери предсказал наступление новой эры свободы, достатка и развлечений, когда желание быть счастливым, помноженное на политкорректность, приведет к запрету книг.\n«Телевизор говорит вам, о чем надлежит думать, и вколачивает это вам в голову. Он всегда и обязательно прав».',1953,'Эксмо','Рэй Брэдбери',320,'735df627-291a-40f7-a421-154b35d06368'),(17,'Цветы для Элджернона','Когда-то это считалось фантастикой.\nСейчас это воспринимается как одно из самых человечных произведений новейшего времени, как роман пронзительной психологической силы, как филигранное развитие темы любви и ответственности.\nИзменения с Чарли Гордоном происходят на наших глазах, здесь и сейчас. В первых отчетах полно орфографических ошибок, ему очень трудно излагать свои мысли, постепенно он начинает писать правильно и рассказывать о событиях идеально.\nГении и идиоты — две стороны одной медали. У них разные IQ, отличаются условия жизни, но они похожи в одном — часто и те, и другие бесконечно одиноки. А цена за мечту — стать умным — становится слишком высокой.\nУ Чарли есть двойник — мышонок Элджернон, только Чарли понимает поведение мышонка и то, что ему самому отведена та же роль подопытной мыши, не больше.\nРоман неоднократно экранизировали в разных странах, в 1968 году в США был снят фильм «Чарли», а актер Клифф Робертсон награжден «Оскаром», в 2006-м был снят фильм во Франции, в 2007 году в Александринском театре был поставлен спектакль по одноименному рассказу, в 2015 году вышел фильм в Японии, и в том же году поставлен спектакль в «Таком театре» «Эффект Чарли Гордона», режиссеры Игорь Сергеев, Варя Светлова.\n*Никого не оставляет равнодушным.*',1959,'Эксмо','Дэниел Киз',320,'94226038-33bf-4d78-a42a-d206be3eb287'),(18,'Мобильник','*Стивен Кинг…*\n\"Король ужасов\"? Да. Непревзойденный мастер проникновения в самые тайные, самые страшные, самые мрачные уголки человеческой души? Да! Жестокий, яростный и агрессивный эстет тьмы, чьи книги пугают и восхищают, возмущают - и все-таки привлекают? О да!!! ...Каждый из нас - только человек, стоящий над черной, адовой бездной собственных страхов. И только Стивен Кинг - **великий Стивен Кинг!** - может заставить нас шагнуть в эту бездну кошмара…\nМобильник…\nОн есть у каждого - у мужчин и женщин, у стариков и детей.\nНо - что, если однажды чья-то злая воля превратит мобильники в источники смерти и ужаса?!\nЕсли десятки тысяч ни в чем не повинных людей в одночасье падут жертвой \"новой чумы\", передающейся через сотовые телефоны?!\nНемногие уцелевшие вступают в битву с кошмаром.\nНо чтобы победить Зло, с ним надо встретиться лицом к лицу!',2006,'АСТ','Стивен Кинг',475,'498ddfe9-74a3-4608-ad6c-115ab96381f9'),(19,'Посторонний','*«Посторонний»* — дебютная работа молодого писателя, своеобразный творческий манифест. Понятие абсолютной свободы — основной постулат этого манифеста. Героя этой повести судят за убийство, которое он совершил по самой глупой из всех возможных причин. И это правда, которую герой не боится бросить в лицо своим судьям, пойти наперекор всему, забыть обо всех условностях и умереть во имя своих убеждений.',1942,'Neoclassic','Альбер Камю',128,'4e47c77b-f7fe-43c1-b292-da881118a66c'),(20,'Мы','Знаковый роман, с которого официально отсчитывают само существование жанра \"антиутопия\" Запрещенный в советский период, теперь он считается одним из классических произведений не только русской, но и мировой литературы ХХ века. Роман об \"обществе равных\", в котором человеческая личность сведена к \"нумеру\". В нем унифицировано все — одежда и квартиры, мысли и чувства. Нет ни семьи, ни прочных привязанностей...\nНо можно ли вытравить из человека жажду свободы, пока он остается человеком?',1924,'Neoclassic','Евгений Замятин',224,'1409078d-395e-49c4-a39b-6b5a1a79bd6c'),(21,'Зов Ктулху','*Дагон*, **Ктулху**, *Йог-Сотот* и многие другие темные божества, придуманные Говардом Лавкрафтом в 1920-е годы, приобрели впоследствии такую популярность, что сотни творцов фантастики, включая Нила Геймана и Стивена Кинга, до сих пор продолжают расширять его мифологию. Каждое монструозное божество в лавкрафтианском пантеоне олицетворяет собой одну из бесчисленных граней хаоса. Таящиеся в глубинах океана или пребывающие в глубине непроходимых лесов, спящие в египетских пирамидах или замурованные в горных пещерах, явившиеся на нашу планету со звезд или из бездны неисчислимых веков, они неизменно враждебны человечеству и неподвластны разуму. И единственное, что остается человеку – это всячески избегать столкновения с этими таинственными существами и держаться настороже…',1928,'АСТ','Говард Лавкрафт',416,'4f406666-f654-4136-96c1-3cbb387fcc87'),(22,'Процесс','Роман, ставший своеобразным символом творчества Франца Кафки. Интересно, что Кафка не оставил никаких подсказок, по которым можно было бы как-то воссоздать фабулу романа. Главы не были пронумерованы и содержались в отдельных конвертах. Йозеф К. — рациональный герой среди абсурдного общества. Его ничем не примечательная, даже в чем-то банальная жизнь шла своим чередом, пока его не известили о том, что против него начат процесс...\nАбсурдность происходящего с К. пугает именно своей приземленной, холодной обыденностью, повседневностью и даже странной логичностью творящегося с героем ужаса, противостоять которому он не в силах.\nГде судья, которого он ни разу не видел? Где высокий суд, куда он так и не попал?\nОн виноват просто потому, что каждый человек в этой жизни может быть в чем-то виноват...\nСтрашная и нелепо смешная атмосфера \"Процесса\" потрясающе точно передана Орсоном Уэллсом в его знаменитой экранизации с Энтони Перкинсом, Жанной Моро и Роми Шнайдер в главных ролях.',1925,'АСТ','Франц Кафка',288,'5356a69c-20e1-4dab-8b02-9bb32a4ceeb6'),(23,'Морфий','В этот сборник вошли произведения Булгакова, носящие автобиографический характер, — остроумная, ироничная повесть \"Записки на манжетах\", посвященная скитаниям по послереволюционному Кавказу, сложным отношениям с \"красной\" властью и собратьями по перу, мечтам об эмиграции и первым опытам в литературе, и потрясающие \"Записки юного врача\" — почти документальные очерки Булгакова о святом и страшном жребии служителя Гиппократа в нищей, почти средневековой российской провинции начала 1920-х. В книгу включен и \"Морфий\" — пугающе откровенная, мучительная исповедь, послужившая основой для одноименного фильма Алексея Балабанова.',1926,'Neoclassic','Михаил Булгаков',256,'1dbf7260-8efb-4533-ac01-a2d3fa7fa368'),(24,'Великий Гэтсби','«Бурные» двадцатые годы прошлого столетия…\nВремя шикарных вечеринок, «сухого закона» и «легких» денег…\nЭти «новые американцы» уверены, что расцвет будет вечным, что достигнув вершин власти и богатства, они обретут и личное счастье…\nТаким был и Джей Гэтсби, ставший жертвой бессмысленной погони за пленительной мечтой об истинной и вечной любви, которой не суждено было сбыться…\nПеред вами — самый знаменитый роман Ф.С. Фицджеральда в новом переводе!',1925,'АСТ','Фрэнсис Скотт Фицджеральд',256,'cbc8d450-f13d-4e72-96cf-1164a5dc4d97'),(25,'Грозовой перевал','Любителям \"страшилок\" просьба обратить внимание: готический роман, неоднократно упоминающийся в вампирской саге \"Сумерки\", и одновременно самая романтическая книга всех времен - \"Грозовой перевал\" Эмили Бронте. Трагедия разворачивается на фоне мрачных вересковых пустошей в \"дьявольской книге, немыслимом чудовище, объединившем все самые сильные женские наклонности…\". .',1847,'Эксмо','Эмили Бронте',416,'50ec9e63-a209-4a6a-bc32-ba515a274b6e');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `covers`
--

DROP TABLE IF EXISTS `covers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `covers` (
  `id` varchar(100) NOT NULL,
  `filename` varchar(200) NOT NULL,
  `mime_type` varchar(50) NOT NULL,
  `md5_hash` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `covers`
--

LOCK TABLES `covers` WRITE;
/*!40000 ALTER TABLE `covers` DISABLE KEYS */;
INSERT INTO `covers` VALUES ('1409078d-395e-49c4-a39b-6b5a1a79bd6c','1409078d-395e-49c4-a39b-6b5a1a79bd6c','image/png','691a92ea9bda3784eeebb7693716ad41'),('1dbf7260-8efb-4533-ac01-a2d3fa7fa368','1dbf7260-8efb-4533-ac01-a2d3fa7fa368','image/png','3b859d92ec3377f44405d4729a90a27b'),('498ddfe9-74a3-4608-ad6c-115ab96381f9','498ddfe9-74a3-4608-ad6c-115ab96381f9','image/png','3d8e27707fff247cb5b8a8133bedefe9'),('4e47c77b-f7fe-43c1-b292-da881118a66c','4e47c77b-f7fe-43c1-b292-da881118a66c.png','image/png','761f293bc37f6657458025bcec69237a'),('4f406666-f654-4136-96c1-3cbb387fcc87','4f406666-f654-4136-96c1-3cbb387fcc87','image/png','99a42fe58d83b60efab953a3d9d0e003'),('50ec9e63-a209-4a6a-bc32-ba515a274b6e','50ec9e63-a209-4a6a-bc32-ba515a274b6e','image/png','1e0b6e398e51e77c3d5e3a2ba5dce068'),('5356a69c-20e1-4dab-8b02-9bb32a4ceeb6','5356a69c-20e1-4dab-8b02-9bb32a4ceeb6','image/png','cc8653f4da6451c62a92070774e9c45f'),('713f9bb5-ebd8-4b06-bfdc-7a3414ec521d','713f9bb5-ebd8-4b06-bfdc-7a3414ec521d.jpg','image/jpeg','5588d5a0f07581d0da6168ff2579d9e4'),('735df627-291a-40f7-a421-154b35d06368','735df627-291a-40f7-a421-154b35d06368.png','image/png','096518d359560eeb6732fb0f7bfd8ea3'),('94226038-33bf-4d78-a42a-d206be3eb287','94226038-33bf-4d78-a42a-d206be3eb287.png','image/png','fd869c24886b51eb82116c56bba4dd3e'),('cbc8d450-f13d-4e72-96cf-1164a5dc4d97','cbc8d450-f13d-4e72-96cf-1164a5dc4d97','image/png','ad5e55a576a31b896e936e23e40ec137');
/*!40000 ALTER TABLE `covers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (3,'Детектив'),(4,'Приключения'),(2,'Роман'),(6,'Ужасы'),(1,'Фантастика'),(7,'Философия'),(5,'Фэнтези');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `book_id` (`book_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (5,16,1,5,'Замечательная книга, замечательная история. Любовь с первого прочтения. *ОБОЖАЮ*','2024-06-16 22:54:51'),(6,18,1,3,'Не самая сильная работа Кинга, но так же затягивает, как и любой его сюжет','2024-06-16 23:21:53'),(7,17,1,4,'Душераздирающая история... настолько, что тяжело читать','2024-06-16 23:22:33'),(8,19,1,5,'Великолепное сочетание философии и художественной литературы... лучшее из подобных произведений','2024-06-16 23:23:08'),(9,21,1,1,'Как-то все слишком аморфно...','2024-06-16 23:23:26'),(10,23,1,0,'Без комментариев...','2024-06-16 23:23:39'),(11,22,1,3,'Неоспоримая классикаЮ, но с нюансами. **Слабейшая** из великой трилогии Кафки','2024-06-16 23:24:12'),(12,24,1,1,'Затянутая нудная история, хоть и мало страниц, но ужасно надоедает','2024-06-16 23:25:00'),(13,20,1,5,'Основоположник жанра антиутопии. Рядом с 1984 и не стоит','2024-06-16 23:25:22'),(14,25,1,2,'Начали за здравие, закончили за упокой...','2024-06-16 23:25:41'),(15,18,2,1,'Бред... опять зомби','2024-06-16 23:26:12'),(16,13,2,5,'Обожаю','2024-06-16 23:26:24'),(17,13,1,3,'Заезженная тема','2024-06-16 23:27:07'),(18,19,2,2,'Ниче не понял','2024-06-16 23:32:08'),(20,13,3,4,'**ОЧЕНЬ** много текста и лишней воды','2024-06-16 23:33:18'),(21,23,3,3,'Нормальное произведение','2024-06-16 23:33:36');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin','Администратор (суперпользователь, имеет полный доступ к системе, в том числе к созданию и удалению книг)'),(2,'Moderator','Модератор (может редактировать данные книг и производить модерацию рецензий)'),(3,'User','Пользователь (может оставлять рецензии)');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(200) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','scrypt:32768:8:1$iVez08uOEWFyFXrI$8ff4dc8af3062a458c5c793a1537925a6606b9ef90c8ea55e8d0a04e6021907d42f20ed33dfc649cc9f239ffd96b271df7e0796b1fb067bf1631945100096322','Лилеков','Вадим','Олегович',1),(2,'moder','scrypt:32768:8:1$PG3yvrFOVdb9lBb5$da1ab365659778cbde1baa941b3dc243c1fd448fb1ce4f949b7ebdfd7675403d41973774c826b9ea51846d0337e96c6142c05491ffa8708d6a1eccc799bd391c','Дубовской','Роман ','Евгеньевич',2),(3,'user','scrypt:32768:8:1$tnzuhAEkosVYaNGW$22a90763a20071023aa465aad65c0426d9c183df3867ee3d61d07cd6d2f58f74ef25112ed7a225b4fb399603546ce3fa13bada9126368ab667ebf3e1ca2a3b81','Игнатов','Игнат','Игнатович',3),(4,'test','scrypt:32768:8:1$IrFwVfqxJHppORcE$28efe3866607037b19bca8bee71e714767367bf76f687a1163ba09e991b407c6f6c30d852a27f728adcefac633240aa67ae45e40173d6213687b07932db6639d','Тестов','Тест','Тестович',3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-17  2:38:56
