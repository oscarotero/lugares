CREATE TABLE `community` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL DEFAULT '',
    `code` int(2) unsigned zerofill NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `province` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL DEFAULT '',
    `code` int(2) unsigned zerofill NOT NULL,
    `community_id` int(11) unsigned NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `code` (`code`),
    KEY `community-province` (`community_id`),
    CONSTRAINT `community-province` FOREIGN KEY (`community_id`) REFERENCES `community` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `municipality` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL DEFAULT '',
    `code` int(5) unsigned zerofill NOT NULL,
    `province_id` int(11) unsigned NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `code` (`code`),
    KEY `province-municipality` (`province_id`),
    CONSTRAINT `province-municipality` FOREIGN KEY (`province_id`) REFERENCES `province` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `place` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL DEFAULT '',
    `code` bigint(11) unsigned zerofill NOT NULL,
    `municipality_id` int(11) unsigned NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `code` (`code`),
    KEY `municipality-place` (`municipality_id`),
    CONSTRAINT `municipality-place` FOREIGN KEY (`municipality_id`) REFERENCES `municipality` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
