# Exercise 1 - sample solution
# Using NHS England Regions (https://data.gov.uk/dataset/7514fa81-a0c2-4031-9c20-63be72cc24c2/nhs-england-regions-april-2020-boundaries-en-bfc) boundaries 
# and data on covid hospitalCases by NHS Region (https://coronavirus.data.gov.uk/details/download), 
# produce a choropleth map for covid case numbers on Nov 9th 2021. 

# Get NHS boundaries
# https://data.gov.uk/dataset/7514fa81-a0c2-4031-9c20-63be72cc24c2/nhs-england-regions-april-2020-boundaries-en-bfc
# save in data folder (and unzip if it's a shapefile)

# get covid cases data
# https://coronavirus.data.gov.uk/details/download
# Area type: NHS Region
# Metrics hospitalCases
# download.file("https://api.coronavirus.data.gov.uk/v2/data?areaType=nhsRegion&metric=hospitalCases&format=csv",destfile = "data/covid_by_nhs.csv")

nhs_shape <- sf::read_sf("data/NHS_England_Regions_(April_2020)_Boundaries_EN_BFC/NHS_England_Regions_(April_2020)_Boundaries_EN_BFC.shp")

df_covid_cases <- readr::read_csv("data/covid_by_nhs.csv") %>% 
  filter(date == "2021-11-09")

head(nhs_shape)

head(df_covid_cases)

# join data
nhs_shape_and_covid_cases <- nhs_shape %>% 
  dplyr::left_join(df_covid_cases, by = c("nhser20cd" = "areaCode"))


# plot map
gg_choro <-ggplot(nhs_shape_and_covid_cases) +
  geom_sf(
    aes(
      geometry = geometry,
      fill = hospitalCases,
      colour = hospitalCases
    )
  )

gg_choro
