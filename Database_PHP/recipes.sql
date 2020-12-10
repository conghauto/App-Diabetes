-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 10, 2020 at 06:18 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.34

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
(14, 'Cháo yến mạch', 'Yến mạch miếng   50g', 'Cho yến mạch vào nồi, đổ thêm nước, nấu đến khi cháo chín nhừ là được.', 'Mớn ăn có công hiệu giảm mỡ trong máu, giảm đường, giảm béo.\r\nCháo yến mạch thích hợp với người bệnh tiểu đường, gan nhiễm mỡ, người béo phì.', 26),
(15, 'Cháo yến mạch', 'Yến mạch miếng 50g', 'Cho yến mạch vào nồi, đổ thêm nước, nấu đến khi cháo chín nhừ là được.', 'Mớn ăn có công hiệu giảm mỡ trong máu, giảm đường, giảm béo.\r\nCháo yến mạch thích hợp với người bệnh tiểu đường, gan nhiễm mỡ, người béo phì.', 52);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
