# clase 6 

### descarga datos y cargando dplyr ####
library(readr)
marketing <- read_csv("BD/marketing.csv")
View(marketing)

library(dplyr)

###  Agrupar y resumir con group_by + summarise ####
# si analizas cada uno, va de lo grande a lo chico, de lo general a lo especifico.

# Ingreso promedio por nivel educativo
marketing %>% 
  group_by(Education) %>% 
  summarise(Ingreso = mean(Income, na.rm = TRUE)) # remove NA = TRUE

# Ingreso promedio por educación y estado civil
marketing %>% 
  group_by(Education, Marital_Status) %>% 
  summarise(Ingreso = mean(Income, na.rm = TRUE))


### Filtrar ####

# Solo personas casadas
marketing %>% filter(Marital_Status == "Married")

# Casados o divorciados (nivel pollito 😄)
marketing %>% filter(Marital_Status %in% c("Married", "Divorced"))



##### Evitar uso notacion cientifica ####

options(scipen = 99)

#### joins ####
    
# | Función       | Qué hace |
#  |---------------|----------|
#  | `filter()`    | Filtra filas (por ejemplo, solo 2020) |
#  | `left_join()` | Une dos tablas, conservando todo lo de la primera |
#  | `right_join()`| Conserva todo lo de la segunda |
#  | `full_join()` | Conserva todo de ambas |
#  | `select(-col)`| Elimina una columna antes de unir |
  
# Para esta parte, se necesita cargar al entorno R el archivo `datos_economicos.RData`

pib20 = df_pib %>% filter(año==2020)           #  Crea una nueva tabla llamada pib20 que contiene solo los datos del año 2020 de la base de datos df_pib (Producto Interno Bruto).
des20 = df_desempleo %>%  filter(año==2020)    # Crea una tabla llamada des20 con solo los datos del año 2020 de la base df_desempleo (tasa de desempleo).
inf20 = df_inflacion %>% filter(año ==2020)    # Crea una tabla llamada inf20 que contiene solo los datos del año 2020 de la base df_inflacion.


#🧠 “Mantén todo el PIB del 2020 y agrégale la inflación si existe.”
#el argumento by = c('pais', 'año') le dice a left_join() por qué columnas debe unir las dos tablas (pib20 e inf20).
tabla_left <- left_join(pib20, inf20, by= c('pais','año'))   

# 🧠 “Une solo por país, sin considerar el año — pero ¡ojo!, puede unir mal si hay datos de varios años por país.”
# En dplyr, el argumento by funciona como si estuvieras indicando las claves (o "keys") por las que se deben unir las tablas, igual que harías con una clave primaria y una clave foránea en bases de datos.
tabla_left1 = left_join(pib20, inf20 %>% select (-año), by = "pais")
#inf20 %>% select(-año) ➜ Esto elimina la columna año de inf20 antes de hacer el join. Luego haces left_join(pib20, ...) usando solo "pais" como clave para unir.

#🧠 “Mantén todos los datos de inflación 2020, y añade el PIB si está disponible.”
tabla_right = right_join(pib20, inf20, by = c("pais", "año"))

#🧠 “Combina desempleo e inflación por país y año, y muéstrame la tabla.”
left_join(df_desempleo, df_inflacion, by = c("pais", "año")) %>% View()

# 🧠 “Dame todos los países que estén en cualquiera de las dos tablas, aunque no coincidan.”
full_join(df_desempleo, df_inflacion, by = c("pais", "año")) %>% View()



###graficos####

table(marketing$Education) 
# Cuenta cuántas veces aparece cada nivel educativo en la columna Education del data frame marketing.
# Devuelve una tabla de frecuencias.

### grafico de barras ####
barplot(table(marketing$Education))
# Muestra un gráfico de barras básico con los conteos anteriores (de niveles educativos).

x = table(marketing$Education)
barplot(x, main = "Nivel educativo", xlab = "Educacion", ylab = "Conteo", col = c("red", "magenta", "purple", "violetred", "pink"))

### Histogramas ####
hist(marketing$Income)

hist(marketing$Income, xlim=c(0, 150000), breaks = 30, col = rainbow(10))
# Mejora el histograma:
  #  xlim=c(0, 150000): recorta el eje X para que solo se muestre hasta 150,000.
  #  breaks = 30: define 30 columnas o "bloques" (más detalle).
  #  col = rainbow(10): usa una paleta de 10 colores del arcoíris.
histo1 = hist(marketing$Income , xlim=c(0, 150000), breaks = 50, col = rainbow(10))            

###BOXPLOT ("Gráfico de caja")####

marketing2 = marketing %>% filter(Income <= 200000)
# Filtra el dataset para eliminar valores muy altos de ingreso (probablemente outliers o extremos).
cajita = boxplot(marketing2$Income, col ="orange")
cajita$stats
# Muestra los cinco números resumen del boxplot:
  #  Mínimo, 1er cuartil, mediana, 3er cuartil, máximo.
cajita$out
#Muestra los valores atípicos (outliers) detectados por el boxplot.
