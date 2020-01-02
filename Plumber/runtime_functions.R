# =========================================================================
# Copyright © 2019 T-Mobile USA, Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# =========================================================================
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
