// 按用户要求：删掉侧栏示例分组里的「分级浏览」入口项（data-exlv="all"）
// 保留：侧栏「全部」列表入口（data-exid）、各分级项（data-exlv=入门/进阶/...）、正文筛选栏、分级分段渲染
const fs = require('fs');

const DOCS = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const HTML = DOCS + 'index.html';
const LOGP = DOCS + 'tools/_side_exlv.txt';

const lines = [];
function log(x) { lines.push(x); console.log(x); }

// ---------- 0. 备份 ----------
fs.copyFileSync(HTML, DOCS + '_bak11-index.html');
log('备份完成: _bak11-...html');

// ---------- 1. 精确删除该行 ----------
let html = fs.readFileSync(HTML, 'utf8');
const ROW = `      h+='<div class="item'+(curExLv==='all'?'':' on')+'" data-exlv="all">分级浏览</div>';\n`;
const first = html.indexOf(ROW);
if (first < 0) throw new Error('「分级浏览」行未找到');
if (html.indexOf(ROW, first + 1) >= 0) throw new Error('「分级浏览」行不止一处，拒绝盲删');
html = html.replace(ROW, '');
fs.writeFileSync(HTML, html, { encoding: 'utf8' });
log('侧栏「分级浏览」入口项已删除');

// ---------- 2. 重读断言 ----------
const html2 = fs.readFileSync(HTML, 'utf8');
if (html2.includes('分级浏览')) throw new Error('「分级浏览」残留');
if (!html2.includes('data-exlv')) throw new Error('data-exlv 分级项误伤（EX_LEVELS 侧栏项丢失）');
if (!html2.includes(`querySelectorAll('[data-exlv]')`)) throw new Error('data-exlv 点击绑定误伤');
if (!html2.includes(`data-exid="all">全部`)) throw new Error('侧栏「全部」列表入口误伤');
if (!html2.includes(`onclick="pickExLv(\\'all\\')"`)) throw new Error('正文筛选栏「全部」chip 误伤');
log('重读断言通过: 只删了侧栏「分级浏览」一项，分级筛选功能完好');
log('ALL OK');
fs.writeFileSync(LOGP, lines.join('\n'), { encoding: 'utf8' });
