Return-Path: <linux-can+bounces-1147-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4281948BE0
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 11:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558F41F24F22
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038DE165EE3;
	Tue,  6 Aug 2024 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a78hC5os"
X-Original-To: linux-can@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE13146A6F;
	Tue,  6 Aug 2024 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722935041; cv=none; b=byJb63OfJJuQ2c0aZ9u/OUh8Uf5D/Fcl3QYz+ip0KkmqBAswcn4rXmUW+ZmQg576R6GYn18J9Y+l8RwBfNoqeipsdrDQOyo7c0Ht7zJJbWUp23ZJUhlX8dqVWCBElXJVA0VUkSwu+MGNExCh7w9hYZOjr1fNIVsc0uGZ9GcidCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722935041; c=relaxed/simple;
	bh=QUs/mtg1M0nKkGv9wzMY/JHT+ula+pf+wIBXs+MKVdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K1EqMXG6Jm3I4+u1stxWZrhy0+pz1l+lDTdyZcpzUETyD8BEYM7EKf6GmWtg4QRwfaWJ0+KU6Toh1cCj9ZRjSJ6hXwm2iGbNy8vC4Vlt0dXgChipEvxvO2Xx6NvQv3cv3kkFsBJgKxsN5Q2T45ACqVLE/OXDXzsf9f280KCyr/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a78hC5os; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475MgNY7027196;
	Tue, 6 Aug 2024 09:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YovUT7xaTMua48TJpa1rlx5iN5zPetc2W8m
	ov6k3AQM=; b=a78hC5osfhzH9EQryZiTbZs+ujlVMlisGMhx5lXYES7Nok1tear
	+MEZ58JRFRlGgAyF7Ou8K4dgv61lrCOT8miH58Wk/w0hmoXnjK4jTecuYf2ClcR2
	u9oUHY8tWAUW0NTuqMxnrLM5NpJGde2Hw1n/3S/CHnNyUQdWizV+PROKgHir5yI5
	RDIG94fsPkw8ydnE6YKnSHf/HY9Fqgbw5eLf5+JFDhJSz4S7sqFwZA704HZS9iPX
	x/sJ9PYU6H1L8QwC270PWelOiRCKbp/FBIYq9MitjDjJdDDxrNcFS7eVQrJ/UBW1
	sgf2f1BcK9uTngFaVh5y7cjsFl19sXVcSDg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scx6pt75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 09:03:47 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 47693gv2023927;
	Tue, 6 Aug 2024 09:03:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40sdmm01fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 09:03:42 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47693gRT023922;
	Tue, 6 Aug 2024 09:03:42 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-anupkulk-hyd.qualcomm.com [10.147.247.84])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 47693gDm023920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 09:03:42 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 4405423)
	id 9B5D22108C; Tue,  6 Aug 2024 14:33:41 +0530 (+0530)
From: Anup Kulkarni <quic_anupkulk@quicinc.com>
To: mkl@pengutronix.de, manivannan.sadhasivam@linaro.org,
        thomas.kopp@microchip.com, mailhol.vincent@wanadoo.fr,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vdadhani@quicinc.com,
        Anup Kulkarni <quic_anupkulk@quicinc.com>
Subject: [PATCH v1] can: mcp251xfd: Enable transceiver using gpio
Date: Tue,  6 Aug 2024 14:33:39 +0530
Message-Id: <20240806090339.785712-1-quic_anupkulk@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LdWfWdB54Lj6MssZ8O-Cii23-6d07SJ7
X-Proofpoint-GUID: LdWfWdB54Lj6MssZ8O-Cii23-6d07SJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_07,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=965 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060064

Ensure the CAN transceiver is active during mcp251xfd_open() and
inactive during mcp251xfd_close() by utilizing
mcp251xfd_transceiver_mode(). Adjust GPIO_0 to switch between
NORMAL and STANDBY modes of transceiver.

Signed-off-by: Anup Kulkarni <quic_anupkulk@quicinc.com>
---
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 32 +++++++++++++++++++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |  7 ++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3e7526274e34..3b56dc1721a5 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -153,6 +153,25 @@ static inline int mcp251xfd_vdd_disable(const struct mcp251xfd_priv *priv)
 	return regulator_disable(priv->reg_vdd);
 }
 
+static int
+mcp251xfd_transceiver_mode(const struct mcp251xfd_priv *priv,
+			   const enum mcp251xfd_xceiver_mode mode)
+{
+	int val, pmode, latch;
+
+	if (mode == MCP251XFD_XCVR_NORMAL_MODE) {
+		pmode = MCP251XFD_REG_IOCON_PM0;
+		latch = 0;
+	} else if (mode == MCP251XFD_XCVR_STBY_MODE) {
+		pmode = MCP251XFD_REG_IOCON_PM0;
+		latch = MCP251XFD_REG_IOCON_LAT0;
+	} else {
+		return -EINVAL;
+	}
+	val = (pmode | latch) << priv->transceiver_pin;
+	return regmap_write(priv->map_reg, MCP251XFD_REG_IOCON, val);
+}
+
 static inline int
 mcp251xfd_transceiver_enable(const struct mcp251xfd_priv *priv)
 {
@@ -1620,6 +1639,10 @@ static int mcp251xfd_open(struct net_device *ndev)
 	if (err)
 		goto out_transceiver_disable;
 
+	err = mcp251xfd_transceiver_mode(priv, MCP251XFD_XCVR_NORMAL_MODE);
+	if (err)
+		goto out_transceiver_disable;
+
 	clear_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	can_rx_offload_enable(&priv->offload);
 
@@ -1668,6 +1691,7 @@ static int mcp251xfd_open(struct net_device *ndev)
 
 static int mcp251xfd_stop(struct net_device *ndev)
 {
+	int err;
 	struct mcp251xfd_priv *priv = netdev_priv(ndev);
 
 	netif_stop_queue(ndev);
@@ -1678,6 +1702,9 @@ static int mcp251xfd_stop(struct net_device *ndev)
 	free_irq(ndev->irq, priv);
 	destroy_workqueue(priv->wq);
 	can_rx_offload_disable(&priv->offload);
+	err = mcp251xfd_transceiver_mode(priv, MCP251XFD_XCVR_STBY_MODE);
+	if (err)
+		return err;
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 	mcp251xfd_transceiver_disable(priv);
 	mcp251xfd_ring_free(priv);
@@ -2051,6 +2078,11 @@ static int mcp251xfd_probe(struct spi_device *spi)
 					     "Failed to get clock-frequency!\n");
 	}
 
+	err = device_property_read_u32(&spi->dev, "gpio-transceiver-pin", &priv->transceiver_pin);
+		if (err)
+			return dev_err_probe(&spi->dev, err,
+					     "Failed to get gpio transceiver pin!\n");
+
 	/* Sanity check */
 	if (freq < MCP251XFD_SYSCLOCK_HZ_MIN ||
 	    freq > MCP251XFD_SYSCLOCK_HZ_MAX) {
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index dcbbd2b2fae8..14b086814bdb 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -614,6 +614,12 @@ enum mcp251xfd_flags {
 	__MCP251XFD_FLAGS_SIZE__
 };
 
+enum mcp251xfd_xceiver_mode {
+	MCP251XFD_XCVR_NORMAL_MODE,
+	MCP251XFD_XCVR_STBY_MODE,
+	MCP251XFD_XCVR_MODE_NONE
+};
+
 struct mcp251xfd_priv {
 	struct can_priv can;
 	struct can_rx_offload offload;
@@ -670,6 +676,7 @@ struct mcp251xfd_priv {
 
 	struct mcp251xfd_devtype_data devtype_data;
 	struct can_berr_counter bec;
+	u32 transceiver_pin;
 };
 
 #define MCP251XFD_IS(_model) \
-- 
2.25.1


