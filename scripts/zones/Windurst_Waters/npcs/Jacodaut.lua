-----------------------------------
-- Area: Windurst Waters
--  NPC: Jacodaut
-- Type: Cooking Image Support
-- !pos -125.890 -2.999 62.499 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillCap = xi.crafting.getCraftSkillCap(player, xi.skill.COOKING)
    local skillLevel = player:getSkillLevel(xi.skill.COOKING)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.COOKING) then
        if not player:hasStatusEffect(xi.effect.COOKING_IMAGERY) then
            player:startEvent(10016, skillCap, skillLevel, 1, 495, player:getGil(), 0, 4095, 0) -- p1 = skill level
        else
            player:startEvent(10016, skillCap, skillLevel, 1, 495, player:getGil(), 7180, 4095, 0)
        end
    else
        player:startEvent(10016) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10016 and option == 1 then
        player:messageSpecial(ID.text.COOKING_SUPPORT, 0, 8, 1)
        player:addStatusEffect(xi.effect.COOKING_IMAGERY, 1, 0, 120)
    end
end

return entity
