-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 30, 2020 at 06:03 PM
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
  `name` varchar(1000) CHARACTER SET utf8 NOT NULL,
  `image` varchar(2000) DEFAULT NULL,
  `ingredient` varchar(5000) CHARACTER SET utf8 NOT NULL,
  `recipe` varchar(5000) CHARACTER SET utf8 NOT NULL,
  `benefit` varchar(5000) CHARACTER SET utf8 NOT NULL,
  `groupID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `foods`
--

INSERT INTO `foods` (`id`, `name`, `image`, `ingredient`, `recipe`, `benefit`, `groupID`) VALUES
(1, 'Nấm xào cải xanh và bắp non', 'https://yt.cdnxbvn.com/medias/uploads/35/35536-mon-an-cho-nguoi-benh-tieu-duong-1.jpg', '350g cải xanh: làm sạch và thái khúc\r\n6 tai nấm hương tươi: cắt bỏ cuống, ngâm qua nước muối pha loãng\r\n50g bắp non\r\n1 củ hành tím: lột vỏ và băm nhỏ\r\nGia vị: 1/3 muỗng cà phê muối, 1/2 muỗng cà phê bột ngọt và ít dầu ăn', 'Phi thơm hành tím với ít dầu, cho nấm vào xào. \r\nKhi nấm chuyển màu chín, cho tiếp phần bắp non và rau cải xanh vào xào cùng. \r\nNêm lại gia vị và tắt bếp.', 'Dùng cho người mắc bệnh tiểu đường kèm bệnh động mạch vành, mỡ máu cao hoặc cao huyết áp', 1),
(2, 'Nhộng tằm xào lá chanh', 'https://yt.cdnxbvn.com/medias/uploads/35/35537-mon-an-cho-nguoi-benh-tieu-duong-2.jpg', '100g nhộng tằm: rửa sạch và xóc ráo nước.\r\nVài lá chanh tươi: rửa sạch và thái sợi\r\nGia vị: 1/2 muỗng cà phê muối, 1/2 muỗng cá phê nước mắm ngon, 1/2 muỗng bột ngọt và 2 muỗng cà phê dầu ăn.', 'Làm nóng dầu, sau đó cho nhộng tằm vào xào săn với lửa nhỏ. \r\nKhi nhộng chín, nêm nếm gia vị và rắc lá chanh vào đảo đều. \r\nTắt bếp sau khoảng 3 phút.', 'Thích hợp với mọi loại bệnh tiểu đường vì nó có tác dụng giảm đường huyết hiệu quả.', 1),
(3, 'Thịt heo xào hành tây', 'https://yt.cdnxbvn.com/medias/uploads/35/35538-mon-an-cho-nguoi-benh-tieu-duong-3.jpg', '2 củ hành tây: lột vỏ và thái múi cau\r\n100g thịt nạc: thái mỏng\r\nĐầu hành lá: rửa sạch và băm nhỏ\r\nGia vị: 1 muỗng cà phê tương, 1/2 muỗng cà phê muối, 1/2 muỗng cà phê bột ngọt và 2 muỗng canh dầu', 'Phi thơm đầu hành với ít dầu nóng, sau đó cho thịt heo vào xào săn. \r\nKhi thịt chuyển săn, cho tiếp phần hành tây vào đảo đều. \r\nNấu khoảng 3 phút, nêm nếm gia vị và tiếp tục đảo đều thêm lần nữa trước khi tắt bếp.', 'Món này giúp ích thận, hạ đường huyết, phù hợp để dùng cho người mắc bị tiểu đường có các triệu chứng nóng gan hoặc mắc kèm bệnh thận, bàng quang.', 1),
(4, 'Nấm rơm xào thịt nạc', 'https://yt.cdnxbvn.com/medias/uploads/35/35553-mon-an-cho-nguoi-benh-tieu-duong-19.jpg', '300g nấm rơm tươi: rửa sạch, ngâm qua nước muối pha loãng và để ráo\r\n50g thịt nạc heo: thái nhỏ\r\n1 củ hành tím băm nhỏ\r\nGia vị: 1/2 muỗng cà phê muối, ½ muỗng cà phê bột ngọt và 2 muỗng cà phê dầu mè', 'Phi hành tím cho dậy thơm, sau đó trút phần thịt vào xào săn. Kế đến, cho nấm vào xào cùng. Sau khoảng 10 phút, nấm thấm vị thịt, nêm nếm lại gia vị và tắt bếp.', 'bổ khí dưỡng huyết, tăng sức đề kháng, thích hợp dùng người mắc bệnh tiểu đường kèm khí huyết hư nhược hoặc gan nhiễm mỡ.', 1),
(5, 'Thịt heo nạc xào cần tây', 'https://yt.cdnxbvn.com/medias/uploads/35/35539-mon-an-cho-nguoi-benh-tieu-duong-4.jpg', '50g thịt heo: rửa sạch và thái nhuyễn\r\n300g rau cần tây: cắt bỏ rễ, rửa sạch và cắt khúc\r\n1 quả trứng gà\r\n15g khoai mài khô: rửa qua nước và để ráo\r\nVài lát gừng tươi thái nhuyễn\r\n10 bột năng\r\n1 củ hành tím băm nhỏ\r\nGia vị: 1 muỗng cà phê muối, 1 muỗng cà phê bột ngọt và 2 muỗng cà phê dầu ăn.', 'Cho khoai mài vào chảo với ít nóng và xào đến đi chín mềm, sau đó cho cần tây và gừng vào đảo đều. Nêm với ít muối, bột ngọt cho vừa miệng trước khi tắt bếp.\r\n- Trộn đều phần thịt heo, bột năng với trứng gà và ít muối.\r\n- Khử dầu nóng với ít hành, sau đó cho hỗn hợp thịt vào đảo đều. Khi thịt chín, trút phần khoai đã xào vào đảo đều.', 'Giúp người mắc bệnh tiểu đường hạ đường huyết, đồng thời giúp hạ huyết áp đi kèm với bệnh.', 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
