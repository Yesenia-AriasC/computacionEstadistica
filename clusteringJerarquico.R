

#---------------------VER CLUSTERES HCLUST AGLOMERATIVO EN MAPA-----------------------#

library(maps)
library(ggplot2)
library(dplyr)

#Preprocesamiento
df <- USArrests
df <- na.omit(df)
df <- scale(df)

# Clustering
d <- dist(df, method = "euclidean") # Definimos medida de distancia a usar
hc1 <- hclust(d, method = "complete") # Definimos medida de linkage - similaridad
sub_grp <- cutree(hc1, k = 4) # Asignando cada individuo a su cluster (4 clusters)

# Dendrograma
plot(hc1, cex = 0.6, hang = -1, main = "Dendrograma de Clustering Jerárquico (USArrests)", xlab = "Estados",ylab = "Altura (Disimilitud)")
rect.hclust(hc1, k = 4, border = 2:5)

# Visualización en 2D (NUBE DE PUNTOS)
library(factoextra)
fviz_cluster(list(data = df, cluster = sub_grp))

fviz_cluster(list(data = df, cluster = sub_grp)) +
  labs(
    title = "Visualización de Clústeres Jerárquicos (USArrests)",
    x = "Componente 1 (PCA)",
    y = "Componente 2 (PCA)"
  )



# VISUALIZA EN MAPA

# Guardar resultados en data frame
states_cluster <- data.frame(state = tolower(rownames(df)),  # importante usar lowercase
                             cluster = as.factor(sub_grp))

# Obtener mapa de EE.UU.
us_map <- map_data("state")

# Unir los clústeres con el mapa
map_df <- us_map %>%
  left_join(states_cluster, by = c("region" = "state"))


ggplot(map_df, aes(x = long, y = lat, group = group, fill = cluster)) +
  geom_polygon(color = "white") +
  coord_fixed(1.3) +
  labs(title = "Conglomerados jerárquicos de los estados según crimen",
       fill = "Clúster") +
  theme_minimal()

#---------COMPARANDO DENDROGRAMAS----------#
# Calcular la matriz de distancias
res.dist <- dist(df, method = "euclidean")

# Calcular 2 agrupamientos jerárquicos diferentes
hc1 <- hclust(res.dist, method = "complete")
hc2 <- hclust(res.dist, method = "ward.D2")

# Crear dos dendrogramas
dend1 <- as.dendrogram(hc1)
dend2 <- as.dendrogram(hc2)


library(dendextend)
tanglegram(
  dend1, dend2,
  main = "Comparando métodos de agrupamiento jerárquico",
  main_left = "Linkage completo",
  main_right = "Ward.D2"
)

#---

dend_list <- dendlist(dend1, dend2)

tanglegram(dend1, dend2,
           highlight_distinct_edges = FALSE,  # Desactiva las líneas punteadas entre ramas diferentes
           common_subtrees_color_lines = FALSE,  # Desactiva el color en las líneas que conectan subárboles comunes
           common_subtrees_color_branches = TRUE,  # Colorea las ramas que son comunes entre los dendrogramas
           main = paste("Entrelazamiento =", round(entanglement(dend_list), 2)),  # Título con el valor de entrelazamiento
           main_left = "Linkage completo",
           main_right = "Ward.D2"
)

##------analizando clústeres-------##
table(sub_grp)
grupos_estados <- cbind(USArrests,sub_grp)
head(grupos_estados)
library(tidyr)
library(dplyr)


# Calcular medias y desviaciones estándar por grupo
resumen_todos <- grupos_estados %>%
  group_by(sub_grp) %>%
  summarise(
    Murder_mean = mean(Murder),
    Murder_sd   = sd(Murder),
    Assault_mean = mean(Assault),
    Assault_sd   = sd(Assault),
    UrbanPop_mean = mean(UrbanPop),
    UrbanPop_sd   = sd(UrbanPop),
    Rape_mean = mean(Rape),
    Rape_sd   = sd(Rape),
    .groups = "drop"
  ) %>%
  pivot_longer(
    cols = -sub_grp,
    names_to = c("Variable", ".value"),
    names_sep = "_"
  ) %>%
  arrange(sub_grp, Variable)

# Mostrar tabla final
print(resumen_todos)


#-----analisis de cluster por variable-----#

# Calcular medias por grupo
medias <- grupos_estados %>%
  group_by(sub_grp) %>%
  summarise(
    Murder = mean(Murder),
    Assault = mean(Assault),
    UrbanPop = mean(UrbanPop),
    Rape = mean(Rape),
    .groups = "drop"
  )

# Transformar a formato largo para graficar
medias_largo <- medias %>%
  pivot_longer(
    cols = -sub_grp,
    names_to = "Variable",
    values_to = "Media"
  )

# Crear gráfico
ggplot(medias_largo, aes(x = Variable, y = Media, group = factor(sub_grp), color = factor(sub_grp))) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 3) +
  labs(title = "Tasas medias de arrestos por crimenes violentos",
       x = "Variable",
       y = "Media",
       color = "Grupo") +
  theme_minimal() +
  theme(text = element_text(size = 12))

