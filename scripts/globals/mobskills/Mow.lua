---------------------------------------------
--  Mow
--
--  Description: Deals damage in an area of effect. Additional effect: Poison
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Unknown radial
--  Notes: Poison can take around 10HP/tick
---------------------------------------------
require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------
function OnMobSkillCheck(target,mob,skill)
	return 0;
end;

function OnMobWeaponSkill(target, mob, skill)

	local numhits = math.random(2,3);
	local accmod = 1;
	local dmgmod = .8;
	local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT);
	local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_PHYSICAL,MOBPARAM_SLASH,info.hitslanded);

	local typeEffect = EFFECT_POISON;
	if(target:hasStatusEffect(typeEffect) == false and MobPhysicalHit(skill, dmg, target, info.hitslanded)) then
		local statmod = MOD_INT;
		local resist = applyPlayerResistance(mob,typeEffect,target,mob:getStat(statmod)-target:getStat(statmod),0,ELE_WATER);
		if(resist > 0.2) then
			local power = math.random(1,4) + 6;
			target:addStatusEffect(typeEffect,power,3,60*resist);--tic=3;duration=60;
		end
	end

	target:delHP(dmg);
	return dmg;
end;
