# SVG 鈫?PDF锛圵indows 鍙抽敭鑿滃崟锛?
鍙抽敭浠绘剰 `.svg` 鏂囦欢锛岄€夈€岃浆鎹负 PDF銆嶏紝鍚岀洰褰曠敓鎴愬悓鍚?`.pdf`銆?**娌℃湁榛戞銆佷笉鐢ㄥ懡浠よ銆佷笉鐢ㄨ Python/Node**銆?
```
鍙抽敭 test.svg 鈫?鏄剧ず鏇村閫夐」 鈫?杞崲涓?PDF
        鈫?    test.pdf锛堝悓鐩綍锛岄噸鍚嶈嚜鍔?test (1).pdf锛?```

## 鐗规€?
- **鏃犵獥鍙?*锛氱敤 `wscript.exe` 杩愯锛屽叏绋嬩笉寮规帶鍒跺彴
- **闆朵緷璧?*锛氭湁 Edge 灏辫兘鐢紙Windows 10/11 鑷甫锛夛紱鏈?Inkscape 鍒欒嚜鍔ㄤ紭鍏堢敤 Inkscape
- **涓嶅姩鍘熸枃浠?*锛氬彧璇诲彇 SVG锛岃緭鍑哄悓鍚?PDF
- **閲嶅悕鑷姩缂栧彿**锛歚x.pdf` 瀛樺湪灏卞啓 `x (1).pdf`
- **椤甸潰灏哄绮剧‘**锛欵dge 璺緞浼氱敤涓€灞?HTML 鎸囧畾绾稿紶澶у皬锛屼笉浼氬鎴?Letter 鍔犵櫧杈?- **鍙啓褰撳墠鐢ㄦ埛**锛氭敞鍐岃〃鍐欏湪 `HKCU`锛屼笉闇€瑕佺鐞嗗憳鏉冮檺

## 瀹夎

### 鏂瑰紡 A锛氫笅杞藉悗鍙屽嚮锛堟帹鑽愶級

1. 鍦ㄦ湰椤靛彸涓婅 **Code 鈫?Download ZIP**锛岃В鍘嬪埌浠绘剰鍥哄畾鐩綍锛屼緥濡?   `C:\Tools\svg2pdf\`锛堜笉瑕佹斁鍦ㄤ笅杞芥枃浠跺す锛屼細琚竻鐞嗭級
2. 鍙屽嚮 `install.cmd`
3. 寮瑰嚭銆屽凡娉ㄥ唽銆嶅嵆鍙娇鐢?
### 鏂瑰紡 B锛氫竴琛屽懡浠?
鍦?PowerShell 閲屾墽琛岋紙浼氭妸鑴氭湰瑁呭埌 `%LOCALAPPDATA%\svg2pdf`锛夛細

```powershell
$d = "$env:LOCALAPPDATA\svg2pdf"
New-Item -ItemType Directory -Force $d | Out-Null
Invoke-WebRequest "https://raw.githubusercontent.com/qiugao34/svg2pdf/main/svg2pdf.vbs" -OutFile "$d\svg2pdf.vbs"
wscript.exe "$d\svg2pdf.vbs" -install
```

> 鎶?`qiugao34/svg2pdf` 鎹㈡垚瀹為檯浠撳簱鍦板潃銆?
### 鏂瑰紡 C锛欸it 鍏嬮殕

```powershell
git clone https://github.com/qiugao34/svg2pdf.git C:\Tools\svg2pdf
cd C:\Tools\svg2pdf
wscript.exe svg2pdf.vbs -install
```

## 娌℃湁 Inkscape 鎬庝箞鍔?
**涓嶉渶瑕佽**銆傝剼鏈細鑷姩鏀圭敤 **Edge 鏃犲ご鎵撳嵃**锛圵indows 10/11 鑷甫 Edge锛夛紝鏁堟灉涓€鏍锋槸鐭㈤噺 PDF锛岃€屼笖鏇村揩锛堢害 0.6 绉掞級銆?
鍒ゆ柇褰撳墠鐢ㄧ殑鏄摢涓浆鎹㈠櫒锛?
| 鐢佃剳鎯呭喌 | 鐢ㄧ殑杞崲鍣?|
|---|---|
| 瑁呬簡 Inkscape | Inkscape锛堢害 2 绉掞紝鍏煎鎬ф渶濂斤級 |
| 娌¤ Inkscape銆佹湁 Edge/Chrome | Edge 鏃犲ご鎵撳嵃锛堢害 0.6 绉掞級 |
| 涓よ€呴兘娌℃湁 | 寮圭獥鎻愮ず锛屼笉浼氶潤榛樺け璐?|

鎯冲己鍒惰蛋 Edge 璇曡瘯锛?
```powershell
wscript.exe svg2pdf.vbs -edge "D:\鏌愭枃浠?svg"
```

### 濡傛灉浣犵‘瀹炴兂瑁?Inkscape锛堝彲閫夛級

瀹冨吋瀹规€ф渶濂斤紝閫傚悎鐢ㄤ簡婊ら暅銆佸浘妗堛€両nkscape 涓撴湁鐗规€х殑 SVG銆?
**鏂瑰紡涓€锛歸inget锛堟帹鑽愶級**

```powershell
winget install --id Inkscape.Inkscape -e
```

**鏂瑰紡浜岋細瀹樼綉瀹夎鍖?*

1. 鎵撳紑 <https://inkscape.org/release/>
2. 閫?**Windows** 鈫?涓嬭浇 **64-bit installer**锛坄.msi` 鎴?`.exe`锛?3. 涓€璺笅涓€姝ワ紝淇濇寔榛樿瀹夎璺緞锛坄C:\Program Files\Inkscape`锛?4. 瑁呭畬涓嶇敤閲嶅惎锛岀洿鎺ュ彸閿?SVG 灏变細鑷姩浼樺厛鐢?Inkscape

**楠岃瘉鏄惁瑁呭ソ**

```powershell
Test-Path "C:\Program Files\Inkscape\bin\inkscape.exe"   # 搴旇緭鍑?True
```

鑴氭湰浼氭寜椤哄簭鏌ユ壘锛歚Program Files` 鈫?`Program Files (x86)` 鈫?`%LOCALAPPDATA%\Programs` 鈫?`PATH`锛屾墍浠ヤ究鎼虹増鏀捐繘 PATH 涔熻兘璇嗗埆銆?
## 浣跨敤

| 鍦烘櫙 | 鍋氭硶 |
|---|---|
| 杞竴涓?| 鍙抽敭 鈫?杞崲涓?PDF |
| 鎵归噺杞?| 閫変腑澶氫釜 鈫?鍙抽敭 鈫?杞崲涓?PDF锛堥€愪釜鎵ц锛?|
| 鍛戒护琛?| `wscript.exe svg2pdf.vbs "D:\a\b.svg"` |
| 寮哄埗 Edge | `wscript.exe svg2pdf.vbs -edge "D:\a\b.svg"` |
| 瀹夐潤妯″紡锛堟壒澶勭悊锛?| `powershell -File svg2pdf.ps1 "D:\a\b.svg" -NoBox` |

## 鍗歌浇

```powershell
wscript.exe svg2pdf.vbs -uninstall
```

鎴栧弻鍑?`uninstall.cmd`銆傚彧鍒犳敞鍐岃〃椤癸紝涓嶅垹浣犵殑 PDF銆?
## 甯歌闂

**鍙抽敭鑿滃崟閲屾病鏈夈€岃浆鎹负 PDF銆嶏紵**
Windows 11 鎶婄涓夋柟鑿滃崟鏀惰繘浜嗕簩绾ц彍鍗曪細鍙抽敭 鈫?**鏄剧ず鏇村閫夐」**锛堟垨鎸?`Shift + F10`锛夈€?
**杞崲澶辫触 / 鎻愮ず鎷掔粷璁块棶锛?*
閫氬父鏄洰鏍囨枃浠跺す涓嶅厑璁稿啓鍏ワ紙鍚屾鐩樸€佸彈淇濇姢鐩綍銆佸畨鍏ㄨ蒋浠舵嫤鎴級銆?鍏堣瘯鎶?SVG 澶嶅埗鍒版闈㈡垨 `D:\` 鏍圭洰褰曞啀杞紱纭鏄枃浠跺す闂鍚庯紝鍦ㄥ畨鍏ㄨ蒋浠堕噷鏀捐 `wscript.exe`銆?
**涓枃鏂囦欢鍚嶄細鏈夐棶棰樺悧锛?*
涓嶄細銆傝剼鏈叏绋嬬敤 Unicode 澶勭悊璺緞銆?
**杈撳嚭鐨?PDF 椤甸潰灏哄涓嶅锛?*
Edge 璺緞浼氳 SVG 鐨?`width`/`height`锛堟敮鎸?`px/pt/mm/cm/in`锛夛紝娌℃湁灏辩敤 `viewBox`锛岄兘娌℃湁鎵嶉€€鍥?1024脳768銆侷nkscape 璺緞鐩存帴鎸?SVG 灏哄杈撳嚭銆?
**`.vbs` 鏄粈涔堬紵瀹夊叏鍚楋紵**
VBScript锛學indows 鑷甫鐨勮剼鏈瑷€锛岀函鏂囨湰鍙锛岀敤璁颁簨鏈氨鑳芥墦寮€瀹￠槄銆傛湰鑴氭湰鍙仛涓変欢浜嬶細鎵?Inkscape/Edge銆佽皟鐢ㄥ畠浠浆鎹€佸啓涓€鏉?HKCU 娉ㄥ唽琛ㄩ」銆?
## 鏂囦欢璇存槑

| 鏂囦欢 | 浣滅敤 |
|---|---|
| `svg2pdf.vbs` | 涓昏剼鏈紙杞崲 + 娉ㄥ唽/娉ㄩ攢鑿滃崟锛夛紝UTF-16LE 缂栫爜 |
| `svg2pdf.ps1` | 鍙€夛細鍛戒护琛岀増鏈紝鏀寔 `-NoBox` 闈欓粯妯″紡 |
| `install.cmd` | 鍙屽嚮娉ㄥ唽 |
| `uninstall.cmd` | 鍙屽嚮鍙栨秷娉ㄥ唽 |

## 鍘熺悊

```
Explorer 鍙抽敭
  鈹斺攢 wscript.exe svg2pdf.vbs "鏂囦欢.svg"        锛圙UI 瀹夸富锛屾棤鎺у埗鍙扮獥鍙ｏ級
       鈹溾攢 鎵?Inkscape 鈫?闅愯棌绐楀彛杩愯 鈫?绛夊畠鍐欏畬
       鈹斺攢 娌℃湁 Inkscape 鈫?鐢熸垚鎸囧畾绾稿紶澶у皬鐨勪复鏃?HTML
                        鈫?Edge --headless --print-to-pdf
```

## License

MIT
