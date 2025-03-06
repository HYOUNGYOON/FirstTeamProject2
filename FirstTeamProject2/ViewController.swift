import UIKit

struct MBTIType {
    let name: String
    let color: UIColor

    static let ESTJ = MBTIType(name: "ESTJ", color: UIColor.red.withAlphaComponent(0.2))
    static let INFP = MBTIType(name: "INFP", color: UIColor.green.withAlphaComponent(0.2))
    static let ISTP = MBTIType(name: "ISTP", color: UIColor.blue.withAlphaComponent(0.2))
    static let INFJ = MBTIType(name: "INFJ", color: UIColor.purple.withAlphaComponent(0.2))
}

struct TeamMember {
    let name: String
    let mbti: MBTIType
    let emoji: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let teamMembers = [
        TeamMember(name: "박혜민", mbti: .ESTJ, emoji: "🙋‍♀️"),
        TeamMember(name: "김기태", mbti: .INFP, emoji: "🧑‍💻"),
        TeamMember(name: "김형윤", mbti: .ISTP, emoji: "👨‍🔧"),
        TeamMember(name: "변준영", mbti: .INFJ, emoji: "🧑‍🏫")
    ]

    private let infoTexts = ["우리팀의 특징", "궁극적인 목표", "우리팀의 약속"]

    private let teamLabel = UILabel()
    private let infoBoxView = UIView()
    private let infoStackView = UIStackView()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor.systemGray6
        let screenWidth = UIScreen.main.bounds.width

        teamLabel.text = "Team360"
        teamLabel.font = UIFont.boldSystemFont(ofSize: 24)
        teamLabel.textColor = UIColor.systemTeal.withAlphaComponent(0.6)
        teamLabel.frame = CGRect(x: 20, y: 80, width: screenWidth - 20 * 2, height: 30)

        infoBoxView.backgroundColor = .white
        infoBoxView.layer.cornerRadius = 10
        infoBoxView.frame = CGRect(x: 20, y: teamLabel.frame.maxY + 10, width: screenWidth - 20 * 2, height: 120)

        infoStackView.axis = .vertical
        infoStackView.alignment = .leading
        infoStackView.distribution = .equalSpacing
        infoStackView.frame = CGRect(x: 15, y: 15, width: infoBoxView.frame.width - 30, height: infoBoxView.frame.height - 30)

        for text in infoTexts {
            let label = UILabel()
            label.text = "• \(text)"
            label.font = UIFont.systemFont(ofSize: 17)
            label.frame = CGRect(x: 0, y: 0, width: infoStackView.frame.width, height: 25)
            infoStackView.addArrangedSubview(label)
        }

        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TeamMemberCell.self, forCellReuseIdentifier: "TeamMemberCell")
        tableView.rowHeight = 60
        tableView.frame = CGRect(x: 20, y: infoBoxView.frame.maxY + 20, width: screenWidth - 20 * 2, height: CGFloat(teamMembers.count) * 60)

        view.addSubview(teamLabel)
        view.addSubview(infoBoxView)
        infoBoxView.addSubview(infoStackView)
        view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamMembers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamMemberCell", for: indexPath) as! TeamMemberCell
        cell.configure(with: teamMembers[indexPath.row])
        return cell
    }
}

class TeamMemberCell: UITableViewCell {
    private let emojiLabel = UILabel()
    private let nameLabel = UILabel()
    private let mbtiLabel = UILabel()
    private let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        mbtiLabel.layer.cornerRadius = 8
        mbtiLabel.clipsToBounds = true
        mbtiLabel.textAlignment = .center
        mbtiLabel.font = UIFont.systemFont(ofSize: 15)
        mbtiLabel.textColor = .black
        arrowImageView.tintColor = .gray

        emojiLabel.frame = CGRect(x: 10, y: 10, width: 30, height: 40)
        nameLabel.frame = CGRect(x:50, y: 10, width: 100, height: 40)
        mbtiLabel.frame = CGRect(x:110, y: 20, width: 50, height: 20)
        arrowImageView.frame = CGRect(x: 360, y: 20, width: 15, height: 15)

        contentView.addSubview(emojiLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(mbtiLabel)
        contentView.addSubview(arrowImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with member: TeamMember) {
        emojiLabel.text = member.emoji
        nameLabel.text = member.name
        mbtiLabel.text = member.mbti.name
        mbtiLabel.backgroundColor = member.mbti.color.withAlphaComponent(0.2)
    }
}
