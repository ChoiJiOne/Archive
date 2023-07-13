# [Getting Started : Shaders](https://learnopengl.com/Getting-started/Shaders)

[Hello Triangle](../02.GettingStarted-04.HelloTriangle/README.md) chapter에서 언급된 대로, 셰이더는 GPU에 위치한 작은 프로그램들입니다. 이러한 프로그램들은 그래픽 파이프라인의 각 특정 부분에서 실행됩니다. 기본적으로, 셰이더는 입력을 출력으로 변환하는 프로그램에 불과합니다. 또한 셰이더는 서로 통신할 수 없는 매우 독립적인 프로그램들이며, 그들이 가지는 유일한 통신 수단은 입력과 출력을 통한 것입니다.

이전 장에서는 셰이더에 대해 간단히 다루고 어떻게 올바르게 사용하는지 알아보았습니다. 이제 더 일반적인 방식으로 셰이더와 특히 OpenGL 셰이딩 언어에 대해 설명하겠습니다.
<br><br>


## GLSL

셰이더는 C와 유사한 GLSL 언어로 작성됩니다. GLSL은 그래픽에 사용하기 위해 특별히 설계된 언어로, 벡터와 행렬 조작에 특화된 유용한 기능을 포함하고 있습니다.

셰이더는 항상 버전 선언으로 시작하며, 입력 및 출력 변수, 유니폼(uniform) 변수 및 주요 함수의 목록이 이어집니다. 각 셰이더의 진입점은 주요 함수에서 이루어지며, 입력 변수를 처리하고 결과를 출력 변수에 저장합니다. 유니폼이 무엇인지 모르셔도 걱정하지 마세요. 곧 설명하겠습니다.

일반적으로 셰이더는 다음과 같은 구조를 갖습니다:

```
#version version_number
in type in_variable_name;
in type in_variable_name;

out type out_variable_name;
  
uniform type uniform_name;
  
void main()
{
  // process input(s) and do some weird graphics stuff
  ...
  // output processed stuff to output variable
  out_variable_name = weird_stuff_we_processed;
}
```

특히 정점 셰이더에 대해 언급할 때 각 입력 변수는 정점 속성(vertex attribute)으로도 알려져 있습니다. 하드웨어에 의해 제한되는 선언할 수 있는 정점 속성의 최대 수가 있습니다. OpenGL은 항상 최소한 16개의 4-요소 정점 속성을 사용할 수 있음을 보장하지만, 일부 하드웨어는 더 많은 정점 속성을 지원할 수 있습니다. 이는 GL_MAX_VERTEX_ATTRIBS를 조회함으로써 확인할 수 있습니다.

```
int nrAttributes;
glGetIntegerv(GL_MAX_VERTEX_ATTRIBS, &nrAttributes);
std::cout << "Maximum nr of vertex attributes supported: " << nrAttributes << std::endl;
```

이는 대부분의 목적에 충분한 16 이상의 최소값을 반환하는 경우가 많습니다.
<br><br>


## Types

GLSL은 다른 프로그래밍 언어와 마찬가지로 변수를 작업할 때 사용할 데이터 유형을 지정하는데 사용되는 유형을 갖고 있습니다. GLSL은 C와 같은 언어에서 알고 있는 대부분의 기본 유형을 갖고 있습니다: int, float, double, uint, bool 등이 있습니다. 또한 GLSL은 우리가 많이 사용할 두 가지 컨테이너 유형, 즉 벡터와 행렬을 제공합니다. 행렬에 대해서는 나중에 설명하겠습니다.

### Vectors

GLSL에서의 벡터는 방금 언급한 기본 유형 중 하나를 사용하여 2, 3 또는 4개의 요소를 가진 컨테이너입니다. 다음과 같은 형식을 가질 수 있습니다 (n은 구성 요소의 수를 나타냅니다):

- vecn: n개의 float로 이루어진 기본 벡터입니다.
- bvecn: n개의 boolean으로 이루어진 벡터입니다.
- ivecn: n개의 정수로 이루어진 벡터입니다.
- uvecn: n개의 부호 없는 정수로 이루어진 벡터입니다.
- dvecn: n개의 double 요소로 이루어진 벡터입니다.

대부분의 경우 우리는 대부분의 목적에 충분한 float를 사용하기 때문에 기본적인 vecn을 사용할 것입니다.

벡터의 구성 요소는 vec.x와 같이 접근할 수 있습니다. 여기서 x는 벡터의 첫 번째 구성 요소입니다. 각각 첫 번째, 두 번째, 세 번째 및 네 번째 구성 요소에 접근하기 위해 .x, .y, .z 및 .w를 사용할 수 있습니다. 또한 GLSL은 동일한 구성 요소에 접근하기 위해 색상에는 rgba, 텍스처 좌표에는 stpq를 사용할 수 있도록 합니다.

벡터 데이터 유형은 스위즐링(swizzling)이라고 하는 흥미로운 유연한 구성 요소 선택을 가능하게 합니다. 스위즐링을 사용하면 다음과 같은 구문을 사용할 수 있습니다:

```
vec2 someVec;
vec4 differentVec = someVec.xyxx;
vec3 anotherVec = differentVec.zyw;
vec4 otherVec = someVec.xxxx + anotherVec.yxzy;
```

원본 벡터가 해당 구성 요소를 가지고 있다면 최대 4개의 문자 조합을 사용하여 새로운 벡터(동일한 유형)를 생성할 수 있습니다. 예를 들어, vec2의 .z 구성 요소에 접근하는 것은 허용되지 않습니다. 또한 벡터를 다른 벡터 생성자 호출의 인수로 전달하여 필요한 인수의 수를 줄일 수도 있습니다:

```
vec2 vect = vec2(0.5, 0.7);
vec4 result = vec4(vect, 0.0, 0.0);
vec4 otherResult = vec4(result.xyz, 1.0);
```

따라서 벡터는 우리가 모든 종류의 입력과 출력에 사용할 수 있는 유연한 데이터 유형입니다. 이 책에서는 벡터를 창의적으로 다룰 수 있는 다양한 예시를 많이 볼 수 있습니다.
<br><br>


## Ins and outs

셰이더 자체로서 셰이더는 멋진 작은 프로그램이지만, 셰이더는 전체 시스템의 일부이며 이를 위해 개별 셰이더에 입력과 출력을 가지고 싶습니다. 이를 위해 GLSL은 in과 out 키워드를 특별히 정의했습니다. 각 셰이더는 이러한 키워드를 사용하여 입력과 출력을 지정할 수 있으며, 출력 변수가 다음 셰이더 단계의 입력 변수와 일치하는 경우 전달됩니다. 그러나 정점 셰이더와 프래그먼트 셰이더는 약간 다릅니다.

정점 셰이더는 어떤 형태의 입력을 받아야만 효과적으로 동작할 수 있습니다. 정점 셰이더는 입력에서 바로 정점 데이터를 받는다는 점에서 입력 측면에서 다른 점이 있습니다. 정점 데이터가 어떻게 구성되어 있는지를 정의하기 위해 입력 변수를 위치 메타데이터와 함께 지정하여 CPU에서 정점 속성을 구성할 수 있습니다. 이전 장에서 layout (location = 0)으로 확인했습니다. 따라서 정점 셰이더는 입력에 대한 추가적인 레이아웃 지정이 필요하므로 정점 데이터와 연결할 수 있습니다.

> layout (location = 0) 지정자를 생략하고 glGetAttribLocation을 통해 OpenGL 코드에서 속성 위치를 조회할 수도 있습니다. 그러나 저는 정점 셰이더에서 설정하는 것을 선호합니다. 이렇게 하면 이해하기 쉽고 작업을 줄여줍니다.

다른 예외는 프래그먼트 셰이더가 최종 출력 색상을 생성해야 하므로 vec4 색상 출력 변수가 필요하다는 점입니다. 프래그먼트 셰이더에서 출력 색상을 지정하지 않으면 해당 프래그먼트의 색상 버퍼 출력은 정의되지 않습니다 (일반적으로 OpenGL은 이러한 프래그먼트를 흰색 또는 검은색으로 렌더링합니다).

따라서 하나의 셰이더에서 다른 셰이더로 데이터를 전송하려면 보내는 셰이더에서 출력을 선언하고 수신하는 셰이더에서 유사한 입력을 선언해야 합니다. 타입과 이름이 양쪽 모두 동일한 경우 OpenGL은 해당 변수를 연결하고 셰이더 간에 데이터를 전송할 수 있게 됩니다 (이는 프로그램 객체를 링크할 때 수행됩니다). 이를 실제로 어떻게 구현하는지 보여주기 위해 이전 장의 셰이더를 수정하여 정점 셰이더에서 프래그먼트 셰이더에 대한 색상을 결정하도록 할 것입니다.

### Vertex shader
```
#version 330 core
layout (location = 0) in vec3 aPos; // the position variable has attribute position 0
  
out vec4 vertexColor; // specify a color output to the fragment shader

void main()
{
    gl_Position = vec4(aPos, 1.0); // see how we directly give a vec3 to vec4's constructor
    vertexColor = vec4(0.5, 0.0, 0.0, 1.0); // set the output variable to a dark-red color
}
```

### Fragment shader
```
#version 330 core
out vec4 FragColor;
  
in vec4 vertexColor; // the input variable from the vertex shader (same name and same type)  

void main()
{
    FragColor = vertexColor;
} 
```

정점 셰이더에서 설정한 vec4 출력인 vertexColor 변수를 선언하고, 프래그먼트 셰이더에서는 유사한 vertexColor 입력을 선언했습니다. 두 변수가 동일한 유형과 이름을 가지고 있기 때문에 프래그먼트 셰이더의 vertexColor는 정점 셰이더의 vertexColor에 연결됩니다. 정점 셰이더에서 어두운 빨간색으로 색상을 설정했기 때문에 결과적으로 프래그먼트는 어두운 빨간색이어야 합니다. 다음 이미지는 출력을 보여줍니다.

![](2023-05-23-07-29-51.png)

> ※ 위 출력의 소스 코드는 [여기](../../02.GettingStarted/05.Shaders.01/main.cpp)에서 확인할 수 있습니다.

잘했습니다! 우리는 방금 정점 셰이더에서 프래그먼트 셰이더로 값을 전달하는 데 성공했습니다. 좀 더 흥미롭게 만들어서 애플리케이션에서 프래그먼트 셰이더로 색상을 전달할 수 있는지 확인해 봅시다!
<br><br>


## Uniforms

유니폼은 CPU에서 GPU의 셰이더로 데이터를 전달하는 또 다른 방법입니다. 그러나 유니폼은 정점 속성과 약간 다릅니다. 첫째로, 유니폼은 전역적입니다. 전역적이라는 것은 유니폼 변수가 셰이더 프로그램 객체당 고유하며 셰이더 프로그램의 어느 셰이더에서든지 어느 단계에서든 접근할 수 있다는 의미입니다. 둘째로, 유니폼 값이 어떤 값으로 설정되든지 유니폼은 해당 값을 재설정하거나 업데이트할 때까지 유지합니다.

GLSL에서 유니폼을 선언하기 위해 우리는 간단히 유니폼 키워드를 셰이더에 타입과 이름과 함께 추가합니다. 그 이후로는 셰이더에서 새로 선언된 유니폼을 사용할 수 있습니다. 이번에는 유니폼을 통해 삼각형의 색상을 설정할 수 있는지 확인해 봅시다.

```
#version 330 core
out vec4 FragColor;
  
uniform vec4 ourColor; // we set this variable in the OpenGL code.

void main()
{
    FragColor = ourColor;
}   
```

우리는 프래그먼트 셰이더에서 uniform vec4 ourColor를 선언하고, 프래그먼트의 출력 색상을 이 uniform 값으로 설정했습니다. 유니폼은 전역 변수이므로 원하는 셰이더 단계에서 정의할 수 있으므로 프래그먼트 셰이더로 데이터를 전달하기 위해 다시 정점 셰이더를 거치지 않아도 됩니다. 우리는 정점 셰이더에서 이 uniform을 사용하지 않으므로 정점 셰이더에서 정의할 필요가 없습니다.

> GLSL 코드에서 사용되지 않는 유니폼을 선언하면 컴파일러가 해당 변수를 컴파일된 버전에서 암묵적으로 제거합니다. 이는 몇 가지 귀찮은 오류의 원인이 될 수 있으므로 이 점을 염두에 두세요!

현재 유니폼은 비어 있습니다. 아직 유니폼에 데이터를 추가하지 않았으므로 이를 시도해 보겠습니다. 먼저 셰이더에서 유니폼 속성의 인덱스/위치를 찾아야 합니다. 유니폼의 인덱스/위치를 얻은 후에는 해당 값을 업데이트할 수 있습니다. 단일 색상을 프래그먼트 셰이더에 전달하는 대신 시간이 지남에 따라 색상이 서서히 변경되도록 만들어 보겠습니다.

```
float timeValue = glfwGetTime();
float greenValue = (sin(timeValue) / 2.0f) + 0.5f;
int vertexColorLocation = glGetUniformLocation(shaderProgram, "ourColor");
glUseProgram(shaderProgram);
glUniform4f(vertexColorLocation, 0.0f, greenValue, 0.0f, 1.0f);
```

먼저 glfwGetTime() 함수를 사용하여 실행 시간을 초 단위로 가져옵니다. 그런 다음 sin 함수를 사용하여 0.0에서 1.0 범위 내에서 색상을 변화시키고 그 결과를 greenValue에 저장합니다.

그런 다음 glGetUniformLocation을 사용하여 ourColor 유니폼의 위치를 조회합니다. 조회 함수에는 셰이더 프로그램과 유니폼의 이름을 제공하여 위치를 가져옵니다. glGetUniformLocation가 -1을 반환하면 위치를 찾을 수 없습니다. 마지막으로 glUniform4f 함수를 사용하여 유니폼 값을 설정할 수 있습니다. 유니폼 위치를 찾는 것은 먼저 셰이더 프로그램을 사용해야 하는 것은 아니지만, 유니폼을 업데이트하려면 프로그램을 먼저 사용해야 합니다 (glUseProgram을 호출하여 현재 활성화된 셰이더 프로그램에 유니폼을 설정하기 때문입니다).

```
OpenGL은 핵심적으로 C 라이브러리이기 때문에 함수 오버로딩을 직접적으로 지원하지 않습니다.  따라서 동일한 기능을 다른 유형으로 호출해야 하는 경우, OpenGL은 필요한 각 유형에 대해 새로운 함수를 정의합니다.  glUniform은 이를 잘 보여주는 예입니다.  이 함수는 설정하려는 유니폼의 유형에 대한 특정 접미사를 요구합니다.  가능한 몇 가지 접미사는 다음과 같습니다:

- f: 함수는 값으로 float를 기대합니다.
- i: 함수는 값으로 int를 기대합니다.
- ui: 함수는 값으로 unsigned int를 기대합니다.
- 3f: 함수는 값으로 3개의 float를 기대합니다.
- fv: 함수는 값으로 float 벡터/배열을 기대합니다.

OpenGL의 옵션을 구성하려면 해당 유형에 해당하는 오버로드된 함수를 선택하면 됩니다.  우리의 경우에는 유니폼에 개별적으로 4개의 float를 설정하려고 하므로, glUniform4f를 사용하여 데이터를 전달합니다 (참고로 fv 버전도 사용할 수 있습니다).
```

이제 유니폼 변수의 값을 설정하는 방법을 알았으므로, 렌더링에 사용할 수 있습니다. 색상을 점진적으로 변경하려면 매 프레임마다 이 유니폼을 업데이트해야 합니다. 그렇지 않으면 한 번만 설정하면 삼각형의 색상이 고정되어 변하지 않습니다. 따라서 우리는 greenValue를 계산하고 렌더링 반복마다 유니폼을 업데이트합니다:

```
while(!glfwWindowShouldClose(window))
{
    // input
    processInput(window);

    // render
    // clear the colorbuffer
    glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    // be sure to activate the shader
    glUseProgram(shaderProgram);
  
    // update the uniform color
    float timeValue = glfwGetTime();
    float greenValue = sin(timeValue) / 2.0f + 0.5f;
    int vertexColorLocation = glGetUniformLocation(shaderProgram, "ourColor");
    glUniform4f(vertexColorLocation, 0.0f, greenValue, 0.0f, 1.0f);

    // now render the triangle
    glBindVertexArray(VAO);
    glDrawArrays(GL_TRIANGLES, 0, 3);
  
    // swap buffers and poll IO events
    glfwSwapBuffers(window);
    glfwPollEvents();
}
```

이 코드는 이전 코드를 상대적으로 간단하게 수정한 것입니다. 이번에는 삼각형을 그리기 전에 매 프레임마다 유니폼 값을 업데이트합니다. 유니폼을 올바르게 업데이트하면 삼각형의 색상이 천천히 녹색에서 검은색으로 변하고 다시 녹색으로 돌아가는 것을 볼 수 있어야 합니다.

![](2023-05-23-07-37-37.png)

문제가 생기면 [여기서](../../02.GettingStarted/05.Shaders.02/main.cpp) 소스 코드를 확인하세요.

보시다시피, 유니폼은 매 프레임마다 변경될 수 있는 속성을 설정하는 데 유용하며, 응용 프로그램과 셰이더 간의 데이터 교환에도 사용될 수 있습니다. 그러나 각 정점에 대해 색상을 설정하려면 많은 유니폼을 선언해야 합니다. 더 좋은 해결책은 정점 속성에 더 많은 데이터를 포함하는 것인데, 이제 그것을 할 것입니다.
<br><br>


## More attributes!

이전 장에서 VBO를 채우고 정점 속성 포인터를 구성하고 모든 것을 VAO에 저장하는 방법을 보았습니다. 이번에는 정점 데이터에 색상 데이터를 추가하려고 합니다. 우리는 각각 삼각형의 모서리에 빨간색, 녹색, 파란색을 할당하기 위해 정점 배열에 3개의 float로 색상 데이터를 추가할 것입니다.

```
float vertices[] = {
    // positions         // colors
     0.5f, -0.5f, 0.0f,  1.0f, 0.0f, 0.0f,   // bottom right
    -0.5f, -0.5f, 0.0f,  0.0f, 1.0f, 0.0f,   // bottom left
     0.0f,  0.5f, 0.0f,  0.0f, 0.0f, 1.0f    // top 
};    
```

이제 정점 셰이더에 전송할 데이터가 더 많기 때문에 정점 셰이더를 조정하여 색상 값을 정점 속성 입력으로 받을 수 있도록 해야 합니다. aColor 속성의 위치를 1로 설정한 것에 주목하세요(layout 지정자 사용):

```
#version 330 core
layout (location = 0) in vec3 aPos;   // the position variable has attribute position 0
layout (location = 1) in vec3 aColor; // the color variable has attribute position 1
  
out vec3 ourColor; // output a color to the fragment shader

void main()
{
    gl_Position = vec4(aPos, 1.0);
    ourColor = aColor; // set ourColor to the input color we got from the vertex data
}    
```

이제 fragment의 색상을 위해 더 이상 uniform을 사용하지 않고 ourColor 출력 변수를 사용하므로 fragment 셰이더도 변경해야 합니다:

```
#version 330 core
out vec4 FragColor;  
in vec3 ourColor;
  
void main()
{
    FragColor = vec4(ourColor, 1.0);
}
```

또한, 추가된 정점 속성과 VBO의 메모리를 업데이트했으므로 정점 속성 포인터를 다시 구성해야 합니다. 업데이트된 VBO 메모리의 데이터는 다음과 같이 약간 변경되었습니다:

![](2023-05-23-07-40-13.png)

현재 레이아웃을 알고 있으므로 glVertexAttribPointer를 사용하여 정점 형식을 업데이트할 수 있습니다:

```
// position attribute
glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)0);
glEnableVertexAttribArray(0);
// color attribute
glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*)(3* sizeof(float)));
glEnableVertexAttribArray(1);
```

glVertexAttribPointer의 처음 몇 인수는 비교적 직관적입니다. 이번에는 속성 위치 1에 대해 정점 속성을 구성합니다. 색상 값은 3개의 float로 구성되어 있으며 값을 정규화하지 않습니다.

이제 두 개의 정점 속성이 있으므로 stride 값을 다시 계산해야 합니다. 데이터 배열에서 다음 속성 값을 가져오려면 (예: 위치 벡터의 다음 x 구성 요소) 오른쪽으로 6개의 float를 이동해야 합니다. 이는 float의 크기인 바이트 단위로 6배하여 stride 값인 24바이트가 됩니다.
또한, 이번에는 오프셋을 지정해야 합니다. 각 정점에서 위치 정점 속성이 처음이므로 오프셋은 0으로 선언합니다. 색상 속성은 위치 데이터 이후에 시작되므로 오프셋은 sizeof(float)의 3배인 바이트 단위로 12바이트입니다.

응용 프로그램을 실행하면 다음 이미지가 생성됩니다.

![](2023-05-23-07-41-19.png)

[여기](../../02.GettingStarted/05.Shaders.03/main.cpp)에 링크된 소스 코드를 확인해보세요. 만약 도움이 필요하다면 참고하시면 됩니다.

이미지가 예상한 것과 정확히 일치하지 않을 수 있습니다. 왜냐하면 우리가 지금 보고 있는 것은 거대한 색상 팔레트가 아니라 3가지 색상만 제공했기 때문입니다. 이는 프래그먼트 셰이더에서 일어나는 프래그먼트 보간(interpolation)의 결과입니다. 삼각형을 렌더링할 때, 래스터화 단계는 일반적으로 지정된 원래 정점보다 훨씬 많은 프래그먼트를 생성합니다. 래스터화기는 이러한 프래그먼트들이 삼각형 모양상 어디에 위치하는지를 결정합니다. 이러한 위치를 기반으로 래스터화기는 모든 프래그먼트 셰이더의 입력 변수들을 보간(interpolate)합니다. 예를 들어, 상단 지점이 녹색이고 하단 지점이 파란색인 선이 있다고 가정해봅시다. 만약 프래그먼트 셰이더가 해당 선의 70% 위치에 있는 프래그먼트에서 실행된다면, 결과적으로 해당 프래그먼트의 색상 입력 속성은 녹색과 파란색의 선형 조합이 될 것입니다. 더 정확하게 말하면, 30%는 파란색이고 70%는 녹색입니다.

이것이 바로 삼각형에서 발생한 일입니다. 우리는 3개의 정점과 따라서 3가지 색상을 가지고 있으며, 삼각형의 픽셀들을 보면 약 50000개의 프래그먼트가 포함되어 있는 것으로 보입니다. 프래그먼트 셰이더는 이러한 픽셀들 사이에서 색상을 보간(interpolate)합니다. 색상을 자세히 살펴보면 모든 것이 의미를 가지는 것을 알 수 있습니다: 빨간색에서 파란색으로 이어지면서 먼저 보라색이 되고 그 다음에 파란색이 됩니다. 프래그먼트 보간은 프래그먼트 셰이더의 모든 입력 속성에 적용됩니다.
<br><br>


## Our own shader class

쉐이더를 작성, 컴파일 및 관리하는 것은 꽤 귀찮은 일일 수 있습니다. 셰이더 주제에 대한 마지막 접근법으로, 우리는 셰이더 클래스를 만들어서 우리의 일을 조금 더 쉽게 할 것입니다. 이 클래스는 디스크에서 셰이더를 읽고, 컴파일 및 링크하며, 오류를 확인하고 사용하기 쉽도록 만들어질 것입니다. 또한 이를 통해 지금까지 배운 지식을 유용한 추상 객체로 캡슐화하는 방법에 대한 아이디어를 얻을 수 있습니다.

우리는 헤더 파일에서 전적으로 셰이더 클래스를 만들 것이며, 주로 학습 목적과 이식성을 위해 그렇게 합니다. 먼저 필요한 헤더 파일을 추가하고, 클래스 구조를 정의하는 것으로 시작해봅시다.

```
#ifndef SHADER_H
#define SHADER_H

#include <glad/glad.h> // include glad to get all the required OpenGL headers
  
#include <string>
#include <fstream>
#include <sstream>
#include <iostream>
  

class Shader
{
public:
    // the program ID
    unsigned int ID;
  
    // constructor reads and builds the shader
    Shader(const char* vertexPath, const char* fragmentPath);
    // use/activate the shader
    void use();
    // utility uniform functions
    void setBool(const std::string &name, bool value) const;  
    void setInt(const std::string &name, int value) const;   
    void setFloat(const std::string &name, float value) const;
};
  
#endif
```

> 헤더 파일 상단에 여러 전처리기 지시문을 사용했습니다. 이 작은 코드 라인을 사용하여 컴파일러에게 이 헤더 파일이 아직 포함되지 않았을 경우에만 포함하고 컴파일하도록 지시합니다. 심지어 여러 파일이 셰이더 헤더를 포함하더라도 말이죠. 이렇게 하면 링크 충돌을 방지할 수 있습니다.

쉐이더 클래스는 쉐이더 프로그램의 ID를 보유합니다. 생성자는 각각 정점 셰이더와 프래그먼트 셰이더의 소스 코드 파일 경로를 요구하며, 이는 간단한 텍스트 파일로 디스크에 저장할 수 있습니다. 약간의 추가 기능으로 use 함수는 쉐이더 프로그램을 활성화하고, set... 함수들은 유니폼 위치를 조회하고 값을 설정하는 데 도움을 주는 여러 유틸리티 함수들을 추가했습니다.
<br><br>


## Reading from file

우리는 C++ 파일 스트림을 사용하여 파일의 내용을 여러 문자열 객체로 읽어들입니다.

```
Shader(const char* vertexPath, const char* fragmentPath)
{
    // 1. retrieve the vertex/fragment source code from filePath
    std::string vertexCode;
    std::string fragmentCode;
    std::ifstream vShaderFile;
    std::ifstream fShaderFile;
    // ensure ifstream objects can throw exceptions:
    vShaderFile.exceptions (std::ifstream::failbit | std::ifstream::badbit);
    fShaderFile.exceptions (std::ifstream::failbit | std::ifstream::badbit);
    try 
    {
        // open files
        vShaderFile.open(vertexPath);
        fShaderFile.open(fragmentPath);
        std::stringstream vShaderStream, fShaderStream;
        // read file's buffer contents into streams
        vShaderStream << vShaderFile.rdbuf();
        fShaderStream << fShaderFile.rdbuf();		
        // close file handlers
        vShaderFile.close();
        fShaderFile.close();
        // convert stream into string
        vertexCode   = vShaderStream.str();
        fragmentCode = fShaderStream.str();		
    }
    catch(std::ifstream::failure e)
    {
        std::cout << "ERROR::SHADER::FILE_NOT_SUCCESFULLY_READ" << std::endl;
    }
    const char* vShaderCode = vertexCode.c_str();
    const char* fShaderCode = fragmentCode.c_str();
    [...]
```

다음으로는 셰이더를 컴파일하고 링크해야 합니다. 컴파일/링크가 실패한 경우 컴파일 시간 오류를 출력하는 부분을 확인하는 것도 중요합니다. 디버깅할 때 이러한 오류 로그가 굉장히 유용합니다 (언젠가는 이 오류 로그가 필요할 것입니다).

```
// 2. compile shaders
unsigned int vertex, fragment;
int success;
char infoLog[512];
   
// vertex Shader
vertex = glCreateShader(GL_VERTEX_SHADER);
glShaderSource(vertex, 1, &vShaderCode, NULL);
glCompileShader(vertex);
// print compile errors if any
glGetShaderiv(vertex, GL_COMPILE_STATUS, &success);
if(!success)
{
    glGetShaderInfoLog(vertex, 512, NULL, infoLog);
    std::cout << "ERROR::SHADER::VERTEX::COMPILATION_FAILED\n" << infoLog << std::endl;
};
  
// similiar for Fragment Shader
[...]
  
// shader Program
ID = glCreateProgram();
glAttachShader(ID, vertex);
glAttachShader(ID, fragment);
glLinkProgram(ID);
// print linking errors if any
glGetProgramiv(ID, GL_LINK_STATUS, &success);
if(!success)
{
    glGetProgramInfoLog(ID, 512, NULL, infoLog);
    std::cout << "ERROR::SHADER::PROGRAM::LINKING_FAILED\n" << infoLog << std::endl;
}
  
// delete the shaders as they're linked into our program now and no longer necessary
glDeleteShader(vertex);
glDeleteShader(fragment);
```

use 함수는 간단합니다:

```
void use() 
{ 
    glUseProgram(ID);
}  
```

동일한 방식으로 모든 uniform 설정 함수도 동작합니다:

```
void setBool(const std::string &name, bool value) const
{         
    glUniform1i(glGetUniformLocation(ID, name.c_str()), (int)value); 
}
void setInt(const std::string &name, int value) const
{ 
    glUniform1i(glGetUniformLocation(ID, name.c_str()), value); 
}
void setFloat(const std::string &name, float value) const
{ 
    glUniform1f(glGetUniformLocation(ID, name.c_str()), value); 
} 
```

여기에 완성된 셰이더 클래스가 있습니다. 셰이더 클래스를 사용하는 것은 매우 쉽습니다. 한 번 셰이더 객체를 생성한 후에는 그저 사용하기만 하면 됩니다.

```
Shader ourShader("path/to/shaders/shader.vs", "path/to/shaders/shader.fs");
[...]
while(...)
{
    ourShader.use();
    ourShader.setFloat("someUniform", 1.0f);
    DrawStuff();
}
```

여기서는 vertex 셰이더와 fragment 셰이더 소스 코드를 shader.vs와 shader.fs라는 두 개의 파일에 저장했습니다. 원하는 대로 셰이더 파일의 이름을 지정할 수 있습니다. 저는 개인적으로 .vs와 .fs 확장자를 상당히 직관적으로 생각합니다.

새로 만든 [셰이더 클래스](../../02.GettingStarted/05.Shaders.04/Shader.h)를 사용하여 소스 코드를 [여기](../../02.GettingStarted/05.Shaders.04/main.cpp)에서 찾을 수 있습니다. 셰이더 파일 경로를 클릭하여 셰이더의 소스 코드를 확인할 수 있습니다.