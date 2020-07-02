export interface NSView {
    identifier: (() => string) | string;
    addView: (view:NSView) => void;
}
