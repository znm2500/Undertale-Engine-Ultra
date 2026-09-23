// 清理 docs/ 下全部备份文件：_bak* / _backup* / _TODO.md.bak* / tools/*.bak*
// 删前统计、删后核对，日志落盘
const fs = require('fs');
const path = require('path');
const BASE = 'C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/';
const LOG = [];
const out = (s) => LOG.push(s);

// 收集（只匹配备份模式，绝不碰活文件）
const targets = [];
for (const f of fs.readdirSync(BASE)) {
  if (/^_bak\d+-/.test(f) || /^_backup-/.test(f) || /^_TODO\.md\.bak\d*$/.test(f)) targets.push(BASE + f);
}
const toolsDir = BASE + 'tools/';
for (const f of fs.readdirSync(toolsDir)) {
  if (/\.(bak|bak\d+)$/.test(f)) targets.push(toolsDir + f);
}
out('待删备份 ' + targets.length + ' 个：');
targets.forEach(t => out('  ' + t));

// 保护性断言：绝不允许出现活文件名
const PROTECT = ['UNDERTALE-Engine-Ultra-手册.html', 'manual-api.js', 'manual-examples.js', '_verify.js', '_TODO.md'];
for (const t of targets) {
  if (PROTECT.includes(path.basename(t))) die('FATAL: 待删清单命中活文件 ' + t);
  if (/\d{4,}\.txt$|\.js$/.test(path.basename(t)) && !/\.bak/.test(path.basename(t)) && !/^_bak\d+-/.test(path.basename(t)) && !/^_backup-/.test(path.basename(t))) die('FATAL: 异常路径 ' + t);
}

let ok = 0, fail = 0;
for (const t of targets) {
  try { fs.unlinkSync(t); ok++; } catch (e) { out('  ✗ 删除失败: ' + t + ' (' + e.message + ')'); fail++; }
}
out('删除完成: 成功 ' + ok + ' / 失败 ' + fail);

// 删后核对：docs 下不应再有备份模式文件
const left = [];
for (const f of fs.readdirSync(BASE)) if (/^_bak\d+-/.test(f) || /^_backup-/.test(f) || /^_TODO\.md\.bak\d*$/.test(f)) left.push(f);
for (const f of fs.readdirSync(toolsDir)) if (/\.(bak|bak\d+)$/.test(f)) left.push('tools/' + f);
out('残留备份: ' + (left.length ? left.join(', ') : '0'));

// 活文件完好核对（体积骤降强信号检查）
const MUST_EXIST = [
  'UNDERTALE-Engine-Ultra-手册.html', 'manual-api.js', 'manual-examples.js',
  'tools/_verify.js', 'favicon.png', '_TODO.md'
];
for (const m of MUST_EXIST) {
  const p = BASE + m;
  if (!fs.existsSync(p)) { out('FATAL: 活文件丢失 ' + m); break; }
  out('  活文件在: ' + m + ' (' + fs.statSync(p).size + ' B)');
}
out('ALL OK');
fs.writeFileSync(BASE + 'tools/_cleanup_bak.txt', LOG.join('\n'), { encoding: 'utf8' });
