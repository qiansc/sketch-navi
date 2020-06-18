import { Panel } from "./panel";

export class PanelFactory{
    private map = new Map();
    constructor(private documentID: string) {

    }

    regist(key: string, panelClass: typeof Panel) {
        this.map.set(panelClass, key);
    }

    hasPanel(panelClass: typeof Panel) {
        const key = this.map.get(panelClass);
        const id = this.getId(key);
        const threadDictionary = NSThread.mainThread().threadDictionary();
        const view = threadDictionary[id];
        if (view) {
            const panel = new Panel(
                id,
                this.getIDPrefix(key)
            );
            panel.setView(view);
            return panel;
        } else {
            return;
        }
    }

    createPanel(panelClass: typeof Panel) {
        const key = this.map.get(panelClass);
        const panel = new Panel(
            this.getId(key),
            this.getIDPrefix(key)
        );
        panel.createView();
        return panel;
    }

    getIDPrefix(key: string) {
        return this.documentID ? `sketch-plugin-${key}-${this.documentID}` : `sketch-plugin-${key}`;
    }

    getId(key: string){
        const IDPrefix = this.getIDPrefix(key);
        return `${IDPrefix}-panel`;
    }


}
