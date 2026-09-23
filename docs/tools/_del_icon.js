// 删除 manual-api.js 分类里的 icon 字段（16 个 emoji，手册从未渲染的死数据）
const fs = require('fs');
const vm = require('vm');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_del_icon.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };

const p = BASE + 'manual-api.js';
const tmpBak = BASE + '_tmp-manual-api.js';
fs.copyFileSync(p, tmpBak);
out('临时备份: _tmp-manual-api.js');

const raw = fs.readFileSync(p, { encoding: 'utf8' });
const m = raw.match(/^window\.API = ([\s\S]*);\s*$/);
if (!m) die('文件不是 window.API = {...}; 结构，中止');
const obj = JSON.parse(m[1]);   // 能 parse = 纯 JSON 体，stringify 回写无损
if (!obj.categories || obj.categories.length !== 16) die('categories 数量 != 16，中止');
const before = obj.functions.length;

let n = 0;
for (const c of obj.categories) {
  if ('icon' in c) { delete c.icon; n++; }
}
if (n !== 16) die('删除的 icon 数量 != 16（实际 ' + n + '），中止');
if (obj.functions.length !== before) die('functions 被意外改动，中止');
if (obj.categories.some(c => 'icon' in c)) die('仍有 icon 残留，中止');
out('已删除 ' + n + " 个分类的 icon 字段（其他字段不动）");

// 回写（保持 window.API = {...}; 格式与 3 空格缩进）
fs.writeFileSync(p, 'window.API = ' + JSON.stringify(obj, null, 3) + ';\n', { encoding: 'utf8' });

// vm 重载验证 + 对比（除 icon 外深度一致）
const after = fs.readFileSync(p, { encoding: 'utf8' });
const sb = { window: {} };
vm.createContext(sb);
vm.runInContext(after, sb);
const API2 = sb.window.API;
if (!API2 || API2.functions.length !== before || API2.categories.length !== 16) die('回写后数据异常，中止');
const orig = JSON.parse(m[1]);
for (let i = 0; i < 16; i++) {
  const a = { ...orig.categories[i] }, b = { ...API2.categories[i] };
  delete a.icon;
  if (JSON.stringify(a) !== JSON.stringify(b)) die('分类 ' + i + ' 除 icon 外字段有差异，中止');
}
out('vm 重载验证通过：16 分类除 icon 外逐字段一致，functions ' + before + ' 条不变');

fs.unlinkSync(tmpBak);
out('临时备份已删除');
out('ALL OK');
fs.writeFileSync(BASE + 'tools/_del_icon.txt', LOG.join('\n'), { encoding: 'utf8' });
