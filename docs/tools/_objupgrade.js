// 给 objects 补 v（变量表）与 rel（关联表）字段
const fs = require('fs');
const vm = require('vm');
const path = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const log = (...a) => LOG.push(a.join(' '));

const DICT = require('./_objdict.js');

const apiSrc = fs.readFileSync(path + 'manual-api.js', 'utf8');
const sandbox = { console };
sandbox.window = sandbox;
vm.createContext(sandbox);
vm.runInContext(apiSrc, sandbox);
const API = sandbox.API;

// 条目的 n 可能是 "a / b / c"，取首个名字匹配字典
function headName(n) {
  return String(n).split('/')[0].trim();
}

let vAdded = 0, relAdded = 0;
const missing = [];

API.objects.forEach(o => {
  const key = headName(o.n);
  const hit = DICT[key];
  if (!hit) { missing.push(o.n); }
  if (hit && hit.v && !o.v) { o.v = hit.v; vAdded++; log('v  ' + o.n + ' -> ' + hit.v.length + ' 行'); }
  if (hit && hit.rel && !o.rel) { o.rel = hit.rel; relAdded++; log('rel ' + o.n + ' -> ' + hit.rel.length + ' 组'); }
});

log('');
log('补 v: ' + vAdded + ' 条 | 补 rel: ' + relAdded + ' 条');
log('未覆盖字典的物体（' + missing.length + '）:');
missing.forEach(m => log('  ' + m));

// 回写
const header = '/* eslint-disable */\n// Undertale-Engine-Ultra 手册数据 · 自动生成 + 手工维护\n// 结构见 _TODO.md\n';
const body = 'window.API = ' + JSON.stringify(API, null, 1) + ';\n';
fs.writeFileSync(path + '_objupgrade-report.txt', LOG.join('\n'), 'utf8');
fs.writeFileSync(path + 'manual-api.js', header + body, { encoding: 'utf8' });

console.log('v', vAdded, 'rel', relAdded, 'missing', missing.length);
