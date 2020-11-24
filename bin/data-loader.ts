import * as path from 'path';
import * as fs from 'fs';

import { Workbook } from 'exceljs';
import { SHEET_MAP, DATA_CONFIG } from './data-config';

const ASSETS_PATH = path.join(__dirname, '..', 'assets');
const DATA_SOURCE_PATH = path.join(ASSETS_PATH, 'table');
const OUTPUT_PATH = path.join(ASSETS_PATH, 'data', 'data.json');
const DEMO_PATH = path.join(ASSETS_PATH, 'example/data', 'demo.xlsx');

const workbook = new Workbook();

const globalMap: Record<string, any> = {};

async function loadDataFromTable(input: string, cline: string) {
    return await workbook.xlsx.readFile(input).then((workbook) => {
        const result: Record<string, any> = {};
        workbook.eachSheet((s) => {
            // 如果对应的sheet name有config
            const specKey = SHEET_MAP[s.name.split('-')[0]];
            if (specKey) {
                const specConfig: Record<string, any> = DATA_CONFIG[specKey];
                const sheetData: Array<any> = [];
                s.eachRow((row, rowNumber) => {
                    // 从第二列开始读数据
                    if (rowNumber > 1) {
                        let newRow: Record<string, any> = { cline };
                        row.eachCell(((cell, cellNumber) => {
                            const specConfigItem = specConfig[cellNumber];
                            if (specConfigItem) {
                                if (typeof specConfigItem.transformer === 'function') {
                                    newRow[specConfigItem.key] = specConfigItem.transformer(cell.value, globalMap);
                                } else {
                                    newRow[specConfigItem.key] = cell.value;
                                }
                            }
                        }));
                        if (specConfig.afterRow) {
                            newRow = specConfig.afterRow(newRow);
                        }
                        newRow.rowNumber = rowNumber;
                        sheetData.push(newRow);
                        globalMap[newRow.code] = newRow;
                    }
                });
                result[specKey] = sheetData;
            }
        });
        return result;
    });
}

function mockData() {
    if (!fs.existsSync(DATA_SOURCE_PATH)) {
        fs.mkdirSync(DATA_SOURCE_PATH, { recursive: true });
    }
    const files = fs.readdirSync(DATA_SOURCE_PATH);
    if (!files || files.length === 0) {
        fs.writeFileSync(path.join(
            DATA_SOURCE_PATH, 'demo.xlsx'),
            fs.readFileSync(DEMO_PATH),
            { flag: 'wx+'}
        );
    }
}

async function loadData() {
    mockData();
    const result: Record<string, any> = {};
    const allData = fs.readdirSync(DATA_SOURCE_PATH).map(file => {
        const fileName = file.split('.')[0];
        const input = path.join(DATA_SOURCE_PATH, file);
        return loadDataFromTable(input, fileName);
    });
    await Promise.all(allData).then(datalist => {
        datalist.forEach((tableData: any) => {
            Object.keys(tableData).forEach(key => {
                if (result[key]) {
                    result[key] = result[key].concat(tableData[key]);
                } else {
                    result[key] = tableData[key];
                }
            });
        });
    })

    fs.rmSync(OUTPUT_PATH, { force: true });
    fs.writeFileSync(OUTPUT_PATH, JSON.stringify(result), { flag: 'wx+'});
}

loadData();
