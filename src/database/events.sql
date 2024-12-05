CREATE EVENT `mark_expired_events`
ON SCHEDULE EVERY 1 DAY
DO
  UPDATE `menus_menu`
  SET `active_status` = 0
  WHERE `available_until` < NOW();