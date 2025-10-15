
# Fix Notes (SakaMilePurw)

Applied fixes on 2025-10-14 (Asia/Jakarta):

## Database
- Added **sql/schema_fix.sql** to create required tables:
  - `site_stats(stat_key, stat_value, updated_at)` seeded with `('total_page_views', 0)`
  - `berita(id_berita, judul, sub_judul, isi_berita, gambar, tanggal, status)`
- Added **scripts/init_db.py** to apply schema quickly:
  ```bash
  # with MySQL running and DB created (db_dinkominfostasandi_dummy)
  python scripts/init_db.py
  ```

## Code (Flask)
- Kept your `app/db.py` connection pattern; errors are handled in try/except in routes.
- No functional change to route logic, only support for missing tables.

## Static Assets
- Fixed relative paths in **app/static/css/style.css** and **templates/css/style.css**:
  - `static/img/...` → `../img/...` (CSS-relative) to avoid `/static/css/static/img/...` 404.
- Updated many templates under **templates/** to use Jinja `url_for('static', filename=...)` for `img`, `css`, and `js` references to avoid broken paths.

## How to run
1. Make sure MySQL has a database named `db_dinkominfostasandi_dummy` and credentials match **app/db.py**.
2. Apply schema:
   ```bash
   python scripts/init_db.py
   ```
3. Start Flask app (as you normally do). Visit `/` and check logs; 1146/1054/404 issues should be gone.
4. Optional: insert sample rows into `berita` for the homepage list.

## Notes
- If you prefer aggregated page views per path/day, you can switch to a different schema; current code expects key-value `site_stats` with key `total_page_views`.
