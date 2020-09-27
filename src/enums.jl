module Enums
export Role, Type, Gender, Fusion, Race, Attribute, Categ, Usage, Series
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

# attribute of demon or spell
@enum Attribute begin
  Neutral = 0x1
  Law = 0x2
  Chaos = 0x4
  Light = 0x8
  Dark = 0x10
  Phys = 0x20
  Magic = 0x40
  Fire = 0x80
  Ice = 0x100
  Electric = 0x200
  Force = 0x400
  Psy = 0x800
  Expel = 0x1000
  Death = 0x2000
  Almighty = 0x4000
  Curse = 0x8000
  Sealing = 0x10000
  Restoration = 0x20000
  Reflect = 0x40000
  Paralyze = 0x80000
  Alignments = 0x1f
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