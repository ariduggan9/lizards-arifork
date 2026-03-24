# Make a map
install.packages("rnaturalearth")

library(sf)
library(rnaturalearth)
library(ggplot2)
library(dplyr)



# read in data ------------------------------------------------------------

locdata <- read.csv("local_dat.csv")



# map ---------------------------------------------------------------------

# find reasonable bound box
fivenum(locdata$Latitude) # min = 10.55, max = 39.79 (y values)
fivenum(locdata$Longitude) # min = -117.33, max -82



world <- ne_countries(returnclass = "sf")
ggplot(world) +
  geom_sf(fill = "gray90", color = "gray50") +
  coord_sf(
    xlim = c(-120, -82),
    ylim = c(11, 41),
    expand = FALSE
  ) +
  theme_minimal()


ggplot(world) +
  geom_sf(fill = "gray90", color = "gray50") +
  geom_point(data = samples,
             aes(x = longitude, y = latitude, color = actualparasite, shape = ReproductionStrategy),
             size = 3) +
  coord_sf(
    xlim = c(-120, -79),
    ylim = c(11, 42),
    expand = FALSE
  ) +
  theme_minimal()


# This works
ggplot(world) +
  geom_sf(fill = "gray90", color = "gray50") +
  coord_sf(
    xlim = c(-120, -82),
    ylim = c(11, 41),
    expand = FALSE
  ) +
  theme_minimal()


ggplot(world) +
  geom_sf(fill = "gray90", color = "gray50") +
  geom_point(data = samples,
             aes(x = longitude, y = latitude, fill = actualparasite, shape = ReproductionStrategy),
             size = 3) + scale_fill_manual(values = c("Negative" = "steelblue", "Positive" = "red")) +
  scale_shape_manual(values = c("Sexual" = 22, "Unisexual" = 24))+
  coord_sf(
    xlim = c(-120, -79),
    ylim = c(11, 42),
    expand = FALSE
  ) +
  theme_minimal(base_family = "Raleway") + guides(fill = "none") + theme(
    plot.title = element_text(hjust = 0.5)) + labs(title = "Parasite Presence",
                                                   x = "Longitude", y = "Latitude",
                                                   shape = "Reproductive Mode")