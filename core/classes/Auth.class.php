<?php

/**
  * Authentication Module
  *  Handle local login (from a form) and remote login
  * phpVMS
  *
  * @author Nabeel Shahzad
  */
  
class Auth  
{
	public static $init=false;
	public static $loggedin=false;
	public static $error_message;
	
	public static $userid;
	public static $userinfo;
	public static $usergroups;
	
	/**
	 * Constructor.  
	 *
	 * @param 
	 * @return 
	 */
	function StartAuth() 
	{	
		self::$init = true;
		
		if(SessionManager::GetData('loggedin') == true)
		{
			self::$loggedin = true;
			self::$userinfo = SessionManager::GetData('userinfo');
			self::$usergroups = SessionManager::UserGroups('usergroups');
			self::$userid = self::$userinfo->userid;
			
			return true;
		}
		else
		{
			self::$loggedin = false;
			return false;
		}
	}
	
	function Username()
	{
		return self::$userinfo->username;
	}
	
	function DisplayName()
	{
		return self::$userinfo->displayname;
	}
	
	function LoggedIn()
	{
		if(self::$init == false)
		{
			return self::StartAuth();
		}
		
		return self::$loggedin;
	}
	
	function UserInGroup($groupname)
	{
		if(!self::LoggedIn()) return false;
		
		foreach(self::$usergroups as $group)
		{
			if($group->name == $groupname)
				return true;
		}
		
		return false;
	}
	
	function ProcessLogin($emailaddress, $password)
	{
		$emailaddress = DB::escape($emailaddress);
		$password = DB::escape($password);
		
		$sql = 'SELECT * FROM ' . TABLE_PREFIX . 'users
					WHERE email=\''.$emailaddress.'\'';

		$userinfo = DB::get_row($sql);

		if(!is_array($userinfo))
		{
			self::$error_message = 'User does not exist';
			return false;
		}

		//ok now check it
		$hash = md5($password . $userinfo->salt);
		
		if($hash == $userinfo->password)
		{	
			SessionManager::AddData('loggedin', true);	
			SessionManager::AddData('userinfo', $userinfo);
			SessionManager::AddData('usergroups', PilotGroups::GetUserGroups($userinfo->userid));
			
			return true;
		}			
		else 
		{
			// just blank it
			self::$error_message = 'Invalid Password';
			self::LogOut();
			
			return false;
		}
	}
		
	function LogOut()
	{
		SessionManager::AddData('loggedin', false);
		SessionManager::AddData('userinfo', '');
		SessionManager::AddData('usergroups', '');
		
		self::$loggedin = false;
	}
}
?>