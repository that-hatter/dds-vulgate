import XLSX
import SQLite

XLSX.readxlsx("resources/SMT TCG Card List.xlsx") do file
  cards = file["Sheet1"]

  ;

end
