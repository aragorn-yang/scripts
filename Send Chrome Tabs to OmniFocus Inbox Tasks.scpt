--============================================================
-- OmniFocus > Send Chrome Tabs to OmniFocus Inbox Tasks
-- Written By: Aragorn Yang <aragorn.yang@gmail.com>
-- Version: 1.0 (2019.01.16)
-- Description: This script sends each of chrome tabs to OmniFocus Inbox as an individual task

-- UPDATE NOTICES
-- ** Follow @AragornYang on Twitter for Update Notices! **

-- CHANGELOG
-- 1.00 - Initial release

my main()

on main()
	set tabList to {}
	
	tell application "Google Chrome"
		
		set chromeWindow to the front window
		set tabCount to (count of (tabs of chromeWindow))
		set successCount to 0
		
		--try
		repeat with t in (tabs of chromeWindow)
			copy {tabTitle:(title of t), tabURL:(URL of t)} to the end of tabList
		end repeat
		--end try
	end tell
	
	tell front document of application "OmniFocus"
		repeat with tab in tabList
			make new inbox task with properties {name:(tabTitle of tab) as text, note:(tabURL of tab) as text}
			--INCREMENT SUCCESS COUNT
			set successCount to (successCount + 1)
		end repeat
	end tell
	
	my notify(successCount, tabCount)
end main

on notify(successCount, itemNum)
	set scriptTitle to "Send Chrome Tabs to OmniFocus Inbox Tasks"
	set scriptSubTitle to "aragorn.yang@gmail.com"
	set Plural_Test to (successCount) as number
	
	if Plural_Test is -1 then
		display notification "No Tabs Exported!" with title scriptTitle subtitle scriptSubTitle
		
	else if Plural_Test is 0 then
		display notification "No Tabs Exported!" with title scriptTitle subtitle scriptSubTitle
		
	else if Plural_Test is equal to 1 then
		display notification "Successfully Exported " & itemNum & ¬
			" Tab to OmniFocus" with title scriptTitle subtitle scriptSubTitle
		
	else if Plural_Test is greater than 1 then
		display notification "Successfully Exported " & itemNum & ¬
			" Tabs to OmniFocus" with title scriptTitle subtitle scriptSubTitle
	end if
	
	set itemNum to "0"
	delay 1
end notify
