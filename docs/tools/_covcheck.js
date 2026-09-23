// 覆盖率硬校验：源码参数 vs 手册参数表
const fs = require('fs'), vm = require('vm');
const ROOT = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/';
const info = {};
(function walk(d) {
  for (const e of fs.readdirSync(d, { withFileTypes: true })) {
    const p = d + '/' + e.name;
    if (e.isDirectory()) walk(p);
    else if (e.name.endsWith('.gml')) {
      const lines = fs.readFileSync(p, 'utf8').split(/\r?\n/);
      for (let i = 0; i < lines.length; i++) {
        const m = lines[i].match(/^(\s*)function\s+([A-Za-z_][A-Za-z0-9_]*)\s*\(([^)]*)\)/);
        if (!m) continue;
        const name = m[2], sig = m[3].trim();
        let hasArg = false;
        for (let j = i - 1; j >= 0; j--) {
          const L = lines[j].trim();
          if (L.startsWith('///@arg')) { hasArg = true; }
          else if (L.startsWith('///')) continue;
          else if (L === '') continue;
          else break;
        }
        const has = sig.length > 0 || hasArg;
        info[name] = (name in info) ? (info[name] || has) : has;
      }
    }
  }
})(ROOT + 'scripts');

const sb = { window: {}, document: {}, console }; vm.createContext(sb);
vm.runInContext(fs.readFileSync(ROOT + 'docs/manual-api.js', 'utf8'), sb);
const API = sb.window.API;
const out = [];
const noP = API.functions.filter(f => !f.p.length);
const wrong = noP.filter(f => info[f.n.trim().split('.').pop()] === true);
out.push('手册判定无参数: ' + noP.length + ' | 其中源码实际有参数: ' + wrong.length);
if (wrong.length) out.push('  ' + wrong.map(f => f.n).join(', '));
const noTable = API.functions.filter(f => !f.p.length).map(f => f.n.trim().split('.').pop());
out.push('');
out.push('手册带参数表: ' + API.functions.filter(f => f.p.length).length);
out.push('物体带变量表: ' + API.objects.filter(o => o.v && o.v.length).length + ' / ' + API.objects.length);
out.push('');
['Animator.SetKeyframe', 'Animator.DeleteKeyFrame', 'Animator.GetPattern'].forEach(n => {
  const e = API.functions.find(x => x.n === n);
  out.push(n + '  签名: ' + e.s);
  e.p.forEach(r => out.push('   - ' + r.join(' | ')));
});
fs.writeFileSync(ROOT + 'docs/tools/_covcheck.txt', out.join('\n'), 'utf8');
console.log('written');
