-----------------------------------------
-- Spell: Utsusemi: Ichi
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
    local icon = EFFECT_COPY_IMAGE_3;

    -- Set base shadows and which of ichi/ni/san this is
    local shadows = 3;
    local tier = 1; -- Ichi!

    -- Get extras shadows
    if (caster:getMod(MOD_ENHANCES_UTSUSEMI) > 0) then
        shadows = shadows+1;
    end

    if (shadows > 3) then
        icon = EFFECT_COPY_IMAGE_4;
    end

    if (effect == nil) then
        target:addStatusEffectEx(EFFECT_COPY_IMAGE, icon, shadows, 0, 900, 0, tier);
        target:setMod(MOD_UTSUSEMI, shadows);
        spell:setMsg(230);
    elseif (effect:getTier() <= tier) then -- Don't overwrite Ni or San!
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
