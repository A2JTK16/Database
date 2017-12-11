DELIMITER //
   CREATE OR REPLACE FUNCTION isThereUser(usrname VARCHAR(30), pass VARCHAR(25)) RETURNS BOOLEAN DETERMINISTIC
   BEGIN

   DECLARE result BOOLEAN;

   SELECT COUNT(*) INTO @temp FROM traveller WHERE (traveller_username = usrname AND traveller_password = pass);
   IF @temp = 1 THEN SET result = TRUE;
   ELSEIF @temp = 0 THEN SET result = FALSE;
   END IF;

   RETURN(result);
   END //
DELIMITER ;

SELECT isThereUser('nmuntaaza','qwerty');