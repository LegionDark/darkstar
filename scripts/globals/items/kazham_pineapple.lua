-----------------------------------------
-- ID: 4432
-- Item: kazham_pineapple
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Agility -5
-- Intelligence 3
-----------------------------------------
require("scripts/globals/status");
-----------------------------------------

function onItemCheck(target)
    local result = 0;
    if (target:hasStatusEffect(EFFECT_FOOD) == true or target:hasStatusEffect(EFFECT_FIELD_SUPPORT_FOOD) == true) then
        result = 246;
    end
    return result;
end;

function onItemUse(target)
    target:addStatusEffect(EFFECT_FOOD,0,0,300,4432);
end;

function onEffectGain(target, effect)
    target:addMod(MOD_AGI, -5);
    target:addMod(MOD_INT, 3);
end;

function onEffectLose(target, effect)
    target:delMod(MOD_AGI, -5);
    target:delMod(MOD_INT, 3);
end;
