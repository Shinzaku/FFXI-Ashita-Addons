_addon.author   = 'Shinzaru';
_addon.name     = 'CustomTimers';
_addon.version  = '1.0.0';

require 'common'

local allTimers = {};
local globalTimer = 0;
local globalDelay = 1;

ashita.register_event('incoming_packet', function(id, size, data)

	
    return false;
end);

ashita.register_event('command', function(cmd, nType)
	-- Get the command arguments
    local args = cmd:args();
	
	if (args[1] == "/ctimers" and #args >= 2) then
		local command = args[2];
		
		if (command == "add") then
			if (args[3] == nil or args[4] == nil or args[5] == nil or args[6] == nil) then
				print("Unable to create timer; Missing parameters (Need H M S)");
			else
				local h = tonumber(args[4]);
				local m = tonumber(args[5]);
				local s = tonumber(args[6]);
				local totaltime = (h * 3600) + (m * 60) + s;
				createNewTimer(args[3], totaltime);
			end;
		elseif (command == "del") then
			if (args[3] == nil) then
				print("Unable to delete timer; Missing parameter");
			else
				print("Attempting to remove timer");
				for i=1,#allTimers do
					if (allTimers[i].name == args[3]) then
						allTimers[i].time = 0;
					end;
				end;
			end;
		end;
		
		return true;
	end;
	
    return false;
end);

ashita.register_event('load', function()
	
end);

ashita.register_event('unload', function()
	for i=1,#allTimers do
		AshitaCore:GetFontManager():Delete(allTimers[i].name);
	end;
end);

ashita.register_event('render', function()
	local cleanupList = {};
	if  (os.time() >= (globalTimer + globalDelay)) then
		globalTimer = os.time();	
	
		for i=1,#allTimers do
			allTimers[i].time = allTimers[i].time - 1;
			if (allTimers[i].time <= 0) then
				table.insert(cleanupList, allTimers[i].name);
			end;
		end;
	end;
	
	-- Update timer display
	for i=1,#allTimers do
		local h = allTimers[i].time / 3600;
		local m = (allTimers[i].time % 3600) / 60;
		local s = ((allTimers[i].time % 3600) % 60);
		allTimers[i].timerText:SetText(allTimers[i].name .. "> " .. string.format("%02d:%02d:%02d", h, m, s));
	end;
	
	if (#cleanupList > 0) then
		for i=1,#cleanupList do
			local indexToRemove = 0;
			for x=1,#allTimers do
				if (allTimers[x].name == cleanupList[i]) then
					indexToRemove = x;
				end;
			end;
			
			table.remove(allTimers, indexToRemove);
			AshitaCore:GetFontManager():Delete(cleanupList[i]);
		end;
	end;
	
	-- Post cleanup, reorder them
end);

function createNewTimer(txtName, maxTime)
	local newTimer = AshitaCore:GetFontManager():Create(txtName);

	local fontColor = 0xFFFFFFFF;
	local bgColor = 0xCC000000;
	
	newTimer:SetColor(fontColor);
	newTimer:SetFontFamily("Arial");
	newTimer:SetFontHeight(10);
	newTimer:SetBold(false);
	newTimer:SetPositionX(10);
	newTimer:SetPositionY(50 + (#allTimers * 17));
	newTimer:SetVisibility(true);
	newTimer:GetBackground():SetColor(bgColor);
	newTimer:GetBackground():SetVisibility(true);
	newTimer:SetPadding(1);
	
	
	table.insert(allTimers, { name = txtName, time = maxTime, timerText = newTimer });
end;