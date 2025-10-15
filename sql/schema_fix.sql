
-- Schema fixes for SakaMilePurw

-- 1) Key-Value statistics table used by app/public/routes.py
CREATE TABLE IF NOT EXISTS site_stats (
  stat_key VARCHAR(100) PRIMARY KEY,
  stat_value BIGINT UNSIGNED NOT NULL DEFAULT 0,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed the required key
INSERT INTO site_stats (stat_key, stat_value) VALUES ('total_page_views', 0)
ON DUPLICATE KEY UPDATE stat_value = stat_value;

-- 2) Berita table expected by queries in routes (id_berita, judul, sub_judul, isi_berita, gambar, tanggal, status)
CREATE TABLE IF NOT EXISTS berita (
  id_berita INT UNSIGNED NOT NULL AUTO_INCREMENT,
  judul VARCHAR(255) NOT NULL,
  sub_judul VARCHAR(255) NULL,
  isi_berita MEDIUMTEXT NOT NULL,
  gambar VARCHAR(255) NULL,
  tanggal DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status ENUM('Draft','Published') NOT NULL DEFAULT 'Draft',
  PRIMARY KEY (id_berita),
  KEY idx_tanggal (tanggal),
  KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
