const express = require('express');
const cors = require('cors');
const path = require('path');
const { queryOrders, getOrderSummary } = require('./utils/db');
const OrderCollector = require('./utils/collector');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// 中间件
app.use(cors());
app.use(express.json());
app.use(express.static(__dirname));

// API路由 - 查询订单
app.get('/api/orders', async (req, res) => {
    try {
        const filters = {
            orderId: req.query.orderId,
            skuName: req.query.skuName,
            startTime: req.query.startTime,
            endTime: req.query.endTime,
            validCode: req.query.validCode
        };

        const page = parseInt(req.query.page) || 1;
        const pageSize = parseInt(req.query.pageSize) || 20;

        const result = await queryOrders(filters, page, pageSize);
        res.json({
            success: true,
            data: result
        });
    } catch (error) {
        console.error('查询订单失败:', error);
        res.status(500).json({
            success: false,
            message: error.message
        });
    }
});

// API路由 - 订单汇总
app.get('/api/summary', async (req, res) => {
    try {
        const filters = {
            startTime: req.query.startTime,
            endTime: req.query.endTime
        };

        const result = await getOrderSummary(filters);
        res.json({
            success: true,
            data: result
        });
    } catch (error) {
        console.error('获取汇总失败:', error);
        res.status(500).json({
            success: false,
            message: error.message
        });
    }
});

// 健康检查
app.get('/api/health', (req, res) => {
    res.json({ status: 'ok' });
});

// 启动服务器
app.listen(PORT, () => {
    console.log(`服务器运行在 http://localhost:${PORT}`);
    
    // 启动订单采集定时任务
    const collector = new OrderCollector();
    collector.startSchedule();
});
