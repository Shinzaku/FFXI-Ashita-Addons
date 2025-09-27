--[[
Copyright (c) 2017, Shinzaku
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:
1. Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
3. Neither the name of the copyright holder nor the names of its
contributors may be used to endorse or promote products derived from
this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]

-- addon information

_addon.name = 'sendall'
_addon.version = '1.0'
_addon.author = 'Shinzaku'

-- modules

require 'common'

-- filter helper functions
local currPlayer;
local queueNames = {};
local currCmd;
local __lclock, __sendclock = 0,0;
local __cycle = 1;

local partyList = { "", "", "", "" };

ashita.register_event('load', function(cmd, nType)	
	currPlayer = AshitaCore:GetDataManager():GetParty():GetMemberName(0);
end );

ashita.register_event('render', function()
	-- Create a timer and attempt to use a key on a chest
	if (table.getn(queueNames) ~= nil and table.getn(queueNames) > 0) then
		__sendclock = os.clock() - __lclock;
		if(__cycle == 1 and __sendclock >= 1.0) then
            sendCmd(queueNames[1]);
			table.remove(queueNames, 1);
			
			__lclock = os.clock();
		elseif (__cycle == 0) then
            sendCmd(queueNames[1]);
			table.remove(queueNames, 1);
        end
	else
		__lclock = os.clock();
	end;
end);

function addToQueue(name)
	table.insert(queueNames, name);
end;

function sendCmd(name)		
	if (name ~= currPlayer) then
		AshitaCore:GetChatManager():QueueCommand("/ms sendto " .. name .. " " .. currCmd, 1);	
	else
		AshitaCore:GetChatManager():QueueCommand(currCmd, 1);	
	end;
end;

ashita.register_event('command', function(command, nType)
	-- Get the command arguments..
    local args = command:args();
	local EntityManager = AshitaCore:GetDataManager():GetEntity();
	local Party = AshitaCore:GetDataManager():GetParty();
	
	if (#args >= 2) then
		if (args[1] == "/sendall") then		
			table.remove(args, 1);
			currCmd = table.concat(args," ");
			__cycle = 1;

			for i = 1, #partyList do
				addToQueue(partyList[i]);
			end;
			
			return true;
		end;
	end;
    return false;
end);
