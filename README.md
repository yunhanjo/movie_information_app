<h1 align="center"> 🎬 Flutter_Movie_App 🍿 </h1> 
<div align="center"> 
<img width="300" height="600" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-27 at 11 27 55" src="https://github.com/user-attachments/assets/ea2c4b18-e74e-44b9-8977-d54c714a51f4" />
<img width="300" height="600" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-27 at 11 28 34" src="https://github.com/user-attachments/assets/d73be778-37b8-4e29-bcab-3c98eea6c7fc" />
</div> 
<br> 

<h3 align="center"> [Flutter 심화] 개인 과제 - 영화 정보 앱 </h3> 
<p align="center"> 프로젝트 일정 [ 25/08/14 ~ 25/08/27 ] </p> 
<br> 
<br> 
<br>

## 🎬 프로젝트 개요 – Movie Information App 🍿

### 💡 영화 정보를 TMDB API에서 가져와 보여주는 앱  
- TMDB API를 통해 영화 정보를 가져오기  
- Hero 위젯으로 영화 목록 → 상세 페이지 전환 시 애니메이션 효과  
- 클린 아키텍처 기반으로 data/domain/presentation 레이어 분리  
- Riverpod 상태관리 적용  
<br>

## 🎯 주요 목표  
- 애니메이션 학습
  - Hero 위젯으로 자연스러운 화면 전환 구현  
- 클린 아키텍처
  - data / domain / presentation 레이어로 분리  
  - DTO, Entity, Repository, UseCase 계층 구현  
- API 연동  
  - TMDB API Key 발급 및 .env로 환경변수 관리  
  - dio 패키지를 통한 비동기 HTTP 요청  
- 상태관리  
  - flutter_riverpod을 이용해 HomeViewModel, DetailViewModel 구현  
<br>

## 📁 파일 구조
<pre>
  <code>lib
├── data
│   ├── datasource
│   │   ├── movie_data_source_impl.dart
│   │   └── movie_data_source.dart
│   ├── dto
│   │   ├── movie_detail_dto.dart
│   │   └── movie_response_dto.dart
│   └── repository
│       └── movie_repository_impl.dart
├── domain
│   ├── entity
│   │   ├── movie_detail.dart
│   │   └── movie.dart
│   ├── repository
│   │   └── movie_repository.dart
│   └── usecase
│       ├── fetch_movie_detail.dart
│       ├── fetch_now_playing_movies.dart
│       ├── fetch_popular_movies.dart
│       ├── fetch_top_rated_movies.dart
│       └── fetch_upcoming_movies.dart
├── env.dart
├── main.dart
└── presentation
    ├── pages
    │   ├── detail_page.dart
    │   └── home_page.dart
    ├── providers.dart
    ├── viewmodel
    │   ├── detail_view_model.dart
    │   └── home_view_model.dart
    └── widgets</code>
</pre>
<br>

## ✅ 완료한 필수 기능
### 1. HomePage  
<div> 
<img width="300" height="600" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-27 at 11 28 16" src="https://github.com/user-attachments/assets/f846da75-4cce-4c16-a47d-f17b6a5805c5" />
</div> 
<br>

- 상단에 가장 인기있는 영화 섹션 표시
- 현재 상영중, 인기순, 평점 높은순, 개봉예정 가로 리스트뷰 구현  
- 각 섹션 위에는 라벨 표시  
- 인기순 섹션에서는 랭킹 숫자를 좌측 하단에 표시

### 2. DetailPage  
<div> 
<img width="300" height="600" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-27 at 11 28 44" src="https://github.com/user-attachments/assets/0dd20cee-8a61-4d3e-b3b3-1ad0572ffa71" />
</div> 
<br>

- 상단 Hero 이미지 전체 너비 표시  
- 상세 정보 출력  
  - 영화 제목, 개봉일  
  - 태그라인  
  - 러닝타임  
  - 장르
  - 영화 설명  
  - 흥행정보 (평점, 투표수, 인기점수, 예산, 수익)
  - 제작사 로고

### 3. Hero 위젯 애니메이션
- HomePage와 DetailPage에서 동일한 tag를 지정
- 전환 시 영화 포스터가 자연스럽게 확대/축소되며 이동

### 4. TMDB API 연동 (Lv.3)
- 회원가입 후 발급받은 v4 API Token 사용
- 영화 목록 (now_playing, popular, top_rated, upcoming)과 상세 정보 호출
- 응답 DTO 정의 후 Domain Entity로 변환
- Repository → UseCase → ViewModel → UI 데이터 바인딩 완료
<br>

## 🔥 Trouble Shooting
### 1. Hero 애니메이션 오류
[문제상황]  
Home → Detail 전환 시 이미지가 자연스럽게 날아가지 않음  

[원인분석]  
DetailPage에서 state.when(loading: …) 구문 때문에 첫 프레임에 Hero 위젯이 존재하지 않았음
Hero가 두 페이지 모두에서 동시에 렌더링되어야 하는데, 
새 라우트의 첫 프레임에서 Hero가 없으니 전환 애니메이션이 포기됨  

[해결방법]  
Hero 위젯은 항상 렌더링되도록 유지하고, 내부 콘텐츠만 상태에 따라 전환 처리  
<pre>
  <code>Hero(
  tag: heroTag,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: (posterPath == null || posterPath!.isEmpty)
        ? Container(
            width: double.infinity,
            color: Colors.blueGrey,
          )
        : Image.network(
            Env.posterUrl(posterPath!),
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
  ),
);

// 내용만 state.when으로 분기
state.when(
  loading: () => Padding(
    padding: EdgeInsets.all(16),
    child: Center(child: CircularProgressIndicator()),
  ),
  error: (e, _) => Padding(
    padding: EdgeInsets.all(16),
    child: Text(e.toString()),
  ),
  data: (detail) {
    /* ... */
  },
);</code>
</pre>
<br>

### 2. Riverpod 2.x에서 Reader 오류
[문제상황]  
ViewModel 작성 중 final Reader read; 선언 시 컴파일 에러 발생
<pre>
  <code>Undefined class 'Reader'</code>
</pre>

[원인분석]  
Riverpod 2.x부터는 Reader 타입이 제거되고 Ref로 통일됨
예전 버전 튜토리얼 코드 그대로 가져오면 오류 발생  

[해결방법]  
ViewModel 생성자에서 Reader 대신 Ref 사용
<pre>
  <code>class DetailViewModel extends StateNotifier<AsyncValue<MovieDetail?>> {
  final Ref ref; // Reader → Ref
  final int movieId;

  DetailViewModel(this.ref, this.movieId)
      : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    try {
      final detail = await ref.read(detailUsecaseProvider)(movieId);
      state = AsyncValue.data(detail);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final detailViewModelProvider = StateNotifierProvider.family<
    DetailViewModel,
    AsyncValue<MovieDetail?>,
    int
>((ref, id) => DetailViewModel(ref, id));</code>
</pre>
<br>

### 3. TMDB 401 Unauthorized
[문제상황]  
Dio 요청 시 401 Unauthorized 발생 (API 키도 있고 URL도 맞음)  

[원인분석]  
TMDB의 v3 키(쿼리스트링 ?api_key=)와 v4 토큰(Bearer 인증)을 혼용해서 사용  
v4 토큰을 쓰면서 Authorization 헤더에 Bearer 접두사를 빠뜨림  

[해결방법]  
Authorization: Bearer {토큰} 헤더를 반드시 포함하고, v3와 v4 중 하나만 사용  
<pre>
  <code>final dio = Dio(BaseOptions(
  baseUrl: 'https://api.themoviedb.org/3',
  headers: {
    'Authorization': 'Bearer ${Env.apiToken}', // Bearer 필수
    'Accept': 'application/json',
  },
));

final res = await dio.get(
  '/movie/now_playing',
  queryParameters: {
    'language': 'ko-KR',
    'page': 1,
  },
);</code>
</pre>
<br>

### 4. .env FileNotFoundError
[문제상황]  
실행 시 .env 파일이 있음에도 불구하고 FileNotFoundError 발생  
<pre>
  <code>await dotenv.load(fileName: ".env");
Exception has occurred.
FileNotFoundError</code>
</pre>

[원인분석]  
flutter_dotenv는 런타임 파일 읽기가 아니라 asset 번들에서 로드  
.env를 pubspec.yaml에 등록하지 않으면 빌드에 포함되지 않음  
혹은 숨김 확장자 문제 (.env.txt), 경로/대소문자 불일치  

[해결방법]  
(1) 프로젝트 루트(pubspec.yaml 옆)에 .env 파일 생성  
(2) pubspec.yaml에 .env 등록  
<pre>
  <code>flutter:
  assets:
    - .env</code>
</pre>

(3) main.dart 초기화
<pre>
  <code>Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(ProviderScope(child: MyApp()));
}</code>
  </pre>

(4) 터미널에서 파일명 확인  
<pre>
  <code>ls -al</code>
</pre>

(5) 반영 후 터미널에서 실행
<pre>
  <code>flutter clean
  flutter pub get
  flutter run</code>
</pre>
<br>
<br>
<br>
