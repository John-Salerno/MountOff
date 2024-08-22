local function BuildMountNamesTable()
    local mountNames = {}
    local allMountIDs = C_MountJournal.GetMountIDs()
    for _, mountID in pairs(allMountIDs) do
        local mountName = C_MountJournal.GetMountInfoByID(mountID)
        if mountName ~= "" then
            mountNames[mountName] = mountID
        end
    end
    return mountNames
end

local function MountOff()
    local mountNames = BuildMountNamesTable()
    AuraUtil.ForEachAura("target", "HELPFUL", nil, function(auraName)
        local mountID = mountNames[auraName]
        if mountID ~= nil then
            --We are purposely doing this even if you don't have the mount collected, so that you see the error message at the top of the screen
            C_MountJournal.SummonByID(mountID)
        end
    end)
end

SLASH_MOUNTOFF1 = "/mountoff"
SlashCmdList["MOUNTOFF"] = MountOff