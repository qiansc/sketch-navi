// 此处添加规范的类型
export enum SPEC_ENUM {
    COLOR = 'color',
    MASK = 'mask',
    SHADOW = 'shadow',
    LINE = 'line',
}

function arrayHandler(data: string, refMap?: Record<string, unknown>, seperator: string | RegExp = /,|，/) {
    return data.toString().trim().split(seperator).map(item => item.trim());
}

function arrayRefHandler(
    handler: (item: string, refMap: Record<string, unknown>) => unknown,
    seperator: string | RegExp = /,|，/) {
    return function(data: string, refMap: Record<string, unknown>) {
        return data.toString().trim().split(seperator).map(item => {
            return handler(item.trim(), refMap);
        });
    }
}


// 此处定义每个规范，每一列代表的字段
export const DATA_CONFIG = {
    [SPEC_ENUM.COLOR]: {
        1: {
            key: 'code',
        },
        2: {
            key: 'light',
            transformer(item: string) {
                const data = arrayHandler(item);
                return {
                    color: data[0],
                    alpha: Number(data[1])
                };
            }
        },
        3: {
            key: 'night'
        },
        4: {
            key: 'dark'
        },
    },
    /** 蒙层 */
    [SPEC_ENUM.MASK]: {
        1: {
            key: 'code'
        },
        2: {
            key: 'cclass'
        },
        3: {
            key: 'direction',
            transformer(data: '上' | '下') {
                if (data === '上') {
                    return {
                        from: { x: 0.5, y: 0 },
                        to: { x: 0.5, y: 1 },
                    }
                }
                return {
                    from: { x: 0.5, y: 1 },
                    to: { x: 0.5, y: 0 },
                }
            },
        },
        4: {
            key: 'color',
            transformer: arrayRefHandler((data: string, refMap: Record<string, unknown>) => {
                const colorSpec: any =refMap[data];
                const { color, alpha } = colorSpec.light;
                return { color, alpha }
            }),
        },
        5: {
            key: 'stop',
            transformer: arrayHandler,
        },
        6: {
            key: 'height'
        },
        afterRow(row: any) {
            row = {
                ...row,
                from: row.direction.from,
                to: row.direction.to,
                size: 0,
            };
            delete row.direction;
            if (!row.stop) {
                row.stop = row.from.y > row.to.y ? [1 ,0] : [0, 1];
            }
            if (row.color.length === 1) {
                const newColor = {...row.color[0]};
                row.color = [newColor, newColor];
            }
            row.stops = [];
            row.color.forEach((item: any, index: number) => {
                row.stops[index] = {
                    color: item.color,
                    alpha: item.alpha,
                };
                row.stops[index].position = Number(row['stop'][index]);
            });
            if (row.height < 1) {
                row.from.y = 1;
                row.to.y = 1 * row.height;
            }
            delete row.height;
            delete row.color;
            delete row.stop;
            return row;
        }
    },
    [SPEC_ENUM.SHADOW]: {
        1: {
            key: 'code',
        },
        2: {
            key: 'cclass'
        },
        3: {
            key: 'ios',
            transformer(data: string) {
                const input = arrayHandler(data).map(x => Number(x));
                return {
                    x: input[0],
                    y: input[1],
                    spread: input[2],
                    size: input[3],
                }
            }
        },
        4: {
            key: 'android',
            transformer(data: string) {
                const input = arrayHandler(data).map(x => Number(x));
                return {
                    x: input[0],
                    y: input[1],
                    spread: input[2],
                    size: input[3],
                }
            }
        },
        5: {
            key: 'h5',
            transformer(data: string) {
                const input = arrayHandler(data).map(x => Number(x));
                return {
                    x: input[0],
                    y: input[1],
                    spread: input[2],
                    size: input[3],
                }
            }
        },
        6: {
            key: 'color',
            transformer(data: string, refMap: Record<string, any>) {
                const colorSpec: any =refMap[data];
                const { color, alpha } = colorSpec.light;
                return { color, alpha }
            },
        },
        afterRow(row: any) {
            row.opacity = row.color.alpha;
            row.color = row.color.color;
            return row;
        }
    },
    [SPEC_ENUM.LINE]: {
        1: {
            key: 'code'
        },
        2: {
            key: 'ios',
            transformer: (data: string) => Number(data)
        },
        3: {
            key: 'android',
            transformer: (data: string) => Number(data)
        },
        4: {
            key: 'h5',
            transformer: (data: string) => Number(data)
        },
        5: {
            key: 'cmeaning'
        },
    }
};

// 此处定义每个sheet代表的意义
export const SHEET_MAP: Record<string, SPEC_ENUM> = {
    'Color': SPEC_ENUM.COLOR,
    'Shadow': SPEC_ENUM.SHADOW,
    'Mask': SPEC_ENUM.MASK,
    'Line': SPEC_ENUM.LINE,
};
