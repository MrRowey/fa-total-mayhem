-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  BRN Scavenger Medium Tank
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local SWeapons = import('/lua/seraphimweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon
local SDFChronotronCannonWeapon = SWeapons.SDFChronotronCannonWeapon

BROT1EXTANK = Class(TLandUnit){
    Weapons = {
        autoattack = Class(AutoAttackWeapon){ FxMuzzleFlashScale = 0.0 },
        MainGun = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 1.7,
            FxMuzzleFlash = EffectTemplate.ASerpFlash01,
        },
        smgun1 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 1.0,
            FxMuzzleFlash = EffectTemplate.ASerpFlash01,
        },
        smgun2 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 1.0,
            FxMuzzleFlash = EffectTemplate.ASerpFlash01,
        },
        smgun3 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 1.0,
            FxMuzzleFlash = EffectTemplate.ASerpFlash01,
        },
        smgun4 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 1.0,
            FxMuzzleFlash = EffectTemplate.ASerpFlash01,
        },
        smgun5 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 1.0,
            FxMuzzleFlash = EffectTemplate.ASerpFlash01,
        },
        smgun6 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 1.0,
            FxMuzzleFlash = EffectTemplate.ASerpFlash01,
        },
        MainGun2 = Class(SDFChronotronCannonWeapon){
            FxMuzzleFlashScale = 3.55,
            FxMuzzleFlash = EffectTemplate.ASDisruptorCannonMuzzle01,
        },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        TLandUnit.OnStopBeingBuilt(self, builder, layer)

        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        TLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['AeonUnitDeathRing02'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'engine01', army, v):ScaleEmitter(1.10))
        end
        for k, v in TMEffectTemplate['UEFHEAVYROCKET02'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'engine01', army, v):ScaleEmitter(1.0))
        end
    end,
}

TypeClass = BROT1EXTANK
