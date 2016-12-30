
local function run(msg, matches)
if is_sudo then
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
return {
  patterns = {
    "^[#!/](markread) (.*)$",
	"^!!!edit:[#!/](markread) (.*)$",
  },
  run = run
}