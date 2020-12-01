-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2020 at 05:08 PM
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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `sports`
--
ALTER TABLE `sports`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sports`
--
ALTER TABLE `sports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
