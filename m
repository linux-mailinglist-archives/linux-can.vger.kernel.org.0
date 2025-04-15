Return-Path: <linux-can+bounces-3404-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C76A89A5B
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 12:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45BD7A6914
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975D9284691;
	Tue, 15 Apr 2025 10:34:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089CC27EC9A
	for <linux-can@vger.kernel.org>; Tue, 15 Apr 2025 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713248; cv=none; b=LNFJGcH1ByGHSkbGLFOaCjplOuRoJWvtWbhDWPl9Oxb7LW0NSxH1qTN8OuKGP7SyYmXj2yz2eXC6ZwdOvFjgy5ApwHMRJZFW9FtL0tfjtgtj3VavqfVgbnq3fU+hXEdX8L73XQQQ+nuxslUY13PjfuIowvVb+f2TFU1ZboFtmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713248; c=relaxed/simple;
	bh=/cAoqqJiceTtsveDOFFXsiASt1G0/g0AKzPnXXGy5uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGPGK0eF92rpe5lT0/VarZwQBuUUlngNtJc4IuqsjGBNVa+68quy1n55B5Vni9GrhOXZJOzF0x3Slv/NYggtBTb66kgfn194Pi4eOLHRMcJpdpHpZfY1jYBtGVrlVJS3B7410v9YQ3zedN/nhHpKPaZnFHQYYUX1DODPcZuYRZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4dcD-0006Ot-8N
	for linux-can@vger.kernel.org; Tue, 15 Apr 2025 12:34:05 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4dcD-000P55-05
	for linux-can@vger.kernel.org;
	Tue, 15 Apr 2025 12:34:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B2FD13F9BE6
	for <linux-can@vger.kernel.org>; Tue, 15 Apr 2025 10:34:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 381593F9BD5;
	Tue, 15 Apr 2025 10:34:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4df992a3;
	Tue, 15 Apr 2025 10:34:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Weizhao Ouyang <o451686892@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/2] can: rockchip_canfd: fix broken quirks checks
Date: Tue, 15 Apr 2025 12:31:45 +0200
Message-ID: <20250415103401.445981-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250415103401.445981-1-mkl@pengutronix.de>
References: <20250415103401.445981-1-mkl@pengutronix.de>
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

From: Weizhao Ouyang <o451686892@gmail.com>

First get the devtype_data then check quirks.

Fixes: bbdffb341498 ("can: rockchip_canfd: add quirk for broken CAN-FD support")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250324114416.10160-1-o451686892@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 46201c126703..7107a37da36c 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -902,15 +902,16 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.data_bittiming_const = &rkcanfd_data_bittiming_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_BERR_REPORTING;
-	if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_CANFD_BROKEN))
-		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	priv->can.do_set_mode = rkcanfd_set_mode;
 	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
 	priv->ndev = ndev;
 
 	match = device_get_match_data(&pdev->dev);
-	if (match)
+	if (match) {
 		priv->devtype_data = *(struct rkcanfd_devtype_data *)match;
+		if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_CANFD_BROKEN))
+			priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
+	}
 
 	err = can_rx_offload_add_manual(ndev, &priv->offload,
 					RKCANFD_NAPI_WEIGHT);
-- 
2.47.2



