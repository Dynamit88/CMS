-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Май 07 2019 г., 22:33
-- Версия сервера: 5.6.41
-- Версия PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `database`
--

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) NOT NULL,
  `catName` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `catName`) VALUES
(1, 'Fruits'),
(2, 'News'),
(3, 'Posts'),
(4, 'Ice cream');

-- --------------------------------------------------------

--
-- Структура таблицы `docs`
--

CREATE TABLE `docs` (
  `id` int(11) NOT NULL,
  `name` tinytext NOT NULL,
  `title` tinytext NOT NULL,
  `format` tinytext NOT NULL,
  `size` int(11) NOT NULL,
  `type` tinytext NOT NULL,
  `src` tinytext NOT NULL,
  `dateCreated` date NOT NULL,
  `timeCreated` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `docs`
--

INSERT INTO `docs` (`id`, `name`, `title`, `format`, `size`, `type`, `src`, `dateCreated`, `timeCreated`) VALUES
(2, '2008.wcms_security.final.pdf', '2008.wcms_security.final', 'pdf', 456984, 'docs', 'medias/docs/2008.wcms_security.final.pdf', '2018-12-27', '23:32:52'),
(3, 'jQuery.js', 'jQuery', 'js', 86927, 'docs', 'medias/docs/jQuery.js', '2019-02-19', '21:45:37'),
(4, 'How_to_make_a_div_take_the_remaining_height___WhiteByte.pdf', 'How_to_make', 'pdf', 107306, 'docs', 'medias/docs/How_to_make_a_div_take_the_remaining_height___WhiteByte.pdf', '2019-02-20', '20:32:52'),
(5, 'CMS_3.docx', 'CMS_3', 'docx', 15071, 'docs', 'medias/docs/CMS_3.docx', '2019-02-20', '20:34:31'),
(6, 'Questionaire.docx', 'Questionaire', 'docx', 15213, 'docs', 'medias/docs/Questionaire.docx', '2019-02-20', '20:40:34'),
(7, 'Новый_текстовый_документ.txt', 'Новый_текстовый_документ', 'txt', 1827, 'docs', 'medias/docs/Новый_текстовый_документ.txt', '2019-02-20', '21:11:10'),
(8, 'frvu_2014_9_41.pdf', 'frvu_2014_9_41', 'pdf', 70951, 'docs', 'medias/docs/frvu_2014_9_41.pdf', '2019-05-07', '19:33:40');

-- --------------------------------------------------------

--
-- Структура таблицы `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `name` tinytext NOT NULL,
  `title` tinytext NOT NULL,
  `format` tinytext NOT NULL,
  `size` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `type` tinytext NOT NULL,
  `alt` tinytext NOT NULL,
  `src` tinytext NOT NULL,
  `thumb` tinytext NOT NULL,
  `medium` tinytext NOT NULL,
  `large` tinytext NOT NULL,
  `description` text NOT NULL,
  `dateCreated` date NOT NULL,
  `timeCreated` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `images`
--

INSERT INTO `images` (`id`, `name`, `title`, `format`, `size`, `width`, `height`, `type`, `alt`, `src`, `thumb`, `medium`, `large`, `description`, `dateCreated`, `timeCreated`) VALUES
(1049, 'xtxcn.jpg', 'horror', 'jpg', 5250, 500, 275, 'images', '', 'medias/images/xtxcn.jpg', 'medias/images/thumb/xtxcn(thumb).jpg', 'medias/images/medium/xtxcn(medium).jpg', 'medias/images/large/xtxcn(large).jpg', '', '2019-05-07', '19:30:46'),
(1051, 'krany-stroika-doma-oae-dubai.jpg', 'krany-stroika-doma-oae-dubai', 'jpg', 528404, 1920, 1080, 'images', '', 'medias/images/krany-stroika-doma-oae-dubai.jpg', 'medias/images/thumb/krany-stroika-doma-oae-dubai(thumb).jpg', 'medias/images/medium/krany-stroika-doma-oae-dubai(medium).jpg', 'medias/images/large/krany-stroika-doma-oae-dubai(large).jpg', '', '2019-05-07', '19:33:41'),
(1052, 'poverhnost_tekstura_pyatna_fon_50906_1920x1080.jpg', 'poverhnost_tekstura_pyatna_fon_50906_1920x1080', 'jpg', 953450, 1920, 1080, 'images', '', 'medias/images/poverhnost_tekstura_pyatna_fon_50906_1920x1080.jpg', 'medias/images/thumb/poverhnost_tekstura_pyatna_fon_50906_1920x1080(thumb).jpg', 'medias/images/medium/poverhnost_tekstura_pyatna_fon_50906_1920x1080(medium).jpg', 'medias/images/large/poverhnost_tekstura_pyatna_fon_50906_1920x1080(large).jpg', '', '2019-05-07', '22:03:09'),
(1053, 'rammstein_gruppa_rokery_ulybka_lysyy_7810_1920x1080.jpg', 'rammstein_gruppa_rokery_ulybka_lysyy_7810_1920x1080', 'jpg', 500676, 1920, 1080, 'images', '', 'medias/images/rammstein_gruppa_rokery_ulybka_lysyy_7810_1920x1080.jpg', 'medias/images/thumb/rammstein_gruppa_rokery_ulybka_lysyy_7810_1920x1080(thumb).jpg', 'medias/images/medium/rammstein_gruppa_rokery_ulybka_lysyy_7810_1920x1080(medium).jpg', 'medias/images/large/rammstein_gruppa_rokery_ulybka_lysyy_7810_1920x1080(large).jpg', '', '2019-05-07', '22:03:09'),
(1054, 'shema_dorozhki_chipy_chrnyy_kontakt_26298_1920x1080.jpg', 'shema_dorozhki_chipy_chrnyy_kontakt_26298_1920x1080', 'jpg', 843943, 1920, 1080, 'images', '', 'medias/images/shema_dorozhki_chipy_chrnyy_kontakt_26298_1920x1080.jpg', 'medias/images/thumb/shema_dorozhki_chipy_chrnyy_kontakt_26298_1920x1080(thumb).jpg', 'medias/images/medium/shema_dorozhki_chipy_chrnyy_kontakt_26298_1920x1080(medium).jpg', 'medias/images/large/shema_dorozhki_chipy_chrnyy_kontakt_26298_1920x1080(large).jpg', '', '2019-05-07', '22:03:09'),
(1055, 'shema_nvidia_nvidia_tegra_tegra_kompyuter_29688_1920x1080.jpg', 'shema_nvidia_nvidia_tegra_tegra_kompyuter_29688_1920x1080', 'jpg', 652840, 1920, 1080, 'images', '', 'medias/images/shema_nvidia_nvidia_tegra_tegra_kompyuter_29688_1920x1080.jpg', 'medias/images/thumb/shema_nvidia_nvidia_tegra_tegra_kompyuter_29688_1920x1080(thumb).jpg', 'medias/images/medium/shema_nvidia_nvidia_tegra_tegra_kompyuter_29688_1920x1080(medium).jpg', 'medias/images/large/shema_nvidia_nvidia_tegra_tegra_kompyuter_29688_1920x1080(large).jpg', '', '2019-05-07', '22:03:10'),
(1056, 'siluet_gorod_ulitsa_123496_1920x1080.jpg', 'siluet_gorod_ulitsa_123496_1920x1080', 'jpg', 1500017, 1920, 1080, 'images', '', 'medias/images/siluet_gorod_ulitsa_123496_1920x1080.jpg', 'medias/images/thumb/siluet_gorod_ulitsa_123496_1920x1080(thumb).jpg', 'medias/images/medium/siluet_gorod_ulitsa_123496_1920x1080(medium).jpg', 'medias/images/large/siluet_gorod_ulitsa_123496_1920x1080(large).jpg', '', '2019-05-07', '22:03:10'),
(1057, 'siluet_luna_lodka_135277_1920x1080.jpg', 'siluet_luna_lodka_135277_1920x1080', 'jpg', 449419, 1920, 1080, 'images', '', 'medias/images/siluet_luna_lodka_135277_1920x1080.jpg', 'medias/images/thumb/siluet_luna_lodka_135277_1920x1080(thumb).jpg', 'medias/images/medium/siluet_luna_lodka_135277_1920x1080(medium).jpg', 'medias/images/large/siluet_luna_lodka_135277_1920x1080(large).jpg', '', '2019-05-07', '22:03:11'),
(1058, 'trassa_66_neon_tsifry_126694_1920x1080.jpg', 'trassa_66_neon_tsifry_126694_1920x1080', 'jpg', 453537, 1920, 1080, 'images', '', 'medias/images/trassa_66_neon_tsifry_126694_1920x1080.jpg', 'medias/images/thumb/trassa_66_neon_tsifry_126694_1920x1080(thumb).jpg', 'medias/images/medium/trassa_66_neon_tsifry_126694_1920x1080(medium).jpg', 'medias/images/large/trassa_66_neon_tsifry_126694_1920x1080(large).jpg', '', '2019-05-07', '22:03:11'),
(1059, 'vecher_vorota_solnce_derevo_listya_zemlya_pustota_60174_1920x1080.jpg', 'vecher_vorota_solnce_derevo_listya_zemlya_pustota_60174_1920x1080', 'jpg', 1359233, 1920, 1080, 'images', '', 'medias/images/vecher_vorota_solnce_derevo_listya_zemlya_pustota_60174_1920x1080.jpg', 'medias/images/thumb/vecher_vorota_solnce_derevo_listya_zemlya_pustota_60174_1920x1080(thumb).jpg', 'medias/images/medium/vecher_vorota_solnce_derevo_listya_zemlya_pustota_60174_1920x1080(medium).jpg', 'medias/images/large/vecher_vorota_solnce_derevo_listya_zemlya_pustota_60174_1920x1080(large).jpg', '', '2019-05-07', '22:03:12'),
(1060, 'videokarta_nvidia_geforce_gtx_980_97913_1920x1080.jpg', 'videokarta_nvidia_geforce_gtx_980_97913_1920x1080', 'jpg', 574623, 1920, 1080, 'images', '', 'medias/images/videokarta_nvidia_geforce_gtx_980_97913_1920x1080.jpg', 'medias/images/thumb/videokarta_nvidia_geforce_gtx_980_97913_1920x1080(thumb).jpg', 'medias/images/medium/videokarta_nvidia_geforce_gtx_980_97913_1920x1080(medium).jpg', 'medias/images/large/videokarta_nvidia_geforce_gtx_980_97913_1920x1080(large).jpg', '', '2019-05-07', '22:03:12'),
(1061, 'world_of_tanks_tank_les_vojna_t_34_85_95976_1920x1080.jpg', 'world_of_tanks_tank_les_vojna_t_34_85_95976_1920x1080', 'jpg', 1319855, 1920, 1080, 'images', '', 'medias/images/world_of_tanks_tank_les_vojna_t_34_85_95976_1920x1080.jpg', 'medias/images/thumb/world_of_tanks_tank_les_vojna_t_34_85_95976_1920x1080(thumb).jpg', 'medias/images/medium/world_of_tanks_tank_les_vojna_t_34_85_95976_1920x1080(medium).jpg', 'medias/images/large/world_of_tanks_tank_les_vojna_t_34_85_95976_1920x1080(large).jpg', '', '2019-05-07', '22:03:12'),
(1062, 'xbox_xbox_one_pristavka_gejmpad_dzhojstik_97639_1920x1080.jpg', 'xbox_xbox_one_pristavka_gejmpad_dzhojstik_97639_1920x1080', 'jpg', 898269, 1920, 1080, 'images', '', 'medias/images/xbox_xbox_one_pristavka_gejmpad_dzhojstik_97639_1920x1080.jpg', 'medias/images/thumb/xbox_xbox_one_pristavka_gejmpad_dzhojstik_97639_1920x1080(thumb).jpg', 'medias/images/medium/xbox_xbox_one_pristavka_gejmpad_dzhojstik_97639_1920x1080(medium).jpg', 'medias/images/large/xbox_xbox_one_pristavka_gejmpad_dzhojstik_97639_1920x1080(large).jpg', '', '2019-05-07', '22:03:13'),
(1063, 'yurij_alekseevich_gagarin_pervyj_kosmonavt_sssr_80_let_93412_1920x1080.jpg', 'yurij_alekseevich_gagarin_pervyj_kosmonavt_sssr_80_let_93412_1920x1080', 'jpg', 774708, 1920, 1080, 'images', '', 'medias/images/yurij_alekseevich_gagarin_pervyj_kosmonavt_sssr_80_let_93412_1920x1080.jpg', 'medias/images/thumb/yurij_alekseevich_gagarin_pervyj_kosmonavt_sssr_80_let_93412_1920x1080(thumb).jpg', 'medias/images/medium/yurij_alekseevich_gagarin_pervyj_kosmonavt_sssr_80_let_93412_1920x1080(medium).jpg', 'medias/images/large/yurij_alekseevich_gagarin_pervyj_kosmonavt_sssr_80_let_93412_1920x1080(large).jpg', '', '2019-05-07', '22:03:13'),
(1064, 'zvezdnoe_nebo_noch_derevya_nochnoj_pejzazh_118760_1920x1080.jpg', 'zvezdnoe_nebo_noch_derevya_nochnoj_pejzazh_118760_1920x1080', 'jpg', 1028385, 1920, 1080, 'images', '', 'medias/images/zvezdnoe_nebo_noch_derevya_nochnoj_pejzazh_118760_1920x1080.jpg', 'medias/images/thumb/zvezdnoe_nebo_noch_derevya_nochnoj_pejzazh_118760_1920x1080(thumb).jpg', 'medias/images/medium/zvezdnoe_nebo_noch_derevya_nochnoj_pejzazh_118760_1920x1080(medium).jpg', 'medias/images/large/zvezdnoe_nebo_noch_derevya_nochnoj_pejzazh_118760_1920x1080(large).jpg', '', '2019-05-07', '22:03:14'),
(1065, 'bmw_325i_e30_belyj_avto_93276_1920x1080.jpg', 'bmw_325i_e30_belyj_avto_93276_1920x1080', 'jpg', 987379, 1920, 1080, 'images', '', 'medias/images/bmw_325i_e30_belyj_avto_93276_1920x1080.jpg', 'medias/images/thumb/bmw_325i_e30_belyj_avto_93276_1920x1080(thumb).jpg', 'medias/images/medium/bmw_325i_e30_belyj_avto_93276_1920x1080(medium).jpg', 'medias/images/large/bmw_325i_e30_belyj_avto_93276_1920x1080(large).jpg', '', '2019-05-07', '22:03:14'),
(1066, 'bmw_e34_krasnyj_avto_vid_sboku_sportkar_96487_1920x1080.jpg', 'bmw_e34_krasnyj_avto_vid_sboku_sportkar_96487_1920x1080', 'jpg', 579427, 1920, 1080, 'images', '', 'medias/images/bmw_e34_krasnyj_avto_vid_sboku_sportkar_96487_1920x1080.jpg', 'medias/images/thumb/bmw_e34_krasnyj_avto_vid_sboku_sportkar_96487_1920x1080(thumb).jpg', 'medias/images/medium/bmw_e34_krasnyj_avto_vid_sboku_sportkar_96487_1920x1080(medium).jpg', 'medias/images/large/bmw_e34_krasnyj_avto_vid_sboku_sportkar_96487_1920x1080(large).jpg', '', '2019-05-07', '22:03:15'),
(1067, 'bugatti_chiron_skorost_vid_sboku_113074_1920x1080.jpg', 'bugatti_chiron_skorost_vid_sboku_113074_1920x1080', 'jpg', 645269, 1920, 1080, 'images', '', 'medias/images/bugatti_chiron_skorost_vid_sboku_113074_1920x1080.jpg', 'medias/images/thumb/bugatti_chiron_skorost_vid_sboku_113074_1920x1080(thumb).jpg', 'medias/images/medium/bugatti_chiron_skorost_vid_sboku_113074_1920x1080(medium).jpg', 'medias/images/large/bugatti_chiron_skorost_vid_sboku_113074_1920x1080(large).jpg', '', '2019-05-07', '22:03:15'),
(1068, 'chernyj_kot_morda_vzglyad_106808_1920x1080.jpg', 'chernyj_kot_morda_vzglyad_106808_1920x1080', 'jpg', 587062, 1920, 1080, 'images', '', 'medias/images/chernyj_kot_morda_vzglyad_106808_1920x1080.jpg', 'medias/images/thumb/chernyj_kot_morda_vzglyad_106808_1920x1080(thumb).jpg', 'medias/images/medium/chernyj_kot_morda_vzglyad_106808_1920x1080(medium).jpg', 'medias/images/large/chernyj_kot_morda_vzglyad_106808_1920x1080(large).jpg', '', '2019-05-07', '22:03:17'),
(1069, 'doroga_derevya_ten_119606_1920x1080.jpg', 'doroga_derevya_ten_119606_1920x1080', 'jpg', 1423948, 1920, 1080, 'images', '', 'medias/images/doroga_derevya_ten_119606_1920x1080.jpg', 'medias/images/thumb/doroga_derevya_ten_119606_1920x1080(thumb).jpg', 'medias/images/medium/doroga_derevya_ten_119606_1920x1080(medium).jpg', 'medias/images/large/doroga_derevya_ten_119606_1920x1080(large).jpg', '', '2019-05-07', '22:03:18'),
(1070, 'doroga_zakat_razmetki_trava_102104_1920x1080.jpg', 'doroga_zakat_razmetki_trava_102104_1920x1080', 'jpg', 854092, 1920, 1080, 'images', '', 'medias/images/doroga_zakat_razmetki_trava_102104_1920x1080.jpg', 'medias/images/thumb/doroga_zakat_razmetki_trava_102104_1920x1080(thumb).jpg', 'medias/images/medium/doroga_zakat_razmetki_trava_102104_1920x1080(medium).jpg', 'medias/images/large/doroga_zakat_razmetki_trava_102104_1920x1080(large).jpg', '', '2019-05-07', '22:03:19'),
(1071, 'dzhojstik_kontroller_gejmpad_126483_1920x1080.jpg', 'dzhojstik_kontroller_gejmpad_126483_1920x1080', 'jpg', 676735, 1920, 1080, 'images', '', 'medias/images/dzhojstik_kontroller_gejmpad_126483_1920x1080.jpg', 'medias/images/thumb/dzhojstik_kontroller_gejmpad_126483_1920x1080(thumb).jpg', 'medias/images/medium/dzhojstik_kontroller_gejmpad_126483_1920x1080(medium).jpg', 'medias/images/large/dzhojstik_kontroller_gejmpad_126483_1920x1080(large).jpg', '', '2019-05-07', '22:03:19'),
(1072, 'flag_sssr_rossiya_serp_molot_63332_1920x1080.jpg', 'flag_sssr_rossiya_serp_molot_63332_1920x1080', 'jpg', 467670, 1920, 1080, 'images', '', 'medias/images/flag_sssr_rossiya_serp_molot_63332_1920x1080.jpg', 'medias/images/thumb/flag_sssr_rossiya_serp_molot_63332_1920x1080(thumb).jpg', 'medias/images/medium/flag_sssr_rossiya_serp_molot_63332_1920x1080(medium).jpg', 'medias/images/large/flag_sssr_rossiya_serp_molot_63332_1920x1080(large).jpg', '', '2019-05-07', '22:03:20'),
(1073, 'gejmpad_xbox_konsol_dzhojstik_113510_1920x1080.jpg', 'gejmpad_xbox_konsol_dzhojstik_113510_1920x1080', 'jpg', 719446, 1920, 1080, 'images', '', 'medias/images/gejmpad_xbox_konsol_dzhojstik_113510_1920x1080.jpg', 'medias/images/thumb/gejmpad_xbox_konsol_dzhojstik_113510_1920x1080(thumb).jpg', 'medias/images/medium/gejmpad_xbox_konsol_dzhojstik_113510_1920x1080(medium).jpg', 'medias/images/large/gejmpad_xbox_konsol_dzhojstik_113510_1920x1080(large).jpg', '', '2019-05-07', '22:03:21'),
(1074, 'gory_leto_ozero_derevya_les_95632_1920x1080.jpg', 'gory_leto_ozero_derevya_les_95632_1920x1080', 'jpg', 1162156, 1920, 1080, 'images', '', 'medias/images/gory_leto_ozero_derevya_les_95632_1920x1080.jpg', 'medias/images/thumb/gory_leto_ozero_derevya_les_95632_1920x1080(thumb).jpg', 'medias/images/medium/gory_leto_ozero_derevya_les_95632_1920x1080(medium).jpg', 'medias/images/large/gory_leto_ozero_derevya_les_95632_1920x1080(large).jpg', '', '2019-05-07', '22:03:22'),
(1075, 'gory_ozero_vershiny_vid_sverkhu_119133_1920x1080.jpg', 'gory_ozero_vershiny_vid_sverkhu_119133_1920x1080', 'jpg', 996263, 1920, 1080, 'images', '', 'medias/images/gory_ozero_vershiny_vid_sverkhu_119133_1920x1080.jpg', 'medias/images/thumb/gory_ozero_vershiny_vid_sverkhu_119133_1920x1080(thumb).jpg', 'medias/images/medium/gory_ozero_vershiny_vid_sverkhu_119133_1920x1080(medium).jpg', 'medias/images/large/gory_ozero_vershiny_vid_sverkhu_119133_1920x1080(large).jpg', '', '2019-05-07', '22:03:22'),
(1076, 'korabl_more_zakat_luna_63381_1920x1080.jpg', 'korabl_more_zakat_luna_63381_1920x1080', 'jpg', 425567, 1920, 1080, 'images', '', 'medias/images/korabl_more_zakat_luna_63381_1920x1080.jpg', 'medias/images/thumb/korabl_more_zakat_luna_63381_1920x1080(thumb).jpg', 'medias/images/medium/korabl_more_zakat_luna_63381_1920x1080(medium).jpg', 'medias/images/large/korabl_more_zakat_luna_63381_1920x1080(large).jpg', '', '2019-05-07', '22:03:23'),
(1077, 'leopard_morda_vzglyad_hischnik_92043_1920x1080.jpg', 'leopard_morda_vzglyad_hischnik_92043_1920x1080', 'jpg', 813863, 1920, 1080, 'images', '', 'medias/images/leopard_morda_vzglyad_hischnik_92043_1920x1080.jpg', 'medias/images/thumb/leopard_morda_vzglyad_hischnik_92043_1920x1080(thumb).jpg', 'medias/images/medium/leopard_morda_vzglyad_hischnik_92043_1920x1080(medium).jpg', 'medias/images/large/leopard_morda_vzglyad_hischnik_92043_1920x1080(large).jpg', '', '2019-05-07', '22:03:23'),
(1078, 'leto_priroda_doroga_listya_derevya_90616_1920x1080.jpg', 'leto_priroda_doroga_listya_derevya_90616_1920x1080', 'jpg', 900479, 1920, 1080, 'images', '', 'medias/images/leto_priroda_doroga_listya_derevya_90616_1920x1080.jpg', 'medias/images/thumb/leto_priroda_doroga_listya_derevya_90616_1920x1080(thumb).jpg', 'medias/images/medium/leto_priroda_doroga_listya_derevya_90616_1920x1080(medium).jpg', 'medias/images/large/leto_priroda_doroga_listya_derevya_90616_1920x1080(large).jpg', '', '2019-05-07', '22:03:24'),
(1079, 'macbook_pro_apple_noutbuk_naushniki_stol_98893_1920x1080.jpg', 'macbook_pro_apple_noutbuk_naushniki_stol_98893_1920x1080', 'jpg', 462744, 1920, 1080, 'images', '', 'medias/images/macbook_pro_apple_noutbuk_naushniki_stol_98893_1920x1080.jpg', 'medias/images/thumb/macbook_pro_apple_noutbuk_naushniki_stol_98893_1920x1080(thumb).jpg', 'medias/images/medium/macbook_pro_apple_noutbuk_naushniki_stol_98893_1920x1080(medium).jpg', 'medias/images/large/macbook_pro_apple_noutbuk_naushniki_stol_98893_1920x1080(large).jpg', '', '2019-05-07', '22:03:24'),
(1080, 'meduzy_svechenie_liuminestsentsiia_140073_1920x1080.jpg', 'meduzy_svechenie_liuminestsentsiia_140073_1920x1080', 'jpg', 698982, 1920, 1080, 'images', '', 'medias/images/meduzy_svechenie_liuminestsentsiia_140073_1920x1080.jpg', 'medias/images/thumb/meduzy_svechenie_liuminestsentsiia_140073_1920x1080(thumb).jpg', 'medias/images/medium/meduzy_svechenie_liuminestsentsiia_140073_1920x1080(medium).jpg', 'medias/images/large/meduzy_svechenie_liuminestsentsiia_140073_1920x1080(large).jpg', '', '2019-05-07', '22:03:25'),
(1081, 'mercedes_benz_e_200_mercedes_avtomobil_140070_1920x1080.jpg', 'mercedes_benz_e_200_mercedes_avtomobil_140070_1920x1080', 'jpg', 518984, 1920, 1080, 'images', '', 'medias/images/mercedes_benz_e_200_mercedes_avtomobil_140070_1920x1080.jpg', 'medias/images/thumb/mercedes_benz_e_200_mercedes_avtomobil_140070_1920x1080(thumb).jpg', 'medias/images/medium/mercedes_benz_e_200_mercedes_avtomobil_140070_1920x1080(medium).jpg', 'medias/images/large/mercedes_benz_e_200_mercedes_avtomobil_140070_1920x1080(large).jpg', '', '2019-05-07', '22:03:25'),
(1082, 'more_bereg_skaly_podvodnyy_mir_rastitelnost_ryba_53966_1920x1080.jpg', 'more_bereg_skaly_podvodnyy_mir_rastitelnost_ryba_53966_1920x1080', 'jpg', 771089, 1920, 1080, 'images', '', 'medias/images/more_bereg_skaly_podvodnyy_mir_rastitelnost_ryba_53966_1920x1080.jpg', 'medias/images/thumb/more_bereg_skaly_podvodnyy_mir_rastitelnost_ryba_53966_1920x1080(thumb).jpg', 'medias/images/medium/more_bereg_skaly_podvodnyy_mir_rastitelnost_ryba_53966_1920x1080(medium).jpg', 'medias/images/large/more_bereg_skaly_podvodnyy_mir_rastitelnost_ryba_53966_1920x1080(large).jpg', '', '2019-05-07', '22:03:26'),
(1083, 'neon_nadpis_stena_134368_1920x1080.jpg', 'neon_nadpis_stena_134368_1920x1080', 'jpg', 599938, 1920, 1080, 'images', '', 'medias/images/neon_nadpis_stena_134368_1920x1080.jpg', 'medias/images/thumb/neon_nadpis_stena_134368_1920x1080(thumb).jpg', 'medias/images/medium/neon_nadpis_stena_134368_1920x1080(medium).jpg', 'medias/images/large/neon_nadpis_stena_134368_1920x1080(large).jpg', '', '2019-05-07', '22:03:26'),
(1084, 'neon_podsvetka_nadpis_121706_1920x1080.jpg', 'neon_podsvetka_nadpis_121706_1920x1080', 'jpg', 313461, 1920, 1080, 'images', '', 'medias/images/neon_podsvetka_nadpis_121706_1920x1080.jpg', 'medias/images/thumb/neon_podsvetka_nadpis_121706_1920x1080(thumb).jpg', 'medias/images/medium/neon_podsvetka_nadpis_121706_1920x1080(medium).jpg', 'medias/images/large/neon_podsvetka_nadpis_121706_1920x1080(large).jpg', '', '2019-05-07', '22:03:26'),
(1085, 'pioneer_ustanovka_temnyy_dj_muzyka_66750_1920x1080.jpg', 'pioneer_ustanovka_temnyy_dj_muzyka_66750_1920x1080', 'jpg', 487250, 1920, 1080, 'images', '', 'medias/images/pioneer_ustanovka_temnyy_dj_muzyka_66750_1920x1080.jpg', 'medias/images/thumb/pioneer_ustanovka_temnyy_dj_muzyka_66750_1920x1080(thumb).jpg', 'medias/images/medium/pioneer_ustanovka_temnyy_dj_muzyka_66750_1920x1080(medium).jpg', 'medias/images/large/pioneer_ustanovka_temnyy_dj_muzyka_66750_1920x1080(large).jpg', '', '2019-05-07', '22:03:27'),
(1086, 'pirs_prichal_more_sumerki_bereg_118549_1920x1080.jpg', 'pirs_prichal_more_sumerki_bereg_118549_1920x1080', 'jpg', 1100011, 1920, 1080, 'images', '', 'medias/images/pirs_prichal_more_sumerki_bereg_118549_1920x1080.jpg', 'medias/images/thumb/pirs_prichal_more_sumerki_bereg_118549_1920x1080(thumb).jpg', 'medias/images/medium/pirs_prichal_more_sumerki_bereg_118549_1920x1080(medium).jpg', 'medias/images/large/pirs_prichal_more_sumerki_bereg_118549_1920x1080(large).jpg', '', '2019-05-07', '22:03:27'),
(1087, 'planeta_galaktika_vselennaia_121293_1920x1080.jpg', 'planeta_galaktika_vselennaia_121293_1920x1080', 'jpg', 1081744, 1920, 1080, 'images', '', 'medias/images/planeta_galaktika_vselennaia_121293_1920x1080.jpg', 'medias/images/thumb/planeta_galaktika_vselennaia_121293_1920x1080(thumb).jpg', 'medias/images/medium/planeta_galaktika_vselennaia_121293_1920x1080(medium).jpg', 'medias/images/large/planeta_galaktika_vselennaia_121293_1920x1080(large).jpg', '', '2019-05-07', '22:03:28'),
(1088, 'planeta_kratery_kosmos_svet_61032_1920x1080.jpg', 'planeta_kratery_kosmos_svet_61032_1920x1080', 'jpg', 641785, 1920, 1080, 'images', '', 'medias/images/planeta_kratery_kosmos_svet_61032_1920x1080.jpg', 'medias/images/thumb/planeta_kratery_kosmos_svet_61032_1920x1080(thumb).jpg', 'medias/images/medium/planeta_kratery_kosmos_svet_61032_1920x1080(medium).jpg', 'medias/images/large/planeta_kratery_kosmos_svet_61032_1920x1080(large).jpg', '', '2019-05-07', '22:03:28'),
(1089, 'plyazh_tropiki_more_pesok_palmy_zakat_84729_1920x1080.jpg', 'plyazh_tropiki_more_pesok_palmy_zakat_84729_1920x1080', 'jpg', 794699, 1920, 1080, 'images', '', 'medias/images/plyazh_tropiki_more_pesok_palmy_zakat_84729_1920x1080.jpg', 'medias/images/thumb/plyazh_tropiki_more_pesok_palmy_zakat_84729_1920x1080(thumb).jpg', 'medias/images/medium/plyazh_tropiki_more_pesok_palmy_zakat_84729_1920x1080(medium).jpg', 'medias/images/large/plyazh_tropiki_more_pesok_palmy_zakat_84729_1920x1080(large).jpg', '', '2019-05-07', '22:03:28'),
(1090, 'korabli_more_svet_dozhd_69192_1920x1080.jpg', 'korabli_more_svet_dozhd_69192_1920x1080', 'jpg', 744345, 1920, 1080, 'images', '', 'medias/images/korabli_more_svet_dozhd_69192_1920x1080.jpg', 'medias/images/thumb/korabli_more_svet_dozhd_69192_1920x1080(thumb).jpg', 'medias/images/medium/korabli_more_svet_dozhd_69192_1920x1080(medium).jpg', 'medias/images/large/korabli_more_svet_dozhd_69192_1920x1080(large).jpg', '', '2019-05-07', '22:09:40'),
(1091, 'litso_maska_shramy_137994_1920x1080.jpg', 'litso_maska_shramy_137994_1920x1080', 'jpg', 435796, 1920, 1080, 'images', '', 'medias/images/litso_maska_shramy_137994_1920x1080.jpg', 'medias/images/thumb/litso_maska_shramy_137994_1920x1080(thumb).jpg', 'medias/images/medium/litso_maska_shramy_137994_1920x1080(medium).jpg', 'medias/images/large/litso_maska_shramy_137994_1920x1080(large).jpg', '', '2019-05-07', '22:09:41'),
(1092, 'mi_24_35_vertolety_polet_nebo_aviatsiya_107255_1920x1080.jpg', 'mi_24_35_vertolety_polet_nebo_aviatsiya_107255_1920x1080', 'jpg', 713616, 1920, 1080, 'images', '', 'medias/images/mi_24_35_vertolety_polet_nebo_aviatsiya_107255_1920x1080.jpg', 'medias/images/thumb/mi_24_35_vertolety_polet_nebo_aviatsiya_107255_1920x1080(thumb).jpg', 'medias/images/medium/mi_24_35_vertolety_polet_nebo_aviatsiya_107255_1920x1080(medium).jpg', 'medias/images/large/mi_24_35_vertolety_polet_nebo_aviatsiya_107255_1920x1080(large).jpg', '', '2019-05-07', '22:09:42'),
(1093, 'mylo_dynya_persik_vinograd_apelsiny_limony_107566_1920x1080.jpg', 'mylo_dynya_persik_vinograd_apelsiny_limony_107566_1920x1080', 'jpg', 986546, 1920, 1080, 'images', '', 'medias/images/mylo_dynya_persik_vinograd_apelsiny_limony_107566_1920x1080.jpg', 'medias/images/thumb/mylo_dynya_persik_vinograd_apelsiny_limony_107566_1920x1080(thumb).jpg', 'medias/images/medium/mylo_dynya_persik_vinograd_apelsiny_limony_107566_1920x1080(medium).jpg', 'medias/images/large/mylo_dynya_persik_vinograd_apelsiny_limony_107566_1920x1080(large).jpg', '', '2019-05-07', '22:09:43'),
(1094, 'okno_arka_interer_126264_1920x1080.jpg', 'okno_arka_interer_126264_1920x1080', 'jpg', 787060, 1920, 1080, 'images', '', 'medias/images/okno_arka_interer_126264_1920x1080.jpg', 'medias/images/thumb/okno_arka_interer_126264_1920x1080(thumb).jpg', 'medias/images/medium/okno_arka_interer_126264_1920x1080(medium).jpg', 'medias/images/large/okno_arka_interer_126264_1920x1080(large).jpg', '', '2019-05-07', '22:09:45'),
(1095, 'palmy_otdykh_lezhaki_bassejn_94865_1920x1080.jpg', 'palmy_otdykh_lezhaki_bassejn_94865_1920x1080', 'jpg', 1003759, 1920, 1080, 'images', '', 'medias/images/palmy_otdykh_lezhaki_bassejn_94865_1920x1080.jpg', 'medias/images/thumb/palmy_otdykh_lezhaki_bassejn_94865_1920x1080(thumb).jpg', 'medias/images/medium/palmy_otdykh_lezhaki_bassejn_94865_1920x1080(medium).jpg', 'medias/images/large/palmy_otdykh_lezhaki_bassejn_94865_1920x1080(large).jpg', '', '2019-05-07', '22:09:46'),
(1096, 'planeta_yarkiy_fon_86638_1920x1080.jpg', 'planeta_yarkiy_fon_86638_1920x1080', 'jpg', 821035, 1920, 1080, 'images', '', 'medias/images/planeta_yarkiy_fon_86638_1920x1080.jpg', 'medias/images/thumb/planeta_yarkiy_fon_86638_1920x1080(thumb).jpg', 'medias/images/medium/planeta_yarkiy_fon_86638_1920x1080(medium).jpg', 'medias/images/large/planeta_yarkiy_fon_86638_1920x1080(large).jpg', '', '2019-05-07', '22:09:47'),
(1097, 'poezd_doroga_dym_79239_1920x1080.jpg', 'poezd_doroga_dym_79239_1920x1080', 'jpg', 517606, 1920, 1080, 'images', '', 'medias/images/poezd_doroga_dym_79239_1920x1080.jpg', 'medias/images/thumb/poezd_doroga_dym_79239_1920x1080(thumb).jpg', 'medias/images/medium/poezd_doroga_dym_79239_1920x1080(medium).jpg', 'medias/images/large/poezd_doroga_dym_79239_1920x1080(large).jpg', '', '2019-05-07', '22:09:48'),
(1098, 'poezd_zheleznaia_doroga_vagon_133739_1920x1080.jpg', 'poezd_zheleznaia_doroga_vagon_133739_1920x1080', 'jpg', 1210365, 1920, 1080, 'images', '', 'medias/images/poezd_zheleznaia_doroga_vagon_133739_1920x1080.jpg', 'medias/images/thumb/poezd_zheleznaia_doroga_vagon_133739_1920x1080(thumb).jpg', 'medias/images/medium/poezd_zheleznaia_doroga_vagon_133739_1920x1080(medium).jpg', 'medias/images/large/poezd_zheleznaia_doroga_vagon_133739_1920x1080(large).jpg', '', '2019-05-07', '22:09:49'),
(1099, 'samolet_nebo_oblaka_106153_1920x1080.jpg', 'samolet_nebo_oblaka_106153_1920x1080', 'jpg', 410021, 1920, 1080, 'images', '', 'medias/images/samolet_nebo_oblaka_106153_1920x1080.jpg', 'medias/images/thumb/samolet_nebo_oblaka_106153_1920x1080(thumb).jpg', 'medias/images/medium/samolet_nebo_oblaka_106153_1920x1080(medium).jpg', 'medias/images/large/samolet_nebo_oblaka_106153_1920x1080(large).jpg', '', '2019-05-07', '22:09:50'),
(1100, 'setka_zabor_bliki_razmytost_svet_119748_1920x1080.jpg', 'setka_zabor_bliki_razmytost_svet_119748_1920x1080', 'jpg', 631385, 1920, 1080, 'images', '', 'medias/images/setka_zabor_bliki_razmytost_svet_119748_1920x1080.jpg', 'medias/images/thumb/setka_zabor_bliki_razmytost_svet_119748_1920x1080(thumb).jpg', 'medias/images/medium/setka_zabor_bliki_razmytost_svet_119748_1920x1080(medium).jpg', 'medias/images/large/setka_zabor_bliki_razmytost_svet_119748_1920x1080(large).jpg', '', '2019-05-07', '22:09:50'),
(1101, 'spichki_ogon_plamya_119027_1920x1080.jpg', 'spichki_ogon_plamya_119027_1920x1080', 'jpg', 537939, 1920, 1080, 'images', '', 'medias/images/spichki_ogon_plamya_119027_1920x1080.jpg', 'medias/images/thumb/spichki_ogon_plamya_119027_1920x1080(thumb).jpg', 'medias/images/medium/spichki_ogon_plamya_119027_1920x1080(medium).jpg', 'medias/images/large/spichki_ogon_plamya_119027_1920x1080(large).jpg', '', '2019-05-07', '22:09:51'),
(1102, 'svet_bliki_boke_131979_1920x1080.jpg', 'svet_bliki_boke_131979_1920x1080', 'jpg', 735132, 1920, 1080, 'images', '', 'medias/images/svet_bliki_boke_131979_1920x1080.jpg', 'medias/images/thumb/svet_bliki_boke_131979_1920x1080(thumb).jpg', 'medias/images/medium/svet_bliki_boke_131979_1920x1080(medium).jpg', 'medias/images/large/svet_bliki_boke_131979_1920x1080(large).jpg', '', '2019-05-07', '22:09:53'),
(1103, 'tropiki_kurort_palmy_uyut_90879_1920x1080.jpg', 'tropiki_kurort_palmy_uyut_90879_1920x1080', 'jpg', 1285470, 1920, 1080, 'images', '', 'medias/images/tropiki_kurort_palmy_uyut_90879_1920x1080.jpg', 'medias/images/thumb/tropiki_kurort_palmy_uyut_90879_1920x1080(thumb).jpg', 'medias/images/medium/tropiki_kurort_palmy_uyut_90879_1920x1080(medium).jpg', 'medias/images/large/tropiki_kurort_palmy_uyut_90879_1920x1080(large).jpg', '', '2019-05-07', '22:09:54'),
(1104, 'velosiped_ulitsa_zheltyj_116535_1920x1080.jpg', 'velosiped_ulitsa_zheltyj_116535_1920x1080', 'jpg', 1468191, 1920, 1080, 'images', '', 'medias/images/velosiped_ulitsa_zheltyj_116535_1920x1080.jpg', 'medias/images/thumb/velosiped_ulitsa_zheltyj_116535_1920x1080(thumb).jpg', 'medias/images/medium/velosiped_ulitsa_zheltyj_116535_1920x1080(medium).jpg', 'medias/images/large/velosiped_ulitsa_zheltyj_116535_1920x1080(large).jpg', '', '2019-05-07', '22:09:55'),
(1105, 'vojna_render_tank_fantastika_oruzhie_93842_1920x1080.jpg', 'vojna_render_tank_fantastika_oruzhie_93842_1920x1080', 'jpg', 640085, 1920, 1080, 'images', '', 'medias/images/vojna_render_tank_fantastika_oruzhie_93842_1920x1080.jpg', 'medias/images/thumb/vojna_render_tank_fantastika_oruzhie_93842_1920x1080(thumb).jpg', 'medias/images/medium/vojna_render_tank_fantastika_oruzhie_93842_1920x1080(medium).jpg', 'medias/images/large/vojna_render_tank_fantastika_oruzhie_93842_1920x1080(large).jpg', '', '2019-05-07', '22:09:56'),
(1106, 'vozdushnyj_shar_nebo_oblaka_138993_1920x1080.jpg', 'vozdushnyj_shar_nebo_oblaka_138993_1920x1080', 'jpg', 424296, 1920, 1080, 'images', '', 'medias/images/vozdushnyj_shar_nebo_oblaka_138993_1920x1080.jpg', 'medias/images/thumb/vozdushnyj_shar_nebo_oblaka_138993_1920x1080(thumb).jpg', 'medias/images/medium/vozdushnyj_shar_nebo_oblaka_138993_1920x1080(medium).jpg', 'medias/images/large/vozdushnyj_shar_nebo_oblaka_138993_1920x1080(large).jpg', '', '2019-05-07', '22:09:56'),
(1107, 'zoloto_slitki_monety_belyy_fon_dengi_80253_1920x1080.jpg', 'zoloto_slitki_monety_belyy_fon_dengi_80253_1920x1080', 'jpg', 616624, 1920, 1080, 'images', '', 'medias/images/zoloto_slitki_monety_belyy_fon_dengi_80253_1920x1080.jpg', 'medias/images/thumb/zoloto_slitki_monety_belyy_fon_dengi_80253_1920x1080(thumb).jpg', 'medias/images/medium/zoloto_slitki_monety_belyy_fon_dengi_80253_1920x1080(medium).jpg', 'medias/images/large/zoloto_slitki_monety_belyy_fon_dengi_80253_1920x1080(large).jpg', '', '2019-05-07', '22:09:58'),
(1108, 'avtomobil_neon_chelovek_137624_1920x1080.jpg', 'avtomobil_neon_chelovek_137624_1920x1080', 'jpg', 514780, 1920, 1080, 'images', '', 'medias/images/avtomobil_neon_chelovek_137624_1920x1080.jpg', 'medias/images/thumb/avtomobil_neon_chelovek_137624_1920x1080(thumb).jpg', 'medias/images/medium/avtomobil_neon_chelovek_137624_1920x1080(medium).jpg', 'medias/images/large/avtomobil_neon_chelovek_137624_1920x1080(large).jpg', '', '2019-05-07', '22:09:59'),
(1109, 'balerina_siluet_luna_tanets_120085_1920x1080.jpg', 'balerina_siluet_luna_tanets_120085_1920x1080', 'jpg', 291408, 1920, 1080, 'images', '', 'medias/images/balerina_siluet_luna_tanets_120085_1920x1080.jpg', 'medias/images/thumb/balerina_siluet_luna_tanets_120085_1920x1080(thumb).jpg', 'medias/images/medium/balerina_siluet_luna_tanets_120085_1920x1080(medium).jpg', 'medias/images/large/balerina_siluet_luna_tanets_120085_1920x1080(large).jpg', '', '2019-05-07', '22:09:59'),
(1110, 'chelovek_dym_ldiny_122200_1920x1080.jpg', 'chelovek_dym_ldiny_122200_1920x1080', 'jpg', 529050, 1920, 1080, 'images', '', 'medias/images/chelovek_dym_ldiny_122200_1920x1080.jpg', 'medias/images/thumb/chelovek_dym_ldiny_122200_1920x1080(thumb).jpg', 'medias/images/medium/chelovek_dym_ldiny_122200_1920x1080(medium).jpg', 'medias/images/large/chelovek_dym_ldiny_122200_1920x1080(large).jpg', '', '2019-05-07', '22:10:00'),
(1111, 'darts_igla_forma_85655_1920x1080.jpg', 'darts_igla_forma_85655_1920x1080', 'jpg', 638024, 1920, 1080, 'images', '', 'medias/images/darts_igla_forma_85655_1920x1080.jpg', 'medias/images/thumb/darts_igla_forma_85655_1920x1080(thumb).jpg', 'medias/images/medium/darts_igla_forma_85655_1920x1080(medium).jpg', 'medias/images/large/darts_igla_forma_85655_1920x1080(large).jpg', '', '2019-05-07', '22:10:02'),
(1112, 'dom_skazka_art_fonar_noch_101615_1920x1080.jpg', 'dom_skazka_art_fonar_noch_101615_1920x1080', 'jpg', 863809, 1920, 1080, 'images', '', 'medias/images/dom_skazka_art_fonar_noch_101615_1920x1080.jpg', 'medias/images/thumb/dom_skazka_art_fonar_noch_101615_1920x1080(thumb).jpg', 'medias/images/medium/dom_skazka_art_fonar_noch_101615_1920x1080(medium).jpg', 'medias/images/large/dom_skazka_art_fonar_noch_101615_1920x1080(large).jpg', '', '2019-05-07', '22:10:02'),
(1113, 'dozhd_derevya_fonari_ulica_skamya_dvoe_para_zont_75431_1920x1080.jpg', 'dozhd_derevya_fonari_ulica_skamya_dvoe_para_zont_75431_1920x1080', 'jpg', 1405810, 1920, 1080, 'images', '', 'medias/images/dozhd_derevya_fonari_ulica_skamya_dvoe_para_zont_75431_1920x1080.jpg', 'medias/images/thumb/dozhd_derevya_fonari_ulica_skamya_dvoe_para_zont_75431_1920x1080(thumb).jpg', 'medias/images/medium/dozhd_derevya_fonari_ulica_skamya_dvoe_para_zont_75431_1920x1080(medium).jpg', 'medias/images/large/dozhd_derevya_fonari_ulica_skamya_dvoe_para_zont_75431_1920x1080(large).jpg', '', '2019-05-07', '22:10:03'),
(1114, 'gorod_zheleznaya_doroga_svet_91905_1920x1080.jpg', 'gorod_zheleznaya_doroga_svet_91905_1920x1080', 'jpg', 1140124, 1920, 1080, 'images', '', 'medias/images/gorod_zheleznaya_doroga_svet_91905_1920x1080.jpg', 'medias/images/thumb/gorod_zheleznaya_doroga_svet_91905_1920x1080(thumb).jpg', 'medias/images/medium/gorod_zheleznaya_doroga_svet_91905_1920x1080(medium).jpg', 'medias/images/large/gorod_zheleznaya_doroga_svet_91905_1920x1080(large).jpg', '', '2019-05-07', '22:10:04'),
(1115, 'guby_devushka_pomada_poceluy_82169_1920x1080.jpg', 'guby_devushka_pomada_poceluy_82169_1920x1080', 'jpg', 711499, 1920, 1080, 'images', '', 'medias/images/guby_devushka_pomada_poceluy_82169_1920x1080.jpg', 'medias/images/thumb/guby_devushka_pomada_poceluy_82169_1920x1080(thumb).jpg', 'medias/images/medium/guby_devushka_pomada_poceluy_82169_1920x1080(medium).jpg', 'medias/images/large/guby_devushka_pomada_poceluy_82169_1920x1080(large).jpg', '', '2019-05-07', '22:10:06'),
(1116, 'kliuch_klaviatura_enter_125437_1920x1080.jpg', 'kliuch_klaviatura_enter_125437_1920x1080', 'jpg', 561389, 1920, 1080, 'images', '', 'medias/images/kliuch_klaviatura_enter_125437_1920x1080.jpg', 'medias/images/thumb/kliuch_klaviatura_enter_125437_1920x1080(thumb).jpg', 'medias/images/medium/kliuch_klaviatura_enter_125437_1920x1080(medium).jpg', 'medias/images/large/kliuch_klaviatura_enter_125437_1920x1080(large).jpg', '', '2019-05-07', '22:10:06'),
(1117, 'kofe_art_sketch_stol_117083_1920x1080.jpg', 'kofe', 'jpg', 1276232, 1920, 1080, 'images', '', 'medias/images/kofe_art_sketch_stol_117083_1920x1080.jpg', 'medias/images/thumb/kofe_art_sketch_stol_117083_1920x1080(thumb).jpg', 'medias/images/medium/kofe_art_sketch_stol_117083_1920x1080(medium).jpg', 'medias/images/large/kofe_art_sketch_stol_117083_1920x1080(large).jpg', 'kofes', '2019-05-07', '22:10:07'),
(1118, 'korabl_zvezdnoe_nebo_noch_137144_1920x1080.jpg', 'korabl_zvezdnoe_nebo_noch_137144_1920x1080', 'jpg', 561867, 1920, 1080, 'images', '', 'medias/images/korabl_zvezdnoe_nebo_noch_137144_1920x1080.jpg', 'medias/images/thumb/korabl_zvezdnoe_nebo_noch_137144_1920x1080(thumb).jpg', 'medias/images/medium/korabl_zvezdnoe_nebo_noch_137144_1920x1080(medium).jpg', 'medias/images/large/korabl_zvezdnoe_nebo_noch_137144_1920x1080(large).jpg', '', '2019-05-07', '22:10:07'),
(1119, 'kofe.jpg', 'kofe', 'jpg', 645269, 1920, 1080, 'images', '', 'medias/images/kofe.jpg', 'medias/images/thumb/kofe(thumb).jpg', 'medias/images/medium/kofe(medium).jpg', 'medias/images/large/kofe(large).jpg', '', '2019-05-07', '22:18:45'),
(1120, 'kofe(1).jpg', 'kofe', 'jpg', 5250, 500, 275, 'images', '', 'medias/images/kofe(1).jpg', 'medias/images/thumb/kofe(1)(thumb).jpg', 'medias/images/medium/kofe(1)(medium).jpg', 'medias/images/large/kofe(1)(large).jpg', '', '2019-05-07', '22:19:38');

-- --------------------------------------------------------

--
-- Структура таблицы `images_tags`
--

CREATE TABLE `images_tags` (
  `iid` int(11) NOT NULL,
  `tid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `images_tags`
--

INSERT INTO `images_tags` (`iid`, `tid`) VALUES
(1117, 93);

-- --------------------------------------------------------

--
-- Структура таблицы `items`
--

CREATE TABLE `items` (
  `id` bigint(20) NOT NULL,
  `name` varchar(60) NOT NULL,
  `category` bigint(20) NOT NULL,
  `content` longtext NOT NULL,
  `template` text NOT NULL,
  `authorId` bigint(20) NOT NULL,
  `groupId` tinyint(11) NOT NULL,
  `version` tinyint(11) NOT NULL,
  `blockIdCounter` tinyint(11) NOT NULL,
  `dateCreated` date NOT NULL,
  `timeCreated` time NOT NULL,
  `dateModified` date NOT NULL,
  `timeModified` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `items`
--

INSERT INTO `items` (`id`, `name`, `category`, `content`, `template`, `authorId`, `groupId`, `version`, `blockIdCounter`, `dateCreated`, `timeCreated`, `dateModified`, `timeModified`) VALUES
(2, 'Product 1', 1, 'a:2:{i:0;a:17:{s:2:\"id\";s:3:\"945\";s:8:\"fullName\";s:19:\"Sensual-Jane_07.jpg\";s:4:\"name\";s:15:\"Sensual-Jane_07\";s:5:\"title\";s:15:\"Sensual-Jane_07\";s:6:\"format\";s:3:\"jpg\";s:4:\"size\";s:6:\"870397\";s:5:\"width\";s:4:\"1920\";s:6:\"height\";s:4:\"1080\";s:4:\"type\";s:6:\"images\";s:3:\"alt\";s:0:\"\";s:3:\"src\";s:33:\"medias/images/Sensual-Jane_07.jpg\";s:5:\"thumb\";s:46:\"medias/images/thumb/Sensual-Jane_07(thumb).jpg\";s:6:\"medium\";s:48:\"medias/images/medium/Sensual-Jane_07(medium).jpg\";s:5:\"large\";s:46:\"medias/images/large/Sensual-Jane_07(large).jpg\";s:11:\"description\";s:0:\"\";s:11:\"dateCreated\";s:10:\"2018-10-18\";s:11:\"timeCreated\";s:8:\"01:44:41\";}i:1;s:63:\"<h2 style=\"text-align: left; \"><strong>Sensssssss</strong></h2>\";}', 'a:2:{i:0;a:4:{s:7:\"blockId\";s:1:\"0\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}i:1;a:4:{s:7:\"blockId\";s:1:\"1\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}}', 1, 2, 1, 2, '2019-03-07', '47:00:00', '2019-03-14', '15:00:00'),
(3, 'Post about our company ', 3, '', '', 1, 2, 1, 0, '2019-03-12', '00:45:10', '2019-03-15', '29:09:00'),
(4, 'News post 1', 3, '', '', 1, 3, 1, 0, '2019-03-30', '00:09:00', '2019-03-05', '00:07:00'),
(5, 'Brexit latest news', 3, 'a:1:{i:0;s:5:\"Bomba\";}', 'a:1:{i:0;a:4:{s:7:\"blockId\";s:1:\"0\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}}', 1, 4, 1, 1, '2019-03-04', '00:00:17', '2019-03-14', '00:08:00'),
(6, 'Lollipop candy', 4, 'a:7:{i:0;s:691:\"<h3 style=\"text-align: left; \"><strong><em>What is Lorem Ipsum?\n</em></strong></h3><p style=\"text-align: left; \">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\"s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\";i:1;a:17:{s:2:\"id\";s:4:\"1015\";s:8:\"fullName\";s:13:\"348622(1).jpg\";s:4:\"name\";s:9:\"348622(1)\";s:5:\"title\";s:13:\"546546546gfdf\";s:6:\"format\";s:3:\"jpg\";s:4:\"size\";s:6:\"710999\";s:5:\"width\";s:4:\"2560\";s:6:\"height\";s:4:\"1600\";s:4:\"type\";s:6:\"images\";s:3:\"alt\";s:0:\"\";s:3:\"src\";s:27:\"medias/images/348622(1).jpg\";s:5:\"thumb\";s:40:\"medias/images/thumb/348622(1)(thumb).jpg\";s:6:\"medium\";s:42:\"medias/images/medium/348622(1)(medium).jpg\";s:5:\"large\";s:40:\"medias/images/large/348622(1)(large).jpg\";s:11:\"description\";s:0:\"\";s:11:\"dateCreated\";s:10:\"2018-12-27\";s:11:\"timeCreated\";s:8:\"23:31:49\";}i:2;s:7716:\"<p style=\"text-align: left;\">Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc, quis gravida magna mi a libero. Fusce vulputate eleifend sapien. Vestibulum purus quam, scelerisque ut, mollis sed, nonummy id, metus. Nullam accumsan lorem in dui. Cras ultricies mi eu turpis hendrerit fringilla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In ac dui quis mi consectetuer lacinia. Nam pretium turpis et arcu. Duis arcu tortor, suscipit eget, imperdiet nec, imperdiet iaculis, ipsum. Sed aliquam ultrices mauris. Integer ante arcu, accumsan a, consectetuer eget, posuere ut, mauris. Praesent adipiscing. Phasellus ullamcorper ipsum rutrum nunc. Nunc nonummy metus. Vestibulum volutpat pretium libero. Cras id dui. Aenean ut eros et nisl sagittis vestibulum. Nullam nulla eros, ultricies sit amet, nonummy id, imperdiet feugiat, pede. Sed lectus. Donec mollis hendrerit risus. Phasellus nec sem in justo pellentesque facilisis. Etiam imperdiet imperdiet orci. Nunc nec neque. Phasellus leo dolor, tempus non, auctor et, hendrerit quis, nisi. Curabitur ligula sapien, tincidunt non, euismod vitae, posuere imperdiet, leo. Maecenas malesuada. Praesent congue erat at massa. Sed cursus turpis vitae tortor. Donec posuere vulputate arcu. Phasellus accumsan cursus velit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed aliquam, nisi quis porttitor congue, elit erat euismod orci, ac placerat dolor lectus quis orci. Phasellus consectetuer vestibulum elit. Aenean tellus metus, bibendum sed, posuere ac, mattis non, nunc. Vestibulum fringilla pede sit amet augue. In turpis. Pellentesque posuere. Praesent turpis. Aenean posuere, tortor sed cursus feugiat, nunc augue blandit nunc, eu sollicitudin urna dolor sagittis lacus. Donec elit libero, sodales nec, volutpat a, suscipit non, turpis. Nullam sagittis. Suspendisse pulvinar, augue ac venenatis condimentum, sem libero volutpat nibh, nec pellentesque velit pede quis nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Fusce id purus. Ut varius tincidunt libero. Phasellus dolor. Maecenas vestibulum mollis diam. Pellentesque ut neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In dui magna, posuere eget, vestibulum et, tempor auctor, justo. In ac felis quis tortor malesuada pretium. Pellentesque auctor neque nec urna. Proin sapien ipsum, porta a, auctor quis, euismod ut, mi. Aenean viverra rhoncus pede. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut non enim eleifend felis pretium feugiat. Vivamus quis mi. Phasellus a est. Phasellus magna. In hac habitasse platea dictumst. Curabitur at lacus ac velit ornare lobortis. Curabitur a felis in nunc fringilla tristique. Morbi mattis ullamcorper velit. Phasellus gravida semper nisi. Nullam vel sem. Pellentesque libero tortor, tincidunt et, tincidunt eget, semper nec, quam. Sed hendrerit. Morbi ac felis. Nunc egestas, augue at pellentesque laoreet, felis eros vehicula leo, at malesuada velit leo quis pede. Donec interdum, metus et hendrerit aliquet, dolor diam sagittis ligula, eget egestas libero turpis vel mi. Nunc nulla. Fusce risus nisl, viverra et, tempor et, pretium in, sapien. Donec venenatis vulputate lorem. Morbi nec metus. Phasellus blandit leo ut odio. Maecenas ullamcorper, dui et placerat feugiat, eros pede varius nisi, condimentum viverra felis nunc et lorem. Sed magna purus, fermentum eu, tincidunt eu, varius ut, felis. In auctor lobortis lacus. Quisque libero metus, condimentum nec, tempor a, commodo mollis, magna. Vestibulum ullamcorper mauris at ligula. Fusce fermentum. Nullam cursus lacinia erat. Praesent blandit laoreet nibh. Fusce convallis metus id felis luctus adipiscing. Pellentesque egestas, neque sit amet convallis pulvinar, justo nulla eleifend augue, ac auctor orci leo non est. Quisque id mi. Ut tincidunt tincidunt erat. Etiam feugiat lorem non metus. Vestibulum dapibus nunc ac augue. Curabitur vestibulum aliquam leo. Praesent egestas neque eu enim. In hac habitasse platea dictumst. Fusce a quam. Etiam ut purus mattis mauris sodales aliquam. Curabitur nisi. Quisque malesuada placerat nisl. Nam ipsum risus, rutrum vitae, vestibulum eu, molestie vel, lacus. Sed augue ipsum, egestas nec, vestibulum et, malesuada adipiscing, dui. Vestibulum facilisis, purus nec pulvinar iaculis, ligula mi congue nunc, vitae euismod ligula urna in dolor. Mauris sollicitudin fermentum libero. Praesent nonummy mi in odio. Nunc interdum lacus sit amet orci. Vestibulum rutrum, mi nec elementum vehicula, eros quam gravida nisl, id fringilla neque ante vel mi. Morbi mollis tellus ac sapien. Phasellus volutpat, metus eget egestas mollis, lacus lacus blandit dui, id egestas quam mauris ut lacus. Fusce vel dui. Sed in libero ut nibh placerat accumsan. Proin faucibus arcu quis ante. In consectetuer turpis ut velit. Nulla sit amet est. Praesent metus tellus, elementum eu, semper a, adipiscing nec, purus. Cras risus ipsum, faucibus ut, ullamcorper id, varius ac, leo. Suspendisse feugiat. Suspendisse enim turpis, dictum sed, iaculis a, condimentum nec, nisi. Praesent nec nisl a purus blandit viverra. Praesent ac massa at ligula laoreet iaculis. Nulla neque dolor, sagittis eget, iaculis quis, molestie non, velit. Mauris turpis nunc, blandit et, volutpat molestie, porta ut, ligula. Fusce pharetra convallis urna. Quisque ut nisi. Donec mi odio, faucibus at, scelerisque quis, convallis in, nisi. Suspendisse non nisl sit amet velit hendrerit rutrum. Ut leo. Ut a nisl id ante tempus hendrerit. Proin pretium, leo ac pellentesque mollis, felis nunc ultrices eros, sed gravida augue augue mollis justo. Suspendisse eu ligula. Nulla facilisi. Donec id justo. Praesent porttitor, nulla vitae posuere iaculis, arcu nisl dignissim dolor, a pretium mi sem ut ipsum. Curabitur suscipit suscipit tellus. Praesent vestibulum dapibus nibh. Etiam iaculis nunc ac metus. Ut id nisl quis enim dignissim sagittis. Etiam sollicitudin, ipsum eu pulvinar rutrum, tellus ipsum laoreet sapien, quis venenatis ante odio sit amet eros. Proin magna. Duis&nbsp;</p><p style=\"text-align: left;\">Ruler\n</p><p style=\"text-align: left; \">[î] TopShare:  Facebook  Twitter  Google  Diigo  Delicious Home | Imprint | v1.8(noflash) |  Link dieSachbearbeiter</p>\";i:3;a:17:{s:2:\"id\";s:4:\"1032\";s:8:\"fullName\";s:15:\"32437_12big.jpg\";s:4:\"name\";s:11:\"32437_12big\";s:5:\"title\";s:11:\"32437_12big\";s:6:\"format\";s:3:\"jpg\";s:4:\"size\";s:6:\"130552\";s:5:\"width\";s:3:\"671\";s:6:\"height\";s:4:\"1000\";s:4:\"type\";s:6:\"images\";s:3:\"alt\";s:0:\"\";s:3:\"src\";s:29:\"medias/images/32437_12big.jpg\";s:5:\"thumb\";s:42:\"medias/images/thumb/32437_12big(thumb).jpg\";s:6:\"medium\";s:44:\"medias/images/medium/32437_12big(medium).jpg\";s:5:\"large\";s:42:\"medias/images/large/32437_12big(large).jpg\";s:11:\"description\";s:0:\"\";s:11:\"dateCreated\";s:10:\"2019-02-20\";s:11:\"timeCreated\";s:8:\"20:40:29\";}i:4;a:17:{s:2:\"id\";s:3:\"927\";s:8:\"fullName\";s:10:\"161600.jpg\";s:4:\"name\";s:6:\"161600\";s:5:\"title\";s:6:\"161600\";s:6:\"format\";s:3:\"jpg\";s:4:\"size\";s:7:\"1116443\";s:5:\"width\";s:4:\"1920\";s:6:\"height\";s:4:\"1080\";s:4:\"type\";s:6:\"images\";s:3:\"alt\";s:0:\"\";s:3:\"src\";s:24:\"medias/images/161600.jpg\";s:5:\"thumb\";s:37:\"medias/images/thumb/161600(thumb).jpg\";s:6:\"medium\";s:39:\"medias/images/medium/161600(medium).jpg\";s:5:\"large\";s:37:\"medias/images/large/161600(large).jpg\";s:11:\"description\";s:0:\"\";s:11:\"dateCreated\";s:10:\"2018-10-10\";s:11:\"timeCreated\";s:8:\"02:56:54\";}i:5;s:22:\"<h1>Dasha Navarra</h1>\";i:6;a:17:{s:2:\"id\";s:4:\"1009\";s:8:\"fullName\";s:10:\"Mojave.jpg\";s:4:\"name\";s:6:\"Mojave\";s:5:\"title\";s:6:\"Mojave\";s:6:\"format\";s:3:\"jpg\";s:4:\"size\";s:6:\"275058\";s:5:\"width\";s:4:\"3570\";s:6:\"height\";s:4:\"2078\";s:4:\"type\";s:6:\"images\";s:3:\"alt\";s:0:\"\";s:3:\"src\";s:24:\"medias/images/Mojave.jpg\";s:5:\"thumb\";s:37:\"medias/images/thumb/Mojave(thumb).jpg\";s:6:\"medium\";s:39:\"medias/images/medium/Mojave(medium).jpg\";s:5:\"large\";s:37:\"medias/images/large/Mojave(large).jpg\";s:11:\"description\";s:18:\"Desert at night...\";s:11:\"dateCreated\";s:10:\"2018-10-18\";s:11:\"timeCreated\";s:8:\"01:45:31\";}}', 'a:7:{i:0;a:4:{s:7:\"blockId\";s:1:\"0\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}i:1;a:4:{s:7:\"blockId\";s:1:\"1\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}i:2;a:4:{s:7:\"blockId\";s:1:\"2\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}i:3;a:4:{s:7:\"blockId\";s:1:\"3\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}i:4;a:4:{s:7:\"blockId\";s:1:\"4\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}i:5;a:4:{s:7:\"blockId\";s:1:\"5\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}i:6;a:4:{s:7:\"blockId\";s:1:\"6\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}}', 1, 5, 1, 7, '2019-03-04', '28:12:00', '2019-03-14', '29:09:00'),
(80, 'New Item', 3, '', 'a:2:{i:0;a:4:{s:7:\"blockId\";s:1:\"4\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}i:1;a:4:{s:7:\"blockId\";s:1:\"5\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}}', 1, 0, 1, 6, '2019-03-16', '22:41:24', '0000-00-00', '00:00:00'),
(84, 'River Otter Beaver Trial', 2, '', '', 1, 0, 1, 0, '2019-03-19', '00:34:10', '0000-00-00', '00:00:00'),
(85, 'La fleur', 3, '', '', 1, 0, 1, 0, '2019-03-19', '00:36:32', '0000-00-00', '00:00:00'),
(86, 'La fleur le est belle', 3, '', '', 1, 0, 1, 0, '2019-03-19', '00:38:10', '0000-00-00', '00:00:00'),
(87, 'Analytical tools for business analysis', 2, '', '', 1, 0, 1, 0, '2019-03-19', '00:39:53', '0000-00-00', '00:00:00'),
(88, 'Spaceflight activates herpes in astronauts', 2, '', 'a:7:{i:0;a:4:{s:7:\"blockId\";s:1:\"0\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}i:1;a:4:{s:7:\"blockId\";s:1:\"1\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}i:2;a:4:{s:7:\"blockId\";s:1:\"2\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}i:3;a:4:{s:7:\"blockId\";s:1:\"3\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}i:4;a:4:{s:7:\"blockId\";s:1:\"6\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}i:5;a:4:{s:7:\"blockId\";s:1:\"4\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}i:6;a:4:{s:7:\"blockId\";s:1:\"5\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}}', 1, 0, 1, 0, '2019-03-19', '03:03:45', '0000-00-00', '00:00:00'),
(89, 'Why so many people leave London', 1, '', 'a:2:{i:0;a:4:{s:7:\"blockId\";s:1:\"4\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}i:1;a:4:{s:7:\"blockId\";s:1:\"5\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}}', 1, 0, 1, 0, '2019-03-19', '03:08:07', '0000-00-00', '00:00:00'),
(90, 'Boeing unveils its brand new 777X airplane', 2, '', '', 1, 0, 1, 0, '2019-03-19', '03:12:34', '0000-00-00', '00:00:00'),
(91, 'Traditional Web Server Model', 3, '', '', 1, 0, 1, 0, '2019-03-19', '03:14:14', '0000-00-00', '00:00:00'),
(92, 'Node.js Process Model', 3, '', '', 1, 0, 1, 0, '2019-03-19', '03:14:33', '0000-00-00', '00:00:00'),
(93, 'Table cells of a column selected with crosses', 3, '', '', 1, 0, 1, 0, '2019-03-19', '03:15:15', '0000-00-00', '00:00:00'),
(94, 'Advertising is a marketing communication', 3, '', '', 1, 0, 1, 0, '2019-03-19', '03:19:42', '0000-00-00', '00:00:00'),
(95, 'The 17 Best Advertisements of All Time', 3, '', '', 1, 0, 1, 0, '2019-03-19', '03:20:11', '0000-00-00', '00:00:00'),
(96, 'Sales messages and wall posters', 2, '', '', 1, 0, 1, 0, '2019-03-19', '03:21:12', '0000-00-00', '00:00:00'),
(97, 'Bacon ice cream', 4, '', '', 1, 0, 1, 0, '2019-03-19', '03:21:39', '0000-00-00', '00:00:00'),
(98, 'Blue moon', 4, 'a:4:{i:0;s:480:\"<p style=\"text-align: left; \">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>\";i:1;a:17:{s:2:\"id\";s:4:\"1049\";s:8:\"fullName\";s:9:\"xtxcn.jpg\";s:4:\"name\";s:5:\"xtxcn\";s:5:\"title\";s:6:\"horror\";s:6:\"format\";s:3:\"jpg\";s:4:\"size\";s:4:\"5250\";s:5:\"width\";s:3:\"500\";s:6:\"height\";s:3:\"275\";s:4:\"type\";s:6:\"images\";s:3:\"alt\";s:0:\"\";s:3:\"src\";s:23:\"medias/images/xtxcn.jpg\";s:5:\"thumb\";s:36:\"medias/images/thumb/xtxcn(thumb).jpg\";s:6:\"medium\";s:38:\"medias/images/medium/xtxcn(medium).jpg\";s:5:\"large\";s:36:\"medias/images/large/xtxcn(large).jpg\";s:11:\"description\";s:0:\"\";s:11:\"dateCreated\";s:10:\"2019-05-07\";s:11:\"timeCreated\";s:8:\"19:30:46\";}i:9;s:7:\"tyughjj\";i:10;a:17:{s:2:\"id\";s:4:\"1049\";s:8:\"fullName\";s:9:\"xtxcn.jpg\";s:4:\"name\";s:5:\"xtxcn\";s:5:\"title\";s:6:\"horror\";s:6:\"format\";s:3:\"jpg\";s:4:\"size\";s:4:\"5250\";s:5:\"width\";s:3:\"500\";s:6:\"height\";s:3:\"275\";s:4:\"type\";s:6:\"images\";s:3:\"alt\";s:0:\"\";s:3:\"src\";s:23:\"medias/images/xtxcn.jpg\";s:5:\"thumb\";s:36:\"medias/images/thumb/xtxcn(thumb).jpg\";s:6:\"medium\";s:38:\"medias/images/medium/xtxcn(medium).jpg\";s:5:\"large\";s:36:\"medias/images/large/xtxcn(large).jpg\";s:11:\"description\";s:0:\"\";s:11:\"dateCreated\";s:10:\"2019-05-07\";s:11:\"timeCreated\";s:8:\"19:30:46\";}}', 'a:4:{i:0;a:4:{s:7:\"blockId\";s:1:\"0\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}i:1;a:4:{s:7:\"blockId\";s:1:\"1\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}i:2;a:4:{s:7:\"blockId\";s:2:\"10\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}i:3;a:4:{s:7:\"blockId\";s:1:\"9\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}}', 1, 0, 1, 11, '2019-03-19', '03:22:36', '0000-00-00', '00:00:00'),
(99, 'Chocolate chip cookie dough ice cream', 4, '', '', 1, 0, 1, 0, '2019-03-19', '03:23:15', '0000-00-00', '00:00:00'),
(100, 'Green tea ice cream', 4, 'a:2:{i:0;s:124:\"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\";i:1;a:17:{s:2:\"id\";s:4:\"1008\";s:8:\"fullName\";s:14:\"Wallpapers.jpg\";s:4:\"name\";s:10:\"Wallpapers\";s:5:\"title\";s:10:\"Wallpapers\";s:6:\"format\";s:3:\"jpg\";s:4:\"size\";s:6:\"307959\";s:5:\"width\";s:4:\"1366\";s:6:\"height\";s:3:\"768\";s:4:\"type\";s:6:\"images\";s:3:\"alt\";s:0:\"\";s:3:\"src\";s:28:\"medias/images/Wallpapers.jpg\";s:5:\"thumb\";s:41:\"medias/images/thumb/Wallpapers(thumb).jpg\";s:6:\"medium\";s:43:\"medias/images/medium/Wallpapers(medium).jpg\";s:5:\"large\";s:41:\"medias/images/large/Wallpapers(large).jpg\";s:11:\"description\";s:0:\"\";s:11:\"dateCreated\";s:10:\"2018-10-18\";s:11:\"timeCreated\";s:8:\"01:45:29\";}}', 'a:2:{i:0;a:4:{s:7:\"blockId\";s:1:\"0\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}i:1;a:4:{s:7:\"blockId\";s:1:\"1\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}}', 1, 0, 1, 2, '2019-03-19', '03:23:54', '0000-00-00', '00:00:00'),
(101, 'Moose Tracks', 4, '', '', 1, 0, 1, 0, '2019-03-19', '03:24:20', '0000-00-00', '00:00:00'),
(102, 'Neapolitan ice cream', 4, 'a:2:{i:0;s:1402:\"<p style=\"text-align: left; \">Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,</p>\";i:1;a:17:{s:2:\"id\";s:4:\"1051\";s:8:\"fullName\";s:32:\"krany-stroika-doma-oae-dubai.jpg\";s:4:\"name\";s:28:\"krany-stroika-doma-oae-dubai\";s:5:\"title\";s:28:\"krany-stroika-doma-oae-dubai\";s:6:\"format\";s:3:\"jpg\";s:4:\"size\";s:6:\"528404\";s:5:\"width\";s:4:\"1920\";s:6:\"height\";s:4:\"1080\";s:4:\"type\";s:6:\"images\";s:3:\"alt\";s:0:\"\";s:3:\"src\";s:46:\"medias/images/krany-stroika-doma-oae-dubai.jpg\";s:5:\"thumb\";s:59:\"medias/images/thumb/krany-stroika-doma-oae-dubai(thumb).jpg\";s:6:\"medium\";s:61:\"medias/images/medium/krany-stroika-doma-oae-dubai(medium).jpg\";s:5:\"large\";s:59:\"medias/images/large/krany-stroika-doma-oae-dubai(large).jpg\";s:11:\"description\";s:0:\"\";s:11:\"dateCreated\";s:10:\"2019-05-07\";s:11:\"timeCreated\";s:8:\"19:33:41\";}}', 'a:2:{i:0;a:4:{s:7:\"blockId\";s:1:\"0\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}i:1;a:4:{s:7:\"blockId\";s:1:\"1\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}}', 1, 0, 1, 2, '2019-03-19', '03:24:48', '0000-00-00', '00:00:00'),
(103, 'New item test', 1, '', 'a:1:{i:0;a:4:{s:7:\"blockId\";s:1:\"0\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}}', 1, 0, 1, 1, '2019-04-11', '21:38:50', '0000-00-00', '00:00:00'),
(108, 'JH', 3, 'a:3:{i:0;s:58:\"<p style=\"text-align: right;\"><strong>fgvbhnm</strong></p>\";i:1;a:17:{s:2:\"id\";s:4:\"1109\";s:8:\"fullName\";s:48:\"balerina_siluet_luna_tanets_120085_1920x1080.jpg\";s:4:\"name\";s:44:\"balerina_siluet_luna_tanets_120085_1920x1080\";s:5:\"title\";s:44:\"balerina_siluet_luna_tanets_120085_1920x1080\";s:6:\"format\";s:3:\"jpg\";s:4:\"size\";s:6:\"291408\";s:5:\"width\";s:4:\"1920\";s:6:\"height\";s:4:\"1080\";s:4:\"type\";s:6:\"images\";s:3:\"alt\";s:0:\"\";s:3:\"src\";s:62:\"medias/images/balerina_siluet_luna_tanets_120085_1920x1080.jpg\";s:5:\"thumb\";s:75:\"medias/images/thumb/balerina_siluet_luna_tanets_120085_1920x1080(thumb).jpg\";s:6:\"medium\";s:77:\"medias/images/medium/balerina_siluet_luna_tanets_120085_1920x1080(medium).jpg\";s:5:\"large\";s:75:\"medias/images/large/balerina_siluet_luna_tanets_120085_1920x1080(large).jpg\";s:11:\"description\";s:0:\"\";s:11:\"dateCreated\";s:10:\"2019-05-07\";s:11:\"timeCreated\";s:8:\"22:09:59\";}i:2;a:17:{s:2:\"id\";s:4:\"1108\";s:8:\"fullName\";s:44:\"avtomobil_neon_chelovek_137624_1920x1080.jpg\";s:4:\"name\";s:40:\"avtomobil_neon_chelovek_137624_1920x1080\";s:5:\"title\";s:40:\"avtomobil_neon_chelovek_137624_1920x1080\";s:6:\"format\";s:3:\"jpg\";s:4:\"size\";s:6:\"514780\";s:5:\"width\";s:4:\"1920\";s:6:\"height\";s:4:\"1080\";s:4:\"type\";s:6:\"images\";s:3:\"alt\";s:0:\"\";s:3:\"src\";s:58:\"medias/images/avtomobil_neon_chelovek_137624_1920x1080.jpg\";s:5:\"thumb\";s:71:\"medias/images/thumb/avtomobil_neon_chelovek_137624_1920x1080(thumb).jpg\";s:6:\"medium\";s:73:\"medias/images/medium/avtomobil_neon_chelovek_137624_1920x1080(medium).jpg\";s:5:\"large\";s:71:\"medias/images/large/avtomobil_neon_chelovek_137624_1920x1080(large).jpg\";s:11:\"description\";s:0:\"\";s:11:\"dateCreated\";s:10:\"2019-05-07\";s:11:\"timeCreated\";s:8:\"22:09:59\";}}', 'a:3:{i:0;a:4:{s:7:\"blockId\";s:1:\"1\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}i:1;a:4:{s:7:\"blockId\";s:1:\"0\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:7:\"wysiwyg\";s:7:\"options\";s:0:\"\";}i:2;a:4:{s:7:\"blockId\";s:1:\"2\";s:4:\"type\";s:3:\"fwb\";s:7:\"subtype\";s:3:\"img\";s:7:\"options\";s:0:\"\";}}', 1, 0, 1, 3, '2019-05-07', '21:53:44', '0000-00-00', '00:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `itemstags`
--

CREATE TABLE `itemstags` (
  `id` bigint(20) NOT NULL,
  `itemId` bigint(20) NOT NULL,
  `taxonomyId` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `otherfiles`
--

CREATE TABLE `otherfiles` (
  `id` int(11) NOT NULL,
  `fullName` tinytext NOT NULL,
  `name` tinytext NOT NULL,
  `title` tinytext NOT NULL,
  `format` tinytext NOT NULL,
  `size` int(11) NOT NULL,
  `type` tinytext NOT NULL,
  `src` tinytext NOT NULL,
  `dateCreated` date NOT NULL,
  `timeCreated` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `author` int(11) NOT NULL,
  `path` varchar(500) NOT NULL,
  `dateCreated` date NOT NULL,
  `timeCreated` time NOT NULL,
  `dateModified` date NOT NULL,
  `timeModified` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `tags`
--

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `tag` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tags`
--

INSERT INTO `tags` (`id`, `tag`) VALUES
(9, 'tag1'),
(10, 'bazooka'),
(11, 'asos'),
(12, 'berserk'),
(13, 'serafin'),
(14, 'burzoom'),
(15, 'german'),
(47, 'gaz'),
(48, 'ber'),
(49, 'vazilin'),
(50, 'bA'),
(51, 'bamberg'),
(52, 'basturma'),
(53, 'berm'),
(54, 'bama'),
(55, 'kazel'),
(56, 'lazara'),
(57, 'tag-1'),
(58, 'yatis'),
(59, 'brom'),
(60, 'prorok'),
(61, 'br'),
(62, 'bt'),
(63, 'baran'),
(64, 'dsadasd'),
(65, '1'),
(66, '2'),
(67, '3'),
(68, '4'),
(69, '5'),
(70, '6'),
(71, '7'),
(72, '8'),
(73, '9'),
(74, '10'),
(75, '11'),
(76, 's'),
(77, 'gaonoz'),
(78, 'kobila'),
(79, 'parasha'),
(80, 'armagedon'),
(81, 'cccc'),
(82, 'panther'),
(83, 'Ira'),
(84, 'sss'),
(85, 'vvvv'),
(86, 'desert'),
(87, 'night'),
(88, 'wallpapers'),
(89, 'Alua'),
(90, 'Jane'),
(91, 'Sensual'),
(92, 'tag1-2'),
(93, 'kofe');

-- --------------------------------------------------------

--
-- Структура таблицы `tanks`
--

CREATE TABLE `tanks` (
  `id` int(11) NOT NULL,
  `fullName` tinytext NOT NULL,
  `shortName` tinytext NOT NULL,
  `nation` tinytext NOT NULL,
  `class` tinytext NOT NULL,
  `technicalInfo` text NOT NULL,
  `history` mediumtext NOT NULL,
  `combatHistory` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tanks`
--

INSERT INTO `tanks` (`id`, `fullName`, `shortName`, `nation`, `class`, `technicalInfo`, `history`, `combatHistory`, `dateCreated`) VALUES
(10, 'Panzerkampfwagen I', 'bvdsf', 'germany', 'medium', 'fdsfdsfsd', '', 'rtgy', '2018-07-07 20:05:34'),
(11, 'Panzerkampf', 'bvdsf', 'ussr', 'light', 'rewrwe', '', '', '2018-07-08 16:52:03'),
(12, 'Panzerkampfwagen II', 'bvdsf', 'ussr', 'medium', '', '', '', '2018-07-15 13:18:15'),
(13, 'Panzerkampfwagen IVVVV', '', 'germany', '', 'fdsfdsfsd', '', '', '2018-07-15 13:51:12'),
(14, '', '', 'germany', 'heavy', '', '', '', '2018-07-18 02:09:54'),
(15, 'FDFSf', '', 'ussr', '', '', '', '', '2018-07-18 02:10:14');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `username` varchar(60) NOT NULL,
  `password` varchar(60) NOT NULL,
  `permissions` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(100) NOT NULL,
  `activeNow` char(1) NOT NULL,
  `worksOn` bigint(20) NOT NULL,
  `dateCreated` date NOT NULL,
  `timeCreated` time NOT NULL,
  `lastLoginDate` date NOT NULL,
  `lastLoginTIme` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `permissions`, `email`, `activeNow`, `worksOn`, `dateCreated`, `timeCreated`, `lastLoginDate`, `lastLoginTIme`) VALUES
(1, 'user1', 'b59c67bf196a4758191e42f76670ceba', 0, 'email@gamil.com', '', 0, '0000-00-00', '00:00:00', '0000-00-00', '00:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `videos`
--

CREATE TABLE `videos` (
  `id` int(11) NOT NULL,
  `fullName` tinytext NOT NULL,
  `name` tinytext NOT NULL,
  `title` tinytext NOT NULL,
  `format` tinytext NOT NULL,
  `size` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `type` tinytext NOT NULL,
  `src` tinytext NOT NULL,
  `thumb` tinytext NOT NULL,
  `medium` tinytext NOT NULL,
  `large` tinytext NOT NULL,
  `description` text NOT NULL,
  `dateCreated` date NOT NULL,
  `timeCreated` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `docs`
--
ALTER TABLE `docs`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `images_tags`
--
ALTER TABLE `images_tags`
  ADD KEY `images_tags_ibfk_2` (`tid`),
  ADD KEY `images_tags_ibfk_1` (`iid`);

--
-- Индексы таблицы `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `authorId` (`authorId`),
  ADD KEY `taxonomyCategory` (`category`);

--
-- Индексы таблицы `itemstags`
--
ALTER TABLE `itemstags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `itemId` (`itemId`);

--
-- Индексы таблицы `otherfiles`
--
ALTER TABLE `otherfiles`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tanks`
--
ALTER TABLE `tanks`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `docs`
--
ALTER TABLE `docs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1121;

--
-- AUTO_INCREMENT для таблицы `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT для таблицы `itemstags`
--
ALTER TABLE `itemstags`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `otherfiles`
--
ALTER TABLE `otherfiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT для таблицы `tanks`
--
ALTER TABLE `tanks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `videos`
--
ALTER TABLE `videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `images_tags`
--
ALTER TABLE `images_tags`
  ADD CONSTRAINT `images_tags_ibfk_1` FOREIGN KEY (`iid`) REFERENCES `images` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `images_tags_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_2` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `items_ibfk_3` FOREIGN KEY (`category`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `itemstags`
--
ALTER TABLE `itemstags`
  ADD CONSTRAINT `itemstags_ibfk_1` FOREIGN KEY (`itemId`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
