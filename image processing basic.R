#frink <- image_read("https://jeroen.github.io/images/frink.png")
#library(magick)
#image_display(frink)
#print(frink)
#magick::magick_config(frink)

#Loading magick package
library(magick)

#reading a png image frink image
frink <- image_read("https://jeroen.github.io/images/frink.png")
#reading a jpg image ex-President Barack Obama from Wikipedia
obama <- image_read('https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/President_Barack_Obama.jpg/800px-President_Barack_Obama.jpg')
#image details
image_info(obama)
image_info(frink)
#displaying the image
print(obama)
print(frink)
