# Load library ------------------------------------------------------------

library(rvest)
library(dplyr)
library(NLP)
library(stringr)

# First page pictures extraction ------------------------------------------

planespotter <- read_html("https://www.planespotters.net/photos/latest?page=1")

img <- planespotter %>%
  html_node(xpath = '//*/img')

constructor <- xml_attrs(xml_child(xml_child(xml_child(xml_child(constructor_html, 1), 2), 1), 4))[["title"]] %>% 
               stringr::str_replace( "Search for Manufacturer: ", "")

aircraft_type <- xml_attrs(xml_child(xml_child(xml_child(xml_child(constructor_html, 1), 2), 1), 5))[["title"]] %>% 
                 stringr::str_replace( "Search for Aircraft Type: ", "")

imgalt <- html_attr(img, 'alt')
imgsrc <- html_attr(img, 'src')
imgsrc_split <- strsplit(imgsrc, "_")
img_number <- as.integer(imgsrc_split[[1]][3])
download.file(imgsrc, destfile =  paste0('Images/',aircraft_type, '-', img_number, '.jpg'))
aicrafts <- data_frame(constructor = constructor, aircraft_type = aircraft_type)
for(j in 1:47) {
  img_numbera <- img_number - j
  node_id <- paste0('#', img_numbera, ' .photo__intrinsic_item')
  constructor_html <- planespotter %>%
    html_node(paste0('#', img_numbera))
  
  constructor <- xml_attrs(xml_child(xml_child(xml_child(xml_child(constructor_html, 1), 2), 1), 4))[["title"]] %>% 
    stringr::str_replace( "Search for Manufacturer: ", "")
  
  aircraft_type <- xml_attrs(xml_child(xml_child(xml_child(xml_child(constructor_html, 1), 2), 1), 5))[["title"]] %>% 
    stringr::str_replace( "Search for Aircraft Type: ", "")
  
  imgsrc <- planespotter %>%
    html_node(node_id) %>%
    html_attr('src')
  
  download.file(imgsrc, destfile = paste0('Images/',aircraft_type, '-', img_numbera, '.jpg'))
  aicrafts <- rbind.data.frame(aicrafts, c(constructor, aircraft_type))
}
write.csv(aicrafts, file = "aicrafts.csv")

# entire website images extraction ----------------------------------------

aicrafts <- matrix(ncol = 3, nrow = 48*55)
nb <- 0
for (i in 1:55){
  nb <- nb+1
  planespotter_url <- paste("https://www.planespotters.net/photos/latest?page=",i, sep = "")
  planespotter <- read_html(planespotter_url)
  img <- planespotter %>%
    html_node(xpath = '//*/img')
  
  imgalt <- html_attr(img, 'alt')
  imgsrc <- html_attr(img, 'src')
  imgsrc_split <- strsplit(imgsrc, "_")
  img_number <- as.integer(imgsrc_split[[1]][3])
  
  constructor_html <- planespotter %>%
    html_nodes(paste0('#', img_number, " a")) %>% 
    html_attr('href')
  
  constructor <- stringr::str_replace(constructor_html[4], "/photos/manufacturer/", "")
  aircraft_type <- stringr::str_replace(constructor_html[5], paste0('/photos/aircraft/',constructor, '/' ), "")
  airline <- stringr::str_replace(constructor_html[3], "/airline/", "")
  
  download.file(imgsrc, destfile = paste0('Images/',constructor, '.', nb, '.jpg'))
  aicrafts[nb, 1] <- constructor
  aicrafts[nb, 2] <- aircraft_type
  aicrafts[nb, 3] <- airline
  
  for(j in 1:47) {
    nb <- nb+1
    img_numbera <- img_number - j
    node_id <- paste0('#', img_numbera, ' .photo__intrinsic_item')
    
    img <- planespotter %>%
      html_node(node_id) 
    
    constructor_html <- planespotter %>%
      html_nodes(paste0('#', img_numbera, " a")) %>% 
      html_attr('href')
    
    constructor <- stringr::str_replace(constructor_html[4], "/photos/manufacturer/", "")
    aircraft_type <- stringr::str_replace(constructor_html[5], paste0('/photos/aircraft/',constructor, '/' ), "")
    airline <- stringr::str_replace(constructor_html[3], "/airline/", "")
      
    imgalt <- html_attr(img, 'alt')
    imgsrc <- html_attr(img, 'src')
    aicrafts[nb, 1] <- constructor
    aicrafts[nb, 2] <- aircraft_type
    aicrafts[nb, 3] <- airline
    if(is.na(imgsrc)){ Sys.sleep(0.5)
    }else{
      download.file(imgsrc, destfile = paste0('Images/',constructor, '.', nb, '.jpg'))
    }
  }
}
aircrafts <- data_frame(constructor = aicrafts[,1], aircraft_type = aicrafts[,2], airline = aicrafts[,3])
write.csv(aircrafts, file = "aicrafts.csv")
View(aircrafts)
length(list.files("Images/", pattern="jpg"))
dim(aicrafts)


