### Medidas estadisticas en R ####
#Intro libreria dplyr

### promedio medida de tendencia central ####

x = c(2, 4, 60)
# se usa la formula mean para hacer un promedio - sencible a valores extremos
mean(x)

## puedo tener lo que se conoce como media recortada: promedio sin usar los valores de los extremos, en proporcion el numero de datos que yo quite a la derecha los quito a la izquierda.

x2 = c(1:10, 50, 60, 62)

mean(x2)
mean(x2, trim=0.3)

## media - promedio ponderado ####

# tengo una asignatura (computacion)
#taller 1: 30 %
#taller 2: 30 %
#tareas: 15 %
#expo: 25 %

#taller 1: 4.8
#taller 2: 4.5
#tareas: 4.3
#expo: 3.2

calificaciones = c(4.8, 4.5, 4.3, 3.2)
pesos = c(0.3, 0.3, 0.15, 0.25)

mean(calificaciones)

weighted.mean(calificaciones, w = pesos)

### Mediana ####
# es el valor que separa el 50% de los valores mas altos del 50% de los valores mas bajos

x = c(4, 6000, 2)
median(x)

## cualtiles####
# es el valor que separa el a% de los valores mas altos del 100-a% de los valores mas bajos

data(mtcars)

# cual es el mpg de los autos con el 80%

quantile(mtcars$mpg, probs = 0.8) # 80% de los autos tienen un mpg menor o igual a 24.08
quantile(mtcars$mpg, probs = 0.2) # 20% de los autos tienen un mpg menor o igual a 15.2
quantile(mtcars$mpg, probs = c(0.2, 0.8)) # los saca al mismo tiempo

### desviacion estandar ####
# motivacion
# entre mas cercano a cero, los datos mas cercanos a la media.
# misma unidad de medida que la variable estudiada
# si la rta es 2, es la desviacion promedio respecto al promedio. promedio de que tanto los valores se desvian del promedio.
# si me paro en el promedio, cuanto debo estirar mis brazos en promedio ára alcanzar todos los datos

# ejemplo
# notas de 4 personas, 4, 4, 3, 5, dos niñas y dos niños respectivamente, el promedio de solo niñas
#y de solo niños es 4 en ambos casos, pero los niños estan mas alejados entre si y las diñas no, la
#desv est de las niñas es 0, la de los niños es raiz de 2
sd(mtcars$mpg)
# las millas por galon se desvian del promedio en 6 mpg
#media = 20
#desv = 6
#medida estandarizacion  ####
# como saber quien saco mas entre uno que se presento a la nacho y otro que se presento al icfes
# estandarizacion es intentar llevar las dos cosas a una misma medida
# estandarizacion en general z = (x - median poblacional) /desv estandar poblacional = cuantas desviaciones estoy alejado de la media (si es positivo es encima del promedio, si es negativo, es por debajo del promedio)

# persona 1: 400   persona 2: 600
# media: 250       media: 500
#desv est: 50    desv est: 100

z = (mtcars$mpg - mean(mtcars$mpg))/sd(mtcars$mpg)
z

z[16]
mtcars$mpg[16]

### coeficiente de variacion ####
# permite comparar dos cosas diferentes
# que grupo es mas disperso?

# hijos                ingresos
# media: 3              media: 1000
#desv est: 1            desv est: 1
# coef var:33.33%      coef var:0.1%

#el numero de hijos es mas disperso que el ingrso

xbar = mean(mtcars$mpg)
xdesv = sd(mtcars$mpg)

cv = xdesv/xbar*100
cv

### Correlacion ####
# entre -1 y 1
# se necesitan dos variables. cor(x,y)

# obtenemos la correlacion entre las millas por galon que consume un auto y su peso
cor(mtcars$mpg, mtcars$wt)
plot(mtcars$mpg, mtcars$wt)
cor(mtcars$mpg, mtcars$wt, method="spearman")

data("swiss")
?swiss

# calcule promedio de catolicos (entre provincias)
mean(swiss$Catholic)
# queremos 3 niveles de catolicos - discretizar la variable  con cut
catolicos = cut(swiss$Catholic, breaks = c(0, 33, 66, 100),
                labels = c("bajo", "medio", "alto"))
table(catolicos) #polarizacion, desiguadad si fuera pobreza

# la media no se interpreta sola, es con desv estandar y coef var (medida de asociacion lineal)
sd(swiss$Catholic)
# el promedio no es concluyente pues el coef var es demasiado alto
xbar = mean(swiss$Catholic)
xdesv = sd(swiss$Catholic)

cv = xdesv/xbar*100
cv

# promedio por numero de cilindros
table(mtcars$cyl)

mpg4 = mtcars$cyl[mtcars$cyl == 6]
mean(mpg4)


###dplyr secenciacion %>% pipe ctrl shinf m ####

# select, seleccionar colubas
library(dplyr)
colnames(mtcars)
mtcars[,c(1,6)]
mtcars %>% select(mpg, wt)
























