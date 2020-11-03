const { existsSync, readFileSync } = require("@skpm/fs");

export class SpecData {
    constructor(private assetsPath: string) {
        // console.log(assetsPath);
    }
    getColorSpec() {
        let file = `/data/color-baiduboxapp-FC.json`;
        let json: any = {};
        let arr: any[] = [];
        let exist: any = {};
        if (existsSync(`${this.assetsPath}${file}`)) {
            const text = readFileSync(`${this.assetsPath}${file}`).toString();
            json =  JSON.parse(text);
        } else {
            const text = readFileSync(`${this.assetsPath}/example${file}`).toString();
            json =  JSON.parse(text);
        }
        json.data.forEach((item: any) => {
            let spec = item;
            if (exist[spec.cnum]) {
                return;
            }
            spec.dim = [item.cclass, item.cmeaning];

            if (item.cmeaning.indexOf('边') > -1 || item.cclass.indexOf('边') > -1 || item.cmeaning.indexOf('线') > -1 || item.cclass.indexOf('线') > -1) {
                spec.borderMode = true;
                spec.fillMode = false;
            } else {
                spec.borderMode = false;
                spec.fillMode = true;
            }
            if (item.cmeaning.indexOf('字') > -1 || item.cclass.indexOf('字') > -1) {
                spec.shapeMode = 'Text';
                spec.borderMode = false;
                spec.fillMode = true;
            } else {
                spec.shapeMode = 'Others';
            }
            exist[spec.cnum] = true;
            arr.push(spec);
        });
        return arr;
    }
    getTextSpec() {
        let file = `/data/spec-baiduboxapp.json`;
        let json: any = {};
        let arr: any[] = [];
        let exist: any = {};
        if (existsSync(`${this.assetsPath}${file}`)) {
            const text = readFileSync(`${this.assetsPath}${file}`).toString();
            json =  JSON.parse(text);
        } else {
            const text = readFileSync(`${this.assetsPath}/example${file}`).toString();
            json =  JSON.parse(text);
        }
        json.data.forEach((item: any) => {
            let spec = item;
            if (exist[spec.code] || spec.cline !=="FEED") {
                return;
            }
            if (!spec.code || spec.code.indexOf('F_Txt') !== 0) {
                return;
            }
            spec.dim = [item.cclass, item.cmeaning];
            exist[spec.code] = true;
            arr.push(spec);
        });
        return arr;
    }
    getBorderSpec() {
        let file = `/data/spec-baiduboxapp.json`;
        let json: any = {};
        let arr: any[] = [];
        let exist: any = {};
        if (existsSync(`${this.assetsPath}${file}`)) {
            const text = readFileSync(`${this.assetsPath}${file}`).toString();
            json =  JSON.parse(text);
        } else {
            const text = readFileSync(`${this.assetsPath}/example${file}`).toString();
            json =  JSON.parse(text);
        }
        json.data.forEach((item: any) => {
            let spec = item;
            if (exist[spec.code]) {
                return;
            }
            if (!spec.code || spec.code.indexOf('S_J') !== 0) {
                return;
            }
            spec.dim = [item.cclass, item.cmeaning];
            exist[spec.code] = true;
            arr.push(spec);
        });
        return arr;
    }
}
