library(tidyverse)
library(dplyr)
library(readr)
library(sf)

# shapefiles

district_115 <- read_sf("usmap/115thcongress/tl_2017_us_cd115.shp")
district_116 <- read_sf("usmap/116thcongress/tl_2019_us_cd116.shp")
district_117 <- read_sf("usmap/117thcongress/tl_2022_us_cd116.shp")
nc_district_117 <- read_sf("usmap/117thcongress/nc117thcongress/C-Goodwin-A-1-TC.shp")
officeholders <- read_csv("usmap/officeholders.csv")

# clean

district_115 = district_115 %>%
  filter(STATEFP < 57) %>%
  filter(STATEFP != 11) %>%
  filter(CD115FP != "ZZ")

district_116 = district_116 %>%
  filter(STATEFP < 57) %>%
  filter(STATEFP != 11) %>%
  filter(CD116FP != "ZZ")

district_117 = district_117 %>%
  filter(STATEFP != 37) %>%
  filter(STATEFP < 57) %>%
  filter(STATEFP != 11) %>%
  filter(CD116FP != "ZZ")

# test

office115 = officeholders %>%
  filter(Congress == 115,
         Year == 2018)

women_115 = office115 %>%
  left_join(district_115, by = "GEOID") %>%
  filter(STATEFP.x != 15)

head(women_115)

ggplot(women_115) +
  geom_sf(aes(geometry = geometry), fill = "red", color = NA, alpha = 0.25) +
  theme_void()


office116 = officeholders %>%
  filter(Congress == 116,
         Year == 2019)

women_116 = office116 %>%
  left_join(district_115, by = "GEOID") %>%
  filter(STATEFP.x != 15)

ggplot(women_116) +
  geom_sf(aes(geometry = geometry), fill = "red", color = NA, alpha = 0.25) +
  theme_void()

ggplot() +
  geom_sf(data = women_115, aes(geometry = geometry), fill = "red", color = NA, alpha = 0.25) +
  geom_sf(data = women_116, aes(geometry = geometry), fill = "red", color = NA, alpha = 0.25) +
  theme_void()







