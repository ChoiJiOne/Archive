# [Game Programming Patterns - Singleton](https://gameprogrammingpatterns.com/singleton.html)

이 문서는 `Game Programming Patterns`의 `Singleton`을 번역한 문서입니다.
<br><br>


## Singleton

이 장은 이상한 점이 있습니다. 이 책의 다른 장들은 디자인 패턴을 사용하는 방법을 보여줍니다. 하지만 이 장은 어떤 디자인 패턴을 사용하지 말아야 하는지를 보여줍니다.

Gang of Four에서 설명한 Singleton 패턴은 고귀한 의도를 가지고 있지만, 보통 좋은 대신에 더 큰 해로움을 가져옵니다. 그들은 이 패턴이 절제해서 사용되어야 한다고 강조하지만, 이 메시지는 게임 산업으로 전달될 때 종종 잊혀집니다.

어떤 패턴이든지, Singleton을 적절하지 않은 곳에 사용하는 것은 고리타분한 것과 같습니다. 너무 많이 사용되기 때문에, 이 장의 대부분은 싱글톤을 피하는 방법에 대한 것이지만, 먼저 패턴 자체에 대해 알아보겠습니다.
<br><br>


## The Singleton Pattern 

디자인 패턴에서 싱글톤을 다음과 같이 요약합니다:

> 클래스가 하나의 인스턴스만 가지도록 보장하고, 이에 대한 전역적인 접근 지점을 제공합니다.

우리는 "and"를 기준으로 나누고 각각을 개별적으로 고려할 것입니다.


### 클래스를 하나의 인스턴스로 제한하기

하나 이상의 인스턴스가 있는 경우에는 클래스가 올바르게 작동하지 못할 수 있는 경우가 있습니다. 일반적인 경우는 클래스가 자체적으로 전역 상태를 유지하는 외부 시스템과 상호 작용하는 경우입니다.

예를 들어, 기본 파일 시스템 API를 래핑하는 클래스를 고려해보겠습니다. 파일 작업은 완료되기까지 시간이 걸릴 수 있으므로, 이 클래스는 비동기적으로 작업을 수행합니다. 이는 여러 작업이 동시에 실행될 수 있기 때문에 서로 조율되어야 합니다. 파일을 생성하기 위해 하나의 호출을 시작하고, 동시에 같은 파일을 삭제하기 위해 또 다른 호출을 시작한다면, 래퍼는 두 작업이 서로 간섭하지 않도록 주의해야 합니다.

이를 위해 우리의 래퍼로의 호출은 이전의 모든 작업에 접근할 수 있어야 합니다. 사용자들이 우리의 클래스의 인스턴스를 자유롭게 생성할 수 있다면, 한 인스턴스는 다른 인스턴스가 시작한 작업에 대해 알 방법이 없을 것입니다. 여기에 싱글톤이 등장합니다. 싱글톤은 클래스가 컴파일 시간에 해당 클래스의 단일 인스턴스만 존재함을 보장하는 방법을 제공합니다.

### 전역 접근 지점 제공하기

게임 내에서 여러 다른 시스템은 우리의 파일 시스템 래퍼를 사용할 것입니다. 로깅, 콘텐츠 로딩, 게임 상태 저장 등이 그 예입니다. 이러한 시스템이 자체적으로 파일 시스템 래퍼의 인스턴스를 생성할 수 없다면, 어떻게 그것을 얻을 수 있을까요?

싱글톤은 이에 대한 해결책을 제공합니다. 단일 인스턴스를 생성하는 것 외에도, 이를 얻을 수 있는 전역적으로 사용 가능한 메서드도 제공합니다. 이렇게 하면 어디에서든 누구나 우리의 축복받은 인스턴스를 얻을 수 있습니다. 전통적인 구현은 다음과 같습니다:

```
class FileSystem
{
public:
  static FileSystem& instance()
  {
    // Lazy initialize.
    if (instance_ == NULL) instance_ = new FileSystem();
    return *instance_;
  }

private:
  FileSystem() {}

  static FileSystem* instance_;
};
```

정적인 instance_ 멤버는 클래스의 인스턴스를 보유하며, 비공개 생성자는 그것이 유일한 인스턴스임을 보장합니다. public static instance() 메서드는 코드베이스 어디에서든 인스턴스에 접근할 수 있도록 합니다. 또한, 이 메서드는 누군가 인스턴스를 요청할 때 처음으로 싱글톤 인스턴스를 지연 생성하는 역할도 담당합니다.

현대적인 방식은 다음과 같습니다:

```
class FileSystem
{
public:
  static FileSystem& instance()
  {
    static FileSystem *instance = new FileSystem();
    return *instance;
  }

private:
  FileSystem() {}
};
```

C++11은 지역 정적 변수의 초기화자가 동시성이 존재할 경우에도 한 번만 실행되도록 규정합니다. 따라서, 현대적인 C++ 컴파일러를 가정한다면, 이 코드는 첫 번째 예제와는 달리 스레드 안전합니다.
<br><br>


## Why We Use It

우리의 파일 시스템 래퍼는 필요한 곳 어디에서나 사용할 수 있어서 매번 인스턴스를 전달해야 하는 번거로움이 없습니다. 이 클래스 자체가 몇 개의 인스턴스를 생성하여 문제를 일으키지 않도록 잘 관리합니다. 그 외에도 몇 가지 좋은 특징이 있습니다:

- 사용자가 없을 경우 인스턴스를 생성하지 않습니다. 메모리와 CPU 사이클을 절약하는 것은 항상 좋은 일입니다. 싱글톤은 처음 접근될 때만 초기화되므로, 게임이 싱글톤을 요청하지 않는다면 전혀 인스턴스화되지 않습니다.
- 런타임에 초기화됩니다. 싱글톤에 대한 일반적인 대안은 정적 멤버 변수를 가진 클래스입니다. 저는 간단한 해결책을 선호하기 때문에 가능한 경우 싱글톤 대신 정적 클래스를 사용하지만, 정적 멤버의 한 가지 제약 사항이 있습니다: 자동 초기화입니다. 컴파일러는 main()이 호출되기 전에 정적 멤버를 초기화합니다. 이는 프로그램이 실행 중인 동안만 알 수 있는 정보 (예: 파일에서 로드된 설정)를 사용할 수 없다는 것을 의미합니다. 또한, 정적 멤버는 서로 신뢰할 수 없습니다 - 컴파일러는 정적 멤버의 초기화 순서를 상호 간에 보장하지 않습니다. 

    게으른 초기화는 이 두 가지 문제를 해결합니다. 싱글톤은 가능한 늦은 시기에 초기화되므로 그 때까지 필요한 모든 정보가 제공될 것입니다. 서로 순환 종속성이 없다면, 한 싱글톤은 자체를 초기화할 때 다른 싱글톤을 참조할 수도 있습니다.
- 싱글톤을 서브클래스화할 수 있습니다. 이는 강력하지만 종종 간과되는 기능입니다. 예를 들어, 파일 시스템 래퍼를 크로스 플랫폼으로 만들어야 할 경우가 있다고 가정해봅시다. 이를 위해 파일 시스템의 추상 인터페이스로 작동하며, 각 플랫폼에 대한 인터페이스를 구현한 서브클래스로 구성되도록 원합니다. 다음은 기본 클래스입니다:
    ```
    class FileSystem
    {
    public:
    virtual ~FileSystem() {}
    virtual char* readFile(char* path) = 0;
    virtual void  writeFile(char* path, char* contents) = 0;
    };
    ```
    그런 다음 몇 가지 플랫폼에 대한 파생 클래스를 정의합니다:
    ```
    class PS3FileSystem : public FileSystem
    {
    public:
    virtual char* readFile(char* path)
    { 
        // Use Sony file IO API...
    }

    virtual void writeFile(char* path, char* contents)
    {
        // Use sony file IO API...
    }
    };

    class WiiFileSystem : public FileSystem
    {
    public:
    virtual char* readFile(char* path)
    { 
        // Use Nintendo file IO API...
    }

    virtual void writeFile(char* path, char* contents)
    {
        // Use Nintendo file IO API...
    }
    };
    ```
    다음으로, FileSystem을 싱글톤으로 바꿉니다:
    ```
    class FileSystem
    {
    public:
    static FileSystem& instance();

    virtual ~FileSystem() {}
    virtual char* readFile(char* path) = 0;
    virtual void  writeFile(char* path, char* contents) = 0;

    protected:
    FileSystem() {}
    };
    ```
    가장 재미있는 부분은 인스턴스가 생성되는 방식입니다:
    ```
    FileSystem& FileSystem::instance()
    {
    #if PLATFORM == PLAYSTATION3
        static FileSystem *instance = new PS3FileSystem();
    #elif PLATFORM == WII
        static FileSystem *instance = new WiiFileSystem();
    #endif

    return *instance;
    }
    ```

간단한 컴파일러 스위치로 파일 시스템 래퍼를 적절한 구체 타입에 바인딩합니다. 우리의 전체 코드베이스는 FileSystem::instance()를 사용하여 파일 시스템에 접근할 수 있지만, 특정 플랫폼 코드에 결합되지 않습니다. 이러한 결합은 대신 FileSystem 클래스의 구현 파일 안에 캡슐화됩니다.

이렇게 하면 대부분의 사람들이 이런 문제를 해결할 때까지 진행됩니다. 우리는 파일 시스템 래퍼를 갖고 있습니다. 신뢰할 수 있게 작동합니다. 필요한 모든 곳에서 이를 얻을 수 있도록 전역적으로 사용 가능합니다. 이제 코드를 체크인하고 맛있는 음료수와 함께 축하할 시간입니다.
<br><br>


## 사용해서 후회하는 이유

짧은 기간 동안에는 싱글톤 패턴은 비교적 무해합니다. 많은 설계 선택과 마찬가지로, 오랜 기간에 걸쳐 비용을 지불하게 됩니다. 몇 가지 불필요한 싱글톤을 단단한 코드로 캐스트한 후에는 다음과 같은 문제가 발생합니다:

### 전역 변수입니다

게임이 아직 창고에서 몇 명의 개발자가 작성하는 시절에는 하드웨어를 밀어 올리는 것이 상위 소프트웨어 공학 원칙보다 중요했습니다. 고전적인 C 및 어셈블리 코더들은 전역 변수와 정적 변수를 어려움 없이 사용하고 좋은 게임을 출시했습니다. 게임이 점점 커지고 복잡해지면서, 아키텍처와 유지보수성이 병목 현상이 되기 시작했습니다. 우리는 하드웨어 제약 때문이 아니라 생산성 제약 때문에 게임을 출시하는 데 어려움을 겪었습니다.

그래서 우리는 C++과 같은 언어로 전환하고 소프트웨어 엔지니어 선조들의 고생 끝에 얻은 지혜 중 일부를 적용하기 시작했습니다. 우리가 배운 교훈 중 하나는 다양한 이유로 전역 변수는 좋지 않다는 것입니다:

- 코드를 이해하기 어렵게 만듭니다. 다른 사람이 작성한 함수에서 버그를 찾고 있다고 가정해 봅시다. 그 함수가 전역 상태에 영향을 주지 않는다면, 함수의 내용과 인수들을 이해함으로써 그 함수를 파악할 수 있습니다. 

    이제 그 함수의 중간에 SomeClass::getSomeGlobalData()를 호출하는 부분이 있다고 상상해 보세요. 무슨 일이 벌어지고 있는지 파악하려면 전역 데이터에 접근하는 부분을 찾기 위해 전체 코드베이스를 살펴봐야 합니다. 전역 상태에 대한 진정한 혐오감은 새벽 세 시에 잘못된 값을 설정하는 잘못된 호출을 찾기 위해 백만 줄의 코드를 grep해야 할 때에야 실감됩니다.
- 전역 변수는 결합을 장려합니다. 팀의 새로운 개발자는 게임의 아름답게 유지 가능한 느슨하게 결합된 아키텍처에 익숙하지 않지만, 그에게 첫 번째 작업이 주어졌습니다: 바위가 땅에 충돌할 때 소리가 나도록 만들기. 우리는 물리학 코드가 오디오와 결합되어서는 안 된다는 것을 알고 있지만, 그는 그저 자신의 작업을 완료하려고 노력하고 있습니다. 우리에게 불행히도, AudioPlayer의 인스턴스는 전역적으로 보이게 되어 있습니다. 그래서 #include 한 줄로, 새로운 개발자가 신중히 구축된 아키텍처를 손상시킬 수 있습니다. 

    오디오 플레이어의 전역 인스턴스가 없다면, 헤더를 #include 하더라도 여전히 인스턴스를 사용할 수 없습니다. 이 어려움은 그에게 두 모듈이 서로에 대해 알지 말아야 하며, 다른 방법으로 문제를 해결해야 한다는 명확한 메시지를 보냅니다. 인스턴스에 대한 접근을 제어함으로써 결합을 제어할 수 있습니다.
- 싱글톤은 동시성에 친숙하지 않습니다. 단일 코어 CPU에서 실행되는 게임의 시대는 거의 끝났습니다. 현재의 코드는 최소한 멀티스레딩 방식으로 작동해야 합니다. 동시성을 완전히 활용하지 않더라도요. 우리가 무언가를 전역으로 만들면, 우리는 모든 스레드가 볼 수 있고 건드릴 수 있는 메모리 조각을 만든 것입니다. 다른 스레드가 그것에 대해 무슨 작업을 수행하는지 여부에 상관없이요. 이러한 경로는 교착상태, 경쟁 조건 및 기타 스레드 동기화 버그로 이어집니다.

이러한 문제들 때문에 전역 변수 선언과 싱글톤 패턴을 피하게 되지만, 이는 여전히 어떻게 게임을 설계해야 하는지에 대한 답을 제공해주지는 않습니다. 전역 상태 없이 게임을 설계하는 방법은 무엇일까요?

이에 대한 포괄적인 답변들이 있지만 (이 책의 대부분은 그 질문에 대한 답변이기도 합니다), 그들은 명백하거나 쉽게 얻을 수 있는 것은 아닙니다. 그 동안에는 게임을 완성해야 합니다. 싱글톤 패턴은 마치 만병통치약처럼 보입니다. 객체지향 디자인 패턴의 책에 나와 있으니, 아키텍처적으로 옳다고 할 수 있지 않을까요? 그리고 이렇게 하면 여러 해 동안 소프트웨어를 설계할 수 있습니다.

불행히도, 싱글톤 패턴은 위약보다는 치료효과가 더 큽니다. 전역 변수가 일으키는 문제 목록을 살펴보면, 싱글톤 패턴이 그 어느 것도 해결하지 않는다는 것을 알 수 있습니다. 왜냐하면 싱글톤은 전역 상태이기 때문입니다 - 그저 클래스 안에 캡슐화된 전역 상태일 뿐입니다.

### 한 가지 문제가 있을 때에도 두 가지 문제를 해결합니다.

Gang of Four의 싱글톤 설명에서 "and"라는 단어는 조금 이상합니다. 이 패턴은 한 가지 문제를 해결하는 것인가요, 아니면 두 가지 문제를 해결하는 것인가요? 그 중 하나만 있다면 어떻게 될까요? 하나의 인스턴스를 보장하는 것은 유용하지만, 누구나 그것을 건드릴 수 있게 해야 하는 것은 아닙니다. 마찬가지로, 전역적인 접근은 편리하지만, 여러 인스턴스를 허용하는 클래스에도 그렇습니다.

위의 두 가지 문제 중에서 편리한 접근성은 거의 항상 우리가 싱글톤 패턴을 선택하는 이유입니다. 로깅 클래스를 생각해보세요. 게임의 대부분의 모듈은 진단 정보를 기록할 수 있는 기능이 유용합니다. 그러나 모든 함수에 Log 클래스의 인스턴스를 전달하는 것은 메소드 시그니처를 혼잡하게 만들고 코드의 의도를 흐리게 합니다.

명백한 해결책은 Log 클래스를 싱글톤으로 만드는 것입니다. 그러면 모든 함수는 인스턴스를 얻기 위해 클래스 자체로 이동할 수 있습니다. 그러나 그렇게 하면 우리는 우연히 이상한 제한을 얻게 됩니다. 갑자기, 더 이상 하나 이상의 로거를 만들 수 없습니다.

처음에는 이것이 문제가 되지 않습니다. 우리는 하나의 로그 파일만 작성하므로 결국 하나의 인스턴스만 필요합니다. 그런데 개발 주기가 진행되면서 문제가 발생합니다. 팀의 모든 사람들이 자신의 진단 정보를 기록하기 위해 로거를 사용하고, 로그 파일은 거대한 덤프 공간이 되어버립니다. 프로그래머들은 자신이 관심 있는 항목을 찾기 위해 페이지를 헤엄쳐야 합니다.

우리는 이를 해결하기 위해 로깅을 여러 파일로 분할하고자 합니다. 이를 위해 온라인, UI, 오디오, 게임플레이와 같은 다른 게임 영역에 대한 별도의 로거를 갖을 것입니다. 그러나 우리는 할 수 없습니다. Log 클래스는 이제 더 이상 여러 인스턴스를 생성할 수 없을 뿐만 아니라, 그 설계 제약은 그것을 사용하는 모든 호출 지점에 깊이 박혀 있습니다.

```
Log::instance().write("Some event.");
```

Log 클래스가 처음처럼 다중 인스턴스화를 지원하도록 만들기 위해서는, 클래스 자체와 해당 클래스를 언급하는 모든 코드의 각 줄을 수정해야 합니다. 우리의 편리한 접근 방식은 더 이상 편리하지 않습니다.

### 게으른 초기화는 제어를 가져가버립니다

가상 메모리와 소프트한 성능 요구 사항이 있는 데스크탑 PC 세계에서 게으른 초기화는 똑똑한 트릭입니다. 게임은 다른 동물입니다. 시스템 초기화는 시간이 걸릴 수 있습니다: 메모리 할당, 리소스 로딩 등. 오디오 시스템 초기화에 몇 백 밀리초가 걸린다면, 그것이 언제 발생할지 제어해야 합니다. 첫 번째로 사운드가 재생될 때 자체적으로 게으른 초기화하게 둔다면, 그것은 게임의 액션 집중적인 부분에서 발생할 수 있으며, 화면이 눈에 띄게 끊기고 게임 플레이가 버벅거릴 수 있습니다.

마찬가지로, 게임은 일반적으로 메모리가 힙에 어떻게 배치되는지를 면밀히 제어하여 단편화를 피해야 합니다. 오디오 시스템이 초기화될 때 힙의 한 조각을 할당한다면, 그 초기화가 언제 발생할지 알고 싶으므로 해당 메모리가 힙의 어디에 존재할지 제어하고 싶습니다.

이러한 두 가지 문제로 인해, 내가 본 대부분의 게임은 게으른 초기화에 의존하지 않습니다. 대신, 다음과 같이 싱글톤 패턴을 구현합니다:

```
class FileSystem
{
public:
  static FileSystem& instance() { return instance_; }

private:
  FileSystem() {}

  static FileSystem instance_;
};
```

이로써 게으른 초기화 문제는 해결되지만, 원시 전역 변수보다 더 나은 여러 싱글톤 기능을 버리는 대가가 발생합니다. 정적 인스턴스를 사용하면 다형성을 더 이상 사용할 수 없으며, 클래스는 정적 초기화 시간에 구성 가능해야 합니다. 또한 인스턴스가 필요하지 않을 때 사용 중인 메모리를 해제할 수 없습니다.

싱글톤을 생성하는 대신, 우리가 실제로 가지고 있는 것은 간단한 정적 클래스입니다. 이것이 반드시 나쁜 것은 아니지만, 정적 클래스만 필요한 경우에는 완전히 instance() 메서드를 제거하고 대신 정적 함수를 사용하는 것이 어떨까요? Foo::bar()를 호출하는 것은 Foo::instance().bar()보다 간단하며, 정적 메모리를 다루고 있다는 것을 명확하게 보여줍니다.
<br><br>


## What We Can Do Instead

지금까지 목표를 달성했다면, 다음에 문제가 발생했을 때 Singleton을 바로 꺼내기 전에 한 번 더 생각하게 될 것입니다. 그러나 여전히 해결해야 할 문제가 있습니다. 어떤 도구를 사용해야 할까요? 해결하려는 작업에 따라 몇 가지 옵션이 있습니다만, 먼저...

어떤 클래스가 필요한지 확인해보세요

게임에서 본 싱글톤 클래스 중 많은 것들은 "매니저"입니다. 다른 객체를 돌보기 위해 존재하는 모호한 클래스입니다. 가끔 코드베이스를 보면 거의 모든 클래스가 매니저를 가지고 있는 것 같습니다: Monster, MonsterManager, Particle, ParticleManager, Sound, SoundManager, ManagerManager. 때로는 다양성을 위해 "System"이나 "Engine"을 더해줄 때도 있지만, 여전히 동일한 아이디어입니다.

보호자 클래스는 때로는 유용할 수 있지만, 종종 객체 지향 프로그래밍에 대한 이해 부족을 반영하기도 합니다. 다음 두 가지 가짜 클래스를 생각해보세요:

```
class Bullet
{
public:
  int getX() const { return x_; }
  int getY() const { return y_; }

  void setX(int x) { x_ = x; }
  void setY(int y) { y_ = y; }

private:
  int x_, y_;
};

class BulletManager
{
public:
  Bullet* create(int x, int y)
  {
    Bullet* bullet = new Bullet();
    bullet->setX(x);
    bullet->setY(y);

    return bullet;
  }

  bool isOnScreen(Bullet& bullet)
  {
    return bullet.getX() >= 0 &&
           bullet.getX() < SCREEN_WIDTH &&
           bullet.getY() >= 0 &&
           bullet.getY() < SCREEN_HEIGHT;
  }

  void move(Bullet& bullet)
  {
    bullet.setX(bullet.getX() + 5);
  }
};
```

이 예시는 조금 어리석은 것일 수 있지만, 구린 세부 사항을 제거하면 이와 같은 설계가 드러난 코드를 많이 본 적이 있습니다. 이 코드를 보면 BulletManager가 싱글톤이어야 한다는 생각이 자연스럽게 듭니다. 결국, Bullet이 있는 모든 것은 매니저도 필요하고, BulletManager의 인스턴스가 얼마나 필요한가요?

여기서 정답은 사실상 제로입니다. 매니저 클래스에 대한 "싱글톤" 문제를 다음과 같이 해결합니다:

```
class Bullet
{
public:
  Bullet(int x, int y) : x_(x), y_(y) {}

  bool isOnScreen()
  {
    return x_ >= 0 && x_ < SCREEN_WIDTH &&
           y_ >= 0 && y_ < SCREEN_HEIGHT;
  }

  void move() { x_ += 5; }

private:
  int x_, y_;
};
```

그럼 이렇게 하죠. 매니저 없이도 문제없이 해결되었습니다. 잘못 설계된 싱글톤은 종종 다른 클래스에 기능을 추가하는 "도우미"입니다. 가능하다면, 해당 도우미 기능을 도움을 주는 클래스 자체로 이동시켜주세요. 결국, 객체 지향 프로그래밍은 객체가 자신을 관리하도록 하는 것입니다.

매니저를 제외하고도, 싱글톤을 해결해야 할 다른 문제들이 있습니다. 각각의 문제에 대해 고려할 수 있는 대체적인 해결책이 있습니다.

### 클래스를 단일 인스턴스로 제한하기

이것은 싱글톤 패턴이 제공하는 기능 중 하나입니다. 파일 시스템 예시와 같이 클래스가 단일 인스턴스만 존재하는 것이 중요할 수 있습니다. 그러나 이는 또한 그 인스턴스에 대한 공개적이고 전역적인 접근을 제공하고 싶다는 의미는 아닙니다. 코드의 특정 영역에 대한 접근을 제한하거나, 단일 클래스에 대해 private하게 만들기를 원할 수도 있습니다. 이러한 경우, 공개적인 전역 접근 지점을 제공하는 것은 아키텍처를 약화시킵니다.

전역 접근을 제공하지 않으면서 단일 인스턴스화를 보장할 수 있는 방법이 있습니다. 몇 가지 방법이 있지만, 다음은 하나의 방법입니다:

```
class FileSystem
{
public:
  FileSystem()
  {
    assert(!instantiated_);
    instantiated_ = true;
  }

  ~FileSystem() { instantiated_ = false; }

private:
  static bool instantiated_;
};

bool FileSystem::instantiated_ = false;
```

이 클래스는 누구나 인스턴스를 생성할 수 있게 하지만, 여러 개의 인스턴스를 생성하려고 시도하면 어설트(assert)하고 실패합니다. 올바른 코드가 먼저 인스턴스를 생성한다면, 다른 코드가 해당 인스턴스에 접근하거나 자체적으로 인스턴스를 생성하는 것을 방지할 수 있습니다. 이 클래스는 신경 쓰는 단일 인스턴스화 요구 사항을 보장하지만, 클래스의 사용 방법은 규정하지 않습니다.

이 구현의 단점은 여러 인스턴스화를 방지하는 검사가 런타임에만 수행된다는 것입니다. 이에 비해 싱글톤 패턴은 클래스의 구조적 특성으로 인해 컴파일 타임에 단일 인스턴스를 보장합니다.

### 인스턴스에 편리한 접근을 제공하기

편리한 접근은 우리가 싱글톤을 사용하는 주된 이유입니다. 싱글톤은 우리가 많은 다양한 장소에서 사용해야 하는 객체에 쉽게 접근할 수 있게 해줍니다. 그러나 이 편리함은 대가가 따릅니다. 우리가 원하지 않는 장소에서도 쉽게 객체에 접근할 수 있게 되는 것입니다.

일반적으로 변수는 가능한 한 좁은 범위로 제한하면서 작업을 수행해야 합니다. 객체가 가지는 범위가 작을수록 해당 객체와 작업하는 동안 기억해야 할 장소가 적어집니다. 전역 범위를 가진 싱글톤 객체의 산발적인 접근 방식을 사용하기 전에, 코드베이스에서 객체에 접근할 수 있는 다른 방법을 고려해보겠습니다:

- 전달하기. 가장 간단한 해결책이자 종종 가장 좋은 해결책은 필요한 객체를 해당 객체를 필요로 하는 함수의 인수로 전달하는 것입니다. 이 방법은 번거로워서 버릴만한 방법으로 여기기 전에 고려해볼 가치가 있습니다.

    객체를 렌더링하는 함수를 생각해보세요. 렌더링을 위해서는 그래픽 디바이스를 나타내고 렌더 상태를 유지하는 객체에 대한 접근이 필요합니다. 보통 이를 context와 같은 이름의 매개변수로 렌더링 함수에 전달하는 것이 매우 일반적입니다. 
    
    반면, 일부 객체는 메서드의 시그니처에 포함되지 않습니다. 예를 들어, AI를 처리하는 함수는 로그 파일에도 기록해야 할 수 있지만 로깅은 주요 관심사가 아닙니다. 그 함수의 인수 목록에 Log가 표시되는 것은 이상할 것입니다. 따라서 이와 같은 경우에는 다른 옵션을 고려해야 합니다.
- 베이스 클래스로부터 가져오기. 많은 게임 아키텍처에서는 얕지만 넓은 상속 계층 구조를 가지고 있으며, 종종 한 단계만 깊습니다. 예를 들어, 게임의 각 적 또는 객체에 대한 파생 클래스가 있는 기본 GameObject 클래스를 가질 수 있습니다. 이와 같은 아키텍처를 사용하면 게임 코드의 많은 부분이 이러한 "리프" 파생 클래스에 위치하게 됩니다. 이는 이러한 클래스들이 이미 동일한 것에 액세스할 수 있다는 것을 의미합니다: 그들의 GameObject 베이스 클래스. 이를 우리의 이점으로 활용할 수 있습니다:
    ```
    class GameObject
    {
    protected:
    Log& getLog() { return log_; }

    private:
    static Log& log_;
    };

    class Enemy : public GameObject
    {
    void doSomething()
    {
        getLog().write("I can log!");
    }
    };
    ```
    이를 통해 GameObject 외부에서는 Log 객체에 접근할 수 없지만, 모든 파생된 엔티티는 getLog()를 사용하여 접근할 수 있습니다. 이러한 방식은 파생된 객체가 제공된 protected 메서드를 사용하여 자체를 구현하도록 하는 패턴으로, Subclass Sandbox 장에서 다루고 있습니다.
- 이미 전역으로 사용 가능한 무언가로부터 가져오세요. 모든 전역 상태를 제거하는 것은 칭찬할 만한 목표이지만, 실제로는 거의 실현 가능하지 않습니다. 대부분의 코드베이스는 전체 게임 상태를 나타내는 단일 Game 또는 World 객체와 같이 전역으로 사용 가능한 몇 가지 객체를 갖게 될 것입니다. 
    
    우리는 Log, FileSystem 및 AudioPlayer를 싱글톤으로 만드는 대신 이와 같이 기존의 것들에 끼워 맞추는 방식으로 전역 클래스의 수를 줄일 수 있습니다:
    ```
    class Game
    {
    public:
    static Game& instance() { return instance_; }

    // Functions to set log_, et. al. ...

    Log&         getLog()         { return *log_; }
    FileSystem&  getFileSystem()  { return *fileSystem_; }
    AudioPlayer& getAudioPlayer() { return *audioPlayer_; }

    private:
    static Game instance_;

    Log         *log_;
    FileSystem  *fileSystem_;
    AudioPlayer *audioPlayer_;
    };
    ```
    이렇게 하면 Game만 전역으로 사용할 수 있습니다. 함수는 다른 시스템에 Game을 통해 접근할 수 있습니다:
    ```
    Game::instance().getAudioPlayer().play(VERY_LOUD_BANG);
    ```
    나중에 아키텍처가 변경되어 여러 개의 Game 인스턴스를 지원하게 된다면(예: 스트리밍이나 테스트 목적으로), Log, FileSystem 및 AudioPlayer는 전혀 영향을 받지 않습니다. 심지어 그들은 차이를 알지 못할 것입니다. 물론 이러한 접근 방식의 단점은 더 많은 코드가 Game 자체에 결합된다는 것입니다. 예를 들어 클래스가 단순히 소리를 재생해야 하는 경우, 해당 예제는 해당 클래스가 오디오 플레이어에 접근하기 위해 월드에 대해 알아야 한다는 것을 요구합니다.

    이 문제를 하이브리드 솔루션으로 해결합니다. 이미 Game에 대해 알고 있는 코드는 Game에서 AudioPlayer에 직접 액세스할 수 있습니다. 그렇지 않은 코드의 경우, 여기에서 설명한 다른 옵션 중 하나를 사용하여 AudioPlayer에 액세스할 수 있도록 제공합니다.
- 서비스 로케이터(Service Locator)에서 가져오세요. 지금까지 우리는 전역 클래스가 Game과 같은 일반적인 구체적인 클래스라고 가정했습니다. 다른 옵션은 전역으로 객체에 액세스할 목적으로 정의된 클래스를 정의하는 것입니다. 이러한 일반적인 패턴을 서비스 로케이터라고 하며, 해당 패턴은 별도의 장에서 다루고 있습니다.
<br><br>


## 싱글톤에 남은 것은 무엇일까요?

실제로 싱글톤 패턴을 어디에 사용해야 할까요? 솔직히 말해서, 나는 게임에서 완전한 Gang of Four 구현을 사용한 적이 없습니다. 단일 인스턴스화를 보장하기 위해 보통 단순히 정적 클래스를 사용합니다. 그렇지 않은 경우에는 실행 시에 단일 클래스 인스턴스만 생성되도록 정적 플래그를 사용합니다.

이 책에는 이 부분에 도움이 될 수 있는 몇 가지 다른 장(chapter)도 있습니다. Subclass Sandbox 패턴은 클래스의 인스턴스가 일부 공유 상태에 접근할 수 있게 하면서 전역으로 사용할 수 없도록 합니다. 서비스 로케이터 패턴은 객체를 전역으로 사용할 수 있지만, 해당 객체가 구성되는 방식에 대해 더 많은 유연성을 제공합니다.