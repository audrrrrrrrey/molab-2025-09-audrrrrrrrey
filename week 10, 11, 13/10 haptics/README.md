## bubble bounce
12/5/25

after feeling overwhelmed by the nebulous documentation that exists for arkit, i decided to forget ar for the final project and shift my attention to haptics. i had always planned to use haptics in my final project, but they were originally going to be just the fun thing i sprinkled on at the end. however, given that i was excited about trying them, and not so excited about the ar documentation that seemed to only take the form of ai-voiceovered videos and outdated swift frameworks, i decided to make them the main thing i toyed with until something interesting emerged.

haptics are interesting to me because they are native to apple and super tactile. i've been interested in touch interactions lately and creating games that are more like toys than being goal-oriented, so this seemed like a perfect opportunity to dive into those things.

the first week, i created three buttons that linked to three different functions. the first returned the built-in "error" haptic. the second two were custom haptics using the core haptics library, which gives you full control over each haptic's feel and duration.

the second week, i tested out different gestures -- tapping, pressing, pinching, rotating, and dragging -- in the same vein.

for the final app, i created a ball-bouncing toy that employs the iphone's accelerometer, physics, draw functions, gestures, and haptics. the ball can be interacted with by tilting the phone to make it move, dragged, and pinched to enlarge or shrink it. it can also collide with four walls no matter the size. finally, each of these gestures is mapped to haptics feedback to make it feel tactile.

overall, i imagine the app being used as a sort of sensory toy, something mesmerizing to play with, something to relieve boredom. learning swift was a challenge for me, but i'm satisfied with what i was able to make with limited time. 

here is a full list of references:
- https://www.hackingwithswift.com/books/ios-swiftui/adding-haptic-effects for an intro to haptics
- https://www.hackingwithswift.com/books/ios-swiftui/how-to-use-gestures-in-swiftui for an intro to gestures
- https://www.hackingwithswift.com/forums/swiftui/playing-sound/4921 for sound
- built off existing code from https://github.com/NDCSwift/SensorExample/blob/main/SensorExample/ContentView.swift for motionmanager
- https://github.com/molab-itp/05-BubbleLevel as a reference for motionmanager
- apple docs for looking up syntax and features
- chatgpt as a helper for physics, some shapes drawing, some errors

by audrrrrrrrey
