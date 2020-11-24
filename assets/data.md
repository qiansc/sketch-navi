# excel表使用方法
### assets/table下存放excel，文件名就是业务线名，各个excel内的数据会合并
### bin/data-config.ts
该文件下配置规范（Spec）的枚举，配置excel内每列代表的字段，每列可单独写数据转换函数
### 生成json文件
运行npm run build 或 npm run load-data，会在assets/data/data.json内生成数据。可在spec-data.ts文件内自行使用里面的数据
