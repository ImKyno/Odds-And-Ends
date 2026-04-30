-- To do list for Odds and Ends release.
--[[-----------------------------------------------------------------------------------------------------------------------------

    [ Misc ]
    * Add Missing STRINGS for characters. - [DONE]

    [ Minimap Icons ]
    * Add Icons for Treasure Bags and Trinket Machine.

    [ General ]
    * Add True Ice - [DONE]
        |
        New type of material for repairing items.

    [ Assorted Weapons ]
    * Weapon with "Damage increases as health decreases"
    * Weapon with "Damage increases as sanity decreases"
    * Moonsplitter
        |
        Damage is based on the moon phase and bonus effects when Lunar Rift is active.
        
    * Strangler's Heart Dagger
        |
        Part of a Set Bonus, damage increases for each target around the wielder.

    [ Treasure Bags ]
    * Add Treasure Bags System - [DONE]
    * Add Treasure Bag for each Boss.
    * Add Custom Loot for each Treasure Bag.
    * Make Treasure Bags only appear for their owner. (Other players can't see them).
    * Make Bosses drop Treasure Bags based on the number of nearby players.

    [ Treasure Bags Loot ]
    * All Bags drop a sum of Tokens that can be spent at the Trinket Machine.
    * Not every item is included, some are guaranteed, others are chance based.
    * Deerclops: 
        |
        * Chilled Tools (Pickaxe, Axe, Shovel, Hoe): Perishable Tools like Ham Bat, 
        does not spoil during Winter, spoils faster during other seasons, specially Summer.
        Can be stored inside Ice Box to stop spoil time and decreases temperature when yield. - [DONE]

        * Frozen Mallet (Tool/Weapon): Perishable Hammer that can also be used as a weapon
        that slows targets and decreases their damage for a certain duration,
        does not spoil during Winter, spoils faster during other seasons, specially Summer.
        Can be stored inside Ice Box to stop spoil time and decreases the temperature when yield. - [DONE]

        * Chilled Stone: Infinite Thermal Stone that is always cold. -- Thinking of moving this to Frostjaw...

        * Frostbane (Weapon): Sword that can instantly freeze targets, has cooldown between uses.
        Deals more damage during the Winter and decreases the temperature when yield. - [DONE]

        * Trinkets: Snowman, Snowglobe, ...

    * Moose Goose
        |
        * Stormcaller's Staff (Weapon): Casts lightnings at mouse cursor. Drains sanity when used.

        * Stormcaller's Cloak (Armor): Chance to stun targets when attacked.
        Has 100% Waterprofness and gives insulation against lighnting.

        * Rain Totem: Summons rain. Drains sanity and is consumed when used.

        * Bottled Maelstrom (Weapon): Throwable weapon that deals electric damage and stuns targets.

        * Goose Waders (Accessory): Increased movement speed when it's raining or if wetness is high enough. [DONE]

        * Trinkets: Rubber Duck, Cracked Egg, Bird Nest, Soggy Boot, ...

    * Bearger
        |
        * Groundbreaker (Tool): Casts Bearger's Groundpound AOE attack.
        Has low damage and cooldown between uses.

        * Hibernation Hat (Clothing): Reduces hunger rate and gives winter insulation.

        * Thick Fur Bedroll: Better than bunnyman's bedroll. Sleep at any time of the day.

        * Gnawed Wood Totem (Accessory): Drops more logs when chopping trees and killing treeguards.
        Does not work for trees that can't drop logs or driftwood.

        * Trinkets: Teddy Bear, Picnic Basket, Chewed Log, Honey Jar, ...

    * Dragonfly
        |
        * Molten Blade (Weapon): Ignites targets and increases the temperature when yield.
        Chance to self ignite when attacking. Increased damage against targets that are burning.

        * Magma Fire Pit (Blueprint): Just like Obsidian Fire Pit from Shipwrecked.
        Huge Light radius and hot temperature.

        * Molten Ring (Accessory): Damage and ignites targets when attacked, has cooldown.
        Drains sanity when activated.

        * Molten Skull (Accessory): Grants immunity to fire damage.

        Enraged Loot:
            |
            * Molten Charm (Accessory): Grants immunity to overheat.

            * Magma Stone: Infinite Thermal Stone that is always hot.

        * Trinkets: Mosquito Spray, Mini Volcano, Lava Lamp, Burnt Toast, ...

    * Klaus
        |
        * Blizzard Staff (Weapon): Better Ice staff with Ice AOE attack.

        * Eruption Staff (Weapon): Better Fire staff with Fire AOE attack.

        * ??? (Accessory): Increases naughtiness by 2 points when killing any creature.

        * Bewitching Compass: Tracks and makes the Loot Stash visible over the fog on the minimap.

        * Trinkets: Keyring, ...

        Enraged Loot:
            |
            * Mini Loot Stash (Portable Storage): 4 slots container with infinite stacking
            that works similar to Polar Bearger Bin.

    [ Accessories ]
    * Make Accessory System
        |
        A new inventory slot that players can equip accessories and gain bonuses. [DONE]

    * Accessory Slot is limited to 1 equip at a time, but players can combine accessories into new ones using a station.
        |
        Combining accessories keeps both of their bonuses into a single one with new bonuses.

    * Wanna do an accessory in honor of Helicalpuma, something for Maxwell.
        |
        Probably dropped by Shadow Pieces. "Helicalpuma's Might" Flair-like item.

    [ Tinkerer's Workbench ]
    * Station used to combine 2 accessories into a single one.
        |
        Combining Scorched Skull (Fire Immunity) and Magma Charm (Overheat Immunity) 
        will result in the Molten Charm (Fire + Overheat Immunity) plus increased movement speed while on fire.
    
    * When trying to combine accessories, if the combination fails it will simply return the items back.

    [ Trinket Vending Machine ]
    * Add Recipe (costs nothing).
    * Make Trinket Ball that players can open and receive a random trinket.
    * Make Trinket Ball Loot system based on weighted chances. (COMMON, UNCOMMON, RARE, ULTRA RARE, LEGENDARY).
    * Make Cool new trinkets and Donator Trinkets (Need to ask them what trinket they want).

    [ Sewing Machine ]
    * Structure that acts like a Sewing Kit with more uses and repairs 100% of the item.

    [ Critical Strikes ]
    * Add a Crit system.
    * Critical Strikes deals +50% bonus damage.
    * Player starts with 0% Critical Strike Chance. It can be further boosted by items and accessories alike.
    * Some weapons and accessories can override the player's critical strike chance/damage.

    [ Powder Weapon ]
    * A ranged weapon that shoots projectiles of various type. We gonna start with Gunpowder only.
    * Acts like a slingshot with higher damage but has cooldown between shots (Just like real life muzzleloaders).
    * Damage and effects are determined by the projectile used.
    * The projectiles can Critical Strike for even more damage.

    [ Cursed Blades ]
    * Masa
        |
        A sword that grants +5% Critical Strike Chance. Critical Strikes deals bonus damage.
        It has Shadow Allegiance and deals bonus damage against Lunar Aligned creatures.
        It also drains -5 Health every 30 seconds of the wielder if it's Lunar Aligned.

    * Mune
        |
        A sword that grants +5% Critical Strike Chance. Critical Strikes deals bonus damage.
        It has Lunar Allegiance and deals bonus damage against Shadow Aligned creatures.
        It also drains -5 Health every 30 seconds of the wielder if it's Shadow Aligned.

    * Masamune
        |
        A sword that has a penalty of -99% Critical Strike Chance.
        Critical Strikes no longer deals bonus damage, it executes target instead. (Non-bosses).
        It has no Allegiance and deals bonus damage against Lunar and Shadow Aligned creatures.
        It Heals +10 Health every 60 seconds of the wielder if no Allegiance.
        Crafted by combining Masa and Mune.

    * Bloodthirster
        |
        A sword that grants +5% Critical Strike Chance and constantly drains the Health of the wielder.
        Killing targets restores Health, Critical Strikes also restores a bigger portion of health.
        Damage increases as you kill more targets, for a max of 5 stacks. Effects last for 30 seconds, resets on kill. 

--]]-----------------------------------------------------------------------------------------------------------------------------