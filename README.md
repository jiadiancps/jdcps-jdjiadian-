# 京东联盟订单查询系统

<div align="center">

[![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](LICENSE)
[![Node.js](https://img.shields.io/badge/node-%3E%3D14.0.0-brightgreen)](https://nodejs.org/)
[![Python](https://img.shields.io/badge/python-%3E%3D3.8-blue)](https://www.python.org/)
[![MySQL](https://img.shields.io/badge/mysql-%3E%3D5.7-orange)](https://www.mysql.com/)

基于 Node.js + Python + MySQL 的京东联盟订单自动采集与查询系统

[特性](#-主要功能) • [安装](#-安装步骤) • [配置](#-配置说明) • [使用](#-使用说明) • [部署](#-部署指南)

</div>

---

## 📝 项目简介

京东联盟订单查询系统是一个用于自动采集京东联盟订单数据的 Web 应用，支持多账号独立采集、订单查询和数据统计。系统采用前后端分离架构，前端使用 Express 提供静态资源服务，后端使用 Flask 提供 API 接口，Python 脚本负责定时采集京东联盟订单数据并存储到 MySQL 数据库。

### ✨ 产品特点

- 🚀 **快速部署** - 一键安装脚本，5分钟即可完成部署
- 🔄 **自动采集** - 定时自动调用京东联盟 API，无需手动干预
- 👥 **多账号支持** - 支持配置多个京东联盟账号，独立运行采集任务
- 🔍 **智能查询** - 快速查询订单详情，支持多种筛选条件
- 📊 **数据统计** - 实时订单汇总统计功能
- 🛡️ **容错机制** - API 调用重试、限流保护、错误日志
- 📦 **轻量级** - 依赖少，资源占用低，适合小型服务器

## 🎯 主要功能

- **订单查询**：通过订单号快速查询订单详情
- **订单列表**：分页展示所有采集的订单数据
- **自动采集**：定时自动调用京东联盟 API 采集订单数据
- **多账号支持**：支持配置多个京东联盟账号，独立运行采集任务
- **数据统计**：订单汇总统计功能

## 🛠️ 技术栈

### 前端服务
- **Node.js** + **Express** - Web 服务器框架
- **HTML/CSS/JavaScript** - 前端页面
- **node-cron** - 定时任务调度

### 后端服务
- **Python 3.8+** + **Flask** - API 服务框架
- **APScheduler** - Python 定时任务调度
- **requests** - HTTP 请求库

### 数据库
- **MySQL** - 数据存储

### 其他依赖
- **axios** - Node.js HTTP 客户端
- **PyMySQL** - Python MySQL 驱动
- **dotenv** - 环境变量管理
- **cors / Flask-CORS** - 跨域支持

## 📦 项目结构

```
jd-order-system/
├── db/
│   └── init.sql                 # 数据库初始化脚本
├── python/
│   ├── __init__.py
│   ├── app.py                   # Flask Web 服务
│   ├── collector.py             # 单账号采集器
│   ├── collector_multi.py       # 多账号采集器
│   ├── database.py              # 数据库操作
│   └── jd_api.py                # 京东 API 接口封装
├── utils/
│   ├── collector.js             # Node.js 采集工具
│   ├── db.js                    # Node.js 数据库工具
│   └── jdApi.js                 # Node.js 京东 API 工具
├── logs/                        # 日志目录（自动创建）
├── venv/                        # Python 虚拟环境（自动创建）
├── index.html                   # 首页（订单查询页面）
├── query.html                   # 订单查询页面
├── summary.html                 # 订单列表页面
├── server.js                    # Node.js 服务入口
├── package.json                 # Node.js 依赖配置
├── requirements.txt             # Python 依赖配置
├── start.sh                     # 启动脚本
├── .env.example                 # 环境变量示例
├── .gitignore                   # Git 忽略配置
├── LICENSE                      # 开源许可证
└── README.md                    # 项目说明文档
```

## 🚀 部署要求

### 系统要求

- **操作系统**：Linux（推荐 Ubuntu 20.04+）
- **Node.js**：14.x 或更高版本
- **Python**：3.8 或更高版本
- **MySQL**：5.7 或更高版本
- **内存**：建议 2GB 以上
- **磁盘空间**：建议 10GB 以上

### 环境依赖

#### 1. 安装 Node.js
```bash
# 使用 nvm 安装（推荐）
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 16
nvm use 16
```

#### 2. 安装 Python 3.8+
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3 python3-pip python3-venv

# CentOS/RHEL
sudo yum install python3 python3-pip
```

#### 3. 安装 MySQL
```bash
# Ubuntu/Debian
sudo apt install mysql-server

# CentOS/RHEL
sudo yum install mysql-server
```

## 📦 安装步骤

### 前置要求

在开始安装之前，请确保您的系统已安装：

- **Node.js** 14.x 或更高版本
- **Python** 3.8 或更高版本
- **MySQL** 5.7 或更高版本
- **Git**（可选）

### 快速开始

#### 1、克隆项目

```bash
git clone https://github.com/yourusername/jd-order-system.git
cd jd-order-system
```

#### 2、初始化数据库

```bash
# 登录 MySQL
mysql -u root -p

# 执行初始化脚本
source db/init.sql

# 或使用命令行直接导入
mysql -u root -p < db/init.sql
```

#### 3、配置环境变量

复制 `.env.example` 为 `.env` 并填写配置：

```bash
cp .env.example .env
nano .env  # 或使用其他编辑器
```

**单账号配置示例：**

```env
# 数据库配置
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_NAME=jdroot

# 京东联盟配置
JD_APP_KEY=your_app_key
JD_APP_SECRET=your_app_secret

# 服务端口
PORT=3000
```

**多账号配置示例：**

```env
# 数据库配置
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_NAME=jdroot

# 京东联盟账号1
JD_APP_KEY_1=your_app_key_1
JD_APP_SECRET_1=your_app_secret_1

# 京东联盟账号2
JD_APP_KEY_2=your_app_key_2
JD_APP_SECRET_2=your_app_secret_2

# 服务端口
PORT=3000
```

> 💡 **提示：**如何获取京东联盟 API 密钥？
> 1. 访问 [京东联盟开放平台](https://union.jd.com/)
> 2. 登录并进入「应用管理」
> 3. 创建应用并获取 AppKey 和 AppSecret

#### 4、安装依赖

**安装 Node.js 依赖：**

```bash
npm install
```

**安装 Python 依赖：**

```bash
# 创建虚拟环境（推荐）
python3 -m venv venv
source venv/bin/activate  # Windows 上使用: venv\Scripts\activate

# 安装依赖
pip install -r requirements.txt
```

#### 5、启动服务

**方式一：使用启动脚本（推荐）**

```bash
chmod +x start.sh
./start.sh
```

**方式二：手动启动**

```bash
# 启动 Node.js 服务
node server.js &

# 启动 Python 采集器（单账号）
python3 python/collector.py &

# 或启动多账号采集器
python3 python/collector_multi.py &
```

#### 6、访问系统

打开浏览器访问：`http://localhost:3000`

✅ 如果看到查询页面，说明部署成功！

## 🚀 生产环境部署

### 使用 PM2 部署（推荐）

**启动服务：**

```bash
# 启动 Node.js 服务
pm2 start server.js --name "jd-order-system"

# 启动 Python 采集器
pm2 start python/collector.py --name "jd-collector" --interpreter python3

# 保存 PM2 配置
pm2 save

# 设置开机自启
pm2 startup
```

**管理服务：**

```bash
# 查看服务状态
pm2 status

# 查看日志
pm2 logs jd-order-system
pm2 logs jd-collector

# 重启服务
pm2 restart jd-order-system
pm2 restart jd-collector

# 停止服务
pm2 stop all
```

### 使用 Systemd 部署

创建服务文件 `/etc/systemd/system/jd-order-system.service`：

```ini
[Unit]
Description=JD Order System
After=network.target mysql.service

[Service]
Type=simple
User=www-data
WorkingDirectory=/path/to/jd-order-system
ExecStart=/usr/bin/node server.js
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

启动服务：

```bash
sudo systemctl enable jd-order-system
sudo systemctl start jd-order-system
sudo systemctl status jd-order-system
```

### Nginx 反向代理配置

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

## 📊 服务管理

### 查看服务状态
```bash
# PM2 服务状态
pm2 status

# 查看进程
ps aux | grep node
ps aux | grep python
```

### 查看日志
```bash
# PM2 日志
pm2 logs jd-order-system
pm2 logs jd-collector

# 应用日志
tail -f logs/app.log
tail -f logs/collector.log
```

### 重启服务
```bash
# 重启 PM2 服务
pm2 restart all

# 或重启单个服务
pm2 restart jd-order-system
pm2 restart jd-collector
```

## 🐛 常见问题

### 1. 端口被占用

**问题：**启动时提示端口已被占用

**解决方案：**

```bash
# 查看端口占用
lsof -i :3000

# 杀死占用进程
kill -9 PID

# 或修改 .env 中的 PORT 配置
```

### 2. 数据库连接失败

**问题：**无法连接到 MySQL 数据库

**解决方案：**

- 检查 `.env` 文件中的数据库配置是否正确
- 确认 MySQL 服务是否正常运行：`systemctl status mysql`
- 检查数据库用户权限
- 确认数据库名称是否存在

### 3. 采集任务未运行

**问题：**数据库中没有新订单数据

**解决方案：**

- 查看日志文件确认错误信息：`tail -f logs/collector.log`
- 检查京东联盟 API 配置是否正确
- 确认采集器进程是否正常运行：`ps aux | grep collector`
- 检查网络连接是否正常

### 4. 虚拟环境问题

**问题：**Python 依赖安装失败或版本冲突

**解决方案：**

```bash
# 重新创建虚拟环境
rm -rf venv
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

### 5. 权限问题

**问题：**启动脚本没有执行权限

**解决方案：**

```bash
chmod +x start.sh
```

### 6. 查看日志

```bash
# 实时查看日志
tail -f logs/app.log
tail -f logs/collector.log

# 查看最近 100 行日志
tail -n 100 logs/app.log

# 搜索错误信息
grep -i error logs/*.log
```

## 📝 API 接口说明

### 查询订单

```http
GET /api/orders?orderId={订单号}&page={页码}&pageSize={每页数量}
```

**参数说明：**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| orderId | string | 否 | 订单号 |
| skuName | string | 否 | 商品名称 |
| startTime | string | 否 | 开始时间 (YYYY-MM-DD HH:mm:ss) |
| endTime | string | 否 | 结束时间 (YYYY-MM-DD HH:mm:ss) |
| validCode | number | 否 | 订单状态 |
| page | number | 否 | 页码，默认 1 |
| pageSize | number | 否 | 每页数量，默认 20 |

**返回示例：**

```json
{
  "success": true,
  "data": {
    "list": [
      {
        "orderId": "123456789",
        "skuName": "商品名称",
        "orderTime": "2024-01-01 12:00:00",
        "estimateCosPrice": 100.00,
        "estimateFee": 10.00
      }
    ],
    "total": 100,
    "page": 1,
    "pageSize": 20
  }
}
```

### 订单汇总

```http
GET /api/summary?startTime={开始时间}&endTime={结束时间}
```

**参数说明：**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| startTime | string | 否 | 开始时间 (YYYY-MM-DD HH:mm:ss) |
| endTime | string | 否 | 结束时间 (YYYY-MM-DD HH:mm:ss) |

### 健康检查

```http
GET /api/health
```

**返回示例：**

```json
{
  "status": "ok"
}
```

## 🔐 安全建议

1. **保护环境变量** 
   - 确保 `.env` 文件不被公开访问
   - 将 `.env` 添加到 `.gitignore` （已默认配置）
   - 不要将包含真实密钥的文件提交到版本控制

2. **数据库安全**
   - 使用强密码
   - 限制数据库访问权限
   - 定期备份数据

3. **网络安全**
   - 生产环境建议配置 SSL 证书
   - 使用 Nginx 反向代理
   - 配置防火墙，仅开放必要端口

4. **依赖管理**
   - 定期更新依赖包
   - 使用 `npm audit` 和 `pip check` 检查安全漏洞

5. **日志管理**
   - 定期清理日志文件
   - 不要在日志中记录敏感信息

## 📢 更新日志

### v1.0.0 (2025-12-03)

- ✨ 初始版本发布
- ✅ 支持京东联盟订单自动采集
- ✅ 支持多账号独立采集
- ✅ 支持订单查询和统计
- ✅ 支持 Web 页面查询
- ✅ 支持 RESTful API 接口

## 👥 贡献指南

欢迎贡献！请按照以下步骤：

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的修改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

### 代码规范

- 遵循 PEP 8 (Python) 和 ESLint (JavaScript) 代码规范
- 保持代码简洁、清晰
- 添加必要的注释和文档
- 提交前进行测试

## 📝 许可证

Apache License 2.0 - 详见 [LICENSE](LICENSE) 文件

## ⚠️ 免责声明

本项目仅供学习和研究使用，不得用于商业目的。使用本系统前请确保遵守京东联盟平台的相关协议和规定。

---

<div align="center">

**如果这个项目对你有帮助，请给一个 ⭐ Star!**

最后更新时间：2025-12-03

---

🤖 **本项目完全由 [Qoder AI IDE](https://qoder.com/referral?referral_code=onc5Mvt6XMkPvQFq9k0wC5QyuNLvAU3V) 开发**

体验智能编程的魅力，让 AI 成为你的编程伙伴！

</div>
