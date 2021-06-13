#version 150

uniform vec2 ScreenSize;
uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

uniform sampler2D DiffuseSampler;
uniform sampler2D DepthBuffer;
uniform sampler2D md5;

in vec2 texCoord;

#define PI 3.1415926535898
#define PI_2 6.28318530718

// Edit parameters here
#define BLUR_DIRECTIONS 16.0
#define BLUR_QUALITY 4.0

#define FOCUS_SPREAD 0.00
#define BLUR_SIZE 0.3

out vec4 fragColor;

vec4 gaussianColor(float blurRadius) {
    vec4 Color = texture(DiffuseSampler, texCoord);

    for (float d = 0.0; d < PI_2; d += PI_2 / BLUR_DIRECTIONS) {
		for (float i = 1.0 / BLUR_QUALITY; i <= 1.0; i += 1.0 / BLUR_QUALITY) {
			Color += texture(DiffuseSampler, texCoord + vec2(cos(d), sin(d)) * blurRadius * i);
        }
    }

    Color /= BLUR_QUALITY * BLUR_DIRECTIONS - 15.0;
    Color /= 1.3; // Color Correction
    return Color;
}

void main() {
    float centerDepth = texture(DepthBuffer, vec2(0.5)).x;
    float depth = texture(DepthBuffer, texCoord).x;

    float a = max(abs(depth - centerDepth) - FOCUS_SPREAD, 0.0);
    float blurRadius = a * BLUR_SIZE;
    
    fragColor = gaussianColor(blurRadius);
}
