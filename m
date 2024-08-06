Return-Path: <linux-can+bounces-1146-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9331948A8C
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BFC1F213A0
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416991C0DC5;
	Tue,  6 Aug 2024 07:47:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9F1BCA15
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930470; cv=none; b=D5F+kmcrsjO7aMfcYE72Ak2+q9d1cMWMvqrzOgZ/bxi89lu9H9vZlJK/ywya4KGj4vmG55ORs0i8EjV1gcFBwGarA+BhejV1Tr2x6ytUIsypqLYITdFDCqEXXQLTVtXQ16Gn079b+Hp740MzganKrQBR+WCMKgOCiq4z/LwDIik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930470; c=relaxed/simple;
	bh=oTenZEw0y91NOffRMByZkFbTkTce9t97v+R+3ORoKrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkUM4YvwnKCmkHXOd6W0gKs0t/iiDJvz4m/tlim+QGY+LxeSnNGBRSiQnh1JHE3EHcGMfn68vKX1UtEUsYH1D3JsK1PiF81uDov4h3Zgyk+BaMJlMsHP14NV6EA8D1Q+Pfi1eVGklva+m7g6gI2XnJpByYH++dt4JZH6PVB5nio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEv2-00049C-8C
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:44 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEux-004tw2-As
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:39 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id F2CC7317A20
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5300C3179A0;
	Tue, 06 Aug 2024 07:47:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 81415b32;
	Tue, 6 Aug 2024 07:47:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 20/20] can: kvaser_usb: Rename kvaser_usb_{ethtool,netdev}_ops_hwts to kvaser_usb_{ethtool,netdev}_ops
Date: Tue,  6 Aug 2024 09:42:11 +0200
Message-ID: <20240806074731.1905378-21-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806074731.1905378-1-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
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

Now when we only got one set of ethtool_ops and netdev_ops, remove the
"hwts" suffix from the struct variables
kvaser_usb_{ethtool,netdev}_ops_hwts.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-16-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 4b6c23121b5d..35b4132b0639 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -753,7 +753,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
+static const struct net_device_ops kvaser_usb_netdev_ops = {
 	.ndo_open = kvaser_usb_open,
 	.ndo_stop = kvaser_usb_close,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
@@ -761,7 +761,7 @@ static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
-static const struct ethtool_ops kvaser_usb_ethtool_ops_hwts = {
+static const struct ethtool_ops kvaser_usb_ethtool_ops = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
@@ -847,8 +847,8 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 
 	netdev->flags |= IFF_ECHO;
 
-	netdev->netdev_ops = &kvaser_usb_netdev_ops_hwts;
-	netdev->ethtool_ops = &kvaser_usb_ethtool_ops_hwts;
+	netdev->netdev_ops = &kvaser_usb_netdev_ops;
+	netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
 	netdev->dev_id = channel;
 
-- 
2.43.0



