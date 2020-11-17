import { getSpecs } from './spec-data';
const framework = require('./framework/Navi.xcworkspace/contents.xcworkspacedata');
const MochaJSDelegate = require('mocha-js-delegate');
const NVApp = framework.getClass('NVApp');

export function onStart(context: any) {
    COScript.currentCOScript().setShouldKeepAround(true);
    NVApp.currentApp().toggle();
}
export function onOpenDocument(){
    COScript.currentCOScript().setShouldKeepAround(true);
    const app = NVApp.prepareInit();
    app.dataSource = new MochaJSDelegate({
        'updateSpec': () => {
            const path =  app.bundlePath();
            app.specs = getSpecs(path.substring(0, path.indexOf('/_webpack_resources')));
        },
    }).getClassInstance();
}

export function onSelectionChanged(context: any) {
    NVApp.currentApp().selectionChange();
    // var documentId = context.actionContext.document.hash().toString();
    // const threadDictionary = NSThread.mainThread().threadDictionary();
}

