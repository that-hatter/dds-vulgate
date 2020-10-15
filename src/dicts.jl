module Dicts
export types, genders, fusions, races, attributes, categs, usages

include("./enums.jl")
import .Enums

types = Dict(
  "Grounded" => Enums.Grounded,
  "Flying" => Enums.Flying
)

genders = Dict(
  "Male" => Enums.Male,
  "Female" => Enums.Female
)

fusions = Dict(
  "Normal" => Enums.Normal,
  "Double-fused" => Enums.Double,
  "Tri-fused" => Enums.Triple
)

races = Dict(
  "Deity" => Enums.Deity,
  "Megami" => Enums.Megami,
  "Herald" => Enums.Herald,
  "Avian" => Enums.Avian,
  "Tree" => Enums.Tree,
  "Genma" => Enums.Genma,
  "Avatar" => Enums.Avatar,
  "Holy" => Enums.Holy,
  "Enigma" => Enums.Enigma,
  "Hero" => Enums.Hero,
  "Fury" => Enums.Fury,
  "Lady" => Enums.Lady,
  "Kishin" => Enums.Kishin,
  "Dragon" => Enums.Dragon,
  "Divine" => Enums.Divine,
  "Flight" => Enums.Flight,
  "Yoma" => Enums.Yoma,
  "Fairy" => Enums.Fairy,
  "Snake" => Enums.Snake,
  "Beast" => Enums.Beast,
  "Jirae" => Enums.Beast,
  "Night" => Enums.Night,
  "Fallen" => Enums.Fallen,
  "Brute" => Enums.Brute,
  "Femme" => Enums.Femme,
  "Vile" => Enums.Vile,
  "Raptor" => Enums.Raptor,
  "Wood" => Enums.Wood,
  "Reaper" => Enums.Reaper,
  "Wilder" => Enums.Wilder,
  "Jaki" => Enums.Jaki,
  "Undead" => Enums.Undead,
  "Vermin" => Enums.Vermin,
  "Tyrant" => Enums.Tyrant,
  "Drake" => Enums.Drake,
  "Haunt" => Enums.Haunt,
  "Spirit" => Enums.Spirit,
  "Foul" => Enums.Foul,
  "Entity" => Enums.Entity,
  "Zealot" => Enums.Zealot,
  "General" => Enums.General,
  "UMA" => Enums.Uma,
  "Zoma" => Enums.Zoma,
  "Rumor" => Enums.Rumor,
  "Element" => Enums.Element,
  "Godly" => Enums.Godly,
  "Ghost" => Enums.Ghost,
  "Cyber" => Enums.Cyber,
  "Amatsu" => Enums.Amatsu,
  "Mitama" => Enums.Mitama,
  "Kunitsu" => Enums.Kunitsu,
  "Machine" => Enums.Machine,
  "Fiend" => Enums.Fiend,
  "Great" => Enums.Great,
  "Kohi" => Enums.Kohi,
  "Shinshou" => Enums.Shinshou,
  "Tenma" => Enums.Tenma,
  "Vaccine" => Enums.Vaccine,
  "Virus" => Enums.Virus,
  "Deity Emperor" => Enums.DeityEmperor,
  "Messian" => Enums.Messian,
  "Therian" => Enums.Therian,
  "Touki" => Enums.Therian,
  "Gaean" => Enums.Gaean,
  "Meta" => Enums.Meta,
  "Ranger" => Enums.Ranger
)

alignments = Dict(
  "Light" => Enums.Light,
  "Dark" => Enums.Dark,
  "Neutral" => Enums.Neutral,
  "Law" => Enums.Law,
  "Chaos" => Enums.Chaos
)

attributes = Dict(
  "Phys" => Enums.Phys,
  "Magic" => Enums.Spell,
  "Fire" => Enums.Fire,
  "Ice" => Enums.Ice,
  "Electric" => Enums.Electric,
  "Force" => Enums.Force,
  "Psy" => Enums.Psy,
  "Expel" => Enums.Expel,
  "Death" => Enums.Death,
  "Almighty" => Enums.Almighty,
  "Curse" => Enums.Curse,
  "Sealing" => Enums.Sealing,
  "Restoration" => Enums.Restoration,
  "Reflect" => Enums.Reflect,
  "Paralyze" => Enums.Paralyze
)

categs = Dict(
  "Tool" => Enums.Tool,
  "Electronic" => Enums.Electronic,
  "Armor" => Enums.Armor,
  "Weapon" => Enums.Weapon,
  "Jewel" => Enums.Jewel,
  "Talisman" => Enums.Talisman,
  "Sword" => Enums.Sword,
  "VR Theater" => Enums.Theater
)

usages = Dict(
  "Placed" => Enums.Placed,
  "Equipment" => Enums.Equipment,
  "Consumable" => Enums.Consumable,
  "Instant" => Enums.Instant
)

end # module Dicts