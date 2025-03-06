import UIKit

class MemberViewController: UIViewController {
    var teamMember: TeamMember?

    private let profileView = UIView()
    private let nameLabel = UILabel()
    private let mbtiLabel = UILabel()
    private let infoStackView = UIView()
    private let containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureMemberData()
        closeGesture()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)

        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15
        containerView.frame = CGRect(x: 40, y: 150, width: 320, height: 600)
        view.addSubview(containerView)

        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.frame = CGRect(x: 40, y: 20, width: 200, height: 30)

        mbtiLabel.font = UIFont.systemFont(ofSize: 14)
        mbtiLabel.textAlignment = .center
        mbtiLabel.layer.cornerRadius = 5
        mbtiLabel.clipsToBounds = true
        mbtiLabel.frame = CGRect(x: 95, y: 22, width: 50, height: 25)

        profileView.backgroundColor = UIColor.lightGray
        profileView.layer.cornerRadius = 10
        profileView.frame = CGRect(x: 50, y: 70, width: 220, height: 200)

        infoStackView.frame = CGRect(x: 30, y: 300, width: 260, height: 200)
        let infoTexts = ["장점", "협업 스타일", "블로그 주소"]
        var yOffset: CGFloat = 0

        for text in infoTexts {
            let label = UILabel()
            label.text = "• \(text)"
            label.font = UIFont.systemFont(ofSize: 16)
            label.frame = CGRect(x: 20, y: yOffset, width: 260, height: 25)
            infoStackView.addSubview(label)
            yOffset += 30
        }

        containerView.addSubview(nameLabel)
        containerView.addSubview(mbtiLabel)
        containerView.addSubview(profileView)
        containerView.addSubview(infoStackView)
    }

    private func configureMemberData() {
        guard let member = teamMember else { return }

        nameLabel.text = member.name
        mbtiLabel.text = member.mbti.name
        mbtiLabel.backgroundColor = member.mbti.color
    }
    
    private func closeGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Modal))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func Modal(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: view)
        if !containerView.frame.contains(touchPoint) {
            dismiss(animated: true, completion: nil)
        }
    }
}
