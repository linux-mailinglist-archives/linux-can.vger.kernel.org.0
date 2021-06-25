Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F2A3B40C8
	for <lists+linux-can@lfdr.de>; Fri, 25 Jun 2021 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFYJrx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Jun 2021 05:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhFYJrw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Jun 2021 05:47:52 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617AAC061760
        for <linux-can@vger.kernel.org>; Fri, 25 Jun 2021 02:45:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k6so7575595pfk.12
        for <linux-can@vger.kernel.org>; Fri, 25 Jun 2021 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OkGaPTN7L07QWq0eRuyHbk6ObnFyKKbWL/R0HdbDJQ=;
        b=mjnFYwoCKf90yxCKqDGZE3K3y7QqCLKmqD2mA/13c+C9l107CiG0uI07jNJSg1nrdj
         demz8JIS2bwY7amk/6ryzXypqE7nct80OOyoGJRpOjP93273hnmMkOvOG8zY6CtGC+t3
         kSu0WwbCoquXOFZP8cFz0UHr40M0Ydsqfy7ItK2PqWyyF1bn2OOXX8g0ngqyp5xK+0iF
         bsAJ7uDvdWx6gMwM1D51dDoUuBeVKmCxabb/NE6uiUyazRZA5myVfEsRwCp2Zfg+KlBS
         y+Oaz7Nj5Ome7Zpw48N341XnyOfZBItDnBFB7Nn/Ujhoo67K9qksjHAar8Ynn+s4eQTl
         ihvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OkGaPTN7L07QWq0eRuyHbk6ObnFyKKbWL/R0HdbDJQ=;
        b=cLz5tO/Urty9wag78Hj3+1FMcNsf72xBIvJFDn2vyAyAuMVdf1E6rCSDPvDMXxXH54
         afdLjYoxBvI+9H5K5dyLZ7sDBG/7C4xY3q7c/OCxunYFpxMByYKvvpMqn+/9u5GZ9d27
         gkE8e9pQ5yBi9XXCt32X2kqeQQf6rfZPZchHbydZ2xbL0KjVBQII1muH+Ipdohn9rMLC
         fZDZTtzuzkBJba0U5JEtN1b9/dIHToRLisc54kLiy9X4/EqHjgxJlVm4APpPssErmScd
         U3nalfYmDceV8L2LH8YFF1lw0rbW63U+3PoYTDX6+C/W4kx2XiEidVKMwODv5hoWWaUf
         eteQ==
X-Gm-Message-State: AOAM531nAImjYMxsHFO05q9oPS/W09JSSepXifqv8PnEEaysW1fI2cH3
        4WUmFUchI0Ti/bQuG/Tpt8I=
X-Google-Smtp-Source: ABdhPJzhv8Q2XnoWAN2IprDo5wCRMVn2LavZ7s4LwawG97HHzkWCZxEFWMxNWbMxDtV8Stkzf99A8A==
X-Received: by 2002:a63:2503:: with SMTP id l3mr8819536pgl.237.1624614331874;
        Fri, 25 Jun 2021 02:45:31 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id y4sm4723288pfc.15.2021.06.25.02.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 02:45:31 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     wg@grandegger.com
Cc:     mkl@pengutronix.de, linux-can@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com,
        Morris Ku <saumah@gmail.com>, Edward Lee <Edward.lee@sunix.com>
Subject: [PATCH] SUNIX SDC CAN controller driver
Date:   Fri, 25 Jun 2021 17:45:20 +0800
Message-Id: <20210625094520.13283-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add support for SUNIX SDC CAN controller

Cc: Jason Lee <jason_lee@sunix.com>
Cc: Taian Chen <taian.chen@sunix.com>
Cc: Morris Ku <morris_ku@sunix.com>
Cc: Edward Lee <Edward.lee@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 sx2010_can.c | 1243 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1243 insertions(+)
 create mode 100644 sx2010_can.c

diff --git a/sx2010_can.c b/sx2010_can.c
new file mode 100644
index 0000000..5d9d360
--- /dev/null
+++ b/sx2010_can.c
@@ -0,0 +1,1243 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SUNIX SDC CAN controller driver.
+ *
+ * Copyright (C) 2021, SUNIX Co., Ltd.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/can/core.h>
+#include <linux/can/dev.h>
+#include <linux/can/led.h>
+
+#define DRIVER_NAME		"sx2010_can"
+
+#define SX2010_REG_CTRL				0
+#define SX2010_CTRL_ENABLE			BIT(0)
+#define SX2010_CTRL_TX_IRQ_ENABLE	BIT(1)
+#define SX2010_CTRL_RX_IRQ_ENABLE	BIT(2)
+#define SX2010_CTRL_DEV_IRQ_ENABLE	BIT(3)
+#define SX2010_REG_STATUS			4
+#define SX2010_STATUS_BUSY			BIT(0)
+#define SX2010_STATUS_TX_IRQ		BIT(1)
+#define SX2010_STATUS_RX_IRQ		BIT(2)
+#define SX2010_STATUS_DEV_IRQ		BIT(3)
+#define SX2010_REG_TIMING_CTRL		8
+#define SX2010_REG_IRQ_ENABLE		12
+#define SX2010_REG_IRQ_STATUS		16
+#define SX2010_REG_GPIO_OUT_ENABLE	20
+#define SX2010_REG_GPIO_OUT			24
+#define SX2010_REG_TRANS_CTRL_0		28
+#define SX2010_TRANS_ENABLE			BIT(0)
+#define SX2010_TRANS_WRITE			BIT(1)
+#define SX2010_REG_TRANS_CTRL_1		32
+#define SX2010_REG_RAM				512
+
+#define SX2010_WAIT_MAX_LOOP		2000
+#define SX2010_ISR_MAX_CNT			10
+#define SX2010_ISR_TIME				(HZ / 100)
+#define SX2010_CAN_MAX_DATA_LEN		8
+#define SX2010_CAN_TRANS_BUF_LEN	(6 + SX2010_CAN_MAX_DATA_LEN)
+#define SX2010_BUF_LEN				512
+#define SX2010_TX_ECHO_SKB_MAX		1
+#define SX2010_OST_DELAY_MS			(5)
+#define SX2010_FREQUENCY			20000000
+
+#define SX2010_CMD_WRITE			0x02
+#define SX2010_CMD_READ				0x03
+#define SX2010_CMD_BIT_MODIFY		0x05
+#define SX2010_CMD_WRITE_TXB(n)		(0x40 + 2 * (n))
+#define SX2010_CMD_READ_RXB(n)		(((n) == 0) ? 0x90 : 0x94)
+#define SX2010_CMD_RESET			0xC0
+#define SX2010_CMD_RTS(n)			(0x80 | ((n) & 0x07))
+
+#define REG_STAT					0x0e
+#define REG_CTRL					0x0f
+#define REG_CTRL_MASK				GENMASK(7, 5)
+#define REG_CTRL_CONF				BIT(7)
+#define REG_CTRL_LISTEN_ONLY		GENMASK(6, 5)
+#define REG_CTRL_LOOPBACK			BIT(6)
+#define REG_CTRL_SLEEP				BIT(5)
+#define REG_CTRL_NORMAL				0
+#define REG_CFG1					0x2a
+#define REG_CFG2					0x29
+#define REG_CFG2_BTLMODE			BIT(7)
+#define REG_CFG2_SAM				BIT(6)
+#define REG_CFG3					0x28
+#define REG_CFG3_PHSEG2_MASK		GENMASK(2, 0)
+#define REG_INTE					0x2b
+#define REG_INTE_ALL				GENMASK(5, 0)
+#define REG_INTF					0x2c
+#define REG_INTF_RX1				BIT(1)
+#define REG_INTF_RX0				BIT(0)
+#define REG_INTF_RX					GENMASK(1, 0)
+#define REG_INTF_TX					GENMASK(4, 2)
+#define REG_INTF_ERR				BIT(5)
+#define REG_EFLG					0x2d
+#define REG_EFLG_RXWAR				BIT(1)
+#define REG_EFLG_TXWAR				BIT(2)
+#define REG_EFLG_RXEP				BIT(3)
+#define REG_EFLG_TXEP				BIT(4)
+#define REG_EFLG_TXBO				BIT(5)
+#define REG_EFLG_RX0OVR				BIT(6)
+#define REG_EFLG_RX1OVR				BIT(7)
+#define REG_TXBCTRL(n)				(((n) * 0x10) + 0x30)
+#define REG_RXBCTRL(n)				(((n) * 0x10) + 0x60)
+#define REG_RXBCTRL_BUKT			BIT(2)
+#define REG_RXBCTRL_RXM0			BIT(5)
+#define REG_RXBCTRL_RXM1			BIT(6)
+#define REG_RXBSIDL_IDE				BIT(3)
+#define REG_RXBSIDL_SRR				BIT(4)
+#define REG_RXBSIDL_EID				GENMASK(1, 0)
+#define REG_RXBDLC_LEN_MASK			GENMASK(3, 0)
+#define REG_RXBDLC_RTR				BIT(6)
+
+#define GET_BYTE(val, byte)			\
+	(((val) >> ((byte) * 8)) & 0xff)
+#define SET_BYTE(val, byte)			\
+	(((val) & 0xff) << ((byte) * 8))
+
+static const struct can_bittiming_const sx2010_bittiming_const = {
+	.name = DRIVER_NAME,
+	.tseg1_min = 3,
+	.tseg1_max = 16,
+	.tseg2_min = 2,
+	.tseg2_max = 8,
+	.sjw_max = 4,
+	.brp_min = 1,
+	.brp_max = 64,
+	.brp_inc = 1,
+};
+
+struct sx2010_can_data {
+	u32 board_id;
+	u8 chl_number;
+	u8 version;
+	u32 significand;
+	u8 exponent;
+	u8 gpio_input;
+	u8 gpio_output;
+};
+
+struct sx2010_data {
+	struct can_priv can;
+	struct net_device *net;
+	struct mutex trans_lock;
+	struct mutex sx_lock;
+	u8 *tx_buf;
+	u8 *rx_buf;
+	struct sk_buff *tx_skb;
+	int tx_len;
+	struct workqueue_struct *wq;
+	struct work_struct tx_work;
+	struct work_struct restart_work;
+
+	int force_quit;
+	int after_suspend;
+#define SX2010_AFTER_SUSPEND_UP 1
+#define SX2010_AFTER_SUSPEND_DOWN 2
+#define SX2010_AFTER_SUSPEND_POWER 4
+#define SX2010_AFTER_SUSPEND_RESTART 8
+	int restart_tx;
+
+	struct sx2010_can_data data;
+	struct device *dev;
+	struct resource *res;
+	u8 chip_select;
+	unsigned long long clk_rate;
+	struct timer_list timer;
+	void __iomem *base;
+};
+
+static inline u32 sx2010_readl(struct sx2010_data *data, u32 reg)
+{
+	return readl(data->base + reg);
+}
+
+static inline void sx2010_writel(struct sx2010_data *data, u32 reg,
+				u32 val)
+{
+	writel(val, data->base + reg);
+}
+
+static inline int sx2010_wait_till_ready(struct sx2010_data *data,
+				bool wait_rx_irq)
+{
+	bool available = false;
+	bool rx_irq = false;
+	u32 status;
+	int i;
+
+	for (i = 0; i < SX2010_WAIT_MAX_LOOP; i++) {
+		status = sx2010_readl(data, SX2010_REG_STATUS);
+		if (!(status & SX2010_STATUS_BUSY))
+			available = true;
+		if (status & SX2010_STATUS_RX_IRQ)
+			rx_irq = true;
+
+		if (wait_rx_irq) {
+			if (available && rx_irq)
+				return 0;
+		} else {
+			if (available)
+				return 0;
+		}
+		cpu_relax();
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int sx2010_write_trans(struct sx2010_data *data, int cmd_len,
+				int data_len)
+{
+	int len_in_dw;
+	int total_len;
+	u32 val;
+	int ret;
+	int i;
+	int j;
+
+	if (cmd_len <= 0)
+		return -EINVAL;
+
+	total_len = cmd_len + data_len;
+	mutex_lock(&data->trans_lock);
+
+	ret = sx2010_wait_till_ready(data, false);
+	if (ret)
+		goto out_unlock;
+
+	/* Set ram */
+	if ((total_len % 4) == 0) {
+		len_in_dw = total_len / 4;
+	} else {
+		if (total_len < 4)
+			len_in_dw = 1;
+		else
+			len_in_dw = (total_len / 4) + 1;
+	}
+
+	j = 0;
+	for (i = 0; i < len_in_dw; i++) {
+		do {
+			val = data->tx_buf[i * 4];
+			if (++j == total_len)
+				break;
+			val |= data->tx_buf[i * 4 + 1] << 8;
+			if (++j == total_len)
+				break;
+			val |= data->tx_buf[i * 4 + 2] << 16;
+			if (++j == total_len)
+				break;
+			val |= data->tx_buf[i * 4 + 3] << 24;
+			if (++j == total_len)
+				break;
+		} while (false);
+
+		sx2010_writel(data, SX2010_REG_RAM + (i * 4), val);
+	}
+
+	/* Set trans reg 1 */
+	val = data_len << 16;
+	sx2010_writel(data, SX2010_REG_TRANS_CTRL_1, val);
+
+	/* Set trans reg 0 */
+	val = SX2010_TRANS_ENABLE | SX2010_TRANS_WRITE;
+	val |= cmd_len << 8;
+	val |= data->chip_select << 16;
+	sx2010_writel(data, SX2010_REG_TRANS_CTRL_0, val);
+
+	ret = sx2010_wait_till_ready(data, false);
+
+out_unlock:
+	mutex_unlock(&data->trans_lock);
+	return ret;
+}
+
+static int sx2010_read_trans(struct sx2010_data *data, int cmd_len,
+				int data_len)
+{
+	int len_in_dw;
+	u32 val;
+	int ret;
+	int i;
+	int j;
+
+	if (cmd_len <= 0)
+		return -EINVAL;
+
+	mutex_lock(&data->trans_lock);
+
+	ret = sx2010_wait_till_ready(data, false);
+	if (ret)
+		goto out_unlock;
+
+	/* Set ram */
+	if ((cmd_len % 4) == 0) {
+		len_in_dw = cmd_len / 4;
+	} else {
+		if (cmd_len < 4)
+			len_in_dw = 1;
+		else
+			len_in_dw = (cmd_len / 4) + 1;
+	}
+
+	j = 0;
+	for (i = 0; i < len_in_dw; i++) {
+		do {
+			val = data->tx_buf[i * 4];
+			if (++j == cmd_len)
+				break;
+			val |= data->tx_buf[i * 4 + 1] << 8;
+			if (++j == cmd_len)
+				break;
+			val |= data->tx_buf[i * 4 + 2] << 16;
+			if (++j == cmd_len)
+				break;
+			val |= data->tx_buf[i * 4 + 3] << 24;
+			if (++j == cmd_len)
+				break;
+		} while (false);
+
+		sx2010_writel(data, SX2010_REG_RAM + (i * 4), val);
+	}
+
+	/* Set trans reg 1 */
+	val = data_len;
+	sx2010_writel(data, SX2010_REG_TRANS_CTRL_1, val);
+
+	/* Set trans reg 0 */
+	val = SX2010_TRANS_ENABLE;
+	val |= cmd_len << 8;
+	val |= data->chip_select << 16;
+	sx2010_writel(data, SX2010_REG_TRANS_CTRL_0, val);
+
+	ret = sx2010_wait_till_ready(data, true);
+	if (ret)
+		goto out_unlock;
+
+	/* Get ram */
+	if ((data_len % 4) == 0) {
+		len_in_dw = data_len / 4;
+	} else {
+		if (data_len < 4)
+			len_in_dw = 1;
+		else
+			len_in_dw = (data_len / 4) + 1;
+	}
+
+	j = 0;
+	for (i = 0; i < len_in_dw; i++) {
+		val = sx2010_readl(data, SX2010_REG_RAM + (i * 4));
+		data->rx_buf[j++] = val & GENMASK(7, 0);
+		if (j == data_len)
+			break;
+		data->rx_buf[j++] = (val & GENMASK(15, 8)) >> 8;
+		if (j == data_len)
+			break;
+		data->rx_buf[j++] = (val & GENMASK(23, 16)) >> 16;
+		if (j == data_len)
+			break;
+		data->rx_buf[j++] = (val & GENMASK(31, 24)) >> 24;
+		if (j == data_len)
+			break;
+	}
+
+out_unlock:
+	mutex_unlock(&data->trans_lock);
+	return ret;
+}
+
+static void sx2010_clean(struct net_device *net)
+{
+	struct sx2010_data *data = netdev_priv(net);
+
+	if (data->tx_skb || data->tx_len)
+		net->stats.tx_errors++;
+	dev_kfree_skb(data->tx_skb);
+	if (data->tx_len)
+		can_free_echo_skb(data->net, 0);
+	data->tx_skb = NULL;
+	data->tx_len = 0;
+}
+
+static u8 sx2010_read_reg(struct sx2010_data *data, u8 reg)
+{
+	int ret;
+	u8 val = 0;
+
+	data->tx_buf[0] = SX2010_CMD_READ;
+	data->tx_buf[1] = reg;
+
+	ret = sx2010_read_trans(data, 2, 1);
+	if (ret == 0)
+		val = data->rx_buf[0];
+
+	return val;
+}
+
+static void sx2010_read_2regs(struct sx2010_data *data, u8 reg, u8 *v1, u8 *v2)
+{
+	int ret;
+
+	data->tx_buf[0] = SX2010_CMD_READ;
+	data->tx_buf[1] = reg;
+
+	ret = sx2010_read_trans(data, 2, 2);
+	if (ret == 0) {
+		*v1 = data->rx_buf[0];
+		*v2 = data->rx_buf[1];
+	}
+}
+
+static void sx2010_write_reg(struct sx2010_data *data, u8 reg, u8 val)
+{
+	data->tx_buf[0] = SX2010_CMD_WRITE;
+	data->tx_buf[1] = reg;
+	data->tx_buf[2] = val;
+
+	sx2010_write_trans(data, 2, 1);
+}
+
+static void sx2010_write_2regs(struct sx2010_data *data, u8 reg, u8 v1, u8 v2)
+{
+	data->tx_buf[0] = SX2010_CMD_WRITE;
+	data->tx_buf[1] = reg;
+	data->tx_buf[2] = v1;
+	data->tx_buf[3] = v2;
+
+	sx2010_write_trans(data, 2, 2);
+}
+
+static void sx2010_write_bits(struct sx2010_data *data, u8 reg, u8 mask, u8 val)
+{
+	data->tx_buf[0] = SX2010_CMD_BIT_MODIFY;
+	data->tx_buf[1] = reg;
+	data->tx_buf[2] = mask;
+	data->tx_buf[3] = val;
+
+	sx2010_write_trans(data, 2, 2);
+}
+
+static void sx2010_hw_tx_frame(struct sx2010_data *data, u8 *buf,
+					int len, int tx_buf_idx)
+{
+	memcpy(data->tx_buf, buf, 6 + len);
+	sx2010_write_trans(data, 1, 6 + len - 1);
+}
+
+static void sx2010_hw_tx(struct sx2010_data *data, struct can_frame *frame,
+					int tx_buf_idx)
+{
+	u32 sid, eid, exide, rtr;
+	u8 buf[SX2010_CAN_TRANS_BUF_LEN];
+
+	exide = (frame->can_id & CAN_EFF_FLAG) ? 1 : 0;
+	if (exide)
+		sid = (frame->can_id & CAN_EFF_MASK) >> 18;
+	else
+		sid = frame->can_id & CAN_SFF_MASK;
+	eid = frame->can_id & CAN_EFF_MASK;
+	rtr = (frame->can_id & CAN_RTR_FLAG) ? 1 : 0;
+
+	buf[0] = SX2010_CMD_WRITE_TXB(tx_buf_idx);
+	buf[1] = sid >> 3;
+	buf[2] = ((sid & 7) << 5) |	(exide << 3) | ((eid >> 16) & 3);
+	buf[3] = GET_BYTE(eid, 1);
+	buf[4] = GET_BYTE(eid, 0);
+	buf[5] = (rtr << 6) | frame->len;
+
+	memcpy(buf + 6, frame->data, frame->len);
+	sx2010_hw_tx_frame(data, buf, frame->len, tx_buf_idx);
+
+	data->tx_buf[0] = SX2010_CMD_RTS(1 << tx_buf_idx);
+	sx2010_write_trans(data, 1, 0);
+}
+
+static void sx2010_hw_rx_frame(struct sx2010_data *data, u8 *buf,
+					int buf_idx)
+{
+	memset(data->rx_buf, 0, sizeof(u8) * SX2010_BUF_LEN);
+	data->tx_buf[0] = SX2010_CMD_READ_RXB(buf_idx);
+
+	sx2010_read_trans(data, 1, SX2010_CAN_TRANS_BUF_LEN - 1);
+	memcpy(&buf[1], data->rx_buf, SX2010_CAN_TRANS_BUF_LEN - 1);
+}
+
+static void sx2010_hw_rx(struct sx2010_data *data, int buf_idx)
+{
+	struct can_frame *frame;
+	struct sk_buff *skb;
+	u8 buf[SX2010_CAN_TRANS_BUF_LEN];
+
+	skb = alloc_can_skb(data->net, &frame);
+	if (!skb) {
+		dev_err(data->dev, "cannot allocate RX skb\n");
+		data->net->stats.rx_dropped++;
+		return;
+	}
+
+	sx2010_hw_rx_frame(data, buf, buf_idx);
+	if (buf[2] & REG_RXBSIDL_IDE) {
+		frame->can_id = CAN_EFF_FLAG;
+		frame->can_id |=
+			SET_BYTE(buf[2] & REG_RXBSIDL_EID, 2) |
+			SET_BYTE(buf[3], 1) |
+			SET_BYTE(buf[4], 0) |
+			(((buf[1] << 3) | (buf[1] >> 5)) << 18);
+
+		if (buf[5] & REG_RXBDLC_RTR)
+			frame->can_id |= CAN_RTR_FLAG;
+	} else {
+		frame->can_id = (buf[1] << 3) |	(buf[2] >> 5);
+
+		if (buf[2] & REG_RXBSIDL_SRR)
+			frame->can_id |= CAN_RTR_FLAG;
+	}
+
+	frame->len = can_cc_dlc2len(buf[5] & REG_RXBDLC_LEN_MASK);
+	memcpy(frame->data, buf + 6, frame->len);
+
+	data->net->stats.rx_packets++;
+	data->net->stats.rx_bytes += frame->len;
+
+	can_led_event(data->net, CAN_LED_EVENT_RX);
+	netif_rx_ni(skb);
+}
+
+static void sx2010_hw_sleep(struct sx2010_data *data)
+{
+	sx2010_write_reg(data, REG_CTRL, REG_CTRL_SLEEP);
+}
+
+static int sx2010_hw_startup(struct sx2010_data *data)
+{
+	int divisor = 1;
+	u32 val;
+
+	divisor = data->clk_rate / SX2010_FREQUENCY;
+	val = 0x01;
+	val |= ((divisor % 256) << 16);
+	val |= ((divisor / 256) << 24);
+	sx2010_writel(data, SX2010_REG_CTRL, val);
+	sx2010_writel(data, SX2010_REG_IRQ_ENABLE, 0);
+	sx2010_writel(data, SX2010_REG_GPIO_OUT_ENABLE, data->chip_select);
+	sx2010_writel(data, SX2010_REG_GPIO_OUT, data->chip_select);
+	return 0;
+}
+
+static int sx2010_hw_shutdown(struct sx2010_data *data)
+{
+	sx2010_writel(data, SX2010_REG_CTRL, 0);
+	sx2010_writel(data, SX2010_REG_IRQ_ENABLE, 0);
+	sx2010_writel(data, SX2010_REG_GPIO_OUT_ENABLE, data->chip_select);
+	sx2010_writel(data, SX2010_REG_GPIO_OUT, 0);
+	return 0;
+}
+
+static int sx2010_hw_reset(struct sx2010_data *data)
+{
+	unsigned long timeout;
+	int ret;
+
+	mdelay(SX2010_OST_DELAY_MS);
+
+	data->tx_buf[0] = SX2010_CMD_RESET;
+	ret = sx2010_write_trans(data, 1, 0);
+	if (ret)
+		return ret;
+
+	mdelay(SX2010_OST_DELAY_MS);
+
+	timeout = jiffies + HZ;
+	while ((sx2010_read_reg(data, REG_STAT) & REG_CTRL_MASK) !=
+			REG_CTRL_CONF) {
+		usleep_range(SX2010_OST_DELAY_MS * 1000,
+				SX2010_OST_DELAY_MS * 1000 * 2);
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(data->dev, "SX2010 didn't enter in config mode\n");
+			return -EBUSY;
+		}
+	}
+	return 0;
+}
+
+static int sx2010_hw_probe(struct sx2010_data *data)
+{
+	int ret;
+	u8 val;
+
+	ret = sx2010_hw_startup(data);
+	if (ret)
+		return ret;
+
+	ret = sx2010_hw_reset(data);
+	if (ret)
+		return ret;
+
+	val = sx2010_read_reg(data, REG_CTRL);
+	if ((val & 0x17) != 0x07)
+		return -ENODEV;
+	return 0;
+}
+
+static netdev_tx_t sx2010_start_xmit(struct sk_buff *skb,
+					struct net_device *net)
+{
+	struct sx2010_data *data = netdev_priv(net);
+
+	if (data->tx_skb || data->tx_len) {
+		dev_warn(data->dev, "xmit called while tx busy\n");
+		return NETDEV_TX_BUSY;
+	}
+
+	if (can_dropped_invalid_skb(net, skb))
+		return NETDEV_TX_OK;
+
+	netif_stop_queue(net);
+	data->tx_skb = skb;
+	queue_work(data->wq, &data->tx_work);
+
+	return NETDEV_TX_OK;
+}
+
+static int sx2010_do_set_mode(struct net_device *net, enum can_mode mode)
+{
+	struct sx2010_data *data = netdev_priv(net);
+
+	switch (mode) {
+	case CAN_MODE_START:
+		sx2010_clean(net);
+		data->can.state = CAN_STATE_ERROR_ACTIVE;
+		data->restart_tx = 1;
+		if (data->can.restart_ms == 0)
+			data->after_suspend = SX2010_AFTER_SUSPEND_RESTART;
+		queue_work(data->wq, &data->restart_work);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int sx2010_set_normal_mode(struct sx2010_data *data)
+{
+	unsigned long timeout;
+
+	sx2010_write_reg(data, REG_INTE, REG_INTE_ALL);
+
+	if (data->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
+		sx2010_write_reg(data, REG_CTRL, REG_CTRL_LOOPBACK);
+	} else if (data->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
+		sx2010_write_reg(data, REG_CTRL, REG_CTRL_LISTEN_ONLY);
+	} else {
+		sx2010_write_reg(data, REG_CTRL, REG_CTRL_NORMAL);
+
+		timeout = jiffies + HZ;
+		while (sx2010_read_reg(data, REG_STAT) & REG_CTRL_MASK) {
+			schedule();
+			if (time_after(jiffies, timeout)) {
+				dev_err(data->dev, "SX2010 didn't enter in normal mode\n");
+				return -EBUSY;
+			}
+		}
+	}
+	data->can.state = CAN_STATE_ERROR_ACTIVE;
+	return 0;
+}
+
+static int sx2010_do_set_bittiming(struct net_device *net)
+{
+	struct sx2010_data *data = netdev_priv(net);
+	struct can_bittiming *bt = &data->can.bittiming;
+
+	sx2010_write_reg(data, REG_CFG1, ((bt->sjw - 1) << 6) |
+			  (bt->brp - 1));
+	sx2010_write_reg(data, REG_CFG2, REG_CFG2_BTLMODE |
+			  (data->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES ?
+			   REG_CFG2_SAM : 0) |
+			  ((bt->phase_seg1 - 1) << 3) |
+			  (bt->prop_seg - 1));
+	sx2010_write_bits(data, REG_CFG3, REG_CFG3_PHSEG2_MASK,
+			   (bt->phase_seg2 - 1));
+	dev_dbg(data->dev, "CFG: 0x%02x 0x%02x 0x%02x\n",
+		sx2010_read_reg(data, REG_CFG1),
+		sx2010_read_reg(data, REG_CFG2),
+		sx2010_read_reg(data, REG_CFG3));
+
+	return 0;
+}
+
+static int sx2010_setup(struct net_device *net, struct sx2010_data *data)
+{
+	sx2010_do_set_bittiming(net);
+
+	sx2010_write_reg(data, REG_RXBCTRL(0),
+			  REG_RXBCTRL_BUKT | REG_RXBCTRL_RXM0 | REG_RXBCTRL_RXM1);
+	sx2010_write_reg(data, REG_RXBCTRL(1),
+			  REG_RXBCTRL_RXM0 | REG_RXBCTRL_RXM1);
+	return 0;
+}
+
+static int sx2010_stop(struct net_device *net)
+{
+	struct sx2010_data *data = netdev_priv(net);
+
+	close_candev(net);
+
+	data->force_quit = 1;
+	del_timer(&data->timer);
+
+	mutex_lock(&data->sx_lock);
+
+	sx2010_write_2regs(data, REG_INTE, 0x00, 0x00);
+	sx2010_write_reg(data, REG_TXBCTRL(0), 0);
+	sx2010_clean(net);
+
+	sx2010_hw_sleep(data);
+
+	data->can.state = CAN_STATE_STOPPED;
+
+	mutex_unlock(&data->sx_lock);
+
+	can_led_event(net, CAN_LED_EVENT_STOP);
+	return 0;
+}
+
+static void sx2010_error_skb(struct net_device *net, int can_id, int data1)
+{
+	struct can_frame *frame;
+	struct sk_buff *skb;
+
+	skb = alloc_can_err_skb(net, &frame);
+	if (skb) {
+		frame->can_id |= can_id;
+		frame->data[1] = data1;
+		netif_rx_ni(skb);
+	} else {
+		netdev_err(net, "cannot allocate error skb\n");
+	}
+}
+
+static void sx2010_tx_work_handler(struct work_struct *ws)
+{
+	struct sx2010_data *data = container_of(ws, struct sx2010_data,
+						 tx_work);
+	struct net_device *net = data->net;
+	struct can_frame *frame;
+
+	mutex_lock(&data->sx_lock);
+	if (data->tx_skb) {
+		if (data->can.state == CAN_STATE_BUS_OFF) {
+			sx2010_clean(net);
+		} else {
+			frame = (struct can_frame *)data->tx_skb->data;
+
+			if (frame->can_dlc > SX2010_CAN_MAX_DATA_LEN)
+				frame->can_dlc = SX2010_CAN_MAX_DATA_LEN;
+
+			sx2010_hw_tx(data, frame, 0);
+			data->tx_len = 1 + frame->len;
+			can_put_echo_skb(data->tx_skb, net, 0, 0);
+			data->tx_skb = NULL;
+		}
+	}
+	mutex_unlock(&data->sx_lock);
+}
+
+static void sx2010_restart_work_handler(struct work_struct *ws)
+{
+	struct sx2010_data *data = container_of(ws, struct sx2010_data,
+						 restart_work);
+	struct net_device *net = data->net;
+
+	mutex_lock(&data->sx_lock);
+	if (data->after_suspend) {
+		sx2010_hw_reset(data);
+		sx2010_setup(net, data);
+		data->force_quit = 0;
+		if (data->after_suspend & SX2010_AFTER_SUSPEND_RESTART) {
+			sx2010_set_normal_mode(data);
+		} else if (data->after_suspend & SX2010_AFTER_SUSPEND_UP) {
+			netif_device_attach(net);
+			sx2010_clean(net);
+			sx2010_set_normal_mode(data);
+			netif_wake_queue(net);
+		} else {
+			sx2010_hw_sleep(data);
+		}
+		data->after_suspend = 0;
+	}
+
+	if (data->restart_tx) {
+		data->restart_tx = 0;
+		sx2010_write_reg(data, REG_TXBCTRL(0), 0);
+		sx2010_clean(net);
+		netif_wake_queue(net);
+		sx2010_error_skb(net, CAN_ERR_RESTARTED, 0);
+	}
+	mutex_unlock(&data->sx_lock);
+}
+
+static void sx2010_can_isr(struct timer_list *t)
+{
+	struct sx2010_data *data = from_timer(data, t, timer);
+	struct net_device *net = data->net;
+	int cnt = SX2010_ISR_MAX_CNT;
+
+	if (!mutex_trylock(&data->sx_lock))
+		goto out_without_unlock;
+
+	while (!data->force_quit) {
+		enum can_state new_state;
+		u8 intf, eflag;
+		u8 clear_intf = 0;
+		int can_id = 0, data1 = 0;
+
+		sx2010_read_2regs(data, REG_INTF, &intf, &eflag);
+
+		intf &= REG_INTF_RX | REG_INTF_TX | REG_INTF_ERR;
+
+		if (intf & REG_INTF_RX0)
+			sx2010_hw_rx(data, 0);
+		if (intf & REG_INTF_RX1)
+			sx2010_hw_rx(data, 1);
+
+		if (intf & (REG_INTF_ERR | REG_INTF_TX))
+			clear_intf |= intf & (REG_INTF_ERR | REG_INTF_TX);
+		if (clear_intf)
+			sx2010_write_bits(data, REG_INTF, clear_intf, 0x00);
+		if (eflag & (REG_EFLG_RX0OVR | REG_EFLG_RX1OVR))
+			sx2010_write_bits(data, REG_EFLG, eflag, 0x00);
+
+		if (eflag & REG_EFLG_TXBO) {
+			new_state = CAN_STATE_BUS_OFF;
+			can_id |= CAN_ERR_BUSOFF;
+		} else if (eflag & REG_EFLG_TXEP) {
+			new_state = CAN_STATE_ERROR_PASSIVE;
+			can_id |= CAN_ERR_CRTL;
+			data1 |= CAN_ERR_CRTL_TX_PASSIVE;
+		} else if (eflag & REG_EFLG_RXEP) {
+			new_state = CAN_STATE_ERROR_PASSIVE;
+			can_id |= CAN_ERR_CRTL;
+			data1 |= CAN_ERR_CRTL_RX_PASSIVE;
+		} else if (eflag & REG_EFLG_TXWAR) {
+			new_state = CAN_STATE_ERROR_WARNING;
+			can_id |= CAN_ERR_CRTL;
+			data1 |= CAN_ERR_CRTL_TX_WARNING;
+		} else if (eflag & REG_EFLG_RXWAR) {
+			new_state = CAN_STATE_ERROR_WARNING;
+			can_id |= CAN_ERR_CRTL;
+			data1 |= CAN_ERR_CRTL_RX_WARNING;
+		} else {
+			new_state = CAN_STATE_ERROR_ACTIVE;
+		}
+
+		switch (data->can.state) {
+		case CAN_STATE_ERROR_ACTIVE:
+			if (new_state >= CAN_STATE_ERROR_WARNING &&
+			    new_state <= CAN_STATE_BUS_OFF)
+				data->can.can_stats.error_warning++;
+			fallthrough;
+		case CAN_STATE_ERROR_WARNING:
+			if (new_state >= CAN_STATE_ERROR_PASSIVE &&
+			    new_state <= CAN_STATE_BUS_OFF)
+				data->can.can_stats.error_passive++;
+			break;
+		default:
+			break;
+		}
+		data->can.state = new_state;
+
+		if (intf & REG_INTF_ERR) {
+			if (eflag & (REG_EFLG_RX0OVR | REG_EFLG_RX1OVR)) {
+				if (eflag & REG_EFLG_RX0OVR) {
+					net->stats.rx_over_errors++;
+					net->stats.rx_errors++;
+				}
+				if (eflag & REG_EFLG_RX1OVR) {
+					net->stats.rx_over_errors++;
+					net->stats.rx_errors++;
+				}
+				can_id |= CAN_ERR_CRTL;
+				data1 |= CAN_ERR_CRTL_RX_OVERFLOW;
+			}
+			sx2010_error_skb(net, can_id, data1);
+		}
+
+		if (data->can.state == CAN_STATE_BUS_OFF) {
+			if (data->can.restart_ms == 0) {
+				data->force_quit = 1;
+				data->can.can_stats.bus_off++;
+				can_bus_off(net);
+				sx2010_hw_sleep(data);
+				break;
+			}
+		}
+
+		if (intf == 0)
+			break;
+
+		if (intf & REG_INTF_TX) {
+			net->stats.tx_packets++;
+			net->stats.tx_bytes += data->tx_len - 1;
+			can_led_event(net, CAN_LED_EVENT_TX);
+			if (data->tx_len) {
+				can_get_echo_skb(net, 0, NULL);
+				data->tx_len = 0;
+			}
+			netif_wake_queue(net);
+		}
+
+		if (--cnt <= 0)
+			break;
+	}
+	mutex_unlock(&data->sx_lock);
+
+out_without_unlock:
+	mod_timer(&data->timer, jiffies + SX2010_ISR_TIME);
+}
+
+static int sx2010_open(struct net_device *net)
+{
+	struct sx2010_data *data = netdev_priv(net);
+	int ret;
+
+	ret = open_candev(net);
+	if (ret) {
+		dev_err(data->dev, "unable to set initial baudrate!\n");
+		return ret;
+	}
+
+	mutex_lock(&data->sx_lock);
+
+	data->force_quit = 0;
+	data->tx_skb = NULL;
+	data->tx_len = 0;
+
+	ret = sx2010_hw_reset(data);
+	if (ret)
+		goto out_clean;
+
+	ret = sx2010_setup(net, data);
+	if (ret)
+		goto out_clean;
+
+	ret = sx2010_set_normal_mode(data);
+	if (ret)
+		goto out_clean;
+
+	can_led_event(net, CAN_LED_EVENT_OPEN);
+
+	netif_wake_queue(net);
+	mutex_unlock(&data->sx_lock);
+
+	add_timer(&data->timer);
+	mod_timer(&data->timer, jiffies + SX2010_ISR_TIME);
+	return 0;
+
+out_clean:
+	sx2010_hw_sleep(data);
+	close_candev(net);
+	mutex_unlock(&data->sx_lock);
+	return ret;
+}
+
+static const struct net_device_ops sx2010_netdev_ops = {
+	.ndo_open = sx2010_open,
+	.ndo_stop = sx2010_stop,
+	.ndo_start_xmit = sx2010_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
+};
+
+static int sx2010_read_property(struct sx2010_can_data *data,
+				struct device *dev)
+{
+	int ret;
+
+	ret = device_property_read_u32(dev, "board_id", &data->board_id);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "chl_number", &data->chl_number);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "version", &data->version);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u32(dev, "significand", &data->significand);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "exponent", &data->exponent);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "gpio_input", &data->gpio_input);
+	if (ret < 0)
+		return -EINVAL;
+	ret = device_property_read_u8(dev, "gpio_output", &data->gpio_output);
+	if (ret < 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+
+static struct dentry *sx2010_debugfs;
+#define SX2010_DEBUGFS_FORMAT		"b%d:can%d"
+
+static void sx2010_debugfs_add(struct sx2010_data *data)
+{
+	struct dentry *dir;
+	char name[32];
+
+	snprintf(name, sizeof(name), SX2010_DEBUGFS_FORMAT,
+		data->data.board_id, data->data.chl_number);
+	dir = debugfs_create_dir(name, sx2010_debugfs);
+	debugfs_create_x8("version", 0444, dir, &data->data.version);
+}
+
+static void sx2010_debugfs_remove(struct sx2010_data *data)
+{
+	struct dentry *dir;
+	char name[32];
+
+	snprintf(name, sizeof(name), SX2010_DEBUGFS_FORMAT,
+		data->data.board_id, data->data.chl_number);
+	dir = debugfs_lookup(name, sx2010_debugfs);
+	debugfs_remove_recursive(dir);
+}
+
+static void sx2010_debugfs_init(void)
+{
+	sx2010_debugfs = debugfs_create_dir(DRIVER_NAME, NULL);
+}
+
+static void sx2010_debugfs_exit(void)
+{
+	debugfs_remove(sx2010_debugfs);
+}
+#else
+static void sx2010_debugfs_add(struct sx2010_data *data) {}
+static void sx2010_debugfs_remove(struct sx2010_data *data) {}
+static void sx2010_debugfs_init(void) {}
+static void sx2010_debugfs_exit(void) {}
+#endif
+
+static int sx2010_probe(struct platform_device *pdev)
+{
+	unsigned long long exponent;
+	struct sx2010_data *data;
+	struct net_device *net;
+	struct resource *res;
+	struct device *dev;
+	int ret;
+	int i;
+
+	dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "no resource defined\n");
+		return -EINVAL;
+	}
+
+	net = alloc_candev(sizeof(*data), SX2010_TX_ECHO_SKB_MAX);
+	if (!net)
+		return -ENOMEM;
+
+	data = netdev_priv(net);
+	if (!data)
+		goto err_out_free;
+
+	ret = sx2010_read_property(&data->data, dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to read property\n");
+		goto err_out_free;
+	}
+	data->dev = dev;
+	data->chip_select = data->data.gpio_output;
+	data->res = res;
+
+	exponent = 1;
+	for (i = 0; i < data->data.exponent; i++)
+		exponent *= 10;
+	data->clk_rate = data->data.significand * exponent;
+
+	data->base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!data->base) {
+		ret = -ENOMEM;
+		goto err_out_free;
+	}
+
+	net->netdev_ops = &sx2010_netdev_ops;
+	net->flags |= IFF_ECHO;
+
+	data->can.bittiming_const = &sx2010_bittiming_const;
+	data->can.do_set_mode = sx2010_do_set_mode;
+	data->can.clock.freq = SX2010_FREQUENCY / 2;
+	data->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
+			CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_LISTENONLY;
+
+	data->net = net;
+	platform_set_drvdata(pdev, data);
+
+	data->wq = alloc_workqueue("sx2010_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM,
+					0);
+	if (!data->wq) {
+		ret = -ENOMEM;
+		goto err_out_free;
+	}
+	INIT_WORK(&data->tx_work, sx2010_tx_work_handler);
+	INIT_WORK(&data->restart_work, sx2010_restart_work_handler);
+
+	mutex_init(&data->trans_lock);
+	mutex_init(&data->sx_lock);
+
+	data->tx_buf = devm_kzalloc(data->dev, SX2010_BUF_LEN, GFP_KERNEL);
+	if (!data->tx_buf) {
+		ret = -ENOMEM;
+		goto err_out_probe;
+	}
+
+	data->rx_buf = devm_kzalloc(data->dev, SX2010_BUF_LEN, GFP_KERNEL);
+	if (!data->rx_buf) {
+		ret = -ENOMEM;
+		goto err_out_probe;
+	}
+
+	SET_NETDEV_DEV(net, dev);
+
+	ret = sx2010_hw_probe(data);
+	if (ret) {
+		if (ret == -ENODEV)
+			dev_err(data->dev, "cannot initialize SX2010.\n");
+		goto err_out_probe;
+	}
+
+	sx2010_hw_sleep(data);
+
+	ret = register_candev(net);
+	if (ret)
+		goto err_out_probe;
+
+	devm_can_led_init(net);
+
+	sx2010_debugfs_add(data);
+	timer_setup(&data->timer, sx2010_can_isr, 0);
+	netdev_info(net, "SX2010 successfully initialized.\n");
+	return 0;
+
+err_out_probe:
+	destroy_workqueue(data->wq);
+	data->wq = NULL;
+
+err_out_free:
+	free_candev(net);
+
+	dev_err(dev, "failed to probe, err %d\n", ret);
+	return ret;
+}
+
+static int sx2010_remove(struct platform_device *pdev)
+{
+	struct sx2010_data *data = platform_get_drvdata(pdev);
+	struct net_device *net = data->net;
+
+	sx2010_debugfs_remove(data);
+	del_timer(&data->timer);
+	unregister_candev(net);
+
+	destroy_workqueue(data->wq);
+	data->wq = NULL;
+
+	sx2010_hw_shutdown(data);
+	free_candev(net);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int sx2010_suspend(struct device *dev)
+{
+	struct sx2010_data *data = dev_get_drvdata(dev);
+	struct net_device *net = data->net;
+
+	data->force_quit = 1;
+	del_timer(&data->timer);
+
+	if (netif_running(net)) {
+		netif_device_detach(net);
+
+		sx2010_hw_sleep(data);
+		data->after_suspend = SX2010_AFTER_SUSPEND_UP;
+	} else {
+		data->after_suspend = SX2010_AFTER_SUSPEND_DOWN;
+	}
+
+	sx2010_hw_shutdown(data);
+	return 0;
+}
+
+static int sx2010_resume(struct device *dev)
+{
+	struct sx2010_data *data = dev_get_drvdata(dev);
+
+	sx2010_hw_startup(data);
+
+	if (data->after_suspend & SX2010_AFTER_SUSPEND_UP) {
+		add_timer(&data->timer);
+		mod_timer(&data->timer, jiffies + SX2010_ISR_TIME);
+		queue_work(data->wq, &data->restart_work);
+	} else {
+		data->after_suspend = 0;
+	}
+
+	data->force_quit = 0;
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops sx2010_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sx2010_suspend, sx2010_resume)
+};
+
+static struct platform_driver sx2010_platform_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.pm = &sx2010_pm_ops,
+		.suppress_bind_attrs = true,
+	},
+	.probe = sx2010_probe,
+	.remove = sx2010_remove,
+};
+
+static int __init sx2010_init(void)
+{
+	sx2010_debugfs_init();
+	platform_driver_register(&sx2010_platform_driver);
+	return 0;
+}
+module_init(sx2010_init);
+
+static void __exit sx2010_exit(void)
+{
+	platform_driver_unregister(&sx2010_platform_driver);
+	sx2010_debugfs_exit();
+}
+module_exit(sx2010_exit);
+
+MODULE_AUTHOR("Jason Lee <jason_lee@sunix.com>");
+MODULE_DESCRIPTION("SUNIX SDC CAN controller driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.20.1

