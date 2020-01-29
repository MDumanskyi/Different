-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DB_Shop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DB_Shop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DB_Shop` DEFAULT CHARACTER SET utf8 ;
USE `DB_Shop` ;

-- -----------------------------------------------------
-- Table `DB_Shop`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Shop`.`users` (
  `id` INT(11) NOT NULL,
  `fio` VARCHAR(255) NOT NULL,
  `login` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `type` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `fio`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Shop`.`settings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Shop`.`settings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `host` VARCHAR(45) NULL,
  `db` VARCHAR(45) NULL,
  `user` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Shop`.`product_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Shop`.`product_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Shop`.`deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Shop`.`deliveries` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `fio` INT NOT NULL,
  `address` VARCHAR(255) NULL,
  `time` VARCHAR(255) NULL,
  `data` DATE NULL,
  `confirm` TINYINT NULL,
  PRIMARY KEY (`order_id`, `fio`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Shop`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Shop`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `shop_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `fio` INT NOT NULL,
  `data` DATE NULL,
  `quantity` INT NULL,
  `tel` VARCHAR(255) NULL,
  `confirm` TINYINT NULL,
  `deliveries_order_id` INT NOT NULL,
  `deliveries_fio` INT NOT NULL,
  `deliveries_order_id1` INT NOT NULL,
  `deliveries_fio1` INT NOT NULL,
  `users_id` INT(11) NOT NULL,
  `users_fio` VARCHAR(255) NOT NULL,
  `shops_id` INT NOT NULL,
  PRIMARY KEY (`id`, `shop_id`, `product_id`, `fio`, `deliveries_order_id`, `deliveries_fio`, `deliveries_order_id1`, `deliveries_fio1`, `users_id`, `users_fio`, `shops_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_orders_deliveries1_idx` (`deliveries_order_id` ASC, `deliveries_fio` ASC) VISIBLE,
  INDEX `fk_orders_deliveries2_idx` (`deliveries_order_id1` ASC, `deliveries_fio1` ASC) VISIBLE,
  INDEX `fk_orders_users1_idx` (`users_id` ASC, `users_fio` ASC) VISIBLE,
  INDEX `fk_orders_shops1_idx` (`shops_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_deliveries1`
    FOREIGN KEY (`deliveries_order_id` , `deliveries_fio`)
    REFERENCES `DB_Shop`.`deliveries` (`order_id` , `fio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_deliveries2`
    FOREIGN KEY (`deliveries_order_id1` , `deliveries_fio1`)
    REFERENCES `DB_Shop`.`deliveries` (`order_id` , `fio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`users_id` , `users_fio`)
    REFERENCES `DB_Shop`.`users` (`id` , `fio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shops1`
    FOREIGN KEY (`shops_id`)
    REFERENCES `DB_Shop`.`shops` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Shop`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Shop`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `shop_id` INT NOT NULL,
  `type_id` INT NOT NULL,
  `brand` VARCHAR(255) NULL,
  `model` VARCHAR(255) NULL,
  `data` TINYTEXT NULL,
  `img` VARCHAR(255) NULL,
  `price` VARCHAR(45) NULL,
  `waranty` VARCHAR(45) NULL,
  `orders_id` INT NOT NULL,
  `orders_shop_id` INT NOT NULL,
  `orders_product_id` INT NOT NULL,
  `orders_fio` INT NOT NULL,
  `orders_deliveries_order_id` INT NOT NULL,
  `orders_deliveries_fio` INT NOT NULL,
  `orders_deliveries_order_id1` INT NOT NULL,
  `orders_deliveries_fio1` INT NOT NULL,
  `orders_users_id` INT(11) NOT NULL,
  `orders_users_fio` VARCHAR(255) NOT NULL,
  `orders_shops_id` INT NOT NULL,
  PRIMARY KEY (`id`, `shop_id`, `type_id`, `orders_id`, `orders_shop_id`, `orders_product_id`, `orders_fio`, `orders_deliveries_order_id`, `orders_deliveries_fio`, `orders_deliveries_order_id1`, `orders_deliveries_fio1`, `orders_users_id`, `orders_users_fio`, `orders_shops_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `product_to_type_idx` (`type_id` ASC) VISIBLE,
  INDEX `fk_products_orders1_idx` (`orders_id` ASC, `orders_shop_id` ASC, `orders_product_id` ASC, `orders_fio` ASC, `orders_deliveries_order_id` ASC, `orders_deliveries_fio` ASC, `orders_deliveries_order_id1` ASC, `orders_deliveries_fio1` ASC, `orders_users_id` ASC, `orders_users_fio` ASC, `orders_shops_id` ASC) VISIBLE,
  CONSTRAINT `product_to_type`
    FOREIGN KEY (`type_id`)
    REFERENCES `DB_Shop`.`product_type` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_products_orders1`
    FOREIGN KEY (`orders_id` , `orders_shop_id` , `orders_product_id` , `orders_fio` , `orders_deliveries_order_id` , `orders_deliveries_fio` , `orders_deliveries_order_id1` , `orders_deliveries_fio1` , `orders_users_id` , `orders_users_fio` , `orders_shops_id`)
    REFERENCES `DB_Shop`.`orders` (`id` , `shop_id` , `product_id` , `fio` , `deliveries_order_id` , `deliveries_fio` , `deliveries_order_id1` , `deliveries_fio1` , `users_id` , `users_fio` , `shops_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DB_Shop`.`shops`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DB_Shop`.`shops` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `address` VARCHAR(255) NULL,
  `tel` VARCHAR(45) NULL,
  `site` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `products_id` INT NOT NULL,
  `products_shop_id` INT NOT NULL,
  `products_type_id` INT NOT NULL,
  `products_orders_id` INT NOT NULL,
  `products_orders_shop_id` INT NOT NULL,
  `products_orders_product_id` INT NOT NULL,
  `products_orders_fio` INT NOT NULL,
  `products_orders_deliveries_order_id` INT NOT NULL,
  `products_orders_deliveries_fio` INT NOT NULL,
  `products_orders_deliveries_order_id1` INT NOT NULL,
  `products_orders_deliveries_fio1` INT NOT NULL,
  `products_orders_users_id` INT(11) NOT NULL,
  `products_orders_users_fio` VARCHAR(255) NOT NULL,
  `products_orders_shops_id` INT NOT NULL,
  PRIMARY KEY (`id`, `products_id`, `products_shop_id`, `products_type_id`, `products_orders_id`, `products_orders_shop_id`, `products_orders_product_id`, `products_orders_fio`, `products_orders_deliveries_order_id`, `products_orders_deliveries_fio`, `products_orders_deliveries_order_id1`, `products_orders_deliveries_fio1`, `products_orders_users_id`, `products_orders_users_fio`, `products_orders_shops_id`),
  INDEX `fk_shops_products1_idx` (`products_id` ASC, `products_shop_id` ASC, `products_type_id` ASC, `products_orders_id` ASC, `products_orders_shop_id` ASC, `products_orders_product_id` ASC, `products_orders_fio` ASC, `products_orders_deliveries_order_id` ASC, `products_orders_deliveries_fio` ASC, `products_orders_deliveries_order_id1` ASC, `products_orders_deliveries_fio1` ASC, `products_orders_users_id` ASC, `products_orders_users_fio` ASC, `products_orders_shops_id` ASC) VISIBLE,
  CONSTRAINT `fk_shops_products1`
    FOREIGN KEY (`products_id` , `products_shop_id` , `products_type_id` , `products_orders_id` , `products_orders_shop_id` , `products_orders_product_id` , `products_orders_fio` , `products_orders_deliveries_order_id` , `products_orders_deliveries_fio` , `products_orders_deliveries_order_id1` , `products_orders_deliveries_fio1` , `products_orders_users_id` , `products_orders_users_fio` , `products_orders_shops_id`)
    REFERENCES `DB_Shop`.`products` (`id` , `shop_id` , `type_id` , `orders_id` , `orders_shop_id` , `orders_product_id` , `orders_fio` , `orders_deliveries_order_id` , `orders_deliveries_fio` , `orders_deliveries_order_id1` , `orders_deliveries_fio1` , `orders_users_id` , `orders_users_fio` , `orders_shops_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
