#installing 'devtools' package for installing Packages from github
install.packages('devtools')

#installing keras
devtools::install_github("rstudio/keras") 

#Loading the keras package
library(keras)

#The R interface to Keras uses TensorFlow as it's underlying 
#computation engine.So we need to install Tensorflow engine
library(reticulate)
#install_tensorflow()
library(tensorflow)
#loading keras library
library(keras)
#loading the blood cells dataset
# Directory for images
image_dir <- "D:/Others/Downloads/BloodCells/mixed_data"

source("https://bioconductor.org/biocLite.R")
biocLite("EBImage")    #provides general purpose functionality for image processing & analysis
library(EBImage)

example_image <- readImage(file.path(image_dir, "_0_33.jpeg"))
display(example_image)

#Data Partition
#library(caret)
#Train<-createDataPartition(abc$charges,p=0.70,list=FALSE)
#training<-abc[Train, ]
#testing<-abc[-Train, ]

cells_list<-c("eosinophil","neutrophil","monocyte","lymphocyte")
# image size to scale down to (original images are of variable sizes)
img_width <- 28
img_height <- 28
target_size <- c(img_width, img_height)
#RGB Channels
channels <- 3

install_tensorflow()
train_data_gen = image_data_generator(rescale = 1/255)
# training images
train_image_array_gen <- flow_images_from_directory(image_dir, 
                                                    train_data_gen,
                                                    target_size = target_size,
                                                    class_mode = "categorical",
                                                    classes = cells_list,
                                                    seed = 42)

table(factor(train_image_array_gen$classes))