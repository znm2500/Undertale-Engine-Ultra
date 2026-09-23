// 把 objects 里 7 个「合并写法」条目拆成独立条目
// 注意：必须在 _upgrade.js + _objupgrade.js 之后运行
const fs = require('fs');
const vm = require('vm');
const path = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const log = (...a) => LOG.push(a.join(' '));

const NEW = require('./_splitobjs.js');

const apiSrc = fs.readFileSync(path + 'manual-api.js', 'utf8');
const sandbox = { console };
sandbox.window = sandbox;
vm.createContext(sandbox);
vm.runInContext(apiSrc, sandbox);
const API = sandbox.API;

// 找出所有合并条目（名字里带 /）
const mergedIdx = [];
API.objects.forEach((o, i) => { if (o.n.includes('/')) mergedIdx.push(i); });
log('拆分前：' + API.objects.length + ' 条，其中合并条目 ' + mergedIdx.length + ' 个');

// 记录合并条目覆盖了哪些「第一个名字」，方便校验替换完整性
const replacedHeads = mergedIdx.map(i => API.objects[i].n.split('/')[0].trim());
log('被替换的合并条目首名：' + replacedHeads.join(', '));

// 新条目里应当完全覆盖这些首名
const newHeads = new Set(NEW.map(o => o.n));
const notCovered = replacedHeads.filter(h => !newHeads.has(h));
if (notCovered.length) {
  log('⚠ 以下合并条目的首名在新列表中缺失：' + notCovered.join(', '));
  fs.writeFileSync(path + '_split-report.txt', LOG.join('\n'), 'utf8');
  throw new Error('拆分不完整，已中止，未修改文件');
}

// 移除合并条目（从后往前删，避免索引错位）
for (let k = mergedIdx.length - 1; k >= 0; k--) API.objects.splice(mergedIdx[k], 1);
log('移除合并条目后剩余：' + API.objects.length + ' 条');

// 剔除空表：新列表里可能与「原本就独立存在的条目」重名（如 char_save），
// 这些旧条目由 _objdict.js 提供变量表，我们用新版本覆盖，避免出现重复条目
const newNames = new Set(NEW.map(o => o.n));
const dupIdx = [];
API.objects.forEach((o, i) => { if (newNames.has(o.n)) dupIdx.push(i); });
if (dupIdx.length) {
  log('发现重名旧条目，将被新版覆盖：' + dupIdx.map(i => API.objects[i].n).join(', '));
  for (let k = dupIdx.length - 1; k >= 0; k--) API.objects.splice(dupIdx[k], 1);
}

// 追加新条目
NEW.forEach(o => {
  const entry = { g: o.g, n: o.n, t: o.t };
  if (o.hot) entry.hot = true;
  entry.d = o.d;
  if (o.v) entry.v = o.v;
  if (o.rel) entry.rel = o.rel;
  API.objects.push(entry);
});

log('追加独立条目 ' + NEW.length + ' 个 → 共 ' + API.objects.length + ' 条');

// 校验：每个条目都必须有 g / n / t / d
let bad = 0;
API.objects.forEach(o => {
  if (!o.g || !o.n || !o.t || !o.d) { bad++; log('⚠ 字段不全：' + JSON.stringify(o.n)); }
  if (o.d && o.d.trim().length < 29) log('⚠ 描述过短：' + o.n + ' (' + o.d.trim().length + ' 字)');
});
log('字段不全条目：' + bad);

// 校验：不允许出现重复条目名
const nameCount = {};
API.objects.forEach(o => { nameCount[o.n] = (nameCount[o.n] || 0) + 1; });
const dups = Object.entries(nameCount).filter(([, c]) => c > 1);
if (dups.length) {
  log('⚠ 重复条目：' + dups.map(([n, c]) => n + '×' + c).join(', '));
  fs.writeFileSync(path + '_split-report.txt', LOG.join('\n'), 'utf8');
  throw new Error('存在重复条目，已中止');
}
log('重复条目：0');

// 分组计数校验
const grpIds = new Set(API.objectsGroups.map(g => g.id));
API.objects.forEach(o => { if (!grpIds.has(o.g)) log('⚠ 未知分组：' + o.n + ' -> ' + o.g); });

// 回写
const header = '/* eslint-disable */\n// Undertale-Engine-Ultra 手册数据 · 自动生成 + 手工维护\n// 结构见 _TODO.md\n';
fs.writeFileSync(path + 'manual-api.js', header + 'window.API = ' + JSON.stringify(API, null, 1) + ';\n', { encoding: 'utf8' });
fs.writeFileSync(path + '_split-report.txt', LOG.join('\n'), 'utf8');
console.log('done. objects =', API.objects.length);
