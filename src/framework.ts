export const framework = require('./framework/Navi.xcworkspace/contents.xcworkspacedata');

export function MenuNib() {
    return framework.getNib('Menu');
}

export function MenuBtn() {
    return framework.getNib('MenuBtn');
}
