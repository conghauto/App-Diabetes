-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 18, 2020 at 06:12 PM
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
(2, 'tokuda', 'Tác dụng nhanh', 15, 12, '2020-11-18 22:58:42', 'Viên', ''),
(3, 'soko', '', 0, 12, '2020-11-18 22:59:38', 'Viên', ''),
(4, 'aa', '', 0, 12, '2020-11-18 23:02:57', '', ''),
(5, 'abc', '', 4, 12, '2020-11-18 23:09:31', '', ''),
(6, 'abc', 'Tác dụng nhanh', 45, 12, '2020-11-18 23:11:43', 'Viên', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `medicine`
--
ALTER TABLE `medicine`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `medicine`
--
ALTER TABLE `medicine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
