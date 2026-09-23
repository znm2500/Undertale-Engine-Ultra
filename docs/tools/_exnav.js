// 侧栏逐篇定位：buildNav 示例分支加逐篇标题项 + .exitem 子级样式 + 校验断言
const fs = require('fs');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_exnav.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

const htmlPath = BASE + 'UNDERTALE-Engine-Ultra-手册.html';
fs.copyFileSync(htmlPath, BASE + '_bak19-UNDERTALE-Engine-Ultra-手册.html');
fs.copyFileSync(BASE + 'tools/_verify.js', BASE + 'tools/_verify.js.bak9');
out('备份完成: _bak19-...html / _verify.js.bak9');

let h = fs.readFileSync(htmlPath, { encoding: 'utf8' });

// ---------- 1. CSS：.item 块后插 .exitem（置于 :hover/.on 之前，保证 hover/on 可覆盖） ----------
const cssOld = [
  '.nav .item{',
  '  display:block;padding:5px 10px;font-size:13px;color:var(--tx2);',
  '  border-radius:6px;cursor:pointer;position:relative;',
  '  white-space:nowrap;overflow:hidden;text-overflow:ellipsis;',
  '}'
].join('\n');
if (count(h, cssOld) !== 1) die('CSS .item 锚点不唯一，中止');
const cssNew = cssOld + '\n.nav .item.exitem{white-space:normal;line-height:1.45;padding-left:20px;font-size:12.5px;color:var(--tx3)}';
h = h.replace(cssOld, cssNew);

// ---------- 2. buildNav：分级项后加逐篇标题（锚点用 +c+ 与 api 分支的 +n2+ 区分） ----------
const navOld = [
  "           ' <span style=\"color:var(--tx3)\">'+c+'</span></div>';",
  '      });',
  "      h+='</div></div>';"
].join('\n');
if (count(h, navOld) !== 1) die('buildNav 示例分支锚点不唯一，中止');
const navNew = [
  "           ' <span style=\"color:var(--tx3)\">'+c+'</span></div>';",
  '      });',
  '      EXAMPLES.forEach(e=>{',
  "        h+='<div class=\"item exitem\" data-exid=\"'+e.id+'\">'+esc(e.title)+'</div>';",
  '      });',
  "      h+='</div></div>';"
].join('\n');
h = h.replace(navOld, navNew);

fs.writeFileSync(htmlPath, h, { encoding: 'utf8' });
const h2 = fs.readFileSync(htmlPath, { encoding: 'utf8' });
if (count(h2, 'item exitem') !== 1 || !h2.includes('EXAMPLES.forEach(e=>{') || !h2.includes('.nav .item.exitem{')) {
  die('HTML 写回重读断言失败');
}
out('HTML: .exitem 样式 + buildNav 逐篇标题渲染已插入，重读断言通过');

// ---------- 3. _verify.js wiring 加 3 条 ----------
const verPath = BASE + 'tools/_verify.js';
let v = fs.readFileSync(verPath, { encoding: 'utf8' });
const wOld = "  ['CSS .exgrt', /\\.exgrt\\{/.test(html)],";
if (count(v, wOld) !== 1) die('_verify wiring 锚点不唯一，中止');
const wNew = wOld + "\n  ['侧栏逐篇标题项', html.includes('class=\"item exitem\" data-exid=')],\n  ['侧栏逐篇渲染', /EXAMPLES\\.forEach\\(e=>\\{[^}]*exitem/.test(html)],\n  ['CSS .exitem', /\\.exitem\\{/.test(html)],";
v = v.replace(wOld, wNew);
fs.writeFileSync(verPath, v, { encoding: 'utf8' });
if (!fs.readFileSync(verPath, { encoding: 'utf8' }).includes('侧栏逐篇标题项')) die('_verify 写回断言失败');
out('_verify.js: wiring 加「侧栏逐篇标题项 / 渲染 / CSS .exitem」3 条断言');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_exnav.txt', LOG.join('\n'), { encoding: 'utf8' });
