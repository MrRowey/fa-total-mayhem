-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  BRN Scavenger Medium Tank
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

BRMT3PDRO = Class(TStructureUnit){
    Weapons = { MainGun = Class(TDFGaussCannonWeapon){
        FxMuzzleFlashScale = 2.1,
        FxMuzzleFlash = EffectTemplate.CIFCruiseMissileLaunchSmoke,
    } },
}

TypeClass = BRMT3PDRO
