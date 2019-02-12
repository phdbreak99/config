from Quartz.CoreGraphics import *

our_event = CGEventCreate(None);
current_pos = CGEventGetLocation(our_event);             # Save current mouse position
mouseEvent(kCGEventLeftMouseDown, int(current_pos.x), int(current_pos.y));
