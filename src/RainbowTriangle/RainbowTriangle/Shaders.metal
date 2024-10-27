//
//  Shaders.metal
//  RainbowTriangle
//
//  Created by mac_sys1 on 10/25/24.
//

#include <metal_stdlib>
#include "ShaderDefinitions.h"
using namespace metal;

struct VertexOut {
    float4 color;
    float4 pos [[position]];
};

// Hash function for noise generation
float hash3(float3 p) {
    return fract(sin(dot(p, float3(1.0, 57.0, -13.7))) * 4375.5453);
}

// 3D Noise function using tri-linear interpolation
float noise3(float3 x) {
    float3 p = floor(x);
    float3 f = fract(x);

    f = f * f * (3.0 - 2.0 * f); // Smoothing to make derivatives continuous

    return mix(
        mix(
            mix(hash3(p + float3(0, 0, 0)), hash3(p + float3(1, 0, 0)), f.x),
            mix(hash3(p + float3(0, 1, 0)), hash3(p + float3(1, 1, 0)), f.x),
            f.y
        ),
        mix(
            mix(hash3(p + float3(0, 0, 1)), hash3(p + float3(1, 0, 1)), f.x),
            mix(hash3(p + float3(0, 1, 1)), hash3(p + float3(1, 1, 1)), f.x),
            f.y
        ),
        f.z
    );
}

// Improved noise function
float noise(float3 x) {
    return (noise3(x) + noise3(x + float3(11.5))) / 2.0;
}

vertex VertexOut vertexShader(const device Vertex *vertexArray [[buffer(0)]], unsigned int vid [[vertex_id]])
{
    /**
     In Metal, if you want to rotate a triangle upside down in the geometry shader, you can apply a rotation transformation to each vertex position. To rotate the triangle 180 degrees (upside down) around the origin, you can multiply each vertex position by a rotation matrix.
     */
    Vertex in = vertexArray[vid];
    VertexOut out;

    // Copy color from input to output
    out.color = in.color;

    // Apply a 180 rotation by flipping x and y
    out.pos = float4(-in.pos.x, -in.pos.y, 0, 1);
    return out;
}

fragment float4 fragmentShader(VertexOut interpolated [[stage_in]], constant FragmentUniforms &uniforms [[buffer(0)]])
{
    float4 blueColor = float4(0.0, 0.0, 1.0, 1.0); // Blue color
    float4 mixedColor = mix(interpolated.color, blueColor, 0.5); // 50% blend between vertex color and blue
    float4 outColor = float4(mixedColor.rgb * uniforms.brightness, interpolated.color.a);
    return outColor;
}
