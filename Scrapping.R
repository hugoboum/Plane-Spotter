# Load library ------------------------------------------------------------

library(rvest)
library(dplyr)
library(NLP)


# First page pictures extraction ------------------------------------------

planespotter <- read_html("https://www.planespotters.net/photos/latest?page=1")

img <- planespotter %>%
  html_node(xpath = '//*/img')

imgalt <- html_attr(img, 'alt')
imgsrc <- html_attr(img, 'src')
imgsrc_split <- strsplit(imgsrc, "_")
img_number <- as.integer(imgsrc_split[[1]][3])
for(j in 1:47) {
  img_numbera <- img_number - j
  node_id <- paste0('#', img_numbera, ' .photo__intrinsic_item')
  
  imgsrc <- planespotter %>%
    html_node(node_id) %>%
    html_attr('src')
  imgsrc
  
  download.file(imgsrc, destfile = basename(imgsrc))
}

# entire website images extraction ----------------------------------------

for (i in 1:125){
  planespotter_url <- paste("https://www.planespotters.net/photos/latest?page=",i, sep = "")
  planespotter <- read_html(planespotter_url)
  img <- planespotter %>%
    html_node(xpath = '//*/img')
  
  imgalt <- html_attr(img, 'alt')
  imgsrc <- html_attr(img, 'src')
  imgsrc_split <- strsplit(imgsrc, "_")
  img_number <- as.integer(imgsrc_split[[1]][3])
  
  for(j in 1:47) {
    img_numbera <- img_number - j
    node_id <- paste0('#', img_numbera, ' .photo__intrinsic_item')
    
    imgsrc <- planespotter %>%
      html_node(node_id) %>%
      html_attr('src')
    imgsrc
    
    download.file(imgsrc, destfile = basename(imgsrc))
  }
}

