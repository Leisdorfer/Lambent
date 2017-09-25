import UIKit
import AVFoundation

class CameraOverlay: UIView {
    private let sectionLabel = UILabel()
    private let valueLabel = UILabel()
    private let slider = UISlider()
   
    private let device: AVCaptureDevice
    private let section: Page
 
    init?(section: Page) {
        guard let device = AVCaptureDevice.DiscoverySession.init(deviceTypes: [.builtInWideAngleCamera], mediaType: nil, position: .unspecified).devices.first else { return nil }
        self.device = device
        self.section = section
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.backgroundColor()
        alpha = 0.7
        sectionLabel.text = section.description()
        sectionLabel.numberOfLines = 0
        sectionLabel.textAlignment = .center
        sectionLabel.textColor = .white
        addSubview(sectionLabel)
        valueLabel.textColor = .white
        addSubview(valueLabel)
        configureSlider()
        slider.addTarget(self, action: #selector(sliderMoved), for: .valueChanged)
        addSubview(slider)
    }
    
    @objc private func sliderMoved() {
        do {
            try device.lockForConfiguration()
            updateExposureMode()
            device.unlockForConfiguration()
        } catch {
            print("unable to lock device due to error: \(error)")
        }
    }
    
    private func updateExposureMode() {
        switch section {
        case .iso:
            let newISO = slider.value
            valueLabel.text = String(Int(newISO))
            device.setExposureModeCustom(duration: device.exposureDuration, iso: newISO, completionHandler: nil)
        case .shutter:
            let newShutterSpeed = CMTime(seconds: Double(slider.value), preferredTimescale: 1000000)
            guard newShutterSpeed.seconds > device.activeFormat.minExposureDuration.seconds && newShutterSpeed.seconds < device.activeFormat.maxExposureDuration.seconds else { return }
            configureShutterText()
            device.setExposureModeCustom(duration: newShutterSpeed, iso: device.iso, completionHandler: nil)
        case .focal:
            let newFocalLength = CGFloat(slider.value)
            valueLabel.text = String(Int(newFocalLength))
            device.videoZoomFactor = newFocalLength
        default: return
        }
        setNeedsLayout()
    }
    
    private func configureSlider() {
        switch section {
        case .iso:
            slider.minimumValue = device.activeFormat.minISO
            slider.maximumValue = 1856
        case .shutter:
            slider.minimumValue = Float(device.activeFormat.minExposureDuration.seconds)
            slider.maximumValue = Float(device.activeFormat.maxExposureDuration.seconds)
        case .focal:
            slider.minimumValue = 1
            slider.maximumValue = Float(device.activeFormat.videoMaxZoomFactor)/4
        default: return
        }
    }
    
    private func configureShutterText() {
        switch slider.value {
        case 0.008 ..< 0.01: valueLabel.text = "1/125"
        case 0.01 ..< 0.03: valueLabel.text = "1/60"
        case 0.03 ..< 0.06: valueLabel.text = "1/30"
        case 0.06 ..< 0.125: valueLabel.text = "1/15"
        case 0.125 ..< 0.25: valueLabel.text = "1/8"
        case 0.25 ..< 0.4: valueLabel.text = "1/4"
        case 0.4 ... 0.5: valueLabel.text = "1/2"
        default: valueLabel.text = "0"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let sliderSize = slider.sizeThatFits(bounds.size)
        let sliderWidth = UIScreen.main.bounds.width * 0.5
        slider.frame = CGRect(x: bounds.midX - sliderWidth/2, y: bounds.midY - sliderSize.height/2, width: sliderWidth, height: sliderSize.height)
        let valueLabelSize = valueLabel.sizeThatFits(bounds.size)
        valueLabel.frame = CGRect(x: slider.frame.maxX + 8, y: bounds.midY - valueLabelSize.height/2, width: valueLabelSize.width, height: valueLabelSize.height)
        let contentArea = bounds.divided(atDistance: slider.frame.minX, from: .minXEdge).slice
        let sectionLabelSize = sectionLabel.sizeThatFits(contentArea.size)
        sectionLabel.frame = CGRect(x: slider.frame.minX - sectionLabelSize.width - 8, y: bounds.midY - sectionLabelSize.height/2, width: sectionLabelSize.width, height: sectionLabelSize.height)
    }
}

class CameraHandler: UIView {
    private let imagePicker = UIImagePickerController()
    
    init(section: Page) {
        super.init(frame: CGRect.zero)
        imagePicker.sourceType = .camera
        let cameraOverlay = CameraOverlay(section: section)
        cameraOverlay?.frame = CGRect(x: 0, y: 475, width: UIScreen.main.bounds.width, height: 75)
        imagePicker.cameraOverlayView = cameraOverlay

        UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
