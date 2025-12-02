library(gapminder) # provides the built-in gapminder dataset
library(tidyverse)

# Load prepared dataset -------------------------------------------------------
gapminder::gapminder

# Prepare a readable subset ---------------------------------------------------
# We pick one year and one continent so labels stay legible.
df <- gapminder %>%
  filter(year == 2007, continent == "Europe") %>%
  drop_na()

country_classes <- tibble(
  country = c(
    "Albania", "Austria", "Belgium", "Bosnia and Herzegovina", "Bulgaria",
    "Croatia", "Czech Republic", "Denmark", "Finland", "France",
    "Germany", "Greece", "Hungary", "Iceland", "Ireland",
    "Italy", "Montenegro", "Netherlands", "Norway", "Poland",
    "Portugal", "Romania", "Serbia", "Slovak Republic", "Slovenia",
    "Spain", "Sweden", "Switzerland", "Turkey", "United Kingdom"
  ),

  # 1) Jazykové rodiny
  language_group = c(
    "Other",      # Albania
    "Germanic",   # Austria
    "Germanic",   # Belgium
    "Slavic",     # Bosnia
    "Slavic",     # Bulgaria
    "Slavic",     # Croatia
    "Slavic",     # Czech Republic
    "Germanic",   # Denmark
    "Other",      # Finland (Finno-Ugric)
    "Romance",    # France
    "Germanic",   # Germany
    "Romance",    # Greece (není Romance, ale pro graf je lepší skupina South Euro)
    "Slavic",     # Hungary (Ugrofinská lingvistika → ale pro graf zařazena do post-communist/Slavic region)
    "Germanic",   # Iceland
    "Germanic",   # Ireland
    "Romance",    # Italy
    "Slavic",     # Montenegro
    "Germanic",   # Netherlands
    "Germanic",   # Norway
    "Slavic",     # Poland
    "Romance",    # Portugal
    "Romance",    # Romania (Romance jazyková větev)
    "Slavic",     # Serbia
    "Slavic",     # Slovak Republic
    "Slavic",     # Slovenia
    "Romance",    # Spain
    "Germanic",   # Sweden
    "Germanic",   # Switzerland
    "Other",      # Turkey
    "Germanic"    # United Kingdom
  ),

  # 2) Geografické regiony Evropy
  region_europe = c(
    "South",  # Albania
    "West",   # Austria
    "West",   # Belgium
    "East",   # Bosnia
    "East",   # Bulgaria
    "East",   # Croatia
    "East",   # Czech Republic
    "North",  # Denmark
    "North",  # Finland
    "West",   # France
    "West",   # Germany
    "South",  # Greece
    "East",   # Hungary
    "North",  # Iceland
    "West",   # Ireland
    "South",  # Italy
    "South",  # Montenegro
    "West",   # Netherlands
    "North",  # Norway
    "East",   # Poland
    "South",  # Portugal
    "East",   # Romania
    "East",   # Serbia
    "East",   # Slovak Republic
    "East",   # Slovenia
    "South",  # Spain
    "North",  # Sweden
    "West",   # Switzerland
    "East",   # Turkey (pro Gapminder nejčastěji v East)
    "West"    # United Kingdom
  ),

  # 3) Ekonomické bloky
  econ_block = c(
    "Post-Communist",    # Albania
    "Western Core",      # Austria
    "Western Core",      # Belgium
    "Post-Communist",    # Bosnia
    "Post-Communist",    # Bulgaria
    "Post-Communist",    # Croatia
    "Post-Communist",    # Czech Republic
    "Nordic",            # Denmark
    "Nordic",            # Finland
    "Western Core",      # France
    "Western Core",      # Germany
    "Southern EU",       # Greece
    "Post-Communist",    # Hungary
    "Nordic",            # Iceland
    "Western Core",      # Ireland
    "Southern EU",       # Italy
    "Post-Communist",    # Montenegro
    "Western Core",      # Netherlands
    "Nordic",            # Norway
    "Post-Communist",    # Poland
    "Southern EU",       # Portugal
    "Post-Communist",    # Romania
    "Post-Communist",    # Serbia
    "Post-Communist",    # Slovak Republic
    "Post-Communist",    # Slovenia
    "Southern EU",       # Spain
    "Nordic",            # Sweden
    "Western Core",      # Switzerland
    "Other",             # Turkey
    "Western Core"       # United Kingdom
  )
)

df_extended <- df %>%
  left_join(country_classes, by = "country")

write_csv2(df_extended, "src/data/gapminder_extended.csv")
