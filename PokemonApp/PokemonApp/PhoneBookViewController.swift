//
//  PhoneBookViewController.swift
//  PokemonApp
//
//  Created by 이정인 on 2/20/26.
//

// MARK: Level 2 - 연락처 추가 화면 구현.
import UIKit
import CoreData
import SnapKit
import Alamofire

class PhoneBookViewController: UIViewController {
    
    // MARK: Level 5 - CoreData의 container.
    static var container: NSPersistentContainer?
    
    // MARK: Level 7 - 편집 모드 체크.
    var isEditingBook: PhoneBook?
    
    // MARK: Level 2 - 프로필 이미지 UIImageView.
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 70
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: Level 4 - 랜덤 이미지 생성 버튼 (API).
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(randomImageButtonTapped), for: .touchDown)
        return button
    }()
    
    // MARK: Level 2 - 이름 UITextField.
    let nameTextField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.font = .systemFont(ofSize: 15)
        return textfield
    }()
    
    // MARK: Level 2 - 전화번호 UITextField.
    let phoneNumberTextField: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.font = .systemFont(ofSize: 15)
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        setNavigationController()
    }
    
    // MARK: UI를 view에 반영해주는 메서드.
    private func configureUI() {
        view.backgroundColor = .white
        
        [profileImageView, createButton, nameTextField, phoneNumberTextField].forEach { view.addSubview($0) }
        
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(140)
            $0.top.equalToSuperview().offset(120)
            $0.centerX.equalToSuperview()
        }
        
        createButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(createButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
        
        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }
    }
    
    // MARK: Level 4 - Alamofire를 사용하여 API 호출.
    private func fetchDataByAlamofire<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // MARK: Level 4 - 랜덤 포켓몬 이미지 버튼 생성.
    @objc
    private func randomImageButtonTapped() {
        
        let randomNumber = Int.random(in: 1...1000)
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomNumber)") else { return }
        
        // fetchData()
        fetchDataByAlamofire(url: url) { [weak self] (result: Result<PokemonData, AFError>) in
            
            guard let self else { return }
            
            switch result {
                
            case .success(let pokemon):
                guard let imageUrl = pokemon.sprites.frontDefault else {
                    print("이미지 없음")
                    return
                }
                
                // Alamofire 를 사용하면 이미지 로드
                AF.request(imageUrl).responseData { [weak self] response in
                    
                    guard let self else { return }
                    
                    if let data = response.data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.profileImageView.image = image
                        }
                    }
                }
                
            case .failure(let error):
                print("API 실패: \(error)")
                
            }
        }
    }
    
    // MARK: Level 5 - Create.
    // MARK: Level 8 - Update 분기 처리.
    @objc func buttonTapped() {
        
        // isEditiongBook을 사용하여 분기처리.
        if isEditingBook == nil {
            createBookList()
        } else {
            guard let updateBook = isEditingBook else { return }
            updateBookList(phoneBook: updateBook)
        }
        
        // MARK: Level 5 - pop으로 메인 복귀.
        navigationController?.popViewController(animated: true)
    }
}

// MARK: Level 3 - NavigationBar 구성.
extension PhoneBookViewController {
    private func setNavigationController() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "연락처 추가"
        
        // iOS15+ (특히 최신 iOS)에서는 Appearance로 버튼 색을 지정.
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        // "적용" 같은 일반 BarButtonItem 색.
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.systemBlue
        ]
        
        // Back 버튼도 동일하게 적용.
        appearance.buttonAppearance = buttonAppearance
        appearance.backButtonAppearance = buttonAppearance
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        // (아이콘/화살표 tint도 같이 맞추기).
        navigationController?.navigationBar.tintColor = .systemBlue
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "적용",
            style: .plain,
            target: self,
            action: #selector(buttonTapped)
        )
        
    }
}


extension PhoneBookViewController {
    
    // MARK: Level 5 - CoreData 데이터 생성(Create).
    func createData(name: String, phoneNumber: String, image: Data) {
        
        // 1) context를 먼저 안전하게 꺼내기 (nil이면 그냥 종료).
        guard let context = PhoneBookViewController.container?.viewContext else {
            print("container가 nil 입니다. (CoreData 컨테이너 초기화가 안 됨)")
            return
        }
        
        // 2) entity도 context로 만들기 (여기서도 nil 체크).
        guard let entity = NSEntityDescription.entity(
            forEntityName: PhoneBook.className,
            in: context
        ) else {
            print("Entity를 찾을 수 없음: \(PhoneBook.className)")
            return
        }
        
        // 3) insertInto도 동일한 context 사용.
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: context)
        
        newPhoneBook.setValue(name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(phoneNumber, forKey: PhoneBook.Key.phoneNumber)
        newPhoneBook.setValue(image, forKey: PhoneBook.Key.image)
        
        do {
            try context.save()
            print("연락처 저장 성공")
        } catch {
            print("연락처 저장 실패")
            context.rollback()
        }
    }
    
    // MARK: Level 5 - Create 로직.
    private func createBookList() {
        let nameData = nameTextField.text ?? ""
        let phoneNumberData = phoneNumberTextField.text ?? ""
        if nameData.isEmpty || phoneNumberData.isEmpty {
            showAlert(error: .mustInput)
            return
        }
        guard let image = self.profileImageView.image?.pngData() else {
            showAlert(error: .mustImage)
            return
        }
        
        createData(name: nameData, phoneNumber: phoneNumberData, image: image)
    }
    
    // MARK: Level 8 - 데이터 Update(기존 데이터 수정).
    private func updateBookList(phoneBook: PhoneBook) {
        let nameData = nameTextField.text ?? ""
        let phoneNumberData = phoneNumberTextField.text ?? ""
        if nameData.isEmpty || phoneNumberData.isEmpty {
            showAlert(error: .mustInput)
            return
        }
        guard let image = self.profileImageView.image?.pngData() else {
            showAlert(error: .mustImage)
            return
        }
        
        phoneBook.name = nameData
        phoneBook.phoneNumber = phoneNumberData
        phoneBook.image = image
        
        do {
            try PhoneBookViewController.container?.viewContext.save()
            print("연락처 저장 성공")
        } catch {
            print("연락처 저장 실패")
        }
    }
}

extension PhoneBookViewController {
    
    // MARK: alert 생성하는 메서드.
    func showAlert(error: CustomError) {
        let alert = UIAlertController(title: "오류", message: error.errorTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

