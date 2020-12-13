-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 13, 2020 at 03:14 PM
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
(73, 'Canh bí xanh thịt nạc', 1, 'chén', 103, 12, 3, 6, 2, 'dinner', 'high', 'https://toanhtc.files.wordpress.com/2020/12/canh-bi-dao-nau-thit-bam-recipe-main-photo.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `foods`
--
ALTER TABLE `foods`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `foods`
--
ALTER TABLE `foods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
