-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 16, 2020 at 02:32 PM
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
(1, 12.12, '', '', '2020-11-16 01:09:09', 0),
(2, 12.2, '[Trong lúc hoạt động, Trước hoạt động]', '33232', '2020-11-16 01:14:52', 0),
(3, 12.1, '[Trước hoạt động, Trước bữa tối]', '3232', '2020-11-16 01:23:07', 0),
(4, 12.1, '[Trong lúc hoạt động, Trước hoạt động]', '1121', '2020-11-16 01:26:16', 0),
(5, 12.1, '[Trong lúc hoạt động, Trước hoạt động]', '1121', '2020-11-16 01:26:16', 0),
(6, 12.12, '[Trước hoạt động, Trước bữa tối]', '1212', '2020-11-16 01:32:29', 0),
(7, 11.21, '[Trước hoạt động, Trước bữa tối]', '112', '2020-11-16 01:34:45', 17),
(8, 1003, '[Trước hoạt động, Trước bữa tối]', '112', '2020-11-16 01:34:45', 17),
(9, 1004, '[Trước hoạt động, Trước bữa tối]', '112', '2020-11-16 01:34:45', 17),
(10, 12.212, '[Trong lúc hoạt động, Trước hoạt động]', 'ewewrwfdf', '2020-11-15 01:42:00', 17),
(11, 12121, '[Trước bữa tối, Trước hoạt động]', '332323', '2020-11-16 01:46:48', 17),
(12, 11, '', '', '2020-11-16 14:15:47', 17),
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
(24, 12, '[Trước hoạt động, Trước bữa tối]', '2323', '2020-11-16 20:28:27', 17);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `glycemics`
--
ALTER TABLE `glycemics`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `glycemics`
--
ALTER TABLE `glycemics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
