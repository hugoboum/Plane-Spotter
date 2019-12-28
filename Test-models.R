
# Testing our models ------------------------------------------------------
library(keras)

base_dir <- "Airbus-and-Boeing"
test_dir <- file.path(base_dir, "test")

test_datagen <- image_data_generator(rescale = 1/255)

test_generator <- flow_images_from_directory(
  test_dir,
  test_datagen,
  target_size = c(150, 150),
  batch_size = 20,
  class_mode = "binary"
)

model_1 <- load_model_hdf5("plane-spotter_full.h5")

model_1 %>% evaluate_generator(test_generator, steps = 50)

model_2 <- load_model_hdf5("plane-spotter_pretrained_1.h5")

model_2 %>% evaluate_generator(test_generator, steps = 50)

model_3 <- load_model_hdf5("plane-spotter_pretrained_2.h5")

model_3 %>% evaluate_generator(test_generator, steps = 50)