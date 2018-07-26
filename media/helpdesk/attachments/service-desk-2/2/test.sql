DECLARE
  info_ VARCHAR2(2000);
  attr_ VARCHAR2(2000);
  objid_ VARCHAR2(2000);
  objversion_ VARCHAR2(2000);
  var_ BOOLEAN := FALSE;
  input_default_site_ VARCHAR2(20):='';
  CURSOR csv_user
  IS
    SELECT userid FROM USER_ALLOWED_SITE  where userid IN ('CGOODE');------------unim_temp_users;
    
  CURSOR site_user(userid_ VARCHAR2) IS
    SELECT USERID,CONTRACT,USER_SITE_TYPE,USER_SITE_TYPE_DB,objid,objversion FROM USER_ALLOWED_SITE WHERE  USERID=userid_;
  
BEGIN
FOR user_ IN csv_user LOOP
----------IF 41,42,44,45,46 not exist then insert it--------------- 
IF NOT (user_allowed_site_api.Exists(user_.userid,'041')) THEN
        info_        :='';
        objid_      :='';
        objversion_ :='';
        Client_SYS.Clear_Attr(attr_);
        Client_SYS.Add_To_Attr('USERID', user_.userid, attr_);
        Client_SYS.Add_To_Attr('CONTRACT', '041', attr_);
        IF  (User_Allowed_Site_API.Check_Default_Site(user_.userid,'042') OR User_Allowed_Site_API.Check_Default_Site(user_.userid,'044') OR User_Allowed_Site_API.Check_Default_Site(user_.userid,'045') OR User_Allowed_Site_API.Check_Default_Site(user_.userid,'046')) THEN
        Client_SYS.Add_To_Attr('USER_SITE_TYPE_DB', 'NOT DEFAULT SITE', attr_);
        ELSE
        Client_SYS.Add_To_Attr('USER_SITE_TYPE_DB', 'DEFAULT SITE', attr_);
        END IF;
        
        dbms_output.put_line('SET DEFAULT SITE 041'||user_.userid);
        USER_ALLOWED_SITE_API.NEW__(info_,objid_,objversion_,attr_,'DO');
END IF;
IF NOT (user_allowed_site_api.Exists(user_.userid,'042')) THEN
      info_        :='';
        objid_      :='';
        objversion_ :='';
        Client_SYS.Clear_Attr(attr_);
        Client_SYS.Add_To_Attr('USERID', user_.userid, attr_);
        Client_SYS.Add_To_Attr('CONTRACT', '042', attr_);
        Client_SYS.Add_To_Attr('USER_SITE_TYPE_DB', 'NOT DEFAULT SITE', attr_);
        dbms_output.put_line('SET DEFAULT SITE 042'||user_.userid);
        USER_ALLOWED_SITE_API.NEW__(info_,objid_,objversion_,attr_,'DO');
END IF;
IF NOT (user_allowed_site_api.Exists(user_.userid,'044')) THEN
      info_        :='';
        objid_      :='';
        objversion_ :='';
        Client_SYS.Clear_Attr(attr_);
        Client_SYS.Add_To_Attr('USERID', user_.userid, attr_);
        Client_SYS.Add_To_Attr('CONTRACT', '044', attr_);
        Client_SYS.Add_To_Attr('USER_SITE_TYPE_DB', 'NOT DEFAULT SITE', attr_);
        dbms_output.put_line('SET DEFAULT SITE 044'||user_.userid);
        USER_ALLOWED_SITE_API.NEW__(info_,objid_,objversion_,attr_,'DO');
END IF;
IF NOT (user_allowed_site_api.Exists(user_.userid,'045')) THEN
      info_        :='';
        objid_      :='';
        objversion_ :='';
        Client_SYS.Clear_Attr(attr_);
        Client_SYS.Add_To_Attr('USERID', user_.userid, attr_);
        Client_SYS.Add_To_Attr('CONTRACT', '045', attr_);
        Client_SYS.Add_To_Attr('USER_SITE_TYPE_DB', 'NOT DEFAULT SITE', attr_);
        dbms_output.put_line('SET DEFAULT SITE 045'||user_.userid);
        USER_ALLOWED_SITE_API.NEW__(info_,objid_,objversion_,attr_,'DO');
END IF;
IF NOT (user_allowed_site_api.Exists(user_.userid,'046')) THEN
      info_        :='';
        objid_      :='';
        objversion_ :='';
        Client_SYS.Clear_Attr(attr_);
        Client_SYS.Add_To_Attr('USERID', user_.userid, attr_);
        Client_SYS.Add_To_Attr('CONTRACT', '046', attr_);
        Client_SYS.Add_To_Attr('USER_SITE_TYPE_DB', 'NOT DEFAULT SITE', attr_);
        dbms_output.put_line('SET DEFAULT SITE 046'||user_.userid);
        USER_ALLOWED_SITE_API.NEW__(info_,objid_,objversion_,attr_,'DO');
END IF;
----------------------------------------------------------------------
--------------------SET default site---------------------------------
  IF NOT (User_Allowed_Site_API.Check_Default_Site(user_.userid,'041') OR User_Allowed_Site_API.Check_Default_Site(user_.userid,'042') OR User_Allowed_Site_API.Check_Default_Site(user_.userid,'044') OR User_Allowed_Site_API.Check_Default_Site(user_.userid,'045') OR User_Allowed_Site_API.Check_Default_Site(user_.userid,'046')) THEN
        info_        :='';
        input_default_site_ := '&df_site_';
        SELECT objid INTO objid_ FROM USER_ALLOWED_SITE WHERE  USERID=user_.userid AND CONTRACT=input_default_site_;
        SELECT objversion INTO objversion_ FROM USER_ALLOWED_SITE WHERE  USERID=user_.userid AND CONTRACT=input_default_site_;
        Client_SYS.Clear_Attr(attr_);
        Client_SYS.Add_To_Attr('USER_SITE_TYPE_DB', 'DEFAULT SITE', attr_);
        dbms_output.put_line('SET DEFAULT SITE SET'||input_default_site_||' '||user_.userid);
        USER_ALLOWED_SITE_API.MODIFY__(info_,objid_,objversion_,attr_,'DO');
  END IF;
  ---------------------------------------------------------------------
------------------Remove other sites---------------------------------
  FOR site_ IN site_user(user_.userid) LOOP
    IF NOT (site_.CONTRACT='041' OR site_.CONTRACT='042' OR site_.CONTRACT='044' OR site_.CONTRACT='045' OR site_.CONTRACT='046') THEN 
    info_        :='';  
    dbms_output.put_line('remove SITE : '||site_.CONTRACT);
    USER_ALLOWED_SITE_API.REMOVE__(info_,site_.objid,site_.objversion,'DO');
    END IF;
	
	
  END LOOP;
  ---------------------------------------------------------------------
COMMIT;
END LOOP;
EXCEPTION 
	WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/