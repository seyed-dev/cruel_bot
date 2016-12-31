local function run(msg, matches)

  if matches[1] == 'addword' and is_sudo(msg) then
    redis:set('filter'..msg.chat_id_,matches[2])
    tg.sendMessage(msg.chat_id_, 0, 0,  'Word Has Been Blocked', 0)
  elseif matches[1] == 'rw' and is_sudo(msg) then
    redis:del('filter'..msg.chat_id_,matches[2])
    tg.sendMessage(msg.chat_id_, 0, 0,  'Word Has Been UnBlocked', 0)
  end
  local badword = redis:get('filter'..msg.chat_id_)
  
  if msg.text:match(badword) and not is_sudo(msg) then
    tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
  end
end
return {
  patterns = {
    "^[#!/](addword) (.*)$",
    "^[#!/](rw) (.*)$",
    "(.*)"
  },
  run = run
}
