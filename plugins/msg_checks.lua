local function run(msg, matches)
local group = load_data('bot/group.json')
local addgroup = group[tostring(msg.chat_id)]
if addgroup then
if is_momod(msg) or is_robot(msg) then
return false
else
local group_mute_all = group[tostring(msg.chat_id)]['settings']['mute_all']
if group_mute_all == 'yes' then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_mute_photo = group[tostring(msg.chat_id)]['settings']['mute_photo']
local is_photo_msg = msg.text:match("!!!photo:")
if group_mute_photo == 'yes' and is_photo_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_lock_english = group[tostring(msg.chat_id)]['settings']['lock_english']
local is_english_msg = msg.text:match("[a-z]") or msg.text:match("[A-Z]")
local is_not_english_msg = msg.text:match("!!!photo:") or msg.text:match("!!!tgservice:") or msg.text:match("!!!edit:") or msg.text:match("!!!video:") or msg.text:match("!!!audio:") or msg.text:match("!!!voice:") or msg.text:match("!!!document:")
if group_lock_english == 'yes' and is_english_msg and not is_not_english_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_lock_persian = group[tostring(msg.chat_id)]['settings']['lock_persian']
local is_persian_msg = msg.text:match("[\216-\219][\128-\191]")
if group_lock_persian == 'yes' and is_persian_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_lock_tgservice = group[tostring(msg.chat_id)]['settings']['lock_tgservice']
local is_tgservice_msg = msg.text:match("!!!tgservice:")
if group_lock_tgservice == 'yes' and is_persian_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_lock_tgservice = group[tostring(msg.chat_id)]['settings']['lock_sticker']
local is_tgservice_msg = msg.text:match("!!!sticker:")
if group_lock_tgservice == 'yes' and is_persian_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_lock_spam = group[tostring(msg.chat_id)]['settings']['lock_spam']
local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
local _nl, real_digits = string.gsub(msg.text, '%d', '')
if group_lock_spam == "yes" and string.len(msg.text) > 2049 or ctrl_chars > 40 or real_digits > 2000 then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_mute_photo = group[tostring(msg.chat_id)]['settings']['mute_video']
local is_video_msg = msg.text:match("!!!video:")
if group_mute_video == 'yes' and is_video_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_mute_photo = group[tostring(msg.chat_id)]['settings']['mute_voice']
local is_video_msg = msg.text:match("!!!voice:")
if group_mute_video == 'yes' and is_video_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_mute_photo = group[tostring(msg.chat_id)]['settings']['mute_document']
local is_video_msg = msg.text:match("!!!document:")
if group_mute_video == 'yes' and is_video_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_mute_photo = group[tostring(msg.chat_id)]['settings']['mute_gif']
local is_video_msg = msg.text:match("!!!gif:")
if group_mute_video == 'yes' and is_video_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_mute_photo = group[tostring(msg.chat_id)]['settings']['mute_audio']
local is_video_msg = msg.text:match("!!!audio:")
if group_mute_video == 'yes' and is_video_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_link_lock = group[tostring(msg.chat_id)]['settings']['lock_link']
local is_link_msg = msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
if is_link_msg and group_link_lock == 'yes'then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_edit_lock = group[tostring(msg.chat_id)]['settings']['lock_edit']
local is_edit_msg = msg.text:match("!!!edit:")
if group_edit_lock == 'yes' and is_edit_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_fwd_lock = group[tostring(msg.chat_id)]['settings']['lock_fwd']
if group_fwd_lock == 'yes' and msg.forward_info_ ~= false then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
local group_username_lock = group[tostring(msg.chat_id)]['settings']['lock_username']
local is_username_msg = msg.text:match("@")
if group_username_lock == 'yes' and is_username_msg then
tg.deleteMessages(msg.chat_id_, {[0] = msg.id_ })
end
end
end
end
return {
  patterns = {
    "^(.*)$",
  },
  run = run
}
