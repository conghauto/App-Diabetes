-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 18, 2020 at 11:31 AM
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
-- Table structure for table `weight`
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
-- Dumping data for table `weight`
--

INSERT INTO `weights` (`id`, `userID`, `tags`, `note`, `weight`, `measureTime`) VALUES
(3, 17, '', '', 12.3, '2020-11-17 10:52:48'),
(4, 17, '', '', 99, '2020-11-17 10:54:27'),
(5, 17, '', '', 23, '2020-11-17 13:04:29'),
(6, 17, '', '', 188, '2020-11-17 13:05:16'),
(7, 17, '', '', 78, '2020-11-17 13:19:24'),
(8, 17, '', '', 111, '2020-11-17 13:20:26'),
(9, 17, '', '', 222.3, '2020-11-17 13:23:00'),
(10, 17, '', '', 44.3, '2020-11-17 13:29:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `weight`
--
ALTER TABLE `weights`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `weight`
--
ALTER TABLE `weights`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
