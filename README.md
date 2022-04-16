
# JPEG Compression

This is a project to understand the interworking behind the JPEG algorithm. 
Since a significant portion of the algorithm is deeply rooted in mathematical concepts,
I went ahead to implement this project in MATLAB. with that said it can be easy ported to 
python as well😉.

## Screenshots

![](screenshots/lady%20in%20snow.png)
![](/screenshots/monke_screenshot.png)
![](/screenshots/night%20city.png)
![](/screenshots/rose%20screenshot.png)

## Acknowledgements & wisdom 😇

 - [Algorithm tutorial by Alex Townsend](http://pi.math.cornell.edu/~web6140/TopTenAlgorithms/JPEG.html)
 -  [Awesome video explaining Computation](https://www.youtube.com/watch?v=Kv1Hiv3ox8I) 
  
 [![Awesome video explaining Computation](http://img.youtube.com/vi/Kv1Hiv3ox8I/0.jpg)](https://www.youtube.com/watch?v=Kv1Hiv3ox8I "Awesome video explaining Computation")
 
 - [Awesome video explaining Mathematics](https://youtu.be/0me3guauqOU)
 
 [![Awesome video explaining Mathematics](http://img.youtube.com/vi/0me3guauqOU/0.jpg)](https://youtu.be/0me3guauqOU "Awesome video explaining Mathematics")


## Authors

- [@myself](https://www.github.com/sameeriron42)
- [@sai teja](https://github.com/sai1027)


## Installation


Download MATLAB from [here](https://matlab.mathworks.com/). U need to have a licensed account😟
,u could also use your organization/university email🙂.

Install image processing toolbox from [here](https://in.mathworks.com/products/image.html).

## Running the code

- Clone the repo and navigate to the directory in matlab.
- Under current folder section right click and  select `add to path`> `current folder` option.
- your uncompressed images should be placed in `images/` folder.
- compressed image is saved as `result.jpg` in parent folder.
- `compression.m` is the main script for compression. Plenty of comments is provided so you won't be lost😉
### Before compiling
- specify the `filename`to path of your uncompressed image eg: `images/[your img].tiff`.
- Depending on whether the img is raw or rgb(jpg, png, tiff) img use `raw2rgb` or `imread` respectively.
- Finally hit `f5` or run button in editor tab

##RGB Channel
- Just an extra `RGB_channels.m` is to seperate out R,G,B components from image.
![]()
- `test.m` is literally what it is a script to test code





