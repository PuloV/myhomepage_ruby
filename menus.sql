-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Време на генериране: 
-- Версия на сървъра: 5.5.27
-- Версия на PHP: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- БД: `myhomepage_ruby`
--

-- --------------------------------------------------------

--
-- Структура на таблица `menus`
--

CREATE TABLE IF NOT EXISTS `menus` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_type` tinyint(1) NOT NULL DEFAULT '0',
  `menu_name` varchar(45) NOT NULL,
  `menu_link` varchar(45) NOT NULL,
  `menu_for_logged` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Ссхема на данните от таблица `menus`
--

INSERT INTO `menus` (`menu_id`, `menu_type`, `menu_name`, `menu_link`, `menu_for_logged`) VALUES
(1, 0, 'Login', '../user/login', 0),
(2, 0, 'Register', '../register', 0),
(3, 0, 'News', '../news', 0),
(4, 1, 'Bookmarks', '../bookmarks', 0),
(5, 0, 'Most Visited', '../chart/most_visited', 1),
(6, 0, 'News', '../news', 1),
(7, 1, 'Logout', '../user/logout', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
