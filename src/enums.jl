module Enums
export Role, Type, Gender, Fusion, Race, Alignment, Attribute, Categ, Usage, Series
#----------------------------------
# card info constants
#----------------------------------

# type of card
@enum Role begin
  Demon = 1
  Partner
  Spell
  Item
end

# battle position of demon or partner
@enum Type begin
  Grounded = 1
  Flying
end

# gender of partner
@enum Gender begin
  Male = 1
  Female
end

# fusion type according to required materials
@enum Fusion begin
  Normal = 0
  Double = 2
  Triple = 3
end

# race of demon
@enum Race begin
  Deity = 1
  Megami
  Herald
  Avian
  Tree
  Genma
  Avatar
  Holy
  Enigma
  Hero
  Fury
  Lady
  Kishin
  Dragon
  Divine
  Flight
  Yoma
  Fairy
  Snake
  Beast
  Jirae
  Night
  Fallen
  Brute
  Femme
  Vile
  Raptor
  Wood
  Reaper
  Wilder
  Jaki
  Undead
  Vermin
  Tyrant
  Drake
  Haunt
  Spirit
  Foul
  Entity
  Zealot
  General
  Uma
  Zoma
  Rumor
  Element
  Godly
  Ghost
  Cyber
  Amatsu
  Mitama
  Kunitsu
  Machine
  Fiend
  Great
  Kohi
  Shinshou
  Tenma
  Vaccine
  Virus
  DeityEmperor
  Messian
  Therian
  Touki
  Gaean
  Meta
  Ranger
end

# demon alignment (attribute)
@enum Alignment begin
  Neutral = 0x1
  Law = 0x2
  Chaos = 0x4
  Light = 0x8
  Dark = 0x10
end

# attribute of spell/effect (not demon)
@enum Attribute begin
  Phys = 0x1
  Magic = 0x2
  Fire = 0x4
  Ice = 0x8
  Electric = 0x10
  Force = 0x20
  Psy = 0x40
  Expel = 0x80
  Death = 0x100
  Almighty = 0x200
  Curse = 0x400
  Sealing = 0x800
  Restoration = 0x1000
  Reflect = 0x2000
  Paralyze = 0x4000
end

@enum Categ begin
  Tool = 1
  Electronic
  Armor
  Weapon
  Jewel
  Talisman
  Sword
  Theater
end

# type of item according to usage
@enum Usage begin
  Placed = 1
  Equipment
  Consumable
  Instant
end

@enum Series begin
  Base = 0
  G = 1000000
  P = 2000000
  S = 3000000
end

end # module enums