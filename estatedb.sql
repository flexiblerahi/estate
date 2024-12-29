-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for realstatedb
CREATE DATABASE IF NOT EXISTS `realstatedb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `realstatedb`;

-- Dumping structure for table realstatedb.attendances
CREATE TABLE IF NOT EXISTS `attendances` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_detail_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attendances_user_detail_id_foreign` (`user_detail_id`),
  CONSTRAINT `attendances_user_detail_id_foreign` FOREIGN KEY (`user_detail_id`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.attendances: ~0 rows (approximately)

-- Dumping structure for table realstatedb.backup_bank_infos
CREATE TABLE IF NOT EXISTS `backup_bank_infos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bank_info_id` bigint unsigned NOT NULL,
  `bank_name_id` bigint unsigned NOT NULL,
  `account_id` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `amount` double NOT NULL DEFAULT '0',
  `status` tinyint NOT NULL DEFAULT '0',
  `entry` bigint unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_bank_infos_bank_info_id_foreign` (`bank_info_id`),
  KEY `backup_bank_infos_bank_name_id_foreign` (`bank_name_id`),
  KEY `backup_bank_infos_entry_foreign` (`entry`),
  CONSTRAINT `backup_bank_infos_bank_info_id_foreign` FOREIGN KEY (`bank_info_id`) REFERENCES `bank_infos` (`id`),
  CONSTRAINT `backup_bank_infos_bank_name_id_foreign` FOREIGN KEY (`bank_name_id`) REFERENCES `bank_names` (`id`),
  CONSTRAINT `backup_bank_infos_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.backup_bank_infos: ~0 rows (approximately)

-- Dumping structure for table realstatedb.backup_bank_transactions
CREATE TABLE IF NOT EXISTS `backup_bank_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bank_transaction_id` bigint unsigned NOT NULL,
  `account_id` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_info_id` bigint unsigned DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `balance` double NOT NULL DEFAULT '0',
  `trx_by` tinyint NOT NULL DEFAULT '0' COMMENT 'cash=0,online_transfer=1,check=2',
  `trx_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'transaction_no',
  `other` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '0' COMMENT 'withdraw=0,cashin=1',
  `date` date DEFAULT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  `entry` bigint unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_bank_transactions_bank_transaction_id_foreign` (`bank_transaction_id`),
  KEY `backup_bank_transactions_bank_info_id_foreign` (`bank_info_id`),
  KEY `backup_bank_transactions_entry_foreign` (`entry`),
  CONSTRAINT `backup_bank_transactions_bank_info_id_foreign` FOREIGN KEY (`bank_info_id`) REFERENCES `bank_infos` (`id`),
  CONSTRAINT `backup_bank_transactions_bank_transaction_id_foreign` FOREIGN KEY (`bank_transaction_id`) REFERENCES `bank_transactions` (`id`),
  CONSTRAINT `backup_bank_transactions_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.backup_bank_transactions: ~1 rows (approximately)
INSERT INTO `backup_bank_transactions` (`id`, `bank_transaction_id`, `account_id`, `bank_info_id`, `amount`, `balance`, `trx_by`, `trx_no`, `other`, `status`, `date`, `model_type`, `model_id`, `entry`, `comment`, `created_at`, `updated_at`) VALUES
	(1, 3, '100003', 1, -1000, 0, 1, '1', NULL, 0, '2023-08-06', 'App\\Models\\Transaction', 1, 1, 'update', '2023-08-06 09:53:18', '2023-08-06 09:53:18');

-- Dumping structure for table realstatedb.backup_expenses
CREATE TABLE IF NOT EXISTS `backup_expenses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `expense_id` bigint unsigned NOT NULL,
  `expense_item_id` bigint unsigned NOT NULL,
  `entry` bigint unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_expenses_expense_id_foreign` (`expense_id`),
  KEY `backup_expenses_expense_item_id_foreign` (`expense_item_id`),
  KEY `backup_expenses_entry_foreign` (`entry`),
  CONSTRAINT `backup_expenses_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `backup_expenses_expense_id_foreign` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`),
  CONSTRAINT `backup_expenses_expense_item_id_foreign` FOREIGN KEY (`expense_item_id`) REFERENCES `expense_items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.backup_expenses: ~0 rows (approximately)

-- Dumping structure for table realstatedb.backup_expense_items
CREATE TABLE IF NOT EXISTS `backup_expense_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `expense_item_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent` bigint unsigned DEFAULT NULL,
  `entry` bigint unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_expense_items_expense_item_id_foreign` (`expense_item_id`),
  KEY `backup_expense_items_parent_foreign` (`parent`),
  KEY `backup_expense_items_entry_foreign` (`entry`),
  CONSTRAINT `backup_expense_items_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `backup_expense_items_expense_item_id_foreign` FOREIGN KEY (`expense_item_id`) REFERENCES `expense_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `backup_expense_items_parent_foreign` FOREIGN KEY (`parent`) REFERENCES `expense_items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.backup_expense_items: ~0 rows (approximately)

-- Dumping structure for table realstatedb.backup_investments
CREATE TABLE IF NOT EXISTS `backup_investments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `investment_id` bigint unsigned NOT NULL,
  `investor_id` bigint unsigned NOT NULL,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` double NOT NULL DEFAULT '0',
  `duration` double NOT NULL DEFAULT '0',
  `duration_in` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `entry` bigint unsigned NOT NULL,
  `invest_at` date NOT NULL,
  `last_interest` date DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1 = activate( get commission every month), 0 = deactive (not get any commission)',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_investments_investment_id_foreign` (`investment_id`),
  KEY `backup_investments_investor_id_foreign` (`investor_id`),
  KEY `backup_investments_entry_foreign` (`entry`),
  CONSTRAINT `backup_investments_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `backup_investments_investment_id_foreign` FOREIGN KEY (`investment_id`) REFERENCES `investments` (`id`),
  CONSTRAINT `backup_investments_investor_id_foreign` FOREIGN KEY (`investor_id`) REFERENCES `investors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.backup_investments: ~0 rows (approximately)

-- Dumping structure for table realstatedb.backup_investment_withdraws
CREATE TABLE IF NOT EXISTS `backup_investment_withdraws` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `investment_withdraw_id` bigint unsigned NOT NULL,
  `investor_id` bigint unsigned NOT NULL,
  `investment_id` bigint unsigned NOT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL,
  `entry` bigint unsigned NOT NULL,
  `other` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_investment_withdraws_investment_withdraw_id_foreign` (`investment_withdraw_id`),
  KEY `backup_investment_withdraws_investor_id_foreign` (`investor_id`),
  KEY `backup_investment_withdraws_investment_id_foreign` (`investment_id`),
  KEY `backup_investment_withdraws_entry_foreign` (`entry`),
  CONSTRAINT `backup_investment_withdraws_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `backup_investment_withdraws_investment_id_foreign` FOREIGN KEY (`investment_id`) REFERENCES `investments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `backup_investment_withdraws_investment_withdraw_id_foreign` FOREIGN KEY (`investment_withdraw_id`) REFERENCES `investment_withdraws` (`id`) ON DELETE CASCADE,
  CONSTRAINT `backup_investment_withdraws_investor_id_foreign` FOREIGN KEY (`investor_id`) REFERENCES `investors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.backup_investment_withdraws: ~0 rows (approximately)

-- Dumping structure for table realstatedb.backup_other_deposits
CREATE TABLE IF NOT EXISTS `backup_other_deposits` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `other_deposit_id` bigint unsigned NOT NULL,
  `other` text COLLATE utf8mb4_unicode_ci,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entry` bigint unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_other_deposits_other_deposit_id_foreign` (`other_deposit_id`),
  KEY `backup_other_deposits_entry_foreign` (`entry`),
  CONSTRAINT `backup_other_deposits_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `backup_other_deposits_other_deposit_id_foreign` FOREIGN KEY (`other_deposit_id`) REFERENCES `other_deposits` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.backup_other_deposits: ~0 rows (approximately)

-- Dumping structure for table realstatedb.backup_payments
CREATE TABLE IF NOT EXISTS `backup_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payment_id` bigint unsigned NOT NULL,
  `sale_id` bigint unsigned NOT NULL,
  `commission` json DEFAULT NULL,
  `commission_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `percentage` double NOT NULL DEFAULT '0',
  `comment` text COLLATE utf8mb4_unicode_ci,
  `entry` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_payments_payment_id_foreign` (`payment_id`),
  KEY `backup_payments_sale_id_foreign` (`sale_id`),
  KEY `backup_payments_entry_foreign` (`entry`),
  CONSTRAINT `backup_payments_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `backup_payments_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`),
  CONSTRAINT `backup_payments_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.backup_payments: ~0 rows (approximately)

-- Dumping structure for table realstatedb.backup_salaries
CREATE TABLE IF NOT EXISTS `backup_salaries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `salary_id` bigint unsigned NOT NULL,
  `user_detail_id` bigint unsigned NOT NULL,
  `group_id` bigint unsigned DEFAULT NULL,
  `type_id` bigint unsigned DEFAULT NULL,
  `other` text COLLATE utf8mb4_unicode_ci,
  `monthly` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entry` bigint unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_salaries_salary_id_foreign` (`salary_id`),
  KEY `backup_salaries_user_detail_id_foreign` (`user_detail_id`),
  KEY `backup_salaries_group_id_foreign` (`group_id`),
  KEY `backup_salaries_type_id_foreign` (`type_id`),
  KEY `backup_salaries_entry_foreign` (`entry`),
  CONSTRAINT `backup_salaries_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `backup_salaries_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `salaries` (`id`),
  CONSTRAINT `backup_salaries_salary_id_foreign` FOREIGN KEY (`salary_id`) REFERENCES `salaries` (`id`),
  CONSTRAINT `backup_salaries_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `salary_types` (`id`),
  CONSTRAINT `backup_salaries_user_detail_id_foreign` FOREIGN KEY (`user_detail_id`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.backup_salaries: ~0 rows (approximately)

-- Dumping structure for table realstatedb.backup_sales
CREATE TABLE IF NOT EXISTS `backup_sales` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sale_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `agent_id` bigint unsigned DEFAULT NULL,
  `shareholder_id` bigint unsigned NOT NULL,
  `price` double NOT NULL DEFAULT '0',
  `sector` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `block` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `road` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plot` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kata` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'cash, emi',
  `commission` json NOT NULL COMMENT 'commission data will be comes from commission table data take which agent get how much commission',
  `date` date NOT NULL,
  `entry` bigint unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_sales_sale_id_foreign` (`sale_id`),
  KEY `backup_sales_customer_id_foreign` (`customer_id`),
  KEY `backup_sales_agent_id_foreign` (`agent_id`),
  KEY `backup_sales_shareholder_id_foreign` (`shareholder_id`),
  KEY `backup_sales_entry_foreign` (`entry`),
  CONSTRAINT `backup_sales_agent_id_foreign` FOREIGN KEY (`agent_id`) REFERENCES `user_details` (`id`),
  CONSTRAINT `backup_sales_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `backup_sales_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `backup_sales_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`),
  CONSTRAINT `backup_sales_shareholder_id_foreign` FOREIGN KEY (`shareholder_id`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.backup_sales: ~0 rows (approximately)
INSERT INTO `backup_sales` (`id`, `sale_id`, `customer_id`, `agent_id`, `shareholder_id`, `price`, `sector`, `block`, `road`, `plot`, `kata`, `type`, `commission`, `date`, `entry`, `comment`, `created_at`, `updated_at`) VALUES
	(1, 5, 2, NULL, 2, 2000, '85', '20', '23', '52', '20', 'cash', '{"installment": [{"hand": "shareholder", "percentage": 80, "shareholder_id": 2}], "down_payment": [{"hand": "shareholder", "percentage": 85, "shareholder_id": 2}], "booking_money": [{"hand": "shareholder", "percentage": 80, "shareholder_id": 2}]}', '2023-08-19', 2, 'po', '2023-08-19 06:57:35', '2023-08-19 06:57:35');

-- Dumping structure for table realstatedb.backup_transactions
CREATE TABLE IF NOT EXISTS `backup_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` bigint unsigned NOT NULL,
  `user_details_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0' COMMENT 'withdraw = 0, cashin = 1',
  `other` text COLLATE utf8mb4_unicode_ci,
  `entry` bigint unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `backup_transactions_transaction_id_foreign` (`transaction_id`),
  KEY `backup_transactions_user_details_id_foreign` (`user_details_id`),
  KEY `backup_transactions_entry_foreign` (`entry`),
  CONSTRAINT `backup_transactions_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `backup_transactions_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`),
  CONSTRAINT `backup_transactions_user_details_id_foreign` FOREIGN KEY (`user_details_id`) REFERENCES `user_details` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.backup_transactions: ~0 rows (approximately)
INSERT INTO `backup_transactions` (`id`, `transaction_id`, `user_details_id`, `model_type`, `model_id`, `amount`, `date`, `status`, `other`, `entry`, `comment`, `created_at`, `updated_at`) VALUES
	(1, 1, 2, 'App\\Models\\Investor', 2, -1000, '2023-08-06', 0, NULL, 1, 'update', '2023-08-06 09:53:18', '2023-08-06 09:53:18');

-- Dumping structure for table realstatedb.bank_infos
CREATE TABLE IF NOT EXISTS `bank_infos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `bank_name_id` bigint unsigned NOT NULL,
  `account_id` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `address` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '0',
  `entry` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bank_infos_account_id_unique` (`account_id`),
  KEY `bank_infos_bank_name_id_foreign` (`bank_name_id`),
  KEY `bank_infos_entry_foreign` (`entry`),
  CONSTRAINT `bank_infos_bank_name_id_foreign` FOREIGN KEY (`bank_name_id`) REFERENCES `bank_names` (`id`),
  CONSTRAINT `bank_infos_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.bank_infos: ~7 rows (approximately)
INSERT INTO `bank_infos` (`id`, `bank_name_id`, `account_id`, `amount`, `address`, `status`, `entry`, `created_at`, `updated_at`) VALUES
	(1, 1, '11111111111111', 7000, 'Default Account', 1, 1, '2023-07-25 07:41:01', '2023-09-19 20:46:29'),
	(2, 3, '01889725954', 13000, 'ubyubkjhnuj7898747', 1, 1, '2023-08-12 14:39:23', '2023-09-19 20:47:22'),
	(3, 2, '0178945879', 21752, 'bhubhubhubuh', 1, 1, '2023-08-12 14:39:47', '2023-09-18 17:52:13'),
	(4, 2, '0188754548', 7000, 'cxc xc', 1, 1, '2023-08-12 14:43:36', '2023-08-19 05:05:59'),
	(5, 5, '01224915451', 1900, 'hhvhjj', 1, 1, '2023-08-12 14:48:49', '2023-08-27 19:00:39'),
	(6, 4, '01887454881', 7800, 'chchjihvivi', 1, 1, '2023-08-12 14:49:48', '2023-08-27 19:07:29'),
	(7, 6, '0148595199', 13400, 'dd klckl ckl', 1, 1, '2023-08-12 14:51:08', '2023-09-19 20:44:57');

-- Dumping structure for table realstatedb.bank_names
CREATE TABLE IF NOT EXISTS `bank_names` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `entry` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bank_names_name_unique` (`name`),
  KEY `bank_names_entry_foreign` (`entry`),
  CONSTRAINT `bank_names_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.bank_names: ~5 rows (approximately)
INSERT INTO `bank_names` (`id`, `name`, `status`, `entry`, `created_at`, `updated_at`) VALUES
	(1, 'Cash', 1, 1, '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(2, 'Pubali Bank', 1, 1, '2023-08-12 14:38:11', '2023-08-12 14:38:11'),
	(3, 'AB Bank', 1, 1, '2023-08-12 14:38:45', '2023-08-12 14:38:45'),
	(4, 'CB Bank', 1, 1, '2023-08-12 14:40:31', '2023-08-12 14:40:31'),
	(5, 'MTB Bank', 1, 1, '2023-08-12 14:40:45', '2023-08-12 14:40:45'),
	(6, 'Rupali Bank', 1, 1, '2023-08-12 14:41:00', '2023-08-12 14:41:00');

-- Dumping structure for table realstatedb.bank_transactions
CREATE TABLE IF NOT EXISTS `bank_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_info_id` bigint unsigned DEFAULT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `balance` double NOT NULL DEFAULT '0' COMMENT 'before balance of each transaction',
  `trx_by` tinyint NOT NULL DEFAULT '0' COMMENT 'cash=0,online_transfer=1,check=2',
  `trx_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'transaction_no',
  `other` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '0' COMMENT 'withdraw=0,cashin=1',
  `date` date DEFAULT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  `entry` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bank_transactions_account_id_unique` (`account_id`),
  KEY `bank_transactions_bank_info_id_foreign` (`bank_info_id`),
  KEY `bank_transactions_entry_foreign` (`entry`),
  CONSTRAINT `bank_transactions_bank_info_id_foreign` FOREIGN KEY (`bank_info_id`) REFERENCES `bank_infos` (`id`),
  CONSTRAINT `bank_transactions_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.bank_transactions: ~42 rows (approximately)
INSERT INTO `bank_transactions` (`id`, `account_id`, `bank_info_id`, `amount`, `balance`, `trx_by`, `trx_no`, `other`, `status`, `date`, `model_type`, `model_id`, `entry`, `created_at`, `updated_at`) VALUES
	(1, '100001', 1, 100, 0, 1, '1', 'k', 1, '2023-08-03', 'App\\Models\\Investment', 1, 1, '2023-08-03 16:14:50', '2023-08-03 16:14:50'),
	(2, '100002', 1, 50, 100, 1, '1', 'anything', 1, '2023-08-05', 'App\\Models\\Investment', 2, 1, '2023-08-05 10:38:19', '2023-08-05 10:38:19'),
	(3, '100003', 1, -80, 150, 1, '1', NULL, 0, '2023-08-06', 'App\\Models\\Transaction', 1, 1, '2023-08-06 09:22:38', '2023-08-06 09:53:18'),
	(4, '100004', 1, -30, 70, 1, '1', 'yftudty', 0, '2023-08-06', 'App\\Models\\Transaction', 2, 1, '2023-08-06 14:05:46', '2023-08-06 14:05:46'),
	(5, '100005', 1, 7000, 50, 1, '1', 'Laboris dolorem accu', 1, '2023-08-13', 'App\\Models\\OtherDeposit', 1, 1, '2023-08-12 18:42:39', '2023-08-12 18:42:39'),
	(6, '100006', 2, 5000, 0, 1, '5122952', 'Sapiente a aut non exx', 1, '2023-08-13', 'App\\Models\\OtherDeposit', 2, 1, '2023-08-12 18:43:57', '2023-08-12 18:43:57'),
	(7, '100007', 3, 5000, 0, 0, '525225257', 'Sed voluptas quidem 514', 1, '2023-08-13', 'App\\Models\\OtherDeposit', 3, 1, '2023-08-12 18:44:33', '2023-08-12 18:44:33'),
	(8, '100008', 6, 4000, 0, 0, '2529529', 'Dignissimos recusand1917971', 1, '2023-08-13', 'App\\Models\\OtherDeposit', 4, 1, '2023-08-12 18:45:10', '2023-08-12 18:45:10'),
	(9, '100009', 1, -1000, 7050, 1, '1', 'j  j j', 0, '2023-08-13', 'App\\Models\\Salary', 1, 1, '2023-08-12 18:46:30', '2023-08-12 18:46:30'),
	(10, '100010', 1, -4000, 6050, 1, '1', 'j  j j', 0, '2023-08-13', 'App\\Models\\Salary', 2, 1, '2023-08-12 18:46:30', '2023-08-12 18:46:30'),
	(11, '100011', 4, -5000, 5000, 0, 'jj hj j', 'h h h', 0, '2023-08-19', 'App\\Models\\Salary', 3, 1, '2023-08-12 18:49:31', '2023-08-12 18:49:31'),
	(12, '100012', 3, -3000, 5000, 0, 'jj hj j', 'h h h', 0, '2023-08-13', 'App\\Models\\Salary', 4, 1, '2023-08-12 18:49:31', '2023-08-12 18:49:31'),
	(13, '100013', 6, -2000, 4000, 0, '2411811', 'h j  ihkh', 0, '2023-08-13', 'App\\Models\\Salary', 5, 1, '2023-08-12 18:50:32', '2023-08-12 18:50:32'),
	(14, '100014', 6, -1000, 2000, 0, '2411811', 'h j  ihkh', 0, '2023-08-13', 'App\\Models\\Salary', 6, 1, '2023-08-12 18:50:32', '2023-08-12 18:50:32'),
	(15, '100015', 5, 12000, 0, 0, '914191', 'ij  jk  jknon', 1, '2023-08-13', 'App\\Models\\Investment', 3, 1, '2023-08-12 18:51:35', '2023-08-12 18:51:35'),
	(16, '100016', 4, 4000, 0, 0, '49171', 'b  jh hjk', 1, '2023-08-13', 'App\\Models\\Investment', 4, 1, '2023-08-12 18:52:43', '2023-08-12 18:52:43'),
	(17, '100017', 3, 4000, 2000, 0, '7191991hhj   h h', 'hi hi hi i', 1, '2023-08-13', 'App\\Models\\Investment', 5, 1, '2023-08-12 18:53:38', '2023-08-12 18:53:38'),
	(18, '100018', 3, 1000, 6000, 1, '89465616212', 'somthe', 1, '2023-08-19', 'App\\Models\\Payment', 1, 1, '2023-08-19 05:04:44', '2023-08-19 05:04:44'),
	(19, '100019', 5, 800, 1200, 0, '34534534543', 'wer', 1, '2023-08-19', 'App\\Models\\Payment', 2, 1, '2023-08-19 05:05:31', '2023-08-19 05:05:31'),
	(20, '100020', 4, 3000, 4000, 2, '342343342323', 'wer', 1, '2023-08-13', 'App\\Models\\Payment', 3, 1, '2023-08-19 05:05:59', '2023-08-19 05:05:59'),
	(21, '100021', 2, 4500, 5000, 1, '094534859848797', NULL, 1, '2023-08-17', 'App\\Models\\Payment', 4, 1, '2023-08-19 05:06:43', '2023-08-19 05:06:43'),
	(22, '100022', 6, 9000, 1000, 2, '989656213235', NULL, 1, '2023-08-18', 'App\\Models\\Payment', 5, 1, '2023-08-19 05:07:17', '2023-08-19 05:07:17'),
	(23, '100023', 1, 50, 2050, 1, '1', 'gdhtdnc', 1, '2023-08-19', 'App\\Models\\Payment', 6, 1, '2023-08-19 06:36:23', '2023-08-19 06:36:23'),
	(24, '100024', 3, 500, 7000, 1, '989656218558', 'wer', 1, '2023-08-31', 'App\\Models\\Payment', 7, 2, '2023-08-19 06:56:52', '2023-08-19 06:56:52'),
	(25, '100025', 1, 5000, 3000, 1, '1', 'Aliqua Do sed est', 1, '2023-08-22', 'App\\Models\\OtherDeposit', 5, 1, '2023-08-22 01:46:54', '2023-08-22 01:46:54'),
	(26, '100026', 7, 8500, 0, 1, '89465616212', NULL, 1, '2023-08-11', 'App\\Models\\OtherDeposit', 13, 1, '2023-08-24 03:08:58', '2023-08-24 03:08:58'),
	(27, '100027', 7, 7000, 8500, 1, '3453453454334', NULL, 1, '2023-08-24', 'App\\Models\\OtherDeposit', 14, 1, '2023-08-24 03:10:03', '2023-08-24 03:10:03'),
	(28, '100028', 7, 3000, 15500, 0, '89465616888', NULL, 1, '2023-08-24', 'App\\Models\\OtherDeposit', 15, 1, '2023-08-24 03:12:50', '2023-08-24 03:12:50'),
	(29, '100029', 7, 7000, 18500, 0, '0945348598451', NULL, 1, '2023-08-24', 'App\\Models\\OtherDeposit', 16, 1, '2023-08-24 03:16:05', '2023-08-24 03:16:05'),
	(30, '100030', 7, -5000, 25500, 1, '989656217777', NULL, 0, '2023-08-24', 'App\\Models\\Expense', 1, 1, '2023-08-24 03:17:34', '2023-08-24 03:17:34'),
	(31, '100031', 7, -7000, 20500, 0, '34534578458', NULL, 0, '2023-08-24', 'App\\Models\\Expense', 2, 1, '2023-08-24 03:19:09', '2023-08-24 03:19:09'),
	(32, '100032', 1, -500, 0, 1, '1', 'efsdf', 0, '2023-08-28', 'App\\Models\\Transaction', 31, 1, '2023-08-27 18:29:29', '2023-08-27 18:29:29'),
	(33, '100033', 1, -1000, 0, 1, '1', 'ftufy', 0, '2023-08-28', 'App\\Models\\Transaction', 32, 1, '2023-08-27 18:53:16', '2023-08-27 18:53:16'),
	(34, '100034', 1, -2000, 0, 1, '1', 'jgvgchhg', 0, '2023-08-28', 'App\\Models\\Transaction', 33, 1, '2023-08-27 18:55:36', '2023-08-27 18:55:36'),
	(35, '100035', 7, -200, 0, 0, '15515153151', 'vhjn', 0, '2023-08-28', 'App\\Models\\Transaction', 34, 1, '2023-08-27 18:57:09', '2023-08-27 18:57:09'),
	(36, '100036', 7, -400, 0, 0, '151515', 'nmvhjvhj', 0, '2023-08-28', 'App\\Models\\Transaction', 35, 1, '2023-08-27 18:57:51', '2023-08-27 18:57:51'),
	(37, '100037', 7, -500, 0, 0, '23155111', 'hjvjvj', 0, '2023-08-28', 'App\\Models\\Transaction', 36, 1, '2023-08-27 18:58:43', '2023-08-27 18:58:43'),
	(38, '100038', 6, -200, 0, 0, '23132', 'vhjvjgjvh', 0, '2023-08-28', 'App\\Models\\Transaction', 37, 1, '2023-08-27 18:59:58', '2023-08-27 18:59:58'),
	(39, '100039', 5, -100, 0, 0, '2', NULL, 0, '2023-08-28', 'App\\Models\\Transaction', 38, 1, '2023-08-27 19:00:39', '2023-08-27 19:00:39'),
	(40, '100040', 3, -1000, 0, 1, '23325', 'n  k', 0, '2023-08-28', 'App\\Models\\Transaction', 39, 1, '2023-08-27 19:01:46', '2023-08-27 19:01:46'),
	(41, '100041', 1, -1200, 0, 1, '1', NULL, 0, '2023-08-28', 'App\\Models\\Transaction', 40, 1, '2023-08-27 19:02:56', '2023-08-27 19:02:56'),
	(42, '100042', 3, -1500, 0, 0, '251', NULL, 0, '2023-08-28', 'App\\Models\\Transaction', 41, 1, '2023-08-27 19:04:02', '2023-08-27 19:04:02'),
	(43, '100043', 1, -800, 0, 1, '1', NULL, 0, '2023-08-28', 'App\\Models\\Transaction', 42, 1, '2023-08-27 19:04:53', '2023-08-27 19:04:53'),
	(44, '100044', 2, -1700, 0, 0, '2332312', NULL, 0, '2023-08-28', 'App\\Models\\Transaction', 43, 1, '2023-08-27 19:05:48', '2023-08-27 19:05:48'),
	(45, '100045', 2, -800, 0, 0, '233231221', NULL, 0, '2023-08-28', 'App\\Models\\Transaction', 44, 1, '2023-08-27 19:06:14', '2023-08-27 19:06:14'),
	(46, '100046', 6, -2000, 0, 0, '1323132', NULL, 0, '2023-08-28', 'App\\Models\\Transaction', 45, 1, '2023-08-27 19:07:29', '2023-08-27 19:07:29'),
	(47, '100047', 3, 452, 0, 1, '09453485984539485', 'testing', 1, '2023-09-18', 'App\\Models\\Payment', 8, 1, '2023-09-18 03:41:19', '2023-09-18 03:41:19'),
	(48, '100048', 3, 7800, 0, 1, '09453485984539485', 'something', 1, '2023-09-18', 'App\\Models\\Payment', 9, 1, '2023-09-18 17:48:13', '2023-09-18 17:48:13'),
	(49, '100049', 3, 8500, 0, 1, '989656213235', 'fghdfghf', 1, '2023-09-18', 'App\\Models\\Payment', 10, 1, '2023-09-18 17:52:13', '2023-09-18 17:52:13'),
	(50, '100050', 7, 1000, 0, 0, '164951915', 'my', 1, '2023-09-18', 'App\\Models\\Payment', 11, 1, '2023-09-19 20:44:57', '2023-09-19 20:44:57'),
	(51, '100051', 1, 2000, 0, 1, '1', 'money back', 1, '2023-09-20', 'App\\Models\\Payment', 12, 1, '2023-09-19 20:45:38', '2023-09-19 20:45:38'),
	(52, '100052', 2, 1000, 0, 2, '4944842842', 'hhkjk', 1, '2023-09-20', 'App\\Models\\Payment', 13, 1, '2023-09-19 20:46:09', '2023-09-19 20:46:09'),
	(53, '100053', 1, 2500, 0, 1, '1', 'jh,kugj,', 1, '2023-09-20', 'App\\Models\\Payment', 14, 1, '2023-09-19 20:46:29', '2023-09-19 20:46:29'),
	(54, '100054', 2, 5000, 0, 2, '484981416', 'jkh,hj,jyjyj', 1, '2023-09-20', 'App\\Models\\Payment', 15, 1, '2023-09-19 20:47:22', '2023-09-19 20:47:22');

-- Dumping structure for table realstatedb.commissions
CREATE TABLE IF NOT EXISTS `commissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint NOT NULL COMMENT 'Booking Money = 0, Down Payment = 1, Installment = 2',
  `total` double NOT NULL DEFAULT '0',
  `rank1` json DEFAULT NULL COMMENT 'hand1, hand2, hand3, shareholder',
  `rank2` json DEFAULT NULL COMMENT 'hand1, hand2, hand3, shareholder',
  `rank3` json DEFAULT NULL COMMENT 'hand1, hand2, hand3, shareholder',
  `user_details_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `commissions_user_details_id_foreign` (`user_details_id`),
  CONSTRAINT `commissions_user_details_id_foreign` FOREIGN KEY (`user_details_id`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.commissions: ~3 rows (approximately)
INSERT INTO `commissions` (`id`, `type`, `total`, `rank1`, `rank2`, `rank3`, `user_details_id`, `created_at`, `updated_at`) VALUES
	(1, 0, 80, '{"hand1": "20", "hand2": "14", "hand3": "7", "shareholder": "39.00"}', '{"hand1": "25", "hand2": "18", "hand3": "10", "shareholder": "27.00"}', '{"hand1": "30", "hand2": "21", "hand3": "15", "shareholder": "14.00"}', 1, '2023-07-25 07:41:01', '2023-08-12 18:33:50'),
	(2, 1, 85, '{"hand1": "35", "hand2": "24", "hand3": "15", "shareholder": "11.00"}', '{"hand1": "28", "hand2": "18", "hand3": "14", "shareholder": "25.00"}', '{"hand1": "38", "hand2": "20", "hand3": "14", "shareholder": "13.00"}', 1, '2023-07-25 07:41:01', '2023-08-12 18:34:42'),
	(3, 2, 80, '{"hand1": "24", "hand2": "18", "hand3": "14", "shareholder": "24.00"}', '{"hand1": "30", "hand2": "24", "hand3": "12", "shareholder": "14.00"}', '{"hand1": "35", "hand2": "20", "hand3": "14", "shareholder": "11.00"}', 1, '2023-07-25 07:41:01', '2023-08-12 18:35:54');

-- Dumping structure for table realstatedb.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `present_address` text COLLATE utf8mb4_unicode_ci,
  `permanent_address` text COLLATE utf8mb4_unicode_ci,
  `emergency_contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_name` json DEFAULT NULL COMMENT 'father name, and mother name',
  `status` tinyint NOT NULL DEFAULT '0',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entry` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_account_id_unique` (`account_id`),
  KEY `customers_entry_foreign` (`entry`),
  CONSTRAINT `customers_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.customers: ~6 rows (approximately)
INSERT INTO `customers` (`id`, `account_id`, `name`, `phone`, `present_address`, `permanent_address`, `emergency_contact`, `occupation`, `parent_name`, `status`, `image`, `entry`, `created_at`, `updated_at`) VALUES
	(1, 'cu789453374', 'Raihan Uddin', '+1 (667) 239-1196', 'Qui qui aute non ex', 'Quia earum ea libero', '+1 (116) 833-1266', 'Saepe eu voluptate a', '{"father": "Xerxes Tanner", "mother": "Laboris odit quibusd"}', 1, NULL, 1, '2023-08-09 02:22:58', '2023-08-09 02:22:58'),
	(2, 'cu9921', 'Kawsar', '+1 (249) 203-2528', 'Eligendi in expedita', 'Rem consequatur Und', '+1 (708) 357-4197', 'Cillum illo repudian', '{"father": "Salvador Diaz", "mother": "Mollit dolor deserun"}', 1, NULL, 1, '2023-08-12 18:26:59', '2023-08-12 18:26:59'),
	(3, 'cu9922', 'Wilma Conrad', '+1 (618) 152-2163', 'Aut ratione aut vel', 'Nihil ut praesentium', '+1 (461) 695-5209', 'Molestiae do officii', '{"father": "Gemma Glenn", "mother": "Reiciendis laborum"}', 1, NULL, 1, '2023-08-12 18:27:29', '2023-08-12 18:27:29'),
	(4, 'cu9923', 'Yasir Duran', '+1 (386) 244-9624', 'Repudiandae earum do', 'Dolor ut aliquam mod', '+1 (735) 247-6417', 'Nihil ut dicta velit', '{"father": "Skyler Mooney", "mother": "Illum deserunt ad r"}', 1, NULL, 1, '2023-08-12 18:27:59', '2023-08-12 18:27:59'),
	(5, '9925', 'Gavin Estrada', '+1 (696) 335-5108', 'Eligendi excepturi r', 'Dolor maiores aut ma', '+1 (781) 778-3752', 'Sed aspernatur labor', '{"father": "Jeanette Battle", "mother": "Eiusmod nihil quod e"}', 1, NULL, 1, '2023-08-12 18:28:24', '2023-08-28 17:07:12'),
	(6, NULL, 'Kitra Nash', '+1 (696) 335-5108', 'Molestiae qui lorem', 'Tempore eius sint q', '+1 (159) 581-3224', 'Ex non ut praesentiu', '{"father": "Patrick Stewart", "mother": "Aut laboris aliquam"}', 1, NULL, 1, '2023-08-28 16:58:22', '2023-08-28 16:58:22'),
	(7, '1188', 'Md kamal uddin', '01887956874', 'gfhgfh', 'fgh', 'fgh', 'fghg', '{"father": "fhgh", "mother": "ghf"}', 1, NULL, 1, '2023-09-19 20:41:26', '2023-09-19 20:41:26');

-- Dumping structure for table realstatedb.expenses
CREATE TABLE IF NOT EXISTS `expenses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `expense_item_id` bigint unsigned NOT NULL,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entry` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_expense_item_id_foreign` (`expense_item_id`),
  KEY `expenses_entry_foreign` (`entry`),
  CONSTRAINT `expenses_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `expenses_expense_item_id_foreign` FOREIGN KEY (`expense_item_id`) REFERENCES `expense_items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.expenses: ~2 rows (approximately)
INSERT INTO `expenses` (`id`, `expense_item_id`, `document`, `entry`, `created_at`, `updated_at`) VALUES
	(1, 1, NULL, 1, '2023-08-24 03:17:34', '2023-08-24 03:17:34'),
	(2, 1, NULL, 1, '2023-08-24 03:19:09', '2023-08-24 03:19:09');

-- Dumping structure for table realstatedb.expense_items
CREATE TABLE IF NOT EXISTS `expense_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent` bigint unsigned DEFAULT NULL,
  `entry` bigint unsigned NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0' COMMENT 'if expense have then 1 else 0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `expense_items_title_unique` (`title`),
  KEY `expense_items_parent_foreign` (`parent`),
  KEY `expense_items_entry_foreign` (`entry`),
  CONSTRAINT `expense_items_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `expense_items_parent_foreign` FOREIGN KEY (`parent`) REFERENCES `expense_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.expense_items: ~0 rows (approximately)
INSERT INTO `expense_items` (`id`, `title`, `parent`, `entry`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'anything', NULL, 1, 0, '2023-08-24 03:16:55', '2023-08-24 03:16:55');

-- Dumping structure for table realstatedb.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table realstatedb.investments
CREATE TABLE IF NOT EXISTS `investments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `investor_id` bigint unsigned NOT NULL,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` double NOT NULL DEFAULT '0',
  `duration` double NOT NULL DEFAULT '0',
  `duration_in` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entry` bigint unsigned NOT NULL,
  `last_interest` date DEFAULT NULL,
  `invest_at` date NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1=activate( get commission every month), 0 = deactive (not get any commission)',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `investments_account_id_unique` (`account_id`),
  KEY `investments_investor_id_foreign` (`investor_id`),
  KEY `investments_entry_foreign` (`entry`),
  CONSTRAINT `investments_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `investments_investor_id_foreign` FOREIGN KEY (`investor_id`) REFERENCES `investors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.investments: ~4 rows (approximately)
INSERT INTO `investments` (`id`, `account_id`, `investor_id`, `document`, `rate`, `duration`, `duration_in`, `entry`, `last_interest`, `invest_at`, `status`, `created_at`, `updated_at`) VALUES
	(1, '100001', 1, NULL, 10, 1, 'months', 1, '2023-08-01', '2023-06-03', 1, '2023-08-03 16:14:50', '2023-08-05 10:42:03'),
	(2, '100002', 2, NULL, 2, 12, 'months', 1, '2023-08-01', '2023-06-05', 1, '2023-08-05 10:38:19', '2023-08-05 10:42:04'),
	(3, '100003', 3, NULL, 6, 1, 'years', 1, NULL, '2023-08-13', 1, '2023-08-12 18:51:35', '2023-08-12 18:51:35'),
	(4, '100004', 2, NULL, 10, 1, 'months', 1, NULL, '2023-08-13', 1, '2023-08-12 18:52:43', '2023-08-12 18:52:43'),
	(5, '100005', 3, NULL, 20, 1, 'months', 1, NULL, '2023-08-13', 1, '2023-08-12 18:53:38', '2023-08-12 18:53:38');

-- Dumping structure for table realstatedb.investment_commissions
CREATE TABLE IF NOT EXISTS `investment_commissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `investment_id` bigint unsigned NOT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `investor_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `investment_commissions_investment_id_foreign` (`investment_id`),
  KEY `investment_commissions_investor_id_foreign` (`investor_id`),
  CONSTRAINT `investment_commissions_investment_id_foreign` FOREIGN KEY (`investment_id`) REFERENCES `investments` (`id`),
  CONSTRAINT `investment_commissions_investor_id_foreign` FOREIGN KEY (`investor_id`) REFERENCES `investors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.investment_commissions: ~4 rows (approximately)
INSERT INTO `investment_commissions` (`id`, `investment_id`, `amount`, `investor_id`, `created_at`, `updated_at`) VALUES
	(1, 1, 9032.2580645161, 1, '2023-08-05 10:40:15', '2023-08-05 10:40:15'),
	(2, 2, 16774.193548387, 2, '2023-08-05 10:40:15', '2023-08-05 10:40:15'),
	(3, 1, 10000, 1, '2023-08-05 10:42:03', '2023-08-05 10:42:03'),
	(4, 2, 20000, 2, '2023-08-05 10:42:04', '2023-08-05 10:42:04');

-- Dumping structure for table realstatedb.investment_withdraws
CREATE TABLE IF NOT EXISTS `investment_withdraws` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `investor_id` bigint unsigned NOT NULL,
  `investment_id` bigint unsigned NOT NULL,
  `amount` double NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL,
  `entry` bigint unsigned NOT NULL,
  `other` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `investment_withdraws_investor_id_foreign` (`investor_id`),
  KEY `investment_withdraws_investment_id_foreign` (`investment_id`),
  KEY `investment_withdraws_entry_foreign` (`entry`),
  CONSTRAINT `investment_withdraws_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `investment_withdraws_investment_id_foreign` FOREIGN KEY (`investment_id`) REFERENCES `investments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `investment_withdraws_investor_id_foreign` FOREIGN KEY (`investor_id`) REFERENCES `investors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.investment_withdraws: ~0 rows (approximately)

-- Dumping structure for table realstatedb.investors
CREATE TABLE IF NOT EXISTS `investors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `present_address` text COLLATE utf8mb4_unicode_ci,
  `permanent_address` text COLLATE utf8mb4_unicode_ci,
  `emergency_contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` bigint unsigned NOT NULL,
  `parent_name` json DEFAULT NULL COMMENT 'father name, and mother name',
  `status` tinyint NOT NULL DEFAULT '0',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `income` double NOT NULL DEFAULT '0',
  `reference_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `investors_account_id_unique` (`account_id`),
  UNIQUE KEY `investors_phone_unique` (`phone`),
  KEY `investors_role_foreign` (`role`),
  KEY `investors_reference_id_foreign` (`reference_id`),
  CONSTRAINT `investors_reference_id_foreign` FOREIGN KEY (`reference_id`) REFERENCES `users` (`id`),
  CONSTRAINT `investors_role_foreign` FOREIGN KEY (`role`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.investors: ~4 rows (approximately)
INSERT INTO `investors` (`id`, `account_id`, `name`, `phone`, `present_address`, `permanent_address`, `emergency_contact`, `occupation`, `role`, `parent_name`, `status`, `image`, `income`, `reference_id`, `created_at`, `updated_at`) VALUES
	(1, '10000000001', 'Rudyard Bauer', '+11665514801', 'Quis nesciunt fugit', 'Quis nesciunt fugit', NULL, NULL, 6, '{"father": "hhn", "mother": "ghn"}', 1, NULL, 500, 1, '2023-08-03 16:05:57', '2023-08-06 14:05:46'),
	(2, '10000000002', 'Scarlet Wall', '+1 (718) 407-2213', 'Et non corrupti iur', 'Maxime velit et adi', '+1 (575) 171-4408', 'Vel eu suscipit volu', 6, '{"father": "Gisela Blanchard", "mother": "Aliquid obcaecati vo"}', 1, NULL, 19500, 1, '2023-08-05 09:32:28', '2023-08-06 09:53:18'),
	(3, '10000000003', 'Owen Meyers', '+1 (283) 941-9708', 'Tempore esse labor', 'Atque harum sapiente', '+1 (938) 691-5464', 'Rem cum fugiat amet', 6, '{"father": "Kato Powell", "mother": "Dolore ex pariatur"}', 1, NULL, 0, 1, '2023-08-12 18:29:12', '2023-08-12 18:29:12'),
	(4, '10000000004', 'Nita Serrano', '+1 (484) 633-5635', 'Nisi cupiditate ipsa', 'Aliquam esse id con', '+1 (524) 849-7391', 'Ipsa et ipsa sed i', 6, '{"father": "Mallory Turner", "mother": "Excepturi nemo quasi"}', 1, NULL, 0, 1, '2023-08-12 18:29:46', '2023-08-12 18:29:46'),
	(5, '10000000005', 'Britanney Haley', '+1 (451) 115-3196', 'Rerum totam do Nam o', 'Ut consequatur unde', '+1 (194) 742-3012', 'Cum molestias volupt', 6, '{"father": "Wynter Olson", "mother": "Molestiae natus est"}', 1, NULL, 0, 1, '2023-08-12 18:30:00', '2023-08-12 18:30:22');

-- Dumping structure for table realstatedb.land_purchases
CREATE TABLE IF NOT EXISTS `land_purchases` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `land` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `giver` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `taker` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mouza` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rs` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sa` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `entry` bigint unsigned NOT NULL,
  `document` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `land_purchases_entry_foreign` (`entry`),
  CONSTRAINT `land_purchases_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.land_purchases: ~0 rows (approximately)

-- Dumping structure for table realstatedb.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.migrations: ~38 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
	(3, '2014_10_12_100000_create_password_resets_table', 1),
	(4, '2019_08_19_000000_create_failed_jobs_table', 1),
	(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(6, '2023_02_19_145236_create_permission_tables', 1),
	(7, '2023_02_20_045238_create_user_details_table', 1),
	(8, '2023_02_21_131406_create_customers_table', 1),
	(9, '2023_02_22_053308_create_sales_table', 1),
	(10, '2023_02_22_053503_create_payments_table', 1),
	(11, '2023_02_22_054523_create_commissions_table', 1),
	(12, '2023_02_28_131803_create_settings_table', 1),
	(13, '2023_04_16_210614_create_backup_sales_table', 1),
	(14, '2023_04_16_210636_create_backup_payments_table', 1),
	(15, '2023_05_07_091056_create_investors_table', 1),
	(16, '2023_05_09_234947_create_investments_table', 1),
	(17, '2023_05_10_194759_create_backup_investments_table', 1),
	(18, '2023_05_11_191222_create_land_purchases_table', 1),
	(19, '2023_05_14_111230_create_expense_items_table', 1),
	(20, '2023_05_14_154846_create_backup_expense_items_table', 1),
	(21, '2023_05_15_111109_create_expenses_table', 1),
	(22, '2023_05_15_221004_create_backup_expenses_table', 1),
	(23, '2023_05_24_100808_create_bank_names_table', 1),
	(24, '2023_05_25_235033_create_bank_infos_table', 1),
	(25, '2023_05_26_105227_create_backup_bank_infos_table', 1),
	(26, '2023_05_26_181320_create_transactions_table', 1),
	(27, '2023_05_26_210626_create_backup_transactions_table', 1),
	(28, '2023_05_27_053835_create_bank_transactions_table', 1),
	(29, '2023_05_27_083912_create_backup_bank_transactions_table', 1),
	(30, '2023_06_09_113455_create_other_deposits_table', 1),
	(31, '2023_06_09_113516_create_backup_other_deposits_table', 1),
	(32, '2023_06_15_131154_create_salary_types_table', 1),
	(33, '2023_06_22_005306_create_attendances_table', 1),
	(34, '2023_07_08_100010_create_investment_commissions_table', 1),
	(35, '2023_07_08_151038_create_salaries_table', 1),
	(36, '2023_07_09_123101_create_backup_salaries_table', 1),
	(37, '2023_08_05_182957_create_investment_withdraws_table', 2),
	(38, '2023_08_05_183409_create_backup_investment_withdraws_table', 2);

-- Dumping structure for table realstatedb.model_has_permissions
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.model_has_permissions: ~0 rows (approximately)

-- Dumping structure for table realstatedb.model_has_roles
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.model_has_roles: ~8 rows (approximately)
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
	(1, 'App\\Models\\User', 1),
	(3, 'App\\Models\\User', 2),
	(3, 'App\\Models\\User', 3),
	(3, 'App\\Models\\User', 4),
	(3, 'App\\Models\\User', 5),
	(2, 'App\\Models\\User', 6),
	(2, 'App\\Models\\User', 7),
	(2, 'App\\Models\\User', 8);

-- Dumping structure for table realstatedb.other_deposits
CREATE TABLE IF NOT EXISTS `other_deposits` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `other` text COLLATE utf8mb4_unicode_ci,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entry` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `other_deposits_account_id_unique` (`account_id`),
  KEY `other_deposits_entry_foreign` (`entry`),
  CONSTRAINT `other_deposits_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.other_deposits: ~8 rows (approximately)
INSERT INTO `other_deposits` (`id`, `account_id`, `other`, `document`, `entry`, `created_at`, `updated_at`) VALUES
	(1, '100001', 'Saepe est eu ullam o', NULL, 1, '2023-08-12 18:42:39', '2023-08-12 18:42:39'),
	(2, '100002', 'Vel adipisicing Nam', NULL, 1, '2023-08-12 18:43:57', '2023-08-12 18:43:57'),
	(3, '100003', 'Ipsum ad eum quae au', NULL, 1, '2023-08-12 18:44:33', '2023-08-12 18:44:33'),
	(4, '100004', 'Doloremque eum error9', NULL, 1, '2023-08-12 18:45:10', '2023-08-12 18:45:10'),
	(5, '100005', 'Quis reiciendis sint', NULL, 1, '2023-08-22 01:46:54', '2023-08-22 01:46:54'),
	(13, '100006', NULL, NULL, 1, '2023-08-24 03:08:58', '2023-08-24 03:08:58'),
	(14, '100007', 'transaction again', NULL, 1, '2023-08-24 03:10:03', '2023-08-24 03:10:03'),
	(15, '100008', NULL, NULL, 1, '2023-08-24 03:12:50', '2023-08-24 03:12:50'),
	(16, '100009', NULL, NULL, 1, '2023-08-24 03:16:04', '2023-08-24 03:16:04');

-- Dumping structure for table realstatedb.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.password_resets: ~0 rows (approximately)

-- Dumping structure for table realstatedb.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table realstatedb.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sale_id` bigint unsigned NOT NULL,
  `commission` json DEFAULT NULL,
  `commission_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `percentage` double NOT NULL DEFAULT '0',
  `entry` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_sale_id_foreign` (`sale_id`),
  KEY `payments_entry_foreign` (`entry`),
  CONSTRAINT `payments_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `payments_sale_id_foreign` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.payments: ~13 rows (approximately)
INSERT INTO `payments` (`id`, `sale_id`, `commission`, `commission_type`, `percentage`, `entry`, `created_at`, `updated_at`) VALUES
	(1, 4, '[{"hand": "hand_1", "account_id": "10", "percentage": 35}, {"hand": "hand_2", "account_id": "9", "percentage": 24}, {"hand": "shareholder", "account_id": "2", "percentage": 26}, {"hand": "general_manager", "account_id": 1, "percentage": "15.00"}]', 'down_payment', 85, 1, '2023-08-19 05:04:44', '2023-08-19 05:04:44'),
	(2, 4, '[{"hand": "hand_1", "account_id": "10", "percentage": 20}, {"hand": "hand_2", "account_id": "9", "percentage": 14}, {"hand": "shareholder", "account_id": "2", "percentage": 46}, {"hand": "general_manager", "account_id": 1, "percentage": "20.00"}]', 'installment', 80, 1, '2023-08-19 05:05:31', '2023-08-19 05:05:31'),
	(3, 4, '[{"hand": "hand_1", "account_id": "10", "percentage": 20}, {"hand": "hand_2", "account_id": "9", "percentage": 14}, {"hand": "shareholder", "account_id": "2", "percentage": 46}, {"hand": "general_manager", "account_id": 1, "percentage": "20.00"}]', 'installment', 80, 1, '2023-08-19 05:05:59', '2023-08-19 05:05:59'),
	(4, 3, '[{"hand": "hand_1", "account_id": "12", "percentage": 35}, {"hand": "hand_2", "account_id": "11", "percentage": 24}, {"hand": "hand_3", "account_id": "10", "percentage": 15}, {"hand": "shareholder", "account_id": "2", "percentage": 11}, {"hand": "general_manager", "account_id": 1, "percentage": "15.00"}]', 'down_payment', 85, 1, '2023-08-24 05:06:43', '2023-08-19 05:06:43'),
	(5, 3, '[{"hand": "hand_1", "account_id": "12", "percentage": 24}, {"hand": "hand_2", "account_id": "11", "percentage": 18}, {"hand": "hand_3", "account_id": "10", "percentage": 14}, {"hand": "shareholder", "account_id": "2", "percentage": 24}, {"hand": "general_manager", "account_id": 1, "percentage": "20.00"}]', 'booking_money', 80, 1, '2023-08-27 06:07:17', '2023-08-19 05:07:17'),
	(6, 4, '[{"hand": "hand_1", "account_id": "10", "percentage": 20}, {"hand": "hand_2", "account_id": "9", "percentage": 14}, {"hand": "shareholder", "account_id": "2", "percentage": 46}, {"hand": "general_manager", "account_id": 1, "percentage": "20.00"}]', 'installment', 80, 1, '2023-08-25 06:36:23', '2023-08-19 06:36:23'),
	(7, 5, '[{"hand": "shareholder", "account_id": 2, "percentage": 80}, {"hand": "general_manager", "account_id": 1, "percentage": "20.00"}]', 'installment', 80, 2, '2023-08-25 06:56:52', '2023-08-19 06:56:52'),
	(8, 5, '[{"hand": "shareholder", "account_id": 2, "percentage": 85}, {"hand": "general_manager", "account_id": 1, "percentage": "15.00"}]', 'down_payment', 85, 1, '2023-09-18 03:41:19', '2023-09-18 03:41:19'),
	(9, 1, '[{"hand": "shareholder", "account_id": 2, "percentage": 0}, {"hand": "general_manager", "account_id": 1, "percentage": "100.00"}]', 'down_payment', 0, 1, '2023-09-18 17:48:13', '2023-09-18 17:48:13'),
	(10, 2, '[{"hand": "hand_1", "account_id": "11", "percentage": 20}, {"hand": "hand_2", "account_id": "10", "percentage": 14}, {"hand": "hand_3", "account_id": "9", "percentage": 7}, {"hand": "shareholder", "account_id": "2", "percentage": 39}, {"hand": "general_manager", "account_id": 1, "percentage": "20.00"}]', 'installment', 80, 1, '2023-09-18 17:52:12', '2023-09-18 17:52:12'),
	(11, 6, '[{"hand": "hand_1", "account_id": "11", "percentage": 25}, {"hand": "hand_2", "account_id": "10", "percentage": 18}, {"hand": "hand_3", "account_id": "9", "percentage": 10}, {"hand": "shareholder", "account_id": "2", "percentage": 27}, {"hand": "general_manager", "account_id": 1, "percentage": "20.00"}]', 'installment', 80, 1, '2023-09-19 20:44:57', '2023-09-19 20:44:57'),
	(12, 6, '[{"hand": "hand_1", "account_id": "11", "percentage": 28}, {"hand": "hand_2", "account_id": "10", "percentage": 18}, {"hand": "hand_3", "account_id": "9", "percentage": 14}, {"hand": "shareholder", "account_id": "2", "percentage": 25}, {"hand": "general_manager", "account_id": 1, "percentage": "15.00"}]', 'down_payment', 85, 1, '2023-09-19 20:45:38', '2023-09-19 20:45:38'),
	(13, 6, '[{"hand": "hand_1", "account_id": "11", "percentage": 30}, {"hand": "hand_2", "account_id": "10", "percentage": 24}, {"hand": "hand_3", "account_id": "9", "percentage": 12}, {"hand": "shareholder", "account_id": "2", "percentage": 14}, {"hand": "general_manager", "account_id": 1, "percentage": "20.00"}]', 'booking_money', 80, 1, '2023-09-19 20:46:09', '2023-09-19 20:46:09'),
	(14, 6, '[{"hand": "hand_1", "account_id": "11", "percentage": 28}, {"hand": "hand_2", "account_id": "10", "percentage": 18}, {"hand": "hand_3", "account_id": "9", "percentage": 14}, {"hand": "shareholder", "account_id": "2", "percentage": 25}, {"hand": "general_manager", "account_id": 1, "percentage": "15.00"}]', 'down_payment', 85, 1, '2023-09-19 20:46:29', '2023-09-19 20:46:29'),
	(15, 6, '[{"hand": "hand_1", "account_id": "11", "percentage": 28}, {"hand": "hand_2", "account_id": "10", "percentage": 18}, {"hand": "hand_3", "account_id": "9", "percentage": 14}, {"hand": "shareholder", "account_id": "2", "percentage": 25}, {"hand": "general_manager", "account_id": 1, "percentage": "15.00"}]', 'down_payment', 85, 1, '2023-09-19 20:47:22', '2023-09-19 20:47:22');

-- Dumping structure for table realstatedb.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.permissions: ~83 rows (approximately)
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'sale-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(2, 'new-sale', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(3, 'sale-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(4, 'sale-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(5, 'accountant-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(6, 'accountant-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(7, 'accountant-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(8, 'shareholder-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(9, 'shareholder-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(10, 'shareholder-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(11, 'agent-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(12, 'agent-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(13, 'new-agent', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(14, 'agent-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(15, 'customer-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(16, 'customer-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(17, 'new-customer', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(18, 'customer-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(19, 'payment-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(20, 'new-payment', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(21, 'old-payment-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(22, 'old-payment-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(23, 'withdraw-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(24, 'new-withdraw', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(25, 'withdraw-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(26, 'report-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(27, 'report-customers', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(28, 'report-agents', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(29, 'report-sale-txotal', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(30, 'report-sale-individual', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(31, 'report-deposit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(32, 'report-withdraw', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(33, 'report-transaction', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(34, 'commission-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(35, 'commission-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(36, 'commission-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(37, 'role-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(38, 'permission-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(39, 'investor-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(40, 'new-investor', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(41, 'investor-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(42, 'investor-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(43, 'land-purchase-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(44, 'new-land-purchase', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(45, 'land-purchase-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(46, 'land-purchase-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(47, 'investment-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(48, 'new-investment', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(49, 'investment-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(50, 'investment-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(51, 'expense-type-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(52, 'new-expense-type', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(53, 'expense-type-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(54, 'expense-type-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(55, 'expense-type-delete', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(56, 'expense-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(57, 'new-expense', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(58, 'expense-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(59, 'expense-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(60, 'salary-type-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(61, 'new-salary-type', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(62, 'salary-type-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(63, 'salary-type-delete', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(64, 'salary-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(65, 'new-salary', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(66, 'salary-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(67, 'salary-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(68, 'bank-name-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(69, 'new-bank-name', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(70, 'bank-name-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(71, 'bank-name-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(72, 'bank-info-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(73, 'new-bank-info', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(74, 'bank-info-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(75, 'bank-info-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(76, 'other-deposit-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(77, 'new-other-deposit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(78, 'other-deposit-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(79, 'other-deposit-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(80, 'stuff-list', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(81, 'new-stuff', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(82, 'stuff-edit', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01'),
	(83, 'stuff-view', 'web', '2023-07-25 07:41:01', '2023-07-25 07:41:01');

-- Dumping structure for table realstatedb.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.personal_access_tokens: ~0 rows (approximately)

-- Dumping structure for table realstatedb.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.roles: ~7 rows (approximately)
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'Managing Director', 'web', '2023-07-25 07:41:00', '2023-07-25 07:41:00'),
	(2, 'Accountant', 'web', '2023-07-25 07:41:00', '2023-07-25 07:41:00'),
	(3, 'Master Agent', 'web', '2023-07-25 07:41:00', '2023-07-25 07:41:00'),
	(4, 'Agent', 'web', '2023-07-25 07:41:00', '2023-07-25 07:41:00'),
	(5, 'Customer', 'web', '2023-07-25 07:41:00', '2023-07-25 07:41:00'),
	(6, 'Investor', 'web', '2023-07-25 07:41:00', '2023-07-25 07:41:00'),
	(7, 'Stuff', 'web', '2023-07-25 07:41:00', '2023-07-25 07:41:00');

-- Dumping structure for table realstatedb.role_has_permissions
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.role_has_permissions: ~249 rows (approximately)
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1),
	(10, 1),
	(11, 1),
	(12, 1),
	(13, 1),
	(14, 1),
	(15, 1),
	(16, 1),
	(17, 1),
	(18, 1),
	(19, 1),
	(20, 1),
	(21, 1),
	(22, 1),
	(23, 1),
	(24, 1),
	(25, 1),
	(26, 1),
	(27, 1),
	(28, 1),
	(29, 1),
	(30, 1),
	(31, 1),
	(32, 1),
	(33, 1),
	(34, 1),
	(35, 1),
	(36, 1),
	(37, 1),
	(38, 1),
	(39, 1),
	(40, 1),
	(41, 1),
	(42, 1),
	(43, 1),
	(44, 1),
	(45, 1),
	(46, 1),
	(47, 1),
	(48, 1),
	(49, 1),
	(50, 1),
	(51, 1),
	(52, 1),
	(53, 1),
	(54, 1),
	(55, 1),
	(56, 1),
	(57, 1),
	(58, 1),
	(59, 1),
	(60, 1),
	(61, 1),
	(62, 1),
	(63, 1),
	(64, 1),
	(65, 1),
	(66, 1),
	(67, 1),
	(68, 1),
	(69, 1),
	(70, 1),
	(71, 1),
	(72, 1),
	(73, 1),
	(74, 1),
	(75, 1),
	(76, 1),
	(77, 1),
	(78, 1),
	(79, 1),
	(80, 1),
	(81, 1),
	(82, 1),
	(83, 1),
	(1, 2),
	(2, 2),
	(3, 2),
	(4, 2),
	(5, 2),
	(6, 2),
	(7, 2),
	(8, 2),
	(9, 2),
	(10, 2),
	(11, 2),
	(12, 2),
	(13, 2),
	(14, 2),
	(15, 2),
	(16, 2),
	(17, 2),
	(18, 2),
	(19, 2),
	(20, 2),
	(21, 2),
	(22, 2),
	(23, 2),
	(24, 2),
	(25, 2),
	(26, 2),
	(27, 2),
	(28, 2),
	(29, 2),
	(30, 2),
	(31, 2),
	(32, 2),
	(33, 2),
	(34, 2),
	(35, 2),
	(36, 2),
	(37, 2),
	(38, 2),
	(39, 2),
	(40, 2),
	(41, 2),
	(42, 2),
	(43, 2),
	(44, 2),
	(45, 2),
	(46, 2),
	(47, 2),
	(48, 2),
	(49, 2),
	(50, 2),
	(51, 2),
	(52, 2),
	(53, 2),
	(54, 2),
	(55, 2),
	(56, 2),
	(57, 2),
	(58, 2),
	(59, 2),
	(60, 2),
	(61, 2),
	(62, 2),
	(63, 2),
	(64, 2),
	(65, 2),
	(66, 2),
	(67, 2),
	(68, 2),
	(69, 2),
	(70, 2),
	(71, 2),
	(72, 2),
	(73, 2),
	(74, 2),
	(75, 2),
	(76, 2),
	(77, 2),
	(78, 2),
	(79, 2),
	(80, 2),
	(81, 2),
	(82, 2),
	(83, 2),
	(1, 3),
	(2, 3),
	(3, 3),
	(4, 3),
	(5, 3),
	(6, 3),
	(7, 3),
	(8, 3),
	(9, 3),
	(10, 3),
	(11, 3),
	(12, 3),
	(13, 3),
	(14, 3),
	(15, 3),
	(16, 3),
	(17, 3),
	(18, 3),
	(19, 3),
	(20, 3),
	(21, 3),
	(22, 3),
	(23, 3),
	(24, 3),
	(25, 3),
	(26, 3),
	(27, 3),
	(28, 3),
	(29, 3),
	(30, 3),
	(31, 3),
	(32, 3),
	(33, 3),
	(34, 3),
	(35, 3),
	(36, 3),
	(37, 3),
	(38, 3),
	(39, 3),
	(40, 3),
	(41, 3),
	(42, 3),
	(43, 3),
	(44, 3),
	(45, 3),
	(46, 3),
	(47, 3),
	(48, 3),
	(49, 3),
	(50, 3),
	(51, 3),
	(52, 3),
	(53, 3),
	(54, 3),
	(55, 3),
	(56, 3),
	(57, 3),
	(58, 3),
	(59, 3),
	(60, 3),
	(61, 3),
	(62, 3),
	(63, 3),
	(64, 3),
	(65, 3),
	(66, 3),
	(67, 3),
	(68, 3),
	(69, 3),
	(70, 3),
	(71, 3),
	(72, 3),
	(73, 3),
	(74, 3),
	(75, 3),
	(76, 3),
	(77, 3),
	(78, 3),
	(79, 3),
	(80, 3),
	(81, 3),
	(82, 3),
	(83, 3);

-- Dumping structure for table realstatedb.salaries
CREATE TABLE IF NOT EXISTS `salaries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_detail_id` bigint unsigned NOT NULL,
  `group_id` bigint unsigned DEFAULT NULL,
  `type_id` bigint unsigned DEFAULT NULL,
  `other` text COLLATE utf8mb4_unicode_ci,
  `monthly` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entry` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `salaries_user_detail_id_foreign` (`user_detail_id`),
  KEY `salaries_type_id_foreign` (`type_id`),
  KEY `salaries_entry_foreign` (`entry`),
  CONSTRAINT `salaries_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `salaries_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `salary_types` (`id`),
  CONSTRAINT `salaries_user_detail_id_foreign` FOREIGN KEY (`user_detail_id`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.salaries: ~6 rows (approximately)
INSERT INTO `salaries` (`id`, `user_detail_id`, `group_id`, `type_id`, `other`, `monthly`, `entry`, `created_at`, `updated_at`) VALUES
	(1, 7, NULL, NULL, NULL, '2023-01', 1, '2023-08-12 18:46:30', '2023-08-12 18:46:30'),
	(2, 7, 1, 1, NULL, NULL, 1, '2023-08-12 18:46:30', '2023-08-12 18:46:30'),
	(3, 7, NULL, NULL, NULL, '2023-05', 1, '2023-08-12 18:49:31', '2023-08-12 18:49:31'),
	(4, 7, 3, 2, NULL, NULL, 1, '2023-08-12 18:49:31', '2023-08-12 18:49:31'),
	(5, 7, NULL, NULL, NULL, '2023-09', 1, '2023-08-12 18:50:32', '2023-08-12 18:50:32'),
	(6, 7, 5, 1, NULL, NULL, 1, '2023-08-12 18:50:32', '2023-08-12 18:50:32');

-- Dumping structure for table realstatedb.salary_types
CREATE TABLE IF NOT EXISTS `salary_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entry` bigint unsigned NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `salary_types_title_unique` (`title`),
  KEY `salary_types_entry_foreign` (`entry`),
  CONSTRAINT `salary_types_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.salary_types: ~2 rows (approximately)
INSERT INTO `salary_types` (`id`, `title`, `entry`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'bonus', 1, 1, '2023-08-12 18:46:09', '2023-08-12 18:46:09'),
	(2, 'Tea bonus', 1, 1, '2023-08-12 18:48:22', '2023-08-12 18:48:22');

-- Dumping structure for table realstatedb.sales
CREATE TABLE IF NOT EXISTS `sales` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `agent_id` bigint unsigned DEFAULT NULL,
  `shareholder_id` bigint unsigned NOT NULL,
  `price` double NOT NULL DEFAULT '0',
  `sector` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `block` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `road` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plot` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kata` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'cash, emi',
  `commission` json NOT NULL COMMENT 'commission data will be comes from commission table data take which agent get how much commission',
  `date` date NOT NULL,
  `entry` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sales_uuid_unique` (`uuid`),
  KEY `sales_customer_id_foreign` (`customer_id`),
  KEY `sales_agent_id_foreign` (`agent_id`),
  KEY `sales_shareholder_id_foreign` (`shareholder_id`),
  KEY `sales_entry_foreign` (`entry`),
  CONSTRAINT `sales_agent_id_foreign` FOREIGN KEY (`agent_id`) REFERENCES `user_details` (`id`),
  CONSTRAINT `sales_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `sales_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`),
  CONSTRAINT `sales_shareholder_id_foreign` FOREIGN KEY (`shareholder_id`) REFERENCES `user_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.sales: ~3 rows (approximately)
INSERT INTO `sales` (`id`, `uuid`, `customer_id`, `agent_id`, `shareholder_id`, `price`, `sector`, `block`, `road`, `plot`, `kata`, `type`, `commission`, `date`, `entry`, `created_at`, `updated_at`) VALUES
	(1, 'e2a6a1ace352668000aed191a817d143', 1, NULL, 2, 536, '78', '45', '12', '35', '100', 'emi', '{"installment": [{"hand": "shareholder", "percentage": 0, "shareholder_id": 2}], "down_payment": [{"hand": "shareholder", "percentage": 0, "shareholder_id": 2}], "booking_money": [{"hand": "shareholder", "percentage": 0, "shareholder_id": 2}]}', '2023-08-09', 1, '2023-08-09 02:23:56', '2023-08-09 02:23:56'),
	(2, 'c81e728d9d4c2f636f067f89cc14862c', 2, 11, 2, 100000, 'Incidunt reprehende', 'Explicabo Non totam', 'Est neque cillum de', 'Quis molestiae facer', '96', 'cash', '{"installment": [{"hand": "hand_1", "agent_id": "11", "percentage": 20}, {"hand": "hand_2", "agent_id": "10", "percentage": 14}, {"hand": "hand_3", "agent_id": "9", "percentage": 7}, {"hand": "shareholder", "percentage": 39, "shareholder_id": "2"}], "down_payment": [{"hand": "hand_1", "agent_id": "11", "percentage": 35}, {"hand": "hand_2", "agent_id": "10", "percentage": 24}, {"hand": "hand_3", "agent_id": "9", "percentage": 15}, {"hand": "shareholder", "percentage": 11, "shareholder_id": "2"}], "booking_money": [{"hand": "hand_1", "agent_id": "11", "percentage": 24}, {"hand": "hand_2", "agent_id": "10", "percentage": 18}, {"hand": "hand_3", "agent_id": "9", "percentage": 14}, {"hand": "shareholder", "percentage": 24, "shareholder_id": "2"}]}', '2023-08-13', 1, '2023-08-12 18:39:13', '2023-08-12 18:39:13'),
	(3, 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 1, 12, 2, 600000, 'In corrupti anim ea', 'Veritatis exercitati', 'Maiores officia ipsa', 'Cum in magnam in exc', '33', 'emi', '{"installment": [{"hand": "hand_1", "agent_id": "12", "percentage": 20}, {"hand": "hand_2", "agent_id": "11", "percentage": 14}, {"hand": "hand_3", "agent_id": "10", "percentage": 7}, {"hand": "shareholder", "percentage": 39, "shareholder_id": "2"}], "down_payment": [{"hand": "hand_1", "agent_id": "12", "percentage": 35}, {"hand": "hand_2", "agent_id": "11", "percentage": 24}, {"hand": "hand_3", "agent_id": "10", "percentage": 15}, {"hand": "shareholder", "percentage": 11, "shareholder_id": "2"}], "booking_money": [{"hand": "hand_1", "agent_id": "12", "percentage": 24}, {"hand": "hand_2", "agent_id": "11", "percentage": 18}, {"hand": "hand_3", "agent_id": "10", "percentage": 14}, {"hand": "shareholder", "percentage": 24, "shareholder_id": "2"}]}', '2023-08-13', 1, '2023-08-12 18:40:20', '2023-08-12 18:40:20'),
	(4, 'a87ff679a2f3e71d9181a67b7542122c', 2, 10, 2, 135000, 'Exercitation magni v', 'Omnis perspiciatis', 'Nobis quisquam exerc', 'Accusantium temporib', '66', 'emi', '{"installment": [{"hand": "hand_1", "agent_id": "10", "percentage": 20}, {"hand": "hand_2", "agent_id": "9", "percentage": 14}, {"hand": "shareholder", "percentage": 46, "shareholder_id": "2"}], "down_payment": [{"hand": "hand_1", "agent_id": "10", "percentage": 35}, {"hand": "hand_2", "agent_id": "9", "percentage": 24}, {"hand": "shareholder", "percentage": 26, "shareholder_id": "2"}], "booking_money": [{"hand": "hand_1", "agent_id": "10", "percentage": 24}, {"hand": "hand_2", "agent_id": "9", "percentage": 18}, {"hand": "shareholder", "percentage": 38, "shareholder_id": "2"}]}', '2023-08-13', 1, '2023-08-12 18:41:55', '2023-08-12 18:41:55'),
	(5, 'e4da3b7fbbce2345d7772b0674a318d5', 2, NULL, 2, 200000, '85', '20', '23', '52', '40', 'cash', '{"installment": [{"hand": "shareholder", "percentage": 80, "shareholder_id": 2}], "down_payment": [{"hand": "shareholder", "percentage": 85, "shareholder_id": 2}], "booking_money": [{"hand": "shareholder", "percentage": 80, "shareholder_id": 2}]}', '2023-08-19', 2, '2023-08-19 06:55:55', '2023-08-19 06:57:36'),
	(6, '1679091c5a880faf6fb5e6087eb1b2dc', 7, 11, 2, 10000, '65', '23', '562', 'dewfd8', '10', 'emi', '{"installment": [{"hand": "hand_1", "agent_id": "11", "percentage": 25}, {"hand": "hand_2", "agent_id": "10", "percentage": 18}, {"hand": "hand_3", "agent_id": "9", "percentage": 10}, {"hand": "shareholder", "percentage": 27, "shareholder_id": "2"}], "down_payment": [{"hand": "hand_1", "agent_id": "11", "percentage": 28}, {"hand": "hand_2", "agent_id": "10", "percentage": 18}, {"hand": "hand_3", "agent_id": "9", "percentage": 14}, {"hand": "shareholder", "percentage": 25, "shareholder_id": "2"}], "booking_money": [{"hand": "hand_1", "agent_id": "11", "percentage": 30}, {"hand": "hand_2", "agent_id": "10", "percentage": 24}, {"hand": "hand_3", "agent_id": "9", "percentage": 12}, {"hand": "shareholder", "percentage": 14, "shareholder_id": "2"}]}', '2023-09-20', 1, '2023-09-19 20:44:00', '2023-09-19 20:44:00');

-- Dumping structure for table realstatedb.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `group_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.settings: ~0 rows (approximately)

-- Dumping structure for table realstatedb.transactions
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_details_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0' COMMENT 'withdraw = 0, cashin = 1',
  `other` text COLLATE utf8mb4_unicode_ci,
  `entry` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transactions_entry_foreign` (`entry`),
  CONSTRAINT `transactions_entry_foreign` FOREIGN KEY (`entry`) REFERENCES `user_details` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.transactions: ~78 rows (approximately)
INSERT INTO `transactions` (`id`, `user_details_id`, `model_type`, `model_id`, `amount`, `date`, `status`, `other`, `entry`, `created_at`, `updated_at`) VALUES
	(1, 2, 'App\\Models\\Investor', 2, -500, '2023-08-06', 0, NULL, 1, '2023-08-06 09:22:38', '2023-08-06 09:53:18'),
	(2, 1, 'App\\Models\\Investor', 1, -9500, '2023-08-06', 0, NULL, 1, '2023-08-06 14:05:46', '2023-08-06 14:05:46'),
	(3, 2, 'App\\Models\\Payment', 1, 260, '2023-08-19', 1, 'percentage=26.00%', 1, '2023-08-19 05:04:44', '2023-08-19 05:04:44'),
	(4, 9, 'App\\Models\\Payment', 1, 240, '2023-08-19', 1, 'percentage=24.00%', 1, '2023-08-19 05:04:44', '2023-08-19 05:04:44'),
	(5, 10, 'App\\Models\\Payment', 1, 350, '2023-08-19', 1, 'percentage=35.00%', 1, '2023-08-19 05:04:44', '2023-08-19 05:04:44'),
	(6, 1, 'App\\Models\\Payment', 1, 150, '2023-08-19', 1, 'percentage=15.00%', 1, '2023-08-19 05:04:44', '2023-08-19 05:04:44'),
	(7, 2, 'App\\Models\\Payment', 2, 3910, '2023-08-19', 1, 'percentage=46.00%', 1, '2023-08-19 05:05:31', '2023-08-19 05:05:31'),
	(8, 9, 'App\\Models\\Payment', 2, 1190, '2023-08-19', 1, 'percentage=14.00%', 1, '2023-08-19 05:05:31', '2023-08-19 05:05:31'),
	(9, 10, 'App\\Models\\Payment', 2, 1700, '2023-08-19', 1, 'percentage=20.00%', 1, '2023-08-19 05:05:31', '2023-08-19 05:05:31'),
	(10, 1, 'App\\Models\\Payment', 2, 1700, '2023-08-19', 1, 'percentage=20.00%', 1, '2023-08-19 05:05:31', '2023-08-19 05:05:31'),
	(11, 2, 'App\\Models\\Payment', 3, 3450, '2023-08-19', 1, 'percentage=46.00%', 1, '2023-08-19 05:05:59', '2023-08-19 05:05:59'),
	(12, 9, 'App\\Models\\Payment', 3, 1050, '2023-08-19', 1, 'percentage=14.00%', 1, '2023-08-19 05:05:59', '2023-08-19 05:05:59'),
	(13, 10, 'App\\Models\\Payment', 3, 1500, '2023-08-19', 1, 'percentage=20.00%', 1, '2023-08-19 05:05:59', '2023-08-19 05:05:59'),
	(14, 1, 'App\\Models\\Payment', 3, 1500, '2023-08-19', 1, 'percentage=20.00%', 1, '2023-08-19 05:05:59', '2023-08-19 05:05:59'),
	(15, 2, 'App\\Models\\Payment', 4, 495, '2023-08-17', 1, 'percentage=11.00%', 1, '2023-08-19 05:06:43', '2023-08-19 05:06:43'),
	(16, 10, 'App\\Models\\Payment', 4, 675, '2023-08-17', 1, 'percentage=15.00%', 1, '2023-08-19 05:06:43', '2023-08-19 05:06:43'),
	(17, 11, 'App\\Models\\Payment', 4, 1080, '2023-08-17', 1, 'percentage=24.00%', 1, '2023-08-19 05:06:43', '2023-08-19 05:06:43'),
	(18, 12, 'App\\Models\\Payment', 4, 1575, '2023-08-17', 1, 'percentage=35.00%', 1, '2023-08-19 05:06:43', '2023-08-19 05:06:43'),
	(19, 1, 'App\\Models\\Payment', 4, 675, '2023-08-17', 1, 'percentage=15.00%', 1, '2023-08-19 05:06:43', '2023-08-19 05:06:43'),
	(20, 2, 'App\\Models\\Payment', 5, 2160, '2023-08-18', 1, 'percentage=24.00%', 1, '2023-08-19 05:07:17', '2023-08-19 05:07:17'),
	(21, 10, 'App\\Models\\Payment', 5, 1260, '2023-08-18', 1, 'percentage=14.00%', 1, '2023-08-19 05:07:17', '2023-08-19 05:07:17'),
	(22, 11, 'App\\Models\\Payment', 5, 1620, '2023-08-18', 1, 'percentage=18.00%', 1, '2023-08-19 05:07:17', '2023-08-19 05:07:17'),
	(23, 12, 'App\\Models\\Payment', 5, 2160, '2023-08-18', 1, 'percentage=24.00%', 1, '2023-08-19 05:07:17', '2023-08-19 05:07:17'),
	(24, 1, 'App\\Models\\Payment', 5, 1800, '2023-08-18', 1, 'percentage=20.00%', 1, '2023-08-19 05:07:17', '2023-08-19 05:07:17'),
	(25, 2, 'App\\Models\\Payment', 6, 23, '2023-08-19', 1, 'percentage=46.00%', 1, '2023-08-19 06:36:23', '2023-08-19 06:36:23'),
	(26, 9, 'App\\Models\\Payment', 6, 7, '2023-08-19', 1, 'percentage=14.00%', 1, '2023-08-19 06:36:23', '2023-08-19 06:36:23'),
	(27, 10, 'App\\Models\\Payment', 6, 10, '2023-08-19', 1, 'percentage=20.00%', 1, '2023-08-19 06:36:23', '2023-08-19 06:36:23'),
	(28, 1, 'App\\Models\\Payment', 6, 10, '2023-08-19', 1, 'percentage=20.00%', 1, '2023-08-19 06:36:23', '2023-08-19 06:36:23'),
	(29, 2, 'App\\Models\\Payment', 7, 400, '2023-08-31', 1, 'percentage=80.00%', 2, '2023-08-19 06:56:52', '2023-08-19 06:56:52'),
	(30, 1, 'App\\Models\\Payment', 7, 100, '2023-08-31', 1, 'percentage=20.00%', 2, '2023-08-19 06:56:52', '2023-08-19 06:56:52'),
	(31, 2, 'App\\Withdraw', 0, -500, '2023-08-28', 0, NULL, 1, '2023-08-27 18:29:29', '2023-08-27 18:29:29'),
	(32, 2, 'App\\Withdraw', 0, -1000, '2023-08-28', 0, NULL, 1, '2023-08-27 18:53:16', '2023-08-27 18:53:16'),
	(33, 2, 'App\\Withdraw', 0, -2000, '2023-08-28', 0, NULL, 1, '2023-08-27 18:55:35', '2023-08-27 18:55:35'),
	(34, 2, 'App\\Withdraw', 0, -200, '2023-08-28', 0, NULL, 1, '2023-08-27 18:57:09', '2023-08-27 18:57:09'),
	(35, 2, 'App\\Withdraw', 0, -400, '2023-08-28', 0, NULL, 1, '2023-08-27 18:57:51', '2023-08-27 18:57:51'),
	(36, 2, 'App\\Withdraw', 0, -500, '2023-08-28', 0, NULL, 1, '2023-08-27 18:58:43', '2023-08-27 18:58:43'),
	(37, 2, 'App\\Withdraw', 0, -200, '2023-08-28', 0, NULL, 1, '2023-08-27 18:59:58', '2023-08-27 18:59:58'),
	(38, 2, 'App\\Withdraw', 0, -100, '2023-08-28', 0, NULL, 1, '2023-08-27 19:00:39', '2023-08-27 19:00:39'),
	(39, 2, 'App\\Withdraw', 0, -1000, '2023-08-28', 0, NULL, 1, '2023-08-27 19:01:46', '2023-08-27 19:01:46'),
	(40, 9, 'App\\Withdraw', 0, -1200, '2023-08-28', 0, NULL, 1, '2023-08-27 19:02:56', '2023-08-27 19:02:56'),
	(41, 10, 'App\\Withdraw', 0, -1500, '2023-08-28', 0, NULL, 1, '2023-08-27 19:04:02', '2023-08-27 19:04:02'),
	(42, 10, 'App\\Withdraw', 0, -800, '2023-08-28', 0, NULL, 1, '2023-08-27 19:04:53', '2023-08-27 19:04:53'),
	(43, 12, 'App\\Withdraw', 0, -1700, '2023-08-28', 0, NULL, 1, '2023-08-27 19:05:48', '2023-08-27 19:05:48'),
	(44, 12, 'App\\Withdraw', 0, -800, '2023-08-28', 0, NULL, 1, '2023-08-27 19:06:14', '2023-08-27 19:06:14'),
	(45, 11, 'App\\Withdraw', 0, -2000, '2023-08-28', 0, NULL, 1, '2023-08-27 19:07:29', '2023-08-27 19:07:29'),
	(46, 2, 'App\\Models\\Payment', 8, 384.2, '2023-09-18', 1, 'percentage=85.00%', 1, '2023-09-18 03:41:19', '2023-09-18 03:41:19'),
	(47, 1, 'App\\Models\\Payment', 8, 67.8, '2023-09-18', 1, 'percentage=15.00%', 1, '2023-09-18 03:41:19', '2023-09-18 03:41:19'),
	(48, 2, 'App\\Models\\Payment', 9, 0, '2023-09-18', 1, 'percentage=0.00%', 1, '2023-09-18 17:48:13', '2023-09-18 17:48:13'),
	(49, 1, 'App\\Models\\Payment', 9, 7800, '2023-09-18', 1, 'percentage=100.00%', 1, '2023-09-18 17:48:13', '2023-09-18 17:48:13'),
	(50, 2, 'App\\Models\\Payment', 10, 3315, '2023-09-18', 1, 'percentage=39.00%', 1, '2023-09-18 17:52:12', '2023-09-18 17:52:12'),
	(51, 9, 'App\\Models\\Payment', 10, 595, '2023-09-18', 1, 'percentage=7.00%', 1, '2023-09-18 17:52:12', '2023-09-18 17:52:12'),
	(52, 10, 'App\\Models\\Payment', 10, 1190, '2023-09-18', 1, 'percentage=14.00%', 1, '2023-09-18 17:52:12', '2023-09-18 17:52:12'),
	(53, 11, 'App\\Models\\Payment', 10, 1700, '2023-09-18', 1, 'percentage=20.00%', 1, '2023-09-18 17:52:13', '2023-09-18 17:52:13'),
	(54, 1, 'App\\Models\\Payment', 10, 1700, '2023-09-18', 1, 'percentage=20.00%', 1, '2023-09-18 17:52:13', '2023-09-18 17:52:13'),
	(55, 2, 'App\\Models\\Payment', 11, 270, '2023-09-20', 1, 'percentage=27.00%', 1, '2023-09-19 20:44:57', '2023-09-19 20:44:57'),
	(56, 9, 'App\\Models\\Payment', 11, 100, '2023-09-20', 1, 'percentage=10.00%', 1, '2023-09-19 20:44:57', '2023-09-19 20:44:57'),
	(57, 10, 'App\\Models\\Payment', 11, 180, '2023-09-20', 1, 'percentage=18.00%', 1, '2023-09-19 20:44:57', '2023-09-19 20:44:57'),
	(58, 11, 'App\\Models\\Payment', 11, 250, '2023-09-20', 1, 'percentage=25.00%', 1, '2023-09-19 20:44:57', '2023-09-19 20:44:57'),
	(59, 1, 'App\\Models\\Payment', 11, 200, '2023-09-20', 1, 'percentage=20.00%', 1, '2023-09-19 20:44:57', '2023-09-19 20:44:57'),
	(60, 2, 'App\\Models\\Payment', 12, 500, '2023-09-20', 1, 'percentage=25.00%', 1, '2023-09-19 20:45:38', '2023-09-19 20:45:38'),
	(61, 9, 'App\\Models\\Payment', 12, 280, '2023-09-20', 1, 'percentage=14.00%', 1, '2023-09-19 20:45:38', '2023-09-19 20:45:38'),
	(62, 10, 'App\\Models\\Payment', 12, 360, '2023-09-20', 1, 'percentage=18.00%', 1, '2023-09-19 20:45:38', '2023-09-19 20:45:38'),
	(63, 11, 'App\\Models\\Payment', 12, 560, '2023-09-20', 1, 'percentage=28.00%', 1, '2023-09-19 20:45:38', '2023-09-19 20:45:38'),
	(64, 1, 'App\\Models\\Payment', 12, 300, '2023-09-20', 1, 'percentage=15.00%', 1, '2023-09-19 20:45:38', '2023-09-19 20:45:38'),
	(65, 2, 'App\\Models\\Payment', 13, 140, '2023-09-20', 1, 'percentage=14.00%', 1, '2023-09-19 20:46:09', '2023-09-19 20:46:09'),
	(66, 9, 'App\\Models\\Payment', 13, 120, '2023-09-20', 1, 'percentage=12.00%', 1, '2023-09-19 20:46:09', '2023-09-19 20:46:09'),
	(67, 10, 'App\\Models\\Payment', 13, 240, '2023-09-20', 1, 'percentage=24.00%', 1, '2023-09-19 20:46:09', '2023-09-19 20:46:09'),
	(68, 11, 'App\\Models\\Payment', 13, 300, '2023-09-20', 1, 'percentage=30.00%', 1, '2023-09-19 20:46:09', '2023-09-19 20:46:09'),
	(69, 1, 'App\\Models\\Payment', 13, 200, '2023-09-20', 1, 'percentage=20.00%', 1, '2023-09-19 20:46:09', '2023-09-19 20:46:09'),
	(70, 2, 'App\\Models\\Payment', 14, 625, '2023-09-20', 1, 'percentage=25.00%', 1, '2023-09-19 20:46:29', '2023-09-19 20:46:29'),
	(71, 9, 'App\\Models\\Payment', 14, 350, '2023-09-20', 1, 'percentage=14.00%', 1, '2023-09-19 20:46:29', '2023-09-19 20:46:29'),
	(72, 10, 'App\\Models\\Payment', 14, 450, '2023-09-20', 1, 'percentage=18.00%', 1, '2023-09-19 20:46:29', '2023-09-19 20:46:29'),
	(73, 11, 'App\\Models\\Payment', 14, 700, '2023-09-20', 1, 'percentage=28.00%', 1, '2023-09-19 20:46:29', '2023-09-19 20:46:29'),
	(74, 1, 'App\\Models\\Payment', 14, 375, '2023-09-20', 1, 'percentage=15.00%', 1, '2023-09-19 20:46:29', '2023-09-19 20:46:29'),
	(75, 2, 'App\\Models\\Payment', 15, 1250, '2023-09-20', 1, 'percentage=25.00%', 1, '2023-09-19 20:47:22', '2023-09-19 20:47:22'),
	(76, 9, 'App\\Models\\Payment', 15, 700, '2023-09-20', 1, 'percentage=14.00%', 1, '2023-09-19 20:47:22', '2023-09-19 20:47:22'),
	(77, 10, 'App\\Models\\Payment', 15, 900, '2023-09-20', 1, 'percentage=18.00%', 1, '2023-09-19 20:47:22', '2023-09-19 20:47:22'),
	(78, 11, 'App\\Models\\Payment', 15, 1400, '2023-09-20', 1, 'percentage=28.00%', 1, '2023-09-19 20:47:22', '2023-09-19 20:47:22'),
	(79, 1, 'App\\Models\\Payment', 15, 750, '2023-09-20', 1, 'percentage=15.00%', 1, '2023-09-19 20:47:22', '2023-09-19 20:47:22');

-- Dumping structure for table realstatedb.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.users: ~8 rows (approximately)
INSERT INTO `users` (`id`, `email`, `email_verified_at`, `password`, `status`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'admin@gmail.com', '2023-07-25 07:41:00', '$2y$10$yFSZxg.O/3lmsZBpN5B/QOcft6DGE2txfE.QSojU/Ih4nYfjNYVYu', 1, NULL, '2023-07-25 07:41:00', '2023-07-25 07:41:00', NULL),
	(2, 'roken12@gmail.com', NULL, '$2y$10$yFSZxg.O/3lmsZBpN5B/QOcft6DGE2txfE.QSojU/Ih4nYfjNYVYu', 1, NULL, '2023-08-03 10:04:04', '2023-08-03 10:06:44', NULL),
	(3, 'sakib12@gmail.com', NULL, '$2y$10$yFSZxg.O/3lmsZBpN5B/QOcft6DGE2txfE.QSojU/Ih4nYfjNYVYu', 1, NULL, '2023-08-12 14:53:47', '2023-08-12 15:32:48', NULL),
	(4, 'rakib12@gmail.com', NULL, '$2y$10$yFSZxg.O/3lmsZBpN5B/QOcft6DGE2txfE.QSojU/Ih4nYfjNYVYu', 1, NULL, '2023-08-12 14:58:22', '2023-08-12 15:32:54', NULL),
	(5, 'nafiz@gmail.com', NULL, '$2y$10$yFSZxg.O/3lmsZBpN5B/QOcft6DGE2txfE.QSojU/Ih4nYfjNYVYu', 1, NULL, '2023-08-12 15:32:19', '2023-08-12 15:33:02', NULL),
	(6, 'kuddos43@gmail.com', NULL, '$2y$10$yFSZxg.O/3lmsZBpN5B/QOcft6DGE2txfE.QSojU/Ih4nYfjNYVYu', 1, NULL, '2023-08-12 16:17:15', '2023-08-12 16:24:19', NULL),
	(7, 'sokina98@gmail.com', NULL, '$2y$10$zxhAIuM9OQPa70vsOABiIuSwgSQwFuV5wNcSlkxIZBdTPBfPB9RL2', 1, NULL, '2023-08-12 16:18:21', '2023-08-12 16:24:27', NULL),
	(8, 'rohima23@gmail.com', NULL, '$2y$10$7au64fzOvhgKEcltKD3IGOpFuA7lr00L1X0IXuQ3foZtPDPNN/yDe', 1, NULL, '2023-08-12 16:26:23', '2023-08-12 16:27:02', NULL);

-- Dumping structure for table realstatedb.user_details
CREATE TABLE IF NOT EXISTS `user_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `present_address` text COLLATE utf8mb4_unicode_ci,
  `permanent_address` text COLLATE utf8mb4_unicode_ci,
  `emergency_contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refer_id` bigint unsigned DEFAULT NULL,
  `reference_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` bigint unsigned NOT NULL,
  `parent_name` json DEFAULT NULL COMMENT 'father name, and mother name',
  `status` tinyint NOT NULL DEFAULT '0',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `income` double NOT NULL DEFAULT '0' COMMENT 'only agent and shareholder',
  `total_kata` double NOT NULL DEFAULT '0' COMMENT 'only for agent and shareholder',
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_details_refer_id_foreign` (`refer_id`),
  KEY `user_details_role_foreign` (`role`),
  KEY `user_details_user_id_foreign` (`user_id`),
  CONSTRAINT `user_details_refer_id_foreign` FOREIGN KEY (`refer_id`) REFERENCES `user_details` (`id`),
  CONSTRAINT `user_details_role_foreign` FOREIGN KEY (`role`) REFERENCES `roles` (`id`),
  CONSTRAINT `user_details_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table realstatedb.user_details: ~17 rows (approximately)
INSERT INTO `user_details` (`id`, `account_id`, `name`, `phone`, `present_address`, `permanent_address`, `emergency_contact`, `occupation`, `refer_id`, `reference_id`, `role`, `parent_name`, `status`, `image`, `income`, `total_kata`, `user_id`, `created_at`, `updated_at`) VALUES
	(1, 'Gm11111111', 'General Manager', '01222222222', 'present address', 'permanent address', '01222222222', 'General Manager', NULL, NULL, 1, NULL, 1, NULL, 17317.8, 0, 1, NULL, '2023-09-19 20:47:22'),
	(2, '14895', 'md rokon', '014879556879', 'fatiya', 'vkd', 'ef', 'Not weeGiven Yet', NULL, NULL, 3, '{"father": "frr", "mother": "frfer"}', 1, '/profile/2.jpg', 11259.2, 140, 2, '2023-08-03 10:04:05', '2023-09-19 20:47:22'),
	(3, '1154', 'md sakib', '01487998532', NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, 1, NULL, 0, 0, 3, '2023-08-12 14:53:47', '2023-08-12 15:32:47'),
	(4, '4487', 'Md rakib', '01558779955', NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, 1, NULL, 0, 0, 4, '2023-08-12 14:58:23', '2023-08-12 15:32:54'),
	(5, '1254', 'md nafiz', '01887954778', NULL, NULL, NULL, NULL, NULL, NULL, 3, NULL, 1, NULL, 0, 0, 5, '2023-08-12 15:32:19', '2023-08-12 15:33:02'),
	(6, '4798', 'md kuddos', '01448792321', NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, 1, NULL, 0, 0, 6, '2023-08-12 16:17:15', '2023-08-12 16:24:19'),
	(7, '5889', 'sokina begum', '0145789732', NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, 1, NULL, 0, 0, 7, '2023-08-12 16:18:21', '2023-08-12 16:24:26'),
	(8, '7922', 'rohima khaton', '01448791474', NULL, NULL, NULL, NULL, NULL, NULL, 2, NULL, 1, NULL, 0, 0, 8, '2023-08-12 16:26:23', '2023-08-12 16:27:02'),
	(9, '1423', 'Ryan Mcbride', '018793111447', 'Qui quis assumenda a', 'Dicta iusto sint do', '+1 (989) 471-7985', 'Voluptatibus Nam har', 2, '2,', 4, '{"father": "Vernon Vargas", "mother": "Ratione non officia"}', 1, NULL, 3425, 0, NULL, '2023-08-12 18:22:49', '2023-09-19 20:47:22'),
	(10, '1234', 'Daphne Snyder', '01239877899', 'Aliqua Irure qui ve', 'Repudiandae ullam no', '+1 (446) 255-9927', 'Non at sit ad verit', 9, '9,2,', 4, '{"father": "Rudyard Chan", "mother": "Quidem excepturi fug"}', 1, NULL, 6505, 66, NULL, '2023-08-12 18:23:37', '2023-09-19 20:47:22'),
	(11, '1235', 'Adrian Marks', '0123977849', 'Enim dolorem volupta', 'Minim voluptatum est', '+1 (101) 986-1812', 'In lorem beatae enim', 10, '10,9,2,', 4, '{"father": "Francesca Zamora", "mother": "Reprehenderit sint"}', 1, NULL, 5610, 106, NULL, '2023-08-12 18:24:38', '2023-09-19 20:47:22'),
	(12, '1237', 'Caldwell Blackwell', '+1 (408) 863-5319', 'Quidem enim dolor iu', 'Est possimus paria', '+1 (444) 748-1826', 'Ut ullamco maiores a', 11, '11,10,9,2,', 4, '{"father": "Nomlanga Walsh", "mother": "Sit mollit iusto si"}', 1, NULL, 1235, 33, NULL, '2023-08-12 18:25:35', '2023-08-27 19:06:14'),
	(13, '1238', 'Phoebe Dawson', '+1 (614) 323-4701', 'Aliquid odio ea repe', 'Quod officiis soluta', '+1 (734) 823-6721', 'Omnis sequi dicta de', 12, '12,11,10,9,2,', 4, '{"father": "Lana Vinson", "mother": "Ipsum id nihil cons"}', 1, NULL, 0, 0, NULL, '2023-08-12 18:26:04', '2023-08-12 18:26:04'),
	(14, '7781', 'Jessamine Wallace', '+1 (976) 717-6284', 'Nulla aliquid quasi', 'Doloremque sunt blan', '+1 (142) 486-5602', 'Laborum id quis lab', NULL, NULL, 7, '{"father": "Montana Caldwell", "mother": "Omnis exercitation a"}', 1, NULL, 0, 0, NULL, '2023-08-12 18:31:03', '2023-08-12 18:31:03'),
	(15, '8712', 'Kai Mcdowell', '+1 (518) 798-3946', 'Voluptatem nisi et n', 'Porro dolor dolore c', '+1 (452) 139-5756', 'Vero deserunt ipsum', NULL, NULL, 7, '{"father": "Jessamine Mccray", "mother": "Voluptate maxime vol"}', 1, NULL, 0, 0, NULL, '2023-08-12 18:31:38', '2023-08-12 18:31:38'),
	(16, '7743cumque fugiat', 'Quail Johnson', '+1 (375) 363-7385', 'Dolores amet cupidi', 'Suscipit nisi dolore', '+1 (881) 749-4102', 'Nulla ut porro sit', NULL, NULL, 7, '{"father": "Scarlett Lester", "mother": "Exercitationem et am"}', 1, NULL, 0, 0, NULL, '2023-08-12 18:32:02', '2023-08-12 18:32:02'),
	(17, '774quaerat aute', 'Lacota Snow', '+1 (361) 625-8999', 'Ut nobis minim tempo', 'Eveniet ut velit v', '+1 (363) 354-7842', 'Occaecat eum necessi', NULL, NULL, 7, '{"father": "Brittany Vinson", "mother": "Rem mollitia illo si"}', 1, NULL, 0, 0, NULL, '2023-08-12 18:32:22', '2023-08-12 18:32:22'),
	(18, '7824', 'Brandon Day', '+1 (168) 872-7131', 'Ut voluptatem Digni', 'Quis alias eiusmod e', '+1 (259) 954-6194', 'Saepe tempore cillu', NULL, NULL, 7, '{"father": "Nigel Robinson", "mother": "Sit tempore aut bl"}', 1, NULL, 0, 0, NULL, '2023-08-12 18:32:55', '2023-08-12 18:32:55'),
	(19, NULL, 'Simone Beasley', '+1 (407) 878-6525', 'Eveniet ex quo earu', 'Cupidatat aspernatur', '+1 (246) 504-8349', 'Qui consectetur inc', 3, '3,', 4, '{"father": "Alika Hunt", "mother": "Laudantium dolorem"}', 1, NULL, 0, 0, NULL, '2023-08-28 16:52:49', '2023-08-28 16:52:49');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
