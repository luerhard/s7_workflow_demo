library(here)
options(box.path = here())

box::use(
    r / load
)

df <- load$processed_data()

simple_formula <- formula(y ~ MedInc + HouseAge + AveRooms)

model <- lm(simple_formula, data = df)

saveRDS(model, here("data", "models", "model.RDS"))
