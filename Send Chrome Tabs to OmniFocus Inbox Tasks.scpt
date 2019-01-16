--============================================================
-- OmniFocus > Send Chrome Tabs to OmniFocus Inbox Tasks
-- Written By: Aragorn Yang <aragorn.yang@gmail.com>
-- Version: 1.0 (2019.01.16)
-- Description: This script sends each of Google Chrome tabs to an OmniFocus Inbox task

-- UPDATE NOTICES
-- ** Follow @AragornYang on Twitter for Update Notices! **

-- CHANGELOG
-- 1.00 - Initial release

main()

on main()
	set tabList to {}
	
	tell application "Google Chrome"
		
		set chromeWindow to the front window
		set tabCount to (count of (tabs of chromeWindow))
		set successCount to 0
		
		repeat with t in (tabs of chromeWindow)
			copy {tabTitle:(title of t), tabURL:(URL of t)} to the end of tabList
		end repeat
	end tell
	
	tell front document of application "OmniFocus"
		repeat with tab in tabList
			set theName to (tabTitle of tab) as text
			set theURL to (tabURL of tab) as text
			make new inbox task with properties {name:("READ " & theName), note:theURL}
			--INCREMENT SUCCESS COUNT
			set successCount to (successCount + 1)
		end repeat
	end tell
	
	notify(successCount, tabCount)
end main

on notify(successCount, tabCount)
	set scriptTitle to "Send Chrome Tabs to OmniFocus Inbox Tasks"
	set scriptSubTitle to "aragorn.yang@gmail.com"
	set Plural_Test to (successCount) as number
	
	if Plural_Test is -1 then
		notify_ay("No Tabs Exported!")
	else if Plural_Test is 0 then
		notify_ay("No Tabs Exported!")
	else if Plural_Test is equal to 1 then
		notify_ay("Successfully Exported " & tabCount & " Tab to OmniFocus")
	else if Plural_Test is greater than 1 then
		notify_ay("Successfully Exported " & tabCount & " Tabs to OmniFocus")
	end if
end notify

on notify_ay(notificationText)
	set scriptTitle to "Send Chrome Tabs to OmniFocus Inbox Tasks"
	set scriptSubTitle to "aragorn.yang@gmail.com"
	display notification notificationText with title scriptTitle subtitle scriptSubTitle
end notify_ay