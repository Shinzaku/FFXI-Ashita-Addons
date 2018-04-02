
_addon.author   = 'bope || converted by Shinzaku';
_addon.name     = 'chatmod';
_addon.version  = '.2';

require 'common'
require 'imguidef'
require 'helpers.buffs'
require 'helpers.methods'
require 'abilities'
require 'helpers.packethelp'

filter_melee = { ["spikes"] = true, ["addeffect"] = true, ["condense"] = true }
colormode = 1 --1 color list          TODO(,2 job colors)
colors = {["chat"] = 255, ["ppet"] = 15,["opet"] = 255, ["mob"] = 53 ,["mymob"] = 39,["pmob"] = 38,["amob"] = 11}
pcolors = {["self"] = 256,["p1"] = 200,["p2"]  =127,["p3"]  = 141,["p4"]  = 325,["p5"]  = 262,["others"] = 255,
                          ["a10"]= 200,["a11"] =127,["a12"] = 141,["a13"] = 325,["a14"] = 262,["a15"] = 262,
                          ["a20"]= 200,["a21"] =127,["a22"] = 141,["a23"] = 325,["a24"] = 262,["a25"] = 262}

filter = {100,31,4}
ignore = {94,202,310,38,53,170,171,172,173,174,175,176,177,178,565,582}

chatfiltervars = {    ["self"]   = {["start_spell"] = false,["finish_spell"]= false,["melee"] = false,["ws"]= false,["ranged"]= false,["abilities"]= false,["readies"]= false,["effect_wear"]= false},
                       ["party"]  = {["start_spell"] = false,["finish_spell"]= false,["melee"] = false,["ws"]= false,["ranged"]= false,["abilities"]= false,["readies"]= false,["effect_wear"]= false},
                       ["allies"] = {["start_spell"] = false,["finish_spell"]= false,["melee"] = false,["ws"]= false,["ranged"]= false,["abilities"]= false,["readies"]= false,["effect_wear"]= false},
                       ["foe"] = {["start_spell"] = false,["finish_spell"]= false,["melee"] = false,["ws"]= false,["ranged"]= false,["abilities"]= false,["readies"]= false,["effect_wear"]= false},
                       ["other"]  = {["start_spell"] = false,["finish_spell"]= false,["melee"] = false,["ws"]= false,["ranged"]= false,["abilities"]= false,["readies"]= false,["effect_wear"]= false}}

chatfiltervarsGui = {
	-- Editor vars
	["var_ShowEditorWindow"] = {nil, ImGuiVar_BOOLCPP, false},

	-- Filter vars
	["self"] = {
		["start_spell"] = {nil, ImGuiVar_BOOLCPP, false},
		["finish_spell"] = {nil, ImGuiVar_BOOLCPP, false},
		["melee"] = {nil, ImGuiVar_BOOLCPP, false},
		["ws"] = {nil, ImGuiVar_BOOLCPP, false},
		["ranged"] = {nil, ImGuiVar_BOOLCPP, false},
		["abilities"] = {nil, ImGuiVar_BOOLCPP, false},
		["readies"] = {nil, ImGuiVar_BOOLCPP, false},
		["effect_wear"] = {nil, ImGuiVar_BOOLCPP, false}
	},
	["party"] = {
		["start_spell"] = {nil, ImGuiVar_BOOLCPP, false},
		["finish_spell"] = {nil, ImGuiVar_BOOLCPP, false},
		["melee"] = {nil, ImGuiVar_BOOLCPP, false},
		["ws"] = {nil, ImGuiVar_BOOLCPP, false},
		["ranged"] = {nil, ImGuiVar_BOOLCPP, false},
		["abilities"] = {nil, ImGuiVar_BOOLCPP, false},
		["readies"] = {nil, ImGuiVar_BOOLCPP, false},
		["effect_wear"] = {nil, ImGuiVar_BOOLCPP, false}
	},
	["allies"] = {
		["start_spell"] = {nil, ImGuiVar_BOOLCPP, false},
		["finish_spell"] = {nil, ImGuiVar_BOOLCPP, false},
		["melee"] = {nil, ImGuiVar_BOOLCPP, false},
		["ws"] = {nil, ImGuiVar_BOOLCPP, false},
		["ranged"] = {nil, ImGuiVar_BOOLCPP, false},
		["abilities"] = {nil, ImGuiVar_BOOLCPP, false},
		["readies"] = {nil, ImGuiVar_BOOLCPP, false},
		["effect_wear"] = {nil, ImGuiVar_BOOLCPP, false}
	},
	["foe"] = {
		["start_spell"] = {nil, ImGuiVar_BOOLCPP, false},
		["finish_spell"] = {nil, ImGuiVar_BOOLCPP, false},
		["melee"] = {nil, ImGuiVar_BOOLCPP, false},
		["ws"] = {nil, ImGuiVar_BOOLCPP, false},
		["ranged"] = {nil, ImGuiVar_BOOLCPP, false},
		["abilities"] = {nil, ImGuiVar_BOOLCPP, false},
		["readies"] = {nil, ImGuiVar_BOOLCPP, false},
		["effect_wear"] = {nil, ImGuiVar_BOOLCPP, false}
	},
	["other"] = {
		["start_spell"] = {nil, ImGuiVar_BOOLCPP, false},
		["finish_spell"] = {nil, ImGuiVar_BOOLCPP, false},
		["melee"] = {nil, ImGuiVar_BOOLCPP, false},
		["ws"] = {nil, ImGuiVar_BOOLCPP, false},
		["ranged"] = {nil, ImGuiVar_BOOLCPP, false},
		["abilities"] = {nil, ImGuiVar_BOOLCPP, false},
		["readies"] = {nil, ImGuiVar_BOOLCPP, false},
		["effect_wear"] = {nil, ImGuiVar_BOOLCPP, false}
	}
}

----------------------------------------------------------------------------------------------------
-- func: load_settings
-- desc: Loads the Chatmod settings file.
----------------------------------------------------------------------------------------------------
local function load_settings()
    -- TBD
end

---------------------------------------------------------------------------------------------------
-- func: load
-- desc: First called when our addon is loaded.
---------------------------------------------------------------------------------------------------
ashita.register_event('load', function()
    -- Init chatfiltervarsGui
	-- for k, v in pairs(chatfiltervarsGui) do
        -- if (v[2] >= ImGuiVar_CDSTRING) then 
            -- chatfiltervarsGui[k][1] = imgui.CreateVar(chatfiltervarsGui[k][2], chatfiltervarsGui[k][3]);
        -- else
            -- chatfiltervarsGui[k][1] = imgui.CreateVar(chatfiltervarsGui[k][2]);
        -- end
        -- if (#v > 2 and v[2] < ImGuiVar_CDSTRING) then
            -- imgui.SetVarValue(chatfiltervarsGui[k][1], chatfiltervarsGui[k][3]);
        -- end        
    -- end
	
    --Gui_CreateBar("Chat Mod Settings", 100, 100, 225, 350)
    --Gui_Define(" 'Chat Mod Settings' valueswidth=fit color='0 0 153' iconified=true")
    --Self
    local tempvar = ashita.settings.load(_addon.path .. 'settings/chatfilters.json') or {["self"]   = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false},
                                                                                  ["party"]  = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false},
                                                                                  ["allies"] = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false},
                                                                                  ["foe"]    = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false},
                                                                                  ["other"]  = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false}}
    local temp1 = {"self","party","allies","foe","other"}
    local temp2 = {"start_spell","finish_spell","melee","ws","ranged","abilities","readies","effect_wear"}
    for i = 1, #temp1 do
        for j = 1, #temp2 do
            chatfiltervars[temp1[i]][temp2[j]] = tempvar[temp1[i]][temp2[j]];
        end
    end
    -- Gui_NewReadWrite("Chat Mod Settings", "s_ss", 1, chatfiltervars["self"]["start_spell"],"label='Start Spell' group='Self'")
    -- Gui_NewReadWrite("Chat Mod Settings", "s_fs", 1, chatfiltervars["self"]["finish_spell"],"label='Finish Spell' group='Self'")
    -- Gui_NewReadWrite("Chat Mod Settings", "s_m", 1, chatfiltervars["self"]["melee"],"label='Melee' group='Self'")
    -- Gui_NewReadWrite("Chat Mod Settings", "s_ws", 1, chatfiltervars["self"]["ws"],"label='Weapon Skill' group='Self'")
    -- Gui_NewReadWrite("Chat Mod Settings", "s_ra", 1, chatfiltervars["self"]["ranged"],"label='Ranged Attack' group='Self'")
    -- Gui_NewReadWrite("Chat Mod Settings", "s_ab", 1, chatfiltervars["self"]["abilities"],"label='Abilities' group='Self'")
    -- Gui_NewReadWrite("Chat Mod Settings", "s_re", 1, chatfiltervars["self"]["readies"],"label='Readies' group='Self'")
    -- Gui_NewReadWrite("Chat Mod Settings", "s_ew", 1, chatfiltervars["self"]["effect_wear"],"label='Effects wearing' group='Self'")
    -- Gui_Define(string.format(" 'Chat Mod Settings'/Self opened=false"))
    --Party
    -- Gui_NewReadWrite("Chat Mod Settings", "p_ss", 1, chatfiltervars["party"]["start_spell"],"label='Start Spell' group='Party'")
    -- Gui_NewReadWrite("Chat Mod Settings", "p_fs", 1, chatfiltervars["party"]["finish_spell"],"label='Finish Spell' group='Party'")
    -- Gui_NewReadWrite("Chat Mod Settings", "p_m", 1, chatfiltervars["party"]["melee"],"label='Melee' group='Party'")
    -- Gui_NewReadWrite("Chat Mod Settings", "p_ws", 1, chatfiltervars["party"]["ws"],"label='Weapon Skill' group='Party'")
    -- Gui_NewReadWrite("Chat Mod Settings", "p_ra", 1, chatfiltervars["party"]["ranged"],"label='Ranged Attack' group='Party'")
    -- Gui_NewReadWrite("Chat Mod Settings", "p_ab", 1, chatfiltervars["party"]["abilities"],"label='Abilities' group='Party'")
    -- Gui_NewReadWrite("Chat Mod Settings", "p_re", 1, chatfiltervars["party"]["readies"],"label='Readies' group='Party'")
    -- Gui_NewReadWrite("Chat Mod Settings", "p_ew", 1, chatfiltervars["party"]["effect_wear"],"label='Effects wearing' group='Party'")
    -- Gui_Define(string.format(" 'Chat Mod Settings'/Party opened=false"))
    --Allies
    -- Gui_NewReadWrite("Chat Mod Settings", "a_ss", 1, chatfiltervars["allies"]["start_spell"],"label='Start Spell' group='Allies'")
    -- Gui_NewReadWrite("Chat Mod Settings", "a_fs", 1, chatfiltervars["allies"]["finish_spell"],"label='Finish Spell' group='Allies'")
    -- Gui_NewReadWrite("Chat Mod Settings", "a_m", 1, chatfiltervars["allies"]["melee"],"label='Melee' group='Allies'")
    -- Gui_NewReadWrite("Chat Mod Settings", "a_ws", 1, chatfiltervars["allies"]["ws"],"label='Weapon Skill' group='Allies'")
    -- Gui_NewReadWrite("Chat Mod Settings", "a_ra", 1, chatfiltervars["allies"]["ranged"],"label='Ranged Attack' group='Allies'")
    -- Gui_NewReadWrite("Chat Mod Settings", "a_ab", 1, chatfiltervars["allies"]["abilities"],"label='Abilities' group='Allies'")
    -- Gui_NewReadWrite("Chat Mod Settings", "a_re", 1, chatfiltervars["allies"]["readies"],"label='Readies' group='Allies'")
    -- Gui_NewReadWrite("Chat Mod Settings", "a_ew", 1, chatfiltervars["allies"]["effect_wear"],"label='Effects wearing' group='Allies'")
    -- Gui_Define(string.format(" 'Chat Mod Settings'/Allies opened=false"))
    --Foe
    -- Gui_NewReadWrite("Chat Mod Settings", "f_ss", 1, chatfiltervars["foe"]["start_spell"],"label='Start Spell' group='Foes'")
    -- Gui_NewReadWrite("Chat Mod Settings", "f_fs", 1, chatfiltervars["foe"]["finish_spell"],"label='Finish Spell' group='Foes'")
    -- Gui_NewReadWrite("Chat Mod Settings", "f_m", 1, chatfiltervars["foe"]["melee"],"label='Melee' group='Foes'")
    -- Gui_NewReadWrite("Chat Mod Settings", "f_ws", 1, chatfiltervars["foe"]["ws"],"label='Weapon Skill' group='Foes'")
    -- Gui_NewReadWrite("Chat Mod Settings", "f_ra", 1, chatfiltervars["foe"]["ranged"],"label='Ranged Attack' group='Foes'")
    -- Gui_NewReadWrite("Chat Mod Settings", "f_ab", 1, chatfiltervars["foe"]["abilities"],"label='Abilities' group='Foes'")
    -- Gui_NewReadWrite("Chat Mod Settings", "f_re", 1, chatfiltervars["foe"]["readies"],"label='Readies' group='Foes'")
    -- Gui_NewReadWrite("Chat Mod Settings", "f_ew", 1, chatfiltervars["foe"]["effect_wear"],"label='Effects wearing' group='Foes'")
    -- Gui_Define(string.format(" 'Chat Mod Settings'/Foes opened=false"))
    --Others
    -- Gui_NewReadWrite("Chat Mod Settings", "o_ss", 1, chatfiltervars["other"]["start_spell"],"label='Start Spell' group='Others'")
    -- Gui_NewReadWrite("Chat Mod Settings", "o_fs", 1, chatfiltervars["other"]["finish_spell"],"label='Finish Spell' group='Others'")
    -- Gui_NewReadWrite("Chat Mod Settings", "o_m", 1, chatfiltervars["other"]["melee"],"label='Melee' group='Others'")
    -- Gui_NewReadWrite("Chat Mod Settings", "o_ws", 1, chatfiltervars["other"]["ws"],"label='Weapon Skill' group='Others'")
    -- Gui_NewReadWrite("Chat Mod Settings", "o_ra", 1, chatfiltervars["other"]["ranged"],"label='Ranged Attack' group='Others'")
    -- Gui_NewReadWrite("Chat Mod Settings", "o_ab", 1, chatfiltervars["other"]["abilities"],"label='Abilities' group='Others'")
    -- Gui_NewReadWrite("Chat Mod Settings", "o_re", 1, chatfiltervars["other"]["readies"],"label='Readies' group='Others'")
    -- Gui_NewReadWrite("Chat Mod Settings", "o_ew", 1, chatfiltervars["other"]["effect_wear"],"label='Effects wearing' group='Others'")
    -- Gui_Define(string.format(" 'Chat Mod Settings'/Others opened=false"))  
    
end );
ashita.register_event('incoming_packet', function(id, size, packet, packet_modified, blocked)
    local offset;
    if id == 0x029 then --Action Message
        local am = {}
        _ , am.actor_id = pack.unpack(packet,"I",0x05)
        _ , am.target_id = pack.unpack(packet,"I",0x09)
        _ , am.param_1 = pack.unpack(packet,"I",0x0D)
        -- _ , am.param_2 = pack.unpack(packet,"H",0x11)%2^9 -- First 7 bits
        -- _ , am.param_3 = math.floor(pack.unpack(packet,"I",0x11)/2^5) -- Rest
        _ , am.param_2 = pack.unpack(packet,"I",0x011)
        _ , am.actor_index = pack.unpack(packet,"H",0x15)
        _ , am.target_index = pack.unpack(packet,"H",0x17)
        _ , am.message_id = pack.unpack(packet,"I",0x19)
        if(table.hasvalue(filter,am.message_id))then
            return true
        end
        if(table.hasvalue(ignore,am.message_id))then
            return false
        end
        local buff = buffIDtoName(am.param_1)
        if(buff == nil)then
            buf = "???"
        end
        --local messages = {[206] = get_name(am.actor_id) .. "'s " .. color(buff,207) .. " wore off",[6] = get_name(am.actor_id) .. " defeats " .. get_name(am.target_id) , [523] = "You already have " .. AshitaCore:GetResourceManager():GetAbilityById(am.param_1 + 512).Name[2] .. " active"}
        local text = "0x29 "
        text = text .. am.message_id .. " " .. am.param_1 .. " " --.. --am.param_2 .. " " --.. am.param_3
        --text = text .. get_name(am.actor_id)
        if(am.message_id == 206 and chatfiltervars[getrelations(am.actor_id)]["effect_wear"])then
            return true
        end
        if(table.haskey(messages,am.message_id))then
            text = messages[am.message_id].en
            if(string.find(text,'$actor')    ~= nil)then text =string.gsub(text,'$actor',    get_name(am.actor_id) ) end
            if(string.find(text,'$target')   ~= nil)then text =string.gsub(text,'$target',  get_name(am.target_id) ) end
            if(string.find(text,'$number')    ~= nil)then text =string.gsub(text,'$number',  am.param_1 ) end
            if(string.find(text,'$numbe2')    ~= nil)then text =string.gsub(text,'$numbe2',  am.param_2 ) end
            if(string.find(text,'$status')    ~= nil)then text =string.gsub(text,'$status',  buff ) end    
            if(string.find(text,'$spell')    ~= nil)then text =string.gsub(text,'$spell',    AshitaCore:GetResourceManager():GetSpellById(am.param_1).Name[2]) end            
            if(string.find(text,'$weapon_skill')   ~= nil)then text =string.gsub(text,'$weapon_skill',  getmaname(am.actor_id ,am.param_1) ) end
            if(string.find(text,'$item2')    ~= nil)then text =string.gsub(text,'$item2',    AshitaCore:GetResourceManager():GetItemById(am.param_2).Name) end            
            if(string.find(text,'$item')    ~= nil)then text =string.gsub(text,'$item',   AshitaCore:GetResourceManager():GetItemById(am.param_1).Name) end            
            showmessage(121,am.actor_id,am.target_id,text)
            return true
        end
		
		-- Uncaptured message ID; Won't override with anything
        --print("Unknown message: " .. text);
		return false;
    elseif id  == 0x028 then	
        act =  unpackaction(packet)
        if(table.hasvalue(ignore,act.targets[1].actions[1].message))then
            return false
        end
        if(table.hasvalue(filter,act.targets[1].actions[1].message))then
            act.targets[1].actions[1].message = 0;
        else
			--print("Cat: " .. act.category .. "; From: " .. get_name(act.actor_id) .. " - " .. act.actor_id);
			if(act.category == 1) then     --Melee
				act = melee(act)
				elseif(act.category == 2)then --Finish Ranged
				act = ranged(act)
				elseif(act.category == 3)then --Weapon Skill
				act = ws(act)
				elseif(act.category == 4)then --Finish Spell Casting
				act = fspell(act)
				elseif(act.category == 5)then --Finish Item use
				elseif(act.category == 6)then --Ja use
					act = ja(act)
				elseif(act.category == 7)then --Start Weaponskill / tpmove
					act = swstp(act)
				elseif(act.category == 8)then --Start Spell
					local spell = AshitaCore:GetResourceManager():GetSpellById(act.targets[1].actions[1].param);
					if(spell ~= nil)then
						if(chatfiltervars[getrelations(act.actor_id)]["start_spell"])then
							act.targets[1].actions[1].message = 0
						else
						
						local text = "[" .. get_name(act.actor_id) .. "] " .. spell.Name[2] .. " --> " .. get_name(act.targets[1].id)
						showmessage(act.targets[1].actions[1].message,act.actor_id,act.targets[1].id,text)
						act.targets[1].actions[1].message = 0;
						end
					else
						if(act.targets[1].actions[1].message ~= 0)then
							print("Sspell: " .. get_name(act.actor_id) .. " " .. act.targets[1].actions[1].param)
						end
					end  
				elseif(act.category == 9)then --Start Item use /Inter
				if(act.targets[1].actions[1].param ~= 0)then
					local text = "[" .. get_name(act.actor_id) .. "] uses a " .. color(AshitaCore:GetResourceManager():GetItemById(act.targets[1].actions[1].param).Name[2],204)
					showmessage(act.targets[1].actions[1].message,act.actor_id,act.targets[1].id,text)
					act.targets[1].actions[1].message = 0
				end  
				elseif(act.category == 10)then --???
					print("Cat 10:" ..get_name(act.actor_id))
				elseif(act.category == 11)then --Finish Tp Move
					act = ftp(act)
				elseif(act.category == 12)then --Start ranged attack
				elseif(act.category == 13)then --Pet completes ability/ws
					act = pet(act)
				elseif(act.category == 14)then --Unblinkable job ability
					act = ja(act)
				elseif(act.category == 15)then --Some RUN job abilities
			end
        end
        local react = packaction(act);
        return false, string.totable(packet:sub(1,4) .. react);
	else
		return false;
    end;
end);
  
function get_name(id)
    if(id >= 0)then
        local name = GetIndexById(id).Name;
        if (name == nil)then
            name = "Out Of Range"
        end
        local index = "others"
        for i=0 ,AshitaCore:GetDataManager():GetParty():GetAllianceParty0MemberCount()-1,1 do
            if(AshitaCore:GetDataManager():GetParty():GetMemberName(i) == name)then
                if(i == 0)then
                    index = "self"
                else
                    index  = "p" .. i
                end
            end
        end
        for i=0 ,AshitaCore:GetDataManager():GetParty():GetAllianceParty1MemberCount()-1,1 do
            if(AshitaCore:GetDataManager():GetParty():GetMemberName(i+6) == name)then
                index  = "a1" .. (i)
            end
        end
        for i=0 ,AshitaCore:GetDataManager():GetParty():GetAllianceParty2MemberCount()-1,1 do
            if(AshitaCore:GetDataManager():GetParty():GetMemberName(i+12) == name)then
                index  = "a2" .. (i)
            end
        end
        return color(name,pcolors[index])
    elseif(bit.band(id,0x0FFF) >= 1792)then
        local name = AshitaCore:GetDataManager():GetEntity():GetName(bit.band(id,0x0FFF))
        if (name == nil)then
            name = "Out Of Range"
        end
        local index = "ppet" -- opet
        local peto = AshitaCore:GetDataManager():GetEntity():GetPetOwnerId(bit.band(id,0x0FFF))
        if(peto == AshitaCore:GetDataManager():GetParty():GetMemberServerId(0))then
            index = "ppet"
        end
        for i=1 ,AshitaCore:GetDataManager():GetParty():GetAllianceParty0MemberCount()-1,1 do
            if(AshitaCore:GetDataManager():GetParty():GetMemberServerId(i) == peto)then
                index  = "ppet"
            end
        end
        for i=0 ,AshitaCore:GetDataManager():GetParty():GetAllianceParty1MemberCount()-1,1 do
            if(AshitaCore:GetDataManager():GetParty():GetMemberServerId(i+6) == peto)then
                index  = "ppet"
            end
        end
        for i=0 ,AshitaCore:GetDataManager():GetParty():GetAllianceParty2MemberCount()-1,1 do
            if(AshitaCore:GetDataManager():GetParty():GetMemberServerId(i+6) == peto)then
                index  = "ppet"
            end
        end
        return color(name,colors[index])
    else
        local name = AshitaCore:GetDataManager():GetEntity():GetName(bit.band(id,0x0FFF))
        if (name == nil)then
            name = "Out Of Range"
        end
        local index = "mob"
        local mobT = AshitaCore:GetDataManager():GetEntity():GetClaimServerId(bit.band(id,0x0FFF))
        if(mobT == AshitaCore:GetDataManager():GetParty():GetMemberServerId(0))then
            index = "mymob"
        end
        for i=1 ,AshitaCore:GetDataManager():GetParty():GetAllianceParty0MemberCount()-1,1 do
            if(AshitaCore:GetDataManager():GetParty():GetMemberServerId(i) == mobT)then
                index  = "pmob"
            end
        end
        for i=0 ,AshitaCore:GetDataManager():GetParty():GetAllianceParty1MemberCount()-1,1 do
            if(AshitaCore:GetDataManager():GetParty():GetMemberServerId(i+6) == mobT)then
                index  = "amob"
            end
        end
        for i=0 ,AshitaCore:GetDataManager():GetParty():GetAllianceParty2MemberCount()-1,1 do
            if(AshitaCore:GetDataManager():GetParty():GetMemberServerId(i+6) == mobT)then
                index  = "amob"
            end
        end
        return color(name,colors[index])
    end

end

---------------------------------------------------------------------------------------------------
-- func: unload
-- desc: Called when our addon is unloaded.
---------------------------------------------------------------------------------------------------
ashita.register_event('unload', function() 
    local tempvar = {["self"]   = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false},
                     ["party"]  = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false},
                     ["allies"] = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false},
                     ["foe"]    = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false},
                     ["other"]  = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false}}
    local temp1 = {"self","party","allies","foe","other"}
    local temp2 = {"start_spell","finish_spell","melee","ws","ranged","abilities","readies","effect_wear"}
    for i = 1, #temp1 do
        for j = 1, #temp2 do
            tempvar[temp1[i]][temp2[j]] = chatfiltervars[temp1[i]][temp2[j]]
        end
    end
    ashita.settings.save(_addon.path .. 'settings/chatfilters.json', tempvar)
    --Gui_DeleteBar("Chat Mod Settings")    
end );

---------------------------------------------------------------------------------------------------
-- func: Command
-- desc: Called when our addon receives a command.
---------------------------------------------------------------------------------------------------
ashita.register_event('command', function(cmd, nType)
    if(cmd == "/cmod color test")then
        local counter = 0
        local line = ''
        for n = 1, 500 do
            if n <= 255 then
                loc_col = string.char(0x1F, n)
                else
                loc_col = string.char(0x1E, n - 254)
            end
            line = line..loc_col..string.format('%03d ', n)
            counter = counter + 1
        end
        print(line)
    end
    if(cmd == "/cmod save")then
        local tempvar = {["self"]   = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false},
                         ["party"]  = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false},
                         ["allies"] = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false},
                         ["foe"]    = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false},
                         ["other"]  = {["start_spell"] = false,["finish_spell"]=false,["melee"] = false,["ws"]=false,["ranged"]=false,["abilities"]=false,["readies"]=false,["effect_wear"]=false}}
        local temp1 = {"self","party","allies","foe","other"}
        local temp2 = {"start_spell","finish_spell","melee","ws","ranged","abilities","readies","effect_wear"}
        for i = 1, #temp1 do
            for j = 1, #temp2 do
                tempvar[temp1[i]][temp2[j]] = chatfiltervars[temp1[i]][temp2[j]]
            end
        end
        ashita.settings.save(_addon.path .. 'settings/chatfilters.json', tempvar)
    end
    if(cmd == "/cmod settings")then
        --Gui_Define(" 'Chat Mod Settings' iconified=false")
    end
    if(cmd == "/cmod t1")then
        for i =0, 256 do
            local text = ""..i
            AshitaCore:GetChatManager():AddChatMessage(i,text)
        end
    end
    return false;
end );


function melee(act)
    local text = ""
    local damage = 0
    local add = 0
    local taken = 0
    local mid = act.targets[1].actions[1].message
    local misses = {15,30,31,32,63}
    if(chatfiltervars[getrelations(act.actor_id)]["melee"])then
        for i = 1,act.target_count do
            for n = 1,act.targets[i].action_count do
                act.targets[i].actions[n].message = 0
                act.targets[i].actions[n].spike_effect_message = 0
                act.targets[i].actions[n].add_effect_message = 0
            end
        end
        return act
    end   
    for i = 1,act.target_count do
        for n = 1,act.targets[i].action_count do
            if(filter_melee["condense"])then
                damage = damage + act.targets[i].actions[n].param
                mid = act.targets[i].actions[n].message
                if(table.haskey(messages,mid))then
                    text = messages[mid].en
                    if(string.find(text,'$number')    ~= nil)then text =string.gsub(text,'$number',  damage ) end
                    if(act.targets[i].actions[n].has_add_effect and filter_melee["addeffect"])then
                        add = add + act.targets[i].actions[n].add_effect_param
                        if(table.haskey(messages,act.targets[i].actions[n].add_effect_message))then
                            text = text .. "\n"..messages[act.targets[i].actions[n].add_effect_message].en
                        else
                            text = text .. "\nAdd Effect Mid:"..act.targets[i].actions[n].add_effect_message
                        end
                        if(string.find(text,'$number')    ~= nil)then text =string.gsub(text,'$number',  add ) end
                    end
                    if(act.targets[i].actions[n].has_spike_effect and filter_melee["spikes"] and mid ~= 33) then
                        taken = taken + act.targets[i].actions[n].spike_effect_param
                        if(table.haskey(messages,act.targets[i].actions[n].spike_effect_message))then
                            text = text .. "\n"..messages[act.targets[i].actions[n].spike_effect_message].en
                        else
                            text = text .. "\nSpikes Mid" .. act.targets[i].actions[n].spike_effect_message
                        end
                        if(string.find(text,'$number')    ~= nil)then text =string.gsub(text,'$number',  taken ) end
                    end
                    if(string.find(text,'$actor')    ~= nil)then text =string.gsub(text,'$actor',    "["..get_name(act.actor_id).."]") end
                    if(string.find(text,'$target')   ~= nil)then text =string.gsub(text,'$target',  get_name(act.targets[i].id) ) end
                    if(string.find(text,'$damage')    ~= nil)then text =string.gsub(text,'$damage',  damage ) end
                    if(string.find(text,'$status')    ~= nil)then text =string.gsub(text,'$status',  buffIDtoName(act.targets[1].actions[1].add_effect_param) ) end
                    act.targets[i].actions[n].spike_effect_message = 0
                    act.targets[i].actions[n].add_effect_message = 0
                    act.targets[i].actions[n].message = 0
                else
                    return act
                end
            else
                mid = act.targets[i].actions[n].message
                if(mid ~= 0)then
                    text = message[mid]
                    if(act.targets[i].actions[n].has_add_effect and filter_melee["addeffect"])then
                        text = text .. "\n$actor Add effect " .. act.targets[i].actions[n].add_effect_param .. "-->$target"
                    end
                    if(act.targets[i].actions[n].has_spike_effect and filter_melee["spikes"]) then
                        text = text .. "\n[$target] Spikes " .. act.targets[i].actions[n].spike_effect_param .. "-->$actor"
                    end
                    if(string.find(text,'$actor')    ~= nil)then text =string.gsub(text,'$actor',    "["..get_name(act.actor_id).."]") end
                    if(string.find(text,'$target')   ~= nil)then text =string.gsub(text,'$target',  get_name(act.targets[i].id) ) end
                    if(string.find(text,'$damage')    ~= nil)then text =string.gsub(text,'$damage',  act.targets[i].actions[n].param ) end
                end
                act.targets[i].actions[n].spike_effect_message = 0
                act.targets[i].actions[n].add_effect_message = 0
                act.targets[i].actions[n].message = 0
                text = text .. "\n"
            end
        end
    end
    showmessage(50,act.actor_id,act.targets[1].id,text)
    return act
end
function ranged(act)
    local text = ""
    local mid = 0
    if(chatfiltervars[getrelations(act.actor_id)]["ranged"])then
        for i = 1,act.target_count do
            for n = 1,act.targets[i].action_count do
                act.targets[i].actions[n].message = 0
                act.targets[i].actions[n].spike_effect_message = 0
                act.targets[i].actions[n].add_effect_message = 0
            end
        end
        return act
    end
    for i = 1,act.target_count do
        for n = 1,act.targets[i].action_count do
            mid = act.targets[i].actions[n].message
            if(table.haskey(messages,mid))then
                text = messages[mid].en
                if(string.find(text,'$number')    ~= nil)then text =string.gsub(text,'$number',  act.targets[i].actions[n].param ) end
                if(act.targets[i].actions[n].has_add_effect and filter_melee["addeffect"])then
                    if(table.haskey(messages,act.targets[i].actions[n].add_effect_message))then
                        text = text .. "\n"..messages[act.targets[i].actions[n].add_effect_message].en
                        if(string.find(text,'$number')    ~= nil)then text =string.gsub(text,'$number',  act.targets[i].actions[n].add_effect_param ) end
                        act.targets[i].actions[n].add_effect_message = 0
                    else
                        text = text .. "\nAdd Effect Mid:"..act.targets[i].actions[n].add_effect_message
                    end
                end
                if(string.find(text,'$actor')    ~= nil)then text =string.gsub(text,'$actor',    "["..get_name(act.actor_id).."]") end
                if(string.find(text,'$target')   ~= nil)then text =string.gsub(text,'$target',  get_name(act.targets[i].id) ) end
                if(string.find(text,'$damage')    ~= nil)then text =string.gsub(text,'$damage',  act.targets[i].actions[n].param ) end
                if(string.find(text,'$number')    ~= nil)then text =string.gsub(text,'$number',  act.targets[1].actions[1].add_effect_param ) end
                if(string.find(text,'$status')    ~= nil)then text =string.gsub(text,'$status',  buffIDtoName(act.targets[1].actions[1].add_effect_param) ) end
                act.targets[i].actions[n].message = 0
            else
                return act
            end
        end
    end
    showmessage(50,act.actor_id,act.targets[1].id,text)
    return act
end
function ws(act)
    local text = "$actor $damage $action --> $target"
    local mid = act.targets[1].actions[1].message 
    if(chatfiltervars[getrelations(act.actor_id)]["ws"])then
        for i = 1,act.target_count do
            for n = 1,act.targets[i].action_count do
                act.targets[i].actions[n].message = 0
                act.targets[i].actions[n].spike_effect_message = 0
                act.targets[i].actions[n].add_effect_message = 0
            end
        end
        return act
    end
    for i = 1,act.target_count do
        for n = 1,act.targets[i].action_count do
            local num =act.param
            --print(act.targets[i].actions[n].message)
            if(act.targets[i].actions[n].message == 110)then
                num = num + 512
            end
            local ability = AshitaCore:GetResourceManager():GetAbilityById(num)
            if(ability == nil)then
                return act
            else
                if(string.find(text,'$action')    ~= nil)then text =string.gsub(text,'$action',    ability.Name[2] ) end
            end
            if(string.find(text,'$actor')    ~= nil)then text =string.gsub(text,'$actor',    "["..get_name(act.actor_id).."]") end
            if(string.find(text,'$target')   ~= nil)then text =string.gsub(text,'$target',  get_name(act.targets[i].id) ) end
            if(string.find(text,'$damage')    ~= nil)then text =string.gsub(text,'$damage',  act.targets[i].actions[n].param ) end
            if(act.targets[i].actions[n].has_add_effect)then
                if(table.haskey(messages,act.targets[i].actions[n].add_effect_message))then
                    text = text .. "\n"..messages[act.targets[i].actions[n].add_effect_message].en
                else
                    text = text .. "\nAdd Effect Mid:"..act.targets[i].actions[n].add_effect_message
                end
                act.targets[i].actions[n].add_effect_message = 0
                if(string.find(text,'$number')    ~= nil)then text =string.gsub(text,'$number',  act.targets[i].actions[n].add_effect_param ) end
                if(string.find(text,'$target')   ~= nil)then text =string.gsub(text,'$target',  get_name(act.targets[i].id) ) end
            end
            act.targets[i].actions[n].message = 0
        end
    end
    showmessage(50,act.actor_id,act.targets[1].id,text)
    return act
end
function fspell(act)
    local text =  ""
    if(chatfiltervars[getrelations(act.actor_id)]["finish_spell"])then
        for i = 1,act.target_count do
            for n = 1,act.targets[i].action_count do
                act.targets[i].actions[n].message = 0
            end
        end
        return act
    end
    --print("Actor:" .. act.actor_id .. " TCount:" .. act.target_count .. " EffectId:"  .. act.targets[1].actions[1].param .. " Message " ..act.targets[1].actions[1].message)
    local ignore = { 0 }
    local mid = act.targets[1].actions[1].message
    if( table.hasvalue(ignore,mid))then
        act.targets[1].actions[1].message = 0
        return act
    end
    if( not table.haskey(messages,mid))then
        return act
    else
        text = messages[mid].en
    end
    local targets = {}
    act,targets = gettargets(act)
    local names = targets[1][1]
    if(mid == 367)then
        names = targets[1][1] .. "(" .. targets[1][2] .. "HP)"
    end
    for i = 2,#targets do
        if(mid == 367)then
            names = names .. ", " .. targets[i][1] .. "(" .. targets[i][2] .. "HP)"
            else
            names = names .. ", " .. targets[i][1]
        end
    end
    if(string.find(text,'$status')    ~= nil)then text =string.gsub(text,'$status',   buffIDtoName(act.targets[1].actions[1].param) ) end
    if(string.find(text,'$ename')    ~= nil)then text =string.gsub(text,'$ename',   buffIDtoName(act.targets[1].actions[1].param) ) end
    if(string.find(text,'$number')   ~= nil)then text =string.gsub(text,'$number',   act.targets[1].actions[1].param ) end
    if(string.find(text,'$effect')   ~= nil)then text =string.gsub(text,'$effect',   act.targets[1].actions[1].param ) end
    if(string.find(text,'$actor')    ~= nil)then text =string.gsub(text,'$actor',    "["..get_name(act.actor_id).."]") end
    if(string.find(text,'$spell')    ~= nil)then text =string.gsub(text,'$spell',    AshitaCore:GetResourceManager():GetSpellById(act.param).Name[2]) end
    if(string.find(text,'$target')   ~= nil)then text =string.gsub(text,'$target',  names)  end
       
    showmessage(50,act.actor_id,act.targets[1].id,text)
    return act
end
function ja(act)
    local mid = act.targets[1].actions[1].message
    if(chatfiltervars[getrelations(act.actor_id)]["abilities"])then
        for i = 1,act.target_count do
            for n = 1,act.targets[i].action_count do
                act.targets[i].actions[n].message = 0
            end
        end
        return act
    end
    if(table.haskey(messages,mid) or mid == 0)then
        local targets = get_name(act.targets[1].id)
        local num = act.param
        local ability = AshitaCore:GetResourceManager():GetAbilityById(num + 512)  
        local text = ""
        if(mid == 0)then
            text = "$actor $action --> $target"
        else
            text = messages[mid].en
        end
        local targetz = {}
        act,targetz = gettargets(act)
        for i = 2,#targetz do
            targets = targets .. ", " .. targetz[i][1]
        end
        if(string.find(text,'$ability')    ~= nil)then text =string.gsub(text,'$ability',    ability.Name[2] ) end
        if(string.find(text,'$action')    ~= nil)then text =string.gsub(text,'$action',    ability.Name[2] ) end
        if(string.find(text,'$actor')    ~= nil)then text =string.gsub(text,'$actor',    "["..get_name(act.actor_id).."]") end
        if(string.find(text,'$target')   ~= nil)then text =string.gsub(text,'$target', targets  ) end 
        if(string.find(text,'$number')   ~= nil)then text =string.gsub(text,'$number', act.targets[1].actions[1].param  ) end
        if(string.find(text,'$rolleffect')~= nil)then text =string.gsub(text,'$rolleffect', (roll_buff[num + 512][act.targets[1].actions[1].param] .. color(roll_buff[num + 512][13], 13))) end
        if(string.find(text,'$rollchance')   ~= nil)then text =string.gsub(text,'$rollchance', bust_rate(act.targets[1].actions[1].param)  ) end
        if(string.find(text,'$lucky')   ~= nil)then text =string.gsub(text,'$lucky', lucky( num +512,act.targets[1].actions[1].param)  ) end
        showmessage(50,act.actor_id,act.targets[1].id,text)     
    else
        return act
    end
    return act
end
function swstp(act)
    local mid = act.targets[1].actions[1].message;
    local text = "";
    if(chatfiltervars[getrelations(act.actor_id)]["readies"])then
        act.targets[1].actions[1].message = 0
        return act
    end
    if(act.param == 24931)then
        if(act.actor_id <= 1000000)then
			local abil = AshitaCore:GetResourceManager():GetAbilityById(act.targets[1].actions[1].param).Name[2];	
            text = "[" .. get_name(act.actor_id) .. "] readies " .. abil .. " --> " ..  get_name(act.targets[1].id)
        else  --  ..
            text ="[" .. get_name(act.actor_id) .. "] readies " .. getmaname(act.actor_id,act.targets[1].actions[1].param) ..  " --> " ..  get_name(act.targets[1].id)
            act.targets[1].actions[1].message = 0
        end
    else
        if(act.actor_id <= 1000000)then			
			local abil = AshitaCore:GetResourceManager():GetAbilityById(act.targets[1].actions[1].param).Name[2];
            text = "[" .. get_name(act.actor_id) .. "] " .. abil  .. " Failed"
        else
            text = "[" .. get_name(act.actor_id) .. "] " .. getjaname(act.actor_id,act.targets[1].actions[1].param) ..  " Failed"
            act.targets[1].actions[1].message = 0
        end
    end
    showmessage(50,act.actor_id,act.targets[1].id,text)
    return act
end
function ftp(act)
    local mid = act.targets[1].actions[1].message
    if(chatfiltervars[getrelations(act.actor_id)]["abilities"])then
        for i = 1,act.target_count do
            for n = 1,act.targets[i].action_count do
                act.targets[i].actions[n].message = 0
            end
        end
        return act
    end
    if( not table.haskey(messages,mid))then
        return act
    else
        local text = messages[mid].en
        local targets = {}
        act,targets = gettargets(act)
        local names = targets[1][1]
        for i = 2,#targets do
            names = names .. ", " .. targets[i][1]
        end
        local skillname = getmaname(act.actor_id,act.param)
        if(string.find(text,'$actor')    ~= nil)then text =string.gsub(text,'$actor',   get_name(act.actor_id) ) end
        if(string.find(text,'$target')   ~= nil)then text =string.gsub(text,'$target',  names ) end
        if(string.find(text,'$weapon_skill')   ~= nil)then text =string.gsub(text,'$weapon_skill',  skillname ) end
        if(string.find(text,'$number')    ~= nil)then text =string.gsub(text,'$number',  targets[1][2] ) end        
        if(string.find(text,'$status')    ~= nil)then text =string.gsub(text,'$status',  buffIDtoName(act.targets[1].actions[1].param) ) end
        showmessage(50,act.actor_id,act.targets[1].id,text)
    end
    return act
end    
function pet(act)
    local text = ""
    local mid = act.targets[1].actions[1].message
    if( not table.haskey(messages,mid))then
        return act
    else
        text = messages[mid].en
    end
    local targets = {}
    act,targets = gettargets(act)
    names = targets[1][1]
    for i = 2,#targets do
        names = names .. ", " .. targets[i][1]
    end
    if (string.find(text, '$ability') ~= nil) then text = string.gsub(text, '$ability', getjaname(act.actor_id, act.param)) end;
    if(string.find(text,'$status')    ~= nil)then text =string.gsub(text,'$status',   buffIDtoName(act.targets[1].actions[1].param) ) end
    if(string.find(text,'$number')   ~= nil)then text =string.gsub(text,'$number',   act.targets[1].actions[1].param ) end
    if(string.find(text,'$actor')    ~= nil)then text =string.gsub(text,'$actor',    "["..get_name(act.actor_id).."]") end
    if(string.find(text,'$spell')    ~= nil)then text =string.gsub(text,'$spell',    AshitaCore:GetResourceManager():GetSpellById(act.param).Name[2]) end
    if(string.find(text,'$target')   ~= nil)then text =string.gsub(text,'$target',  names)  end
    if(string.find(text,'$weapon_skill')   ~= nil)then text =string.gsub(text,'$weapon_skill',  getmaname(act.actor_id,act.param))  end
    showmessage(50,act.actor_id,act.targets[1].id,text)
    return act
end    
