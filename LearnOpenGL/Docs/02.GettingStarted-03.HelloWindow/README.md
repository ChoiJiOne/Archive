# [Getting Started : Hello Window](https://learnopengl.com/Getting-started/Hello-Window)

GLFW를 실행시켜보겠습니다. 먼저, .cpp 파일을 생성하고 새로 생성한 파일의 맨 위에 다음과 같은 인클루드(Include)를 추가해주세요.

```
#include <glad/glad.h>
#include <GLFW/glfw3.h>
```

> GLFW 이전에 GLAD를 인클루드(Include)해야 합니다. GLAD의 인클루드 파일에는 OpenGL 헤더(GL/gl.h와 같은)가 필요한 경우 자동으로 포함되므로 OpenGL이 필요한 다른 헤더 파일(예: GLFW)보다 GLAD를 먼저 인클루드해야 합니다.

다음으로, GLFW 창을 인스턴스화할 main 함수를 생성합니다:

```
int main()
{
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    //glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
  
    return 0;
}
```

main 함수에서는 먼저 glfwInit을 사용하여 GLFW를 초기화합니다. 그 후에는 glfwWindowHint를 사용하여 GLFW를 구성할 수 있습니다. glfwWindowHint의 첫 번째 인자는 구성하려는 옵션을 나타내는데, 이 옵션은 GLFW_로 시작하는 다양한 옵션의 열거형에서 선택할 수 있습니다. 두 번째 인자는 옵션의 값을 설정하는 정수입니다. 모든 가능한 옵션과 해당 값에 대한 목록은 GLFW의 창 처리 문서에서 확인할 수 있습니다. 지금 애플리케이션을 실행하려고 하면 정의되지 않은 참조 오류가 많이 발생하는데, 이는 GLFW 라이브러리를 성공적으로 링크하지 못한 것을 의미합니다.


이 책의 초점은 OpenGL 버전 3.3에 있으므로 GLFW에게 3.3을 사용할 OpenGL 버전으로 설정하고자 합니다. 이렇게 함으로써 GLFW가 OpenGL 컨텍스트를 생성할 때 적절한 조치를 취할 수 있습니다. 이렇게 함으로써 사용자가 적절한 OpenGL 버전을 갖지 않은 경우 GLFW가 실행되지 않도록 보장할 수 있습니다. 주 버전과 부 버전을 모두 3으로 설정합니다. 또한 GLFW에게 명시적으로 코어 프로파일을 사용하고자 한다고 알려줍니다. GLFW에게 코어 프로파일을 사용하려고 한다고 알리면 더 이상 필요하지 않은 하위 호환 기능 없이 작은 OpenGL 기능 하위 집합에 액세스할 수 있습니다. Mac OS X에서는 작동하도록 초기화 코드에 `glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);`를 추가해야 함을 참고하세요.


> 시스템/하드웨어에 OpenGL 버전 3.3 이상이 설치되어 있는지 확인하세요. 그렇지 않으면 응용 프로그램이 충돌하거나 정의되지 않은 동작이 발생할 수 있습니다. OpenGL 버전을 확인하려면 Linux 기반 시스템에서는 glxinfo를 호출하거나 Windows에서는 OpenGL Extension Viewer와 같은 유틸리티를 사용하세요. 지원되는 버전이 낮은 경우 비디오 카드가 OpenGL 3.3+를 지원하는지 확인하고(그렇지 않으면 매우 오래된 카드일 수 있음) 드라이버를 업데이트해 보세요.


다음으로, 창 객체를 생성해야 합니다. 이 창 객체는 모든 창 관련 데이터를 보유하며, GLFW의 대부분의 다른 함수에서 필요합니다.

```
GLFWwindow* window = glfwCreateWindow(800, 600, "LearnOpenGL", NULL, NULL);
if (window == NULL)
{
    std::cout << "Failed to create GLFW window" << std::endl;
    glfwTerminate();
    return -1;
}
glfwMakeContextCurrent(window);
```

glfwCreateWindow 함수는 첫 번째 인자로 창의 너비(width)와 두 번째 인자로 창의 높이(height)를 필요로 합니다. 세 번째 인자는 창의 이름을 지정할 수 있는데, 현재는 "LearnOpenGL"이라고 이름을 지정하고 있지만, 원하는 대로 이름을 지정할 수 있습니다. 마지막 두 개의 매개변수는 무시할 수 있습니다. 이 함수는 우리가 나중에 다른 GLFW 작업에 필요한 GLFWwindow 객체를 반환합니다. 그 후에 우리는 GLFW에게 현재 스레드에서 우리 창의 컨텍스트를 메인 컨텍스트로 만들도록 지시합니다.
<br><br>


## GLAD

이전 장에서 OpenGL의 함수 포인터를 관리하는 GLAD를 언급했으므로, 어떤 OpenGL 함수를 호출하기 전에 GLAD를 초기화하고자 합니다.

```
if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
{
    std::cout << "Failed to initialize GLAD" << std::endl;
    return -1;
}    
```

GLAD에게 OpenGL 함수 포인터의 주소를 로드하는 함수를 전달해야 하는데, 이 함수는 운영체제에 따라 다릅니다. GLFW는 우리가 컴파일하는 운영체제에 따라 올바른 함수를 정의하는 glfwGetProcAddress를 제공합니다.
<br><br>


## Viewport

렌더링을 시작하기 전에 마지막으로 해야 할 작업이 있습니다. OpenGL에게 렌더링 창의 크기를 알려줘야 합니다. 이렇게 하면 OpenGL이 데이터와 좌표를 창에 대해 어떻게 표시해야 하는지 알 수 있습니다. glViewport 함수를 사용하여 해당 창의 크기를 설정할 수 있습니다.

```
glViewport(0, 0, 800, 600);
```

glViewport의 첫 번째 두 매개변수는 창의 왼쪽 하단 모서리의 위치를 설정합니다. 세 번째와 네 번째 매개변수는 픽셀 단위로 렌더링 창의 너비와 높이를 설정하는데, 이 값을 GLFW의 창 크기와 같도록 설정합니다.


실제로 GLFW의 크기보다 작은 값을 사용하여 뷰포트의 크기를 설정할 수도 있습니다. 그러면 모든 OpenGL 렌더링이 작은 창에 표시되고, OpenGL 뷰포트 외부에 다른 요소를 표시할 수도 있습니다.


> OpenGL은 glViewport를 통해 지정된 데이터를 사용하여 처리한 2D 좌표를 화면상의 좌표로 변환합니다. 예를 들어, (-0.5, 0.5) 위치의 처리된 점은 (최종 변환으로) 화면 좌표인 (200, 450)에 매핑됩니다. OpenGL의 처리된 좌표는 -1과 1 사이에 있으므로 우리는 사실상 범위 (-1에서 1)를 (0, 800) 및 (0, 600)으로 매핑합니다.


그러나 사용자가 창 크기를 조정할 때마다 뷰포트도 조정되어야 합니다. 창에서 호출될 콜백 함수를 등록할 수 있습니다. 이 콜백 함수는 창의 크기가 조정될 때마다 호출됩니다. 이 리사이즈 콜백 함수는 다음과 같은 프로토타입을 가지고 있습니다:

```
void framebuffer_size_callback(GLFWwindow* window, int width, int height);
```

프레임버퍼 크기 함수는 GLFWwindow를 첫 번째 인자로 받고, 새로운 창의 크기를 나타내는 두 개의 정수를 받습니다. 창의 크기가 변경될 때마다 GLFW가 이 함수를 호출하고 적절한 인수를 제공하여 처리할 수 있도록 합니다.


```
void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
    glViewport(0, 0, width, height);
}  
```

우리는 이 함수를 모든 창 크기 조정에 호출하길 원하기 때문에, GLFW에 이 함수를 등록하여 알려줘야 합니다.

```
glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);  
```

창이 처음에 표시될 때도 framebuffer_size_callback이 호출되며, 결과적으로 창의 크기가 전달됩니다. 레티나 디스플레이에서는 너비와 높이가 원래 입력 값보다 상당히 높게 나타날 수 있습니다.


우리는 많은 콜백 함수를 등록하여 자체 함수를 설정할 수 있습니다. 예를 들어, 조이스틱 입력 변경을 처리하는 콜백 함수나 오류 메시지를 처리하는 콜백 함수 등을 만들 수 있습니다. 창을 생성한 후에 렌더 루프가 시작되기 전에 콜백 함수를 등록합니다.
<br><br>


## Ready your engines

우리는 응용 프로그램이 한 번의 이미지를 그리고 즉시 종료하여 창을 닫는 것이 아니라, 프로그램이 명시적으로 중지될 때까지 계속해서 이미지를 그리고 사용자 입력을 처리하도록 원합니다. 이를 위해 우리는 더 이상 루프를 생성해야 하며, 이제 이를 렌더 루프라고 합니다. GLFW에 중지하도록 알리기 전까지 계속 실행됩니다. 다음 코드는 매우 간단한 렌더 루프를 보여줍니다:

```
while(!glfwWindowShouldClose(window))
{
    glfwSwapBuffers(window);
    glfwPollEvents();    
}
```


glfwWindowShouldClose 함수는 각 루프 반복의 시작에서 GLFW가 닫히도록 지시되었는지 확인합니다. 만약 그렇다면 함수는 true를 반환하고 렌더 루프가 실행을 중지하며, 그 후에 우리는 응용 프로그램을 종료할 수 있습니다.


glfwPollEvents 함수는 키보드 입력이나 마우스 이동 등과 같은 이벤트가 발생했는지 확인하고, 창 상태를 업데이트하며, 해당하는 함수를 호출합니다(우리는 이를 콜백 메서드를 통해 등록할 수 있습니다). glfwSwapBuffers 함수는 이 렌더링 반복 중에 사용되는 색상 버퍼(각 픽셀의 색상 값을 포함하는 큰 2D 버퍼)를 교체하고, 그것을 화면에 출력합니다.


> Double buffer  
단일 버퍼로 그린 경우 결과 이미지는 깜빡임 문제가 발생할 수 있습니다. 이는 결과 출력 이미지가 즉시 그려지는 것이 아니라 픽셀 단위로 그려지며 일반적으로 왼쪽에서 오른쪽, 위에서 아래로 그려지기 때문입니다. 이 이미지는 렌더링되는 동안에도 사용자에게 즉시 표시되지 않기 때문에 결과에는 아티팩트가 포함될 수 있습니다. 이러한 문제를 해결하기 위해 창 애플리케이션은 렌더링을 위해 이중 버퍼를 적용합니다. 프론트 버퍼에는 화면에 표시되는 최종 출력 이미지가 포함되어 있으며, 모든 렌더링 명령은 백 버퍼에 그려집니다. 모든 렌더링 명령이 완료되면 백 버퍼를 프론트 버퍼로 교체하여 이미지가 아티팩트 없이 표시될 수 있도록 합니다.
<bre><br>


## One last thing

렌더 루프를 종료한 후에는 할당된 모든 GLFW 자원을 적절하게 정리하거나 삭제하길 원합니다. 이를 위해 main 함수의 끝에서 호출하는 glfwTerminate 함수를 사용할 수 있습니다.


```
glfwTerminate();
return 0;
```


이렇게 하면 모든 자원이 정리되고 응용 프로그램이 올바르게 종료됩니다. 이제 응용 프로그램을 컴파일해 보세요. 모든 것이 잘 진행된다면 다음과 같은 출력이 표시됩니다.

![](2023-05-19-09-55-28.png)


만약 매우 지루하고 단조로운 검은 이미지가 나왔다면, 올바르게 작업한 것입니다! 만약 올바른 이미지가 나오지 않았거나 모든 것이 어떻게 연결되는지 헷갈린다면, 여기에서 [전체 소스 코드](../../02.GettingStarted/03.HelloWindow.01/main.cpp)를 확인하세요. (만약 다른 색상으로 번갈아 가며 깜빡이기 시작했다면 계속 읽어보세요.)


응용 프로그램을 컴파일하는 데 문제가 있다면, 먼저 링커 옵션이 올바르게 설정되었는지 확인하고 IDE에서 올바른 디렉토리를 제대로 포함했는지(이전 장에서 설명한 대로) 확인하세요. 또한 코드가 올바른지 확인하세요. 전체 소스 코드와 비교하여 확인할 수 있습니다.
<br><br>


## Input

우리는 GLFW에서 입력 제어의 형태를 가져야 하며, 이를 위해 여러 GLFW의 입력 함수를 사용할 수 있습니다. 우리는 GLFW의 glfwGetKey 함수를 사용할 것이며, 이 함수는 창과 키를 입력으로 받습니다. 이 함수는 해당 키가 현재 눌려 있는지 여부를 반환합니다. 우리는 모든 입력 코드를 정리하기 위해 processInput 함수를 생성합니다.

```
void processInput(GLFWwindow *window)
{
    if(glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
        glfwSetWindowShouldClose(window, true);
}
```

여기서는 사용자가 ESC 키를 눌렀는지 확인합니다 (눌리지 않으면 glfwGetKey는 GLFW_RELEASE를 반환합니다). 사용자가 ESC 키를 눌렀다면, glfwSetWindowShouldClose를 사용하여 GLFW의 WindowShouldClose 속성을 true로 설정하여 GLFW를 종료합니다. 그런 다음 main while 루프의 다음 조건 확인은 실패하고 응용 프로그램이 종료됩니다.


그런 다음 render 루프의 각 반복에서 processInput을 호출합니다.


```
while (!glfwWindowShouldClose(window))
{
    processInput(window);

    glfwSwapBuffers(window);
    glfwPollEvents();
}  
```

이를 통해 우리는 특정 키를 누르고 해당 프레임에 따라 적절히 반응하는 간단한 방법을 얻을 수 있습니다. render 루프의 한 번의 반복을 일반적으로 프레임이라고 합니다.
<br><br>


## Rendering

우리는 모든 렌더링 명령을 렌더 루프에 넣고자 합니다. 렌더 루프의 각 반복 또는 프레임마다 모든 렌더링 명령을 실행하고자 합니다. 다음과 같은 형태가 될 것입니다.

```
// render loop
while(!glfwWindowShouldClose(window))
{
    // input
    processInput(window);

    // rendering commands here
    ...

    // check and call events and swap the buffers
    glfwPollEvents();
    glfwSwapBuffers(window);
}
```

실제로 작동하는지 확인하기 위해 선택한 색상으로 화면을 지우려고 합니다. 프레임의 시작에서 화면을 지우고자 합니다. 그렇지 않으면 이전 프레임의 결과를 계속해서 볼 수 있습니다 (이것이 원하는 효과일 수도 있지만, 보통은 그렇지 않습니다). 우리는 glClear를 사용하여 화면의 컬러 버퍼를 지울 수 있습니다. 이때 어떤 버퍼를 지울지 지정하기 위해 버퍼 비트를 전달합니다. 설정할 수 있는 비트는 GL_COLOR_BUFFER_BIT, GL_DEPTH_BUFFER_BIT 및 GL_STENCIL_BUFFER_BIT입니다. 현재 우리는 색상 값만 신경쓰므로 컬러 버퍼만 지우기로 합니다.


```
glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
glClear(GL_COLOR_BUFFER_BIT);
```

참고로, glClearColor를 사용하여 화면을 지울 때 지정한 색상을 설정합니다. glClear를 호출하여 컬러 버퍼를 지우면 glClearColor로 설정된 색상으로 전체 컬러 버퍼가 채워집니다. 이는 어두운 초록-파란색의 색상으로 나타납니다.


> OpenGL에서 배운 바와 같이, glClearColor 함수는 상태 설정 함수이고 glClear는 상태 사용 함수입니다. 즉, glClear는 현재 상태를 사용하여 지우기 색상을 가져옵니다.

![](2023-05-19-09-59-24.png)


응용 프로그램의 전체 소스 코드는 [여기](../../02.GettingStarted/03.HelloWindow.02/main.cpp)에서 찾을 수 있습니다.


그래서 지금은 렌더 루프에 많은 렌더링 호출로 채울 준비가 되었습니다. 하지만 그것은 다음 장에서 다룰 내용입니다. 여기서 충분히 말을 했네요.