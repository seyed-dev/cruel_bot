local function run(msg, matches)
if is_sudo then
if matches[1] == 'import' then
tg.importChatInviteLink('https://telegram.me/joinchat/'..matches[2])
elseif matches[1] == 'setbotname' then
if matches[3] then
text = "نام ربات به "..matches[2]..matches[3].." تغییر یافت."
tg.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
tg.changeName(matches[2], matches[3])
else
text = "نام ربات به "..matches[2].." تغییر یافت."
tg.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
tg.changeName(matches[2], '')
end
elseif matches[1] == 'setbotusername' then
tg.changeUsername(matches[2])
elseif matches[1] == 'rembotusername' then
tg.changeUsername('')
elseif matches[1] == 'setbotphoto' then
tg.sendMessage(msg.chat_id_, 0, 1, 'لطفا تصویر را ارسال کنید.', 1, 'html')
redis:set('botphoto','yes')
elseif matches[1] == 'photo' and redis:get('botphoto') then
local file = 'bot/photos/bot.jpg'
print('File downloaded to:', msg.content_.photo_.sizes_[0].photo_.path_)
os.rename(msg.content_.photo_.sizes_[0].photo_.path_, file)
print('File moved to:', file)
tg.setProfilePhoto(msg.content_.photo_.sizes_[0].photo_.path_)
redis:del('botphoto',true)
end
if matches[1] == 'markread' then
if matches[2] == 'on' then
text = '<b> Mark Read => on</b>'
	tg.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
redis:set('markread','on')
elseif matches[2] == 'off' then
text = '<b> Mark Read => off</b>'
	tg.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
redis:set('markread','off')
end
end
end
end
return {
  patterns = {
    "^[#!/](import) https://telegram.me/joinchat/(.*)$",
	"^[#!/](setbotname) (.*) (.*)$",
	"^[#!/](setbotname) (.*)$",
	"^[#!/](setbotusername) (.*)$",
	"^[#!/](rembotusername)$",
	"^[#!/](setbotphoto)$",
    "^[#!/](markread) (.*)$",
	"^!!!edit:[#!/](markread) (.*)$",
	"^!!!(photo):$",
  },
  run = run
}