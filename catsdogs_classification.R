#original_dataset_dir <- "D:/Others/Downloads/Leukemia.csv"

base_dir <- "D:/Others/Downloads/dogs-vs-cats"
dir.create(base_dir)

train_dir <- file.path(base_dir, "train")
dir.create(train_dir)
test_dir <- file.path(base_dir, "test1")
dir.create(test_dir)

train_cats_dir <- file.path(train_dir, "cat")
dir.create(train_cats_dir)

train_dogs_dir <- file.path(train_dir, "dog")
dir.create(train_dogs_dir)

test_cats_dir <- file.path(test_dir, "cat")
dir.create(test_cats_dir)

test_dogs_dir <- file.path(test_dir, "dog")
dir.create(test_dogs_dir)

fnames <- paste0("cat.", 1:1000, ".jpg")
file.copy(file.path(base_dir, fnames), 
          file.path(train_cats_dir)) 

fnames <- paste0("cat.", 1501:2000, ".jpg")
file.copy(file.path(base_dir, fnames),
          file.path(test_cats_dir))

fnames <- paste0("dog.", 1:1000, ".jpg")
file.copy(file.path(base_dir, fnames),
          file.path(train_dogs_dir))

fnames <- paste0("dog.", 1501:2000, ".jpg")
file.copy(file.path(base_dir, fnames),
          file.path(test_dogs_dir))

library(keras)
#conv_base <- application_vgg16(
  #weights = "imagenet",
  #include_top = FALSE,
  #input_shape = c(150, 150, 3))
library(reticulate)
library(tensorflow)

# training images
train_image <- flow_images_from_directory(train_dir, 
                                                    target_size = c(256,256),
                                                    class_mode = 'categorical',
                                                    classes = c('dogs','cats'))

cat("Number of images per class:")
table(factor(train_image$classes))

