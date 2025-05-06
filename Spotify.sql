CREATE DATABASE `Spotify` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `Albums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `release_year` int DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `artist_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `albums_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `Artists` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Artists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `CreditCards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subscription_id` int DEFAULT NULL,
  `card_number` varbinary(255) DEFAULT NULL,
  `expiry_month` int DEFAULT NULL,
  `expiry_year` int DEFAULT NULL,
  `security_code` varbinary(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscription_id` (`subscription_id`),
  CONSTRAINT `creditcards_ibfk_1` FOREIGN KEY (`subscription_id`) REFERENCES `Subscriptions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Favorite_Albums` (
  `user_email` varchar(100) NOT NULL,
  `album_id` int NOT NULL,
  PRIMARY KEY (`user_email`,`album_id`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `favorite_albums_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `Users` (`email`),
  CONSTRAINT `favorite_albums_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `Albums` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Favorite_Songs` (
  `user_email` varchar(100) NOT NULL,
  `song_id` int NOT NULL,
  PRIMARY KEY (`user_email`,`song_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `favorite_songs_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `Users` (`email`),
  CONSTRAINT `favorite_songs_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `Songs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Followed_Artists` (
  `user_email` varchar(100) NOT NULL,
  `artist_id` int NOT NULL,
  PRIMARY KEY (`user_email`,`artist_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `followed_artists_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `Users` (`email`),
  CONSTRAINT `followed_artists_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `Artists` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subscription_id` int DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT NULL,
  `order_number` varchar(50) DEFAULT NULL,
  `total` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`),
  KEY `subscription_id` (`subscription_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`subscription_id`) REFERENCES `Subscriptions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `PayPalAccount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subscription_id` int DEFAULT NULL,
  `paypal_username` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscription_id` (`subscription_id`),
  CONSTRAINT `paypalaccount_ibfk_1` FOREIGN KEY (`subscription_id`) REFERENCES `Subscriptions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Playlists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_email` varchar(100) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `song_count` int DEFAULT '0',
  `creation_date` timestamp NULL DEFAULT NULL,
  `deletion_date` timestamp NULL DEFAULT NULL,
  `is_shared` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_email` (`user_email`),
  CONSTRAINT `playlists_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `Users` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Playlist_Songs` (
  `playlist_id` int NOT NULL,
  `song_id` int NOT NULL,
  `added_by` varchar(100) DEFAULT NULL,
  `added_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`playlist_id`,`song_id`),
  KEY `song_id` (`song_id`),
  KEY `added_by` (`added_by`),
  CONSTRAINT `playlist_songs_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `Playlists` (`id`),
  CONSTRAINT `playlist_songs_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `Songs` (`id`),
  CONSTRAINT `playlist_songs_ibfk_3` FOREIGN KEY (`added_by`) REFERENCES `Users` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Related_Artists` (
  `artist_id` int NOT NULL,
  `related_artist_id` int NOT NULL,
  PRIMARY KEY (`artist_id`,`related_artist_id`),
  KEY `related_artist_id` (`related_artist_id`),
  CONSTRAINT `related_artists_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `Artists` (`id`),
  CONSTRAINT `related_artists_ibfk_2` FOREIGN KEY (`related_artist_id`) REFERENCES `Artists` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Songs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `play_count` int DEFAULT '0',
  `album_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `songs_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `Albums` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_email` varchar(100) DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `renewal_date` timestamp NULL DEFAULT NULL,
  `payment_method` enum('card','paypal') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_email` (`user_email`),
  CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `Users` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Users` (
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `birth_date` timestamp NULL DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `user_type` enum('free','premium') DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;