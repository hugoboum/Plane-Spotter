library(keras)
#install_keras()

original_dataset_dir <- "Images/"
base_dir <- "Airbus-and-Boeing"
dir.create(base_dir)
train_dir <- file.path(base_dir, "train")
dir.create(train_dir)
validation_dir <- file.path(base_dir, "validation")
dir.create(validation_dir)
test_dir <- file.path(base_dir, "test")
dir.create(test_dir)
train_airbus_dir <- file.path(train_dir, "Airbus")
dir.create(train_airbus_dir)
train_boeing_dir <- file.path(train_dir, "Boeing")
dir.create(train_boeing_dir)
validation_airbus_dir <- file.path(validation_dir, "Airbus")
dir.create(validation_airbus_dir)
validation_boeing_dir <- file.path(validation_dir, "Boeing")
dir.create(validation_boeing_dir)
test_airbus_dir <- file.path(test_dir, "Airbus")
dir.create(test_airbus_dir)
test_boeing_dir <- file.path(test_dir, "Boeing")
dir.create(test_boeing_dir)
fnames <- paste0("Airbus.", 1:4000, ".jpg")
file.copy(file.path(original_dataset_dir, fnames),
          file.path(train_airbus_dir))
fnames <- paste0("Airbus.", 4001:5000, ".jpg")
file.copy(file.path(original_dataset_dir, fnames),
          file.path(validation_airbus_dir))
fnames <- paste0("Airbus.", 5001:5497, ".jpg")
file.copy(file.path(original_dataset_dir, fnames),
          file.path(test_airbus_dir))
fnames <- paste0("Boeing.", 1:4000, ".jpg")
file.copy(file.path(original_dataset_dir, fnames),
          file.path(train_boeing_dir))
fnames <- paste0("Boeing.", 4001:5000, ".jpg")
file.copy(file.path(original_dataset_dir, fnames),
          file.path(validation_boeing_dir))
fnames <- paste0("Boeing.", 5001:5497, ".jpg")
file.copy(file.path(original_dataset_dir, fnames),
          file.path(test_boeing_dir))

cat("total training airbus images:", length(list.files(train_airbus_dir)), "\n")

cat("total training boeing images:", length(list.files(train_boeing_dir)), "\n")

cat("total validation airbus images:", length(list.files(validation_airbus_dir)), "\n")

cat("total validation boeing images:", length(list.files(validation_boeing_dir)), "\n")

cat("total test airbus images:", length(list.files(test_airbus_dir)), "\n")

cat("total test boeing images:", length(list.files(test_boeing_dir)), "\n")


