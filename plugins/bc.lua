
local function run(msg, matches)
	if matches[1] == 'bc' and is_sudo(msg) then
		tg.sendMessage(matches[2], 0, 0,  matches[3], 0)
	end
	if matches[1] == 'broadcast' and is_sudo(msg) then
		local group = load_data(_config.group.data)
		local text = matches[2]
			for k,v in pairs(group) do
				tg.sendMessage(k, 0, 0,  text, 0)
			end
	end
end
return {
  patterns = {
    "^[#!/](broadcast) (.*)$",
    "^[#!/](bc) (%d+) (.*)$"
  },
  run = run
}
