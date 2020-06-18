import { SketchContext } from './core/sketch-context';
import { PanelFactory } from './core/panel-factory';
import { Panel } from './core/panel';

export function onToggle(context: any) {

    const contentView = context.document.documentWindow().contentView();
    const stageView = contentView.subviews().objectAtIndex(0);
    const sketchContext = SketchContext.getOrCreate(context);

    const panelFactory = new PanelFactory(sketchContext.documentID);

    panelFactory.regist('navi', Panel);

    let panel = panelFactory.hasPanel(Panel);
    if (panel){
        panel.removeFrom(stageView);
        /** 移除一些其他关联项目 */
        panel.shutdown(sketchContext.documentID);
        return;
    }
    panel = panelFactory.createPanel(Panel);
    panel.insertTo(stageView);

}
