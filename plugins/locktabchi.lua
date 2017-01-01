local function run(msg, matches)
--@ThinkTeam
  if msg.text:match('^lock tabchi$') and is_sudo(msg) then
    redis:set('ltabchi'..msg.chat_id_,true)
    tg.sendMessage(msg.chat_id_, 0, 0,  'از این به بعد اکانت های مشکوک به تبچی بودن مسدود میشوند', 0)
  elseif msg.text:match('^unlock tabchi$') and is_sudo(msg) then
    redis:del('ltabchi'..msg.chat_id_)
    tg.sendMessage(msg.chat_id_, 0, 0,  'استفاده از تبچی آزاد شد', 0)
  end
  
  local texts = {'ادی بیا پی وی','اددی','Addi','Bia Pv','addi','bia pv'}
  if msg.text:match(texts) and redis:get('ltabchi'..chat_id) and msg.reply_to_message_id_ and not is_sudo(msg) then
    tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
  end
end
--@ShopBuy
return {
  patterns = {
    "^[#!/](lock tabchi)$",
    "^[#!/](unlock tabchi)$",
    "(.*)"
  },
  run = run
}
--Dadach Namusan Esm Maro Napak :| #SikTirMirza
