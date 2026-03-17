
# 📱 앱 개발 심화 주차 과제 - Challenge

## 📌 프로젝트 소개

포켓몬 API를 활용하여 
포켓몬 목록을 조회하고 상세 정보를 확인할 수 있는 iOS 애플리케이션입니다.

- 포켓몬 리스트 조회
- 포켓몬 상세 정보 조회
- 무한 스크롤 기능
- MVVM 아키텍처
- RxSwift, RxRelay 구조 적용

## ▶️ 실행 화면
<p align="center">
<img width="500" height="900" alt="Pokemon" src="https://raw.githubusercontent.com/JeongIn0105/Project/main/ChallengeProject/Pokemon.png" />
</p>

---

## 🛠️ 기술 스택

### Tool
- UIKit
- SnapKit
- Then
- Kingfisher
- PokeAPI
- RxSwift
- RxRelay

---

## ⏰ 과제 일정
- **시작일**: 2026.03.13
- **종료일**: 2026.03.17

---

## 📂 프로젝트 구조(MVVM)

```plaintext
📁 Common
 ┣ NetworkManager.swift

📁 Model
 ┣ Pokemon.swift

📁 View
 ┣ MainViewController.swift
 ┣ DetailViewController.swift
 ┣ PosterCell.swift

📁 ViewModel
 ┣ MainViewModel.swift
 ┣ DetailViewModel.swift

📁 Utils
 ┣ PokemonTranslator.swift
 ┣ PokemonTypeName.swift
```

---

## 📋 과제 설명
1. **`Step 1` NetworkManager 구현**
    - 심화 강의에서 배웠던 `NetworkManager` 를 구현합니다.
    - `디자인 패턴 - 싱글톤 패턴`을 활용해서 구현합니다.
    - 아래 형태를 만족하는 `fetch 메서드`를 작성합니다.
     `func** fetch<T: Decodable>(url: URL) -> Single<T>`
    
2. **`Step 2` MVVM - Model 구현**
    
   - MVVM 중에서 Model 을 구현합니다.
   - 이 앱에서는 아래 2가지 API 를 사용하게 됩니다.
   01. **`limit` 개씩 `offset` 부터 포켓몬 정보 로드**
       - `https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)`
       - 예를들어, limit = 20, offset = 0 이라면 처음부터 20개의 포켓몬 정보를 업로드.
   02. **포켓몬 번호로부터 포켓몬 디테일 정보 로드**
       - `https://pokeapi.co/api/v2/pokemon/\(pokemon_id)/`
       - 위 API 결과들을 담을 수 있는 구조체들을 선언합니다.

3. **`Step 3` MVVM -  MainViewModel 구현**
    
    - 포켓몬 도감을 노출하는 메인화면을 `MainViewController` 라고 합시다.
    - 이에 대한 뷰모델인 `MainViewModel` 을 구현합니다.
    - `RxSwift` 를 활용합니다.
    - 리스트 형태로 포켓몬 정보들을 가져와야겠죠. `limit=20`, `offset=0` 으로 합시다.
    - `NetworkManager` 를 활용해주세요.
    - (이 단계에서는 20개의 포켓몬 정보만 불러와도 됩니다.)
    
4. **`Step 4` MVVM -  MainViewController 구현**
    
    - 왼쪽과 같은 형태의 뷰를 구현합니다.
    - 세로형태로 스크롤 가능한 `UICollectionView` 를 구현합니다.
    - 한 줄에 3개의 포켓몬이 노출되도록 합니다.
    - 포켓몬 이미지 URL
      `https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png`
    - `\(id)` 에 포켓몬 id 값을 입력하면, 포켓몬 id 값에 맞는 png 이미지 파일이 나옵니다.
  
5. **`Step 5` CollectionViewCell 을 클릭했을 때 화면 전환**
    
    - 셀을 클릭해서 이동하는 포켓몬 디테일 화면을 `DetailViewController` 라고 합시다.
    - CollectionViewCell 을 클릭했을 때 그 포켓몬의 디테일화면으로 이동하도록 구현합니다.
    - `DetailViewController` , `DetailViewModel` 을 구현해야합니다.

6. **`Step 6` MVVM -  DetailViewModel 구현**
    
    - `DetailViewModel` 을 구현합니다.
    - 아래 API 를 활용합니다.
    - `https://pokeapi.co/api/v2/pokemon/\(pokemon_id)/`
    - 이 중에서
      - `이름, 타입, 키, 몸무게` 정보만 가져와도됩니다.
  
7. **`Step 7` MVVM -  DetailViewController 구현**
    
    - 왼쪽과 같은 뷰를 구현합니다.
    - Color 는 위에서 선언한 Color 값을 사용합니다.
    - 아래 정보들을 노출해주세요.
      1. No
      2. 이름
      3. 타입
      4. 키
      5. 몸무게
     
8. **`Step 8` 무한 스크롤 구현 (difficult 🔥)**
    
    - Level 3 에서는 20개의 포켓몬 정보만 불러왔었습니다.
    - `limit = 20` 값을 유지한채로, 모든 포켓몬을 볼 때까지 무한히 스크롤 할 수 있는 무한 스크롤을 구현해주세요.
     
도전. **Level 1~8 을 구현하시고도 여유가 되시는 분들은 아래 과정들을 도전해보세요 🤓**
    
   1. `Observable`, `Subject`, `Relay` 의 차이를 공부하고, `ViewModel` 에서 `Relay` 를 활용해보세요.
   2. 가장 많이 활용되는 이미지 라이브러리인 `Kingfisher` 를 활용해보세요.

---

## ✨ 주요 기능
1. **포켓몬 메인 화면**
   - PokeAPI를 이용하여 포켓몬 데이터를 불러온다.
   - `UICollectionView`를 사용하여 Grid 형태로 포켓몬 목록을 구성하였다.
   - 포켓몬 이미지를 표시하고, 셀 클릭 시 상세 화면으로 이동한다.
   - 무한 스크롤 기능을 적용하여 추가 데이터를 불러올 수 있도록 구현하였다.
  
2. **포켓몬 상세 화면**
   - 선택한 포켓몬의 상세 정보를 표시한다.
   - 표시 정보:
     - 포켓몬 번호 (No)
     - 이름 (한글 변환)
     - 타입
     - 키 / 몸무게
     - 포켓몬 이미지
   - PokeAPI 상세 API를 활용하여 데이터를 조회하였다.
  
3. **이미지 처리 (Kingfisher) 활용**
   - `Kingfisher` 라이브러리를 활용하여 이미지 로딩 및 캐싱을 구현하였다.
   - 셀 재사용 시 이미지 깨짐을 방지하기 위해 다운로드 취소 로직을 적용하였다

4. **MVVM 아키텍처 적용**
   - Model / View / ViewModel 구조로 프로젝트를 구성하였다.
   - ViewModel에서 데이터를 관리하고, View는 UI에만 집중하도록 설계하였다.
   - RxSwift를 활용하여 데이터 흐름을 단방향으로 처리하였다.

5. **포켓몬 이름 한글 변환**
   - 영어 이름을 한글로 변환하는 `PokemonTranslator`를 구현하였다.
   - 사용자 친화적인 UI를 제공하도록 개선하였다.
     
6. **도전 기능**
   - Kingfisher 라이브러리를 활용한 이미지 캐싱 처리
   - RxRelay를 활용한 상태 관리 (BehaviorRelay 적용)
 
---
