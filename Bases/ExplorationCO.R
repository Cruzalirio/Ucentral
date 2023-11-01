rm(list=ls())

library(data.table)
library(MASS)
library(tidyverse)
library(gee)
library(corrplot)
library(geepack)
library(xtable)
library(CrossCarry)


load("~/Doctorado/SegundoArticulo/pone.0232943.s001/data/Hora.RData")
setwd("~/Doctorado/SegundoArticulo/pone.0232943.s001/data")
occ <- fread("./desk_occupancy.csv")
anasurv <- fread("./cleansurvey.csv")

occ <- occ %>% mutate(hora = paste(date, time, sep=" ")) %>% 
  mutate(Fecha = ymd_hms(hora)) %>% mutate(minute = minute(hora)) %>% 
  mutate(minute = hours+minute/60)

############################################################
######## Acumulando por hora ################################
##############################################################

occup_hora <- occ %>% group_by(area, wave, hours, group, sensor, prev_wave) %>%
  summarise(n=n(), n_occup=sum(reading)) %>% arrange(sensor, wave) %>% 
  mutate(prop = n_occup/n) 

rm(occ)

occup_hora <- occup_hora %>% filter(hours!=13) %>% 
  arrange(group, wave, hours, sensor) %>% 
  group_by(group, wave, hours) %>%
  mutate(conteo=1:n()) %>%
  mutate(id = paste("Grupo ",group, "- Sensor", conteo)) %>% 
  mutate(id=as.factor(id)) %>% 
  mutate(id=factor(as.numeric(id)))
#############################################################
### graficar ################################################

occup_hora %>% ggplot(aes(x=hours, y=prop,
                          group=interaction(id,wave,area),
                          color=area))+
  geom_line()+facet_wrap(.~group)


occup_hora %>% group_by(group, wave, area, hours) %>% 
  summarise(propPromedio = mean(prop)) %>% 
ggplot(aes(x=hours, y=propPromedio,
                          group=interaction(wave,area),
                          color=area))+
  geom_line()+facet_wrap(.~group)


############################################################
#### Modelado  #############################################

library(CrossCarry)

datosCarry <- createCarry(data = occup_hora, 
                          treatment = "area",
                          period="wave",
                          id="id",
                          carrySimple = FALSE)

modSP = CrossGEESP(response="prop", period="wave", treatment = "area",
                   id = "id", time="hours", carry=datosCarry$carryover, 
                   data=datosCarry$data)

summary(modSP$model)

modSP$graphs$hours+coord_cartesian(xlim=c(9,18))


modSP$graphs$Carry_Campus_over_Control+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Campus_over_Menu+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Campus_over_Nest+coord_cartesian(xlim=c(9,18))


modSP$graphs$Carry_Control_over_Campus+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Control_over_Menu+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Control_over_Nest +coord_cartesian(xlim=c(9,18))


modSP$graphs$Carry_Menu_over_Campus+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Menu_over_Control+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Menu_over_Nest +coord_cartesian(xlim=c(9,18))



modSP$graphs$Carry_Nest_over_Campus+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Nest_over_Control+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Nest_over_Menu +coord_cartesian(xlim=c(9,18))






############################################################
######## Acumulando por minuto hora #########################
##############################################################

occ <- fread("./desk_occupancy.csv")

ntemp = 10
occ <- occ %>% mutate(hora = paste(date, time, sep=" ")) %>% 
  mutate(Fecha = ymd_hms(hora)) %>% mutate(minute = floor(minute(hora)/ntemp)) %>% 
  mutate(minute = hours+ntemp*minute/60)


occup_hora <- occ %>% group_by(area, wave, minute, group, sensor, prev_wave) %>%
  summarise(n=n(), n_occup=sum(reading)) %>% arrange(sensor, wave) %>% 
  mutate(prop = n_occup/n) 


occup_hora <- occup_hora %>% filter(floor(minute)!=13) %>% 
  arrange(group, wave, minute, sensor) %>% 
  group_by(group, wave, minute) %>%
  mutate(conteo=1:n()) %>%
  mutate(id = paste("Grupo ",group, "- Sensor", conteo)) %>% 
  mutate(id=as.factor(id)) %>% 
  mutate(id=factor(as.numeric(id)))

rm(occ)

#############################################################
### graficar ################################################


occup_hora %>% group_by(group, wave, area, minute) %>% 
  summarise(propPromedio = mean(prop)) %>% 
  mutate(Group = paste("Group", group)) %>% 
  ggplot(aes(x=minute, y=propPromedio,
             group=interaction(wave,area),
             color=area))+
  geom_line()+facet_wrap(.~Group)+
  xlab("Work time")+
  ylab("Proportion of times the worker is busy sitting")


############################################################
#### Modelado  #############################################

library(CrossCarry)

datosCarry <- createCarry(data = occup_hora, 
                          treatment = "area",
                          period="wave",
                          id="id",
                          carrySimple = FALSE)

modSP = CrossGEESP(response="prop", period="wave", treatment = "area",
                   id = "id", time="minute", carry=datosCarry$carryover, 
                   data=datosCarry$data, nodes=10)

aaa = summary(modSP$model)
xtable(aaa$coefficients, digits=4)

library(xtable)
xtable(anova(modSP$model))
modSP$QIC

modSP$graphs$minute+coord_cartesian(xlim=c(9.5,17.5))+xlab("Work time")+
  ylab("Effects of times the worker in the proportion")


modSP$graphs$Carry_Campus_over_Control+coord_cartesian(xlim=c(9.5,17.5))+
  xlab("Work time")+
  ylab("First order carry-over effect of the treatment B over treatment A")

modSP$graphs$Carry_Campus_over_Menu+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Campus_over_Nest+coord_cartesian(xlim=c(9,18))


modSP$graphs$Carry_Control_over_Campus+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Control_over_Menu+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Control_over_Nest +coord_cartesian(xlim=c(9,18))


modSP$graphs$Carry_Menu_over_Campus+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Menu_over_Control+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Menu_over_Nest +coord_cartesian(xlim=c(9,18))



modSP$graphs$Carry_Nest_over_Campus+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Nest_over_Control+coord_cartesian(xlim=c(9,18))
modSP$graphs$Carry_Nest_over_Menu +coord_cartesian(xlim=c(9,18))


