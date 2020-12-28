local addonName, addon = ...

local events = CreateFrame("Frame", addonName .. "Events", UIParent)
addon.events = events

function events:OnEvent(event, ...)
    if self[event] then
        self[event](self, event, ...)
    end
end

events:SetScript("OnEvent", events.OnEvent)
events:RegisterEvent("ADDON_LOADED")

-- Dispatch events.
function events:ADDON_LOADED(_, name)
    if name ~= addonName then
        return
    end

    self:UnregisterAllEvents()

    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_FLAGS_CHANGED")
end

-- Start reminders once the player is in the game.
function events:PLAYER_ENTERING_WORLD(...)
    addon:LoadReminder()
end

-- This is fired when the player enters combat. Reminders should not be shown in
-- combat to avoid distracting the player.
function events:PLAYER_REGEN_DISABLED(...)
    addon:StopReminder()
end

-- This is fired when the player leaves combat. Remindes can be shown again.
function events:PLAYER_REGEN_ENABLED(...)
    addon:StartReminder()
end

-- This is fired when the player AFK or DND flags change state. Reminders should
-- not be shown while the player is AFK or DND as the player is unlikely to
-- respond to them.
function events:PLAYER_FLAGS_CHANGED(...)
    if UnitIsAFK("player") or UnitIsDND("player") then
        addon:StopReminder()
    else
        addon:StartReminder()
    end
end