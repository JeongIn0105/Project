//
//  ViewController.swift
//  PokemonApp
//
//  Created by 이정인 on 2/19/26.
//

// MARK: Level 1 - 친구 목록 메인 화면 UI 구현.
import UIKit
import SnapKit
import CoreData // Level 5 - CoreData 방식.

class ViewController: UIViewController {
    
    // MARK: Level 5 - CoreData 저장 데이터 배열.
    var phoneBookData = [PhoneBook]()
    
    // MARK: Level 1 - 친구 목록 타이틀 UILabel.
    private let titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "친구 목록"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        
        return label
        
    }()
    
    // MARK: Level 1 - 추가 버튼 UIButton.
    private let addButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = .white
        
        // MARK: Level 2 - push로 연락처 추가 화면 이동.
        button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
        
        return button
        
    }()
    
    // MARK: Level 1 - UITableView UI 구성.
    private lazy var pokemonTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        // 테이블 뷰에다가 테이블 뷰 셀 등록.
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 다음 화면(연락처 추가)로 넘어갔을 때, 뒤로 가기 텍스트가 'Back'으로 보이게 구현.
        navigationItem.backButtonTitle = "Back"
        
        
        // MARK: Level 5 - CoreData container 연결.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        PhoneBookViewController.container = appDelegate.persistentContainer
        
        configureUI()
    }
    
    // MARK: Level 5 - 저장된 데이터 화면 복귀 시 reload.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        readAllData()
    }
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        [titleLabel, addButton, pokemonTableView].forEach { view.addSubview($0) }
        
        // MARK: Level 1 - ViewController 제약 조건.
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }

        addButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }

        pokemonTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.bottom.equalToSuperview().offset(-60)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerX.equalTo(titleLabel.snp.centerX)
        }
        
    }
    
    // MARK: Level 2 - 연락처 추가 버튼 액션.
    @objc
    private func buttonTapped() {
        navigationController?.pushViewController(PhoneBookViewController(), animated: false)
    }
    
    
}

// MARK: Level 1 - Cell 높이 지정.
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80 // 셀 높이 80으로 지정.
    }
}

// MARK: Level 1 - 테이블 뷰 DataSource 설정.
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // MARK: Level 1 - 셀에 이름 / 전화번호 / 이미지 표시.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(phoneBookData: phoneBookData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        phoneBookData.count
    }
    
    // MARK: Level 7 + Level 8 구현.
    // 연락처 편집 페이지에서, 실제로 기기 디스크 데이터에 Update.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // "적용" 버튼을 클릭했을 때, 기존 데이터를 수정할 editView 생성(Update).
        let editView = PhoneBookViewController()
        
        // MARK: Level 7 - 기존 데이터 전달(지금 선택한 셀의 연락처 데이터를 editView에 넘김).
        editView.isEditingBook = phoneBookData[indexPath.row]
        
        // MARK: Level 7 - 이름 / 전화번호 / 이미지 입력된 상태로 이동.
        editView.nameTextField.text = phoneBookData[indexPath.row].name
        editView.phoneNumberTextField.text = phoneBookData[indexPath.row].phoneNumber
        
        if let imageData = phoneBookData[indexPath.row].image {
            editView.profileImageView.image = UIImage(data: imageData)
        }
        
        // 현재 화면에서 새로운 화면(ViewController)을 스택 위로 올려서 이동.
        navigationController?.pushViewController(editView, animated: true)
    }

}

// MARK: Level 5 - CoreData fetch.
// container에 저장된 데이터를 불러오는 메서드.
extension ViewController {
    
    func readAllData() {
        do {
            guard let phoneBooks = try PhoneBookViewController.container?.viewContext.fetch(PhoneBook.fetchRequest()) else { return }
            
            // MARK: Level 6 - 항상 이름 순으로 정렬.
            phoneBookData = phoneBooks.sorted {
                return $0.name ?? "" < $1.name ?? ""
            }
            self.pokemonTableView.reloadData()
        } catch {
            print("데이터 읽기 실패")
        }
    }
}

