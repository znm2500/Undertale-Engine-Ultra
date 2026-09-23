const fs = require('fs');
const p = 'C:/Users/Weaver/Desktop/屏幕录制 2026-09-22 010222.gif';
let out;
try {
  const st = fs.statSync(p);
  out = 'exists=true size=' + st.size + ' bytes (' + (st.size / 1024 / 1024).toFixed(2) + ' MB)';
} catch (e) {
  out = 'exists=false err=' + e.message;
}
fs.writeFileSync('C:/Users/Weaver/Documents/GitHub/Undertale-Engine-Ultra/docs/tools/_gifstat.txt', out, { encoding: 'utf8' });
