include("./xlparse.jl")

using XLSX
using SQLite
using .XLParse

db = SQLite.DB("./dist/vulgate.db")

function dataSQL(e::XLParse.DBEntry)::String
  return """
    INSERT INTO data (
      emit_dark,
      emit_light,
      emit_chaos,
      emit_law,
      emit_neutral,
      cost_dark,
      cost_light,
      cost_chaos,
      cost_law,
      cost_neutral,
      resistance,
      weakness,
      attribute,
      alignment,
      hp,
      atk,
      usage,
      categ,
      gender,
      fusion,
      race,
      level,
      type,
      role,
      id
    ) VALUES (
      $(e.emit_dark),
      $(e.emit_light),
      $(e.emit_chaos),
      $(e.emit_law),
      $(e.emit_neutral),
      $(e.cost_dark),
      $(e.cost_light),
      $(e.cost_chaos),
      $(e.cost_law),
      $(e.cost_neutral),
      $(e.resistance),
      $(e.weakness),
      $(e.attribute),
      $(e.alignment),
      $(e.hp),
      $(e.atk),
      $(e.usage),
      $(e.categ),
      $(e.gender),
      $(e.fusion),
      $(e.race),
      $(e.level),
      $(e.type),
      $(e.role),
      $(e.id)
    );
  """
end

function sqlify(s::String)::String
  # handles single quotes inside strings to make valid sqlite queries
  # won't be able to handle "'," so let's hope that won't happen
  return "'" * join(split(s, "'"), "''") * "'"
end

function textsSQL(e::XLParse.DBEntry)::String
  return """
  INSERT INTO texts (
    effect2,
    effect1,
    ability2,
    ability1,
    flavor,
    name,
    id
  ) VALUES (
    $(sqlify(e.effect2)),
    $(sqlify(e.effect1)),
    $(sqlify(e.ability2)),
    $(sqlify(e.ability1)),
    $(sqlify(e.flavor)),
    $(sqlify(e.name)),
    $(e.id)
  );
  """
end

for ent in XLParse.generateallentries()
  DBInterface.execute(db, dataSQL(ent))
  DBInterface.execute(db, textsSQL(ent))
end