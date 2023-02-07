-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 07, 2023 at 12:08 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nli`
--

-- --------------------------------------------------------

--
-- Table structure for table `date tab`
--

CREATE TABLE `date tab` (
  `Date` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `date_1`
--

CREATE TABLE `date_1` (
  `Date` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `date_1`
--

INSERT INTO `date_1` (`Date`) VALUES
('1'),
('2'),
('3'),
('4'),
('5');

-- --------------------------------------------------------

--
-- Table structure for table `key`
--

CREATE TABLE `key` (
  `SRNO.` int(11) NOT NULL,
  `key_id` varchar(100) NOT NULL,
  `Rfid_key` varchar(100) NOT NULL,
  `Room` int(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `key`
--

INSERT INTO `key` (`SRNO.`, `key_id`, `Rfid_key`, `Room`) VALUES
(1, 'K-3011', 'rfid3011', 301),
(2, 'K-3012', 'rfid3012', 301),
(3, 'K-3021', 'rfid3021', 302),
(4, 'K-3022', 'rfid3022', 302),
(5, 'K-3031', 'rfid3031', 303);

-- --------------------------------------------------------

--
-- Table structure for table `krs1`
--

CREATE TABLE `krs1` (
  `k_n` int(100) NOT NULL,
  `date` date NOT NULL,
  `b_n` varchar(100) NOT NULL,
  `b_t` timestamp NOT NULL DEFAULT current_timestamp(),
  `r_n` varchar(100) NOT NULL,
  `r_t` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `krs1`
--

INSERT INTO `krs1` (`k_n`, `date`, `b_n`, `b_t`, `r_n`, `r_t`) VALUES
(809, '2022-04-14', 'john', '2022-04-14 09:27:37', 'smith', '2022-04-14 09:27:37');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `SRNO.` int(100) NOT NULL,
  `key_id` varchar(100) NOT NULL,
  `s_id` varchar(100) NOT NULL,
  `TimeIn` datetime NOT NULL DEFAULT current_timestamp(),
  `rs_id` varchar(1000) DEFAULT NULL,
  `TimeOut` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`SRNO.`, `key_id`, `s_id`, `TimeIn`, `rs_id`, `TimeOut`) VALUES
(5, 'K-3011', 'S-01', '2021-12-15 16:54:56', 'S-02', '2022-06-22 23:40:33'),
(4, 'K-3011', 'S-01', '2022-05-07 16:06:48', 'S-02', '2022-06-22 23:40:33'),
(16, 'K-3021', 'S-02', '2022-06-22 23:41:48', 's-02', '2022-07-04 18:51:18'),
(15, 'K-3011', 'S-02', '2022-06-22 23:41:13', NULL, NULL),
(9, 'K-3011', 'S-01', '2022-06-08 17:10:03', 'S-02', '2022-06-22 23:40:33'),
(10, 'K-3021', 'S-01', '2022-06-10 10:29:20', 'S-02', '2022-06-10 10:31:23'),
(11, 'K-3031', 'S-02', '2022-06-10 11:04:10', 'S-01', '2022-06-10 11:04:22'),
(12, 'K-3011', 'S-02', '2022-06-21 01:58:13', 'S-02', '2022-06-22 23:40:33'),
(13, 'K-3011', 'S-02', '2022-06-21 20:50:15', 'S-02', '2022-06-22 23:40:33'),
(14, 'K-3022', 'S-02', '2022-06-21 20:51:14', 'S-02', '2022-06-22 23:42:09');

-- --------------------------------------------------------

--
-- Stand-in structure for view `lv`
-- (See below for the actual view)
--
CREATE TABLE `lv` (
`SRNO.` int(100)
,`Room` int(100)
,`Bname` varchar(200)
,`Mobile` bigint(255)
,`TimeIn` datetime
);

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `SRNO` int(100) NOT NULL,
  `username` varchar(1000) NOT NULL,
  `password` varchar(1000) NOT NULL,
  `email` varchar(1000) NOT NULL,
  `mob` bigint(255) DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`SRNO`, `username`, `password`, `email`, `mob`, `type`, `status`) VALUES
(37, 'test1', '$2b$12$.ZAwaBd6YloPj9ujA9IiO.hpqZOIwF5mD6PzlENuGt3J0Mq/5Zk7G', 'test1@gmail.com', NULL, 0, 1),
(35, 'test2', '$2b$12$Kn3oF70FynVfm.xx96Kfpu6fpuft2jEwV/ssS8egvwVa88gSBlQgO', 'test2@gmail.com', 9876543218, 1, 1),
(36, 'test3', '$2b$12$7eeih22p7r0HKuPWzQxPKOvC08GOid4Gt2e.HCZuKLofUK8ZH/uv2', 'test3@gmail.com', NULL, 0, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `memberview`
-- (See below for the actual view)
--
CREATE TABLE `memberview` (
`SRNO` int(100)
,`username` varchar(1000)
,`password` varchar(1000)
,`email` varchar(1000)
,`mob` bigint(255)
,`type` tinyint(1)
,`status` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `rv`
-- (See below for the actual view)
--
CREATE TABLE `rv` (
`SRNO.` int(100)
,`Rname` varchar(200)
,`Mobile` bigint(255)
,`TimeOut` datetime
);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `SRNO` int(100) NOT NULL,
  `s_id` varchar(100) NOT NULL,
  `Rfid_s` varchar(100) NOT NULL,
  `f_name` varchar(100) NOT NULL,
  `l_name` varchar(100) NOT NULL,
  `Mobile` bigint(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`SRNO`, `s_id`, `Rfid_s`, `f_name`, `l_name`, `Mobile`) VALUES
(1, 'S-01', 'rfids01', 'John', 'smith', 987868769),
(2, 'S-02', 'rfids02', 'adams', 'smith', 1238980123);

-- --------------------------------------------------------

--
-- Table structure for table `tab1`
--

CREATE TABLE `tab1` (
  `srno` int(11) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `Date` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tab1`
--

INSERT INTO `tab1` (`srno`, `user_id`, `Date`) VALUES
(1, '123', ''),
(2, '456', '');

-- --------------------------------------------------------

--
-- Table structure for table `tab2`
--

CREATE TABLE `tab2` (
  `SrNo` int(100) NOT NULL,
  `Room` int(100) NOT NULL,
  `Bname` varchar(100) NOT NULL,
  `Mobile` bigint(255) NOT NULL,
  `TimeIn` varchar(100) NOT NULL,
  `Rname` varchar(100) DEFAULT NULL,
  `RMobile` bigint(255) DEFAULT NULL,
  `TimeOut` varchar(100) DEFAULT NULL,
  `Date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tab2`
--

INSERT INTO `tab2` (`SrNo`, `Room`, `Bname`, `Mobile`, `TimeIn`, `Rname`, `RMobile`, `TimeOut`, `Date`) VALUES
(1, 203, 'Haider', 9876543876, '16:00', NULL, NULL, NULL, '2022-05-06 16:00:18'),
(2, 204, 'Abbas', 9876543219, '17:00', NULL, NULL, NULL, '2022-05-06 17:06:23'),
(3, 310, 'Haider', 8729136786, '12:11', NULL, NULL, NULL, '2022-05-07 12:11:38');

-- --------------------------------------------------------

--
-- Structure for view `lv`
--
DROP TABLE IF EXISTS `lv`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lv`  AS SELECT `log`.`SRNO.` AS `SRNO.`, `key`.`Room` AS `Room`, concat(`student`.`f_name`,`student`.`l_name`) AS `Bname`, `student`.`Mobile` AS `Mobile`, `log`.`TimeIn` AS `TimeIn` FROM ((`log` left join `student` on(`student`.`s_id` = `log`.`s_id`)) left join `key` on(`key`.`key_id` = `log`.`key_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `memberview`
--
DROP TABLE IF EXISTS `memberview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `memberview`  AS SELECT `member`.`SRNO` AS `SRNO`, `member`.`username` AS `username`, `member`.`password` AS `password`, `member`.`email` AS `email`, `member`.`mob` AS `mob`, `member`.`type` AS `type`, `member`.`status` AS `status` FROM `member` WHERE `member`.`status` = 1 ;

-- --------------------------------------------------------

--
-- Structure for view `rv`
--
DROP TABLE IF EXISTS `rv`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rv`  AS SELECT `log`.`SRNO.` AS `SRNO.`, concat(`student`.`f_name`,`student`.`l_name`) AS `Rname`, `student`.`Mobile` AS `Mobile`, `log`.`TimeOut` AS `TimeOut` FROM (`log` left join `student` on(`student`.`s_id` = `log`.`rs_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `date tab`
--
ALTER TABLE `date tab`
  ADD PRIMARY KEY (`Date`);

--
-- Indexes for table `date_1`
--
ALTER TABLE `date_1`
  ADD PRIMARY KEY (`Date`);

--
-- Indexes for table `key`
--
ALTER TABLE `key`
  ADD PRIMARY KEY (`key_id`),
  ADD UNIQUE KEY `SRNO.` (`SRNO.`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`SRNO.`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`SRNO`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`s_id`),
  ADD UNIQUE KEY `SRNO` (`SRNO`);

--
-- Indexes for table `tab1`
--
ALTER TABLE `tab1`
  ADD PRIMARY KEY (`srno`),
  ADD KEY `Date` (`Date`);

--
-- Indexes for table `tab2`
--
ALTER TABLE `tab2`
  ADD PRIMARY KEY (`Room`),
  ADD UNIQUE KEY `SrNo` (`SrNo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `key`
--
ALTER TABLE `key`
  MODIFY `SRNO.` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `SRNO.` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `SRNO` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `SRNO` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tab1`
--
ALTER TABLE `tab1`
  MODIFY `srno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tab2`
--
ALTER TABLE `tab2`
  MODIFY `SrNo` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
