Return-Path: <linux-can+bounces-1141-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB070948A84
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67317283595
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6B51BBBF5;
	Tue,  6 Aug 2024 07:47:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9190E1BCA02
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930469; cv=none; b=qF4oIKZgJxMpYXu0QV3/dwVC7qCuL8x6PZpJRkOLsSJfW8kFV+1/ozhX1oAiwRvHOB8JnJbxQvN//G2YuKvXhT3UFVq6c0uhSe4dWjOLQh55fbdqyqFeCoQtFN2Q2QSjIFcKDWfQ968b1tbqsToaWGO5hnQ6TgNIxuikzT5x8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930469; c=relaxed/simple;
	bh=Fahyxk3NIVEwhKQ4W2C0MWAgxEWvb3NSgEKciGH900Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPyMI5yZccZXRAjJ1lVCuXJtLt8Afe+q5rGQ8G9th/66n+SdxUgPWPRunIrQ6MMw9f5G9aV5cMlt2AoIXhqWyALiOT/crjzFUFkQnkK8xVdf3lrtXcRlBElal9r20Lq0xuJogK5SeOmE/glauQ3nzvasz2mpzLtVcjVzhgET5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEv1-00049B-6r
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:43 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEux-004tw1-As
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:39 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id F2AF8317A1F
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 4475031799F;
	Tue, 06 Aug 2024 07:47:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ce62a453;
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
Subject: [PATCH net-next 19/20] can: kvaser_usb: Remove struct variables kvaser_usb_{ethtool,netdev}_ops
Date: Tue,  6 Aug 2024 09:42:10 +0200
Message-ID: <20240806074731.1905378-20-mkl@pengutronix.de>
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

Remove no longer used struct variables, kvaser_usb_ethtool_ops and
kvaser_usb_netdev_ops.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-15-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index a4f32d57173a..4b6c23121b5d 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -753,13 +753,6 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static const struct net_device_ops kvaser_usb_netdev_ops = {
-	.ndo_open = kvaser_usb_open,
-	.ndo_stop = kvaser_usb_close,
-	.ndo_start_xmit = kvaser_usb_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
-};
-
 static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
 	.ndo_open = kvaser_usb_open,
 	.ndo_stop = kvaser_usb_close,
@@ -768,10 +761,6 @@ static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
-static const struct ethtool_ops kvaser_usb_ethtool_ops = {
-	.get_ts_info = ethtool_op_get_ts_info,
-};
-
 static const struct ethtool_ops kvaser_usb_ethtool_ops_hwts = {
 	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
-- 
2.43.0



