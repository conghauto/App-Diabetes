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
(2, 11.3, 15.5, 20, 16, 'Trước bữa ăn', 'Ăn xong', 1, '2020-11-16 01:14:52'),
(3, 15, 15, 15, 15, '', '', 12, '2020-11-17 18:09:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carbs`
--
ALTER TABLE `carbs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carbs`
--
ALTER TABLE `carbs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
