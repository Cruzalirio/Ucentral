#### Bienvenidos ####
rm(list=ls())
### R es una calculadora ####
4+3

5*4

5+6+7*8

(-1)^(0.5)
(-1+0i)^0.5

#### warning ####

x

#### error ####


10^(-16)
10^100
#### 1e-16 es igual a 1*10^(-16)
#### algebra logica ####
2>1
3<2
3==6
3!=0

3=6
# Nota:
# - NA   : "Not Available", no disponible.
# - NULL : objeto "vacio"
# - NaN  : "Not a Number", no es un numero 

datos=c(1,2,3,NA,5,6)
log(datos)


#### operaciones logicas ####
3>2 | 4/5<7/8 
3>2 | 4/5==7/8 
1>2 | 4/5==7/8


3>2 & 4/5<7/8 
3>2 & 4/5 == 7/8 
1>2 & 4/5 == 7/8



#### Funciones ####

cos(1)
tan(3)
tan(90)
tan(pi/2)
sqrt(6)
6^0.5
6^(1/2)
log(exp(1))

? exp
log(23, pi)
# graficas

curve(sin(x))

curve(sin(x), from=0, to=2*pi)

abline(h=0)

abline(v=0)

abline(a=0, b=1)

abline(a=4, b=-1)
warnings()
abline(a=3, b=-1, col=5)
abline(a=2, b=-1, col="red")
abline(a=2, b=1, col=red)
 