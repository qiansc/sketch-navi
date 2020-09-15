import { SketchContext } from "../utils/sketch-context";
import * as framework from '../framework';
import { createButton, createImageView, createBoxSeparator } from './element';


/** 插件面板区 */
export class PanelController {
    public id: string;
    public view: any;
    private nib: any;
    constructor(private ctx: SketchContext) {
        this.id = `${ctx.documentID}-navi-tools-panel`;
        this.nib = framework.MenuNib();
        this.view = this.nib.getRoot();
        this.view.identifier = this.id;
    }
}
