
local function run(msg, matches)
if not msg.chat_id_ and redis:get('demoteuser2') then
msg.chat_id_ = redis:get('demoteuser2')
end
if not msg.chat_id_ and redis:get('promoteuser2') then
msg.chat_id_ = redis:get('promoteuser2')
end
if not msg.chat_id_ and redis:get('setowneruser2') then
msg.chat_id_ = redis:get('setowneruser2')
end
if not msg.chat_id_ and redis:get('muteuser2') then
msg.chat_id_ = redis:get('muteuser2')
end
local group = load_data('bot/group.json')
local addgroup = group[tostring(msg.chat_id_)]
local setowner = redis:get('setowner'..msg.chat_id_) 
local promote = redis:get('promote'..msg.chat_id_)
local demote = redis:get('demote'..msg.chat_id_)
local muteuser = redis:get('muteuser'..msg.chat_id_..msg.chat_id_)
if addgroup then
    if matches[1] == 'owner' then
	 pm = group[tostring(msg.chat_id_)]['set_owner']
	 tg.sendMessage(msg.chat_id_, 0, 1,'owner['..pm..']', 1, 'html')
	end
    if setowner then
         group[tostring(msg.chat_id_)]['set_owner'] = tostring(msg.from_id)
         save_data(_config.group.data, group)
         tg.sendMessage(msg.chat_id, 0, 0,  '[ '..msg.from_id..' ] added as owner', 0)
		 redis:del('setowner'..msg.chat_id_ ,true)
    end
if promote then
		redis:del('promote'..msg.chat_id_ ,true)
		user_id = msg.from_id
		if group[msg.chat_id_]['moderators'][tostring(user_id)] then
			tg.sendMessage(msg.chat_id_, 0, 1,user_id..' is already a moderator.', 1, 'html')
        else
            group[msg.chat_id_]['moderators'][tostring(user_id)] = user_id
            save_data(_config.group.data, group)
			tg.sendMessage(msg.chat_id_, 0, 1,user_id..' has been promoted.', 1, 'html')
    	end
    end
if muteuser then
redis:del('muteuser'..msg.chat_id_..msg.chat_id_ ,true)
local user_id = msg.from_id
		if is_muted_user(msg.chat_id_, user_id) then
			unmute_user(msg.chat_id_, user_id)
			tg.sendMessage(msg.chat_id_, 0, 1,"["..user_id.."] removed from the muted users list", 1, 'html')
        else
             mute_user(msg.chat_id_, user_id)
			tg.sendMessage(msg.chat_id_, 0, 1,'['..user_id..'] added to the muted user list', 1, 'html')
		end
end
if demote then
		redis:del('demote'..msg.chat_id_ ,true)
		user_id = msg.from_id
		if not group[msg.chat_id_]['moderators'][tostring(user_id)] then
			tg.sendMessage(msg.chat_id_, 0, 1,msg.from_id..' is not a moderator.', 1, 'html')
        else
            group[msg.chat_id_]['moderators'][tostring(user_id)] = nil
            save_data(_config.group.data, group)
			tg.sendMessage(msg.chat_id_, 0, 1,user_id..' has been demoted.', 1, 'html')
		end
    end
	if matches[1] == 'setowner' and is_owner(msg) then
	if msg.reply_to_message_id_ ~= 0 then
		tg.getMessage(msg.chat_id_,msg.reply_to_message_id_)
		redis:set('setowner'..msg.chat_id_,msg.from_id)
		redis:set('message:tg','setowner')
	elseif msg.text:match("@(.*)") then
	    redis:set('setowneruser'..msg.chat_id_,'yes')
		redis:set('setowneruser2',msg.chat_id_)
		redis:set('message:tg','setowner')
		tg.searchPublicChat(matches[2])
	elseif tonumber(matches[2]) then
	     group[tostring(msg.chat_id_)]['set_owner'] = matches[2]
             save_data(_config.group.data, group)
         tg.sendMessage(msg.chat_id, 0, 0,  '[ '..matches[2]..' ] added as owner', 0)
	end
	end
if matches[1] == 'ownerset2' then
	if redis:get('demoteuser'..msg.chat_id_) then
	    redis:del('demoteuser'..msg.chat_id_,true)
		redis:del('demoteuser2',true)
		local user_id = msg.from_id
		if not group[msg.chat_id_]['moderators'][tostring(user_id)] then
			tg.sendMessage(msg.chat_id_, 0, 1,msg.from_id..' is not a moderator.', 1, 'html')
        else
            group[msg.chat_id_]['moderators'][tostring(user_id)] = nil
            save_data(_config.group.data, group)
			tg.sendMessage(msg.chat_id_, 0, 1,user_id..' has been demoted.', 1, 'html')
		end
	end
	if redis:get('muteuser'..msg.chat_id_) then
	    redis:del('muteuser'..msg.chat_id_,true)
		redis:del('muteuser2',true)
		local user_id = msg.from_id
		if is_muted_user(msg.chat_id, user_id) then
			unmute_user(msg.chat_id_, user_id)
			tg.sendMessage(msg.chat_id_, 0, 1,"["..user_id.."] removed from the muted users list", 1, 'html')
        else
             mute_user(msg.chat_id_, user_id)
			tg.sendMessage(msg.chat_id_, 0, 1,'['..user_id..'] added to the muted user list', 1, 'html')
		end
	end
	if redis:get('setowneruser'..msg.chat_id_) then
	    redis:del('setowneruser'..msg.chat_id_,true)
		redis:del('setowneruser2',true)
		local user_id = msg.from_id
        group[tostring(msg.chat_id_)]['set_owner'] = user_id
        save_data(_config.group.data, group)
	    tg.sendMessage(msg.chat_id_, 0, 1,'[ '..msg.from_id..' ] added as owner', 1, 'html')
	end
	if redis:get('promoteuser'..msg.chat_id_) then
	    redis:del('promoteuser'..msg.chat_id_,true)
		redis:del('promoteuser2',true)
		local user_id = msg.from_id
		if group[msg.chat_id_]['moderators'][tostring(user_id)] then
			tg.sendMessage(msg.chat_id_, 0, 1,user_id..' is already a moderator.', 1, 'html')
        else
            group[msg.chat_id_]['moderators'][tostring(user_id)] = user_id
            save_data(_config.group.data, group)
			tg.sendMessage(msg.chat_id_, 0, 1,user_id..' has been promoted.', 1, 'html')
    	end
	end

end
if matches[1] == 'promote' and is_owner(msg) then
	if msg.reply_to_message_id_ ~= 0 then
		tg.getMessage(msg.chat_id_,msg.reply_to_message_id_)
		redis:set('promote'..msg.chat_id_,msg.from_id)
		redis:set('message:tg','setowner')
	elseif msg.text:match("@(.*)") then
	    redis:set('promoteuser'..msg.chat_id_,'yes')
		redis:set('promoteuser2',msg.chat_id_)
		redis:set('message:tg','setowner')
		tg.searchPublicChat(matches[2])
	elseif tonumber(matches[2]) then
	    user_id = matches[2]
        if group[msg.chat_id_]['moderators'][tostring(user_id)] then
			tg.sendMessage(msg.chat_id_, 0, 1,user_id..' is already a moderator.', 1, 'html')
        else
            group[msg.chat_id_]['moderators'][tostring(user_id)] = user_id
            save_data(_config.group.data, group)
			tg.sendMessage(msg.chat_id_, 0, 1,user_id..' has been promoted.', 1, 'html')
    	end
	end
	end
if matches[1] == 'muteuser' and is_momod(msg) then
if msg.reply_to_message_id_ ~= 0 then
		tg.getMessage(msg.chat_id_,msg.reply_to_message_id_)
		redis:set('muteuser'..msg.chat_id_..msg.chat_id_,msg.from_id)
		redis:set('message:tg','setowner')
	elseif msg.text:match("@(.*)") then
	    redis:set('muteuser'..msg.chat_id_,'yes')
		redis:set('muteuser2',msg.chat_id_)
		redis:set('message:tg','setowner')
		tg.searchPublicChat(matches[2])
	elseif tonumber(matches[2]) then
	    local user_id = matches[2]
		if is_muted_user(msg.chat_id_, user_id) then
			unmute_user(msg.chat_id_, user_id)
			tg.sendMessage(msg.chat_id_, 0, 1,"["..user_id.."] removed from the muted users list", 1, 'html')
        else
             mute_user(msg.chat_id_, user_id)
			tg.sendMessage(msg.chat_id_, 0, 1,'['..user_id..'] added to the muted user list', 1, 'html')
		end
	end
	end
if matches[1] == 'demote' and is_owner(msg) then
	if msg.reply_to_message_id_ ~= 0 then
		tg.getMessage(msg.chat_id_,msg.reply_to_message_id_)
		redis:set('demote'..msg.chat_id_,msg.from_id)
		redis:set('message:tg','setowner')
	elseif tonumber(matches[2]) then
	    local user_id = matches[2]
		if not group[msg.chat_id_]['moderators'][tostring(user_id)] then
			tg.sendMessage(msg.chat_id_, 0, 1,msg.from_id..' is not a moderator.', 1, 'html')
        else
            group[msg.chat_id_]['moderators'][tostring(user_id)] = nil
            save_data(_config.group.data, group)
			tg.sendMessage(msg.chat_id_, 0, 1,user_id..' has been demoted.', 1, 'html')
		end
	elseif msg.text:match("@(.*)") then
	    redis:set('demoteuser'..msg.chat_id_,'yes')
		redis:set('demoteuser2',msg.chat_id_)
		redis:set('message:tg','setowner')
		tg.searchPublicChat(matches[2])
	end
	end

end
end
return {
  patterns = {
    "^[#!/](setowner)$",
 "^[#!/](owner)$",
 "^[#!/](modlist)$",
	"^[#!/](setowner) (.+)$",
    "^[#!/](promote)$",
	"^[#!/](promote) (.+)$",
    "^[#!/](demote)$",
	"^[#!/](demote) (.+)$",
	"^[#!/](muteuser)$",
	"^[#!/](muteuser) (.+)$",
	"^(ownerset)$",
	"^!!(ownerset2)!!$",
  },
  run = run
}
