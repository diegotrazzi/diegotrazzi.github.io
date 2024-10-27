//
//  ShaderDefinitions.h
//  RainbowTriangle
//
//  Created by mac_sys1 on 10/25/24.
//

#ifndef ShaderDefinitions_h
#define ShaderDefinitions_h

#include <simd/simd.h>

struct Vertex {
    vector_float4 color;
    vector_float2 pos;
};

struct FragmentUniforms {
    float brightness;
};

#endif /* ShaderDefinitions_h */
