struct VertexOutput {
    @location(0) tex_coord: vec2<f32>, //@location(0) 中填任何值都能运行
    // @builtin(position)：这个内置变量修饰符指定了一个特殊的用途，即该变量代表了顶点着色器输出的最终位置。position 变量是必需的，因为它告诉图形管线如何在屏幕上定位顶点。
    @builtin(position) position: vec4<f32>,
};

@group(0)
@binding(0)
var<uniform> transform: mat4x4<f32>; //矩阵投影

@vertex
fn vs_main(
    @location(0) position: vec4<f32>,
    @location(1) tex_coord: vec2<f32>,
) -> VertexOutput {
    var result: VertexOutput;
    result.tex_coord = tex_coord;
    result.position = transform * position;
    return result;
}

@group(0)
@binding(1)
var r_color: texture_2d<u32>;

@fragment
fn fs_main(vertex: VertexOutput) -> @location(0) vec4<f32> {
    // 着色渲染
    let tex = textureLoad(r_color, vec2<i32>(vertex.tex_coord * 25.0), 0);
    let v = f32(tex.x) / 255.0;
    return vec4<f32>(1.0 - (v * 5.0), 1.0 - (v * 15.0), 1.0 - (v * 50.0), 1.0);
}

@fragment
fn fs_wire(vertex: VertexOutput) -> @location(0) vec4<f32> {
    return vec4<f32>(0.0, 0.5, 0.0, 0.5);
}
