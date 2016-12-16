import Foundation

struct PhotographyModel{
    let steps = ["Get Started", "Aperture", "Shutter Speed", "ISO", "Focal Length", "Modes"]
    let descriptions = ["Learn the basics", "Aperture refers to the opening through which the light travels before it hits the sensor. Aperture refers to the opening through which the light travels before it hits the sensor. Aperture refers to the opening through which the light travels before it hits the sensor.", "Shutter speed is...", "ISO is...", "Focal length is...","The shooting modes are..."]
    let sectionTitles = ["Learn Photography", "", "", "", "", ""]
    let content = ["Lorem ipsum dolor sit amet, vivamus dis vestibulum ante penatibus odio, sapien nec sed mauris, amet faucibus velit, vehicula nostra et facilisis, at integer erat felis aliquam. Ligula dolor imperdiet semper, maecenas justo eget eu ut. Curabitur imperdiet mauris eros non, sapien mauris dolor donec purus, massa dictum, tempus pellentesque sit netus phasellus nisl. Odio vestibulum ultricies vehicula risus condimentum quam. Risus vel convallis ac urna, erat in diam porttitor justo, eros aliquam sed magna lorem. Orci cras. Congue lorem morbi orci suspendisse blandit, vestibulum auctor purus sit in et, ipsum etiam, in ut vel rutrum et vestibulum parturient.", "Aperture: However, just like shutter speed, modifying the aperture has other consequences than changing exposure. It also modifies depth of field.  For now, we can just remember that large apertures, which mean a lot of light is hitting the sensor, will create shallow depth of field, where the subject is in focus but the background appears blurred. Conversely, small apertures, limiting the quantity of light we record, will create large depth of field, where much of the image is in focus. The smaller the number after the f, the larger the aperture: more light, less depth of field. This is why we care about the maximal aperture of a lens, which is the lowest f-number we can get. Of course, the higher the number, the smaller the aperture: less light, more depth of field.", "Shutter speed: This parameter simply refers to the amount of time during which the shutter is open and the sensor/film exposed. It is usually expressed in fractions of a second, since it will be relatively rare to need durations longer than one second. Obviously, the longer the speed, the more light can be recorded, and thus the higher the exposure. Like everything exposure related, we also talk about stops for shutter speed, which is a relative measurement unit: 1 stop of overexposure corresponds to doubling the amount of light received, so doubling the shutter speed. ", "ISO (aka sensitivity): Concretely, increasing ISO means allowing more light in, but also more noise, especially in the shadows. Like shutter speed and unlike aperture, ISO is a linear value. Double it and you double the amount of light. This makes it easier to determine what a stop is: simply a doubling of the ISO value. So if you are shooting at ISO 800 and want one stop of underexposure, go to ISO 400. If you want one stop of overexposure, go to ISO 1600.", "Focal Length - determines how “zoomed in” you are, also often called angle of view. The lower this number, the less zoomed in you are. We speak of a wide angle, since you can view much on the sides: you have a wide view. Conversely, if the number is high, the angle will be narrow and you will only see a small portion of what is in front of you: you are zoomed in, this is what we call a telephoto.", "Shooting modes - What you will do with this information will depend on the shooting mode you are using: in auto, the camera will simply set all the required parameters so that you can shoot without questions asked. Alternatively, it can let you set one or more parameters and fill in the remaining ones (aperture or speed priority modes), or it can let you do the whole thing yourself, mentioning how your settings compare to what it thinks you should do, but not acting on it (manual mode)."]
    let practice = ["", "Put your camera in aperture priority and find a good subject: it should be clearly separated from its background and neither too close nor too far away from you, something like 2-5m away from you and at least 10m away from the background. Take pictures of it at all the apertures you can find, taking notice of how the shutter speed is compensating for these changes. Make sure you are always focusing on the subject and never on the background.Back on your computer, see how depth of field changes with aperture. Also compare sharpness of an image at f/8 and one at f/22 (or whatever your smallest aperture was): zoomed in at 100%, the latter should be noticeably less sharp in the focused area.","The goal of this assignment is to determine your handheld limit. It will be quite simple: choose a well lit, static subject and put your camera in speed priority mode (if you don’t have one, you might need to play with exposure compensation and do some trial and error with the different modes to find how to access the different speeds). Put your camera at the wider end and take 3 photos at 1/focal equivalent, underexposed by 2 stops. Concretely, if you are shooting at 8mm on a camera with a crop factor of 2.5, you will be shooting at 1/20 – 2 stops, or 1/80 (it’s no big deal if you don’t have that exact speed, just pick the closest one). Now keep adding one stop of exposure and take three photos each time. It is important to not use the burst mode but pause between each shot. You are done when you reach a shutter speed of 1 second. Repeat the entire process for your longest focal length.Now download the images on your computer and look at them in 100% magnification. The first ones should be perfectly sharp and the last ones terribly blurred. Find the speed at which you go from most of the images sharp to most of the images blurred, and take note of how many stops over or under 1/focal equivalent this is: that’s your handheld limit.", "Find a well lit subject and shoot it at every ISO your camera offers, starting at the base ISO and ending up at 12,800 or whatever the highest ISO that your camera offers. Repeat the assignment with a 2 stops underexposure. Try repeating it with different settings of in-camera noise reduction (off, moderate and high are often offered).Now look at your images on the computer. Make notes of at the ISO at which you start noticing the noise, and at which ISO you find it unacceptably high. Also compare a clean, low ISO image with no noise reduction to a high ISO with heavy NR, and look for how well details and textures are conserved.", "Start by staying immobile and take a picture of the same subject at 5mm increments for the entire range of your lens (compact cameras users, just use the smallest zoom increments you can achieve). Now, remember the framing of your most zoomed in image, walk toward the subject and try to take the same image with the widest focal you have.Back on your computer, compare the last two images. Do they match exactly? What are the differences? Take the series of immobile pictures, reduce the size of the most zoomed in image and overlay it on top of the widest one. Does it match exactly?", ""]
    let demoInstructions = ["", "Play with the slider to see how aperture size affects the above photo", "", "", "", ""]
}
