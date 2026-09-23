// 修复 manual-examples.js 外部覆盖损失：补回准备块 + files 文案 + _verify 防回退断言
// （title「给敌人设置属性、行动选项和行动对话」为用户手改版本，保持不动）
const fs = require('fs');
const vm = require('vm');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_ex_repair.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

const exPath = BASE + 'manual-examples.js';
const tmpBak = BASE + '_tmp-manual-examples.js';
fs.copyFileSync(exPath, tmpBak);   // 临时备份，成功后删除

let ex = fs.readFileSync(exPath, { encoding: 'utf8' });
const rep = (oldS, newS, tag) => {
  if (count(ex, oldS) !== 1) die('锚点不唯一/未找到 [' + tag + ']，中止');
  ex = ex.replace(oldS, newS);
  out('替换 OK: ' + tag);
};

// 1. files 文案
rep('battle_enemy_test 已有的 UE8（生成 turn_test）不动，另加两个事件：\nUser Event 0（INIT）设置敌人属性并注册行动选项，User Event 5（MENU_END）写行动对话。',
    '本篇要动 battle_enemy_test 三个地方：先注释掉 UE8 里的 turn_test 生成\n（不然每回合都冒弹幕，没法安心看对话），再加两个事件 ——\nUser Event 0（INIT）设置敌人属性并注册行动选项，User Event 5（MENU_END）写行动对话。',
    'files');

// 2. 准备块插到 code 首位（片段自带尾逗号，不再重复拼）
const codeAnchor = '  code: [\n    { t: "User Event 0 · INIT';
if (count(ex, codeAnchor) !== 1) die('code 数组开头锚点不唯一，中止');
const frag = fs.readFileSync(BASE + 'tools/_ex2c_prep.txt', { encoding: 'utf8' });
ex = ex.replace(codeAnchor, '  code: [\n' + frag + '\n    { t: "User Event 0 · INIT');
out('替换 OK: 准备块插入 code 首位');

fs.writeFileSync(exPath, ex, { encoding: 'utf8' });

// 3. vm 载入验证
const ex2 = fs.readFileSync(exPath, { encoding: 'utf8' });
const sandbox = { window: {} };
vm.createContext(sandbox);
try { vm.runInContext(ex2, sandbox); } catch (e) { die('vm 解析失败: ' + e.message); }
const EXS = sandbox.window.EXAMPLES;
if (!Array.isArray(EXS) || EXS.length !== 2) die('EXAMPLES 数量 != 2');
const e2 = EXS[1];
const langs = e2.code.map(c => c.lang).join(',');
if (langs !== 'gml,gml,gml,text,img') die('lang 序列不对: ' + langs);
if (e2.code[0].t.indexOf('先注释掉 turn_test') < 0) die('准备块不在首位');
if (e2.code.find(c => c.lang === 'img').b.indexOf('data:image/gif;base64,') !== 0) die('img 块真图丢失');
if (EXS[0].code.find(c => c.lang === 'img').b.indexOf('data:image/gif;base64,') !== 0) die('第 1 篇 img 真图丢失');
if (ex2.includes('待补')) die('仍有「待补」残留');
if (e2.files[0].b.indexOf('先注释掉 UE8') < 0) die('files 未同步');
if (e2.level !== '入门') die('level 被改动');
out('vm 载入验证通过：准备块/真图/files 全部就位（lang: gml,gml,gml,text,img）');

// 4. _verify.js 加防回退断言
const verPath = BASE + 'tools/_verify.js';
let v = fs.readFileSync(verPath, { encoding: 'utf8' });
const aOld = "  ['示例画面块渲染正常（真图）', hEx.includes('imgpic') && hEx.includes('data:image/gif;base64')],";
if (count(v, aOld) !== 1) die('_verify 画面块断言锚点不唯一，中止');
const aNew = aOld + "\n  ['示例无待补占位残留', !hEx.includes('待补') && !hEx.includes('画面占位')],";
v = v.replace(aOld, aNew);
fs.writeFileSync(verPath, v, { encoding: 'utf8' });
if (!fs.readFileSync(verPath, { encoding: 'utf8' }).includes('示例无待补占位残留')) die('_verify 写回断言失败');
out('_verify.js: 加断言「示例无待补占位残留」');

// 5. 删临时备份
fs.unlinkSync(tmpBak);
out('临时备份已删除');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_ex_repair.txt', LOG.join('\n'), { encoding: 'utf8' });
