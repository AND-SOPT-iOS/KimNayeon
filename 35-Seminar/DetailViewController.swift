//
//  DetailViewController.swift
//  35-Seminar
//
//  Created by 김나연 on 10/5/24.
//

import UIKit

import SnapKit

protocol NicknameDelegate: AnyObject {
  func dataBind(nickname: String)
}

final class DetailViewController: UIViewController {
    
    weak var delegate: NicknameDelegate?
    var completionHandler: ((String) -> ())?
    private var receivedTitle: String?
    private var receivedContent: String?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
      
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력하세요."
        textField.font = .systemFont(ofSize: 14)
        textField.clearButtonMode = .whileEditing
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftViewMode = .always
        return textField
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("이전 화면으로", for: .normal)
        button.backgroundColor = .tintColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
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
    }

    private func setUI() {
        [titleLabel, contentLabel, nicknameTextField, backButton].forEach {
          $0.translatesAutoresizingMaskIntoConstraints = false
          self.view.addSubview($0)
        }
    }

    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(contentLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        backButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    func updateUI() {
        self.titleLabel.text = receivedTitle
        self.contentLabel.text = receivedContent
    }

    func dataBind(title: String, content: String) {
        self.receivedTitle = title
        self.receivedContent = content
        updateUI()
    }

    @objc func backButtonTapped() {
        if let nickname = nicknameTextField.text {
//          delegate?.dataBind(nickname: nickname)
            completionHandler?(nickname)
        }
        
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
