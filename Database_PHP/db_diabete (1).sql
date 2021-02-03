-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 23, 2021 at 09:46 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_diabete`
--

-- --------------------------------------------------------

--
-- Table structure for table `activities`
--

CREATE TABLE `activities` (
  `id` int(11) NOT NULL,
  `nameActivity` varchar(100) NOT NULL,
  `indexMET` float NOT NULL,
  `timeActivity` float NOT NULL,
  `tags` varchar(1000) NOT NULL,
  `note` varchar(1000) NOT NULL,
  `measureTime` datetime NOT NULL,
  `calo` float NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `activities`
--

INSERT INTO `activities` (`id`, `nameActivity`, `indexMET`, `timeActivity`, `tags`, `note`, `measureTime`, `calo`, `userID`) VALUES
(30, 'Cử tạ', 3, 80, '[Trước bữa trưa,  Trước bữa tối, Sau bữa tối, Trước bữa tối]', 'test update lần 3', '2020-11-19 00:46:26', 336, 13),
(31, 'Cử tạ', 3, 15, '[Trước hoạt động, Trong lúc hoạt động]', 'test update 4', '2020-11-19 00:50:50', 54.3375, 13),
(32, 'Cầu Lông', 1.2, 15, '', 'test update', '2020-11-19 00:46:26', 6.93, 13),
(35, 'Yoga', 2.5, 5, '[Trước hoạt động, Trong lúc hoạt động]', '', '2020-12-04 23:51:42', 4.8125, 13),
(36, 'Bóng chuyền', 8, 10, '', '', '2020-12-05 12:00:08', 30.8, 13),
(37, 'Cử tạ', 3, 10, '', '', '2020-12-06 12:26:56', 2.625, 13),
(38, 'Dọn dẹp', 3, 25, '', '', '2020-12-06 22:08:32', 6.5625, 13),
(39, 'Chèo thuyền', 3.5, 2, '[Trong lúc hoạt động]', '', '2020-12-16 22:48:00', 0.6125, 13),
(40, 'Cử tạ', 3, 15, '', '', '2021-01-13 21:54:08', 47.25, 13);

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(1000) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `carbs`
--

CREATE TABLE `carbs` (
  `id` int(11) NOT NULL,
  `carb` float NOT NULL,
  `fat` float DEFAULT NULL,
  `protein` float DEFAULT NULL,
  `calo` float DEFAULT NULL,
  `tags` varchar(1000) CHARACTER SET utf8 DEFAULT NULL,
  `note` varchar(10000) CHARACTER SET utf8 DEFAULT NULL,
  `userID` int(11) NOT NULL,
  `measureTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `carbs`
--

INSERT INTO `carbs` (`id`, `carb`, `fat`, `protein`, `calo`, `tags`, `note`, `userID`, `measureTime`) VALUES
(2, 11.3, 15.5, 20, 16, '', 'Ăn xong', 1, '2020-11-16 01:14:52'),
(3, 67, 69, 20, 16, '[Trước bữa ăn, Trước khi ngủ, Trước bữa tối, aaa, Sau khi ngủ, Sau bữa tối, Trước bữa trưa]', 'test update hom nay', 13, '2020-11-19 01:14:52'),
(6, 69, 15, 69, 5, '', '', 13, '2020-11-23 20:36:43'),
(7, 0.5, 0, 0, 0, '', '', 13, '2020-12-06 12:19:19'),
(8, 21.3, 59.3, 17.9, 483, '', 'Phở gà', 13, '2020-12-17 21:03:06'),
(9, 53.8, 13.7, 15.1, 399, '', 'Bánh mì thịt', 13, '2020-12-17 21:12:08'),
(10, 33, 3, 8, 194, '', 'Cháo yến mạch', 13, '2020-12-17 21:30:15'),
(11, 21.3, 59.3, 17.9, 483, '', 'Phở gà', 31, '2020-12-28 13:15:34'),
(12, 5, 2, 2, 2, '', '', 13, '2021-01-13 22:07:10');

-- --------------------------------------------------------

--
-- Table structure for table `foods`
--

CREATE TABLE `foods` (
  `id` int(11) NOT NULL,
  `name` varchar(1000) NOT NULL,
  `amount` int(11) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `calo` float NOT NULL,
  `protein` float NOT NULL,
  `lipid` float NOT NULL,
  `carb` float NOT NULL,
  `cellulose` float NOT NULL,
  `meal` varchar(100) NOT NULL,
  `stateBG` varchar(50) NOT NULL,
  `image` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `foods`
--

INSERT INTO `foods` (`id`, `name`, `amount`, `unit`, `calo`, `protein`, `lipid`, `carb`, `cellulose`, `meal`, `stateBG`, `image`) VALUES
(1, 'Phở gà', 1, 'tô', 483, 17.9, 59.3, 21.3, 2.28, 'breakfast', 'high', 'https://toanhtc.files.wordpress.com/2020/12/mon-pho-ga.jpg'),
(2, 'Há cảo', 6, 'viên', 363, 12.2, 56, 7.4, 0.75, 'breakfast', 'high', 'https://toanhtc.files.wordpress.com/2020/12/mon-ha-cao-tom-thit.jpg'),
(3, 'Bánh mì thịt', 1, 'ổ', 399, 15.1, 13.7, 53.8, 0.59, 'breakfast', 'high', 'https://toanhtc.files.wordpress.com/2020/12/nuoc-sot-banh-mi-kep-thit.jpg'),
(4, 'Bánh canh thịt heo', 1, 'tô', 322, 12.8, 8.5, 48.5, 1, 'breakfast', 'high', 'https://toanhtc.files.wordpress.com/2020/12/banhcanhthitheo.jpg'),
(5, 'Hoành thánh', 1, 'tô', 248, 7.4, 31.7, 12.3, 1.26, 'breakfast', 'high', 'https://toanhtc.files.wordpress.com/2020/12/hoanhtnanh.jpg'),
(6, 'Bánh cuốn', 1, 'đĩa', 590, 25.7, 25.6, 64.3, 1.26, 'breakfast', 'high', 'https://toanhtc.files.wordpress.com/2020/12/banh-cuon-nhan-thit.jpg'),
(7, 'Cháo đậu đỏ', 1, 'chén', 322, 11.8, 43.7, 10.6, 2.42, 'breakfast', 'high', 'https://toanhtc.files.wordpress.com/2020/12/3-cach-nau-chao-dau-do-18-760x367-1.jpg'),
(8, 'Bún bò', 1, 'tô', 479, 18.4, 16, 65.3, 3.3, 'breakfast', 'high', 'https://toanhtc.files.wordpress.com/2020/12/bunbo.jpg?w=1024'),
(9, 'Khoai lang', 1, 'củ', 131, 1.4, 0.3, 30.6, 0.9, 'breakfast', 'high', 'https://toanhtc.files.wordpress.com/2020/12/khoailang.jpg?w=1024'),
(10, 'Bún riêu cua', 1, 'tô', 482, 16.8, 66, 16.5, 3.4, 'breakfast', 'high', 'https://toanhtc.files.wordpress.com/2020/12/bun-rieu-cua.jpg'),
(11, 'Bánh Flan', 1, 'cái', 66, 1.7, 1.6, 11.3, 0.05, 'snack', 'high', 'https://toanhtc.files.wordpress.com/2020/12/flan.jpg'),
(12, 'Bánh quy bơ', 1, 'cái', 38, 0.9, 0.5, 7.5, 0.05, 'snack', 'high', 'https://toanhtc.files.wordpress.com/2020/12/quybo.jpg'),
(13, 'Bắp luộc', 1, 'trái', 192, 4.5, 2.5, 37.8, 1.38, 'snack', 'high', 'https://toanhtc.files.wordpress.com/2020/12/bap.jpg'),
(14, 'Sữa chua', 1, 'hộp', 137, 4, 21.6, 3.8, 0, 'snack', 'high', 'https://dayphache.edu.vn/wp-content/uploads/2018/03/cach-lam-sua-chua-pho-mai-da-lat.jpg'),
(15, 'Bưởi', 1, 'múi', 8, 0, 5.1, 0.1, 0.72, 'snack', 'high', 'https://toanhtc.files.wordpress.com/2020/12/buoi.jpg'),
(16, 'Quýt', 1, 'trái', 28, 0, 6.4, 0.6, 0.44, 'snack', 'high', 'https://toanhtc.files.wordpress.com/2020/12/quyt.jpg'),
(17, 'Mãng cầu xiêm', 1, 'miếng', 40, 1.4, 0, 8.6, 1.52, 'snack', 'high', 'https://toanhtc.files.wordpress.com/2020/12/mang-cau-xiem-c78e7317.jpg'),
(18, 'Vú sữa', 1, 'trái', 83, 2, 0, 18.5, 4.53, 'snack', 'high', 'https://toanhtc.files.wordpress.com/2020/12/qua-vu-sua-2.jpg'),
(19, 'Thanh long', 1, 'trái', 225, 7.3, 0, 49, 10.13, 'snack', 'high', 'https://toanhtc.files.wordpress.com/2020/12/thanh-long-600x600-1.jpg'),
(20, 'Cháo yến mạch', 1, 'tô', 194, 8, 3, 33, 5, 'breakfast', 'high', 'https://toanhtc.files.wordpress.com/2020/12/chao-yen-mach-dinh-duong-600x400-1.jpg'),
(21, 'Cháo bắp mộc nhỉ', 1, 'tô', 116, 5, 1, 25, 3, 'breakfast', 'high', 'https://toanhtc.files.wordpress.com/2020/12/mocnhi.jpg'),
(22, 'Cơm', 1, 'chén', 200, 4, 0, 44, 0, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/com.jpg'),
(23, 'Bún mộc', 1, 'tô', 514, 28, 19, 56, 2, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/bun-suon-moc.jpg'),
(24, 'Mì quảng', 1, 'tô', 541, 22, 20, 67, 2, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/myquang.jpg'),
(25, 'Cháo bí đao', 1, 'tô', 126, 3, 0, 27, 1, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/chaobidao.jpg'),
(26, 'Cháo yến mạch', 1, 'tô', 194, 8, 3, 33, 5, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/chao-yen-mach-dinh-duong-600x400-1.jpg'),
(27, 'Cháo bột bắp', 1, 'tô', 370, 8, 3, 77, 4, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/chao-bot-bap.jpg'),
(28, 'Cháo bắp mộc nhỉ', 1, 'tô', 116, 5, 1, 25, 3, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/mocnhi.jpg'),
(29, 'Thịt kho trứng', 1, 'đĩa', 315, 19, 22, 7, 0, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/thikhotrung.jpg'),
(30, 'Thịt bò xào nấm rơm', 1, 'đĩa', 152, 13, 9, 2, 0, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/boxaonamrom.jpg'),
(31, 'Cá chép chưng tương', 1, 'con', 156, 6.6, 7, 16, 0, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/chachepchungtuong.jpg'),
(32, 'Cá hú kho', 1, 'lát cá', 184, 15, 9, 8, 0, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/ca-hu-ivivu-3.jpg'),
(33, 'Canh gà bí đao', 1, 'chén', 211, 21, 13, 4, 2, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canh-xuong-ga-bi-xanh-hai-hau-recipe-main-photo.jpg'),
(34, 'Hành tây xào thịt lợn', 1, 'đĩa', 109, 10, 3, 9, 1, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/thit-lon-xao-hanh-tay-1.jpg'),
(35, 'Nấm hương đậu phụ', 1, 'tô', 229, 25.25, 11, 9, 12, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canh-nam-huong-dau-phu-recipe-main-photo.jpg'),
(36, 'Dưa chuột trộn sứa', 1, 'đĩa', 135, 9, 1, 15, 3, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/duachuottrondua.jpg'),
(37, 'Lươn nấu (200g)', 1, 'đĩa', 188, 40, 3, 0, 0, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/luon-om-chuoi-dau.jpg'),
(38, 'Bí đỏ nấu chay (300g)', 1, 'chén', 120, 3, 0, 30, 3, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/luon-om-chuoi-dau.jpg'),
(39, 'Mướp đắng xào thịt', 1, 'đĩa', 103, 11, 3, 8, 6, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/muop-dang-xao-thit-bo.jpg'),
(40, 'Canh bầu', 1, 'chén', 30, 2, 1, 1, 0, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/cach-nau-canh-bau.jpg?w=494'),
(41, 'Canh cải ngọt', 1, 'chén', 30, 2, 1, 1, 0, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canh-cai-ngot-thit-bam-recipe-main-photo.jpg'),
(42, 'Canh bí đao', 1, 'chén', 29, 2, 1, 1, 0, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canh-bi-xanh-nau-thit-vien-recipe-main-photo.jpg'),
(43, 'Canh rau dền', 1, 'chén', 22, 2, 0, 0, 0, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canh-rau-den-nau-voi-hen-recipe-main-photo.jpg'),
(44, 'Nước củ hành', 1, 'chén', 40, 1, 0, 9, 1, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/nuocephanhtay.jpg'),
(45, 'Canh bí đao, cà chua', 1, 'chén', 43, 1, 0, 9, 2, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/bidaocachua.jpg'),
(46, 'Canh xanh bạch ngọc', 1, 'chén', 40, 3, 0, 7, 3, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canhxanhbachngoc.jpg'),
(47, 'Canh bí xanh thịt nạc', 1, 'chén', 103, 12, 3, 6, 2, 'lunch', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canh-bi-dao-nau-thit-bam-recipe-main-photo.jpg'),
(48, 'Cơm', 1, 'chén', 200, 4, 0, 44, 0, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/com.jpg'),
(49, 'Bún mộc', 1, 'tô', 514, 28, 19, 56, 2, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/bun-suon-moc.jpg'),
(50, 'Mì quảng', 1, 'tô', 541, 22, 20, 67, 2, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/myquang.jpg'),
(51, 'Cháo bí đao', 1, 'tô', 126, 3, 0, 27, 1, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/chaobidao.jpg'),
(52, 'Cháo yến mạch', 1, 'tô', 194, 8, 3, 33, 5, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/chao-yen-mach-dinh-duong-600x400-1.jpg'),
(53, 'Cháo bột bắp', 1, 'tô', 370, 8, 3, 77, 4, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/chao-bot-bap.jpg'),
(54, 'Cháo bắp mộc nhỉ', 1, 'tô', 116, 5, 1, 25, 3, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/mocnhi.jpg'),
(55, 'Lươn nấu (200g)', 1, 'đĩa', 188, 40, 3, 0, 0, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/luon-om-chuoi-dau.jpg'),
(56, 'Bí đỏ nấu chay (300g)', 1, 'chén', 120, 3, 0, 30, 3, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/bidonauchay.jpg'),
(57, 'Canh gà bí đao', 1, 'chén', 211, 21, 13, 4, 2, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canhbau.jpg'),
(58, 'Hành tây xào thịt lợn', 1, 'đĩa', 109, 10, 3, 9, 1, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/thit-lon-xao-hanh-tay-1.jpg'),
(59, 'Nấm hương đậu phụ', 1, 'tô', 229, 25.25, 11, 9, 12, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canh-nam-huong-dau-phu-recipe-main-photo.jpg'),
(60, 'Dưa chuột trộn sứa', 1, 'đĩa', 135, 9, 1, 15, 3, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/duachuottrondua.jpg'),
(61, 'Thịt kho trứng', 1, 'đĩa', 315, 19, 22, 7, 0, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/thikhotrung.jpg'),
(62, 'Thịt bò xào nấm rơm', 1, 'đĩa', 152, 13, 9, 2, 0, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/boxaonamrom.jpg'),
(63, 'Cá chép chưng tương', 1, 'con', 156, 6.6, 7, 16, 0, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/chachepchungtuong.jpg'),
(64, 'Cá hú kho', 1, 'lát cá', 184, 15, 9, 8, 0, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/ca-hu-ivivu-3.jpg'),
(65, 'Mướp đắng xào thịt', 1, 'đĩa', 103, 11, 3, 8, 6, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/muop-dang-xao-thit-bo.jpg'),
(66, 'Canh bầu', 1, 'chén', 30, 2, 1, 1, 0, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/cach-nau-canh-bau.jpg?w=494'),
(67, 'Canh cải ngọt', 1, 'chén', 30, 2, 1, 1, 0, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canh-cai-ngot-thit-bam-recipe-main-photo.jpg'),
(68, 'Canh bí đao', 1, 'chén', 29, 2, 1, 1, 0, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canh-bi-xanh-nau-thit-vien-recipe-main-photo.jpg'),
(69, 'Canh rau dền', 1, 'chén', 22, 2, 0, 0, 0, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canh-rau-den-nau-voi-hen-recipe-main-photo.jpg'),
(70, 'Nước củ hành', 1, 'chén', 40, 1, 0, 9, 1, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/nuocephanhtay.jpg'),
(71, 'Canh bí đao, cà chua', 1, 'chén', 43, 1, 0, 9, 2, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/bidaocachua.jpg'),
(72, 'Canh xanh bạch ngọc', 1, 'chén', 40, 3, 0, 7, 3, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canhxanhbachngoc.jpg'),
(73, 'Canh bí xanh thịt nạc', 1, 'chén', 103, 12, 3, 6, 2, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canh-bi-dao-nau-thit-bam-recipe-main-photo.jpg'),
(78, 'Test', 0, '', 0, 0, 0, 0, 0, 'breakfast', 'high', 'ac');

-- --------------------------------------------------------

--
-- Table structure for table `glycemics`
--

CREATE TABLE `glycemics` (
  `id` int(11) NOT NULL,
  `indexG` float DEFAULT NULL,
  `tags` varchar(1000) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `measureTime` datetime DEFAULT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `glycemics`
--

INSERT INTO `glycemics` (`id`, `indexG`, `tags`, `note`, `measureTime`, `userID`) VALUES
(11, 120, '[Trước bữa tối, Trước hoạt động]', '332323', '2020-11-16 01:46:48', 13),
(13, 11.6, '', '', '2020-11-16 14:15:47', 17),
(14, 22, '', '', '2020-11-16 14:19:35', 17),
(15, 22, '', '', '2020-11-16 14:19:35', 17),
(16, 22, '', '', '2020-11-16 14:19:35', 17),
(17, 22, '', '', '2020-11-16 14:19:35', 17),
(18, 2, '', '', '2020-11-16 14:24:50', 17),
(19, 2, '', '', '2020-11-16 14:24:50', 17),
(20, 0, '', '', '2020-11-16 14:33:59', 17),
(21, 0, '', '', '2020-11-16 14:34:15', 17),
(22, 11.2, '[Trong lúc hoạt động, Trước hoạt động]', '12121', '2020-11-16 14:53:06', 17),
(23, 6, '[Sau bữa tối, Sau hoạt động]', '66', '2020-11-16 14:53:35', 17),
(24, 12, '[Trước hoạt động, Trước bữa tối]', '2323', '2020-11-16 20:28:27', 17),
(26, 15, '', '', '2020-11-16 22:59:20', 11),
(27, 18, '', '', '2020-11-17 14:49:22', 11),
(28, 12, '', '', '2020-11-17 18:08:46', 12),
(29, 12, '', '', '2020-11-17 18:08:46', 12),
(30, 15, '[Sau bữa tối, Sau hoạt động]', '', '2020-11-17 18:13:46', 12),
(31, 250, '[Trong lúc hoạt động]', '', '2020-11-20 20:49:39', 13),
(32, 20, '[Sau bữa tối, Sau hoạt động]', '', '2020-11-23 20:15:31', 13),
(33, 30, '[Trước hoạt động, Trước bữa tối]', '', '2020-11-23 20:16:02', 13),
(34, 50, '[Trước hoạt động, Trước bữa tối]', '', '2020-11-23 20:16:14', 13),
(35, 45, '[Sau bữa tối, Sau hoạt động]', '', '2020-11-23 20:22:35', 13),
(36, 45, '', '', '2020-11-23 20:22:54', 13),
(37, 45, '', '', '2020-11-23 20:25:55', 13),
(38, 69, '', '', '2020-11-23 20:26:24', 13),
(39, 30, '', '', '2020-11-23 20:32:40', 13),
(40, 69, '', '', '2020-11-23 20:36:43', 13),
(41, 50, '', '', '2020-11-29 00:14:20', 13),
(42, 33, '', '', '2020-11-29 00:17:53', 13),
(43, 1, '', '', '2020-11-30 00:20:38', 13),
(46, 250, '', '', '2020-12-06 13:14:41', 13),
(47, 200, '', 'test update', '2020-11-16 01:46:48', 13),
(48, 300, '', '', '2020-12-06 21:53:39', 13),
(49, 150, '[Trong lúc hoạt động, Trước hoạt động, Sau hoạt động]', 'ok', '2020-12-06 21:55:09', 13),
(50, 280, '', '', '2020-12-06 21:56:46', 13),
(53, 169, '[Trước bữa tối, Sau bữa tối]', '', '2020-12-06 21:59:13', 13),
(54, 200, '', '', '2020-12-08 20:59:33', 28),
(55, 200, '', '', '2020-12-08 21:01:22', 28),
(56, 250, '', '', '2020-12-08 21:01:57', 28),
(57, 250, '', '', '2020-12-09 15:55:03', 29),
(58, 280, '', '', '2020-12-09 15:56:19', 29),
(59, 300, '', '', '2020-12-09 15:57:03', 29),
(60, 200, '', '', '2020-12-09 16:24:41', 13),
(61, 250, '', '', '2020-12-09 17:03:09', 27),
(62, 200, '', '', '2020-12-10 21:57:20', 27),
(63, 269, '', '', '2020-12-10 22:01:43', 27),
(64, 240, '', '', '2020-12-10 22:02:30', 27),
(65, 300, '', '', '2020-12-10 22:03:00', 27),
(66, 250, '', '', '2020-12-13 20:10:41', 27),
(67, 195, '', '', '2020-12-16 22:38:25', 13),
(68, 220, '', '', '2020-12-17 00:28:08', 13),
(69, 230, '', '', '2020-12-17 00:28:21', 13),
(70, 120, '', '', '2020-12-23 20:18:30', 13),
(71, 130, '', '', '2020-12-23 20:18:46', 13),
(72, 146, '', '', '2020-12-23 20:19:16', 13),
(73, 147, '', '', '2020-12-23 20:19:25', 13),
(74, 148, '', '', '2020-12-23 20:19:34', 13),
(75, 149, '', '', '2020-12-23 20:19:40', 13),
(76, 12, '', '', '2020-12-23 23:40:44', 30),
(77, 130, '', '', '2020-12-24 22:40:35', 31),
(78, 130, '', '', '2021-01-13 21:49:07', 13),
(79, 60, '', '', '2021-01-13 21:53:13', 13),
(80, 150, '', '', '2021-01-13 22:02:57', 13),
(81, 155, '', '', '2021-01-13 22:04:34', 13),
(82, 120, '', '', '2021-01-13 22:07:10', 13);

-- --------------------------------------------------------

--
-- Table structure for table `medicine`
--

CREATE TABLE `medicine` (
  `id` int(11) NOT NULL,
  `name` varchar(10000) CHARACTER SET utf8 NOT NULL,
  `typeInsulin` varchar(1000) CHARACTER SET utf8 DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `measureTime` datetime NOT NULL,
  `unit` varchar(1000) CHARACTER SET utf8 NOT NULL,
  `note` varchar(1000) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `medicine`
--

INSERT INTO `medicine` (`id`, `name`, `typeInsulin`, `amount`, `userID`, `measureTime`, `unit`, `note`) VALUES
(1, 'amina', 'Nhanh', 15, 1, '2020-11-16 01:14:52', 'Viên', 'Ăn xong'),
(3, 'test update', 'Nhanh', 15, 13, '2020-11-16 01:14:52', 'Viên', 'Ăn xong'),
(5, 'abc', '', 4, 12, '2020-11-18 23:09:31', '', ''),
(6, 'abc', 'Tác dụng nhanh', 45, 12, '2020-11-18 23:11:43', 'Viên', ''),
(7, 'abc', '', 15, 12, '2020-11-19 00:47:57', '', ''),
(8, 'abc', '', 20, 12, '2020-11-19 00:50:50', 'Viên', ''),
(9, 'test add', 'Tác dụng nhanh', 15, 13, '2020-11-23 20:22:54', 'Viên', ''),
(10, 'test added 23', 'Tác dụng nhanh', 25, 13, '2020-11-23 20:26:24', 'Viên', ''),
(11, 'insulin', 'Tác dụng nhanh', 255, 13, '2020-11-23 20:32:40', 'Ngậm', ''),
(12, '69', 'Tác dụng nhanh', 25, 13, '2020-11-23 20:36:43', 'Viên', ''),
(13, 'soocla', '', 3, 13, '2020-12-04 21:42:06', '', ''),
(14, 'a', '', 5, 13, '2020-12-06 12:05:12', '', ''),
(15, 'socola', '', 30, 13, '2021-01-13 21:54:08', 'Nhộng', ''),
(16, 'test thuốc', '', 25, 13, '2021-01-13 22:04:34', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `eventStartDate` datetime NOT NULL,
  `eventEndDate` datetime NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `title`, `description`, `eventStartDate`, `eventEndDate`, `userID`) VALUES
(29, 'dd', 'dssdsd', '2020-10-28 10:20:00', '2020-10-29 10:21:00', 0),
(40, '44343', '3434', '2020-10-29 22:29:08', '2020-10-29 22:29:08', 0),
(43, 'uuuuu', '0000111', '2020-10-26 11:41:00', '2021-04-23 10:29:00', 0),
(44, '00011122', '0000111222', '2020-10-30 15:07:00', '2020-10-31 11:05:00', 0),
(45, '2121aaaa', '21212aa', '2020-10-30 11:41:42', '2020-10-31 11:41:00', 0),
(46, 'ngu', 'ngu trưa', '2020-11-29 12:23:00', '2020-11-29 12:28:00', 13),
(47, 'a', 'a', '2020-12-03 21:26:00', '2020-12-03 21:26:00', 13),
(48, 's', 'a', '2020-12-04 15:51:00', '2020-12-04 15:54:00', 13),
(49, 'Tập thể dục', 'Tập TD', '2020-12-16 23:02:00', '2020-12-19 23:00:00', 13),
(50, 'test tướng', 'test báo thức', '2020-12-16 23:15:00', '2020-12-17 23:14:02', 13),
(51, 'testgh', 'testhh', '2020-12-17 20:24:00', '2020-12-18 20:11:54', 13),
(52, 'test', 'test', '2020-12-17 20:15:00', '2020-12-18 20:13:47', 13),
(53, 'ok', 'ok', '2020-12-17 21:08:00', '2020-12-18 20:15:31', 13),
(54, 'ok', 'Toàn', '2020-12-28 23:34:51', '2020-12-29 23:34:51', 31),
(55, 'alo', 'alo', '2020-12-28 12:00:00', '2020-12-29 23:47:57', 31),
(56, 'Toàn', 'uống thuốc', '2021-01-12 12:00:00', '2021-01-13 21:38:33', 31);

-- --------------------------------------------------------

--
-- Table structure for table `personalinfos`
--

CREATE TABLE `personalinfos` (
  `id` int(11) NOT NULL,
  `birthday` datetime NOT NULL,
  `gender` int(2) NOT NULL,
  `height` float NOT NULL,
  `weight` float NOT NULL,
  `typeDiabete` int(2) NOT NULL,
  `userID` int(11) NOT NULL,
  `emailRelative` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `personalinfos`
--

INSERT INTO `personalinfos` (`id`, `birthday`, `gender`, `height`, `weight`, `typeDiabete`, `userID`, `emailRelative`) VALUES
(16, '1998-04-04 00:00:00', 1, 11, 11, 2, 14, NULL),
(17, '1998-04-04 00:00:00', 1, 1.74, 75, 2, 18, NULL),
(18, '1950-01-01 00:00:00', 1, 123, 123, 2, 11, NULL),
(19, '1950-01-01 00:00:00', 1, 123, 25, 2, 12, NULL),
(20, '1998-01-01 00:00:00', 2, 123, 65, 2, 13, 'quoctoan0629@gmail.com'),
(22, '2000-01-01 00:00:00', 1, 165, 69, 1, 27, 'quoctoan0629@gmail.com'),
(23, '1970-01-01 00:00:00', 1, 150, 65, 2, 28, 'quoctoan0629@gmail.com'),
(24, '1970-01-01 00:00:00', 1, 165, 65, 2, 29, 'quoctoan0629@gmail.com'),
(25, '1970-01-01 00:00:00', 1, 165, 50, 2, 13, 'quoctoan0629@gmail.com'),
(26, '1970-01-01 00:00:00', 1, 165, 65, 2, 13, 'quoctoan0629@gmail.com'),
(27, '1970-01-01 00:00:00', 1, 165, 65, 2, 0, 'quoctoan0629@gmail.com'),
(28, '1970-01-01 00:00:00', 1, 165, 55, 2, 13, 'quoctoan0629@gmail.com'),
(29, '2000-01-01 00:00:00', 1, 165, 69, 1, 27, 'quoctoan0629@gmail.com'),
(30, '2000-01-01 00:00:00', 1, 165, 69, 1, 27, 'quoctoan0629@gmail.com'),
(31, '2000-01-01 00:00:00', 1, 165, 69, 1, 27, 'quoctoan0629@gmail.com'),
(32, '2000-01-01 00:00:00', 1, 165, 69, 1, 27, 'quoctoan0629@gmail.com'),
(33, '1970-01-01 00:00:00', 1, 1.74, 54, 2, 30, 'toconghauh@gmail.com'),
(34, '1970-01-01 00:00:00', 1, 163, 50, 2, 31, 'toantenx7@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `id` int(11) NOT NULL,
  `name` varchar(1000) CHARACTER SET utf8 NOT NULL,
  `ingredient` varchar(5000) CHARACTER SET utf8 NOT NULL,
  `recipe` varchar(5000) CHARACTER SET utf8 NOT NULL,
  `benefit` varchar(5000) CHARACTER SET utf8 NOT NULL,
  `groupID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`id`, `name`, `ingredient`, `recipe`, `benefit`, `groupID`) VALUES
(1, 'Phở gà', 'Xương gà: 1,5 kg\r\nThịt gà ta: 0,5 - 1kg hoặc nửa con gà (tùy vào khẩu phần ăn của gia đình)\r\nHành tây: 2 củ\r\nHành tím: 5 củ\r\nBánh phở : 1 kg hoặc 1,5 kg tùy sức ăn.\r\nGia vị (mắm, hạt nêm, muối, hạt tiêu, đường cát), quế, hoa hồi, thảo quả, hành tỏi.\r\nHành lá, hành tây, ngò rí và ngò gai, quẩy và các loại rau ăn kèm như húng quế, mùi, giá sống, chanh, ớt sừng xắt mỏng.', 'Đầu tiên, xương gà và thịt gà vừa mua về đem rửa qua bằng nước ấm mấy lần cho sạch.\r\nHành tây, hành tím và gừng rửa sạch, gọt vỏ rồi nướng trên bếp.\r\nRửa sạch hành lá, các loại rau ăn kèm rồi để ráo.\r\nBánh phở trần qua nước sôi cho sạch và giảm bớt độ chua, để ráo.\r\nHành tây, hành lá và ớt thì thái nhỏ.\r\nHoa hồi, quế, thảo quả đem rang qua cho thơm mùi rồi cho vào túi vải.\r\nThịt gà sau khi đã rửa sạch chà xát với muối, sau đó cho vào nồi nước lạnh đun với lửa vừa. Khi luộc bỏ thêm gừng đập dập, hành tím và một ít muối.\r\nGà luộc sau khi sôi thì vặn nhỏ lửa, vớt bọt rồi để nắp nồi hé. Lưu ý luộc gà không nên chín quá, thịt gà dễ bị khô và mất ngọt. Để kiểm tra xem gà có chín chưa, bạn có thể dùng đũa xâm sâu vào phần thịt, nếu gà chín thì sẽ không thấy nước đỏ chảy ra.\r\nSau khi gà chín thì vớt gà ra để nguội, bạn có thể thái miếng hoặc xé nhỏ thành sợi tùy thích.\r\nPhần xương gà sau khi đã rửa sạch thì cho vào nồi áp suất và đổ nước sôi vào hầm cho đến khi xương mềm và hết vị ngọt. Nếu không sợ béo, bạn có thể đổ nước luộc gà vừa luộc và bỏ thêm xương gà đã được tách thịt ở trên vào hầm chung.\r\nCho túi vải gia vị đã buộc vào nồi, nêm nếm gia vị cho vừa ăn và khuấy đều đến khi gia vị hòa quyện hết. Hầm thêm khoảng 20 phút thì vớt túi gia vị đó ra. Sau đó, để lửa nhỏ liu riu cho nước nóng.', 'Chất xơ và nguồn protein từ thịt gà sẽ giúp người tiểu đường no lâu hơn.', 1),
(2, 'Há cảo\r\n', '* Phần Vỏ\r\n  - Bột năng: 100g\r\n  - Cà phê muối: ½ muỗng\r\n  - Bột gạo: 100g (hoặc thay thế hai loại bột này bằng 200g bột há cảo pha sẵn)\r\n  - Nước sôi\r\n* Phần nhân\r\n  - Tôm tươi: 350g\r\n  - 3 tai nấm bèo (hoặc nấm đông cô, nấm hương)\r\n  - Tỏi gừng băm\r\n  - Thịt heo: 150gr băm nhuyễn\r\n  - Hành tây: 1 củ', 'Bước 1: Làm vỏ bánh\r\nHòa tan bột năng, bột gạo cùng khoảng 200ml nước sôi, thêm muối vào khuấy đều cho đến khi bột tan ra. Trộn đều và nhào kỹ cho bột dẻo và mịn rồi ủ bột khoảng 10 phút. Lưu ý bạn không nên cho quá nhiều nước vào cùng một lúc nhé, cho từ từ nước rồi điều chỉnh lượng nước cho phù hợp, tránh trường hợp bột quá nhão sẽ khó làm vỏ.\r\nBước 2: Trong lúc ủ bột, bạn chế biến phần nhân bánh như sau: Trộn tôm và thịt vào cùng nhau, nêm nếm gia vị rồi để riêng trong chén.\r\nBước 3: Nhào bột lại và nén bột thành hình dài, sau đó cắt bột thành từng khúc nhỏ khoảng 3cm. Cán bột thành miếng mỏng, hình tròn.', 'Ổn định đường huyết', 2),
(3, 'Bánh mì thịt', 'Bánh mì: 4 ổ\r\nThịt heo: 300 gram\r\nRau răm: 1 mớ\r\nRượu trắng: 30ml\r\nNước lọc: 50ml\r\nỚt: 2 quả\r\nTỏi: 1 củ\r\nDưa leo: 1 quả\r\nGiấm\r\nBột ngũ vị hương\r\nTiêu xay\r\nĐường\r\nMuối\r\nNước mắm', 'Bước 1: Sơ chế nguyên liệu\r\n– Đầu tiên, đem thịt heo rửa sạch với nước muối loãng, rồi để ráo nước.\r\n– Tiếp theo, dùng dao khứa vài đường lên trên miếng thịt. Rồi sau đó dùng xiên đâm nhẹ lên phần bì của thịt heo để khi tẩm ướp gia vị sẽ thấm đều vào thịt, hương vị sẽ giòn ngon hơn\r\n– Tỏi bóc vỏ rồi dùng máy xay hoặc băm nhuyễn nhỏ lại\r\n– Rau răm bỏ gốc và các lá hư hỏng, lấy phần non của rau răm, đem rửa sạch với nước và cũng để rau răm ráo nước\r\n– Dưa leo cắt bỏ phần đầu để nhựa dưa chảy ra, đem dưa ngâm vào trong nước muối loãng. Sau đó, vớt ra để ráo nước và thái dưa thành các lát chéo mỏng\r\nBước 2: Ướp thịt\r\nSau khi đã sơ chế thịt xong thì thực hiện bước tiếp theo tẩm ướt gia vị vào thịt.\r\nDùng một chiếc bát tô to cho thêm 5ml giấm, 5 gram bột ngũ vị hương, 1/2 thìa cà phê tiêu xay, 2 thìa cà phê đường, 1 thìa cà phê muối, 50ml nước mắm, 30ml rượu trắng. Tiếp đó, trộn đều các gia vị trong tô để các nguyên liệu hòa quyện vào nhau.\r\nCho miếng thịt đã sơ chế làm sạch vào bát tô đựng gia vị, dùng tay bọp nhẹ để gia vị thấm đều vào thịt\r\nTiếp đó, lau sạch gia vị dính trên phần bì và ướp thịt trong khoảng thời gian 4 tiếng ( thời gian ướp càng lâu thịt càng ngấm ngon hơn).\r\nBước 3: Làm nước sốt\r\nCho ớt và tỏi đã băm cùng với nước lọc, nước mắm,1 thìa cà phê đường vào một chiếc bát, khuấy đều cho đến khi đường tan hết là bạn đã chuẩn bị xong phần nước sốt bánh mì thịt, rất đơn giản phải không nào\r\nBước 4: Nướng thịt \r\nNếu gia đình bạn có lò nướng thì bật lò, đặt nhiệt độ 200 độ C trong khoảng 10 phút trước khi nướng thịt để làm nóng lò. Sau đó cho thịt vào nướng và khoảng 20 phút thì lật mặt một lần để thịt chín đều các mặt, từ ngoài vào trong.\r\nBước 5: Kẹp bánh mì và thưởng thức\r\nDùng kéo xẻ dọc ổ bánh mì và cho lần lượt các nguyên liệu đã chuẩn bị: thịt heo, rau răm, dưa leo và rưới ít nước sốt lên trên.', 'Bánh mì có chỉ số đường huyết thấp', 3),
(4, 'Canh bí xanh thịt nạc', 'Bí xanh   250g\r\nThịt nạt  100g\r\nGiá       100g\r\nGia vị\r\nHành', 'Thịt lợn rửa sạch, băm nhỏ, ướp gia vị rồi cho 250ml nước vào đun nhỏ lửa cho sôi. Bí xanh gọt vỏ, thái miếng, giá rửa sạch. Khi thịt chín cho giá, bí vào đun chín lên, cho hành, nêm gia vị vừa ăn.', 'Bệnh nhân ăn ngày 2 lần, liên tục từ 10 - 15 ngày.', 73),
(5, 'Canh bí xanh thịt nạc', 'Bí xanh 250g\r\nThịt nạt 100g\r\nGiá 100g\r\nGia vị\r\nHành', 'Thịt lợn rửa sạch, băm nhỏ, ướp gia vị rồi cho 250ml nước vào đun nhỏ lửa cho sôi. Bí xanh gọt vỏ, thái miếng, giá rửa sạch. Khi thịt chín cho giá, bí vào đun chín lên, cho hành, nêm gia vị vừa ăn.', 'Bệnh nhân ăn ngày 2 lần, liên tục từ 10 - 15 ngày.', 47),
(6, 'Canh bí đao, cà chua', 'Bí đao	 250g\r\nCà chua  150g\r\nMì chình 0,5g\r\nHành     5g', 'Bí đao rửa sạch, bỏ ruột, thái miếng vuông, thêm nước hầm chín, cho cà chua đã thái miếng vào, đun chín, tốt nhất không cho muối.', 'Thích hợp cho bệnh nhân tiểu đường dạng béo phì, có tác dụng thanh nhiệt kiện tỳ.', 71),
(7, 'Canh bí đao, cà chua', 'Bí đao 250g\r\nCà chua 150g\r\nMì chình 0,5g\r\nHành 5g', 'Bí đao rửa sạch, bỏ ruột, thái miếng vuông, thêm nước hầm chín, cho cà chua đã thái miếng vào, đun chín, tốt nhất không cho muối.', 'Thích hợp cho bệnh nhân tiểu đường dạng béo phì, có tác dụng thanh nhiệt kiện tỳ.', 45),
(8, 'Hành tây xào thịt lợn', 'Hành tây tươi	100g\r\nThịt lợn nạc	50g\r\nGia vị vừa đủ.', 'Xào thịt lợn gần chín thì cho hành tây vào cùng xào, rồi cho gia vị vừa ăn.', 'Thích hợp với bệnh tiểu đường mắc chứng hạ tiêu, có tác dụng tư âm, cố thận hạ gan.', 58),
(9, 'Hành tây xào thịt lợn', 'Hành tây tươi 100g\r\nThịt lợn nạc 50g\r\nGia vị vừa đủ.', 'Xào thịt lợn gần chín thì cho hành tây vào cùng xào, rồi cho gia vị vừa ăn.', 'Thích hợp với bệnh tiểu đường mắc chứng hạ tiêu, có tác dụng tư âm, cố thận hạ gan.', 34),
(10, 'Nước củ hành', 'Củ hành tươi  100g', 'Củ hành rửa sạch rồi thái nhỏ nấu nước uống. Không nên nấu lâu vì sẽ mất tác dungjhaj đường huyết. Ngày uống một thang, dùng thường xuyên.', 'Thích hợp với mọi loại bệnh tiểu dduongf có công hiệu giảm đường huyết.', 70),
(11, 'Nước củ hành', 'Củ hành tươi 100g', 'Củ hành rửa sạch rồi thái nhỏ nấu nước uống. Không nên nấu lâu vì sẽ mất tác dungjhaj đường huyết. Ngày uống một thang, dùng thường xuyên.', 'Thích hợp với mọi loại bệnh tiểu dduongf có công hiệu giảm đường huyết.', 44),
(12, 'Cháo bí đao', 'Bí đao  80 - 100g\r\nGạo     30g', 'Bí đao thái miếng, cho vào nấu cùng gạo thành cháo, có thể ăn sáng lẫn chiều.', 'Thích hợp với người bệnh tiểu đường béo phì, tỳ hư thấp thịnh.', 25),
(13, 'Cháo bí đao', 'Bí đao 80 - 100g\r\nGạo 30g', 'Bí đao thái miếng, cho vào nấu cùng gạo thành cháo, có thể ăn sáng lẫn chiều.', 'Thích hợp với người bệnh tiểu đường béo phì, tỳ hư thấp thịnh.', 51),
(14, 'Cháo yến mạch', 'Yến mạch miếng 50g', 'Cho yến mạch vào nồi, đổ thêm nước, nấu đến khi cháo chín nhừ là được.', 'Mớn ăn có công hiệu giảm mỡ trong máu, giảm đường, giảm béo.\r\nCháo yến mạch thích hợp với người bệnh tiểu đường, gan nhiễm mỡ, người béo phì.', 26),
(15, 'Cháo yến mạch', 'Yến mạch miếng 50g', 'Cho yến mạch vào nồi, đổ thêm nước, nấu đến khi cháo chín nhừ là được.', 'Mớn ăn có công hiệu giảm mỡ trong máu, giảm đường, giảm béo.\r\nCháo yến mạch thích hợp với người bệnh tiểu đường, gan nhiễm mỡ, người béo phì.', 52),
(16, 'Mướp đắng xào thịt', 'Mướp đắng    	300g\r\nThịt lợn nạc	200g\r\nHành, gừng, muối, đường trăng, rượu gạo, bột lọc, dầu vừng lượng vừa đủ.', 'Rửa sạch mướp đắng, thái dọc, bổ ruột, thái thành miếng dài 5cm, rửa sạch cho vào nước sôi 3 phút, lấy ra cho vào nước lạnh nguội, vớt ra để ráo nước. Rửa sạch thịt lợn nạc, thái miếng bằng miếng mướp đắng cho vào bát, cho rượu, muối, đường, bột lọc, trộn đều.\r\nBắc nồi lên bếp, đun nóng dầu ăn phi thơm hành, gừng đã thái chỉ, sau đó cho thịt vào xào cho đến khi thịt chuyển màu. Cho mướp đắng vào đảo đều, nêm ít muối, mì chính, đường vào là được.', 'Làm giảm lượng đường trong máu, điều tiết đường trong máu, người bệnh tiểu đường nên ăn thường xuyên.\r\nChú ý: Mướp đắng tính hàn, người vị hàn thể hư cẩn thận khi dùng.', 39),
(17, 'Mướp đắng xào thịt', 'Mướp đắng 300g\r\nThịt lợn nạc 200g\r\nHành, gừng, muối, đường trăng, rượu gạo, bột lọc, dầu vừng lượng vừa đủ.', 'Rửa sạch mướp đắng, thái dọc, bổ ruột, thái thành miếng dài 5cm, rửa sạch cho vào nước sôi 3 phút, lấy ra cho vào nước lạnh nguội, vớt ra để ráo nước. Rửa sạch thịt lợn nạc, thái miếng bằng miếng mướp đắng cho vào bát, cho rượu, muối, đường, bột lọc, trộn đều.\r\nBắc nồi lên bếp, đun nóng dầu ăn phi thơm hành, gừng đã thái chỉ, sau đó cho thịt vào xào cho đến khi thịt chuyển màu. Cho mướp đắng vào đảo đều, nêm ít muối, mì chính, đường vào là được.', 'Làm giảm lượng đường trong máu, điều tiết đường trong máu, người bệnh tiểu đường nên ăn thường xuyên.\r\nChú ý: Mướp đắng tính hàn, người vị hàn thể hư cẩn thận khi dùng.', 65),
(18, 'Canh gà bí đao', 'Thịt gà	   100g\r\nBí đao	   200g\r\nĐảng sâm   3g\r\nGia vị và rượu vừa đủ.', 'Thịt gà rửa sạch, thái nhỏ. Đổ vào 500ml nước, cho thịt gà và đảng sâm vào hầm cho chín thì cho bí đao thái lát vào, bí chín cho gia vị vừa ăn.', 'Thích hợp với bệnh tiểu đường béo phig, tỳ khí hư nhược, kiện tỳ lợi thủy.', 57),
(19, 'Canh gà bí đao', 'Thịt gà 100g\r\nBí đao 200g\r\nĐảng sâm 3g\r\nGia vị và rượu vừa đủ.', 'Thịt gà rửa sạch, thái nhỏ. Đổ vào 500ml nước, cho thịt gà và đảng sâm vào hầm cho chín thì cho bí đao thái lát vào, bí chín cho gia vị vừa ăn.', 'Thích hợp với bệnh tiểu đường béo phig, tỳ khí hư nhược, kiện tỳ lợi thủy.', 33),
(20, 'Cháo yến mạch', 'Yến mạch miếng 50g', 'Cho yến mạch vào nồi, đổ thêm nước, nấu đến khi cháo chín nhừ là được.', 'Mớn ăn có công hiệu giảm mỡ trong máu, giảm đường, giảm béo.\r\nCháo yến mạch thích hợp với người bệnh tiểu đường, gan nhiễm mỡ, người béo phì.', 20),
(21, 'Canh xanh bạch ngọc', 'Bí đao	200g\r\nRau hẹ	100g\r\nMuối, mì chính, dầu, hạt tiêu, dấm, bột tiêu lượng vừa đủ dùng.', 'Rửa sạch bí đao, gọt vỏ, thái miếng mỏng. Hẻ rửa sạch, thái đoạn ngắn chờ dùng.\r\nĐặt nồi lên bếp lửa, cho vào nồi lượng vừa nước nấu sôi, cho bí đao vào. Sau khi bí đao chín nêm muối, mì chính, dầu, hạt tiêu, dấm, bột tiêu, rắc hẹ vào, sau khi hẹ biến màu là được.', 'Dùng cho người bệnh tiểu đường, huyết áp cao, mỡ trong máy cao, người bệnh tim.', 72),
(22, 'Canh xanh bạch ngọc', 'Bí đao 200g\r\nRau hẹ 100g\r\nMuối, mì chính, dầu, hạt tiêu, dấm, bột tiêu lượng vừa đủ dùng.', 'Rửa sạch bí đao, gọt vỏ, thái miếng mỏng. Hẻ rửa sạch, thái đoạn ngắn chờ dùng.\r\nĐặt nồi lên bếp lửa, cho vào nồi lượng vừa nước nấu sôi, cho bí đao vào. Sau khi bí đao chín nêm muối, mì chính, dầu, hạt tiêu, dấm, bột tiêu, rắc hẹ vào, sau khi hẹ biến màu là được.', 'Dùng cho người bệnh tiểu đường, huyết áp cao, mỡ trong máy cao, người bệnh tim.', 46),
(23, 'Lươn nấu', 'Lươn	200g\r\nMuối tinh, mì chính, rượu vang, hành hoa, xì dầu, tỏi.', 'Làm thịt lươn bỏ nọi tạng, rửa sạch, dùng nước sối chần một lúc để tẩy nhớt trên mình lươn, chặt đoạn ngắn, lấy cả đầu lươn, để ráo nước. Tỏi rửa củ, để cả vỏ đập dạp, bỏ vỏ chờ dùng.\r\nBắc nồi lên bếp, dùng lửa to đun nóng dầu, phi thơm tỏi, đổ lươn vào xào 3 phút, cho vào 2 thìa rượu, lại cào 3 phút. Sau khi dậy mùi thơm rượu, cho xì dầu, mì chính và nước lượng vừa, tiếp tục đun 20 - 30 phút cho đến khi lươn chín, cho hành hoa vào là được. Nước canh nấu cho đến khi thành màu trắng, mùi vị càng thơm dinh dưỡng càng phong phú.', 'Dùng cho người bệnh tiểu đường, mỡ trong máu cao. Ngoài ra nó có tác dụng hoạt huyết thông lạc nên rất tốt cho những người viêm khớp có tính phong thấp.', 55),
(24, 'Lươn nấu', 'Lươn 200g\r\nMuối tinh, mì chính, rượu vang, hành hoa, xì dầu, tỏi.', 'Làm thịt lươn bỏ nọi tạng, rửa sạch, dùng nước sối chần một lúc để tẩy nhớt trên mình lươn, chặt đoạn ngắn, lấy cả đầu lươn, để ráo nước. Tỏi rửa củ, để cả vỏ đập dạp, bỏ vỏ chờ dùng.\r\nBắc nồi lên bếp, dùng lửa to đun nóng dầu, phi thơm tỏi, đổ lươn vào xào 3 phút, cho vào 2 thìa rượu, lại cào 3 phút. Sau khi dậy mùi thơm rượu, cho xì dầu, mì chính và nước lượng vừa, tiếp tục đun 20 - 30 phút cho đến khi lươn chín, cho hành hoa vào là được. Nước canh nấu cho đến khi thành màu trắng, mùi vị càng thơm dinh dưỡng càng phong phú.', 'Dùng cho người bệnh tiểu đường, mỡ trong máu cao. Ngoài ra nó có tác dụng hoạt huyết thông lạc nên rất tốt cho những người viêm khớp có tính phong thấp.', 37),
(25, 'Cháo bắp mộc nhĩ', 'Bắp	 100g\r\nMộc nhĩ	 10g\r\nGia vị lượng vừa phải.', 'Rửa sạch mộc nhĩ, ngâm cho nát vụn. Nấu bắp chín nhừ rồi thả mộc nhĩ đã ngâm vào nấu thành cháo, nêm vừa ăn.', 'Cháo băp, mộc nhĩ dùng trong bứa nă hangd ngày.\r\nMón ăn này có tác dụng khử ứ trọc, hạ mỡ trong máu, thích hợp với bệnh cao huyết áp, tiểu đường kèm mỡ máu cao.', 21),
(26, 'Cháo bắp mộc nhĩ', 'Bắp 100g\r\nMộc nhĩ 10g\r\nGia vị lượng vừa phải.', 'Rửa sạch mộc nhĩ, ngâm cho nát vụn. Nấu bắp chín nhừ rồi thả mộc nhĩ đã ngâm vào nấu thành cháo, nêm vừa ăn.', 'Cháo băp, mộc nhĩ dùng trong bứa nă hangd ngày.\r\nMón ăn này có tác dụng khử ứ trọc, hạ mỡ trong máu, thích hợp với bệnh cao huyết áp, tiểu đường kèm mỡ máu cao.', 28),
(27, 'Cháo bắp mộc nhĩ', 'Bắp 100g\r\nMộc nhĩ 10g\r\nGia vị lượng vừa phải.', 'Rửa sạch mộc nhĩ, ngâm cho nát vụn. Nấu bắp chín nhừ rồi thả mộc nhĩ đã ngâm vào nấu thành cháo, nêm vừa ăn.', 'Cháo băp, mộc nhĩ dùng trong bứa nă hangd ngày.\r\nMón ăn này có tác dụng khử ứ trọc, hạ mỡ trong máu, thích hợp với bệnh cao huyết áp, tiểu đường kèm mỡ máu cao.', 54),
(28, 'Bí đỏ nấu chay', 'Bí đỏ	300g\r\nHành, gừng, xì dầu, muối tinh, mì chính lượng vừa đủ.', 'Bí đỏ gọt vỏ, rửa sạch, bỏ ruột, thái miếng vuông 3cm, hành, gừng rửa sạch thái nhỏ.\r\nCho dầu vào nồi, dùng lửa to phi thơm hành, gừng. Sau đó cho bí đỏ vào xào một lúc, nêm xì dầu cùng lượng vừa nước rồi chuyển sang lửa vừa nấu cùng lượng vừa nước rồi chuyển sang lửa vừa nấu cho bí đỏ chín nhừ, nêm muối, mì chính vào là được.', 'Bổ sung, ích khí, giảm mỡ, giảm đường, thích hợp với người bệnh tiểu đường.', 38),
(29, 'Bí đỏ nấu chay', 'Bí đỏ 300g\r\nHành, gừng, xì dầu, muối tinh, mì chính lượng vừa đủ.', 'Bí đỏ gọt vỏ, rửa sạch, bỏ ruột, thái miếng vuông 3cm, hành, gừng rửa sạch thái nhỏ.\r\nCho dầu vào nồi, dùng lửa to phi thơm hành, gừng. Sau đó cho bí đỏ vào xào một lúc, nêm xì dầu cùng lượng vừa nước rồi chuyển sang lửa vừa nấu cùng lượng vừa nước rồi chuyển sang lửa vừa nấu cho bí đỏ chín nhừ, nêm muối, mì chính vào là được.', 'Bổ sung, ích khí, giảm mỡ, giảm đường, thích hợp với người bệnh tiểu đường.', 56),
(30, 'Cháo bột băp', 'Gạo thơm     100g\r\nBột bắp lượng tùy ý.', 'Đổ nước vào gạo nấu cho đến khi gạo nở thì cho bột bắp vào, nấu thành cháo đặc ăn sáng, tối.', 'Món ăn này tuy rất đơn giản nhưng lại có tác dụng tiện tỳ khử thấp, giảm mỡ kiện thân, thích hợp với bệnh áp huyết cao, tiểu đường kèm mỡ máu.', 53),
(31, 'Cháo bột băp', 'Gạo thơm 100g\r\nBột bắp lượng tùy ý.', 'Đổ nước vào gạo nấu cho đến khi gạo nở thì cho bột bắp vào, nấu thành cháo đặc ăn sáng, tối.', 'Món ăn này tuy rất đơn giản nhưng lại có tác dụng tiện tỳ khử thấp, giảm mỡ kiện thân, thích hợp với bệnh áp huyết cao, tiểu đường kèm mỡ máu.', 27),
(32, 'Dưa chuột trộn sứa', 'Dưa chuột non	500g\r\nBì sứa	        100g\r\nRau mùi, gừng tươi, muối tinh, xì dầu, dấm, mì chính, dầu gừng.', 'Dưa chuột non rửa sachjm thái thành sợi nhỏ. Bì sứa ngâm vào nướng nóng, rửa sạch cát, thái nhỏ cho vào nước nóng chần một lúc, vớt ra cho vào nước lạnh nguội. Rau mùi rửa sach, thái đoạn, gừng tươi rửa sạch, gọt vỏ, thái sợi.\r\nCho muối, mì chính, xì dầu, dấm, dầu vừng vào bát, trộn thành nước gia vị. Cho sợi dưa chuột, sợi bì sứa chia lớp xếp lên đĩa, rắc sợi gừng, rau thơm vào, rót nước gia vị lên khi ăn trộn đều là được.', 'Thanh nhiệt, giải độc, lợi thủy, giảm béo. Thích hợp với người bệnh tiểu đường, bệnh cao huyết áp và béo phig, nhất là người bị biến chứng bệnh huyết quản.\r\nChú ý: Người vị hàn ăn nhiều dễ đau bụng. Người già viêm phế quản mạn tính ở thời kỳ cấp tính kiêng ăn.', 36),
(33, 'Dưa chuột trộn sứa', 'Dưa chuột non 500g\r\nBì sứa 100g\r\nRau mùi, gừng tươi, muối tinh, xì dầu, dấm, mì chính, dầu gừng.', 'Dưa chuột non rửa sachjm thái thành sợi nhỏ. Bì sứa ngâm vào nướng nóng, rửa sạch cát, thái nhỏ cho vào nước nóng chần một lúc, vớt ra cho vào nước lạnh nguội. Rau mùi rửa sach, thái đoạn, gừng tươi rửa sạch, gọt vỏ, thái sợi.\r\nCho muối, mì chính, xì dầu, dấm, dầu vừng vào bát, trộn thành nước gia vị. Cho sợi dưa chuột, sợi bì sứa chia lớp xếp lên đĩa, rắc sợi gừng, rau thơm vào, rót nước gia vị lên khi ăn trộn đều là được.', 'Thanh nhiệt, giải độc, lợi thủy, giảm béo. Thích hợp với người bệnh tiểu đường, bệnh cao huyết áp và béo phig, nhất là người bị biến chứng bệnh huyết quản.\r\nChú ý: Người vị hàn ăn nhiều dễ đau bụng. Người già viêm phế quản mạn tính ở thời kỳ cấp tính kiêng ăn.', 60),
(34, 'Bánh canh thịt heo', 'Bánh canh: 500gr\r\nThịt đùi heo: 400gr\r\nBắp giò heo: 1 cái\r\nCà rốt: 1 củ, củ cải: 1củ, nấm rơm, rau mùi, hành lá, hành tím, tỏi.\r\nGiá đỗ, rau sống ăn kèm: xà lách, kinh giới, húng ...\r\nHạt nêm: 1thìa, nước mắm: 1 thìa, đường: 1/2 thìa, tiêu đen: 1/2 thìa, dầu ăn: 1 thìa.', 'Bước 1: Làm sạch thịt đùi heo và bắp giò heo đã mua, sau đó trần qua bằng nước sôi và xả sạch lại bằng nước. Nếu cẩn thận hơn có thể xát thêm muối hoặc rửa lại bằng nước muối để giò heo thật sạch. Tiếp đó, thái thịt thành các khúc đặt vừa nồi, một phần gồm cả xương và thịt còn sót lại chặt thành các khúc vừa ăn.\r\nBước 2: Giò heo đã được cắt thành khúc ở bước trên sẽ được hầm thật cẩn thận để tạo nước dùng cho món bánh canh thịt heo. Thêm các gia vị vào nồi nước dùng và đợi đến khi nước dùng đã được đun sôi cho cà rốt, củ cải vào nấu chung.\r\nBước 3: Đun sôi được khoảng 20 phút, rồi lấy thịt đùi ra ngoài ngâm với nước lọc để miếng thịt vẫn đảm bảo độ chín và trắng ngon mắt. Sau đó, bạn thái thật mỏng thịt đùi heo để riêng ra để lát sau cho vào tô.\r\nBước 4: Nước dùng ngon nhất là lúc giò heo đã mềm hẳn, bây giờ hãy thêm vào chút nấm rơm đã chuẩn bị. Điều chỉnh lại gia vị cho nước dùng thêm đậm đà vừa ăn.\r\nBước 5: Trong bước cuối này, trần sơ bánh canh rồi cho vào tô cùng với thịt đã thái mỏng, thêm cà rốt, nấm rơm hành lá, rau mùi và hành tỏi đã được phi thơm vàng cùng sốt nước dùng.', 'Cung cấp lượng cần thiết cho người bệnh tiều đường.\r\nChú ý: Khẩu phần ăn vừa phải.', 4),
(35, 'Hoành thánh', 'Thịt vai: 300gThịt nạc dăm: 200g\r\nTôm tươi: 200g\r\nTôm khô: 20g\r\nXương gà: 2 bộ\r\nLá hẹ: 1 bó nhỏ\r\nXốt ướp xá xíu: 1/2 gói\r\nSữa tươi: khoảng 100ml\r\nHành khô\r\nTỏi khô\r\nCác gia vị thường dùng: mắm, muối, hạt tiêu …\r\nVỏ hoành thánh: 200g', 'Làm thịt xá xíu.\r\n - Thịt vai rửa sạch, đem chần sơ với nước sôi rồi ướp cùng nước xốt, bột ngọt, hạt tiêu và sữa tươi. Cho thịt vào ngăn mát tủ lạnh ít nhất 3 tiếng để thịt thấm gia vị.\r\n - Tỏi khô đập dập, băm nhỏ.\r\n - Phi thơm tỏi với chút dầu ăn rồi cho thịt đã ướp, nước ướp vào nồi nấu. Khi nước xốt sôi, bạn hạ lửa nhỏ cho thịt chín dần.\r\n - Khi thịt chín, gắp thịt cho vào lò nướng đã làm nóng sẵn, nướng thịt khoảng 10 phút với nhiệt độ 200 độ C rồi lấy ra.\r\n - Đợi thịt nguội, cắt thành những miếng mỏng\r\nNấu nước dùng hoành thánh.\r\n - Xương gà rửa sạch, chặt nhỏ, chần sơ với nước sôi rồi cho vào nồi khác, đổ nước vào hầm trong khoảng 30 phút. Lọc lấy phần nước dùng để riêng.\r\nLàm hoành thánh.\r\n - Hành khô đập dập, băm nhỏ.\r\n - Thịt nạc dăm rửa sạch, chần sơ, để ráo rồi băm nhuyễn. Ướp thịt với hành tím, bột ngọt, hạt tiêu.\r\n - Tôm tươi rửa sach, lột vỏ, bỏ đầu, lấy chỉ đen ở sống lưng cho tôm bớt tanh. Ướp tôm với hành tím, bột ngọt, hạt tiêu.\r\n - Trải miếng vỏ hoành thánh lên một mặt phẳng, múc thịt heo dàn mỏng rồi cho một con tôm, một hạt tiêu và giữa (bạn có thể không dùng hạt tiêu). Bóp hai mép để định hình hoành thánh, làm lần lượt cho tới hết.\r\nNấu hoành thánh.\r\n - Lá hẹ rửa sạch, cắt khúc ngắn.\r\n - Tôm khô ngâm nước ấm cho mềm.\r\n - Phi thơm tỏi và tôm khô, cho tất cả vào nồi nước dùng gà rồi nấu lại. Khi nước dùng sôi, lần lượt cho hoành thánh vào nồi. Hoành thánh nổi lên là chín, bạn nêm nếm vừa ăn rồi tắt bếp.\r\nThành phẩm món ăn.\r\n - Múc hoành thánh và nước dùng ra tô, thêm thịt xá xíu, lá hẹ lên trên rồi ăn nóng.', 'Cung cấp lượng tinh bột vừa phải cho người bệnh tiểu đường.', 5),
(36, 'Thanh long', '', '', 'Thanh long chứa nhiều chất nhầy pectin, chất xơ hòa tan và chất xơ không tan cellulose đều là chất có tác dụng phòng trị bệnh táo bón, béo phì, xơ vữa động mạch, viêm ruột kết... rất hiệu quả.\r\nLượng chất xơ dồi dào trong thanh long có thể kiểm soát lượng đường trong máu và ngăn ngừa nguy cơ mắc bệnh tiểu đường.\r\nTrái cây này rất giàu chất béo không bão hòa đơn giúp trái tim được nghỉ ngơi trong tình trạng tốt nhất. Ăn thanh long cũng có thể giúp làm sạch hệ tiêu hóa. \r\nLưu ý: chỉ nên ăn tối đa 1 quả thanh long mỗi ngày và tuyệt đối không nên ăn vào buổi tối.', 19),
(37, 'Nước bưởi', '', '', 'Nước bưởi có những thành phần tựa như insulin giúp hạ đường huyết đồng thời hỗ trợ bệnh nhân đái tháo đường và cao huyết áp.\r\nNgười mắc bệnh tiểu đường nên ăn trung bình khoảng 2 đến 4 múi bưởi một ngày để cải thiện lượng đường huyết.', 15),
(38, '', '', '', 'Bắp là một nguồn năng lượng, chất xơ, vitamin, khoáng chất, lại ít chất béo và natri. Để có thể hấp thu được những dưỡng chất trong bắp, đồng thời ngăn dung nạp carbohydrate quá mức, bệnh nhân phải theo dõi lượng đã ăn đến từng gram.\r\nChống ung thư hiệu quả.\r\nTăng cường sức khỏe hệ tiêu hóa.\r\nTốt cho não.\r\nTốt cho mắt.', 13),
(39, 'Canh rau dền', '200g rau dền\r\n30g tôm khô\r\n2 tép tỏi băm\r\nGia vị: muối, bột ngọt, hạt nêm, tiêu', 'Bước 1: Sơ chế nguyên liệu\r\nRau dền sau khi mua về, nhặt lá, rồi rửa sạch với nước.\r\nCho tôm khô vào chén nhỏ với một ít nước ấm, ngâm trong 5 phút để tôm khô nở mềm. Tôm khô sẽ làm cho canh ngon, ngọt nước hơn.\r\nBước 2: Nấu canh\r\nBắc một cái nồi lên bếp với lửa nhỏ, cho vào đó một ít dầu. Khi dầu trong nồi sôi, cho phần tỏi vào, phi cho vàng thơm.\r\nTiếp đó, bạn cho tôm khô vào, xào khoảng 1 phút để tôm khô dậy mùi thơm, rồi cho vào nồi 1 lít nước, đậy nắp lại đun ở lửa vừa.\r\nKhi nước trong nồi đã sôi, mở nắp ra, vớt bỏ phần bọt, rồi cho rau dền vào, nêm nếm với gia vị, rồi tắt bếp.', 'Rau dền chứa hàm lượng chất xơ cao (gấp 3 lần so với lúa mì). Do đó, nó có thể giúp bạn cải thiện hệ tiêu hóa và ngăn ngừa táo bón. Đây còn là loại rau rất tốt cho trẻ em và người lớn tuổi. Nước nấu từ lá cây dền tươi còn hỗ trợ điều trị tiêu chảy, xuất huyết và mất nước.', 69),
(40, 'Canh rau dền', '200g rau dền\r\n30g tôm khô\r\n2 tép tỏi băm\r\nGia vị: muối, bột ngọt, hạt nêm, tiêu', 'Bước 1: Sơ chế nguyên liệu\r\nRau dền sau khi mua về, nhặt lá, rồi rửa sạch với nước.\r\nCho tôm khô vào chén nhỏ với một ít nước ấm, ngâm trong 5 phút để tôm khô nở mềm. Tôm khô sẽ làm cho canh ngon, ngọt nước hơn.\r\nBước 2: Nấu canh\r\nBắc một cái nồi lên bếp với lửa nhỏ, cho vào đó một ít dầu. Khi dầu trong nồi sôi, cho phần tỏi vào, phi cho vàng thơm.\r\nTiếp đó, bạn cho tôm khô vào, xào khoảng 1 phút để tôm khô dậy mùi thơm, rồi cho vào nồi 1 lít nước, đậy nắp lại đun ở lửa vừa.\r\nKhi nước trong nồi đã sôi, mở nắp ra, vớt bỏ phần bọt, rồi cho rau dền vào, nêm nếm với gia vị, rồi tắt bếp.', 'Rau dền chứa hàm lượng chất xơ cao (gấp 3 lần so với lúa mì). Do đó, nó có thể giúp bạn cải thiện hệ tiêu hóa và ngăn ngừa táo bón. Đây còn là loại rau rất tốt cho trẻ em và người lớn tuổi. Nước nấu từ lá cây dền tươi còn hỗ trợ điều trị tiêu chảy, xuất huyết và mất nước.', 43),
(41, 'Canh bí đao', '1 quả bí đao\r\n10g tôm nõn\r\nHành lá, ngò\r\nGia vị các loại', 'Bí xanh gọt vỏ, bỏ ruột, rửa sạch với nước rồi thái thành các miếng nhỏ vừa ăn.\r\nTôm tươi lột vỏ, bỏ đầu và chân, chỉ giữ lại phần nõn tôm. Rửa sạch nõn tôm và giã cho tôm hơi dập.\r\nƯớp tôm với một chút muối, nước mắm, đường, hạt tiêu, bột nêm, để khoảng 15 phút để tôm ngấm gia vị.\r\nPhi hành với một chút dầu ăn, sau đó cho tôm vào xào qua. Thêm lượng nước cho vừa đủ.\r\nĐun nước sôi thì vớt hết bọt, cho bí xanh vào nấu chín rồi nêm lại gia vị cho vừa ăn.', 'Chữa tiêu khát do nhiệt tích (bệnh tiểu đường).', 42),
(42, 'Canh bí đao', '1 quả bí đao\r\n10g tôm nõn\r\nHành lá, ngò\r\nGia vị các loại', 'Bí xanh gọt vỏ, bỏ ruột, rửa sạch với nước rồi thái thành các miếng nhỏ vừa ăn.\r\nTôm tươi lột vỏ, bỏ đầu và chân, chỉ giữ lại phần nõn tôm. Rửa sạch nõn tôm và giã cho tôm hơi dập.\r\nƯớp tôm với một chút muối, nước mắm, đường, hạt tiêu, bột nêm, để khoảng 15 phút để tôm ngấm gia vị.\r\nPhi hành với một chút dầu ăn, sau đó cho tôm vào xào qua. Thêm lượng nước cho vừa đủ.\r\nĐun nước sôi thì vớt hết bọt, cho bí xanh vào nấu chín rồi nêm lại gia vị cho vừa ăn.', 'Chữa tiêu khát do nhiệt tích (bệnh tiểu đường).', 68),
(43, 'Bánh cuốn', ' Bột gạo 200 g\r\n Trứng gà 5 trái\r\n Bột năng 100 g\r\n Thịt heo xay 200 g\r\n Hành tây 1 củ\r\n Củ sắn 1 củ\r\n Hành tím 5 củ\r\n Nấm mèo 10 gr\r\n Nước cốt chanh 1 muỗng canh\r\n Ớt thái lát 1 muỗng cà phê\r\n Tỏi băm 1 muỗng cà phê', '\r\nBước 1: Sơ chế các nguyên liệu\r\n  - Nấm mèo ngâm nước ấm cho nở rồi rửa sạch, băm nhỏ.Hành tím và hành tây bóc vỏ, rửa sạch rồi băm nhỏ.\r\n  - Củ sắn bỏ vỏ, rửa sạch sau đó cắt hạt lựu nhỏ.\r\n  - Thịt xay trộn đều với 1 muỗng canh hạt nêm, ướp khoảng 10 phút cho ngấm.\r\nBước 2: Xào nhân\r\n  - Làm nóng chảo, thêm vào 1 muỗng canh dầu ăn rồi đổ phần thịt xay, nấm mèo, hành tây, hành tím, củ sắn vào chảo xào chín.\r\nBước3: Làm vỏ bánh\r\n  - Lấy một chiếc thau nhỏ, trộn đều bột năng và bột gạo với 1 lít nước, để hỗn hợp bột lắng trong khoảng 1 giờ, đánh dấu mức nước rồi gạn phần nước trong đổ đi.\r\n  - Tiếp theo đổ nước lạnh vào thau bột đúng bằng mức đã đánh dấu, khuấy đều. Tiếp tục để bột lắng thêm lần nữa là có thể tráng bánh.\r\n  - Đánh tan 5 trái trứng gà, lọc trứng qua rây rồi đổ từ từ vào hỗn hợp bột ở trên khuấy đều.\r\nBước 4: Tráng bánh\r\n  - Dùng một chiếc chảo có độ chống dính tốt, đặt lên bếp, làm nóng chảo sau đó múc hỗn hợp bột trứng vào tráng một lớp đều mỏng.\r\n  - Đậy nắp chảo, chờ 1-2 phút bột chín lấy ra trải lên mâm, múc nhân thịt lên dàn đều rồi cuốn lại. Làm lần lượt cho đến hết nguyên liệu.\r\nBước 5: Làm nước mắm\r\n  - Pha nước mắm chấm theo công thức sau: Khuấy đều 1 muỗng canh nước cốt chanh, 2 muỗng canh đường, 3 muỗng canh nước mắm, 4 muỗng canh nước, 1 muỗng cà phê tỏi băm và ớt thái lát.\r\nBước 6: Thành phẩm\r\n  - Bày bánh cuốn ra đĩa, dùng kéo cắt thành khúc vừa ăn, khi ăn chan lên nước mắm và ăn kèm các loại chả, rau thơm, dưa leo cắt nhỏ, hành tím phi vàng,... hoặc ăn bánh cuốn không tùy theo sở thích.', 'Cung cấp lượng tinh bột cho người bệnh tiểu đường.\r\nLưu ý: Chế độ ăn và lượng thức ăn phải hợp lý.', 6),
(44, 'Cháo đậu đỏ', '100 gam đậu đỏ\r\n1/2 lon gạo\r\n14 bát nước\r\n1/2 muỗng muối\r\nMuối mè\r\nNước cốt dừa', 'Bước 1: Ngâm khoảng 4 - 5 giờ hoặc qua đêm.\r\nBước 2: Cho đậu vào nồi, cho thêm 5 bát nước và nấu ở lửa vừa khoảng 1 - 2 giờ (dùng nồi áp suất sẽ nhanh hơn), kiểm tra xem đậu mềm vừa nứt vỏ thì cho gạo vào, cho thêm 8 - 10 bát nước và nấu lửa vừa, nhớ thỉnh thoảng đảo đều cháo. Nấu đến khi cả gạo và đậu bung mềm quyện vào nhau là xong. Trong lúc nấu cho 1/2 muỗng muối.\r\nBước 3: Dùng cùng nước cốt dừa hoặc muối mè rất ngon và thanh mát cơ thể.', 'Phòng chống chứng tiêu khát trong bệnh tiểu đường', 7),
(45, 'Nấm hương đậu phụ', 'Đậu phụ     250g\r\nNấm hương   100g\r\nMuối, xì dầu, mì chính, dầu mè.', 'Đậu phụ rửa sạch thái miếng. Cho vào nồi, cho tiếp nấm hương, muối và nước lã vào đun lửa vừa khi sôi giảm nhỏ lửa hầm 15 phút, cho xì dầu, mì chính, dầu mè vào. Dùng liều lượng phù hợp, không dùng khi còn quá nóng.', 'Dùng cho bệnh nhân tiểu đường trung tiêu, có tác dụng thanh vị, giảm hỏa, dưỡng âm, sinh nước bọt.', 59),
(46, 'Nấm hương đậu phụ', 'Đậu phụ 250g\r\nNấm hương 100g\r\nMuối, xì dầu, mì chính, dầu mè.', 'Đậu phụ rửa sạch thái miếng. Cho vào nồi, cho tiếp nấm hương, muối và nước lã vào đun lửa vừa khi sôi giảm nhỏ lửa hầm 15 phút, cho xì dầu, mì chính, dầu mè vào. Dùng liều lượng phù hợp, không dùng khi còn quá nóng.', 'Dùng cho bệnh nhân tiểu đường trung tiêu, có tác dụng thanh vị, giảm hỏa, dưỡng âm, sinh nước bọt.', 35),
(47, 'Canh bầu ', '1 quả bầu non \r\n300 gam tôm bạc\r\nHành tím, hành lá \r\nGia vị: muối, hạt nêm, tiêu xay, nước mắm, đường, bột ngọt', 'Bước 1: Chuẩn bị nguyên liệu\r\n - Tôm: Khi mua về  rửa sạch, bóc vỏ. Bóc vỏ xong thì đem ướp với chút gia vị, hạt nêm, đường và chút tiêu.\r\n - Bầu: Chọn quả bầu non không quá già để khi nấu nước bầu sẽ ngon và ngọt hơn. Bầu đem gọt vỏ rồi thái miếng vừa ăn, nếu quả bầu non vừa ngon thì để cả ruột cũng được.\r\nBước 2: Nấu canh bầu tôm tươi \r\n - Bắt nồi lên bếp cho vào ít dầu ăn, sau đó cho thêm ít hành tím băm nhuyễn vào phi thơm rồi cho tôm đã ướp gia vị vào đảo đều cho thịt tôm chín vàng và có mùi thơm.\r\n - Khi tôm chín cho bầu và 1 muỗng cà phê hạt nêm vào đảo cùng đến khi thấy miếng bầu tái thì đổ nước sôi đun sẵn vào đun. Khi nước sôi trở lại thì cho hành lá cắt khúc vào rồi tắt bếp.\r\nBước 3: Hoàn thành \r\n - Canh chín, mút canh ra cho thêm một ít tiêu lên để cho món canh thêm dậy mùi.', '- Cung cấp dinh dưỡng cần thiết cho cơ thể.\r\n- Ngăn ngừa các bệnh về tim mạch.\r\n- Hỗ trợ giảm cân hiệu quả.', 40),
(48, 'Canh bầu ', '1 quả bầu non \r\n300 gam tôm bạc\r\nHành tím, hành lá \r\nGia vị: muối, hạt nêm, tiêu xay, nước mắm, đường, bột ngọt', 'Bước 1: Chuẩn bị nguyên liệu\r\n - Tôm: Khi mua về  rửa sạch, bóc vỏ. Bóc vỏ xong thì đem ướp với chút gia vị, hạt nêm, đường và chút tiêu.\r\n - Bầu: Chọn quả bầu non không quá già để khi nấu nước bầu sẽ ngon và ngọt hơn. Bầu đem gọt vỏ rồi thái miếng vừa ăn, nếu quả bầu non vừa ngon thì để cả ruột cũng được.\r\nBước 2: Nấu canh bầu tôm tươi \r\n - Bắt nồi lên bếp cho vào ít dầu ăn, sau đó cho thêm ít hành tím băm nhuyễn vào phi thơm rồi cho tôm đã ướp gia vị vào đảo đều cho thịt tôm chín vàng và có mùi thơm.\r\n - Khi tôm chín cho bầu và 1 muỗng cà phê hạt nêm vào đảo cùng đến khi thấy miếng bầu tái thì đổ nước sôi đun sẵn vào đun. Khi nước sôi trở lại thì cho hành lá cắt khúc vào rồi tắt bếp.\r\nBước 3: Hoàn thành \r\n - Canh chín, mút canh ra cho thêm một ít tiêu lên để cho món canh thêm dậy mùi.', '- Cung cấp dinh dưỡng cần thiết cho cơ thể.\r\n- Ngăn ngừa các bệnh về tim mạch.\r\n- Hỗ trợ giảm cân hiệu quả.', 66),
(49, 'Cá chép chưng tương', 'Cá: 1 con cá diêu hồng khoảng 700g\r\nMộc nhĩ (Nấm tai mèo) : 5 tai\r\nNấm đông cô: 10 cái\r\nCần tây: 3 nhánh\r\nCà chua: 1 quả\r\nHành tây: 1 củ\r\nBún tàu: 1 lọn lớn\r\nGừng, ớt cay\r\nGia vị: Hạt nêm, đường, muối, tương hột…\r\nRau sống ăn kèm ', 'Bước 1: Sơ chế nguyên liệu\r\n - Cá diêu hồng rửa sạch, cắt vây, bỏ vảy, khứa vài đường 2 bên thân cá để ướp vào cá 2 muỗng cà phê hạt nêm, để khoảng 15 phút cho cá thấm gia vị. \r\n - Nấm đông cô bỏ cuống, rửa sạch, ngâm với nước ấm cho nở rồi thái làm hai.\r\n - Nấm mèo ngâm nước ấm, bỏ cuống, rửa sạch rồi thái sợi.\r\n - Cà chua, hành tây rửa sạch, thái múi cau.\r\n - Cần tây rửa sạch để ráo nước.\r\n - Gừng (1 củ nhỏ) cạo vỏ, xắt sợi nhỏ, tỏi băm nhuyễn\r\n - Bún tàu cho vào nước ngâm mềm rồi vớt ra để ráo\r\n - Rau sống sửa sạch\r\nBước 2: Cách làm món cá chưng tương đơn giản\r\n - Sau khi cá đã được tẩm ướp gia vị đầy đủ thì bạn cho cá vào chảo dầu chiên vàng hai mặt. Trút cá ra ngoài để ráo dầu.\r\n - Làm nóng chảo, cho tí dầu ăn vào, đợi dầu nóng thì cho tỏi băm vào phi thơm.Cho tiếp tương hột vào xào, nêm vào tương 2 muỗng cà phê hạt nêm, 1 muỗng cà phê muối, 2 muỗng cà phê đường, ½ muỗng cà phê bột ngọt.\r\n - Tiếp đến cho nấm đông cô và nấm mèo vào xào thấm. Sau đó cho cà chua và hành tây vào đảo đều chừng 5 phút cho cà chua chín, nguyên liệu ngấm vị của nhau\r\n - Tiếp đó cho cá vào chảo, để lửa thật nhỏ cho cá thấm gia vị, thêm ớt xắt khoanh nếu thích.\r\n - Nêm nếm lại cho vừa ăn rồi cho bún tàu vào chảo. Để khoảng một phút thì tắt bếp, cho cần tây vào ngay.', 'Lợi tiểu rất phù hợp bới người bệnh tiểu đường, mỡ trong máu cao, bệnh tim, béo phì.', 63),
(50, 'Cá chép chưng tương', 'Cá: 1 con cá diêu hồng khoảng 700g\r\nMộc nhĩ (Nấm tai mèo) : 5 tai\r\nNấm đông cô: 10 cái\r\nCần tây: 3 nhánh\r\nCà chua: 1 quả\r\nHành tây: 1 củ\r\nBún tàu: 1 lọn lớn\r\nGừng, ớt cay\r\nGia vị: Hạt nêm, đường, muối, tương hột…\r\nRau sống ăn kèm ', 'Bước 1: Sơ chế nguyên liệu\r\n - Cá diêu hồng rửa sạch, cắt vây, bỏ vảy, khứa vài đường 2 bên thân cá để ướp vào cá 2 muỗng cà phê hạt nêm, để khoảng 15 phút cho cá thấm gia vị. \r\n - Nấm đông cô bỏ cuống, rửa sạch, ngâm với nước ấm cho nở rồi thái làm hai.\r\n - Nấm mèo ngâm nước ấm, bỏ cuống, rửa sạch rồi thái sợi.\r\n - Cà chua, hành tây rửa sạch, thái múi cau.\r\n - Cần tây rửa sạch để ráo nước.\r\n - Gừng (1 củ nhỏ) cạo vỏ, xắt sợi nhỏ, tỏi băm nhuyễn\r\n - Bún tàu cho vào nước ngâm mềm rồi vớt ra để ráo\r\n - Rau sống sửa sạch\r\nBước 2: Cách làm món cá chưng tương đơn giản\r\n - Sau khi cá đã được tẩm ướp gia vị đầy đủ thì bạn cho cá vào chảo dầu chiên vàng hai mặt. Trút cá ra ngoài để ráo dầu.\r\n - Làm nóng chảo, cho tí dầu ăn vào, đợi dầu nóng thì cho tỏi băm vào phi thơm.Cho tiếp tương hột vào xào, nêm vào tương 2 muỗng cà phê hạt nêm, 1 muỗng cà phê muối, 2 muỗng cà phê đường, ½ muỗng cà phê bột ngọt.\r\n - Tiếp đến cho nấm đông cô và nấm mèo vào xào thấm. Sau đó cho cà chua và hành tây vào đảo đều chừng 5 phút cho cà chua chín, nguyên liệu ngấm vị của nhau\r\n - Tiếp đó cho cá vào chảo, để lửa thật nhỏ cho cá thấm gia vị, thêm ớt xắt khoanh nếu thích.\r\n - Nêm nếm lại cho vừa ăn rồi cho bún tàu vào chảo. Để khoảng một phút thì tắt bếp, cho cần tây vào ngay.', 'Lợi tiểu rất phù hợp bới người bệnh tiểu đường, mỡ trong máu cao, bệnh tim, béo phì.', 31),
(51, 'Cá hú kho', '500g cá hú\r\nNước dừa\r\n5 nhánh tiêu xanh\r\nHành khô, tỏi\r\nHành lá\r\nHạt nêm, bột ngọt, nước mắm, đường, tiêu', 'Bước 1: Sơ chế nguyên liệu\r\n – Hành khô và tỏi bạn đem bóc vỏ, băm nhỏ.\r\n – Cá bạn sơ chế sạch, rồi cắt khúc. Sau đó, cho cá ướp với nước màu, hành tỏ băn, 2 muỗng nước mắm, 1 muỗng đường, ít bột ngọt, tiêu rồi trộn đều lên. Ướp cá khoảng 20 phút cho ngấm đều gia vị.\r\n – Ớt thái lát.\r\n – Tiêu xanh rửa sạch để nguyên nhán.\r\nBước 2: Kho cá hú\r\n – Xếp cá hú vào nồi đất, rồi cho tiêu sọ vào cùng, kho lửa vừa khoảng 3 phút cho cá săn lại. Lúc này, cho nước lọc vào và vặn lửa nhỏ liu riu, đậy kín nắp.\r\nBước 3: Làm nước sốt kho cá hú\r\n – Dùng một chảo khác, cho dầu ăn vào rồi cho hành tỏi băm nhỏ vào phi thơm cùng ít ớt bột. Sau đó, rưới đều lên mặt cá hú. Tiếp tục kho khoảng 30 phút nữa, nêm nếm gia vị cho vừa ăn rồi tắt bếp.', 'Làm giảm Cholesterol có hại trong máu, tốt cho bệnh nhân tiểu đường.', 32),
(52, 'Cá hú kho', '500g cá hú\r\nNước dừa\r\n5 nhánh tiêu xanh\r\nHành khô, tỏi\r\nHành lá\r\nHạt nêm, bột ngọt, nước mắm, đường, tiêu', 'Bước 1: Sơ chế nguyên liệu\r\n – Hành khô và tỏi bạn đem bóc vỏ, băm nhỏ.\r\n – Cá bạn sơ chế sạch, rồi cắt khúc. Sau đó, cho cá ướp với nước màu, hành tỏ băn, 2 muỗng nước mắm, 1 muỗng đường, ít bột ngọt, tiêu rồi trộn đều lên. Ướp cá khoảng 20 phút cho ngấm đều gia vị.\r\n – Ớt thái lát.\r\n – Tiêu xanh rửa sạch để nguyên nhán.\r\nBước 2: Kho cá hú\r\n – Xếp cá hú vào nồi đất, rồi cho tiêu sọ vào cùng, kho lửa vừa khoảng 3 phút cho cá săn lại. Lúc này, cho nước lọc vào và vặn lửa nhỏ liu riu, đậy kín nắp.\r\nBước 3: Làm nước sốt kho cá hú\r\n – Dùng một chảo khác, cho dầu ăn vào rồi cho hành tỏi băm nhỏ vào phi thơm cùng ít ớt bột. Sau đó, rưới đều lên mặt cá hú. Tiếp tục kho khoảng 30 phút nữa, nêm nếm gia vị cho vừa ăn rồi tắt bếp.', 'Làm giảm Cholesterol có hại trong máu, tốt cho bệnh nhân tiểu đường.', 64),
(53, 'Thịt bò xào nấm rơm', '300 gam thịt bò thăn\r\n300 gam nấm rơm\r\n100 gam cần tây\r\n2 củ tỏi\r\nHành tây: 1 củ\r\nCà rốt: 1 củ\r\nGừng tươi: 1 củ\r\nGia vị: mắm, muối, hạt tiêu, hạt nêm, dầu ăn, nước tương', 'Bước 1: Sơ chế nguyên liệu\r\n - Thịt bò rửa sạch, dùng dao thái miếng mỏng. Ướp thịt bò cùng với gia vị gồm: gừng tươi và hạt tiêu, thêm 1 chút nước tương cho thịt bò mềm ra và thêm đậm đà.\r\n - Nấm rơm rửa sạch, cắt bỏ phần gốc, ngâm nước muối trong vòng 15 phút cho sạch đất cát rồi bổ đôi.\r\n - Cần tây ngâm muối và rửa sạch, sau đó cắt thành đoạn dài khoảng 4 cm.\r\n - Hành tây: Bóc vỏ, bỏ rễ, thái nhỏ.\r\n - Cà rốt: Rửa sạch, gọt vỏ, thái thành khoanh tròn.\r\n - Tỏi: Bóc vỏ, đập dập.\r\nBước 2: Xào thịt bò với nấm\r\n - Phi thơm tỏi trong chảo rồi cho thịt bò vào xào lửa lớn, nêm thêm muối, hạt nêm cho vừa miệng.\r\n - Xào bò cho đến khi chín tái thì cho nấm rơm và cần tây, hành tây, cà rốt vào đảo cùng. Đảo đều tay cho đến khi các nguyên liệu đều chín, nêm nếm lại gia vị lần cuối rồi tắt bếp.\r\n - Trút thịt bò xào nấm rơm ra dĩa, rắc thêm ít hạt tiêu và thưởng thức.', 'Chứa lượng natri thấp, có tác dụng ức chế cohlesterol tăng cao trong huyết thanh và gan, giảm huyết áp và chống xơ cứng động mạch, có tác dụng chữa bệnh tiểu đường.', 30),
(54, 'Thịt bò xào nấm rơm', '300 gam thịt bò thăn\r\n300 gam nấm rơm\r\n100 gam cần tây\r\n2 củ tỏi\r\nHành tây: 1 củ\r\nCà rốt: 1 củ\r\nGừng tươi: 1 củ\r\nGia vị: mắm, muối, hạt tiêu, hạt nêm, dầu ăn, nước tương', 'Bước 1: Sơ chế nguyên liệu\r\n - Thịt bò rửa sạch, dùng dao thái miếng mỏng. Ướp thịt bò cùng với gia vị gồm: gừng tươi và hạt tiêu, thêm 1 chút nước tương cho thịt bò mềm ra và thêm đậm đà.\r\n - Nấm rơm rửa sạch, cắt bỏ phần gốc, ngâm nước muối trong vòng 15 phút cho sạch đất cát rồi bổ đôi.\r\n - Cần tây ngâm muối và rửa sạch, sau đó cắt thành đoạn dài khoảng 4 cm.\r\n - Hành tây: Bóc vỏ, bỏ rễ, thái nhỏ.\r\n - Cà rốt: Rửa sạch, gọt vỏ, thái thành khoanh tròn.\r\n - Tỏi: Bóc vỏ, đập dập.\r\nBước 2: Xào thịt bò với nấm\r\n - Phi thơm tỏi trong chảo rồi cho thịt bò vào xào lửa lớn, nêm thêm muối, hạt nêm cho vừa miệng.\r\n - Xào bò cho đến khi chín tái thì cho nấm rơm và cần tây, hành tây, cà rốt vào đảo cùng. Đảo đều tay cho đến khi các nguyên liệu đều chín, nêm nếm lại gia vị lần cuối rồi tắt bếp.\r\n - Trút thịt bò xào nấm rơm ra dĩa, rắc thêm ít hạt tiêu và thưởng thức.', 'Chứa lượng natri thấp, có tác dụng ức chế cohlesterol tăng cao trong huyết thanh và gan, giảm huyết áp và chống xơ cứng động mạch, có tác dụng chữa bệnh tiểu đường.', 62),
(55, 'Canh cải ngọt', '150g tôm tươi\r\n1 bó cải ngọt\r\nHành tím\r\nGừng\r\nGia vị: Nước mắm, bột canh, hạt nêm, bột ngọt, hạt tiêu.', 'Bước 1: Cải ngọt bỏ lá già, lá úa, ngâm nước muối pha loãng khoảng 10 phút. Sau đó rửa lại bằng nước sạch, để ráo, cắt khúc vừa ăn.\r\nBước 2: Tôm tươi bóc vỏ, bỏ chỉ đen sống lương, cho vào cối giã thô. Ướp tôm cùng nước mắm + hạt nêm + bột canh + hạt tiêu trong 15 phút để tôm ngấm gia vị.\r\nBươc 3: Hành khô lột vỏ, băm nhỏ. Gừng bào vỏ, thái sợi chỉ.\r\nBước  4: Đặt nồi lên bếp, đun nóng dầu ăn, phi thơm hành + gừng. Cho tôm ướp vào xào chín. Sau đó thêm nước vào để nấu canh.\r\nBước 4: Khi nước canh sôi, cho rau cải ngọt vào. Đợi nồi canh sôi lại, nêm gia vị vừa ăn, đun tiếp khoảng 2 phút rồi tắt bếp.', 'Bảo vệ tốt hệ miễn dịch, đường tiêu hóa, có tác dụng tốt cho người bệnh tiểu đường.', 67),
(56, 'Canh cải ngọt', '150g tôm tươi\r\n1 bó cải ngọt\r\nHành tím\r\nGừng\r\nGia vị: Nước mắm, bột canh, hạt nêm, bột ngọt, hạt tiêu.', 'Bước 1: Cải ngọt bỏ lá già, lá úa, ngâm nước muối pha loãng khoảng 10 phút. Sau đó rửa lại bằng nước sạch, để ráo, cắt khúc vừa ăn.\r\nBước 2: Tôm tươi bóc vỏ, bỏ chỉ đen sống lương, cho vào cối giã thô. Ướp tôm cùng nước mắm + hạt nêm + bột canh + hạt tiêu trong 15 phút để tôm ngấm gia vị.\r\nBươc 3: Hành khô lột vỏ, băm nhỏ. Gừng bào vỏ, thái sợi chỉ.\r\nBước  4: Đặt nồi lên bếp, đun nóng dầu ăn, phi thơm hành + gừng. Cho tôm ướp vào xào chín. Sau đó thêm nước vào để nấu canh.\r\nBước 4: Khi nước canh sôi, cho rau cải ngọt vào. Đợi nồi canh sôi lại, nêm gia vị vừa ăn, đun tiếp khoảng 2 phút rồi tắt bếp.', 'Bảo vệ tốt hệ miễn dịch, đường tiêu hóa, có tác dụng tốt cho người bệnh tiểu đường.', 41),
(57, 'Thịt kho trứng', 'Thịt heo: 500g, nên chọn loại ba chỉ có nhiều nạc hoặc thịt mông.\r\nTrứng gà: 8 quả (có thể thay thế bằng trứng cút).\r\nHành lá: 100g.\r\nNước dừa tươi: 100ml.\r\nỚt trái đỏ: 3 quả.', 'Bước 1: Sơ chế nguyên liệu\r\n - Hành khô, tỏi: làm sạch, băm nhuyễn.\r\n - Thịt heo: làm sạch, rửa qua với nước muối, để ráo, cắt miếng vừa ăn dạng hình hộp chữ nhật. Sau đó, ướp thịt với 1/2 thìa hạt nêm, 1 thìa nước mắm, 1 thìa bột ngọt, 1/2 thìa đường, 1/2 thài tỏi, 1/2 thìa hành, 1/2 thìa tiêu trong 30 phút để thịt ngấm gia vị và đừng quên 1 thìa dầu ăn để thịt nhanh thấm gia vị hơn.\r\n - Trứng gà: luộc chín, ngâm trong nước lạnh cho dễ bóc vỏ, để ráo nước và chiến sơ qua với dầu để trứng có màu vàng nhẹ đẹp mắt và ngon hơn khi ăn.\r\n - Làm nước màu: cho 2 thìa đường và 2 thìa nước, đun nóng trên chảo với lửa nhỏ đến khi đường tan chuyển sang màu vàng cánh gián là được.\r\n - Hành lá: Làm sạch, thái mịn.\r\n - Ớt trái: 1 quả tỉa hoa trang trí, 2 quả thái lát theo chiều xiên của quả ớt.\r\nBước 2: Thực hiện món thịt kho trứng\r\n - Phi thơm 1/2 thìa hành, 1/2 thìa tỏi với dầu ăn và 1/2 thìa ớt bột (hoặc bột điều);\r\n - Cho thịt vào đảo đều tay để thịt thăn lại, các gia vị ngấm đều vào nhau;\r\n - Tiếp đó, cho 100ml nước dừa tươi và trứng gà đã chiên vàng vào, rưới nhẹ nước màu đã chuẩn bị sẵn lên trên thịt và trứng;\r\n - Vặn lửa nhỏ, đảo nhẹ tay đến khi thịt và trứng chín đều, nước kho thịt vừa sền sệt bao quanh trứng, thịt là được.\r\n - Tắt bếp, rắc hành lá, hạt tiêu lên trên là hoàn thành món thịt kho trứng thơm ngon.', 'Cho nhiều chất dinh dưỡng, món ăn giàu chất béo, phù hợp đối với bệnh nhân tiểu đường muốn tăng cân.\r\nChú ý: Khẩu phần ăn hợp lý', 29),
(58, 'Thịt kho trứng', 'Thịt heo: 500g, nên chọn loại ba chỉ có nhiều nạc hoặc thịt mông.\r\nTrứng gà: 8 quả (có thể thay thế bằng trứng cút).\r\nHành lá: 100g.\r\nNước dừa tươi: 100ml.\r\nỚt trái đỏ: 3 quả.', 'Bước 1: Sơ chế nguyên liệu\r\n - Hành khô, tỏi: làm sạch, băm nhuyễn.\r\n - Thịt heo: làm sạch, rửa qua với nước muối, để ráo, cắt miếng vừa ăn dạng hình hộp chữ nhật. Sau đó, ướp thịt với 1/2 thìa hạt nêm, 1 thìa nước mắm, 1 thìa bột ngọt, 1/2 thìa đường, 1/2 thài tỏi, 1/2 thìa hành, 1/2 thìa tiêu trong 30 phút để thịt ngấm gia vị và đừng quên 1 thìa dầu ăn để thịt nhanh thấm gia vị hơn.\r\n - Trứng gà: luộc chín, ngâm trong nước lạnh cho dễ bóc vỏ, để ráo nước và chiến sơ qua với dầu để trứng có màu vàng nhẹ đẹp mắt và ngon hơn khi ăn.\r\n - Làm nước màu: cho 2 thìa đường và 2 thìa nước, đun nóng trên chảo với lửa nhỏ đến khi đường tan chuyển sang màu vàng cánh gián là được.\r\n - Hành lá: Làm sạch, thái mịn.\r\n - Ớt trái: 1 quả tỉa hoa trang trí, 2 quả thái lát theo chiều xiên của quả ớt.\r\nBước 2: Thực hiện món thịt kho trứng\r\n - Phi thơm 1/2 thìa hành, 1/2 thìa tỏi với dầu ăn và 1/2 thìa ớt bột (hoặc bột điều);\r\n - Cho thịt vào đảo đều tay để thịt thăn lại, các gia vị ngấm đều vào nhau;\r\n - Tiếp đó, cho 100ml nước dừa tươi và trứng gà đã chiên vàng vào, rưới nhẹ nước màu đã chuẩn bị sẵn lên trên thịt và trứng;\r\n - Vặn lửa nhỏ, đảo nhẹ tay đến khi thịt và trứng chín đều, nước kho thịt vừa sền sệt bao quanh trứng, thịt là được.\r\n - Tắt bếp, rắc hành lá, hạt tiêu lên trên là hoàn thành món thịt kho trứng thơm ngon.', 'Cho nhiều chất dinh dưỡng, món ăn giàu chất béo, phù hợp đối với bệnh nhân tiểu đường muốn tăng cân.\r\nChú ý: Khẩu phần ăn hợp lý', 61),
(59, 'Khoai lang', '', 'a', 'Với lượng calo thấp, khoai lang có khả năng cân bằng hàm lượng insulin trong cơ thể, giảm lượng đường trong máu. Vì vậy loại củ này rất an toàn đối với bệnh nhân tiểu đường. \r\nKhoai lang còn có tác dụng cải thiện tiêu hóa cho bệnh nhân tiểu đường.', 9),
(60, 'cơm', '', '', 'Bổ sung lượng tinh bột cho cơ thể cho bệnh nhân tiểu đường.\r\nChú ý:  Tính toán chính xác nhu cầu năng lượng của cơ thể để cung cấp lượng tinh bột hợp lý.', 22),
(61, 'cơm', '', '', 'Bổ sung lượng tinh bột cho cơ thể cho bệnh nhân tiểu đường.\r\nChú ý: Tính toán chính xác nhu cầu năng lượng của cơ thể để cung cấp lượng tinh bột hợp lý.', 48),
(62, 'Bún bò', '300 gam thịt bò\r\n500 gam xương heo\r\n5 cây sả\r\n3 củ hành tím\r\n2 củ tỏi\r\n3 muỗng canh dầu đậu phộng\r\n1/2 trái chanh\r\n1 trái ớt\r\n0.5 kg bún tươi\r\nGia vị', '- Hành tím, tỏi lột vỏ băm nhỏ. Sả lấy gốc cắt mỏng rồi băm nhỏ. Cho dầu vô chảo cho hành tỏi, sả vô phi thơm, tắt bếp rồi cho ớt bột vô lấy màu.\r\n- Rửa xương với nước muối cho sạch, luộc sơ qua rồi thay nước. Nấu xương với nhỏ lửa cho ra được vị ngọt của xương, lấy thân cây sả cho vào nấu chung để tăng thêm hương vị. Nêm muối, đường, hạt nêm theo khẩu vị. Cho dầu đã khử màu vô.\r\n- Thịt bò cắt mỏng. Cho bún và thịt bò vào tô, thêm nước trụng thịt vào tô. Rồi múc thêm nước cho đầy tô, bỏ thêm hành ngò, ớt lên và ăn trong lúc vẫn còn nóng sẽ ngon hơn.', 'Cung cấp chất dinh dưỡng cần thiết cho bệnh nhân tiểu đường.', 8),
(63, 'Mì quảng', '0,5 kg gà ta\r\n5 quả trứng cút\r\n200g mì Quảng\r\n100g bắp chuối\r\n50gcải bẹ xanh\r\n50ghúng quế, húng lủi\r\n100g giá đỗ\r\n50g củ nén\r\n2 cái bánh đa (bánh tráng)\r\n1 quả chanh2 quả ớt\r\n1 củ hành tím\r\n1 xủ gừng\r\n50g đậu phộng rang\r\nGia vị: Nước mắm, muối, đường, hạt nêm, tiêu, dầu điều, bột ngọt, dầu ăn.', 'Bước 1: Sơ chế nguyên liệu\r\n - Đầu tiên, chà xát muối lên bề mặt thịt gà rồi rửa lại nhiều lần với nước để khử mùi tanh. Sau đó, lóc xương gà, chặt thành từng miếng nhỏ vừa ăn.\r\n - Tiếp đó, đập dập củ nén, băm nhỏ. Với hành tím, bóc vỏ, rửa sạch, cắt lát mỏng. Gọt vỏ gừng, rửa sạch, cắt sợi chỉ, nhặt cuống ớt, loại bỏ hạt rồi đập dập.\r\nBước 2: Ướp thịt gà\r\n - Tiếp theo, cho thịt gà vừa chặt vào trong thau lớn, thêm củ nén, gừng, hành tím, ớt, dầu điều, muối, bột ngọt, tiêu vào trộn đều. Cách nấu mì quảng ngon nhất là ướp thịt gà với gia vị trong vòng 15-20 phút.\r\nBước 3: Sơ chế các loại rau ăn kèm\r\n - Sau đó, chẻ bắp chuối chẻ làm đôi, cắt lát mỏng cho vào tô nước đá có cho sẵn vài lát chanh, ngâm khoảng 10 phút, vớt ra rửa lại bằng nước sạch, để ráo nước. Đây là mẹo đơn giản giúp cho bắp chuối không bị thâm đen.\r\n - Lần lượt nhặt bỏ lá ùa vàng, gốc rễ của các loại rau ăn kèm, rửa với nước muối pha loãng để trên rổ cho ráo nước.\r\nBước 4: Cách nấu nước dùng mì Quảng\r\n - Tiếp theo, chần sơ xương gà qua với nước nóng để khử đi mùi tanh, rửa lại với nước lạnh. Cho xương gà vào nồi nước, bắc lên bếp ninh để tạo vị ngọt tự nhiên cho món ăn.\r\n - Sau đó, bắc nồi có sẵn 2 muỗng dầu ăn lên bếp đun sôi. Khi dầu nóng, cho củ nén vào phi thơm rồi cho thịt gà đã ướp vào xào săn lại, thêm một ít nước dùng xương gà vào cùng, nấu với lửa vừa.\r\nBước 5: Hoàn thành và trình bày\r\n - Tiếp đến, xếp các loại rau ăn kèm và bắp chuối lên đĩa sao cho đẹp mắt.\r\n - Cuối cùng, bày mì Quảng vào tô, thêm một ít rau lên mặt, cho vài quả trứng cút vào, múc thịt gà vào tô, sau đó rưới một ít nước xào gà lên trên. Thêm ít đậu phộng rang lên trên bát là đã hoàn thành cách làm mì Quảng tại nhà.', 'Cung cấp chất dinh dưỡng cần thiết cho bệnh nhân tiểu đường.', 50),
(64, 'Mì quảng', '0,5 kg gà ta\r\n5 quả trứng cút\r\n200g mì Quảng\r\n100g bắp chuối\r\n50gcải bẹ xanh\r\n50ghúng quế, húng lủi\r\n100g giá đỗ\r\n50g củ nén\r\n2 cái bánh đa (bánh tráng)\r\n1 quả chanh2 quả ớt\r\n1 củ hành tím\r\n1 xủ gừng\r\n50g đậu phộng rang\r\nGia vị: Nước mắm, muối, đường, hạt nêm, tiêu, dầu điều, bột ngọt, dầu ăn.', 'Bước 1: Sơ chế nguyên liệu\r\n - Đầu tiên, chà xát muối lên bề mặt thịt gà rồi rửa lại nhiều lần với nước để khử mùi tanh. Sau đó, lóc xương gà, chặt thành từng miếng nhỏ vừa ăn.\r\n - Tiếp đó, đập dập củ nén, băm nhỏ. Với hành tím, bóc vỏ, rửa sạch, cắt lát mỏng. Gọt vỏ gừng, rửa sạch, cắt sợi chỉ, nhặt cuống ớt, loại bỏ hạt rồi đập dập.\r\nBước 2: Ướp thịt gà\r\n - Tiếp theo, cho thịt gà vừa chặt vào trong thau lớn, thêm củ nén, gừng, hành tím, ớt, dầu điều, muối, bột ngọt, tiêu vào trộn đều. Cách nấu mì quảng ngon nhất là ướp thịt gà với gia vị trong vòng 15-20 phút.\r\nBước 3: Sơ chế các loại rau ăn kèm\r\n - Sau đó, chẻ bắp chuối chẻ làm đôi, cắt lát mỏng cho vào tô nước đá có cho sẵn vài lát chanh, ngâm khoảng 10 phút, vớt ra rửa lại bằng nước sạch, để ráo nước. Đây là mẹo đơn giản giúp cho bắp chuối không bị thâm đen.\r\n - Lần lượt nhặt bỏ lá ùa vàng, gốc rễ của các loại rau ăn kèm, rửa với nước muối pha loãng để trên rổ cho ráo nước.\r\nBước 4: Cách nấu nước dùng mì Quảng\r\n - Tiếp theo, chần sơ xương gà qua với nước nóng để khử đi mùi tanh, rửa lại với nước lạnh. Cho xương gà vào nồi nước, bắc lên bếp ninh để tạo vị ngọt tự nhiên cho món ăn.\r\n - Sau đó, bắc nồi có sẵn 2 muỗng dầu ăn lên bếp đun sôi. Khi dầu nóng, cho củ nén vào phi thơm rồi cho thịt gà đã ướp vào xào săn lại, thêm một ít nước dùng xương gà vào cùng, nấu với lửa vừa.\r\nBước 5: Hoàn thành và trình bày\r\n - Tiếp đến, xếp các loại rau ăn kèm và bắp chuối lên đĩa sao cho đẹp mắt.\r\n - Cuối cùng, bày mì Quảng vào tô, thêm một ít rau lên mặt, cho vài quả trứng cút vào, múc thịt gà vào tô, sau đó rưới một ít nước xào gà lên trên. Thêm ít đậu phộng rang lên trên bát là đã hoàn thành cách làm mì Quảng tại nhà.', 'Cung cấp chất dinh dưỡng cần thiết cho bệnh nhân tiểu đường.', 24);
INSERT INTO `recipes` (`id`, `name`, `ingredient`, `recipe`, `benefit`, `groupID`) VALUES
(65, 'Bún mọc', 'Sườn non: 400 gam (chọn miếng sườn còn tươi, thịt có độ đàn hồi)\r\nXương ống: 300 gam \r\nBún tươi (sợi nhỏ): 700 gam \r\nChả lụa: 200 gam \r\nGiò sống: 200 gam \r\nMộc nhĩ: 4 cái\r\nHành lá, rau mùi, hành tím, tỏi băm\r\nRau sống: tía tô, húng quế, rau diếp\r\nGia vị: Muối, hạt nêm, nước mắm, hạt tiêu', 'Bước 1: Sơ chế nguyên liệu\r\n - Với phần xương ống thì bạn rửa thật sạch rồi trụng sơ qua nồi nước sôi. Sau đó, cho vào nồi nước mới với 2 muỗng café muối + 2 muỗng café hạt nêm + 1 muỗng café nước mắm và để lửa vừa hầm xương. Lưu ý: khi hầm xương bạn nhớ canh vớt bọt để nước dùng được trong.\r\n - Phần sườn thăn bạn có thể rửa qua với nước muối để cho khử hoàn toàn mùi hôi của thịt. Sau đó xả với nước lạnh và chặt thành các miếng vừa ăn, bạn nêm với chút xíu tiêu xay + 1 muỗng canh hạt nêm và 1/3 muỗng canh nước mắm. Để yên phần thịt sườn trong khoảng 15 phút cho chúng thấm gia vị.\r\n - Mộc nhĩ bạn rửa sạch rồi ngâm nước cho nở mềm rồi băm nhỏ.\r\n - Bạn cắt chả lụa thành những miếng vừa ăn.\r\n - Bún tươi bạn trụng sơ qua nước sôi rồi để ráo.\r\n - Các loại rau sống bạn nhặt và rửa sạch, để ráo.\r\nBước 2: Sơ chế giò sống\r\n - Nếu bạn mua giò sống chưa được nêm nếp thì có thể nêm chút gia vị, hành lá, tiêu xay trộn đều rồi cho phần nấm nhĩ bên trên vào và trộn đều.\r\n - Hoặc bạn có thể sử dụng thịt heo rồi cho vào cối xay nhuyễn, nêm nếm với gia vị đều được. Sau đó, vo hỗn hợp giò sống và mộc nhĩ thành những viên mọc nhỏ.\r\nBước 3: Cách nấu nước dùng bún mọc\r\n - Bắc chảo lên bếp, cho chút xíu dầu ăn vào, đợi cho dầu nóng thì cho hành tím, tỏi băm vào phi cho thơm rồi cho tiếp phần sườn thăn vào xào đến khi thịt vừa săn lại thì tắt bếp.\r\n - Khi nồi nước hầm xương vừa sôi tới thì bạn cho phần sườn vừa xào vào nồi, tiếp tục đun cho đến khi sôi lần nữa thì bạn thả mọc vào nồi và nêm nếm cho khẩu vị vừa ăn. Bạn tiếp tục để nồi nước nấu khoảng 10 phút là mọc sẽ chín.\r\nBước 4: Hoàn tất món ăn\r\n - Bạn múc bún vào tô và múc sườn thăn, rắc thêm chút hành lá và rau mùi, xếp vài miếng chả. Cuối cùng, chan nước dùng lên thật đều là hoàn tất món bún.\r\n - Bún mọc ăn kèm rau sống, chanh, ớt và có người còn thích dùng với mắm tôm.', 'Cung cấp lượng tinh bột cho người bệnh tiểu đường.', 23),
(66, 'Bún mọc', 'Sườn non: 400 gam (chọn miếng sườn còn tươi, thịt có độ đàn hồi)\r\nXương ống: 300 gam \r\nBún tươi (sợi nhỏ): 700 gam \r\nChả lụa: 200 gam \r\nGiò sống: 200 gam \r\nMộc nhĩ: 4 cái\r\nHành lá, rau mùi, hành tím, tỏi băm\r\nRau sống: tía tô, húng quế, rau diếp\r\nGia vị: Muối, hạt nêm, nước mắm, hạt tiêu', 'Bước 1: Sơ chế nguyên liệu\r\n - Với phần xương ống thì bạn rửa thật sạch rồi trụng sơ qua nồi nước sôi. Sau đó, cho vào nồi nước mới với 2 muỗng café muối + 2 muỗng café hạt nêm + 1 muỗng café nước mắm và để lửa vừa hầm xương. Lưu ý: khi hầm xương bạn nhớ canh vớt bọt để nước dùng được trong.\r\n - Phần sườn thăn bạn có thể rửa qua với nước muối để cho khử hoàn toàn mùi hôi của thịt. Sau đó xả với nước lạnh và chặt thành các miếng vừa ăn, bạn nêm với chút xíu tiêu xay + 1 muỗng canh hạt nêm và 1/3 muỗng canh nước mắm. Để yên phần thịt sườn trong khoảng 15 phút cho chúng thấm gia vị.\r\n - Mộc nhĩ bạn rửa sạch rồi ngâm nước cho nở mềm rồi băm nhỏ.\r\n - Bạn cắt chả lụa thành những miếng vừa ăn.\r\n - Bún tươi bạn trụng sơ qua nước sôi rồi để ráo.\r\n - Các loại rau sống bạn nhặt và rửa sạch, để ráo.\r\nBước 2: Sơ chế giò sống\r\n - Nếu bạn mua giò sống chưa được nêm nếp thì có thể nêm chút gia vị, hành lá, tiêu xay trộn đều rồi cho phần nấm nhĩ bên trên vào và trộn đều.\r\n - Hoặc bạn có thể sử dụng thịt heo rồi cho vào cối xay nhuyễn, nêm nếm với gia vị đều được. Sau đó, vo hỗn hợp giò sống và mộc nhĩ thành những viên mọc nhỏ.\r\nBước 3: Cách nấu nước dùng bún mọc\r\n - Bắc chảo lên bếp, cho chút xíu dầu ăn vào, đợi cho dầu nóng thì cho hành tím, tỏi băm vào phi cho thơm rồi cho tiếp phần sườn thăn vào xào đến khi thịt vừa săn lại thì tắt bếp.\r\n - Khi nồi nước hầm xương vừa sôi tới thì bạn cho phần sườn vừa xào vào nồi, tiếp tục đun cho đến khi sôi lần nữa thì bạn thả mọc vào nồi và nêm nếm cho khẩu vị vừa ăn. Bạn tiếp tục để nồi nước nấu khoảng 10 phút là mọc sẽ chín.\r\nBước 4: Hoàn tất món ăn\r\n - Bạn múc bún vào tô và múc sườn thăn, rắc thêm chút hành lá và rau mùi, xếp vài miếng chả. Cuối cùng, chan nước dùng lên thật đều là hoàn tất món bún.\r\n - Bún mọc ăn kèm rau sống, chanh, ớt và có người còn thích dùng với mắm tôm.', 'Cung cấp lượng tinh bột cho người bệnh tiểu đường.', 49),
(67, 'Sữa chua', '', '', 'Giúp tăng cường sức đề kháng và hệ miễn dịch của cơ thể, giảm lượng cholesterol, giúp giảm nguy cơ tiểu đường.', 14),
(68, 'Quýt', 'Quýt trái to', 'Quýt + Xoài', 'Giúp giảm nồng độ đường có trong máu, tăng sự nhạy cảm của insulin trong tế bào.', 16),
(69, 'Vú sữa', '', '\r\n', 'Giảm lượng đường trong máu cho người bệnh.\r\nChú ý: Nên ăn với mức vừa phải.', 18),
(70, 'Mãng cầu xiêm', '', '', 'Mãng cầu xiêm có rất nhiều giá trị cụ thể như cải thiện hệ tiêu hóa, bảo vệ hệ thống xương và răng, tăng cường hệ miễn dịch và cung cấp năng lượng dồi dào cho cơ thể, chữa bệnh trĩ, chữa đau bụng kinh, làm đẹp da, thanh nhiệt cơ thể, đề phòng cao huyết áp.\r\nChú ý: Ăn với lượng nhỏ.', 17),
(71, 'Bún riêu cua', 'Bún tươi 200g gam\r\nCua đồng xay 500 gam\r\nGiò sống 100 gam\r\nHuyết heo 200 gam\r\nĐậu hũ 150 gam\r\nTôm khô 50 gam\r\nMực khô 30 gam\r\nLòng đỏ trứng gà 1 cái\r\nMỡ heo 50g gam\r\nHành tím 50 gr\r\nHành lá 20 gam\r\nCà chua 100 gam\r\nRau ăn kèm 300 gam\r\nMắm tôm 20 gam\r\nDầu điều 1 muỗng canh\r\nNước mắm 20 ml\r\nGia vị 1 ít: tiêu, hạt nêm, muối, đường, bột ngọt.', 'Bước 1: Sơ chế cua đồng\r\n - Cua ngâm nước khoảng 1 tiếng để loại bỏ hết đất cát, xả lại nước sạch. Lột yếm cua, mai cua và để riêng.\r\n - Dùng thìa nhỏ nạo lấy phần gạch cua cho vào chén, ướp với một ít tiêu xay, hạt nêm. Xay hoặc giã nhỏ phần yếm cua.\r\n - Cho cua xay vào một chiếc tô lớn ướp vào ít muối rồi hòa nước vào, dùng tay bóp nhẹ cho thịt cua tan vào với nước. Sau đó, dùng tay hoặc rây lọc bỏ xác cua lấy nước. Lược lấy khoảng 3.5 lít nước riêu cua là được.\r\nBước 2: Sơ chế các nguyên liệu khác\r\n - Mỡ heo rửa sạch, cắt thành từng miếng vuông nhỏ sau đó đem chiên vàng (tận dụng phần nước mỡ heo làm dầu để chiên các nguyên liệu khác). Đậu hũ cắt nhỏ mang đi chiên vàng.\r\n - Hành lá rửa sạch 1 nửa cắt nhỏ còn 1 nửa cắt khúc khoảng 3cm. Hành tím lột vỏ cắt lát.\r\n - Cà chua rửa sạch, cắt múi cau. Huyết heo đem luộc sơ lại với nước cho sạch và cắt khúc vừa ăn.\r\n - Tôm khô và mực khô ngâm nước khoảng 30 phút, sau đó đem mực cắt nhỏ rồi chiên vàng cùng với tôm khô.\r\nBước 3: Phi hành tím\r\n - Cho vào chảo lòng sâu 150ml dầu ăn (hoặc tận dụng phần nước mỡ heo nếu nhiều) đun nóng, rồi cho hành tím đã cắt lát vào chiên vàng.\r\n - Sau khi hành chín vàng thì cho phần tóp mỡ đã thắng vào chiên sơ rồi vớt ra để ráo.\r\nBước 4: Xào gạch cua\r\n - Phần gạch cua đã tách riêng ra, bạn cho vào chảo cùng với 1 muỗng canh nước mỡ heo và xào chín.\r\nBước 5: Làm và hấp chả\r\n - Cho vào tô 100gam giò sống, 2 cái lòng đỏ trứng gà, 1 muỗng cà phê bột ngọt, 1 ít hành lá cắt nhỏ cùng với một ít nước riêu cua đã lọc và trộn đều.\r\n - Sau đó cho phần hỗn hợp này vào khuôn cùng với khoảng 100ml nước riêu cua đã lọc và đem hấp khoảng 30 - 40 phút cho phần chả cua chín.\r\nBước 6: Xào cà chua\r\n - Bắc chảo lên bếp cùng với một ít nước mỡ heo đun nóng, cho cà chua đã cắt múi cau, 1 muỗng canh dầu điều vào xào sơ khoảng 5 phút.\r\nBước 7: Nấu nước dùng\r\n - Phần mực và tôm đã chiên sẵn cho vào nồi, cùng với phần xác cua đã bọc kĩ bằng vải. Thêm vào nồi 1.5 lít nước và nấu khoảng 30 - 40 phút để tôm mực và xác cua ra được chất ngọt.\r\n - Vớt xác bỏ, lúc này trong nồi còn khoảng 1 lít nước dùng, tiếp tục đổ thêm 3 lít nước riêu cua đã lọc vào nồi nấu trên lửa nhỏ để riêu cua từ từ tạo thành váng thịt và nổi lên mặt nước.\r\n - Sau đó cho phần cà chua, đậu hũ, huyết heo, hành lá cắt khúc, gạch cua còn lại vào nồi nêm gia vị gồm: 60gr đường, 1 ít bột ngọt, 20ml nước mắm, 1 ít hạt nêm, tiêu và 20gam mắm tôm khuấy đều.\r\nBước 8: Thành phẩm\r\n - Cho bún vào tô, cắt phần chả riêu cua hấp thành những miếng vừa ăn, chan nước riêu cùng cà chua, huyết, đậu hũ và hành lá vào thưởng thức ngay thôi nào.', 'Cung cấp lượng tinh bột cho người bệnh.\r\nChú ý: Khẩu phần ăn hợp lý.', 10),
(72, 'Bánh Flan', '', '', 'Cải thiện phản ứng insulin và kiểm soát đường huyết.\r\nChú ý: Dùng với lượng vừa phải.', 11),
(73, '', '', '', 'Giúp kiểm soát đường huyết và cung cấp lượng tinh bột cho người tiểu đường.\r\nChú ý: Dùng với lượng vừa phải.', 12);

-- --------------------------------------------------------

--
-- Table structure for table `sports`
--

CREATE TABLE `sports` (
  `id` int(11) NOT NULL,
  `name` varchar(1000) CHARACTER SET utf8 NOT NULL,
  `image` varchar(2000) DEFAULT NULL,
  `technique` varchar(2000) CHARACTER SET utf8 DEFAULT NULL,
  `benefit` varchar(2000) CHARACTER SET utf32 DEFAULT NULL,
  `note` varchar(5000) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sports`
--

INSERT INTO `sports` (`id`, `name`, `image`, `technique`, `benefit`, `note`) VALUES
(1, 'Đi bộ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTz1UzXvV1GfLfiSWdKwYUlgMDfNu0RdNA4uA&usqp=CAU', '- Đối với quãng đường 200-600m: Tốc độ 100m/2-3 phút, sau mỗi 100m nghỉ từ 2-3 phút.\r\n- Đối với quãng đường 400-800m: Tốc độ 100m/3-4 phút, sau mỗi 100-200m nghỉ 3-4 phút.\r\n- Đối với quãng đường 800-1500m: Cả quãng đường đi trong khoảng 15-18 phút, nghỉ 1-3 lần với mỗi lần 3-5 phút.\r\n- Chia thành hai đoạn, mỗi đoạn 1000m: Đi trong khoảng 10-20 phút mỗi đoạn, giữa chừng nghỉ 1-3 lần với mỗi lần 3-5 phút.\r\n- Đối với quãng đường 2000m: Đi trong khoảng 20-30 phút, nghỉ 1-2 lần hoặc đi liên tục không nghỉ.', 'Đi bộ là bài tập đơn giản nhưng lại có hiệu quả cao, giúp giãn gân cốt, thông kinh mạch. Người tiểu đường nên đi bộ ở những địa hình bằng phẳng, không khí trong lành, yên tĩnh. Mới đầu nên đi với tốc độ 60-100 bước/phút, sau có thể đi với quãng đường dài hơn, thời gian lâu hơn', 'Người tiểu đường nên tập đi từ những quãng đường ngắn trước. Sau khi cơ thể đã thích nghi với cường độ luyện tập mới chuyển sang quãng đường dài.'),
(2, 'Chạy chậm', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc1yZvrdfNWC_T1BfEQHfTXuwDXR93AjbcXw&usqp=CAU', '- Chạy với tốc độ 100-200m/phút và chạy trong khoảng thời gian 10 phút.\r\n- Tư thế chạy: Hai bàn tay nắm chặt, cánh tay thả lỏng, không nhắc chân quá cao, tiếp đất bằng mũi bàn chân, ổn định trọng tâm cơ thể.\r\n- Trong lúc chạy người hơi đưa về phía trước, cơ bắp thả lỏng, thẳng lưng, giữ cơ thể cân bằng, chân tiếp đất nhẹ nhàng. Mắt nhìn về phía trước, khuỷu tay hơi gập lại, thả lỏng toàn thân.\r\n- Vừa chạy vừa phải phối hợp điều chỉnh hít thở. Hít vào bằng mũi, thở ra bằng miệng.\r\n- Chạy chậm dần khi muốn kết thúc tập, không dừng đột ngột. Thở đều, hít thở sâu vài lần, dùng tay xoa mặt, tai để máu dễ lưu thông.', 'Chạy chậm là bài tập thể dục chữa tiểu đường hiệu quả. Bài tập này đơn giản lại không tốn quá nhiều sức nhưng vẫn giúp cơ thể được vận động. Ngoài ra, chạy chậm còn giúp giảm lượng mỡ trong máu, tăng cường trao đổi chất, tăng khả năng miễn dịch, tăng cường quá trình tiêu hóa…', '- Nên chạy mỗi ngày một lần hoặc chạy cách ngày.\r\n- Nên chạy vào buổi sáng.'),
(3, 'Bơi lội', 'https://thaythuocvietnam.vn/wp-content/uploads/2018/05/_d_improd_/ti%E1%BB%83u-%C4%91%C6%B0%E1%BB%9Dng-b%C6%A1i-l%E1%BB%99i_f_improf_500x350.jpg', '- Đối với người mới bắt đầu, bơi ít nhất 3 lần/tuần với mỗi lần ít nhất 10 phút.\r\n- Sau một thời gian có thể tăng thời gian bơi tùy thuộc vào tình trạng cơ thể.\r\n- Lưu ý với cứu hộ về bệnh của mình trước khi bơi.\r\n- Ăn uống đầy đủ và thường xuyên kiểm tra mức đường huyết.', 'Bơi lội khiến các cơ giãn ra và nghỉ ngơi, các khớp không phải chịu những áp lực như những môn thể dục khác. Bên cạnh đó bộ môn này còn cải thiện nồng độ cholesterol, đốt cháy calo, giảm stress.', NULL),
(4, 'Yoga tư thế cây cầu', 'https://tieuduong.net/wp-content/uploads/2020/07/yoga-cho-nguoi-tieu-duong-2.jpg', 'Bạn nằm với tư thế thẳng trên thảm tập yoga.\r\nBắt đầu thở ra và lấy điểm tựa là bàn chân đẩy thân lên khỏi sàn.\r\nGiữ nguyên tư thế của cổ và đầu. Bạn có thể dùng tay để hỗ trợ thêm.\r\nNếu có thể bạn hãy nắm chặt ngón tay ngay phần dưới để có thể được căng thêm. Nhưng điều quan trọng ở đây là bạn không nên làm quá sức, gây tổn thương cho mình khi làm tư thế này.', 'Với tư thế này không chỉ giúp bạn kiểm soát chỉ số đường huyết mà còn giúp bạn thư giãn tâm trí, cải thiện tiêu hóa, giúp làm giảm các triệu chứng ở thời kỳ mãn kinhm, thư giãn cổ và cột sống.', NULL),
(5, 'Ngồi thiền chánh niệm', 'https://tieuduong.net/wp-content/uploads/2020/07/ngoi-thien-chua-benh-tieu-duong-3.jpg', 'Thiền chánh niệm là cách thiền mà bạn bắt buộc phải tập trung hoàn toàn vào hơi thở khi ngồi thiền. \r\nNếu sự tập trung cho hơi thở bị gián đoạn bởi tiếng chuông cửa, chuông điện thoại, tiếng đồng hồ tích tắc, âm thanh của ai đó đang nói…thì hãy cố gắng tập trung lại để quay trở lại với nhịp thở.', 'Với cách ngồi thiền này thì quá trình thở không chỉ là trọng tâm duy nhất, mà nó còn giúp cho bạn duy trì nhận thức về thời điểm hiện tại. Từ đó khi nào bạn nhận thấy suy nghĩ của bản thân đang trôi đi thì đó là lúc giúp bạn duy trì được tâm hồn thanh thản nhất. Cũng là lúc bạn tập trung vào hiện tại, bỏ qua quá khứ và bớt đi những lo lắng trong tương lai. Điều này thực sự tốt cho người bệnh tiểu đường.', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password` varchar(50) NOT NULL,
  `signUpDate` datetime NOT NULL,
  `avatar` varchar(10000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `phone`, `password`, `signUpDate`, `avatar`) VALUES
(3, 'Tô Công Hậu', 'hauto@gmail.com', '0123456789', '3fc6172bc115a0056406ce9d45595243', '2020-10-19 00:00:00', 'https://firebasestorage.googleapis.com/v0/b/diabetes-app-1e8a7.appspot.com/o/avartar%2Fimage3?alt=media&token=9eb9c3dc-49f0-4f16-8712-b3605a226af3'),
(4, 'tọnkk', 'toconghauh@gmail.com e', '256666666666', '25f9e794323b453885f5181f1b624d0b', '2020-10-19 00:00:00', NULL),
(5, 'to cong hau', 'toconghauh@gmail.com1', '0397596861', '25f9e794323b453885f5181f1b624d0b', '2020-10-20 00:00:00', NULL),
(8, 'Trần Quốc Toàn', 'toantenx7@gmail.com', '', 'b02dd1f9ddf82871026edd1786c47ed3', '2020-10-26 00:00:00', NULL),
(10, 'toanten ', 'toantenx78@gmail.com', '0935270629', '03a9b8153c9f713fe3c6a69b4e4bacde', '2020-11-13 00:00:00', ''),
(11, 'toan ten', 'toantenx789@gmail.com', '0935269580', '25f9e794323b453885f5181f1b624d0b', '2020-11-13 00:00:00', ''),
(13, 'Trần Quốc Thắng', 'toantenx78900@gmail.com', '0935270629', '25f9e794323b453885f5181f1b624d0b', '2020-11-19 00:00:00', ''),
(27, 'tào tháo lưu bị', 'quoctoan0629@gmail.com', '0935270629', '25f9e794323b453885f5181f1b624d0b', '2020-12-06 00:00:00', 'https://firebasestorage.googleapis.com/v0/b/diabetes-app-1e8a7.appspot.com/o/avartar%2Fimage2020-12-07%2000%3A31%3A03.271538?alt=media&token=da5e38de-245c-424a-a3e2-5c605938aebc'),
(28, 'henry tran', 'quoctoan06290@gmail.com', '0935270629', '25f9e794323b453885f5181f1b624d0b', '2020-12-08 00:00:00', ''),
(29, 'baby shoroe el', 'quoctoan062900@gmail.com', '0935270629', '25f9e794323b453885f5181f1b624d0b', '2020-12-09 00:00:00', ''),
(30, 'pho duc', 'ducphoqn2020@gmail.com', '', 'b02dd1f9ddf82871026edd1786c47ed3', '2020-12-23 00:00:00', ''),
(31, 'TOAN TRAN QUOC', '16521265@gm.uit.edu.vn', '0935270629', 'b02dd1f9ddf82871026edd1786c47ed3', '2020-12-24 00:00:00', 'https://firebasestorage.googleapis.com/v0/b/diabetes-app-1e8a7.appspot.com/o/avartar%2Fimage2020-12-24%2023%3A37%3A06.629428?alt=media&token=8f962bfa-04aa-4b17-8654-925c5b8d6ae3');

-- --------------------------------------------------------

--
-- Table structure for table `weights`
--

CREATE TABLE `weights` (
  `id` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `tags` varchar(1000) CHARACTER SET utf8 DEFAULT NULL,
  `note` varchar(1000) CHARACTER SET utf8 DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `measureTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `weights`
--

INSERT INTO `weights` (`id`, `userID`, `tags`, `note`, `weight`, `measureTime`) VALUES
(3, 13, '[Trước bữa ăn, Tập thể dục, Nghỉ ngơi, Ở nhà]', 'test update weight', 80, '2020-11-20 14:13:00'),
(5, 13, '', '', 23, '2020-11-17 13:04:29'),
(6, 13, '', '', 188, '2020-11-17 13:05:16'),
(7, 13, '', '', 780, '2020-11-17 13:19:24'),
(8, 17, '', '', 111, '2020-11-17 13:20:26'),
(9, 12, '', '', 222.3, '2020-11-17 13:23:00'),
(10, 17, '', '', 44.3, '2020-11-17 13:29:50'),
(11, 13, '', '', 45, '2020-11-23 20:25:55'),
(12, 13, '', '', 55, '2020-11-23 20:36:43'),
(13, 13, '', '', 22, '2020-11-23 20:40:19'),
(14, 13, '', '', 25, '2020-12-06 11:56:03'),
(15, 13, '', '', 5, '2020-12-06 12:13:28'),
(16, 27, '[Ở nhà, Làm việc]', '', 25, '2020-12-13 20:55:54'),
(17, 13, '', '', 50, '2021-01-13 21:49:07'),
(18, 13, '', '', 30, '2021-01-13 21:49:45'),
(19, 13, '', '', 25, '2021-01-13 21:53:13'),
(20, 13, '', '', 60, '2021-01-13 21:53:36'),
(21, 13, '', '', 30, '2021-01-13 22:02:57'),
(22, 13, '', '', 60, '2021-01-13 22:04:34'),
(23, 13, '', '', 65, '2021-01-13 22:07:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activities`
--
ALTER TABLE `activities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carbs`
--
ALTER TABLE `carbs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `foods`
--
ALTER TABLE `foods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `glycemics`
--
ALTER TABLE `glycemics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `medicine`
--
ALTER TABLE `medicine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personalinfos`
--
ALTER TABLE `personalinfos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sports`
--
ALTER TABLE `sports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `weights`
--
ALTER TABLE `weights`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activities`
--
ALTER TABLE `activities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `carbs`
--
ALTER TABLE `carbs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `foods`
--
ALTER TABLE `foods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `glycemics`
--
ALTER TABLE `glycemics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `medicine`
--
ALTER TABLE `medicine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `personalinfos`
--
ALTER TABLE `personalinfos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `sports`
--
ALTER TABLE `sports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `weights`
--
ALTER TABLE `weights`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
