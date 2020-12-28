local addonName, addon = ...

-- True if the reminder popup is active; false otherwise.
addon.reminderActive = false

-- This is the top-level frame for the reminder popup.
addon.reminderFrame = HydrateReminderFrame

-- This is the interval at which reminders are issued, in seconds. The actual
-- time between reminders may be longer if the player is in combat or in some
-- other state inappropriate for reminders.
addon.reminderInterval = 10 * 60

-- This is the minimum duration to wait before showing a reminder, in seconds.
-- This is only relevant to the first reminder after the player leaves a state
-- in which reminders were disabled.
addon.minimumReminderDuration = 5

-- This is the server time at which the reminder timer was most recently
-- started. This is initially set to the time at which the player enters the
-- game world, then updated each time the reminder frame is hidden.
addon.reminderStartTime = nil

-- This is the soundkit ID of the sound to be played when the popup is shown.
-- This defaults to the raid warning sound.
addon.reminderSoundkitId = 8959

-- This is the display ID of the model to be shown in the popup. This defaults
-- to a water elemental battle pet.
addon.reminderDisplayId = 88619