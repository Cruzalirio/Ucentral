#### vectores de datos ####
x=c(3,4,6,2,3,4,5,6) 
str(x)
sum(x)

length(x)

sum(x)/length(x)

mean(x)


5*x

y=sin(x)
y<-sin(x)
sin(x)->yy
sin(x)=yy ## Error

sin(x)

x>3

x[x>3]

x[x>2 & x<5]

x[x>2 & x<=5]
x[x<=2 & x>=5]

z=c("S", "S", "D", "D")
str(z)
zz=as.factor(z)
z[z=="S"]
z[z=="M"]

v1=c(1,2,3,4,5,6)
v2=c("S", "S", "D", "D", "S", "D")

v2[v1==2]
v2[v2=="S" & v1<2]

y=cos(x)
y

acos(y)

x+3

z=x+3

z^2

#### Algebra lineal
### Escribir una matriz
unamatriz=matrix(c(2,2,3,
                   4,5,6,
                   7,8,9), ncol=3, nrow=3, byrow=T)

unamatriz

### Operaciones basicas
det(unamatriz)
eigen(unamatriz)
svd(unamatriz)
chol(unamatriz) ### La matriz no es definida positiva
###Transpuesta

t(unamatriz)


###Un vector fila
unvector=c(1,2,3)

### No funciona como producto
unvector*unamatriz

### Producto de matrices
unvector%*%unamatriz

### Sistemas de ecuaciones Ax=b

A=matrix(c(2,3,4,5,8,9,100,20,30), ncol=3, byrow=T) 
x=c(1,2,3)

solve(A,x)

solve(b,x)

solve(A,b)







