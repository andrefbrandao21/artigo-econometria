#install.packages('PNADcIBGE')
rm(list = ls())

library(PNADcIBGE)

df <- data.frame()
vars = c("UF", "V2007", "V2009", "V2010", "VD3004", "VD3005")
for (q in seq(1,4)){
  d <- get_pnadc(year = 2023, quarter = q, vars = vars)
  d <- d$variables
  d <- d[c("Ano", "Trimestre",  "UF", "V2007", "V2009", "V2010", "VD3004", "VD3005")]
  df <- rbind(df, d)
}


getwd()
write.csv(df, "dados_exportados.csv", row.names = FALSE)
