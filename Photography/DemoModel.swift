import Foundation

struct DemoSettings {
    var apertureImage: String = "fountain2.8"
    var apertureText: String = "f/2.8"
    var cameraOpeningSize: Int? = 38
    var cameraSensorSize: Int? = 44
    var shutterImage: String = "waterfall2.8"
    var shutterIcon: String = "shutter1.2"
    var shutterText: String = "1/2"
    var isoImage: String = "iso100"
    var isoIcon: String = "isoicon100"
    var isoText: String = "100"
    var focalImage: String = "focal18"
    var focalIcon: String = "focalicon18"
    var focalText: String = "18mm"
}

public struct CameraSectionDemoSettings {
    public var image: String?
    public var text: String?
    public var cameraOpeningSize: Int?
    public var cameraSensorSize: Int?
    public var icon: String?
    public var instructions: String?
}

public class DemoModel {
    private var demoSettings = DemoSettings()
    private var sectionSettings = CameraSectionDemoSettings()
    private var updatedInstructions: String?
    private let currentPage: Page
    private var content: Content
    private var previousSliderValue = -1
    
    public var shareInformation: (CameraSectionDemoSettings) -> () = { _ in }
    
    public init (setUp: TutorialSetUp, content: Content) {
        currentPage = setUp.currentPage
        self.content = content
    }
    
    public func configureDemo(sliderValue: Int?) {
        guard let sliderValue = sliderValue, sliderValue != previousSliderValue else { return }
        previousSliderValue = sliderValue
        demoSettings = configureSectionsWhenSliderValueChanged(sliderValue)
        sectionSettings = configureCurrentSection(content.sections[currentPage.rawValue])
        shareInformation(sectionSettings)
    }
    
    private func configureCurrentSection(_ section: String?) -> CameraSectionDemoSettings {
        let demoInstructions = content.instructions[currentPage.rawValue]
        defer { updatedInstructions = content.updatedInstructions[currentPage.rawValue] }
        switch  currentPage {
        case .aperture:
            return CameraSectionDemoSettings(image: demoSettings.apertureImage, text: demoSettings.apertureText, cameraOpeningSize: demoSettings.cameraOpeningSize, cameraSensorSize: demoSettings.cameraSensorSize, icon: nil, instructions: updatedInstructions ?? demoInstructions)
        case .shutter:
            return CameraSectionDemoSettings(image: demoSettings.shutterImage, text: demoSettings.shutterText, cameraOpeningSize: nil, cameraSensorSize: nil, icon: demoSettings.shutterIcon, instructions: updatedInstructions ?? demoInstructions)
        case .iso:
            return CameraSectionDemoSettings(image: demoSettings.isoImage, text: demoSettings.isoText, cameraOpeningSize: nil, cameraSensorSize: nil, icon: demoSettings.isoIcon, instructions: updatedInstructions ?? demoInstructions)
        case .focal:
            return CameraSectionDemoSettings(image: demoSettings.focalImage, text: demoSettings.focalText, cameraOpeningSize: nil, cameraSensorSize: nil, icon: demoSettings.focalIcon, instructions: updatedInstructions ?? demoInstructions)
        default: return sectionSettings
        }
    }
    
    private func configureSectionsWhenSliderValueChanged(_ sliderValue: Int) -> DemoSettings {
        switch sliderValue {
        case 3:
            return DemoSettings(apertureImage: "fountain2.8", apertureText: "f/2.8", cameraOpeningSize: 38, cameraSensorSize: 44, shutterImage: "waterfall2.8", shutterIcon: "shutter1.2", shutterText: "1/2", isoImage: "iso100", isoIcon: "isoicon100", isoText: "100",focalImage: "focal18", focalIcon: "focalicon18", focalText: "18mm")
        case 4:
            return DemoSettings(apertureImage: "fountain4", apertureText: "f/4", cameraOpeningSize: 34, cameraSensorSize: 44, shutterImage: "waterfall4", shutterIcon: "shutter1.4", shutterText: "1/4", isoImage: "iso200", isoIcon: "isoicon200", isoText: "200", focalImage: "focal25", focalIcon: "focalicon25", focalText: "25mm")
        case 6:
            return DemoSettings(apertureImage: "fountain5.6", apertureText: "f/5.6", cameraOpeningSize: 24, cameraSensorSize: 44, shutterImage: "waterfall6", shutterIcon: "shutter1.8", shutterText: "1/8", isoImage: "iso400", isoIcon: "isoicon400", isoText: "400", focalImage: "focal35", focalIcon: "focalicon35", focalText: "35mm")
        case 8:
            return DemoSettings(apertureImage: "fountain8", apertureText: "f/8", cameraOpeningSize: 20, cameraSensorSize: 44, shutterImage: "waterfall8", shutterIcon: "shutter1.15", shutterText: "1/15", isoImage: "iso800", isoIcon: "isoicon800", isoText: "800", focalImage: "focal45", focalIcon: "focalicon45", focalText: "45mm")
        case 11:
            return DemoSettings(apertureImage: "fountain11", apertureText: "f/11", cameraOpeningSize: 16, cameraSensorSize: 44, shutterImage: "waterfall11", shutterIcon: "shutter1.30", shutterText: "1/30", isoImage: "iso1600", isoIcon: "isoicon1600", isoText: "1600", focalImage: "focal55", focalIcon: "focalicon55", focalText: "55mm")
        case 16:
            return DemoSettings(apertureImage: "fountain16", apertureText: "f/16", cameraOpeningSize: 12, cameraSensorSize: 44, shutterImage: "waterfall16", shutterIcon: "shutter1.60", shutterText: "1/60", isoImage: "iso3200", isoIcon: "isoicon3200", isoText: "3200", focalImage: "focal80", focalIcon: "focalicon80", focalText: "80mm")
        case 22:
            return DemoSettings(apertureImage: "fountain22", apertureText: "f/22", cameraOpeningSize: 8, cameraSensorSize: 44, shutterImage: "waterfall22", shutterIcon: "shutter1.125", shutterText: "1/125", isoImage: "iso6400", isoIcon: "isoicon6400", isoText: "6400", focalImage: "focal100", focalIcon: "focalicon100",focalText: "100mm")
        default:
            return demoSettings
        }
    }
}
