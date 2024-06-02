library(tidyverse)
library(readxl)

radpad <- read_excel("RADPAD DATA Stats team 5_28_24_FINAL.xlsx", skip = 1) |>
  select(-Breed, -`Sex (FI, FS, MI, MN)`)

long <- radpad |>
  select(-Patient...20, -`DAP Total (Gycm2)`) |>
  mutate(ID = 1:200) |>
  mutate(`Resident 1` = as.character(`Resident 1`)) |>
  pivot_longer(Faculty:Anesthesia,
               names_to = "Occupation",
               values_to = "Dose") |>
  mutate(across(where(is.character), ~na_if(., "n/a"))) |>
  mutate(across(where(is.character), ~na_if(., "n /a"))) |>
  mutate(across(where(is.character), ~na_if(., "NB"))) |>
  drop_na() |>
  mutate(Dose = as.numeric(Dose))

write_csv(long, "radpad.csv")


