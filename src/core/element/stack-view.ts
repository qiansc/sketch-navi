/** https://developer.apple.com/documentation/appkit/nsstackview?language=objc */

import { NSView } from "./ns-view";

export function create (option: StackViewOption) {
    const view: StackView = NSStackView.alloc().initWithFrame(NSMakeRect(0, 0, 20, 400));
    view.setSpacing(option.space || 8);
    view.setFlipped(true);
    view.setBackgroundColor(NSColor.windowBackgroundColor());
    view.orientation = option.orientation === undefined ? 0: option.orientation;

    return view;
}

export interface StackView extends NSView {
    orientation?: 0 | 1;
    /** 间距 */
    setSpacing: (split: number) => void;
    setFlipped: (flip: boolean) => void;
    setBackgroundColor: (color: Color) => void;
    addView_inGravity: (view: NSView, inGravityType: 0 | 1) => void;
}

interface StackViewOption {
    orientation?: 0 | 1;
    space?: number;
}
