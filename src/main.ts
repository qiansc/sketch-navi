import { SketchContext } from './core/sketch-context';
import { PanelFactory } from './core/panel-factory';
import { Panel } from './core/panel';

export function onToggle(context: any) {

    const sketchContext = SketchContext.getOrCreate(context);
    const stageView = sketchContext.stageView;

    const panelFactory = new PanelFactory(sketchContext.documentID);
    panelFactory.regist('navi', Panel);
    let panel = panelFactory.hasPanel(Panel);

    if (panel){
        stageView.removePanel(panel);
        stageView.shutdownPanel(panel);
        /** 移除一些其他关联项目 */
        return;
    }
    panel = panelFactory.createPanel(Panel);
    stageView.insertPanel(panel);

}
