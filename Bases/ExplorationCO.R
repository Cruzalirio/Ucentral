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

occup_hora <- occ %>% group_by(area, wave, hours, sensor, prev_wave) %>%
  summarise(n=n(), n_occup=sum(reading)) %>% arrange(sensor, wave) %>% 
  mutate(prop = n_occup/n) 

hourly_occ <- occ[, sum(binocc, na.rm = TRUE), by = c("area", "wave", "group", "date","hours", "prev_wave")] # Create a frame of mean occupancy per hour.


