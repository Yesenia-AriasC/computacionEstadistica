# los VECTORES solo admiten un tipo de dato
# coercionar -> forzar un tipo de dato

x = "2"
class(x)

x = as.numeric(x)
class(x)

y = "ocho"
y = as.numeric(y)
class(y)
y
#y da NA not available, no disponible.r solo ve una cadena de caracteres

notas1 = c(2, 3.1, "3.4")
notas1
notas1= as.numeric(notas1)
notas1

notas2 = c(2, 3.1, "me perdi")
notas2= as.numeric(notas2)
notas2
# vemos que no pudimos coercionar el texto pero el resto al parecer si

### Listas ####
# PERMITEN ALMACENAR MAS DE UN TIPO DE DATO
# pueden contener vectores
lista1 = list(estudiante = "sergio", notas = c(4.5, 3.8, 4.9), asignaturas = c("CE", "Matricial", "Multivariada"))
lista1
# podemos acceder a los elementos de una lista con [[]]
# accedamos al primer elemento
lista1[[2]]
lista1$notas
class(lista1)

### Factores ####
#
estratos = c("bajo", "medio", "alto", "medio", "bajo", "bajo")
length(estratos)
estratos
class(estratos)
sort(estratos) #ordenar por defecto / alfabeticmente
estratosf <- factor(c("bajo", "medio", "alto", "medio", "bajo", "bajo"))
estratosf
# nombre_funcion(objeto, arg1, arg2, ... )      los argumentos no tienen orden determinado

estratosf <- factor(c("bajo", "medio", "alto", "medio", "bajo", "bajo"), levels = c("bajo", "medio", "alto"))
estratosf

estratosf <- factor(c("bajo", "medio", "alto", "medio", "bajo", "bajo"), levels = c("bajo", "medio", "alto"), ordered = TRUE) # por defecto ordered viene falso
estratosf

#podemos ver el conteo por niveles
table(estratosf)


### Matrices ####
# arreglo rectangular de datos
#para crear una matrix usamos la funcion matrix
#argumento byrow viene falso

matriz1 <- matrix(c(1:10)) # secuencia de enteros, no hace falta la c
matriz1 <- matrix(1:10, ncol = 2, nrow = 5)
matriz1

matriz1 <- matrix(1:10, ncol = 3, nrow = 5) # lanza un warning pero ejecuta
matriz1

matriz1 <- matrix(1:10, ncol = 3, nrow = 5, byrow = TRUE) # lanza un warning pero ejecuta
matriz1  # llena por columna

# para transponer es con funcion t de transpose
t(matriz1)
dim(matriz1) # filas columnas

### dataframes ####
#columnas variables, filas observaciones. n individuos p variables
# arreglo de datos que va mas alla de las matrices porque ellas solo aceptan vectores que solo aceptan un tipo de dato
# permite tener distintos tipos de datos
# usaremos un dataframe existente mtcars

data("mtcars")
View(mtcars)

# Antes de empezar un analisis de datos es importante tener el contexto de los datos, entenderlos.
# contexto mtcars: autos de los 70's 
# al crear funciones creemos documentaciones

help(mtcars)
?mtcars # diccionarios de datos, nombres de variables cortos en R, y para saber cuales son hacemos un diccionario de datos

## slicing

### df[filas, columbas]
mtcars[3,4] # tercer auto, cuarta variable

# puedo reemplazar un valor
mtcars[3,4] = 100
mtcars[3,4]

## quiero las filas 3, 4 y las columbas 5 y 6
mtcars[3:4,5:6]
mtcars[c(3,4), c(5,6)]

# quiero tomar todas las variables de la fila1
mtcars[1,1:11]
mtcars[1,] # mejor opcion

#quiero tomar toda la fila (todos los registros) de la primer variable
mtcars[,1]
# quiero todas las columnas excepto 1 a 5
mtcars[,-1:-5]
# quiero tomar primera fila y todas las columnas menos la variabl e 4 y 10
mtcars[1,-c(4,10) ]


# quiero comprar un carro que se ajuste a mis gustos
mtcars$cyl
#quiero los autos con 4 cilindros
mtcars$cyl == 4

class(mtcars$cyl) # el numero de cilindros dice que es numerico, pero por entendimiento de los datos deberia ser factor (categorico)

mtcars[mtcars$cyl == 4,] #individuos que tienen 4 cilindros

# indivituos con 4 cilindros y con millas por galon altas

mtcars[mtcars$cyl == 4 & mtcars$mpg >= 25,]
dim(mtcars[mtcars$cyl == 4 & mtcars$mpg >= 25,])
nrow(mtcars[mtcars$cyl == 4 & mtcars$mpg >= 25,]) #num filas

# creemos un dataframe de autos comprables de acuerdo a nuestras condiciones
comprables = mtcars[mtcars$cyl == 4 & mtcars$mpg >= 25,]
comprables

# puedo crear nuevas columnas
# necesito saber relacion peso y galoes porque se relacionan
comprables$rendimiento = comprables$mpg/comprables$wt

# crear variable-columna de cadena de caracteres
comprables$ojito = "lo dejé mirado"