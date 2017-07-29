-----------------------------------------
-- Spell: Utsusemi: San
-----------------------------------------
require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onMagicCastingCheck(caster,target,spell)
    return 0;
end;

function onSpellCast(caster,target,spell)
    local effect = target:getStatusEffect(EFFECT_COPY_IMAGE);
    local icon = EFFECT_COPY_IMAGE_4;

    -- Set base shadows and which of ichi/ni/san this is
    local shadows = 5;
    local tier = 3; -- San!

    -- Get extras shadows
    if (caster:getMod(MOD_ENHANCES_UTSUSEMI) > 0) then
        shadows = shadows+1;
    end

    if (effect == nil) then
        target:addStatusEffectEx(EFFECT_COPY_IMAGE, icon, shadows, 0, 300, 0, tier);
        target:setMod(MOD_UTSUSEMI, shadows);
        spell:setMsg(230);
    elseif (effect:getTier() <= tier) then -- Always overwrite Ichi/Ni!
        effect:setPower(shadows);
        effect:setIcon(icon);
        effect:resetStartTime();
        target:setMod(MOD_UTSUSEMI, shadows);
        spell:setMsg(230);
    else
        spell:setMsg(75); -- No effect
    end

    return EFFECT_COPY_IMAGE;
end;
