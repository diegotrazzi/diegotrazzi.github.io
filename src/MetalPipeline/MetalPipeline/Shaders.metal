//
//  Shaders.metal
//  MetalPipeline
//
//  Created by mac_sys1 on 11/22/24.
//

// 1
struct VertexIn {
  float4 position [[attribute(0)]];
};
// 2
vertex float4 vertex_main(const VertexIn vertexIn [[stage_in]])
{
  return vertexIn.position;
}
