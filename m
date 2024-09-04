Return-Path: <linux-can+bounces-1372-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C73996B724
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 11:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C028D1F21354
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA8A1D0144;
	Wed,  4 Sep 2024 09:42:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F281CF7B9
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442956; cv=none; b=CHAor6QGhUQPRsyTWNJzDU6g11FwHRtgwHhnHyQZsHMyinJ748zbtjm1XCafBs5mO7Tia418FEGBPzZcEA63TcM7fC/Bji6BM9qHjuE8/L+Rnymw6FHtVa2l8zexoSB2T28U9VcXOJrUDxdfQyvJHJhpUs/tSBBZDEZ5SFzLV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442956; c=relaxed/simple;
	bh=ELOsZ/AQIFrsBD5OKeVFRVp2sSQOp7Xb7nFSiqKgfbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A00G4JcwL5lVcMRr5wGBhhi/7obtISZwbSATy1RRw2siycGEDj2wO9VD6L2Ehv65MuldyfWHlq20wuE+aFAdihZKag+zRM7AoShWcZicxaTLBNp3dk+I15fQbFJV1lg6sWpWEqFrKsnA9vUrmFVFO17GMewxCxp1CG2t87q0DHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmX1-0004VH-SB
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 11:42:31 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmWy-005QDB-Ed
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 11:42:28 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0833933240D
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 09:42:27 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 9FF58332384;
	Wed, 04 Sep 2024 09:42:23 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5eef5b4e;
	Wed, 4 Sep 2024 09:42:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alibek Omarov <a1ba.omarov@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH net-next 20/20] can: rockchip_canfd: add support for CAN_CTRLMODE_BERR_REPORTING
Date: Wed,  4 Sep 2024 11:38:55 +0200
Message-ID: <20240904094218.1925386-21-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904094218.1925386-1-mkl@pengutronix.de>
References: <20240904094218.1925386-1-mkl@pengutronix.de>
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

Add support for Bus Error Reporting.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20240904-rockchip-canfd-v5-20-8ae22bcb27cc@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/rockchip/rockchip_canfd-core.c    | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 8853f6a135da..6883153e8fc1 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -293,6 +293,12 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 		RKCANFD_REG_INT_OVERLOAD_INT |
 		RKCANFD_REG_INT_TX_FINISH_INT;
 
+	/* Do not mask the bus error interrupt if the bus error
+	 * reporting is requested.
+	 */
+	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
+		priv->reg_int_mask_default |= RKCANFD_REG_INT_ERROR_INT;
+
 	memset(&priv->bec, 0x0, sizeof(priv->bec));
 
 	rkcanfd_chip_fifo_setup(priv);
@@ -533,14 +539,16 @@ static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
 	if (!reg_ec)
 		return 0;
 
-	skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
-	if (cf) {
-		struct can_berr_counter bec;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
+		skb = rkcanfd_alloc_can_err_skb(priv, &cf, &timestamp);
+		if (cf) {
+			struct can_berr_counter bec;
 
-		rkcanfd_get_berr_counter_corrected(priv, &bec);
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
-		cf->data[6] = bec.txerr;
-		cf->data[7] = bec.rxerr;
+			rkcanfd_get_berr_counter_corrected(priv, &bec);
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
+			cf->data[6] = bec.txerr;
+			cf->data[7] = bec.rxerr;
+		}
 	}
 
 	rkcanfd_handle_error_int_reg_ec(priv, cf, reg_ec);
@@ -899,7 +907,8 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.clock.freq = clk_get_rate(priv->clks[0].clk);
 	priv->can.bittiming_const = &rkcanfd_bittiming_const;
 	priv->can.data_bittiming_const = &rkcanfd_data_bittiming_const;
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+		CAN_CTRLMODE_BERR_REPORTING;
 	if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_CANFD_BROKEN))
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	priv->can.do_set_mode = rkcanfd_set_mode;
-- 
2.45.2



