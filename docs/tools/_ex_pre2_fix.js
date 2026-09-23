// 修复双逗号后的补跑：vm 验证 + _verify.js 断言（_ex_pre2.js 在 vm 验证步中止，第 3 步未执行）
const fs = require('fs');
const vm = require('vm');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);
const die = (s) => { out('FATAL: ' + s); fs.writeFileSync(BASE + 'tools/_ex_pre2_fix.txt', LOG.join('\n'), { encoding: 'utf8' }); process.exit(1); };
const count = (s, sub) => s.split(sub).length - 1;

// ---------- vm 验证 ----------
const ex = fs.readFileSync(BASE + 'manual-examples.js', { encoding: 'utf8' });
if (count(ex, '},,') !== 0) die('文件里仍有双逗号，中止');
const sandbox = { window: {} };
vm.createContext(sandbox);
try { vm.runInContext(ex, sandbox); } catch (e) { die('vm 解析失败: ' + e.message); }
const EXS = sandbox.window.EXAMPLES;
if (!Array.isArray(EXS) || EXS.length !== 2) die('EXAMPLES 数量 != 2');
const e2 = EXS[1];
const langs = (e2.code || []).map(c => c.lang).join(',');
if (langs !== 'gml,gml,gml,text,img') die('lang 序列不对: ' + langs);
if (e2.code[0].t.indexOf('先注释掉 turn_test') < 0) die('准备块标题不对');
if (e2.code[0].b.indexOf('// instance_create_depth(0,0,0,turn_test)') < 0) die('准备块缺注释行');
if (e2.code[0].b.indexOf('instance_create_depth(0,0,0,turn_test)\n') < 0) die('准备块缺原文行');
if (e2.files[0].b.indexOf('先注释掉 UE8') < 0) die('files 未同步');
out('vm 载入验证通过：lang 序列 gml,gml,gml,text,img，准备块/files 均正确');

// ---------- _verify.js 加断言（补第 3 步） ----------
const verPath = BASE + 'tools/_verify.js';
let v = fs.readFileSync(verPath, { encoding: 'utf8' });
const aOld = "  ['示例2 详情 无 undefined', !hOne2.includes('undefined')],";
if (count(v, aOld) !== 1) die('_verify 示例2 断言锚点不唯一，中止');
const aNew = "  ['示例2 有 turn_test 准备步骤', hOne2.includes('先注释掉 turn_test')],\n" + aOld;
v = v.replace(aOld, aNew);
fs.writeFileSync(verPath, v, { encoding: 'utf8' });
if (!fs.readFileSync(verPath, { encoding: 'utf8' }).includes('示例2 有 turn_test 准备步骤')) die('_verify 写回断言失败');
out('_verify.js: 加断言「示例2 有 turn_test 准备步骤」');

out('ALL OK');
fs.writeFileSync(BASE + 'tools/_ex_pre2_fix.txt', LOG.join('\n'), { encoding: 'utf8' });
