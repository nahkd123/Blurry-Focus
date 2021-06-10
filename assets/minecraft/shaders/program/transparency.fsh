#version 150

uniform vec2 ScreenSize;

uniform sampler2D DiffuseSampler;
uniform sampler2D DepthBuffer;
uniform sampler2D md5;

in vec2 texCoord;

#define PI 3.1415926535898
#define PI_2 6.28318530718

// Edit parameters here
#define BLUR_DIRECTIONS 16.0
#define BLUR_QUALITY 8.0

#define FOCUS_POINT 0.025
#define FOCUS_SPREAD 0.045
#define BLUR_SIZE 0.03

#define FOCUS_POINT_MIN (FOCUS_POINT - FOCUS_SPREAD)
#define FOCUS_POINT_MAX (FOCUS_POINT + FOCUS_SPREAD)

out vec4 fragColor;

void main() {
    float depth = 1 - texture(DepthBuffer, texCoord).x;
    //if (depth >= FOCUS_POINT_MIN && depth <= FOCUS_POINT_MAX) fragColor = vec4(depth, depth, depth, 1);
    //else fragColor = vec4(0, 0, 0, 1);
    //return;

    if (depth < FOCUS_POINT_MIN) depth = 0;
    if (depth > FOCUS_POINT_MAX) depth = 0;

    // Map depth
    float focusSpread = FOCUS_POINT_MAX - FOCUS_POINT_MIN;
    depth = (depth - FOCUS_POINT_MIN) / FOCUS_POINT_MAX;
    if (depth < 0.5) depth *= 2.0;
    else depth = (1.0 - depth) * 2.0;

    float blurRadius = (1.0 - depth) * BLUR_SIZE;
    
    // Gaussian Blur
    vec4 Color = texture(DiffuseSampler, texCoord);

    for (float d = 0.0; d < PI_2; d += PI_2 / BLUR_DIRECTIONS) {
		for (float i = 1.0 / BLUR_QUALITY; i <= 1.0; i += 1.0 / BLUR_QUALITY) {
			Color += texture(DiffuseSampler, texCoord + vec2(cos(d), sin(d)) * blurRadius * i);		
        }
    }

    Color /= BLUR_QUALITY * BLUR_DIRECTIONS - 15.0;
    fragColor = Color;
}
