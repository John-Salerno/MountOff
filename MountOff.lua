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
        if mountID then
            C_MountJournal.SummonByID(mountID)
        end
    end)
end

SLASH_MOUNTOFF1 = "/mountoff"
SlashCmdList["MOUNTOFF"] = MountOff