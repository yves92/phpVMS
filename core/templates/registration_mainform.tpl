<h3>Registration</h3>
<p>Welcome to the registration form for <?php echo SITE_NAME; ?>. After you register, you will be notified by a staff member about your membership.</p>
<form method="post" action="<?php echo SITE_URL?>/index.php/Registration">
<dl>
	<dt>First Name: *</dt>
	<dd><input type="text" name="firstname" value="<?php echo Vars::POST('firstname');?>" />
		<?php
			if($firstname_error == true)
				echo '<p class="error">Please enter your first name</p>';
		?>
	</dd>
	
	<dt>Last Name: *</dt>
	<dd><input type="text" name="lastname" value="<?php echo Vars::POST('lastname');?>" />
		<?php
			if($lastname_error == true)
				echo '<p class="error">Please enter your last name</p>';
		?>
	</dd>
	
	<dt>Email Address: *</dt>
	<dd><input type="text" name="email" value="<?php echo Vars::POST('email');?>" />
		<?php
			if($email_error == true)
				echo '<p class="error">Please enter your email address</p>';
		?>
	</dd>
	
	<dt>Select Airline: *</dt>
	<dd>
		<select name="code" id="code">
		<?php
		foreach($allairlines as $airline)
		{
			echo '<option value="'.$airline->code.'">'.$airline->name.'</option>';
		}
		?>
		</select>
	</dd>
	
	<dt>Hub: *</dt>
	<dd>
		<select name="hub" id="hub">
		<?php
		foreach($allhubs as $hub)
		{
			echo '<option value="'.$hub->icao.'">'.$hub->icao.' - ' . $hub->name .'</option>';
		}
		?>
		</select>
	</dd>

	<dt>Location: *</dt>
	<dd><select name="location">
		<?php
			foreach($countries as $countryCode=>$countryName)
			{
				if(Vars::POST('location') == $countryCode)
					$sel = 'selected="selected"';
				else	
					$sel = '';
					
				echo '<option value="'.$countryCode.'" '.$sel.'>'.$countryName.'</option>';
			}
		?>
		</select>
		<?php
			if($location_error == true)
				echo '<p class="error">Please enter your location</p>';
		?>
	</dd>
	
	<dt>Password: *</dt>
	<dd><input id="password" type="password" name="password1" value="" /></dd>
	
	<dt>Enter your password again: *</dt>
	<dd><input type="password" name="password2" value="" />
		<?php
			if($password_error != '')
				echo '<p class="error">'.$password_error.'</p>';
		?>
	</dd>
		
	<?php
	
	//Put this in a seperate template. Shows the Custom Fields for registration
	Template::Show('registration_customfields.tpl');
	
	?>
	
	<dt>What does this add up to? <?php echo $rand1 .' + '.$rand2?></dt>
	<dd><input id="password" type="captcha" name="captcha" value="" />
		<?php
			if($captcha_error != '')
				echo '<p class="error">'.$captcha_error.'</p>';
		?>
	</dd>
		
	<dt></dt>
	<dd><p>By clicking register, you're agreeing to the terms and conditions</p></dd>
	<dt></dt>
	<dd><input type="submit" name="submit" value="Register!" /></dd>
</dl>
</form>
