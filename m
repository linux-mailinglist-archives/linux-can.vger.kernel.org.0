Return-Path: <linux-can+bounces-5238-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC46BF217D
	for <lists+linux-can@lfdr.de>; Mon, 20 Oct 2025 17:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52A324F9C89
	for <lists+linux-can@lfdr.de>; Mon, 20 Oct 2025 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A4E264FB5;
	Mon, 20 Oct 2025 15:25:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2115269D17
	for <linux-can@vger.kernel.org>; Mon, 20 Oct 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973928; cv=none; b=GREAtu2G0yYtvW5O866vsh+Wt7wjKM3qmWVRsER9Wfz+5bIMYr6+DKKrlCAazdaYeMCHYOpz7677M/8/MiBBudPo4ZD3/7H03IMDVhnfxELqxfCYP6uOgg4Bnaj8QdtEsH0BuFxPAjwy6g5HGgBYWyCXHeomyL57vSlDxgyzths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973928; c=relaxed/simple;
	bh=U9VccAxV+pFSFbIU2BZNZbB1fmDD+GL1FWRoPlRjvb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bj4VgHLJAqIl6yFeVf32BrcBqESipgoYYIe+ZXXLo79Y5aEQVQhI5p+4uzQ3a1oK78J3dEhFPTecwKjBJ7VzpYy+AK7/m9YHePNFxwo20lYrrzGjg6AfXoADrjhbjZWE16yTRv2hgjOOE6+pzQX4mmiiiQQlqL6x0hZeqHC10aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vArlC-0005Af-8U; Mon, 20 Oct 2025 17:25:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vArlB-004ZUJ-1Y;
	Mon, 20 Oct 2025 17:25:21 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 267C048B59A;
	Mon, 20 Oct 2025 15:25:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/4] can: esd: acc_start_xmit(): use can_dev_dropped_skb() instead of can_dropped_invalid_skb()
Date: Mon, 20 Oct 2025 17:22:23 +0200
Message-ID: <20251020152516.1590553-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020152516.1590553-1-mkl@pengutronix.de>
References: <20251020152516.1590553-1-mkl@pengutronix.de>
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

In addition to can_dropped_invalid_skb(), the helper function
can_dev_dropped_skb() checks whether the device is in listen-only mode and
discards the skb accordingly.

Replace can_dropped_invalid_skb() by can_dev_dropped_skb() to also drop
skbs in for listen-only mode.

Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/all/20251017-bizarre-enchanted-quokka-f3c704-mkl@pengutronix.de/
Fixes: 9721866f07e1 ("can: esd: add support for esd GmbH PCIe/402 CAN interface family")
Link: https://patch.msgid.link/20251017-fix-skb-drop-check-v1-2-556665793fa4@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/esd/esdacc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index c80032bc1a52..73e66f9a3781 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -254,7 +254,7 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	u32 acc_id;
 	u32 acc_dlc;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* Access core->tx_fifo_tail only once because it may be changed
-- 
2.51.0


