-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jun 24, 2023 at 10:31 PM
-- Server version: 5.7.34
-- PHP Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `firstname` text NOT NULL,
  `surname` text NOT NULL,
  `mobilenumber` varchar(12) NOT NULL,
  `emailaddress` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `createddate` date NOT NULL,
  `createdtime` time NOT NULL,
  `status` text NOT NULL,
  `reference` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `firstname`, `surname`, `mobilenumber`, `emailaddress`, `password`, `createddate`, `createdtime`, `status`, `reference`) VALUES
(1, 'Papa', 'Fynn', '020009969', 'papa@gmaill.com', '1234papa', '2023-06-06', '23:01:35', 'active', ''),
(2, 'Alex', 'Brown', '0200009969', 'alexbrown@gmail.com', '$2b$15$hgG/ZAZIucIs8iThdRotpeyq.6ef9k7qRytibQpyT30U86h7jo8QG', '2023-06-24', '19:49:53', 'active', '7c2477e0-655b-460b-b8e2-3c5738776ff8'),
(6, 'Mavis', 'Beacon', '0200109969', 'alexbrown123@gmail.com', '$2b$15$mOqqelerGbRZ6Xm7mqq4puT9d52bsmO.5W0Pm37ruQakW5wIYPr06', '2023-06-24', '20:03:07', 'active', '15119360-9e6a-44a6-89a8-8e6e4c710333');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_address`
--

CREATE TABLE `delivery_address` (
  `id` int(11) NOT NULL,
  `addressinfo` text NOT NULL,
  `cutsomerid` int(11) NOT NULL,
  `createddate` date NOT NULL,
  `createdtime` time NOT NULL,
  `status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `payment_instrument`
--

CREATE TABLE `payment_instrument` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payment_instrument`
--

INSERT INTO `payment_instrument` (`id`, `name`) VALUES
(1, 'Mobile Money'),
(2, 'Card');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(11) NOT NULL,
  `refnum` text NOT NULL,
  `itemcode` text NOT NULL,
  `itemname` text NOT NULL,
  `sellprice` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `createddate` date NOT NULL,
  `createdtime` time NOT NULL,
  `status` text NOT NULL,
  `customerid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `system_users`
--

CREATE TABLE `system_users` (
  `id` int(11) NOT NULL,
  `firstname` text NOT NULL,
  `lastname` text NOT NULL,
  `mobile` text NOT NULL,
  `email` text NOT NULL,
  `createddate` date NOT NULL,
  `createdtime` time NOT NULL,
  `status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tracking`
--

CREATE TABLE `tracking` (
  `id` int(11) NOT NULL,
  `description` text NOT NULL,
  `ordercode` text NOT NULL,
  `createddate` date NOT NULL,
  `createdtime` time NOT NULL,
  `status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(11) NOT NULL,
  `itemcode` text NOT NULL,
  `createddate` date NOT NULL,
  `craetedtime` time NOT NULL,
  `status` text NOT NULL,
  `customerid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `emailaddress` (`emailaddress`),
  ADD UNIQUE KEY `mobilenumber` (`mobilenumber`);

--
-- Indexes for table `delivery_address`
--
ALTER TABLE `delivery_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addressid` (`cutsomerid`);

--
-- Indexes for table `payment_instrument`
--
ALTER TABLE `payment_instrument`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `costid_idx` (`customerid`);

--
-- Indexes for table `system_users`
--
ALTER TABLE `system_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tracking`
--
ALTER TABLE `tracking`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wish_id` (`customerid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `delivery_address`
--
ALTER TABLE `delivery_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_instrument`
--
ALTER TABLE `payment_instrument`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `system_users`
--
ALTER TABLE `system_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tracking`
--
ALTER TABLE `tracking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `delivery_address`
--
ALTER TABLE `delivery_address`
  ADD CONSTRAINT `addressid` FOREIGN KEY (`cutsomerid`) REFERENCES `customers` (`id`);

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `costid` FOREIGN KEY (`customerid`) REFERENCES `customers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wish_id` FOREIGN KEY (`customerid`) REFERENCES `customers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
