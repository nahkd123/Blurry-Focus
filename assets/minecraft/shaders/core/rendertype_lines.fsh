#version 150

#moj_import <fog.glsl>

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;

out vec4 fragColor;

void main() {
    //vec4 color = vertexColor * ColorModulator;
    //fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
    //fragColor = vec4(sin(GameTime * 1000.0), 0, 0, 1);
    // Time varying pixel color
    //vec3 col = 0.5 + 0.5 * cos((GameTime * 7500.0) + vec3(0, 2, 4));
    
    fragColor = vec4(0.0, 0.0, 0.0, 1.0);
}
