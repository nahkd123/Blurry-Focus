# Blurry Focus
Post process shader that add blurs!

## Using this resourcepack
To use this resourcepack, you need Minecraft 1.17 (or higher, idk). You also need to set your graphics quality to _Fabulous_ (that mean you can cycle between no blur and blur shader without removing resourcepack)

## Showcases
![Forest](showcases/2021-06-10_21.16.51.png)

![Village](showcases/2021-06-10_21.20.46.png)

![The Bridge](showcases/2021-06-10_21.22.16.png)

## Editing parameters
Parameters can be changed inside assets/minecraft/shaders/program/transparency.fsh:
```glsl
// Blur directions, higher = better
#define BLUR_DIRECTIONS 16.0

// Blur quality, higher = better
#define BLUR_QUALITY 8.0

// The focus point, a.k.a where the point that receives no blur
#define FOCUS_POINT 0.025
#define FOCUS_SPREAD 0.045

// Blurriness
#define BLUR_SIZE 0.03
```