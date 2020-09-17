
/**
  * 通过代理在viewWillLayout时触发的时机，限制用户resize splitView面板
  * splitView面板是sketch创建的，其splitViewController[NSSplitViewInstance.delegate()]控制策略，但是我们没有办法修改这个类的策略
  * 所以通过重绘时机,根据slider下个面板的起始位置-40来固定宽度
  *
  * 需要锁定的NSView需要实现 src/framework/Navi/Navi/MenuProtocol.h 的代理接口
  * 同时其NSViewController需要在viewWillLayout调用代理接口方法
*/
const MochaJSDelegate = require('mocha-js-delegate');

export function makeDisableResizeDelegate(NSSplitViewInstance: any, subview: any) {
    return new MochaJSDelegate({
        'viewWillLayoutSize:': (newSize: any) => {
            try{
                let index = -1;
                const views = NSSplitViewInstance.subviews();
                for (let i = 0; i < views.count(); i++) {
                    if (''.concat(views[i].identifier()) ===
                        ''.concat(subview.identifier())) {
                        index = i;
                    }
                }
                if (index > 0 && NSSplitViewInstance.subviews()[index+1]) {
                    const nextWidth = NSSplitViewInstance.subviews()[index+1].frame().size.width;
                    const nextPos = NSSplitViewInstance.maxPossiblePositionOfDividerAtIndex(index);
                    NSSplitViewInstance.setPosition_ofDividerAtIndex(nextPos - nextWidth - 40, index - 1);
                }
            }catch(e) {
                console.log(e);
            }
        }
    }).getClassInstance();
}


