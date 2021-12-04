-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 29, 2021 at 05:15 PM
-- Server version: 8.0.17
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `moviedd`
--

-- --------------------------------------------------------

--
-- Table structure for table `ads`
--

CREATE TABLE `ads` (
  `at_id` int(11) NOT NULL,
  `at_title` text NOT NULL,
  `at_folder` text NOT NULL,
  `at_weight` int(11) NOT NULL,
  `at_target` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `at_timestamp` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ads`
--

INSERT INTO `ads` (`at_id`, `at_title`, `at_folder`, `at_weight`, `at_target`, `status`, `at_timestamp`) VALUES
(1, 'หวยเปลี่ยนโลก', 'a001', 100, 'www.finnbet.com', 0, '2147483647'),
(2, 'สล็อตเปลี่ยนชีวิต', 'a002', 0, 'www.google.com', 1, '214783467'),
(3, 'twitter', 'a003', 40, 'wwww.twitter.com', 1, '821478375'),
(4, 'facebook', 'a005', 80, 'wwww.facebook.com', 1, '214748330'),
(5, 'google', 'a007', 40, 'www.google.com', 1, ''),
(6, 'instagram', 'a009', 100, 'www.instagram.com', 0, ''),
(7, 'smile', 'a010', 50, 'www.smile.com', 1, ''),
(8, 'ดูดวง', 'a011', 20, 'www.horoscope.com', 1, ''),
(9, 'ดูดวงxx', 'a013', 20, 'www.sad.com', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `orderid` int(11) NOT NULL,
  `catname` text NOT NULL,
  `movie` int(11) NOT NULL DEFAULT '0',
  `series` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `orderid`, `catname`, `movie`, `series`, `status`) VALUES
(1, 800, 'ดราม่า', 0, 0, 1),
(2, 3000, 'แอคชั่น', 0, 0, 1),
(3, 2200, 'สารคดี', 0, 0, 1),
(4, 200, 'เกาหลี', 0, 0, 1),
(713, 100, 'การ์ตูน', 0, 0, 1),
(714, 300, 'ครอบครัว', 0, 0, 1),
(716, 500, 'ซุปเปอร์ฮีโร่', 0, 0, 1),
(717, 900, 'ตลก', 1, 0, 1),
(718, 1000, 'ไทย', 1, 0, 1),
(719, 1100, 'ประวัติศาสตร์', 1, 0, 1),
(721, 1500, 'ยอดนิยม', 0, 0, 1),
(722, 1600, 'ระทึกขวัญ', 0, 0, 1),
(723, 1700, 'รายการโชว์', 0, 0, 1),
(724, 1900, 'ลึกลับ', 0, 0, 1),
(725, 400, 'จีน', 0, 0, 1),
(726, 600, 'ไซไฟ', 0, 0, 1),
(727, 700, 'ญี่ปุ่น', 0, 0, 1),
(728, 1200, 'ผจญภัย', 0, 0, 1),
(729, 1300, 'เพลง', 0, 0, 1),
(730, 1400, 'แฟนตาซี', 0, 0, 1),
(731, 1800, 'โรแมนติก', 0, 0, 1),
(732, 2000, 'สงคราม', 0, 0, 1),
(733, 2100, 'สยองขวัญ', 0, 0, 1),
(734, 2300, 'หนังรางวัล', 0, 0, 1),
(735, 2400, 'อาชญากรรม', 0, 0, 1),
(736, 2500, 'อินเดีย', 0, 0, 1),
(737, 2600, 'อีโรติก', 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `deletedmovie`
--

CREATE TABLE `deletedmovie` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `movieCode` text NOT NULL,
  `type` int(11) NOT NULL COMMENT '1=thaisound/2=thaisub',
  `month` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0=undeleted / 1 = deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `deletedmovie`
--

INSERT INTO `deletedmovie` (`id`, `title`, `movieCode`, `type`, `month`, `year`, `status`) VALUES
(13, 'EST2', 'dadqwda', 1, 11, 2021, 1);

-- --------------------------------------------------------

--
-- Table structure for table `episode`
--

CREATE TABLE `episode` (
  `id` int(11) NOT NULL,
  `seriesid` int(11) NOT NULL,
  `seasonid` int(11) NOT NULL,
  `name` text NOT NULL,
  `durationHour` int(11) NOT NULL,
  `durationMin` int(11) NOT NULL,
  `movieCodeEng` text NOT NULL,
  `movieCodeTh` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `id` int(11) NOT NULL,
  `nameEng` text NOT NULL,
  `nameTh` text NOT NULL,
  `poster` int(11) NOT NULL DEFAULT '0' COMMENT '0=ไม่มี poster / 1=มี poster',
  `year` int(11) NOT NULL,
  `mparate` text NOT NULL,
  `durationHour` int(11) NOT NULL,
  `durationMin` int(11) NOT NULL,
  `type` text NOT NULL,
  `synopsis` longtext NOT NULL,
  `alertThaiSound` int(11) NOT NULL DEFAULT '0',
  `alertThaiSub` int(11) NOT NULL DEFAULT '0',
  `movieCodeEng` text NOT NULL,
  `movieCodeTh` text NOT NULL,
  `trailerCode` text NOT NULL,
  `netflix` int(11) NOT NULL DEFAULT '0',
  `disney` int(11) NOT NULL DEFAULT '0',
  `amazon` int(11) NOT NULL DEFAULT '0',
  `hbo` int(11) NOT NULL DEFAULT '0',
  `promotion` int(11) NOT NULL DEFAULT '0' COMMENT '0=ไม่มี promotion / 1=มี promotion',
  `promotionMobilePic` int(11) NOT NULL DEFAULT '0' COMMENT '0=ไม่มีรูปภาพ mobile / 1 = รูปภาพ mobile',
  `promotionTabletPic` int(11) NOT NULL DEFAULT '0' COMMENT '0=ไม่มีรูปภาพ tablet / 1 = รูปภาพ tablet',
  `promotionPCPic` int(11) NOT NULL DEFAULT '0' COMMENT '0=ไม่มีรูปภาพ PC / 1 = มีรูปภาพ PC',
  `new` int(11) NOT NULL COMMENT '0=ไม่มี new / 1 = new',
  `expireddate` text,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0=offline / 1 = online',
  `timestamp` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`id`, `nameEng`, `nameTh`, `poster`, `year`, `mparate`, `durationHour`, `durationMin`, `type`, `synopsis`, `alertThaiSound`, `alertThaiSub`, `movieCodeEng`, `movieCodeTh`, `trailerCode`, `netflix`, `disney`, `amazon`, `hbo`, `promotion`, `promotionMobilePic`, `promotionTabletPic`, `promotionPCPic`, `new`, `expireddate`, `status`, `timestamp`) VALUES
(44, 'Test1', '', 1, 2011, 'G', 0, 45, '[717],[718],[719]', '', 0, 0, 'FSEQQ', 'FSDSFS', 'DSDAD', 0, 1, 0, 0, 1, 1, 1, 1, 1, NULL, 1, 1635840167000);

-- --------------------------------------------------------

--
-- Table structure for table `problem`
--

CREATE TABLE `problem` (
  `id` int(11) NOT NULL,
  `orderid` int(11) NOT NULL,
  `problem` text NOT NULL,
  `movie` int(11) NOT NULL,
  `series` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `problem`
--

INSERT INTO `problem` (`id`, `orderid`, `problem`, `movie`, `series`) VALUES
(1, 100, 'หนังดูไม่ได้', 1, 1),
(2, 200, 'ไม่มีเสียง/เสียงไม่ตรง', 1, 1),
(3, 300, 'ภาพกระตุก/ไม่ชัด', 1, 1),
(4, 50, 'ตอนไม่ครบ', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `reportbroblemseriesetc`
--

CREATE TABLE `reportbroblemseriesetc` (
  `id` int(11) NOT NULL,
  `seriesid` int(11) NOT NULL,
  `seasonid` int(11) NOT NULL,
  `episodeid` int(11) NOT NULL,
  `topic` text NOT NULL,
  `sloved` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `reportproblemmovie`
--

CREATE TABLE `reportproblemmovie` (
  `id` int(11) NOT NULL,
  `problemid` int(11) NOT NULL,
  `movieid` int(11) NOT NULL,
  `type` int(11) NOT NULL COMMENT '1=Thai sound / 2 =Thai sub',
  `userid` int(11) NOT NULL,
  `solved` int(11) NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reportproblemmovie`
--

INSERT INTO `reportproblemmovie` (`id`, `problemid`, `movieid`, `type`, `userid`, `solved`, `timestamp`) VALUES
(7, 1, 44, 1, 11, 1, '2021-11-23 03:45:39'),
(8, 2, 44, 1, 12, 1, '2021-11-23 03:45:39'),
(9, 2, 44, 2, 25, 1, '2021-11-28 23:02:12'),
(10, 1, 44, 2, 26, 1, '2021-11-28 23:02:12'),
(11, 1, 44, 2, 56, 1, '2021-11-28 23:02:21');

-- --------------------------------------------------------

--
-- Table structure for table `reportproblemmovieetc`
--

CREATE TABLE `reportproblemmovieetc` (
  `id` int(11) NOT NULL,
  `movieid` int(11) NOT NULL,
  `topic` text NOT NULL,
  `type` int(11) NOT NULL COMMENT '1=thai sound / 2 = thai sub',
  `solve` int(11) NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reportproblemmovieetc`
--

INSERT INTO `reportproblemmovieetc` (`id`, `movieid`, `topic`, `type`, `solve`, `timestamp`) VALUES
(1, 44, 'ทดสอบ1', 1, 1, '2021-10-26 05:52:13'),
(2, 44, 'ทดสอบ 2', 1, 1, '2021-10-26 05:52:13'),
(3, 44, 'TEST1', 1, 1, '2021-11-28 07:57:22'),
(5, 44, 'test3', 1, 1, '2021-11-28 07:59:28'),
(6, 44, 'test4', 1, 1, '2021-11-28 07:59:28'),
(7, 44, 'test5', 2, 1, '2021-11-28 07:59:59'),
(8, 44, 'test6', 2, 1, '2021-11-28 07:59:59');

-- --------------------------------------------------------

--
-- Table structure for table `reportproblemseries`
--

CREATE TABLE `reportproblemseries` (
  `id` int(11) NOT NULL,
  `problemid` int(11) NOT NULL,
  `seriesid` int(11) NOT NULL,
  `seasonid` int(11) NOT NULL,
  `episodeid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `solved` int(11) NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `season`
--

CREATE TABLE `season` (
  `id` int(11) NOT NULL,
  `seriesid` int(11) NOT NULL,
  `orderid` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `season`
--

INSERT INTO `season` (`id`, `seriesid`, `orderid`, `name`) VALUES
(1, 3, 100, 'season 1'),
(3, 3, 200, 'season 2'),
(5, 2, 100, 'ภาค 1'),
(6, 2, 200, 'ภาค 2'),
(7, 2, 300, 'ภาค 3'),
(10, 3, 350, 'test'),
(11, 5, 100, 'xxx');

-- --------------------------------------------------------

--
-- Table structure for table `securitycode`
--

CREATE TABLE `securitycode` (
  `id` int(11) NOT NULL,
  `code` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `securitycode`
--

INSERT INTO `securitycode` (`id`, `code`) VALUES
(1, 'Gu2fFdmxATRVokUvOb0hbc6c');

-- --------------------------------------------------------

--
-- Table structure for table `series`
--

CREATE TABLE `series` (
  `id` int(11) NOT NULL,
  `nameEng` text NOT NULL,
  `nameTh` text NOT NULL,
  `year` int(11) NOT NULL,
  `mparate` text NOT NULL,
  `poster` int(11) NOT NULL DEFAULT '0' COMMENT '0=ไม่มี poster/1=มี poster',
  `type` text NOT NULL,
  `synopsis` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `alert` int(11) NOT NULL DEFAULT '0',
  `trailerCode` text NOT NULL,
  `episode` text,
  `netflix` int(11) NOT NULL DEFAULT '0',
  `disney` int(11) NOT NULL DEFAULT '0',
  `amazon` int(11) NOT NULL DEFAULT '0',
  `hbo` int(11) NOT NULL DEFAULT '0',
  `promotion` int(11) NOT NULL DEFAULT '0',
  `promotionMobilePic` int(11) NOT NULL DEFAULT '0',
  `promotionTabletPic` int(11) NOT NULL DEFAULT '0',
  `promotionPCPic` int(11) NOT NULL DEFAULT '0',
  `new` int(11) NOT NULL DEFAULT '0',
  `expireddate` text,
  `status` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `series`
--

INSERT INTO `series` (`id`, `nameEng`, `nameTh`, `year`, `mparate`, `poster`, `type`, `synopsis`, `alert`, `trailerCode`, `episode`, `netflix`, `disney`, `amazon`, `hbo`, `promotion`, `promotionMobilePic`, `promotionTabletPic`, `promotionPCPic`, `new`, `expireddate`, `status`, `timestamp`) VALUES
(2, 'test1', 'ทดสอบ1', 2022, 'PG-13', 1, '[719],[717],[1],[732]', 'tesdf ad dsad dasd da dadadas dasdas ', 0, 'Rsdac', '12,16,14', 0, 1, 1, 1, 0, 0, 0, 0, 0, NULL, 0, 1634711068),
(3, 'test2', 'ทดสอบ2', 2999, 'R', 0, '[719],[717],[727],[732]', 'xx', 0, 'dsdaas', NULL, 0, 1, 1, 0, 0, 0, 0, 0, 0, NULL, 0, 1634712812),
(4, 'test3', 'ทดสอบ3', 2544, 'PG-13', 1, '[719],[717],[727],[716]', 'xde', 0, 'dasdas', NULL, 0, 0, 1, 0, 0, 0, 0, 0, 1, NULL, 0, 1634712931),
(5, 'Test', 'ทดสอบ', 2055, 'PG-13', 1, '[2],[737],[736],[735]', 'xxxx', 0, '5256dad', NULL, 0, 0, 1, 1, 0, 0, 0, 0, 0, NULL, 0, 1634723600),
(6, 'test7', 'ทดสอบ 7', 2011, 'G', 1, '[717],[719],[723],[731]', 'ทดสอบระบบ 7', 0, 'XDSFG13', NULL, 0, 1, 1, 0, 0, 0, 0, 0, 1, '6/11/2021', 0, 1634836005);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `status` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `telephone` text NOT NULL,
  `fav` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `status`, `timestamp`, `telephone`, `fav`) VALUES
(11, 'somchai', '6645845', 1, '2021-10-28 05:49:05', '0522554444', '1,3,4,713,716,724,727,729'),
(12, 'prayut', 'yellowshirt', 1, '2021-10-28 05:50:01', '089945956', '727,728,729,730,731'),
(13, 'mooyor', '456789', 1, '2021-10-30 03:44:26', '0975556677', '728,729,730,731'),
(14, 'mooyak', '886644', 2, '2021-10-30 03:45:13', '0925373553', '731,732,733'),
(15, 'Tummanut', '998877', 1, '2021-10-30 03:46:24', '0978798855', '734,721,1,2'),
(17, 'A2', '7788', 1, '2021-10-30 03:47:36', '0789651234', '733,717,718'),
(18, 'A3', '12465', 1, '2021-10-30 03:48:52', '0142563214', '719,713,3'),
(19, 'R1', '1122', 1, '2021-10-30 03:48:52', '0321456987', '723,722,719,719'),
(20, 'R2', '45684', 1, '2021-10-30 03:49:34', '0148529874', '726,728,718,1,2'),
(21, 'T1', '1234', 1, '2021-10-30 03:49:58', '0921453654', '726.725.719'),
(22, 'T2', '123', 1, '2021-10-30 04:02:32', '0551237894', '713,714,718,719'),
(23, 'T3', '123', 1, '2021-10-30 04:02:32', '0874568521', '725,729,732,733'),
(24, 'T3', '77889', 1, '2021-10-30 04:03:52', '0584561234', '721,732,735,734'),
(26, 'E2', '8456', 1, '2021-10-30 04:05:11', '0154237445', '725,726,728,729'),
(27, 'Y1', '44455', 1, '2021-10-30 04:05:11', '08585298745', '731,732,718,717'),
(28, 'F1', '12345', 1, '2021-10-30 04:27:33', '0874568745', '713,714,716,724,725,728'),
(29, 'B1', '12345', 1, '2021-10-30 04:28:05', '0142583214', '723,724,725,726'),
(30, 'B2', '124', 1, '2021-10-30 04:28:56', '0548541245', '728,729,730,731');

-- --------------------------------------------------------

--
-- Table structure for table `usersystem`
--

CREATE TABLE `usersystem` (
  `us_id` int(11) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `us_category` int(11) NOT NULL,
  `us_movie` int(11) NOT NULL,
  `us_series` int(11) NOT NULL,
  `us_ads` int(11) NOT NULL,
  `us_analytic` int(11) NOT NULL,
  `us_user` int(11) NOT NULL,
  `us_admin` int(11) NOT NULL,
  `token` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `usersystem`
--

INSERT INTO `usersystem` (`us_id`, `username`, `password`, `us_category`, `us_movie`, `us_series`, `us_ads`, `us_analytic`, `us_user`, `us_admin`, `token`) VALUES
(1, 'admin', '123456', 1, 1, 1, 1, 1, 1, 1, '5fs4226sa'),
(31, 'art', '123456', 1, 1, 0, 0, 0, 0, 0, 'r4QMRTKsWCl6cYmS97R7'),
(32, 'test1', '1234567x', 1, 0, 0, 0, 0, 0, 0, 'I3wSCov9TRJb0Uj72xAL'),
(33, 'test2', '12223332', 1, 1, 0, 0, 0, 0, 0, 'jvJfnwmBPXaigjeoJljH'),
(34, 'test3', '5556666', 1, 0, 1, 0, 0, 0, 0, 'GEEqMHdkFF1YqZjTkCCK'),
(35, 'test4', '555666', 1, 0, 1, 1, 0, 0, 0, 'mhvgLPfLtNef6xvtHkpv'),
(36, 'test5', '55666w', 0, 0, 0, 0, 0, 1, 1, 'xrI1RbxrKcAL9yyOJnyc'),
(37, 'test6', '12345w', 1, 0, 0, 0, 0, 0, 0, 'SqjlVtMU7msjy3LofZ16'),
(38, 'test7', '2123dsad', 0, 1, 1, 0, 0, 0, 0, 'RORToMtwCZwyoXpAaVYT'),
(39, 'test8', '9998888', 0, 0, 0, 0, 1, 1, 1, 'WEYcol3u20Ejn6EU7vKb'),
(40, 'test9', '77888899', 0, 1, 1, 1, 0, 0, 0, '6Xa8XHSTWYfRQ1HwmjiS'),
(41, 'test10', 'xcasdad', 0, 0, 0, 0, 1, 1, 0, 'sjveGDh2MOQu6zBrSUUb');

-- --------------------------------------------------------

--
-- Table structure for table `viewads`
--

CREATE TABLE `viewads` (
  `id` int(11) NOT NULL,
  `adsid` int(11) NOT NULL,
  `devicetype` int(11) NOT NULL COMMENT '0=mobile/1=tablet/2=pc',
  `week` int(11) NOT NULL,
  `view` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `viewmovie`
--

CREATE TABLE `viewmovie` (
  `id` int(11) NOT NULL,
  `movieid` int(11) NOT NULL,
  `week` int(11) NOT NULL,
  `view` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `viewmovie`
--

INSERT INTO `viewmovie` (`id`, `movieid`, `week`, `view`) VALUES
(1, 16, 1, 200),
(2, 16, 2, 150),
(3, 16, 3, 300),
(4, 16, 4, 150),
(5, 16, 6, 180),
(6, 16, 7, 200),
(7, 17, 7, 250);

-- --------------------------------------------------------

--
-- Table structure for table `viewmovietotal`
--

CREATE TABLE `viewmovietotal` (
  `id` int(11) NOT NULL,
  `movieid` int(11) NOT NULL,
  `view` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `viewmovietotal`
--

INSERT INTO `viewmovietotal` (`id`, `movieid`, `view`) VALUES
(1, 16, 200),
(2, 17, 150),
(3, 18, 30),
(4, 19, 50);

-- --------------------------------------------------------

--
-- Table structure for table `viewseries`
--

CREATE TABLE `viewseries` (
  `id` int(11) NOT NULL,
  `seriesid` int(11) NOT NULL,
  `seasonid` int(11) NOT NULL,
  `episodeid` int(11) NOT NULL,
  `week` int(11) NOT NULL,
  `view` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `viewuser`
--

CREATE TABLE `viewuser` (
  `id` int(11) NOT NULL,
  `week` int(11) NOT NULL,
  `member` int(11) NOT NULL,
  `totalmember` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `viewuser`
--

INSERT INTO `viewuser` (`id`, `week`, `member`, `totalmember`) VALUES
(1, 1, 150, 150),
(2, 2, 200, 350),
(3, 3, 300, 650),
(4, 4, 150, 800),
(5, 5, 200, 1000),
(6, 7, 150, 1150);

-- --------------------------------------------------------

--
-- Table structure for table `viewuserstreaming`
--

CREATE TABLE `viewuserstreaming` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `view` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `viewuserstreaming`
--

INSERT INTO `viewuserstreaming` (`id`, `userid`, `year`, `month`, `view`) VALUES
(1, 11, 2021, 10, 32),
(2, 11, 2021, 9, 50),
(3, 11, 2021, 7, 400),
(4, 11, 2021, 6, 50),
(5, 12, 2021, 9, 300);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ads`
--
ALTER TABLE `ads`
  ADD PRIMARY KEY (`at_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deletedmovie`
--
ALTER TABLE `deletedmovie`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `episode`
--
ALTER TABLE `episode`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `problem`
--
ALTER TABLE `problem`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reportbroblemseriesetc`
--
ALTER TABLE `reportbroblemseriesetc`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reportproblemmovie`
--
ALTER TABLE `reportproblemmovie`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reportproblemmovieetc`
--
ALTER TABLE `reportproblemmovieetc`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reportproblemseries`
--
ALTER TABLE `reportproblemseries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `season`
--
ALTER TABLE `season`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `series`
--
ALTER TABLE `series`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usersystem`
--
ALTER TABLE `usersystem`
  ADD PRIMARY KEY (`us_id`);

--
-- Indexes for table `viewads`
--
ALTER TABLE `viewads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `viewmovie`
--
ALTER TABLE `viewmovie`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `viewmovietotal`
--
ALTER TABLE `viewmovietotal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `viewseries`
--
ALTER TABLE `viewseries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `viewuser`
--
ALTER TABLE `viewuser`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `viewuserstreaming`
--
ALTER TABLE `viewuserstreaming`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ads`
--
ALTER TABLE `ads`
  MODIFY `at_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=739;

--
-- AUTO_INCREMENT for table `deletedmovie`
--
ALTER TABLE `deletedmovie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `episode`
--
ALTER TABLE `episode`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `movie`
--
ALTER TABLE `movie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `problem`
--
ALTER TABLE `problem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reportbroblemseriesetc`
--
ALTER TABLE `reportbroblemseriesetc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reportproblemmovie`
--
ALTER TABLE `reportproblemmovie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `reportproblemmovieetc`
--
ALTER TABLE `reportproblemmovieetc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `reportproblemseries`
--
ALTER TABLE `reportproblemseries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `season`
--
ALTER TABLE `season`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `series`
--
ALTER TABLE `series`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `usersystem`
--
ALTER TABLE `usersystem`
  MODIFY `us_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `viewads`
--
ALTER TABLE `viewads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `viewmovie`
--
ALTER TABLE `viewmovie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `viewmovietotal`
--
ALTER TABLE `viewmovietotal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `viewseries`
--
ALTER TABLE `viewseries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `viewuser`
--
ALTER TABLE `viewuser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `viewuserstreaming`
--
ALTER TABLE `viewuserstreaming`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;