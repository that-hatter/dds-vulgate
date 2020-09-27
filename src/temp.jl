# let races::Array{String} = []

#   for r in XLSX.eachtablerow(ss; header = true)
#     lvlrace = XLSX.getdata(r, 5)
#     if typeof(lvlrace) === String
#       sp = split(lvlrace, " ")
#       if length(sp) >= 3
#         race::String = join(sp[3:end], " ")
#         if findfirst((e -> e === race), races) === nothing
#           println(race)
#           push!(races, race)
#         end
#       end
#     end
#   end

# end