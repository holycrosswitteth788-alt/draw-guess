# 你画我猜 · 双人 1V1 联机版

纯静态单文件游戏，使用 **PeerJS（WebRTC）** 实现两个浏览器之间的点对点联机，**无需任何后端服务器**。

## 玩法

1. A 点「创建房间」，生成 6 位房间号，点「复制房间号」发给朋友
2. B 输入房间号点「加入房间」，两人自动直连
3. 轮流作画，对方猜词；90 秒内猜对得分

## 功能

- 实时画笔轨迹同步（归一化坐标，两端屏幕尺寸不同也能对齐）
- 10 种颜色、4 档笔粗、橡皮、撤销、清空
- 猜词自动判定，命中即结束回合并计分
- 支持 `?room=xxxxxx` 链接直接进房
- 手机 / 平板触摸绘画支持

## 本地运行

**方式一（推荐）**：双击 `启动测试服务器.bat`，浏览器会自动打开 `http://127.0.0.1:8090`

**方式二**：命令行执行

```bash
python -m http.server 8090
```

然后开两个浏览器窗口访问 `http://127.0.0.1:8090` 即可自测。

> 不要直接双击 `index.html` 用 `file://` 打开 —— WebRTC 需要 `http://` 或 `https://` 环境。

## 部署

纯静态，可部署到任意静态托管：GitHub Pages / Vercel / Cloudflare Pages / 阿里云 OSS 等。

GitHub Pages 部署：仓库 Settings → Pages → Source 选 `Deploy from a branch` → 分支 `main`、目录 `/ (root)` → Save。

访问地址：`https://<你的用户名>.github.io/<仓库名>/`

## 技术说明

### 连接方式（双通道自动切换）

1. **P2P 直连**（优先）：PeerJS + WebRTC，延迟最低
2. **中继通道**（兜底）：MQTT over WebSocket（`wss://broker.emqx.io:8084/mqtt`），
   直连 6 秒未建立时自动切换。跨运营商、4G、公司内网等严格 NAT 场景都能连通

手动强制中继：在网址后加 `?relay=1`，例如
`https://xxx.github.io/draw-guess/?relay=1`

### 依赖

- `peerjs.min.js`、`mqtt.min.js` 已放在仓库根目录（本地加载，不依赖境外 CDN）
- 页面里保留了 jsDelivr 回退，本地文件缺失时会自动从 CDN 拉取

### 说明

- 中继模式的数据会经过公共 MQTT broker，仅供娱乐场景使用，别传敏感内容
- 房间号是随机 6 位，两个房间撞号概率极低
