local function run(msg, matches)
	if matches[1] == 'bc' and is_sudo(msg) then
		tg.sendMessage(matches[2], 0, 0,  matches[3], 0)
	end
end
return {
  patterns = {
    "^[#!/](bc) (%d+) (.*)$"
  },
  run = run
}
