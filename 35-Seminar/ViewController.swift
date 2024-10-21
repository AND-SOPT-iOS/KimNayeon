//
//  ViewController.swift
//  35-Seminar
//
//  Created by 김나연 on 10/5/24.
//

import UIKit

import SnapKit

final class ViewController: UIViewController {
    
    private var pushMode = true
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "카카오톡"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임 미설정"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력해주세요."
        textField.font = .systemFont(ofSize: 14)
        textField.clearButtonMode = .whileEditing
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14)
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var pushModeToggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("전환 모드 변경", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setUI()
        setLayout()
    }

    private func setStyle() {
        self.view.backgroundColor = .white
        updateUI()
    }
    
    private func updateUI() {
        self.titleLabel.text = pushMode ? "네비게이션" : "모달"
    }

    private func setUI() {
        [titleLabel, nicknameLabel, stackView, nextButton, pushModeToggleButton].forEach {
          $0.translatesAutoresizingMaskIntoConstraints = false
          self.view.addSubview($0)
        }
        
        [titleTextField, contentTextView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        titleTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        contentTextView.snp.makeConstraints {
            $0.height.equalTo(200)
        }

        nextButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(pushModeToggleButton.snp.top).offset(-16)
            $0.centerX.equalToSuperview()
        }
        
        pushModeToggleButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
        }
    }

    private func transitionToNextViewController() {
        let nextViewController = DetailViewController()
        nextViewController.delegate = self
        nextViewController.completionHandler = { [weak self] nickname in
            guard let self else { return }
            self.nicknameLabel.text = nickname
        }
        
        guard let title = titleTextField.text,
              let content = contentTextView.text
        else { return }
        nextViewController.dataBind(title: title, content: content)
        
        if pushMode {
            self.navigationController?.pushViewController(
              nextViewController,
              animated: true
            )
        } else {
            self.present(
              nextViewController,
              animated: true
            )
        }
    }

    @objc func toggleButtonTapped() {
        self.pushMode.toggle()
        self.updateUI()
    }
    
    @objc func nextButtonTapped() {
        transitionToNextViewController()
    }
}

extension ViewController: NicknameDelegate {
    
  func dataBind(nickname: String) {
    guard !nickname.isEmpty else { return }
    self.nicknameLabel.text = nickname
  }
}
