_addon.name = 'JobChange'
_addon.author = 'Sammeh (Ported by Shinzaku)'
_addon.version = '1.0'

require('common');

-- 1.0.1 first release
-- 1.0.2 added 'reset' command to simply reset to existing job.  Changes sub job to a random starting job and back.

require 'common'

function jobchange(job,main_sub)
	print("JobChange: Changing "..main_sub.." job to:".. getJobName(job))
	if job and main_sub then 
		if main_sub == 'main' then 
			local packet = struct.pack('bbbbbbbb', 0x100, 0x03, 0x00, 0x00, job, 0, 0, 0):totable();
			AddOutgoingPacket(0x100, packet);
		elseif main_sub == 'sub' then			
			local packet = struct.pack('bbbbbbbb', 0x100, 0x03, 0x00, 0x00, 0, job, 0, 0):totable();
			AddOutgoingPacket(0x100, packet);
		end
	end
end

function getJobID(job)
	if job == "WAR" then
		return 1;
	elseif job == "MNK" then
		return 2;
	elseif job == "WHM" then
		return 3;
	elseif job == "BLM" then
		return 4;
	elseif job == "RDM" then
		return 5;
	elseif job == "THF" then
		return 6;
	elseif job == "PLD" then
		return 7;
	elseif job == "DRK" then
		return 8;
	elseif job == "BST" then
		return 9;
	elseif job == "BRD" then
		return 10;
	elseif job == "RNG" then
		return 11;
	elseif job == "SAM" then
		return 12;
	elseif job == "NIN" then
		return 13;
	elseif job == "DRG" then
		return 14;
	elseif job == "SMN" then
		return 15;
	elseif job == "BLU" then
		return 16;
	elseif job == "COR" then
		return 17;
	elseif job == "PUP" then
		return 18;
	elseif job == "DNC" then
		return 19;
	elseif job == "SCH" then
		return 20;
	elseif job == "GEO" then
		return 21;
	elseif job == "RUN" then
		return 22;
	end;
end;

function getJobName(jobid)
	if jobid == 1 then
		return "WAR";
	elseif jobid == 2 then
		return "MNK";
	elseif jobid == 3 then
		return "WHM";
	elseif jobid == 4 then
		return "BLM";
	elseif jobid == 5 then
		return "RDM";
	elseif jobid == 6 then
		return "THF";
	elseif jobid == 7 then
		return "PLD";
	elseif jobid == 8 then
		return "DRK";
	elseif jobid == 9 then
		return "BST";
	elseif jobid == 10 then
		return "BRD";
	elseif jobid == 11 then
		return "RNG";
	elseif jobid == 12 then
		return "SAM";
	elseif jobid == 13 then
		return "NIN";
	elseif jobid == 14 then
		return "DRG";
	elseif jobid == 15 then
		return "SMN";
	elseif jobid == 16 then
		return "BLU";
	elseif jobid == 17 then
		return "COR";
	elseif jobid == 18 then
		return "PUP";
	elseif jobid == 19 then
		return "DNC";
	elseif jobid == 20 then
		return "SCH";
	elseif jobid == 21 then
		return "GEO";
	elseif jobid == 22 then
		return "RUN";
	end;
end;

ashita.register_event('command', function(cmd, nType)
	-- Get the command arguments..
    local args = cmd:args();
	local command = args[2];
	local job = ''
	if args[3] then 
		job = args[3]:lower()
	end
	local currentjob = AshitaCore:GetDataManager():GetPlayer():GetMainJob();
	local main_sub = ''
	if (args[1] == "/jc") then
		if command:lower() == 'main' then
			main_sub = 'main'
		elseif command:lower() == 'sub' then
			main_sub = 'sub'
		elseif command:lower() == 'reset' then
			print("JobChange: Resetting Job")
			main_sub = 'sub'
			job = getJobName(AshitaCore:GetDataManager():GetPlayer():GetSubJob());
		else
			print("JobChange Syntax: /jc main|sub JOB  -- Chnages main or sub to target JOB")
			print("JobChange Syntax: /jc reset -- Resets Current Job")
			return
		end
		local conflict = find_conflict(job)
		local jobid = find_job(job)
		if jobid then 
			local npc = find_job_change_npc()
			if npc then
				if not conflict then 
					jobchange(jobid,main_sub)
				else
					local temp_job = find_temp_job()			
					print("JobChange: Conflict with "..conflict)
					if main_sub == conflict then 
						jobchange(temp_job,main_sub)
						jobchange(jobid,main_sub)
					else
						jobchange(temp_job,conflict)
						jobchange(jobid,main_sub)
					end
				end
			else
				print("JobChange: Not close enough to a Moogle!")
			end		
		else
			print("JobChange: Could not change "..command.." to "..job:upper().." ---Mistype|NotUnlocked")
		end
		
		return true;
	end;
	
	return false;
end)

function find_conflict(job)
	local self = AshitaCore:GetDataManager():GetPlayer();
	if getJobName(self:GetMainJob()) == job:upper() then
		return "main"
	end
	if getJobName(self:GetSubJob()) == job:upper() then
		return "sub"
	end
end

function find_temp_job()
	local starting_jobs = {
	-- WAR, MNK, WHM, BLM, THF, RDM - main starting jobs.
		["WAR"] = 1,
		["MNK"] = 2,
		["WHM"] = 3,
		["BLM"] = 4,
		["RDM"] = 5,
		["THF"] = 6,
	}
	for index,value in pairs(starting_jobs) do
		if not find_conflict(index) then 
			return value
		end
	end
end

function find_job(job)
	local self = AshitaCore:GetDataManager():GetPlayer();
	
	--[[
		Small rant/request/can't figure out a better way.
		windower.ffxi.get_player().jobs includes all jobs regardless if you have it unlocked.  I expected self.jobs["GEO"] to be nil if I didn't have it.  For now going to use a list of the KI's for 
		Job emotes to see which jobs are unlocked. 
	]]	
	local job_gesture_ids = {
		-- Pulled from resources. 12/26/2016
		["WAR"] = 1738,
		["MNK"] = 1739,
		["WHM"] = 1740,
		["BLM"] = 1741,
		["RDM"] = 1742,
		["THF"] = 1743,
		["PLD"] = 1744,
		["DRK"] = 1745,
		["BST"] = 1746,
		["BRD"] = 1747,
		["RNG"] = 1748,
		["SAM"] = 1749,
		["NIN"] = 1750,
		["DRG"] = 1751,
		["SMN"] = 1752,
		["BLU"] = 1753,
		["COR"] = 1754,
		["PUP"] = 1755,
		["DNC"] = 1756,
		["SCH"] = 1757,
		["GEO"] = 2963,
		["RUN"] = 2964,
	}
	local job_gesture = job_gesture_ids[job:upper()]
	if self:HasKeyItem(job_gesture) then
		return getJobID(job:upper());
	end;
end


function find_job_change_npc()
	found = nil
	-- local valid_zones = { 
		-- -- Zones with a nomad moogle / green thumb moogle, taken from Resources
		-- -- All other zones check if mog_house
		-- [26] = {id=26,en="Tavnazian Safehold",ja="タブナジア地下壕",search="TavSafehld"},
		-- [53] = {id=53,en="Nashmau",ja="ナシュモ",search="Nashmau"},
		-- [247] = {id=247,en="Rabao",ja="ラバオ",search="Rabao"},
		-- [248] = {id=248,en="Selbina",ja="セルビナ",search="Selbina"},
		-- [249] = {id=249,en="Mhaura",ja="マウラ",search="Mhaura"},
		-- [250] = {id=250,en="Kazham",ja="カザム",search="Kazham"},
		-- [252] = {id=252,en="Norg",ja="ノーグ",search="Norg"},	
	-- }
	-- local zone = AshitaCore:GetDataManager():GetParty():GetMemberZone(0);
	-- if not (valid_zones[zone] or info['mog_house']) then
		-- print('JobChange: Not in a zone with a Change NPC')
		-- return
	-- end
	
	for x = 0, 2303 do
		local e = GetEntity(x);
		if (e ~= nil and e.WarpPointer ~= 0) then
			if e.Name == "Nomad Moogle" or e.Name == "Green Thumb Moogle" or e.Name == "Pilgrim Moogle" then
				found = 1;
				target_index = e.TargetIndex;
				target_id = e.ServerId;
				npc_name = e.Name;
				distance = e.Distance;
				
				if math.sqrt(distance) < 6 then
					return found;
				end;
			end;
		end;
	end;
end
