const fs = require('fs');
const path = require('path');
const vm = require('vm');
const root = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/scripts/';

// 收集所有脚本目录下的一级 .gml，取每个函数上方的 ///@arg 注释
const dirs = fs.readdirSync(root);
const results = [];

for (const d of dirs) {
  const p = path.join(root, d);
  if (!fs.statSync(p).isDirectory()) continue;
  const gmls = fs.readdirSync(p).filter(f => f.endsWith('.gml'));
  for (const g of gmls) {
    const src = fs.readFileSync(path.join(p, g), 'utf8');
    const lines = src.split(/\r?\n/);
    let pendingArgs = null;
    for (let i = 0; i < lines.length; i++) {
      const L = lines[i].trim();
      // 收集 ///@arg 注释块
      const m = L.match(/^\/\/\/\s*@arg\s+(.+)$/);
      if (m) {
        if (!pendingArgs) pendingArgs = [];
        pendingArgs.push(m[1].trim());
        continue;
      }
      const fm = L.match(/^function\s+([A-Za-z_][A-Za-z0-9_]*)\s*\(/);
      if (fm) {
        results.push({
          name: fm[1],
          file: d + '/' + g,
          args: pendingArgs ? pendingArgs.join(',') : null,
        });
        pendingArgs = null;
        continue;
      }
      // 非注释非空行会清空待定注释
      if (L && !L.startsWith('///') && !L.startsWith('//')) pendingArgs = null;
    }
  }
}

// 去重（同名函数可能多处定义）
const seen = new Map();
results.forEach(r => { if (!seen.has(r.name)) seen.set(r.name, r); });

const withArgs = [...seen.values()].filter(r => r.args);
const noArgs = [...seen.values()].filter(r => !r.args);

const out = [];
out.push('脚本里的函数总数(去重): ' + seen.size);
out.push('带 ///@arg 的参数信息: ' + withArgs.length);
out.push('无参数注释: ' + noArgs.length);
out.push('');
out.push('========== 带参数注释的函数（' + withArgs.length + '）==========');
withArgs.forEach(r => out.push(r.name + '  <=  ' + r.args));

fs.writeFileSync('C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/_srcargs.txt', out.join('\n'), 'utf8');
console.log('functions:', seen.size, 'withArgs:', withArgs.length);
