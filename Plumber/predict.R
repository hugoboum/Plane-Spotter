
# Predicting  -------------------------------------------------------------

library(keras)

model <- load_model_hdf5("plane-spotter_pretrained_fine_tuning.h5")

image_prediction <- function(path){
  image <- image_load(path, target_size = c(150,150)) %>% 
    image_to_array() %>% 
    array_reshape(c(1, 150, 150, 3))
  image_tensor <- image/255
  pred <- predict_classes(model, image_tensor)
  if(pred == 0){
    return("Airbus")
  } else{
    return("Boeing")
  }
}

image_prediction("Plumber/Boeing.5023.jpg")

