setwd("C:/Users/Estudiante/Documents")

### sesión 5

marketing <- read_csv("BD/marketing.csv")


## quiero la columna Income y KidHome

colnames(marketing)

marketing[,c(6, 7)]

## dplyr es una librería para analisis de datos
# funciona bajo la metodologia de encadenado (pipeline)
# por medio del operador %>% 

## función select

# seleccionemos las columnas Income, KidHome

marketing %>% select(Income, Kidhome)

# se debe cargar la librería antes

library(dplyr)
marketing %>% select(Income, Kidhome)

# Todas las columnas excepto Education e Income

marketing %>% select(-c(Income, Education))


### filter...

# filtremos los individuos que tienen un salario mayor a 100000$
marketing %>% filter(Income > 100000)

# Para combinar filtros, podemos separar las condiciones por medio de una coma

marketing %>% filter(Income > 100000, Marital_Status == "Single")

## Seleccionemos la educación de las personas qeu ganan más de 100000

marketing %>% select(Education) %>% filter(Income > 100000)

# error, seleccioné solo educacion

# dos maneras...

marketing %>% select(Education, Income) %>% filter(Income > 100000)

# otra forma (depende de lo que quiera...)
marketing %>% filter(Income > 100000) %>% select(Education)


### group_by, summarise

## Cuál es el ingreso promedio de los casados?...
## Cuál es el ingreso promedio de los solteros?...

# nivel pollito

solteros = marketing[marketing$Marital_Status == "Single",]
casados = marketing[marketing$Marital_Status == "Married",]

solteros = marketing %>% filter(Marital_Status == "Single")

mean(solteros$Income)
mean(casados$Income)



marketing %>% group_by(Marital_Status) %>% 
  summarise(Ingreso = mean(Income))


marketing$Marital_Status[marketing$Marital_Status == "YOLO"] = "Single"
marketing$Marital_Status[marketing$Marital_Status == "Alone"] = "Single"
marketing$Marital_Status[marketing$Marital_Status == "Absurd"] = "Single"

"YOLO" %in% marketing$Marital_Status

marketing$Marital_Status[marketing$Marital_Status %in% c("YOLO", "Alone", "Absurd")] = "Single"


marketing %>% group_by(Marital_Status) %>% 
  summarise(Ingreso = mean(Income))

# desviacióin estándar

marketing %>% group_by(Marital_Status) %>% 
  summarise(Ingreso_sd = sd(Income))


## veamos ambas estadísticas juntas


marketing %>% group_by(Marital_Status) %>% 
  summarise(Ingreso = mean(Income), Income_sd = sd(Income))

# número de individuos

marketing %>% group_by(Marital_Status) %>% 
  summarise(Ingreso = mean(Income), Income_sd = sd(Income), personas = n())


## mutate

# Obtengamos el coeficiente de variación por grupo

marketing %>% group_by(Marital_Status) %>% 
  summarise(Ingreso = mean(Income), Income_sd = sd(Income), personas = n()) %>% 
  mutate(CV = Income_sd/Ingreso*100)


filtro = marketing %>% group_by(Marital_Status) %>% 
  summarise(Ingreso = mean(Income), Income_sd = sd(Income), personas = n()) %>% 
  mutate(CV = Income_sd/Ingreso*100)

?dplyr::filter


filtro = marketing %>% dplyr::group_by(Marital_Status) %>% 
  dplyr::summarise(Ingreso = base::mean(Income), Income_sd = sd(Income), personas = n()) %>% 
  dplyr::mutate(CV = Income_sd/Ingreso*100)

?filter


getwd()

install.packages("writexl")


writexl::write_xlsx(filtro, "filtro_poderoso.xlsx")


getwd()
# "C:/Users/Estudiante/Documents"

writexl::write_xlsx(casados, "C:/Users/Estudiante/Documents/ComputacionEstadistica25/casados.xlsx")


data(mtcars)

writexl::write_xlsx(mtcars, "C:/Users/Estudiante/Documents/ComputacionEstadistica25/carritos.xlsx")

## Segunda manera...

setwd("C:/Users/Estudiante/Documents/ComputacionEstadistica25")

data(swiss)

writexl::write_xlsx(swiss, "suizos.xlsx")


data(iris)

writexl::write_xlsx(iris, "datos/planticas_bellas.xlsx")



## estamos parados en la carpeta de computación...

library(readxl)

flores = readxl::read_excel("datos/planticas_bellas.xlsx")

grafico1 = plot(iris$Sepal.Length)


save.image("datos.RData")


setwd("C:/Users/Estudiante/Documents")





