--============================================================
-- OmniFocus > Send Current Chrome Tab to OmniFocus Inbox Task
-- Written By: Aragorn Yang <aragorn.yang@gmail.com>
-- Version: 1.0 (2019.01.16)
-- Description: This script sends the current Google Chrome chrome tab to an OmniFocus Inbox task

-- UPDATE NOTICES
-- ** Follow @AragornYang on Twitter for Update Notices! **

-- CHANGELOG
-- 1.00 - Initial release

main()

on main()
	set successCount to 0
	
	tell application "Google Chrome"
		set chromeWindow to the front window
		set currentTab to active tab of chromeWindow
		set theURL to (URL of currentTab) as text
		set theName to (title of currentTab) as text
	end tell
	
	tell front document of application "OmniFocus"
		make new inbox task with properties {name:("READ " & theName), note:theURL}
		set successCount to 1
	end tell
	
	notify(successCount)
end main

on notify(successCount)
	set successCount to successCount as number
	if successCount is 1 then
		notify_ay("Successfully Exported One Tab to OmniFocus")
	else
		notify_ay("No Tabs Exported!")
	end if
end notify

on notify_ay(notificationText)
	set scriptTitle to "Send Current Chrome Tab to OmniFocus Inbox Task"
	set scriptSubTitle to "aragorn.yang@gmail.com"
	display notification notificationText as text with title scriptTitle subtitle scriptSubTitle
end notify_ay