-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 12, 2025 at 07:41 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `manystore`
--

-- --------------------------------------------------------

--
-- Table structure for table `users_table`
--

CREATE TABLE `users_table` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `user_email` varchar(30) NOT NULL,
  `user_password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users_table`
--

INSERT INTO `users_table` (`user_id`, `user_name`, `user_email`, `user_password`) VALUES
(34, 'khalid', 'ddd@gmail.com', '$2y$10$RPNVU.S.xih5ibDwS4IMIOJ'),
(35, '', '', '$2y$10$7EF5O8u6FJ9Jz9tUY8OJkOK'),
(36, 'khalid', 'dd@gmail.com', '$2y$10$VjyUAoJPtdp5TXfTKokP8OY'),
(37, 'khalid', 'khalid@gmali.com', '$2y$10$P2Y2uk0/56CdfcxuDvpIP.h'),
(38, 'AbdiFitaah', 'abdi@gmail.com', '$2y$10$8K2fIjZaCKQ8zNAefHGs8eT'),
(39, 'xasan', 'xasan@gmail.com', '$2y$10$JRgN6pehW65qSWlZ6YS8Duv'),
(40, 'ayuub', 'ayuub@gmail.com', '$2y$10$gZ1xhrFW2GcOG4jE7LN3S.l'),
(41, 'jawooc', 'jax@gmail.com', 'cewm;cfk;t,cm45w3pq\'mvptcq'),
(42, 'soodir', 'sood@gmail.com', 'Khaalidmohomudy');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users_table`
--
ALTER TABLE `users_table`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users_table`
--
ALTER TABLE `users_table`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
