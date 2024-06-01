library(tidyverse)

radpad <- read_csv("RADPAD DATA Stats team 5_28_24_FINAL.xlsx - Sheet1.csv", skip = 1)
str(radpad)

long <- radpad |>
  select(-Patient...20, -`DAP Total (Gycm2)`) |>
  mutate(`Resident 1` = as.character(`Resident 1`)) |>
  pivot_longer(Faculty:Anesthesia,
               names_to = "Occupation",
               values_to = "Dose") |>
  mutate(across(where(is.character), ~na_if(., "n/a"))) |>
  mutate(across(where(is.character), ~na_if(., "NB"))) |>
  drop_na()

write_csv(long, "radpad.csv")

