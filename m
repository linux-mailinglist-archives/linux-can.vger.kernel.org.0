Return-Path: <linux-can+bounces-325-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA95A85B5F3
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 09:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4010FB2516A
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584EB60DF0;
	Tue, 20 Feb 2024 08:51:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865815FB98
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419100; cv=none; b=ZMRM+3GAgpfyGuQqCcBLU+u5ZDEOhQUNw3gRDi7JsN9b3nwCfoZmxLgg7hzzg90xwqhkIaayjimfBh05gKt7FkzSyYTMxH018M70JAfej0TY3nl6wS1fblro8DxIZyAFSmtWqTJZHD40i4lgIl2QgQvpOhEu2RofbmYBCnWTJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419100; c=relaxed/simple;
	bh=1bxkSurXBLVq4kIZixWJL+mdZ0wUqydq8VIXgXWCY2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/nWqlbKW7RgI2jPdhXGhWWSV1BTx3btuoZE+HQl425xb4r/v7AGhpV8tf7UP2g2wMZpif4iCs7WaJW7BcUOoRlChKEQTA8J3LIPaft01yRW+OOfBo1pU1/OAxqH1ArBL6p35BYkfYd5+sxeIcShLoC0OYbPLubZFRE2ET6nbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqi-0001ge-Rm
	for linux-can@vger.kernel.org; Tue, 20 Feb 2024 09:51:36 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rcLqh-001oG7-NI
	for linux-can@vger.kernel.org; Tue, 20 Feb 2024 09:51:35 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 652B7292F28
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 08:51:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id EDA13292EEB;
	Tue, 20 Feb 2024 08:51:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f0fcb08b;
	Tue, 20 Feb 2024 08:51:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Srinivas Goud <srinivas.goud@amd.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 7/9] can: xilinx_can: Add ethtool stats interface for ECC errors
Date: Tue, 20 Feb 2024 09:46:09 +0100
Message-ID: <20240220085130.2936533-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220085130.2936533-1-mkl@pengutronix.de>
References: <20240220085130.2936533-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Srinivas Goud <srinivas.goud@amd.com>

Add ethtool stats interface for reading FIFO 1bit/2bit ECC errors
information.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
Link: https://lore.kernel.org/all/20240213-xilinx_ecc-v8-3-8d75f8b80771@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 64 ++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index af2af4eade3c..fae0120473f8 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -228,6 +228,7 @@ struct xcan_devtype_data {
  * @transceiver:		Optional pointer to associated CAN transceiver
  * @rstc:			Pointer to reset control
  * @ecc_enable:			ECC enable flag
+ * @syncp:			synchronization for ECC error stats
  * @ecc_rx_2_bit_errors:	RXFIFO 2bit ECC count
  * @ecc_rx_1_bit_errors:	RXFIFO 1bit ECC count
  * @ecc_txol_2_bit_errors:	TXOLFIFO 2bit ECC count
@@ -254,6 +255,7 @@ struct xcan_priv {
 	struct phy *transceiver;
 	struct reset_control *rstc;
 	bool ecc_enable;
+	struct u64_stats_sync syncp;
 	u64_stats_t ecc_rx_2_bit_errors;
 	u64_stats_t ecc_rx_1_bit_errors;
 	u64_stats_t ecc_txol_2_bit_errors;
@@ -347,6 +349,24 @@ static const struct can_tdc_const xcan_tdc_const_canfd2 = {
 	.tdcf_max = 0,
 };
 
+enum xcan_stats_type {
+	XCAN_ECC_RX_2_BIT_ERRORS,
+	XCAN_ECC_RX_1_BIT_ERRORS,
+	XCAN_ECC_TXOL_2_BIT_ERRORS,
+	XCAN_ECC_TXOL_1_BIT_ERRORS,
+	XCAN_ECC_TXTL_2_BIT_ERRORS,
+	XCAN_ECC_TXTL_1_BIT_ERRORS,
+};
+
+static const char xcan_priv_flags_strings[][ETH_GSTRING_LEN] = {
+	[XCAN_ECC_RX_2_BIT_ERRORS] = "ecc_rx_2_bit_errors",
+	[XCAN_ECC_RX_1_BIT_ERRORS] = "ecc_rx_1_bit_errors",
+	[XCAN_ECC_TXOL_2_BIT_ERRORS] = "ecc_txol_2_bit_errors",
+	[XCAN_ECC_TXOL_1_BIT_ERRORS] = "ecc_txol_1_bit_errors",
+	[XCAN_ECC_TXTL_2_BIT_ERRORS] = "ecc_txtl_2_bit_errors",
+	[XCAN_ECC_TXTL_1_BIT_ERRORS] = "ecc_txtl_1_bit_errors",
+};
+
 /**
  * xcan_write_reg_le - Write a value to the device register little endian
  * @priv:	Driver private data structure
@@ -1182,6 +1202,8 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
 				XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
 
+		u64_stats_update_begin(&priv->syncp);
+
 		if (isr & XCAN_IXR_E2BERX_MASK) {
 			u64_stats_add(&priv->ecc_rx_2_bit_errors,
 				      FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_rx_ecc));
@@ -1211,6 +1233,8 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 			u64_stats_add(&priv->ecc_txtl_1_bit_errors,
 				      FIELD_GET(XCAN_ECC_1BIT_CNT_MASK, reg_txtl_ecc));
 		}
+
+		u64_stats_update_end(&priv->syncp);
 	}
 
 	if (cf.can_id) {
@@ -1637,6 +1661,43 @@ static int xcan_get_auto_tdcv(const struct net_device *ndev, u32 *tdcv)
 	return 0;
 }
 
+static void xcan_get_strings(struct net_device *ndev, u32 stringset, u8 *buf)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		memcpy(buf, &xcan_priv_flags_strings,
+		       sizeof(xcan_priv_flags_strings));
+	}
+}
+
+static int xcan_get_sset_count(struct net_device *netdev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(xcan_priv_flags_strings);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void xcan_get_ethtool_stats(struct net_device *ndev,
+				   struct ethtool_stats *stats, u64 *data)
+{
+	struct xcan_priv *priv = netdev_priv(ndev);
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&priv->syncp);
+
+		data[XCAN_ECC_RX_2_BIT_ERRORS] = u64_stats_read(&priv->ecc_rx_2_bit_errors);
+		data[XCAN_ECC_RX_1_BIT_ERRORS] = u64_stats_read(&priv->ecc_rx_1_bit_errors);
+		data[XCAN_ECC_TXOL_2_BIT_ERRORS] = u64_stats_read(&priv->ecc_txol_2_bit_errors);
+		data[XCAN_ECC_TXOL_1_BIT_ERRORS] = u64_stats_read(&priv->ecc_txol_1_bit_errors);
+		data[XCAN_ECC_TXTL_2_BIT_ERRORS] = u64_stats_read(&priv->ecc_txtl_2_bit_errors);
+		data[XCAN_ECC_TXTL_1_BIT_ERRORS] = u64_stats_read(&priv->ecc_txtl_1_bit_errors);
+	} while (u64_stats_fetch_retry(&priv->syncp, start));
+}
+
 static const struct net_device_ops xcan_netdev_ops = {
 	.ndo_open	= xcan_open,
 	.ndo_stop	= xcan_close,
@@ -1646,6 +1707,9 @@ static const struct net_device_ops xcan_netdev_ops = {
 
 static const struct ethtool_ops xcan_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
+	.get_strings = xcan_get_strings,
+	.get_sset_count = xcan_get_sset_count,
+	.get_ethtool_stats = xcan_get_ethtool_stats,
 };
 
 /**
-- 
2.43.0



