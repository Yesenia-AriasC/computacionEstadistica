#### funciones###########
# interes compuesto -> Monto = C (1 + i)t elevado a la t
# tengo 1000, los invirto a un año con tasa de interes al 10%

C0 = 1000
t = 1
i= 0.10
M = C0*(1+i)^t
M

C0 = 1000
t = 2
i= 0.10
M = C0*(1+i)^t
M

# creemos una funcion que haga los calculos
interes_compuesto= function(C0, i, t){M = C0*(1+i)^t}
interes_compuesto(C0 =1000, i = 0.10, t = 1)

interes_compuesto= function(C0, i, t){
  M = C0*(1+i)^t
  return(M)}

interes_compuesto(C0 =1000, i = 0.10, t = 1)
interes_compuesto(1000, 0.10, 1)

## argumentos por defecto 
interes_compuesto(1000, 0.10)
# puedo tener argumentos obligatorios y opcionales
interes_compuesto2= function(C0, i, t=1){M = C0*(1+i)^t
M = C0*(1+i)^t
return(M)
}

interes_compuesto2(1000, 0.10)


### Estructuras de seleccion ####
# evaluacion en el codigo
ingreso = 1000
if(ingreso >= 1000){
  print("Tocó hamburguesita!")
}

## if - else
ingreso = 100

if (ingreso >= 1000){
  print("Tocó hamburguesita!")
}else{
  print("Tocó recalentao papá...")
}

## funcion ifelse

ingles = c(10, 11, 4, 8, 10)

ifelse(ingles > 9, "No nivela", "Nivela") # categorizar var numerica

## que pasa si tengo mas de 2 niveles?...
# puntaje < 5 : Nivel I
# puntaje < 10 : Nivel II
# puntaje >= 10 : Nivel III
ifelse(ingles < 5, "Nivel I",
       ifelse(ingles < 10, "Nivel II", "No nivela"))

### bucles - estructuras de repeticion ###

asignaturas = c("integral", "Fundamentos", "probabilidad")

asignaturas[1]
asignaturas[2]
asignaturas[3]

for (i in asignaturas) {
  print(i)
}??
  
  for (i in 1:length(asignaturas)) {
    print(asignaturas[i])
  } # no me corre y no entiendo por que
persona_asignaturas = function(estudiante, asignaturas, calificaciones) {
  for(i in 1:length(asignaturas)) {
    print(paste0("El estudiante ", estudiante, " cursó ", asignaturas[i],
                 " con calificación: ", calificaciones[i]))
  }
}

persona_asignaturas("Juan David", c("Proba", "Integral"), c(4.3, 4.6))

## abrir datos

library(readr)
marketing <- read_csv("Bases de datos-20250408/marketing.csv")

View(marketing)


library(readxl)
cafe <- read_excel("Bases de datos-20250408/cafe.xlsx",
                   sheet = "1. Precio Interno Diario ",
                   range = "B6:C7030", col_names = FALSE)
View(cafe)

plot(cafe)

