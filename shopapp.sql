-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql8-container
-- Generation Time: Dec 09, 2023 at 10:01 AM
-- Server version: 8.2.0
-- PHP Version: 8.2.8
DROP DATABASE IF EXISTS ShopApp;
-- Nếu cơ sở dữ liệu ShopApp chưa tồn tại, thực hiện câu lệnh CREATE DATABASE
CREATE DATABASE IF NOT EXISTS ShopApp;

-- Sử dụng cơ sở dữ liệu ShopApp
USE ShopApp;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ShopApp`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Laptop'),
(2, 'Điện thoại'),
(3, 'Phụ kiện điện thoại và laptop');

-- --------------------------------------------------------

--
-- Table structure for table `flyway_schema_history`
--

CREATE TABLE `flyway_schema_history` (
  `installed_rank` int NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int NOT NULL,
  `success` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `flyway_schema_history`
--

INSERT INTO `flyway_schema_history` (`installed_rank`, `version`, `description`, `type`, `script`, `checksum`, `installed_by`, `installed_on`, `execution_time`, `success`) VALUES
(2, '1', 'alter some tables', 'SQL', 'V1__alter_some_tables.sql', 670188877, 'root', '2023-12-01 10:05:58', 605, 1),
(3, '2', 'change tokens', 'SQL', 'V2__change_tokens.sql', 1468721430, 'root', '2023-12-01 10:05:58', 27, 1),
(4, '3', 'refresh tokens', 'SQL', 'V3__refresh_tokens.sql', 1847335528, 'root', '2023-12-03 04:50:25', 36, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `fullname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `note` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','processing','shipped','delivered','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Trạng thái đơn hàng',
  `total_money` float DEFAULT NULL,
  `shipping_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `shipping_date` date DEFAULT NULL,
  `tracking_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `fullname`, `email`, `phone_number`, `address`, `note`, `order_date`, `status`, `total_money`, `shipping_method`, `shipping_address`, `shipping_date`, `tracking_number`, `payment_method`, `active`) VALUES

(1, 1, 'Nguyễn Phước Nguyên', 'nis.110902@google.com', '0393204904', 'Đường Nguyễn Văn Linh, Bình Hưng, Bình Chánh', 'Hàng khó vỡ cứ mạnh tay', '2023-10-08 00:43:21', 'shipped', 150, NULL, NULL, NULL, NULL, NULL, 1);
-- (2, 5, 'Nguyễn Văn X', 'nvx@yahoo.com', '123456', 'Nhà a hẽm B', 'Hàng dễ vỡ xin nhẹ tay', '2023-11-16 00:00:00', 'pending', 123.45, 'express', NULL, '2023-11-16', NULL, 'cod', 1);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `number_of_products` int DEFAULT '1',
  `total_money` decimal(10,2) DEFAULT '0.00',
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `price`, `number_of_products`, `total_money`, `color`) VALUES
(14, 1, 1, 70.07, 1, 70.07, 'Red');
-- (15, 1, 2, 5.99, 3, 17.97, 'Blue'),
-- (16, 1, 3, 8.49, 1, 8.49, 'Green'),
-- (17, 1, 1, 10.99, 2, 21.98, 'Red'),
-- (18, 1, 2, 5.99, 3, 17.97, 'Blue'),
-- (19, 1, 3, 8.49, 1, 8.49, 'Green'),
-- (20, 1, 2, 12.99, 3, 38.97, 'Purple'),
-- (21, 2, 3, 6.99, 1, 6.99, 'Pink'),
-- (22, 2, 1, 14.99, 2, 29.98, 'Gray'),
-- (23, 2, 2, 11.49, 1, 11.49, 'Brown'),
-- (24, 2, 3, 8.99, 3, 26.97, 'Black'),
-- (25, 2, 1, 13.99, 2, 27.98, 'Silver'),
-- (26, 2, 2, 10.49, 1, 10.49, 'Gold'),
-- (27, 1, 3, 7.49, 2, 14.98, 'White'),
-- (28, 2, 1, 10.99, 2, 21.98, 'Red'),
-- (29, 1, 2, 5.99, 3, 17.97, 'Blue'),
-- (30, 1, 3, 8.49, 1, 8.49, 'Green'),
-- (31, 2, 1, 9.99, 2, 19.98, 'Red'),
-- (32, 2, 1, 5.99, 3, 17.97, 'Blue'),
-- (33, 2, 1, 8.49, 1, 8.49, 'Green'),
-- (34, 2, 2, 10.99, 2, 21.98, 'Yellow'),
-- (35, 2, 3, 5.99, 3, 17.97, 'Orange'),
-- (36, 2, 3, 32.85, 1, NULL, NULL),
-- (37, 2, 3, 32.94, 2, NULL, NULL),
-- (38, 2, 1, 45.88, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(350) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Tên sản phẩm',
  `price` decimal(10,2) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `category_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `thumbnail`, `description`, `created_at`, `updated_at`, `category_id`) VALUES
(1, 'Laptop Dell XPS 13', 1349.99, 'f5951b5564d563e51f53a5cdec268815.jpg', 'Mô tả laptop Dell XPS 13', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(2, 'Laptop HP Spectre x3603', 1749.99, 'ad053c069125abcd5ab7ff0d2e5a47e3.jpg', 'Mô tả laptop HP Spectre x3603', '2023-07-31 08:28:28', '2023-11-10 09:27:31', 1),
(3, 'Laptop ASUS ZenBook 14', 999.99, '6569307_sd.jpg', 'Mô tả laptop ASUS ZenBook 14', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(4, 'Laptop Lenovo ThinkPad X1 Carbon', 1719.99, '6546132cv7d.jpg', 'Mô tả laptop Lenovo ThinkPad X1 Carbon', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(5, 'Laptop MSI GS66 Stealth', 2729.99, '6547621_sd.jpg', 'Mô tả laptop MSI GS66 Stealth', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(6, 'Laptop Acer Predator Helios 300', 1799.99, '6514374_sd.jpg', 'Mô tả laptop Acer Predator Helios', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(7, 'Laptop Apple MacBook Air', 1399.00, '5721600_sd.jpg', 'Mô tả laptop Apple MacBook Air', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(8, 'Laptop Razer Blade 15', 1349.99, '6499097_sd.jpg', 'Mô tả laptop Razer Blade 15', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(9, 'Laptop Microsoft Surface Laptop 4', 839.99, '6455193cv11d.jpg', 'Mô tả laptop Microsoft Surface Laptop 4', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(10, 'Laptop LG Gram 17', 1841.99, '6540475_sd.jpg', 'Mô tả laptop LG Gram 17', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(11, 'Laptop Dell Inspiron 14', 999.99, '6539910_rd.jpg', 'Mô tả laptop Dell Inspiron 14', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(12, 'Laptop HP Envy 13', 1349.99, '6535750_sd.jpg', 'Mô tả laptop HP Envy 13', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(13, 'Laptop ASUS ROG Zephyrus G14', 1599.99, '6535497_sd.jpg', 'Mô tả laptop ASUS ROG Zephyrus G14', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(14, 'Laptop Lenovo Legion Y540', 1529.99, '6534469_sd.jpg', 'Mô tả laptop Lenovo Legion Y540', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(15, 'Laptop MSI Prestige 14',899.99, '6501335_sd.jpg', 'Mô tả laptop MSI Prestige 14', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(16, 'Laptop Apple MacBook Pro', 3299.00, '6534612_sd.jpg', 'Mô tả laptop Apple MacBook Pro', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(17, 'Laptop Dell G5 15', 1059.99, '6545461_sd.jpg', 'Mô tả laptop Dell G5 15', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(18, 'Laptop HP Pavilion 14', 1149.99, '6550235_sd.jpg', 'Mô tả laptop HP Pavilion 14', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(19, 'Laptop ASUS VivoBook S14', 949.99, '6510805_sd.jpg', 'Mô tả laptop ASUS VivoBook S14', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
(20, 'Laptop Acer Aspire 5', 799.99, '6553055_sd.jpg', 'Mô tả laptop Acer Aspire 5', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 1),
-- ----------------------------------------------------------------------------
(21, 'iPhone 13 Pro', 679.99, '6551233_sd.jpg', 'Mô tả iPhone 13 Pro', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 2),
(22, 'Samsung Galaxy S21', 329.99, '6528956_sd.jpg', 'Mô tả Samsung Galaxy S21', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 2),
(23, 'OnePlus 11', 629.99, '6531256_sd.jpg', 'Mô tả OnePlus 11', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 2),
(24, 'Google Pixel 6', 219.99, '6486690_sd.jpg', 'Mô tả Google Pixel 6', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 2),
(25, 'Xiaomi note 11', 179.99, '6535977_sd.jpg', 'Mô tả Xiaomi note 11', '2023-07-31 08:28:28', '2023-07-31 08:28:28', 2),
(26, 'iPhone 11', 349.99, '6510048_sd.jpg', 'Mô tả iPhone 11', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(27, 'Sony Xperia 1 III', 999.99, '6544417_sd.jpg', 'Mô tả Sony Xperia 1 III', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(28, 'iphone 14 Pro Max', 1019.99, '6562960_sd.jpg', 'Mô tả iphone 14 Pro Max', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(29, 'iPhone XS', 279.99, '6398619_sd.jpg', 'Mô tả iPhone XS', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(30, 'Motorola Edge', 599.99, '6551222_sd.jpg', 'Mô tả Motorola Edge', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(31, 'iPhone 15 Pro Max', 1368.10, '6525428_sd.jpg', 'Mô tả iPhone 15 Pro Max', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(32, 'Samsung Galaxy Note 20 Ultra', 1419.99, '6533176_sd.jpg', 'Mô tả Samsung Galaxy Note 20 Ultra', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(33, 'iPhone 14 Plus', 879.99, '6417988_sd.jpg', 'Mô tả iPhone 14 Plus', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(34, 'Google Pixel 5', 159.99, '6451571_sd.jpg', 'Mô tả Google Pixel 5', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(35, 'iPhone SE',189.99, '6519727_sd.jpg', 'Mô tả iPhone SE', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(36, 'iPhone 11 Pro', 379.99, '6506160_sd.jpg', 'Mô tả iPhone 11 Pro', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(37, 'Sony Xperia PRO-I', 1289.97, '6489669_sd.jpg', 'Mô tả Sony Xperia PRO-I', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(38, 'iPhone XS Max', 299.99, '6463653_sd.jpg', 'Mô tả iPhone XS Max', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(39, 'Galaxy S24 Ultra', 1659.99, '6570297_sd.jpg', 'Mô tả Galaxy S24 Ultra', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
(40, 'Iphone 12 mini', 379.99, '6525044_sd.jpg', 'Mô tả Iphone 12 mini', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 2),
-- -------------------------------------------------------------------------------------
(41, 'Apple - AirPods Pro', 249.99, '6447382cv12d.jpg', 'Mô tả Apple - AirPods Pro', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(42, 'Apple - Magic Mouse', 67.99, '6474585_sd.jpg', 'Mô tả Apple - Magic Mouse', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(43, 'Thule - EnRoute 27L Escort 2 Backpack for 15.6" Laptop w/ 10.1" Padded Tablet Sleeve, Crushproof SafeZone, & Water Bottle Holder', 123.99, '5096201_sd.jpg', 'Mô tả Thule - EnRoute 27L Escort 2 Backpack for 15.6" Laptop w/ 10.1" Padded Tablet Sleeve, Crushproof SafeZone, & Water Bottle Holder', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(44, 'Apple - 60W MagSafe 2 Power Adapter (MacBook Pro with 13-inch Retina Display)', 79.99, '3655007_sd.jpg', 'Mô tả Apple - 60W MagSafe 2 Power Adapter (MacBook Pro with 13-inch Retina Display)', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(45, 'OtterBox - Symmetry Series Hard Shell for MagSafe for Apple iPhone 15 Pro', 8.83, '6548578_sd.jpg', 'Mô tả OtterBox - Symmetry Series Hard Shell for MagSafe for Apple iPhone 15 Pro', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(46, 'Loa SOUNDBAR máy tính BLUTOOTH SH39 LED RGB nút phím cơ', 60.99, '03fa41c875c689961513301532144ff3.jpg', 'Mô tả Loa SOUNDBAR máy tính BLUTOOTH SH39 LED RGB nút phím cơ', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(47, 'Túi chống nước cho laptop', 109.99, '6474738cv12d.jpg', 'Mô tả Túi chống nước cho laptop', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(48, 'Ốp lưng cho Samsung Galaxy S21 Ultra', 24.99, '6442240_sd.jpg', 'Mô tả Ốp lưng cho Samsung Galaxy S21 Ultra', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(49, 'Razer - Basilisk V3 Wired Optical Gaming Mouse with Chroma RBG Lighting', 49.99, '6475703_sd.jpg', 'Mô tả Razer - Basilisk V3 Wired Optical Gaming Mouse with Chroma RBG Lighting', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(50, 'SteelSeries - QcK Prism Cloth Gaming Mouse Pad with 2-Zone RGB Illumination XL',59.99, '6285961cv18d.jpg', 'Mô tả SteelSeries - QcK Prism Cloth Gaming Mouse Pad with 2-Zone RGB Illumination XL', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(51, 'Apple - AirPods Max', 499.99, '6373460cv11d.jpg', 'Mô tả Apple - AirPods Max', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(52, 'Mechanical keyboard Xinmeng M87', 50.99, 'a.jpg', 'Mô tả Mechanical keyboard Xinmeng M87', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(53, 'CORSAIR - K70 CORE RGB Mechanical Gaming Keyboard',89.99, '6558790_sd.jpg', 'Mô tả CORSAIR - K70 CORE RGB Mechanical Gaming Keyboard', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(54, 'ROCCAT - Burst Pro Air Lightweight Wireless Optical Gaming Ambidextrous Mouse with AIMO Lighting', 69.99, '6508305_sd.jpg', 'Mô tả ROCCAT - Burst Pro Air Lightweight Wireless Optical Gaming Ambidextrous Mouse with AIMO Lighting', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(55, 'Logitech - PRO X TKL LIGHTSPEED Wireless Mechanical Tactile Switch Gaming Keyboard with LIGHTSYNC RGB ', 199.99, '6556751_sd.jpg', 'Mô tả Logitech - PRO X TKL LIGHTSPEED Wireless Mechanical Tactile Switch Gaming Keyboard with LIGHTSYNC RGB', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(56, 'Geeni - Prisma Smart LED Strip Lights', 24.99, '6460897_sd.jpg', 'Mô tả Geeni - Prisma Smart LED Strip Lights', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(57, 'Bàn Gaming K', 35.99, 'Ban-Gaming-Chu-K-Vat-4.jpg', 'Mô tả Bàn Gaming K', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(58, 'Ghế Gaming VG-SL5000', 50.29, 'ghe-gaming-vg-sl5000-13.jpg', 'Mô tả Ghế Gaming VG-SL5000', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3),
(59, 'Apple - 20W USB-C Power Adapter', 25.15, '6437121_sd.jpg', 'Mô tả Apple - 20W USB-C Power Adapter', '2023-07-31 08:28:29', '2023-07-31 08:28:29', 3);

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `image_url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image_url`) VALUES
(8, 1, 'f5951b5564d563e51f53a5cdec268815.jpg'),
(9, 1, '92df3151a87bee0c9f858a7b97a71839.jpg'),
(10, 1, '686c62e9940dec3da4e8d7d27d749297.jpg'),
(11, 1, 'a26ec655e5caa88c2d795e7855735ae7.jpg'),
(12, 1, '28b2793342049ffcb7e2d045ad4b0017.jpg'),
(13, 1, '9927dcdfb321a7b5055b9f4bb9b41b64.jpg'),
(14, 2, 'ad053c069125abcd5ab7ff0d2e5a47e3.jpg'),
(15, 2, 'dcb90184752fbc24dc0397674387d4f5.jpg'),
(16, 2, '483bc7d1ee3a4728522ec4bc4a9638c4.jpg'),
(17, 2, 'fd6284afd4dd830187692a313f954825.jpg'),
(18, 2, '86390c9bbf91fd5338a68c02bcfeaf1b.jpg'),
(19, 2, '996c9a6cbb56c8b74842990b6aef37ed.jpg'),
(20, 3, '6569307_sd.jpg'),
(21, 3, '6569307_rd.jpg'),
(22, 3, '6569307ld.jpg'),
(23, 3, '6569307cv1d.jpg'),
(24, 3, '6569307cv3d.jpg'),
(25, 3, '6569307cv13d.jpg'),
(26, 4, '6546132cv7d.jpg'),
(27, 4, '6546132_sd.jpg'),
(28, 4, '6546132cv1d.jpg'),
(29, 4, '6546132cv3d.jpg'),
(30, 4, '6546132cv4d.jpg'),
(31, 4, '6546132cv10d.jpg'),
(32, 5, '6547621_sd.jpg'),
(33, 5, '6547621_rd.jpg'),
(34, 5, '6547621ld.jpg'),
(35, 5, '6547621cv1d.jpg'),
(36, 5, '6547621cv3d.jpg'),
(37, 5, '6547621cv4d.jpg'),
(38, 6, '6514374_sd.jpg'),
(39, 6, '6514374_rd.jpg'),
(40, 6, '6514374ld.jpg'),
(41, 6, '6514374cv4d3.jpg'),
(42, 6, '6514374cv7d.jpg'),
(43, 6, '6514374cv10d.jpg'),
(44, 7, '5721600_sd.jpg'),
(45, 7, '5721600cv11d.jpg'),
(46, 7, '5721600cv12d.jpg'),
(47, 7, '5721600cv13d.jpg'),
(48, 7, '5721600cv14d.jpg'),
(49, 7, '5721600cv15d.jpg'),
(50, 8, '6499097_sd.jpg'),
(51, 8, '6499097_rd.jpg'),
(52, 8, '6499097cv3d.jpg'),
(53, 8, '6499097cv7d.jpg'),
(54, 8, '6499097cv11d.jpg'),
(55, 8, '6499097cv12d.jpg'),
(56, 9, '6455193cv11d.jpg'),
(57, 9, '6455193_sd.jpg'),
(58, 9, '6455193cv12d.jpg'),
(59, 9, '6455193cv14d.jpg'),
(60, 9, '6455193cv15d.jpg'),
(61, 9, '6455193cv13d.jpg'),
(62, 10, '6540475_sd.jpg'),
(63, 10, '6540475cv4d.jpg'),
(64, 10, '6540475cv3d.jpg'),
(65, 10, '6540475_rd.jpg'),
(66, 10, '6540475ld.jpg'),
(67, 10, '6540475cv1d.jpg'),
(68, 11, '6539910_rd.jpg'),
(69, 11, '6539910ld.jpg'),
(70, 11, '6539910cv1d.jpg'),
(71, 11, '6539910cv12d.jpg'),
(72, 11, '6539910cv13d.jpg'),
(73, 11, '6539910cv15d.jpg'),
(74, 12, '6535750_sd.jpg'),
(75, 12, '6535750_rd.jpg'),
(76, 12, '6535750ld.jpg'),
(77, 12, '6535750cv1d.jpg'),
(78, 12, '6535750cv3d.jpg'),
(79, 12, '6535750cv4d.jpg'),
(80, 13, '6535497_sd.jpg'),
(81, 13, '6535497_rd.jpg'),
(82, 13, '6535497cv1d.jpg'),
(83, 13, '6535497cv7d.jpg'),
(84, 13, '6535497cv13d.jpg'),
(85, 13, '6535497cv14d.jpg'),
(86, 14, '6534469_sd.jpg'),
(87, 14, '6534469_rd.jpg'),
(88, 14, '6534469cv1d.jpg'),
(89, 14, '6534469cv3d.jpg'),
(90, 14, '6534469cv4d.jpg'),
(91, 14, '6534469cv7d.jpg'),
(92, 15, '6501335_sd.jpg'),
(93, 15, '6501335cv16d.jpg'),
(94, 15, '6501335cv18d.jpg'),
(95, 15, '6501335cv22d.jpg'),
(96, 15, '6501335cv23d.jpg'),
(97, 15, '6501335cv32d.jpg'),
(98, 16, '6534612_sd.jpg'),
(99, 16, '6534612cv11d.jpg'),
(100, 16, '6534612cv12d.jpg'),
(101, 16, '6534612cv18d.jpg'),
(102, 16, '6489915cv11d.jpg'),
(103, 16, '6534635cv15d.jpg'),
(104, 17, '6545461_sd.jpg'),
(105, 17, '6545461_rd.jpg'),
(106, 17, '6545461ld.jpg'),
(107, 17, '6545475_rd.jpg'),
(108, 17, '6545475ld.jpg'),
(109, 17, '6545475cv1d.jpg'),
(110, 18, '6550235_sd.jpg'),
(111, 18, '6550235_rd.jpg'),
(112, 18, '6550235ld.jpg'),
(113, 18, '6550235cv1d.jpg'),
(114, 18, '6550235cv10d.jpg'),
(115, 18, '6550235cv4d.jpg'),
(116, 19, '6510805_sd.jpg'),
(117, 19, '6510805cv11d.jpg'),
(118, 19, '6510805cv12d.jpg'),
(119, 19, '6510805cv13d.jpg'),
(120, 19, '6510805cv16d.jpg'),
(121, 19, '6510805cv20d.jpg'),
(122, 20, '6553055_sd.jpg'),
(123, 20, '6553055_rd.jpg'),
(124, 20, '6553055ld.jpg'),
(125, 20, '6553055cv4d.jpg'),
(126, 20, '6553055cv7d.jpg'),
(127, 20, '6553055cv10d.jpg'),
-- ---------------------------------------------------------
(128, 21, '6551233_sd.jpg'),
(129, 21, '6551469_sd.jpg'),
(130, 21, '6551468_sd.jpg'),
(131, 21, '6551467_sd.jpg'),
(132, 21, '6551230_sd.jpg'),
(133, 21, '6551230ld.jpg'),
(134, 22, '6528956_sd.jpg'),
(135, 22, '6528956_rd.jpg'),
(136, 22, '6528956ld.jpg'),
(137, 22, '6528956cv1d.jpg'),
(138, 22, '6528956cv2d.jpg'),
(139, 22, '6528956cv11d.jpg'),
(140, 23, '6531256_sd.jpg'),
(141, 23, '6531256_rd.jpg'),
(142, 23, '6531256ld.jpg'),
(143, 23, '6531256_bd.jpg'),
(144, 23, '6531256cv1d.jpg'),
(145, 23, '6531256cv2d.jpg'),
(146, 24, '6486690_sd.jpg'),
(147, 24, '6486686_sd.jpg'),
(148, 24, '6486688_sd.jpg'),
(149, 24, '6486688cv11d.jpg'),
(150, 24, '6486690cv12d.jpg'),
(151, 24, '6486686cv13d.jpg'),
(152, 25, '6535977_sd.jpg'),
(153, 25, '6535977cv13d.jpg'),
(154, 25, '6535977_rd.jpg'),
(155, 25, '6535977ld.jpg'),
(156, 25, '6535977_bd.jpg'),
(157, 25, '6535977cv16d.jpg'),
(158, 26, '6510048_sd.jpg'),
(159, 26, '6506185_sd.jpg'),
(160, 26, '6506183_sd.jpg'),
(161, 26, '6506162_sd.jpg'),
(162, 26, '6505705_sd.jpg'),
(163, 26, '6506187_sd.jpg'),
(164, 27, '6544417_sd.jpg'),
(165, 27, '6544417_rd.jpg'),
(166, 27, '6544417_bd.jpg'),
(167, 27, '6544417cv1d.jpg'),
(168, 27, '6544417cv11d.jpg'),
(169, 27, '6544417cv14d.jpg'),
(170, 28, '6562960_sd.jpg'),
(171, 28, '6562962_sd.jpg'),
(172, 28, '6562980_sd.jpg'),
(173, 28, '6562966_sd.jpg'),
(174, 28, '6562960ld.jpg'),
(175, 28, '6562960cv1d.jpg'),
(176, 29, '6398619_sd.jpg'),
(177, 29, '6398619_bd.jpg'),
(178, 29, '6398593_bd.jpg'),
(179, 29, '6398612_bd.jpg'),
(180, 29, '6398612cv11d.jpg'),
(181, 29, '6398612cv13d.jpg'),
(182, 30, '6551222_sd.jpg'),
(183, 30, '6551222_rd.jpg'),
(184, 30, '6551222ld.jpg'),
(185, 30, '6551222_bd.jpg'),
(186, 30, '6551222cv13d.jpg'),
(187, 30, '6551222cv15d.jpg'),
(188, 31, '6525428_sd.jpg'),
(189, 31, '6525427_sd.jpg'),
(190, 31, '6525425_sd.jpg'),
(191, 31, '6525426_sd.jpg'),
(192, 31, '6525426cv19d.jpg'),
(193, 31, '6525428cv15d.jpg'),
(194, 32, '6533176_sd.jpg'),
(195, 32, '6533176_rd.jpg'),
(196, 32, '6533176ld.jpg'),
(197, 32, '6533176cv1d.jpg'),
(198, 32, '6494439cv18d.jpg'),
(199, 32, '6494439cv22d.jpg'),
(200, 33, '6417988_sd.jpg'),
(201, 33, '6504815_sd.jpg'),
(202, 33, '6487233_sd.jpg'),
(203, 33, '6504817_sd.jpg'),
(204, 33, '6417988cv2d.jpg'),
(205, 33, '6417988cv1d.jpg'),
(206, 34, '6451571_sd.jpg'),
(207, 34, '6451571_rd.jpg'),
(208, 34, '6451571_bd.jpg'),
(209, 34, '6451571cv11d.jpg'),
(210, 34, '6451571cv14d.jpg'),
(211, 34, '6451571cv18d.jpg'),
(212, 35, '6519727_sd.jpg'),
(213, 35, '6495545_sd.jpg'),
(214, 35, '6495546_sd.jpg'),
(215, 35, '6495546ld.jpg'),
(216, 35, '6495545ld.jpg'),
(217, 35, '6495542ld.jpg'),
(218, 36, '6506160_sd.jpg'),
(219, 36, '6506186_sd.jpg'),
(220, 36, '6502951_sd.jpg'),
(221, 36, '6502951ld.jpg'),
(222, 36, '6506186cv1d.jpg'),
(223, 36, '6506160ld.jpg'),
(224, 37, '6489669_sd.jpg'),
(225, 37, '6489669_rd.jpg'),
(226, 37, '6489669ld.jpg'),
(227, 37, '6489669cv13d.jpg'),
(228, 37, '6489669cv21d.jpg'),
(229, 37, '6489669cv20d.jpg'),
(230, 38, '6463653_sd.jpg'),
(231, 38, '6463654_sd.jpg'),
(232, 38, '6463649_sd.jpg'),
(233, 38, '6463649cv2d.jpg'),
(234, 38, '6463654cv2d.jpg'),
(235, 38, '6463653cv2d.jpg'),
(236, 39, '6570297_sd.jpg'),
(237, 39, '6570266_sd.jpg'),
(238, 39, '6570266cv16d.jpg'),
(239, 39, '6570266cv14d.jpg'),
(240, 39, '6570297cv19d.jpg'),
(241, 39, '6570297cv18d.jpg'),
(242, 40, '6525044_sd.jpg'),
(243, 40, '6525065_sd.jpg'),
(244, 40, '6525075_sd.jpg'),
(245, 40, '6525246_sd.jpg'),
(246, 40, '6525071_sd.jpg'),
(247, 40, '6525073_sd.jpg'),
-- ------------------------------------------------------
(248, 41, '6447382cv12d.jpg'),
(249, 41, '6447382cv11d.jpg'),
(250, 41, '6447382_sd.jpg'),
(251, 41, '6447382cv13d.jpg'),
(252, 41, '6447382cv14d.jpg'),
(253, 41, '6447382cv15d.jpg'),
(254, 42, '6474585_sd.jpg'),
(255, 42, '6474585cv11d.jpg'),
(256, 42, '6474585cv12d.jpg'),
(257, 42, '6276701_sd.jpg'),
(258, 42, '6276701_rd.jpg'),
(259, 42, '6276701ld.jpg'),
(260, 43, '5096201_sd.jpg'),
(261, 43, '5096201_bd.jpg'),
(262, 43, '5096201cv11d.jpg'),
(263, 43, '5096201cv14d.jpg'),
(264, 43, '5096201cv15d.jpg'),
(265, 43, '5096201cv17d.jpg'),
(266, 44, '3655007_sd.jpg'),
(267, 44, '6602021_sd.jpg'),
(268, 44, '6530832_sd.jpg'),
(269, 44, '6530832cv11d.jpg'),
(270, 44, '6530832cv12d.jpg'),
(271, 44, '1019306_sa.jpg'),
(272, 45, '6548578_sd.jpg'),
(273, 45, '6548577_sd.jpg'),
(274, 45, '6548580_sd.jpg'),
(275, 45, '6548575_sd.jpg'),
(276, 45, '6548591_sd.jpg'),
(277, 45, '6548576_sd.jpg'),
(278, 46, '03fa41c875c689961513301532144ff3.jpg'),
(279, 46, '86d2ba964a75ab5e948c026d0acf4398.jpg'),
(280, 46, 'eee46111c5bc5be425b6833ad6f3d1af.jpg'),
(281, 46, 'e07113effc1887fedf9aed1f4f570a51.jpg'),
(282, 46, 'd27d7f9fae3ddd5f691fe72e6289ad5c.jpg'),
(283, 46, '6.jpg'),
(284, 47, '6474738cv12d.jpg'),
(285, 47, '6474738cv14d.jpg'),
(286, 47, '6474738_sd.jpg'),
(287, 47, '6474738cv1d.jpg'),
(288, 47, '6474738cv11d.jpg'),
(289, 47, '6474738cv13d.jpg'),
(290, 48, '6442240_sd.jpg'),
(291, 48, '6439206_sd.jpg'),
(292, 48, '6439196_sd.jpg'),
(293, 48, '6442245_sd.jpg'),
(294, 48, '6493964_sd.jpg'),
(295, 48, '6491685_sd.jpg'),
(296, 49, '6475703_sd.jpg'),
(297, 49, '6475703cv11d.jpg'),
(298, 49, '6475703cv12d.jpg'),
(299, 49, '6475703cv13d.jpg'),
(300, 49, '6475703cv14d.jpg'),
(301, 49, '6475703cv15d.jpg'),
(302, 50, '6285961cv18d.jpg'),
(303, 50, '6285961_sd.jpg'),
(304, 50, '6285961cv11d.jpg'),
(305, 50, '6285961cv12d.jpg'),
(306, 50, '6285961cv17d.jpg'),
(307, 50, '6285961cv14d.jpg'),
(308, 51, '6373460cv11d.jpg'),
(309, 51, '6373460_sd.jpg'),
(310, 51, '6373460cv12d.jpg'),
(311, 51, '6373460cv13d.jpg'),
(312, 51, '6373460cv15d.jpg'),
(313, 51, '6373460cv16d.jpg'),
(314, 52, 'a.jpg'),
(315, 52, 'b.jpg'),
(316, 52, 'c.jpg'),
(317, 52, 'd.jpg'),
(318, 52, 'e.jpg'),
(319, 52, 'f.jpg'),
(320, 53, '6558790_sd.jpg'),
(321, 53, '6558790_rd.jpg'),
(322, 53, '6558790ld.jpg'),
(323, 53, '6558790cv17d.jpg'),
(324, 53, '6558790cv18d.jpg'),
(325, 53, '6558790cv15d.jpg'),
(326, 54, '6508305_sd.jpg'),
(327, 54, '6508305ld.jpg'),
(328, 54, '6508305_rd.jpg'),
(329, 54, '6508305_bd.jpg'),
(330, 54, '6508305cv11d.jpg'),
(331, 54, '6508305cv13d.jpg'),
(332, 55, '6556751_sd.jpg'),
(333, 55, '6556751cv12d.jpg'),
(334, 55, '6556751cv13d.jpg'),
(335, 55, '6556751cv14d.jpg'),
(336, 55, '6556751cv16d.jpg'),
(337, 55, '6556751cv17d.jpg'),
(338, 56, '6460897_sd.jpg'),
(339, 56, '6460897ld.jpg'),
(340, 56, '6460897cv12d.jpg'),
(341, 56, '6460897cv16d.jpg'),
(342, 56, '6460897cv14d.jpg'),
(343, 56, '6460897cv15d.jpg'),
(344, 57, 'Ban-Gaming-Chu-K-Vat-4.jpg'),
(345, 57, 'g.jpg'),
(346, 57, 'Bàn-game-chân-sắt-chữ-K-KG-K120.jpg'),
(347, 57, 'top-5-ban-chu-k-dep-fufutech (1).jpg'),
(348, 57, 'top-5-ban-chu-k-dep-fufutech (2).jpg'),
(349, 57, 'thumbnail-gaming-trang-k-1646.jpg'),
(350, 58, 'ghe-gaming-vg-sl5000-13.jpg'),
(351, 58, 'images.jpg'),
(352, 58, 'images (1).jpg'),
(353, 58, 'images (2).jpg'),
(354, 58, 'images (3).jpg'),
(355, 58, 'images (4).jpg'),
(356, 59, '6437121_sd.jpg'),
(357, 59, '6437121cv11d.jpg'),
(358, 59, '6495825cv12d.jpg'),
(359, 59, '6495825_sd.jpg'),
(360, 59, '6495825cv18d.jpg'),
(361, 59, '6495825cv22d.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'user'),
(2, 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `social_accounts`
--

CREATE TABLE `social_accounts` (
  `id` int NOT NULL,
  `provider` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tên nhà social network',
  `provider_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Email tài khoản',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Tên người dùng',
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `id` int NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `token_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expired` tinyint(1) NOT NULL,
  `user_id` int DEFAULT NULL,
  `is_mobile` tinyint(1) DEFAULT '0',
  `refresh_token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '',
  `refresh_expiration_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tokens`
--

INSERT INTO `tokens` (`id`, `token`, `token_type`, `expiration_date`, `revoked`, `expired`, `user_id`, `is_mobile`, `refresh_token`, `refresh_expiration_date`) VALUES
(7, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjAzOTMyMDQ5MDQiLCJ1c2VySWQiOjksInN1YiI6IjAzOTMyMDQ5MDQiLCJleHAiOjE3MDkxODIwMjN9.ozrjCZH-H_9t-0FGNGffrHuPApbCusqluY50uVZKmnc', 'Bearer', '2023-12-31 10:23:51', 0, 0, 1, 1, '', NULL);
-- (15, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjExMjIzMzQ0IiwidXNlcklkIjozLCJzdWIiOiIxMTIyMzM0NCIsImV4cCI6MTcwNDI1NjMyNH0.w-IXoFFHIMasMwayM0DxZraW3YRgoC_h61C6-74cXqU', 'Bearer', '2024-01-03 04:32:04', 0, 0, 3, 0, '624651d3-a3f6-4f99-89c1-94104ec22a74', '2024-02-02 04:32:04'),
-- (16, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjExMjIzMzQ0IiwidXNlcklkIjozLCJzdWIiOiIxMTIyMzM0NCIsImV4cCI6MTcwNDI1NjM2MH0.U6A4ed5dxRAzMxwHluiR0-_Rxm0ngXfZ1RN-VaW_OpY', 'Bearer', '2024-01-03 04:32:40', 0, 0, 3, 0, '8caf32df-69e8-4489-9716-4e2a2944a1a8', '2024-02-02 04:32:40'),
-- (29, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjA5NjQ4OTYyMzkiLCJ1c2VySWQiOjgsInN1YiI6IjA5NjQ4OTYyMzkiLCJleHAiOjE3MDQ3MDc1MTR9.B3iHckT44zN8zG3clXsURaemqWvfz7HJkR-e9b9VCo0', 'Bearer', '2024-01-08 09:51:55', 0, 0, 8, 0, '9cd17548-6634-43c4-a0a6-376266413e68', '2024-02-07 09:51:55'),
-- (32, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjA5NjQ4OTYyMzkiLCJ1c2VySWQiOjgsInN1YiI6IjA5NjQ4OTYyMzkiLCJleHAiOjE3MDQ3MDc2MTV9.CkOUQe1k7XFjLfiMJgB7VLvVnZnEfkASP0cc7eVAJtQ', 'Bearer', '2024-01-08 09:53:35', 0, 0, 8, 0, '94ac5e7b-abaa-40d7-90df-0a044b7c705c', '2024-02-07 09:53:35'),
-- (33, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjMzNDQ1NTY2IiwidXNlcklkIjo1LCJzdWIiOiIzMzQ0NTU2NiIsImV4cCI6MTcwNDcwNzY1MX0.CbZR3D0WZQCZx1Gj53_GKv7mrGayK4ZGqjO_-YNO_NM', 'Bearer', '2024-01-08 09:54:12', 0, 0, 5, 0, '635b4f9c-c28f-418c-b907-8ccc514924c4', '2024-02-07 09:54:12'),
-- (34, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjA5NjQ4OTYyMzkiLCJ1c2VySWQiOjgsInN1YiI6IjA5NjQ4OTYyMzkiLCJleHAiOjE3MDQ3MDc4NzN9.NzGHRwdw9f1mK6OTe4a8Jsg6xdedeqoAQRb1FZO19Vo', 'Bearer', '2024-01-08 09:57:53', 0, 0, 8, 0, 'c9544702-4ea7-403a-9914-4159f952287a', '2024-02-07 09:57:53'),
-- (35, 'eyJhbGciOiJIUzI1NiJ9.eyJwaG9uZU51bWJlciI6IjMzNDQ1NTY2IiwidXNlcklkIjo1LCJzdWIiOiIzMzQ0NTU2NiIsImV4cCI6MTcwNDcwNzg5MH0.M1VOtWhQ1mmt04r9AKhHCQUCfc1-mWH_haJ720OXm_E', 'Bearer', '2024-01-08 09:58:11', 0, 0, 5, 0, 'd976b190-9db0-425b-87d8-df95d8221a15', '2024-02-07 09:58:11');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `fullname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `phone_number` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `password` char(60) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `date_of_birth` date DEFAULT NULL,
  `facebook_account_id` int DEFAULT '0',
  `google_account_id` int DEFAULT '0',
  `role_id` int DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `phone_number`, `address`, `password`, `created_at`, `updated_at`, `is_active`, `date_of_birth`, `facebook_account_id`, `google_account_id`, `role_id`) VALUES
(1, 'Nguyễn Phước Nguyên', '0393204904', 'Đường Nguyễn Văn Linh, Bình Hưng, Bình Chánh', '$2a$10$z3rOOvwgO5krMaDkGaHWJ.nMDGz8y/hRckciq6FVd51SDHeA0OY6i', '2023-08-03 05:36:11', '2023-08-03 05:36:11', 1, '2002-09-11', 0, 0, 1),
(2, 'ADMIN', '123123', 'Đây là admin', '$2a$10$fVDf2mKEdh3j6QJNcQAkvemIDpBb.LzfqZZk.Xh3V1Tz6eWWOJP.S', '2023-08-06 00:34:35', '2023-08-06 00:34:35', 1, '2002-09-11', 0, 0, 2);


--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `flyway_schema_history`
--
ALTER TABLE `flyway_schema_history`
  ADD PRIMARY KEY (`installed_rank`),
  ADD KEY `flyway_schema_history_s_idx` (`success`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_product_images_product_id` (`product_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_accounts`
--
ALTER TABLE `social_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5781;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

--
-- AUTO_INCREMENT for table `social_accounts`
--
ALTER TABLE `social_accounts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `fk_product_images_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `social_accounts`
--
ALTER TABLE `social_accounts`
  ADD CONSTRAINT `social_accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
