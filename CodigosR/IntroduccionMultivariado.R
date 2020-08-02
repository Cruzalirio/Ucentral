library(readr)
Datos=read.csv(url("https://raw.githubusercontent.com/Cruzalirio/Ucentral/master/Bases/Cereal.csv"), 
               sep=";", dec=",")
str(Datos)


cuanti=subset(Datos, select=c(3:10))
### Matriz de covarianzas

cov(cuanti)


cor(cuanti)
library(reshape2)
library(ggplot2)
matriz=cor(cuanti)
matriz=melt(matriz)
ggplot(matriz,aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile()

plot(cuanti)


p=ggplot(Datos, aes(x=Fibra, y=Potasio))
p+geom_point()+geom_smooth(method="lm")


p=ggplot(Datos, aes(x=Fibra, y=Potasio))
p+geom_point()+geom_smooth()


v <- ggplot(Datos, aes(Fibra, Potasio))
v + geom_density_2d()

Hepatitis=read.csv(url("https://raw.githubusercontent.com/Cruzalirio/Ucentral/master/Bases/Hepatitis.csv"), 
               sep=";", dec=",", encoding = "latin1")


cuali=subset(Hepatitis, select=-c(2,15:19))

str(cuali)
table(cuali$Sexo, cuali$Esteroides)

table(cuali$Sexo, cuali$Esteroides, cuali$Histologia)


ggplot(Hepatitis, aes(x=Sexo, fill=Esteroides))+geom_bar()

ggplot(Hepatitis, aes(x=Sexo, y=Albumina))+geom_boxplot()+facet_grid(.~Histologia)
ggplot(Hepatitis, aes(x=Albumina, fill=Sexo, alpha=0.5))+geom_density()+facet_grid(.~Histologia)

