Return-Path: <linux-can+bounces-2583-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1F5A08F4C
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 12:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C640B3AA10C
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C520D514;
	Fri, 10 Jan 2025 11:27:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C1220CCD0
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508447; cv=none; b=QEfrn/sN8NZWnjrBq+sXNkGBSY3bt+s9xWCFEZ60TM3rt8Atx1TCnOwrLGd0iC30qZvfcRLN1qw/aP3Ai5eoJW1fSkOawlzmdxqBwm770dNWXPEUaQokISgqGvjWtyvH0mWrJG+O8lIlFq3SHdiLNVWRaJMdCyskw2CMzYk2JMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508447; c=relaxed/simple;
	bh=LKMY+58YuDKopatvbzVpOgVlxOBoe4b7lkKRqONbJdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpG4N6aoE98CBLBZTo0Rx1GMc3X1T7WefgrbTu/81zxFhlA3btoe4rQk/US634PR/FDFqcNg1ujH3wfBwCaNnN0GSGd1OaMGV8KM5rN+VpCL5KUY2mYYpb9Ngvk+XNs4RPdVXqaNYi2W4Y7t54rknodkgB/aKwNu8zSI0BsDf0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAg-00055o-FK
	for linux-can@vger.kernel.org; Fri, 10 Jan 2025 12:27:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAd-0009if-2Z
	for linux-can@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:19 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6C6B53A4621
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 9FC8A3A45B2;
	Fri, 10 Jan 2025 11:27:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 207bb45c;
	Fri, 10 Jan 2025 11:27:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Alison Below <alisonbelow@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 18/18] can: kvaser_pciefd: Add support for CAN_CTRLMODE_BERR_REPORTING
Date: Fri, 10 Jan 2025 12:04:26 +0100
Message-ID: <20250110112712.3214173-19-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110112712.3214173-1-mkl@pengutronix.de>
References: <20250110112712.3214173-1-mkl@pengutronix.de>
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

From: Jimmy Assarsson <extja@kvaser.com>

Add support for CAN_CTRLMODE_BERR_REPORTING,
allowing Bus Error Reporting to be enabled or disabled.
Previously, Bus Error Reporting was always active.

Co-developed-by: Alison Below <alisonbelow@gmail.com>
Signed-off-by: Alison Below <alisonbelow@gmail.com>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20241230142645.128244-4-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index e12ff12c4ba3..fa04a7ced02b 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -999,7 +999,8 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 					      CAN_CTRLMODE_FD |
 					      CAN_CTRLMODE_FD_NON_ISO |
-					      CAN_CTRLMODE_CC_LEN8_DLC;
+					      CAN_CTRLMODE_CC_LEN8_DLC |
+					      CAN_CTRLMODE_BERR_REPORTING;
 
 		status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
 		if (!(status & KVASER_PCIEFD_KCAN_STAT_FD)) {
@@ -1304,7 +1305,7 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	struct can_berr_counter bec;
 	enum can_state old_state, new_state, tx_state, rx_state;
 	struct net_device *ndev = can->can.dev;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	struct can_frame *cf = NULL;
 
 	old_state = can->can.state;
@@ -1313,7 +1314,8 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	bec.rxerr = FIELD_GET(KVASER_PCIEFD_SPACK_RXERR_MASK, p->header[0]);
 
 	kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state, &rx_state);
-	skb = alloc_can_err_skb(ndev, &cf);
+	if (can->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		skb = alloc_can_err_skb(ndev, &cf);
 	if (new_state != old_state) {
 		kvaser_pciefd_change_state(can, &bec, cf, new_state, tx_state, rx_state);
 	}
@@ -1328,18 +1330,19 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	can->bec.txerr = bec.txerr;
 	can->bec.rxerr = bec.rxerr;
 
-	if (!skb) {
-		ndev->stats.rx_dropped++;
-		return -ENOMEM;
+	if (can->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
+		if (!skb) {
+			netdev_warn(ndev, "No memory left for err_skb\n");
+			ndev->stats.rx_dropped++;
+			return -ENOMEM;
+		}
+		kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
+		cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
+		cf->data[6] = bec.txerr;
+		cf->data[7] = bec.rxerr;
+		netif_rx(skb);
 	}
 
-	kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
-	cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
-	cf->data[6] = bec.txerr;
-	cf->data[7] = bec.rxerr;
-
-	netif_rx(skb);
-
 	return 0;
 }
 
-- 
2.45.2



