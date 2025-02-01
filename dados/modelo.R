rm(list = ls())

install.packages("lmtest")   # Para o teste de Wald e heterocedasticidade
install.packages("car")      # Para o teste de VIF
install.packages("pscl")     # Para o Pseudo R²
install.packages("sandwich") # Para erros padrão robustos

# Carregando os pacotes
library(lmtest)
library(car)
library(pscl)
library(sandwich)
setwd("C:/Users/brand/Documents/André Filipe/Estudos/PPGE-UFPB/Obrigatórias/econometria/trabalho/dados")
df <- read.csv('tratamento1.csv')

modelo1_logit <- glm(fundamental_completo ~ HOMEM + BRANCO, data = df, family = binomial(link = "logit"))
modelo2_logit <- glm(medio_completo ~ HOMEM + BRANCO, data = df, family = binomial(link = "logit"))
modelo3_logit <- glm(superior_completo ~ HOMEM + BRANCO, data = df, family = binomial(link = "logit"))

# Resumo dos resultados
resumo1 = summary(modelo1_logit)
resumo2 = summary(modelo2_logit)
resumo3 = summary(modelo3_logit)
resumo1
resumo2
resumo3

modelos <- list(modelo1_logit, modelo2_logit, modelo3_logit)

# 3. Teste de VIF (Fator de Inflação da Variância)
# Usando a função `vif` do pacote `car`
for (m in modelos){
vif_resultado <- vif(m)
print("Fator de Inflação da Variância (VIF):")
print(vif_resultado)}


#4. Teste de Heterocedasticidade (Breusch-Pagan)
# Usando a função `bptest` do pacote `lmtest`
# Para modelos logit, é comum usar uma versão adaptada do teste
for (m in modelos){ 
teste_bp <- bptest(m, studentize = TRUE)
print("Teste de Breusch-Pagan para Heterocedasticidade:")
print(teste_bp)}

for (m in modelos){
robust_se <- sqrt(diag(vcovHC(m, type = "HC1")))
print(robust_se)
}
# Exibir resultados com erros padrão robustos
for (m in modelos){
print(coeftest(m, vcov = vcovHC(m, type = "HC1")))
}
