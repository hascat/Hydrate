local addonName, addon = ...

local function ShowReminder()
    if not addon.reminderActive then
        return
    end

    if addon.reminderFrame:IsShown() then
        return
    end

    PlaySound(addon.reminderSoundkitId)
    addon.reminderFrame.model:SetAnimation(16)
    addon.reminderFrame:Show()
end

local function ResetReminder()
    if not addon.reminderActive then
        return
    end

    addon.reminderStartTime = GetServerTime()
    C_Timer.After(addon.reminderInterval, ShowReminder)
end

function addon:LoadReminder()
    self.reminderFrame.model:SetDisplayInfo(self.reminderDisplayId)
    self.reminderFrame:SetScript("OnHide", ResetReminder)

    self:StartReminder()
end

function addon:StartReminder()
    self.reminderActive = true

    local remainder = 0
    if self.reminderStartTime ~= nil then
        local duration = GetServerTime() - self.reminderStartTime
        remainder = self.reminderInterval - duration
    end

    if remainder < addon.minimumReminderDuration then
        remainder = addon.minimumReminderDuration
    end

    C_Timer.After(remainder, ShowReminder)
end

function addon:StopReminder()
    self.reminderActive = false
    self.reminderFrame:Hide()
end