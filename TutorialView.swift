import UIKit

struct ButtonBinding{
    static func bind(view: TutorialView, handler: @escaping ()->()){
        view.nextSection = handler
    }
}

class TutorialView: UIView{
    var tutorialContent: PhotographyModel? {
        didSet{
            let title = tutorialContent?.sectionTitles[currentPage] ?? ""
            let content = tutorialContent?.content[currentPage] ?? ""
            let steps = tutorialContent?.steps.count ?? 0
            var backButtonTitle: String?
            var nextButtonTitle: String?
            
            if currentPage > 0 && currentPage < steps {
                backButtonTitle = tutorialContent?.steps[currentPage - 1] ?? ""
                nextButtonTitle = tutorialContent?.steps[currentPage + 1] ?? ""
                configureToolBar(backButtonTitle, nextButtonTitle)
            } else if currentPage <= 0{
                backButtonTitle = nil
                nextButtonTitle = tutorialContent?.steps[currentPage + 1] ?? ""
            } else if currentPage >= steps{
                backButtonTitle = tutorialContent?.steps[currentPage - 1] ?? ""
                nextButtonTitle = nil
            }
           
            configurePageControl(steps)
            configureContent(currentTitle: title, currentContent: content)
            configureToolBar(backButtonTitle, nextButtonTitle)
        }
    }
    var nextSection: ()->() = { _ in}
    
    private let container = UIView()
    private let pageControl = UIPageControl()
    private let photographyView = PhotographyView()
    private let photographyCell = PhotographyCell()
    private let scrollView = UIScrollView()
    private let toolBar = UIToolbar()
    private let title = UILabel()
    private let content = UILabel()
    private var toolBarSize = CGSize()
    private var segmentedControl = UISegmentedControl()
    
    private var currentPage = 0

    override init (frame: CGRect){
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.953121841, green: 0.9536409974, blue: 0.9688723683, alpha: 1)
        container.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00)
        container.layer.cornerRadius = 8
        
        title.font = UIFont.boldSystemFont(ofSize: 14)
        content.font = UIFont.systemFont(ofSize: 14)
        content.numberOfLines = 0

        photographyCell.configureShadow(element: container)
        configureSegmentedControl()
        
        addSubviews([container, segmentedControl, title, content, scrollView, toolBar, pageControl])
    }
    
    func configureContent(currentTitle: String, currentContent: String){
        switch currentPage {
        case 0:
            title.text = currentTitle
            content.text = currentContent
        case 1:
            break
        default: break
        }
    }
    
    func configurePageControl(_ steps: Int){
        pageControl.currentPageIndicatorTintColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.00)
        pageControl.numberOfPages = steps
        pageControl.pageIndicatorTintColor = .white
    }
    
    func configureSegmentedControl(){
        if currentPage != 0{
        segmentedControl = UISegmentedControl(items: ["Intro", "Demo", "Practice"])
        segmentedControl.selectedSegmentIndex = 0
        //segmentedControl.addTarget(self, action: "action", for: .valueChanged)
        }
    }
    
    func configureToolBar(_ backButtonTitle: String?, _ nextButtonTitle: String?){
        let backButton = UIBarButtonItem(title: backButtonTitle, style: .plain, target: self, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: nextButtonTitle, style: .plain, target: self, action: #selector(loadNextSection))
        
        if currentPage == 0{
            toolBar.items = [flexibleSpace, nextButton]
        } else {
            toolBar.items = [backButton, flexibleSpace, nextButton]
        }
        toolBar.barTintColor = #colorLiteral(red: 0.953121841, green: 0.9536409974, blue: 0.9688723683, alpha: 1)
        toolBar.clipsToBounds = true
    }
    
    @objc private func loadNextSection(){
        print("hello")
        nextSection()
        ButtonBinding.bind(view: self, handler: {
            print("hello")
        })
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let insets = UIEdgeInsets(top: 75, left: 18, bottom: 75, right: 18)
        let contentArea = UIEdgeInsetsInsetRect(bounds, insets)
        container.frame = CGRect(x: contentArea.minX, y: contentArea.minY, width: contentArea.width, height: contentArea.height)
        
        let segmentedHeight = segmentedControl.sizeThatFits(contentArea.size).height
        let segmentedWidth = contentArea.width - insets.left - insets.right
        segmentedControl.frame = CGRect(x: contentArea.midX - segmentedWidth/2, y: contentArea.minY + 8, width: segmentedWidth, height: segmentedHeight)
        
        let titleSize = title.sizeThatFits(contentArea.size)
        title.frame = CGRect(x: contentArea.midX - titleSize.width/2, y: container.frame.minY + 40, width: titleSize.width, height: titleSize.height)

        let contentHeight = content.sizeThatFits(contentArea.size).height
        let contentWidth = contentArea.width - insets.left - insets.right
        content.frame = CGRect(x: contentArea.midX - contentWidth/2, y: title.frame.maxY + 40, width: contentWidth, height: contentHeight)
        
        let pageControlSize = pageControl.sizeThatFits(contentArea.size)
        pageControl.frame = CGRect(x: contentArea.midX - pageControlSize.width/2, y: (container.frame.maxY + bounds.maxY)/2 - pageControlSize.height/2, width: pageControlSize.width, height: pageControlSize.height)
        
        let toolBarHeight = toolBar.sizeThatFits(contentArea.size).height
        toolBar.frame = CGRect(x: contentArea.minX, y: (container.frame.maxY + bounds.maxY)/2 - toolBarHeight/2, width: contentArea.width, height: toolBarHeight)

        scrollView.frame = CGRect(x: contentArea.minX, y: contentArea.minY, width: contentArea.size.width, height: contentArea.size.height)
    }
    
//    class PageControlHandler: UIScrollView, UIScrollViewDelegate{
//        
//        init(){
//            super.init(frame: CGRect.zero)
//            let tutorial = TutorialView()
//            //tutorial.scrollView.delegate = self
//            //tutorial.scrollView.isPagingEnabled = true
//            tutorial.scrollView.backgroundColor = .blue
//            
//        }
//        
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//
//    }
}
