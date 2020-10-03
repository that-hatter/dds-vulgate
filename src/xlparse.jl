module XLParse
export generateallentries, DBEntry, XLRaw

include("./enums.jl")
include("./dicts.jl")

using XLSX
using SQLite
using .Enums
using .Dicts 

ss = XLSX.openxlsx("./src/resources/SMT TCG Card List.xlsx")["Sheet1"]

struct XLRaw
  id::String
  name::String
  cost::String
  att::String
  lvlrace::String
  type::String
  emit::String
  eff1::String
  eff2::String
  res::String
  weak::String
  atk::String
  hp::String
  flavor::String
end

struct DBEntry
  id::Int
  role::Int
  type::Int
  level::Int
  race::Int
  fusion::Int
  gender::Int
  categ::Int
  usage::Int
  atk::Int
  hp::Int
  alignment::Int
  attribute::Int
  weakness::Int
  resistance::Int
  cost_neutral::Int
  cost_law::Int
  cost_chaos::Int
  cost_light::Int
  cost_dark::Int
  emit_neutral::Int
  emit_law::Int
  emit_chaos::Int
  emit_light::Int
  emit_dark::Int
  name::String
  flavor::String
  ability1::String
  ability2::String
  effect1::String
  effect2::String
end

function makeraw(r::XLSX.TableRow)::Union{XLRaw, Nothing}
  try
    vals = Array(1:14) .|> (i -> XLSX.getdata(r, i))
    return ismissing(vals[14]) ? XLRaw(vals[1:13]..., "Dummy Flavor") : XLRaw(vals...)
  catch
    @warn ("Unable to generate raw: " * string(r.row))
    return nothing
  end
end

function getid(r::XLRaw)::Int
  try
    if startswith(r.id, "G")
      return Int(Enums.G) + parse(Int, r.id[2:end])
    elseif startswith(r.id, "P")
      return Int(Enums.P) + parse(Int, r.id[2:end])
    elseif startswith(r.id, "S")
      return Int(Enums.S) + parse(Int, r.id[2:end])
    end
    return parse(Int, r.id)
  catch
    @warn ("Unable to fetch id: " * r.id)
    return 0
  end
end

function getrole(r::XLRaw)::Int
  try
    if startswith(r.lvlrace, "Lv.")
      return Int(Enums.Demon)
    elseif endswith(r.lvlrace, "ale")
      return Int(Enums.Partner)
    elseif (r.type === "[N/A]")
      return Int(Enums.Spell)
    elseif (r.att === "[N/A]")
      return Int(Enums.Item)
    end
    throw(error("Unable to fetch role: " * r.id))
  catch e
    @warn e
    return 0
  end
end

function gettype(r::XLRaw)::Int
  try
    return Dicts.types[strip(r.type)] |> Int
  catch
    @warn ("Unable to fetch type: " * r.id)
    return 0
  end
end

function getlevel(r::XLRaw)::Int
  try 
    return parse(Int, split(r.lvlrace, " ")[2])
  catch
    @warn ("Unable to fetch level: " * r.id)
    return 0
  end
end

function getrace(r::XLRaw)::Int
  try
    return Dicts.races[split(r.lvlrace, " ")[3]] |> Int
  catch
    @warn ("Unable to fetch race: " * r.id)
    return 0
  end
end

function getfusion(r::XLRaw)::Int
  try
    ws = occursin("\n", r.att) ? "\n" : " "
    return Dicts.fusions[strip(split(r.att, ws)[1])] |> Int
  catch
    @warn ("Unable to fetch fusion: " * r.id)
    return 0
  end
end

function getgender(r::XLRaw)::Int
  try
    return Dicts.genders[r.lvlrace] |> Int
  catch
    @warn ("Unable to fetch gender: " * r.id)
    return 0
  end
end

function getcateg(r::XLRaw)::Int
  try
    return Dicts.categs[strip(split(r.type, "\n")[2])] |> Int
  catch
    @warn ("Unable to fetch categ: " * r.id)
    return 0
  end
end

function getusage(r::XLRaw)::Int
  try
    return Dicts.usages[strip(split(r.type, "\n")[1])] |> Int
  catch
    @warn ("Unable to fetch usage: " * r.id)
    return 0
  end
end

function getatk(r::XLRaw)::Int
  try
    return parse(Int, r.atk)
  catch
    @warn ("Unable to fetch atk: " * r.id)
    return 0
  end
end

function gethp(r::XLRaw)::Int
  try
    return parse(Int, r.hp)
  catch
    @warn ("Unable to fetch hp: " * r.id)
    return 0
  end
end

function getalignment(r::XLRaw)::Int
  try
    ws = occursin("\n", r.att) ? "\n" : " "
    alns = split(split(r.att, ws)[2], "/") .|> strip
    return Int(Dicts.alignments[alns[1]]) | Int(Dicts.alignments[alns[2]])
  catch
    @warn ("Unable to fetch alignment: " * r.id)
    return 0
  end
end

function getattribute(r::XLRaw)::Int
  try
    return Dicts.attributes[strip(r.att)] |> Int
  catch
    @warn ("Unable to fetch attribute: " * r.id)
    return 0
  end
end

function getweakness(r::XLRaw)::Int
  try
    if occursin(",", r.weak)
      atts = split(r.weak, ",") .|> (str -> Dicts.attributes[strip(str)] |> Int)
      return reduce(|, atts)
    elseif occursin("/", r.weak)
      atts = split(r.weak, "/") .|> (str -> Dicts.attributes[strip(str)] |> Int)
      return reduce(|, atts)
    end
    return r.weak === "[None]" ? 0 : Int(Dicts.attributes[strip(r.weak)])
  catch
    @warn ("Unable to fetch weakness: " * r.id)
    return 0
  end
end

function getresistance(r::XLRaw)::Int
  try
    if occursin(",", r.res)
      atts = split(r.res, ",") .|> (str -> Dicts.attributes[strip(str)] |> Int)
      return reduce(|, atts)
    elseif occursin("/", r.res)
      atts = split(r.res, "/") .|> (str -> Dicts.attributes[strip(str)] |> Int)
      return reduce(|, atts)
    end
    return r.res === "[None]" ? 0 : Int(Dicts.attributes[strip(r.res)])
  catch
    @warn ("Unable to fetch resistance: " * r.id)
    return 0
  end
end

function parsemagset(s::String)::Tuple{Int, Int, Int, Int, Int}
  mags = Dict(
    Enums.Neutral => 0,
    Enums.Law => 0,
    Enums.Chaos => 0,
    Enums.Light => 0,
    Enums.Dark => 0
  )

  neutsplit = split(s, "/")
  if length(neutsplit) == 2
    mags[Enums.Neutral] = parse(Int, neutsplit[2])
  end

  parts = split(neutsplit[1], " ")
  if length(parts) == 1
    mags[Enums.Neutral] = parse(Int, parts[1])
  else
    for i in [2, 4, 6, 8, 10]
      if length(parts) < i
        break
      end
      att = Dicts.alignments[strip(parts[i - 1])] |> Int |> Enums.Alignment
      mags[att] = parse(Int, parts[i])
    end
  end

  return mags[Enums.Neutral],
    mags[Enums.Law],
    mags[Enums.Chaos],
    mags[Enums.Light],
    mags[Enums.Dark]
end

function getcosts(r::XLRaw)::Tuple{Int, Int, Int, Int, Int}
  try
    return parsemagset(r.cost)
  catch
    @warn ("Unable to fetch cost: " * r.id)
    return 0, 0, 0, 0, 0
  end
end

function getemits(r::XLRaw)::Tuple{Int, Int, Int, Int, Int}
  try
    return parsemagset(r.emit)
  catch
    @warn ("Unable to fetch emits: " * r.id)
    return 0, 0, 0, 0, 0
  end
end

function spaceify(s::String)::String
  return join(split(strip(s), "\n"), " ")
end

function geteffects(r::XLRaw, role::Int)::Tuple{String, String, String, String}
  try
    if role == Int(Enums.Item) || role == Int(Enums.Spell)
      return spaceify(r.eff1), "[N/A]", "[N/A]", "[N/A]"
    elseif r.eff2 !== "[None]"

      paren1, paren2 = findfirst('(', r.eff1), findfirst('(', r.eff2)
      return spaceify(r.eff1[paren1:end]), 
        spaceify(r.eff2[paren2:end]), 
        r.eff1[begin:paren1 - 2], 
        r.eff2[begin:paren2 - 2]

    else
      paren = findfirst('(', r.eff1)
      return spaceify(r.eff1[paren:end]), "[None]", r.eff1[begin:paren - 2], "[None]"
    end
  catch
    @warn ("Unable to fetch effects/abilities: " * r.id)
    return "???", "???", "???", "???"
  end
end

function generatedemon(r::XLRaw)::DBEntry
  e1, e2, a1, a2 = geteffects(r, Int(Enums.Demon))
  return DBEntry(
    getid(r),           # id
    Int(Enums.Demon),   # role
    gettype(r),         # type
    getlevel(r),        # level
    getrace(r),         # race
    getfusion(r),       # fusion
    0,                  # gender
    0,                  # categ
    0,                  # usage
    getatk(r),          # atk
    gethp(r),           # hp
    getalignment(r),    # alignment
    0,                  # attribute
    getweakness(r),     # weakness
    getresistance(r),   # resistance
    getcosts(r)...,     # costs
    getemits(r)...,     # emits
    r.name,
    r.flavor,
    a1, a2, e1, e2
  )
end

function generatepartner(r::XLRaw)::DBEntry
  e1, e2, a1, a2 = geteffects(r, Int(Enums.Partner))
  return DBEntry(
    getid(r),           # id
    Int(Enums.Partner), # role
    gettype(r),         # type
    0,                  # level
    0,                  # race
    0,                  # fusion
    getgender(r),       # gender
    0,                  # categ
    0,                  # usage
    getatk(r),          # atk
    gethp(r),           # hp
    0,                  # alignment
    0,                  # attribute
    0,                  # weakness
    0,                  # resistance
    0, 0, 0, 0, 0,      # costs
    getemits(r)...,     # emits
    r.name,
    r.flavor,
    a1, a2, e1, e2
  )
end

function generatemagic(r::XLRaw)::DBEntry
  e1, e2, a1, a2 = geteffects(r, Int(Enums.Spell))
  return DBEntry(
    getid(r),           # id
    Int(Enums.Spell),   # role
    0,                  # type
    0,                  # level
    0,                  # race
    0,                  # fusion
    0,                  # gender
    0,                  # categ
    0,                  # usage
    0,                  # atk
    0,                  # hp
    0,                  # alignment
    getattribute(r),    # attribute
    0,                  # weakness
    0,                  # resistance
    getcosts(r)...,     # costs
    0, 0, 0, 0, 0,      # emits
    r.name,
    r.flavor,
    a1,
    a2,
    e1,
    e2
  )
end

function generateitem(r::XLRaw)::DBEntry
  e1, e2, a1, a2 = geteffects(r, Int(Enums.Item))
  return DBEntry(
    getid(r),         # id
    Int(Enums.Item),  # role
    0,                # type 
    0,                # level
    0,                # race
    0,                # fusion
    0,                # gender
    getcateg(r),      # categ
    getusage(r),      # usage
    0,                # atk
    0,                # hp
    0,                # alignment
    0,                # attribute
    0,                # weakness
    0,                # resistance
    getcosts(r)...,   # costs
    0, 0, 0, 0, 0,    # emits
    r.name,
    r.flavor,
    a1, a2, e1, e2
  )
end

function generateDBentry(raw::XLRaw)::Union{DBEntry, Nothing}
  role = getrole(raw)
  if role == Int(Enums.Demon)
    return generatedemon(raw)
  elseif role == Int(Enums.Partner)
    return generatepartner(raw)
  elseif role == Int(Enums.Spell)
    return generatemagic(raw)
  elseif role == Int(Enums.Item)
    return generateitem(raw)
  end
  @warn ("Unable to resolve Role: " * raw.id)
  return nothing
end

function generateallentries()::Array{DBEntry}
  out::Array{DBEntry} = []
  for r in XLSX.eachtablerow(ss)
    # if r.row > 1 
    #   continue
    # end

    raw = makeraw(r)
    if isnothing(raw)
      println("Stopped at " * string(r.row))
      break
    end

    ent = generateDBentry(raw)
    if isnothing(ent)
      @warn ("Unable to add " * raw.id)
      continue
    end
    push!(out, ent)
  end
  return out
end

end # module XLParse