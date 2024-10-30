## Structure

For the simplest examples without using any helping code (see `framework.rs` here), check out:

- `hello` for printing adapter information
- `hello_triangle` for graphics and presentation
- `hello_compute` for pure computing

### Summary of examples

A summary of the basic examples as split along the graphics and compute "pathways" laid out roughly in order of building on each other. Those further indented, and thus more roughly dependent on more other examples, tend to be more complicated as well as those further down. It should be noted, though, that computing examples, even though they are mentioned further down (because rendering to a window is by far the most common use case), tend to be less complex as they require less surrounding context to create and manage a window to render to.

The rest of the examples are for demonstrating specific features that you can come back for later when you know what those features are.

#### General

- `hello` - Demonstrates the basics of the WGPU library by getting a default Adapter and debugging it to the screen

#### Graphics

- `hello_triangle` - Provides an example of a bare-bones WGPU workflow using the Winit crate that simply renders a red triangle on a green background.
- `uniform_values` - Demonstrates the basics of enabling shaders and the GPU, in general, to access app state through uniform variables. `uniform_values` also serves as an example of rudimentary app building as the app stores state and takes window-captured keyboard events. The app displays the Mandelbrot Set in grayscale (similar to `storage_texture`) but allows the user to navigate and explore it using their arrow keys and scroll wheel.
- `cube` - Introduces the user to slightly more advanced models. The example creates a set of triangles to form a cube on the CPU and then uses a vertex and index buffer to send the generated model to the GPU for usage in rendering. It also uses a texture generated on the CPU to shade the sides of the cube and a uniform variable to apply a transformation matrix to the cube in the shader.
- `bunnymark` - Demonstrates many things, but chief among them is performing numerous draw calls with different bind groups in one render pass. The example also uses textures for the icon and uniform buffers to transfer both global and per-particle states.
- `skybox` - Shows off too many concepts to list here. The name comes from game development where a "skybox" acts as a background for rendering, usually to add a sky texture for immersion, although they can also be used for backdrops to give the idea of a world beyond the game scene. This example does so much more than this, though, as it uses a car model loaded from a file and uses the user's mouse to rotate the car model in 3d. `skybox` also makes use of depth textures and similar app patterns to `uniform_values`.
- `shadow` - Likely by far the most complex example (certainly the largest in lines of code) of the official WGPU examples. `shadow` demonstrates basic scene rendering with the main attraction being lighting and shadows (as the name implies). It is recommended that any user looking into lighting be very familiar with the basic concepts of not only rendering with WGPU but also the primary mathematical ideas of computer graphics.
- `render_to_texture` - Renders to an image texture offscreen, demonstrating both off-screen rendering as well as how to add a sort of resolution-agnostic screenshot feature to an engine. This example either outputs an image file of your naming (pass command line arguments after specifying a `--` like `cargo run --bin wgpu-examples -- render_to_texture "test.png"`) or adds an `img` element containing the image to the page in WASM.

#### Compute

- `hello_compute` - Demonstrates the basic workflow for getting arrays of numbers to the GPU, executing a shader on them, and getting the results back. The operation it performs is finding the Collatz value (how many iterations of the [Collatz equation](https://en.wikipedia.org/wiki/Collatz_conjecture) it takes for the number to either reach 1 or overflow) of a set of numbers and prints the results.
- `repeated_compute` - Mostly for going into detail on subjects `hello-compute` did not. It, too, computes the Collatz conjecture, but this time, it automatically loads large arrays of randomly generated numbers, prints them, runs them, and prints the result. It does this cycle 10 times.
- `hello_workgroups` - Teaches the user about the basics of compute workgroups; what they are and what they can do.
- `hello_synchronization` - Teaches the user about synchronization in WGSL, the ability to force all invocations in a workgroup to synchronize with each other before continuing via a sort of barrier.
- `storage_texture` - Demonstrates the use of storage textures as outputs to compute shaders. The example on the outside seems very similar to `render_to_texture` in that it outputs an image either to the file system or the web page, except displaying a grayscale render of the Mandelbrot Set. However, inside, the example dispatches a grid of compute workgroups, one for each pixel, which calculates the pixel value and stores it to the corresponding pixel of the output storage texture. This example either outputs an image file of your naming (pass command line arguments after specifying a `--` like `cargo run --bin wgpu-examples -- storage_texture "test.png"`) or adds an `img` element containing the image to the page in WASM.

#### Combined

- `boids` - Demonstrates how to combine compute and render workflows by performing a [boid](https://en.wikipedia.org/wiki/Boids) simulation and rendering the boids to the screen as little triangles.

## Feature matrix

| Feature                      | boids  | bunnymark | conservative_raster | cube   | hello_synchronization | hello_workgroups | mipmap | msaa_line | render_to_texture | repeated_compute | shadow | skybox | stencil_triangles | storage_texture | texture_arrays | uniform_values | water  |
| ---------------------------- | ------ | --------- | ------------------- | ------ | --------------------- | ---------------- | ------ | --------- | ----------------- | ---------------- | ------ | ------ | ----------------- | --------------- | -------------- | -------------- | ------ |
| vertex attributes            | :star: |           |                     | :star: |                       |                  |        | :star:    |                   |                  | :star: | :star: |                   |                 | :star:         |                | :star: |
| instancing                   | :star: |           |                     |        |                       |                  |        |           |                   |                  |        |        |                   |                 |                |                |        |
| lines and points             |        |           | :star:              |        |                       |                  |        | :star:    |                   |                  |        |        |                   |                 |                |                |        |
| dynamic buffer offsets       |        | :star:    |                     |        |                       |                  |        |           |                   |                  | :star: |        |                   |                 |                |                |        |
| implicit layout              |        |           |                     |        |                       |                  | :star: |           |                   |                  |        |        |                   |                 |                |                |        |
| sampled color textures       | :star: | :star:    | :star:              | :star: |                       |                  | :star: |           |                   |                  |        | :star: |                   |                 | :star:         |                | :star: |
| storage textures             | :star: |           |                     |        |                       |                  |        |           |                   |                  |        |        |                   | :star:          |                |                |        |
| comparison samplers          |        |           |                     |        |                       |                  |        |           |                   |                  | :star: |        |                   |                 |                |                |        |
| subresource views            |        |           |                     |        |                       |                  | :star: |           |                   |                  | :star: |        |                   |                 |                |                |        |
| cubemaps                     |        |           |                     |        |                       |                  |        |           |                   |                  |        | :star: |                   |                 |                |                |        |
| multisampling                |        |           |                     |        |                       |                  |        | :star:    |                   |                  |        |        |                   |                 |                |                |        |
| off-screen rendering         |        |           | :star:              |        |                       |                  |        |           | :star:            |                  | :star: |        |                   |                 |                |                | :star: |
| stencil testing              |        |           |                     |        |                       |                  |        |           |                   |                  |        |        | :star:            |                 |                |                |        |
| depth testing                |        |           |                     |        |                       |                  |        |           |                   |                  | :star: | :star: |                   |                 |                |                | :star: |
| depth biasing                |        |           |                     |        |                       |                  |        |           |                   |                  | :star: |        |                   |                 |                |                |        |
| read-only depth              |        |           |                     |        |                       |                  |        |           |                   |                  |        |        |                   |                 |                |                | :star: |
| blending                     |        | :star:    |                     | :star: |                       |                  |        |           |                   |                  |        |        |                   |                 |                |                | :star: |
| render bundles               |        |           |                     |        |                       |                  |        | :star:    |                   |                  |        |        |                   |                 |                |                | :star: |
| uniform buffers              |        |           |                     |        |                       |                  |        |           |                   |                  |        |        |                   |                 |                | :star:         |        |
| compute passes               | :star: |           |                     |        | :star:                | :star:           |        |           |                   | :star:           |        |        |                   | :star:          |                |                |        |
| buffer mapping               |        |           |                     |        | :star:                | :star:           |        |           |                   | :star:           |        |        |                   | :star:          |                |                |        |
| error scopes                 |        |           |                     | :star: |                       |                  |        |           |                   |                  |        |        |                   |                 |                |                |        |
| compute workgroups           |        |           |                     |        | :star:                | :star:           |        |           |                   |                  |        |        |                   |                 |                |                |        |
| compute synchronization      |        |           |                     |        | :star:                |                  |        |           |                   |                  |        |        |                   |                 |                |                |        |
| _optional extensions_        |        |           |                     |        |                       |                  |        |           |                   |                  |        |        |                   |                 | :star:         |                |        |
| - SPIR-V shaders             |        |           |                     |        |                       |                  |        |           |                   |                  |        |        |                   |                 |                |                |        |
| - binding array              |        |           |                     |        |                       |                  |        |           |                   |                  |        |        |                   |                 | :star:         |                |        |
| - push constants             |        |           |                     |        |                       |                  |        |           |                   |                  |        |        |                   |                 |                |                |        |
| - depth clamping             |        |           |                     |        |                       |                  |        |           |                   |                  | :star: |        |                   |                 |                |                |        |
| - compressed textures        |        |           |                     |        |                       |                  |        |           |                   |                  |        | :star: |                   |                 |                |                |        |
| - polygon mode               |        |           |                     | :star: |                       |                  |        |           |                   |                  |        |        |                   |                 |                |                |        |
| - queries                    |        |           |                     |        |                       |                  | :star: |           |                   |                  |        |        |                   |                 |                |                |        |
| - conservative rasterization |        |           | :star:              |        |                       |                  |        |           |                   |                  |        |        |                   |                 |                |                |        |
| _integrations_               |        |           |                     |        |                       |                  |        |           |                   |                  |        |        |                   |                 |                |                |        |
| - staging belt               |        |           |                     |        |                       |                  |        |           |                   |                  |        | :star: |                   |                 |                |                |        |
| - typed arena                |        |           |                     |        |                       |                  |        |           |                   |                  |        |        |                   |                 |                |                |        |
| - obj loading                |        |           |                     |        |                       |                  |        |           |                   |                  |        | :star: |                   |                 |                |                |        |

## Running on the Web

To run the examples in a browser, run `cargo xtask run-wasm`.
Then open `http://localhost:8000` in your browser, and you can choose an example to run.
Naturally, in order to display any of the WebGPU based examples, you need to make sure your browser supports it.

Note that many cannot be downleveled to WebGL as WebGL does (among other things) not support storage texture, storage buffers and compute shaders. Running any example using these feature in a browser will require that browser to support WebGPU.

## Additional notes

Note that the examples regarding computing build off of each other; repeated_compute extends hello_compute, hello_workgroups assumes you know the basic workflow of GPU computation, and hello_synchronization assumes you know what a workgroup is.

All the examples use [WGSL](https://gpuweb.github.io/gpuweb/wgsl.html) shaders unless specified otherwise.

All framework-based examples render to the window and are reftested against the screenshot in the directory.

## Hacking

You can record an API trace for any of the framework-based examples by starting them as:

```sh
mkdir -p trace && WGPU_TRACE=trace cargo run --features trace --bin wgpu-examples <example-name>
```
#  WGSL
## 学习记录
### 工作组
计算着色器中，一个工作组（Workgroup）就是一组调用，它们同时执行一个计算着色器阶段入口点，并共享对工作组地址空间中着色器变量的访问。可以将工作组理解为一个三维网格，我们通过（x, y, z）三个维度来声明当前计算着色器的工作组大小，每个维度上的默认值都是 1。
```wgsl
// WGSL
@workgroup_size(16, 16) // x = 16, y = 16, z = 1
@workgroup_size(16)     // x = 16, y = 1, z = 1
```
### Group 与 Binding 属性
WGSL 中每个资源都使用了 @group(X) 和 @binding(X) 属性标记，例如 @group(0) @binding(0) var<uniform> params: UniformParams 它表示的是 Uniform buffer 对应于哪个绑定组中的哪个绑定槽（对应于 wgpu API 调用）。WGSL 的属性非常明晰，描述了着色器阶段到结构的精确二进制布局的所有内容。

### 变量声明
WGSL 对于基于显式类型的 var 的变量声明有不同的语法。
```wgsl
// WGSL:
var color: vec4f;
```
WGSL 没有像 lowp 这样的精度说明符, 而是显式指定具体类型，例如 f32（32 位浮点数）。如果要使用 f16 类型，需要在你的 WebGPU 程序中开启 shader-f16 扩展（wgpu 中目前已经加入了此扩展，但是 naga 中还没有完全实现对 f16 的支持）。

WGSL 支持自动类型推断。因此，如果在声明变量的同时进行赋值，就不必指定类型：

```wgsl
// 显式指定变量类型声明
var color: vec4f = vec4f(1.0, 0.0, 0.0, 1.0);

// 省略类型声明，变量类型将在编译时自动推断得出
var color = vec4f(1.0, 0.0, 0.0, 1.0);
```
WGSL 中的 var let 关键字与 Swift 语言一样：

var 表示变量可变或可被重新赋值（与 Rust 中的 let mut 一样）;
let 表示变量不可变，不能重新赋值;
### 结构体
在 WGSL 中，结构体（struct）用于表示 Unoform 及 Storage 缓冲区以及着色器的输入和输出。Unoform 缓冲区与 GLSL 类似，Storage 缓冲区虽然也在 GLSL 中存在等价物，但是 WebGL 2.0 并不支持。

WGSL 结构体字段对齐规则也与 GLSL 几乎一致，想要了解更多细节，可查看 WGSL 规范中的字节对齐规则示例：
```wgsl
// WGSL
struct UniformParams {
    mvp: mat4x4f,
	tint_color: vec3f,
};
@group(0) @binding(0) var<uniform> params: UniformParams;
// ...
out.position = params.mvp * vec4f(pos, 1.0);
```
注意到上面 Unoform 缓冲区在声明及使用上的两个区别了吗？

WGSL 需要先定义结构体然后才能声明绑定，而 GLSL 可以在声明绑定的同时定义（当然也支持先定义）;
WGSL 里需要用声明的变量来访问结构体字段，而 GLSL 里是直接使用结构体中的字段;
WGSL 的输入和输出结构体比较独特，在 GLSL 中没有对应物。入口函数接受输入结构，返回输出结构，并且结构体的所有字段都有 location(X) 属性注释。 如果只有单个输入或输出，那使用结构体就是可选的。

这种明确定义输入和输出的方式，使得 WGSL 的代码逻辑更加清晰，明显优于在 GLSL 中给魔法变量赋值的方式。

下边是一个顶点着色器的输出结构体（同时它也是对应的片元着色器的输入结构体）：

```wgsl
struct VertexOutput {
    @location(0) uv: vec2f,
    @builtin(position) position: vec4f,
};
```

### 函数语法
WGSL 函数语法与 Rust 一致, 而 GLSL 是类 C 语法。一个简单的 add 函数如下：
```wgsl
// WGSL
fn add(a: f32, b: f32) -> f32 {
	return a + b;
}
```
### 纹理
#### 采样纹理
WGSL 中采样纹理总是要指定纹素（Texel)的数据类型 texture_2d<T>、texture_3d<T>、texture_cube<T>、texture_cube_array<T>（T 必须是 f32、i32、u32 这三种类型之一），而 GLSL 中是没有纹素类型信息的，只有查看使用此着色器的程序源码才能知道：
```wgsl
// WGSL
@group(0) @binding(1) var texture_front: texture_2d<f32>;
```
#### Storage 纹理
WGSL 中存储纹理的数据类型为 texture_storage_XX<T, access>, 而 GLSL 中没有明确的存储纹理类型，如果需要当做存储纹理使用，就需要在 layout(...) 中标记出纹素格式:
```wgsl
// WGSL
@group(0) @binding(2) var swap_pic: texture_storage_2d<rgba32float, write>;
```
在目前的 WebGPU 标准中, 存储纹理的 access 只能为 write(只写), wgpu 能在 native 中支持 read_write(可读可写)。

更多 WGSL 语法细节
### 三元运算符
GLSL 支持三元运算符 ? : , WGSL 并不直接支持，但提供了内置函数 select(falseValue，trueValue，condition)：

```rust
// GLSL
int n = isTrue ? 1 : 0;

// WGSL
let n: i32 = select(0, 1, isTrue);
```
### 花括号
WGSL 中的 if else 语法不能省略大括号（与 Rust 及 Swift 语言一样）：

```rust
// WGSL
if (gray > 0.2) { n = 65600; }
```
### 求模运算
GLSL 中我们使用 mod 函数做求模运算，WGSL 中有一个长得类似的函数 modf, 但它的功能是将传入参数分割为小数与整数两部分。在 WGSL 中需要使用 % 运算符来求模, 且 mod 与 % 的工作方式还略有不同， mod 内部使用的是 floor (x - y * floor(x / y)), 而 % 内部使用的是 trunc (x - y * trunc(x / y)):

```rust
// WGSL
let n = x % y;
```
#### 着色器预处理
听到过很多人抱怨 WGSL 不提供预处理器，但其实所有的着色器语言都不自己提供预处理，只是我们可能已经习惯了使用已经封装好预处理逻辑的框架。

其实自己写一个预处理逻辑也是非常简单的事，有两种实现预处理的机制：

着色器被调用时实时预处理（对运行时性能会产生负影响）;
利用 build.rs 在程序编译阶段预处理，并磁盘上生成预处理后的文件;
这两种实现方式的代码逻辑其实是一样的，仅仅是预处理的时机不同。

下边是一个需要预处理的实现了边缘检测的片元着色器：

```rust
///#include "common/group0+vs.wgsl"

///#include "func/edge_detection.wgsl"

@fragment
fn fs_main(vertex: VertexOutput) -> @location(0) vec4f {
    let color = textureSample(tex, tex_sampler, vertex.uv);
    return vec4f(edge_detection(length(color.rgb), 0.125));
}
///#include 后面的路径分指向的是 common 及 func 目录下已经实现好的通用顶点着色器与边缘检测函数，我们现在按第 2 种机制实现一个简单的预处理来自动将顶点着色器及边缘检测函数包含进来:

```rust
const WGSL_FOLDER: &'static str = "../wgsl_preprocessed";
const INCLUDE: &tatic str = "///#include ";

fn main() -> Result<(), Box<dyn Error>> {
    // 这一行告诉 cargo 如果 /wgsl/ 目录中的内容发生了变化，就重新运行脚本
    println!("cargo:rerun-if-changed=/../wgsl/");

    // 需要预处理的着色器数组（当然，更好的方式是读取并遍历待处理文件夹）
    let shader_files = vec!["edge_detection"];

    // 创建预处理后着色器的存放目录
    std::fs::create_dir_all(WGSL_FOLDER)?;
    for name in shader_files {
        let _ = regenerate_shader(name);
    }
    Ok(())
}

fn regenerate_shader(shader_name: &str) -> Result<(), Box<dyn Error>> {
    let base_dir = env!("CARGO_MANIFEST_DIR");
    let path = PathBuf::from(&base_dir)
        .join("../wgsl")
        .join(format!("{}.wgsl", shader_name));
    let mut out_path = WGSL_FOLDER.to_string();
    out_path += &format!("/{}.wgsl", shader_name.replace("/", "_"));

    let code = match read_to_string(&path) {
        Ok(code) => code,
        Err(e) => {
            panic!("无法读取 {:?}: {:?}", path, e)
        }
    };

    let mut shader_source = String::new();
    parse_shader_source(&code, &mut shader_source, &base_dir);

    let mut f = std::fs::File::create(&std::path::Path::new(&base_dir).join(&out_path))?;
    f.write_all(shader_source.as_bytes())?;

    Ok(())
}

fn parse_shader_source(source: &str, output: &mut String, base_path: &str) {
    for line in source.lines() {
        if line.starts_with(INCLUDE) {
            // 支持一次 include 多个外部着色器文件，文件路径之间用 , 号分割
            let imports = line[INCLUDE.len()..].split(',');
            // 遍历所有待导入的文件，递归处理导入的代码里还包括导入的情况
            for import in imports {
                if let Some(include) = get_include_code(import, base_path) {
                    parse_shader_source(&include, output, base_path);
                } else {
                    println!("无法找到要导入的着色器文件: {}", import);
                }
            }
        }
    }
}

fn get_include_code(key: &str, base_path: &str) -> Option<String> {
    let path = PathBuf::from(base_path)
        .join("../wgsl")
        .join(key.replace('"', ""));
    let shader = match read_to_string(&path) {
        Ok(code) => code,
        Err(e) => panic!("无法读取 {:?}: {:?}", path, e),
    };
    Some(shader)
}
```
上面的几十行代码就是一套完整的预处理逻辑，它在每次程序编译时自动检查 wgsl/ 目录下的待处理着色器有没有发生变化，如果有变化，就重新处理并在 wgsl_preprocessed/ 目录下写入一个同名的处理后的着色器。