#version 330 core

uniform sampler2D color_texture;
uniform sampler2D depth_texture;

in vec2 fragment_uv;

out vec3 color;

const float znear = 0.1;
const float zfar = 192.0;

float linearize(float depth) {
    return -zfar * znear / (depth * (zfar - znear) - zfar);
}

void main() {
    float p = 1.0 / 4096.0;
    float depth = texture(depth_texture, fragment_uv).x;
    depth = linearize(depth);
    float ref = texture(depth_texture, vec2(800 / 4096.0, 600 / 4096.0)).x;
    ref = linearize(ref);
    p = p * abs(ref - depth) / 192 * 16;
    color = vec3(texture(color_texture, fragment_uv));
    // color = vec3(depth / 192.0);
    // return;
    color = vec3(0);
    for (int dy = -1; dy <= 1; dy++) {
        for (int dx = -1; dx <= 1; dx++) {
            color += vec3(texture(color_texture, fragment_uv + vec2(dx * p, dy * p)));
        }
    }
    color /= 9;
}
