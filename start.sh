#!/bin/bash

echo "======================================"
echo "京东订单查询系统 - 启动脚本"
echo "======================================"

# 获取脚本所在目录作为项目根目录
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $PROJECT_DIR
echo "项目目录: $PROJECT_DIR"

# 检查虚拟环境
if [ ! -d "venv" ]; then
    echo "❌ 虚拟环境不存在，正在创建..."
    python3 -m venv venv
    ./venv/bin/pip install -r requirements.txt
fi

# 使用虚拟环境的Python
PYTHON="$PROJECT_DIR/venv/bin/python3"
echo "Python路径: $PYTHON"
$PYTHON --version

# 创建日志目录
mkdir -p logs

echo ""
echo "1. 启动Flask Web服务器..."
nohup $PYTHON python/app.py > logs/app.log 2>&1 &
APP_PID=$!
echo "Flask服务已启动 (PID: $APP_PID)"

echo ""
echo "2. 启动订单采集定时任务..."

# 检查是否有多个账号配置
if grep -q "JD_APP_KEY_2" .env 2>/dev/null; then
    echo "检测到多账号配置，使用多账号采集器"
    nohup $PYTHON python/collector_multi.py > logs/collector_multi.log 2>&1 &
    COLLECTOR_PID=$!
    echo "多账号采集任务已启动 (PID: $COLLECTOR_PID)"
else
    echo "使用单账号采集器"
    nohup $PYTHON python/collector.py > logs/collector.log 2>&1 &
    COLLECTOR_PID=$!
    echo "采集任务已启动 (PID: $COLLECTOR_PID)"
fi

echo ""
echo "======================================"
echo "系统启动完成！"
echo "Web服务: http://localhost:3000"
echo "Flask PID: $APP_PID"
echo "Collector PID: $COLLECTOR_PID"
echo "======================================"
echo ""
echo "查看日志:"
if grep -q "JD_APP_KEY_2" .env 2>/dev/null; then
    echo "  Web服务: tail -f logs/app.log"
    echo "  采集任务(多账号): tail -f logs/collector_multi.log"
else
    echo "  Web服务: tail -f logs/app.log"
    echo "  采集任务: tail -f logs/collector.log"
fi
echo ""
echo "停止服务:"
echo "  kill $APP_PID $COLLECTOR_PID"
