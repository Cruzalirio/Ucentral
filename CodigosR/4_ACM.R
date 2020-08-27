#### Analisis de Correspondencias Multiples ####

library(FactoMineR)
library(factoextra)

## Cargar base de Hepatitis

url="https://raw.githubusercontent.com/Cruzalirio/Ucentral/master/Bases/Hepatitis.csv"
Hepatitis=read.csv(url, sep = ";")

Base=subset(Hepatitis,select=c(1,3))
table(Base$Clase, Base$Sexo)
acm=MCA(na.exclude(Base), graph = T)
acm$eig
fviz_screeplot(acm, addlabels = TRUE)
fviz_mca_biplot(acm, #repel = TRUE,
               ggtheme = theme_minimal())
fviz_mca_biplot(acm, repel = TRUE,
                ggtheme = theme_minimal(),
                label="var")

fviz_mca_var(acm, choice = "mca.cor", 
repel = TRUE,ggtheme = theme_minimal())

fviz_mca_var(acm,repel = TRUE, 
             ggtheme = theme_minimal())
summary(acm)
acm$ind$coord

###

Base=subset(Hepatitis,select=c(1,3:14))
acm=MCA(na.exclude(Base), graph = T,ncp = 12)
acm$eig
fviz_screeplot(acm, addlabels = TRUE)
fviz_mca_biplot(acm, #repel = TRUE,
                ggtheme = theme_minimal())
fviz_mca_biplot(acm, repel = TRUE,
                ggtheme = theme_minimal(),
                label="var")

fviz_mca_var(acm, choice = "mca.cor", 
             repel = TRUE,ggtheme = theme_minimal())

fviz_mca_var(acm,repel = TRUE, 
             ggtheme = theme_minimal())
summary(acm)
acm$ind$coord

###

url="https://raw.githubusercontent.com/Cruzalirio/Ucentral/master/Bases/Diabetes.csv"
diabetes=read.csv(url, sep=";")
Base=subset(diabetes,select=c(-1))
acm=MCA(na.exclude(Base), graph = T,ncp = 12)
acm$eig
fviz_screeplot(acm, addlabels = TRUE)
fviz_mca_biplot(acm, #repel = TRUE,
                ggtheme = theme_minimal())
fviz_mca_biplot(acm, repel = TRUE,
                ggtheme = theme_minimal(),
                label="var")

fviz_mca_var(acm, choice = "mca.cor", 
             repel = TRUE,ggtheme = theme_minimal())

fviz_mca_var(acm,repel = TRUE, 
             ggtheme = theme_minimal())
summary(acm)
acm$ind$coord
