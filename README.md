# reolink-gmail-archival
Set of scripts that archives and uploads Reolink camera pictures to B2

## prerequisites
- `Raspbian`, `python>=3.5` installed
- following environment variables defined in `creds.sh`:
    - `GMAIL_USER` and `GMAIL_PASSWORD` for [GMail](https://mail.google.com)
    - `B2_KEY_ID`, `B2_APP_KEY`, and `B2_BUCKET` for [backblaze b2 bucket](https://www.backblaze.com/)

## usage
- `setup.sh` installs `gmail-img-dl` package globally
- `download.sh <attachments dir> <log file>` starts `gmail-dl`; it should be in `cron` periodically, preferably once on hour
- `zip_and_upload.sh <attachments dir> <temp dir>` starts zipping and uploading process; it should be in `cron` so it runs once a day
- example `crontab`:
    - `PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games`
    - `0 3 * * * /home/pi/cam/reolink-gmail-archival/download.sh /home/pi/cam/data >> /home/pi/cam/log/download.log 2>&1`
    - `30 3 * * * /home/pi/cam/reolink-gmail-archival/zip_and_upload.sh /home/pi/cam/data /home/pi/cam/upload >> /home/pi/cam/log/zip_and_upload.log 2>&1`
