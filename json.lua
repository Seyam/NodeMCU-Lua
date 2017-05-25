
  table={X=10,Y=20,Z=30}

  tableToJson=cjson.encode(table)
  print(tableToJson)
  jsonParsed=cjson.decode(tableToJson)
  print(jsonParsed.X.." "..jsonParsed.Y.." "..jsonParsed.Z)