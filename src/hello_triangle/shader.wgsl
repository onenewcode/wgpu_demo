// 责处理每个顶点的数据，并计算出顶点的最终位置
@vertex  //是输入参数，表示当前顶点的索引。
fn vs_main(@builtin(vertex_index) in_vertex_index: u32) -> @builtin(position) vec4<f32> { //@builtin(vertex_index)：这是一个内置属性修饰符，表示这个变量是一个内置变量，并且它的值是由图形管线自动提供的。
    
    let x = f32(i32(in_vertex_index)-1);
     //如果 in_vertex_index 是奇数，y 将是 1.0。
    // 如果 in_vertex_index 是偶数，y 将是 -1.0。
    let y = f32(i32(in_vertex_index & 1u) * 2 - 1);
    return vec4<f32>(x, y, 0.0, 1.0);
}

// 用于显示颜色
@fragment
fn fs_main() -> @location(0) vec4<f32> {
    return vec4<f32>(1.0, 0.0, 0.0, 1.0);
}
