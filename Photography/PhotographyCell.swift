import UIKit

class PhotographyCell: UITableViewCell {
    private let title = UILabel()
    private let phrase = UILabel()
    private let startButton = UIButton()
    private let leftButton = UIButton()
    private let middleButton = UIButton()
    private let rightButton = UIButton()
    private let horizontalSeparator = UIView()
    private let leftVerticalSeparator = UIView()
    private let rightVerticalSeparator = UIView()
    
    private let buttonHeight: CGFloat = 45
    private let buttonWidth = (UIScreen.main.bounds.width - 30) * 0.33
   // private var segment: Segment?
    
    var pressButton: (Segment?)->() = { _ in }
    
    static let reuseIdentifier = "Cell"
    
    override init (style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        contentView.addSubviews([title, phrase, horizontalSeparator, leftVerticalSeparator, rightVerticalSeparator, startButton, leftButton, middleButton, rightButton])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let inset: CGFloat = 15
        let insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        let contentArea = UIEdgeInsetsInsetRect(bounds, insets)
        let separatorYOffset = bounds.maxY - 45
        
        let titleSize = title.sizeThatFits(contentArea.size)
        title.frame = CGRect(x: contentArea.minX, y: contentArea.minY, width: titleSize.width, height: titleSize.height)
        
        let phraseSize = phrase.sizeThatFits(contentArea.size)
        phrase.frame = CGRect(x: contentArea.minX, y: (title.frame.maxY + separatorYOffset)/2 - (phraseSize.height/2) + 1, width: phraseSize.width, height: phraseSize.height)
        
        horizontalSeparator.frame = CGRect(x: bounds.minX, y: separatorYOffset, width: bounds.width, height: 1)
        leftVerticalSeparator.frame = CGRect(x: buttonWidth, y: separatorYOffset, width: 1, height: 45)
        rightVerticalSeparator.frame = CGRect(x: buttonWidth * 2, y: separatorYOffset, width: 1, height: 45)
        
        
        startButton.frame = CGRect(x: bounds.midX - buttonWidth/2, y: horizontalSeparator.frame.maxY, width: buttonWidth, height: buttonHeight)
        leftButton.frame = CGRect(x: bounds.minX, y: horizontalSeparator.frame.maxY , width: buttonWidth, height: buttonHeight)
        middleButton.frame = CGRect(x: bounds.midX - buttonWidth/2, y: horizontalSeparator.frame.maxY, width: buttonWidth, height: buttonHeight)
        rightButton.frame = CGRect(x: bounds.midX + buttonWidth/2, y: horizontalSeparator.frame.maxY, width: buttonWidth, height: buttonHeight)
    }
    
    private func commonInit() {
        
        title.font = UIFont.boldSystemFont(ofSize: 14)
        phrase.font = UIFont.systemFont(ofSize: 12)
        phrase.numberOfLines = 0
        
        layoutSeparators([horizontalSeparator, leftVerticalSeparator, rightVerticalSeparator])
        layoutButtons([startButton, leftButton, middleButton, rightButton])
        
        leftButton.setTitle("Intro", for: .normal)
        startButton.setTitle("", for: .normal)
        middleButton.setTitle("", for: .normal)
        rightButton.setTitle("Practice", for: .normal)
        
        middleButton.isEnabled = false
        startButton.isEnabled = false
      //  segment = nil
    }
    
    private func layoutSeparators(_ separators: [UIView]) {
        separators.forEach ({
            $0.layer.borderWidth = 1.5
            $0.layer.borderColor = UIColor.backgroundColor().cgColor
        })
    }
    
    private func layoutButtons(_ buttons: [UIButton]) {
        buttons.forEach({
            $0.setTitleColor(UIColor.buttonColor(), for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        })
    }
    
    func configureCell(_ title: String, _ phrase: String) {
        self.title.text = title
        self.phrase.text = phrase
        self.layer.cornerRadius = 8
        self.selectionStyle = .none
        HelperMethods.configureShadow(element: self)

        if title == "Get Started" {
            configureIntroductionCell(title, phrase)
        } else {
            startButton.isEnabled = false
            middleButton.setTitle("Demo", for: .normal)
            middleButton.isEnabled = true
            leftButton.addTarget(self, action: #selector(pressIntroButton), for: .touchUpInside)
            middleButton.addTarget(self, action: #selector(pressDemoButton), for: .touchUpInside)
            rightButton.addTarget(self, action: #selector(pressPracticeButton), for: .touchUpInside)
        }
    }
    
    @objc private func pressStartButton() {
        pressButton(nil)
    }
    
    @objc private func pressIntroButton() {
        pressButton(Segment.intro)
    }
    
    @objc private func pressDemoButton() {
        pressButton(Segment.demo)
    }
    
    @objc private func pressPracticeButton() {
        pressButton(Segment.practice)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        commonInit()
    }

    private func configureIntroductionCell(_ title: String, _ phrase: String) {
        middleButton.isEnabled = false
        startButton.isEnabled = true
        startButton.addTarget(self, action: #selector(pressStartButton), for: .touchUpInside)
        
        layoutSeparators([horizontalSeparator])
        leftVerticalSeparator.layer.borderWidth = 0
        rightVerticalSeparator.layer.borderWidth = 0
        
        startButton.setTitle("Start", for: .normal)
        leftButton.setTitle("", for: .normal)
        middleButton.setTitle("", for: .normal)
       
        rightButton.setTitle("", for: .normal)
    }
    
   override func sizeThatFits(_ size: CGSize) -> CGSize {
        let phraseHeight: CGFloat = phrase.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude)).height
        let titleHeight: CGFloat = title.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude)).height
        return CGSize(width: size.width, height: phraseHeight + titleHeight + buttonHeight + 8 * 6)
    }
    
}
