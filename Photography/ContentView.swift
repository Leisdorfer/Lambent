import UIKit
import RxSugar
import RxSwift

class ContentView: UIView, UIScrollViewDelegate {
    private let container = UIView()
    private let scrollView = UIScrollView()
    private let title = UILabel()
    private let content = UILabel()
    private var segmentedControl = UISegmentedControl()
    static var segmentedWidth = CGFloat()
    static var segmentedHeight = CGFloat()
    public var demo: DemoView
    private var isDemo = false
    private let practice: PracticeView
    private let verticalInset: CGFloat = 50
    private let horizontalInset: CGFloat = 18
    private let padding: CGFloat = 20
    
    private let currentPage: Page
    private var currentSegment: Segment
    
    let currentSegmentValue: Observable<Segment>
    private let _currentSegmentValue = PublishSubject<Segment>()
    let trackSegment: Observable<Segment>
    private let _trackSegment = PublishSubject<Segment>()
    let currentSliderValue: Observable<Int>
    let currentDemoSettings: AnyObserver<CameraSectionDemoSettings>
    private let _currentDemoSettings = PublishSubject<CameraSectionDemoSettings>()
    
    init(setUp: TutorialSetUp) {
        currentPage = setUp.currentPage
        currentSegment = setUp.currentSegment
        demo = DemoView(page: currentPage)
        practice = PracticeView(page: currentPage)
        currentSegmentValue = _currentSegmentValue.asObservable()
        currentSliderValue = demo.currentSliderValue
        currentDemoSettings = _currentDemoSettings.asObserver()
        trackSegment = _trackSegment.asObservable()
        super.init(frame: CGRect.zero)
        container.backgroundColor = UIColor.containerColor()
        container.layer.cornerRadius = 8
        HelperMethods.configureShadow(element: container)
        addSubview(container)
        scrollView.delegate = self
        scrollView.bounces = false
        configureSegmentedControlItems()
        segmentedControl.selectedSegmentIndex = currentSegment.rawValue
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        addSubview(segmentedControl)
        addSubview(scrollView)
        title.font = UIFont.boldSystemFont(ofSize: 16)
        addSubview(title)
        content.font = UIFont.systemFont(ofSize: 14)
        content.numberOfLines = 0
        addSubview(demo)
        practice.clipsToBounds = true
        addSubview(practice)
        scrollView.addSubview(content)
        
        rxs.disposeBag
            ++ { [weak self] in self?.demo.addInformation(demoInformation: $0) } <~ _currentDemoSettings.asObservable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSegmentedControlItems() {
        switch currentPage {
        case .overview: segmentedControl.isHidden = true
        case .modes: segmentedControl = UISegmentedControl(items: ["Aperture", "Shutter", "Manual"])
        default: segmentedControl = UISegmentedControl(items: ["Intro", "Demo", "Practice"])
        }
    }
    
    private func layoutAppropriateContent() {
        if isDemo || currentSegment == .demo && currentPage != .overview && currentPage != .modes {
            demo.isHidden = false
            content.isHidden = true
            scrollView.isHidden = true
        } else {
            demo.isHidden = true
            content.isHidden = false
            scrollView.isHidden = false
        }
        setNeedsLayout()
    }
    
    func addInformation(_ information: TutorialSettings) {
        content.text = information.content
        title.text = information.title
        isDemo = information.isDemoScreen
    }
    
    @objc private func segmentedControlValueChanged() {
        guard let segment = Segment(rawValue: segmentedControl.selectedSegmentIndex) else { return }
        currentSegment = segment
        _currentSegmentValue.onNext(currentSegment)
        _trackSegment.onNext(currentSegment)
        layoutAppropriateContent()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.frame = bounds
        let contentTop = (title.text?.isEmpty ?? false) ? segmentedControl.frame.maxY + 8 : title.frame.maxY + padding
        let contentLabelArea = UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: contentTop, left: horizontalInset, bottom: verticalInset, right: horizontalInset))
        let segmentedSize = segmentedControl.sizeThatFits(contentLabelArea.size)
        ContentView.segmentedHeight = segmentedSize.height
        ContentView.segmentedWidth = contentLabelArea.width
        segmentedControl.frame = CGRect(x: bounds.midX - contentLabelArea.width/2, y: bounds.minY + padding, width: contentLabelArea.width, height: segmentedSize.height)
        let demoHeight = bounds.height - segmentedControl.frame.height - padding
        demo.isHidden = !isDemo
        demo.frame = demo.isHidden ? .zero : CGRect(x: bounds.minX, y: segmentedControl.frame.maxY, width: bounds.width, height: demoHeight)
        let titleSize = title.sizeThatFits(bounds.size)
        title.frame = CGRect(x: bounds.midX - titleSize.width/2, y: container.frame.minY + segmentedSize.height, width: titleSize.width, height: titleSize.height)
        practice.isHidden = !(currentSegment == .practice && currentPage != .overview && currentPage != .modes)
        let practiceSize = practice.isHidden ? .zero : practice.sizeThatFits(contentLabelArea.size)
        practice.frame = CGRect(x: contentLabelArea.minX, y: contentLabelArea.minY, width: practiceSize.width, height: practiceSize.height)
        let contentSize = content.sizeThatFits(scrollView.contentSize)
        content.frame = CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)
        scrollView.frame = CGRect(x: contentLabelArea.minX, y: practice.frame.maxY + 8, width: contentLabelArea.width, height: contentLabelArea.height - practice.frame.height)
        let tinyPadding: CGFloat = 4
        scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -tinyPadding)
        scrollView.contentSize = CGSize(width: contentLabelArea.width, height: contentSize.height)
    }    
}
