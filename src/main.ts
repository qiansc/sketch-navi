import { SketchContext } from './utils/sketch-context';
import { MenuController, MENU_EVENT, MenuOption } from './components/menu.controller';
import { PanelController, PANEL_EVENT } from './components/panel.controller';

export function onStart(context: any) {
    if(!SketchContext.hasDocument(context)) {
        return;
    }

    COScript.currentCOScript().setShouldKeepAround(true);

    const ctx = new SketchContext(context);
    const threadDictionary = NSThread.mainThread().threadDictionary();

    // 从内存中恢复 因为每次插件调用onStart都是重新执行
    let runtime: Runtime = threadDictionary[`${ctx.documentId}-navi-runtime`];

    if (!runtime) {
        // 创建并写入内存
        runtime = threadDictionary[`${ctx.documentId}-navi-runtime`] = getRuntime(ctx);
    }

    runtime.menuController.toogle();

}

interface Runtime {
    menuController: MenuController;
    panelController: PanelController;
}

function getRuntime(ctx: SketchContext) {
    const menuController = new MenuController(ctx);
    const panelController = new PanelController(ctx);

    // 下面开始把不同controller的事件和处理过程串联起来

    menuController.on(MENU_EVENT.CLOSE_MAIN, (option: MenuOption, target: any) => {
        panelController.hide();
    });

    menuController.on(MENU_EVENT.OPEN_MAIN, (option: MenuOption, target: any) => {
        target.state() ? panelController.show() : panelController.hide();
    });

    menuController.on(MENU_EVENT.OPEN_PANEL, (option: MenuOption, target: any) => {
        // 全部按钮点击时展开面板
        // target.state() ? panelController.show() : panelController.hide();
    });

    menuController.on(MENU_EVENT.WIIL_LAYOUT, (option: MenuOption, target: any) => {
        // 避免Menu rezise导致panel大小auto resize
        panelController.lockSize();
    });

    panelController.on(PANEL_EVENT.CLOSE_WINDOW, () => menuController.setMainButtonState(0));
    panelController.on(PANEL_EVENT.SHOW_PANEL, () => menuController.setMainButtonState(1));

    // panelController.on(PANEL_EVENT.COLOR_CHANGE, (colorCode: string) => changeColor(colorCode));


    return {
        menuController,
        panelController,
    };
}

export function onSelectionChanged(context: any) {

    var document = require('sketch/dom').getSelectedDocument();
    var documentId = context.actionContext.document.hash().toString();
    const threadDictionary = NSThread.mainThread().threadDictionary();
    let runtime: Runtime = threadDictionary[`${documentId}-navi-runtime`];
    if (runtime) {
        runtime.panelController.selectionChange();
        if(document.selectedLayers && document.selectedLayers.layers && document.selectedLayers.layers[0]) {
            // console.log(document.selectedLayers.layers[0]);
            const info =  document.selectedLayers.layers[0].sketchObject.userInfo();
            if (info && info['Navi']) {
                // console.log(info['Navi']['style']);
            }


        }

    }
}


/** 以下代码是颜色测试代码 */

// function  changeColor(colorCode: string) {
//     var document = require('sketch/dom').getSelectedDocument();
//     var selection = document.selectedLayers.layers;
//     if (selection[0]) {
//         selection[0].style.fills[0].color = `#${color[colorCode]}`;
//         try {
//             selection[0].sketchObject.userInfo = {
//                 'com.baidu.Navi': {style: {fills:[{colorCode: colorCode}]}}
//             }
//             // console.log('jsondata', jsonData);
//             // console.log( '___>', selection[0].sketchObject.userInfo());
//         }catch(err) {
//             console.log(err);
//         }
//     }
// }

// const color: {[index: string]: string} = {
//     "SAM_001": "4C4BF3FF",
//     "SAM_002": "4E6EF2FF",
//     "SAM_003": "D089FFFF",
//     "SAM_004": "CFC0FFFF",
//     "SAM_005": "CBF8FFFF",
//     "SAM_006": "FBE98AFF",
//     "SAM_007": "4C4BDDFF",
//     "SAM_008": "4E6EFFFF",
// };
/** 以上代码是颜色测试代码 */

// fills:
// [ Fill {
//     fillType: 'Color',
//     color: '#d8d8d8ff',
//     gradient: [Gradient],
//     pattern: [Object],
//     enabled: true } ],
// borders:
// [ Border {
//     fillType: 'Color',
//     position: 'Inside',
//     color: '#979797ff',
//     gradient: [Gradient],
//     thickness: 1,
//     enabled: true } ],
