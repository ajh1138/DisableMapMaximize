local DisableMapMaxPrintHexColor = "2B98FF";
local DisableMapMaxPrintPrefix = "|cFF" .. DisableMapMaxPrintHexColor .. "DisableMapMaximize:|r";

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")

function DisableMapMax_OnLoad()
	print(DisableMapMaxPrintPrefix .. " loaded.  Use '/dmm off' if you want to re-enable the button.");
	
	if DisableMapMaximizeStatus == nil then
		DisableMapMaximizeStatus = true;
	end
	
	DisableMapMax_ToggleTheButton(DisableMapMaximizeStatus);
end

function DisableMapMax_ToggleTheButton(status)
	if status == true then
		local button = WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MaximizeButton;
		button:Disable(); 
		button:GetNormalTexture():SetDesaturated(true);
	else
		local button = WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MaximizeButton;
		button:Enable(); 
		button:GetNormalTexture():SetDesaturated(false);
	end

end

function DisableMapMax_ReceiveCommand(msg)
	if msg == "on" then
		DisableMapMaximizeStatus = true;
		DisableMapMax_ToggleTheButton(true)
	else
		DisableMapMaximizeStatus = false;
		DisableMapMax_ToggleTheButton(false)
	end
	
	print("status:" .. tostring(DisableMapMaximizeStatus))
end

function dmmdebug(...)
	local msg = "|cFFFF0000DMM debug:|r ";

	print(msg,...);
end

SlashCmdList["DisableMapMax_SLASHCMD"] = function(msg)
	DisableMapMax_ReceiveCommand(msg);
end
SLASH_DisableMapMax_SLASHCMD1 = "/dmm";

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "DisableMapMaximize" then
    	DisableMapMax_OnLoad();
    end
end)