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
    let runtime: Runtime = threadDictionary[`${ctx.documentID}-navi-runtime`];

    if (!runtime) {
        // 创建并写入内存
        runtime = threadDictionary[`${ctx.documentID}-navi-runtime`] = getRuntime(ctx);
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

    menuController.on(MENU_EVENT.MAIN_CLOSE, (option: MenuOption, target: any) => {
        panelController.hide();
    });

    menuController.on(MENU_EVENT.MAIN_CLICK, (option: MenuOption, target: any) => {
        target.state() ? panelController.show() : panelController.hide();
    });

    menuController.on(MENU_EVENT.PANEL_CLICK, (option: MenuOption, target: any) => {
        // 全部按钮点击时展开面板
        // target.state() ? panelController.show() : panelController.hide();
    });

    menuController.on(MENU_EVENT.WIIL_LAYOUT, (option: MenuOption, target: any) => {
        // 避免Menu rezise导致panel大小auto resize
        panelController.lockSize();
    });

    panelController.on(PANEL_EVENT.WINDOW_CLOSE, () => menuController.setMainButtonState(0));
    panelController.on(PANEL_EVENT.PANEL_SHOW, () => menuController.setMainButtonState(1));

    // panelController.on(PANEL_EVENT.COLOR_CHANGE, (colorCode: string) => changeColor(colorCode));


    return {
        menuController,
        panelController,
    };
}


/** 以下代码是颜色测试代码 */

function  changeColor(colorCode: string) {
    var document = require('sketch/dom').getSelectedDocument();
    var selection = document.selectedLayers.layers;
    if (selection[0]) {
        selection[0].style.fills[0].color = `#${color[colorCode]}`;
        try {
            selection[0].sketchObject.userInfo = {
                'com.baidu.Navi': {style: {fills:[{colorCode: colorCode}]}}
            }
            // console.log('jsondata', jsonData);
            // console.log( '___>', selection[0].sketchObject.userInfo());
        }catch(err) {
            console.log(err);
        }
    }
}

export function onSelectionChanged(context: any) {

    var document = require('sketch/dom').getSelectedDocument();
    var selection = document.selectedLayers.layers;
    var command = context.command;


    const threadDictionary = NSThread.mainThread().threadDictionary();
    let runtime: Runtime = threadDictionary[`${document.id}-navi-runtime`];

    if (runtime && selection && selection[0]) {
        // console.log(selection[0].style.id, selection[0].style.fills[0].color);

        // var layerData = selection[0].sketchObject.userInfo();

        // if (layerData) {
        //     const colorCode = layerData['com.baidu.Navi'].style.fills[0].colorCode; // 选中颜色的编码
        //     selection[0].style.fills[0].color = `#${color[colorCode]}`; // 修复颜色
        //     runtime.panelController.colorController.select(colorCode);
        // } else {
        //     runtime.panelController.colorController.reset();
        //     runtime.panelController.sectionInfo.setTitle(selection[0].style.fills[0].color);
        // }

    }

}

const color: {[index: string]: string} = {
    "SAM_001": "4C4BF3FF",
    "SAM_002": "4E6EF2FF",
    "SAM_003": "D089FFFF",
    "SAM_004": "CFC0FFFF",
    "SAM_005": "CBF8FFFF",
    "SAM_006": "FBE98AFF",
    "SAM_007": "4C4BDDFF",
    "SAM_008": "4E6EFFFF",
};
/** 以上代码是颜色测试代码 */
