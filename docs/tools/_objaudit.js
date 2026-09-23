// 物体「内容深度」审计：真实变量集合 vs 手册变量表
// 输出 docs/tools/_objaudit.txt
const fs = require('fs'), vm = require('vm');
const ROOT = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/';

// ---- 1. 源码侧：直接读精确提取结果（排除 enum / 方法 / 局部 var）----
const OBJVARS = JSON.parse(fs.readFileSync(ROOT + 'docs/tools/_objvars.json', 'utf8'));
function realVars(objName) {
  return (OBJVARS[objName] || []).map(x => x.n);
}

// ---- 2. 手册侧 ----
const sb = { window: {}, document: {}, console }; vm.createContext(sb);
vm.runInContext(fs.readFileSync(ROOT + 'docs/manual-api.js', 'utf8'), sb);
const API = sb.window.API;

const out = [];
const gaps = [];
for (const o of API.objects) {
  const dir = ROOT + 'objects/' + o.n;
  if (!fs.existsSync(dir)) { out.push('!! 目录缺失: ' + o.n); continue; }
  const rv = realVars(o.n);
  const docNames = new Set((o.v || []).map(r => String(r[0]).trim()));

  const missing = rv.filter(k => !docNames.has(k));
  const dlen = (o.d || '').trim().length;
  const evs = fs.readdirSync(dir).filter(f => /^(Create|Step|Draw|Other|Alarm|CleanUp|Destroy)/.test(f) && f.endsWith('.gml'));

  // 变量表覆盖率
  const cov = rv.length ? (rv.length - missing.length) / rv.length : 1;
  // 事件代码总行数（体量指标）
  let lines = 0;
  for (const f of evs) lines += fs.readFileSync(dir + '/' + f, 'utf8').split(/\r?\n/).length;

  gaps.push({ n: o.n, g: o.g, srcVars: rv.length, docVars: docNames.size, missing, cov, dlen, evs: evs.length, lines, hot: !!o.hot });
}

// 按「未被文档覆盖的变量数」排序
gaps.sort((a, b) => b.missing.length - a.missing.length || b.lines - a.lines);

out.push('=== 物体内容深度审计（按未覆盖变量数排序）===');
out.push('物体 | 分组 | 源码变量 | 表行 | 覆盖率 | 介绍字 | 事件数 | 代码行 | 未覆盖变量');
out.push('');
for (const g of gaps) {
  out.push([
    g.n.padEnd(30), g.g.padEnd(8),
    String(g.srcVars).padStart(4), String(g.docVars).padStart(4),
    (g.cov * 100).toFixed(0).padStart(4) + '%',
    String(g.dlen).padStart(5), String(g.evs).padStart(4), String(g.lines).padStart(5),
    g.missing.length ? '  ' + g.missing.slice(0, 14).join(', ') + (g.missing.length > 14 ? ' …' : '') : '  (全)'
  ].join(' '));
}

const bad = gaps.filter(g => g.missing.length > 0);
out.push('');
out.push('=== 汇总 ===');
out.push('物体总数: ' + gaps.length);
out.push('变量表未完全覆盖的物体: ' + bad.length);
out.push('未覆盖变量总数: ' + bad.reduce((s, g) => s + g.missing.length, 0));
out.push('');
out.push('=== 未覆盖变量 >= 5 个的物体（优先补）===');
bad.filter(g => g.missing.length >= 5).forEach(g => {
  out.push(g.n + ' [' + g.g + '] 未覆盖 ' + g.missing.length + '/' + g.srcVars + '（介绍 ' + g.dlen + ' 字）');
  out.push('    ' + g.missing.join(', '));
});

fs.writeFileSync(ROOT + 'docs/tools/_objaudit.txt', out.join('\n'), 'utf8');
console.log('written; 未完全覆盖的物体 ' + bad.length + ' / ' + gaps.length);
