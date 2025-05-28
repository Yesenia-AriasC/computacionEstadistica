## Sesión 1: Intro a R

## Vamos a crear un objeto numérico llamado x, con el número 3

# Operadores de asignación: =, ->, <-  

x = 3

y <- 4

z = 4.5

x + y

x*y

# mala pr áctica
x*a

a = 3


# Cadenas de caracteres.
# Para crear cadenas de caracteres e hace con comillas simples
# o dobles


nombre1 = "Felipe"

nombre2 = 'Luisa'

## Puedo saber la clase de objeto con la función class

## de qué tipo es el objeto x?

class(x)

class(nombre2)

x + nombre1

numero1 = "34"
numero1

x + nummero1


## vectores
# Paara crear un vector en R, se usa la letra c(),
# los elementos se separan por comas...

# notas:

notas = c(4.9, 3.5, 4.1, 5, 3.2, 2.8, 4.1, 2.8)

notas

# Solo admiten un tipo de dato

notas2 = c(3, 5, 4.1, "ocho", 5)

class(notas2)

notas2 = c(3, 5, 4.1, ocho, 5)


2notas = c(1, 2, 3)

mis notas bellas = c(1 ,4, 3.1 , 2.8)

mis_notas_bellas = c(1, 4, 2.8)

## Tipos de datos lógicos...

# Es un dato que solo puede tener uno de los
# siguientes valores: TRUE o FALSE

# Operadores lógicos:
# >: Mayor que
# >=: Mayor o igual que
# <: Menor
# == igual que
# != distinto de
# ! : no es cierto que...
# &: significa "y"

# x es mayor que y?

x > y

4 >= y  # 4 es mayor o igual que y?


x == 7 # x es igual a 7?

x == 3

## x es igual a 3 y y es igual a 6?

x == 3 & y == 6

x == 3 & y == 4

## Operadaor |  significa "o"

# x es igual a 3 o y es igual a 6?

x == 3 | y == 6

logico1 = TRUE

logico2 = FALSE

class(logico1)

# TRUE suma 1, FALSE 0

# Ejemplo

TRUE + TRUE - FALSE

notas

# Cuántas notas son mayores a 4.1?

notas > 4.1

# trucazo1:

# función sum me permite sumar todos los
# valores de un vector

sum(notas)

sum( notas > 4.1)

# Cuáles fueron las notas que sacaron más de 4.1?

# truquito2: función which

which(notas > 4.1)

## slicing

# para coger subconjuntos de datos de un vector,
# colocamos el nombre del vector, seguido de
# paréntesis cuadrados y el índice que queremos

# Ejemplo
# quiero obtener la nota de la posición 1

notas[1]

# quiero las notas 1,3 y 5

notas[1,3,5]

notas[c(1,3,5)]

notas > 4.1


notas[notas > 4.1]

# Otra manera:

notas[which(notas > 4.1)]

notas[notas > 4.1 | notas <= 3]

notas

# CASE SENSITIVE. No definidos
Notas
NOTAS

# Puedo cambiar los valores de un vector
notas

# Quiero cambiar el vlor de la 6ta posición a 3.0

notas[6]

notas[6] = 3

notas

notas[notas > 4.5] = 5

notas

notas + 0.3

