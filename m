Return-Path: <linux-can+bounces-1435-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE91970DF6
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 08:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47556B20F25
	for <lists+linux-can@lfdr.de>; Mon,  9 Sep 2024 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32D81AC8A5;
	Mon,  9 Sep 2024 06:37:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F247176FAC
	for <linux-can@vger.kernel.org>; Mon,  9 Sep 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725863825; cv=none; b=KBGMZBYKQoYI0VHTH47vfhWkSf8lPjrP2ZjEuCFqYIb0zW0AN+QF3Z+79+LL12V1HGn9t/+VohOuykMLBWQt5osigJvXvpB5lHMr0V/RX/MJNzPUFz3b7EH0hq4luxFx/BCEEZh3nKH2SkynSO7DM9QCyDcnkdJ7Fby6pWp2jBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725863825; c=relaxed/simple;
	bh=ESIdYawT6iTFsVfHEvwVsj4dazGHx82sjrfidJ5W/Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHI46Ot8R/WJawbF+J997R1a/uHgPpTa+/0vVx83dF2cg5wfs4GZQ8KqygaCide5/xuySL9AY9GuOPVPMXunwuSNXITuDyryfoR7e69QNjFBx9mDCPun19yL3uUEL8cW2HIfNzXooSZxoAlPKxZ8QLIHj9mqMWdHEudgfrsoJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snY1G-0005wB-E1
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 08:37:02 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snY1F-006aXM-Rf
	for linux-can@vger.kernel.org; Mon, 09 Sep 2024 08:37:01 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 89633336451
	for <linux-can@vger.kernel.org>; Mon, 09 Sep 2024 06:37:01 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1CC4833643A;
	Mon, 09 Sep 2024 06:37:00 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b16b3ef0;
	Mon, 9 Sep 2024 06:36:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Nathan Chancellor <nathan@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 2/3] can: rockchip_canfd: fix return type of rkcanfd_start_xmit()
Date: Mon,  9 Sep 2024 08:33:54 +0200
Message-ID: <20240909063657.2287493-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909063657.2287493-1-mkl@pengutronix.de>
References: <20240909063657.2287493-1-mkl@pengutronix.de>
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

From: Nathan Chancellor <nathan@kernel.org>

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed. A
warning in clang aims to catch these at compile time, which reveals:

  drivers/net/can/rockchip/rockchip_canfd-core.c:770:20: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
    770 |         .ndo_start_xmit = rkcanfd_start_xmit,
        |                           ^~~~~~~~~~~~~~~~~~

->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
'netdev_tx_t', not 'int' (although the types are ABI compatible). Adjust
the return type of rkcanfd_start_xmit() to match the prototype's to
resolve the warning.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://patch.msgid.link/20240906-rockchip-canfd-wifpts-v1-1-b1398da865b7@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 2 +-
 drivers/net/can/rockchip/rockchip_canfd.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index f954f38b955f..865a15e033a9 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -63,7 +63,7 @@ void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)
 	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
 }
 
-int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
 	u32 reg_frameinfo, reg_id, reg_cmd;
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 3efd7f174e14..93131c7d7f54 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -546,7 +546,7 @@ void rkcanfd_timestamp_stop_sync(struct rkcanfd_priv *priv);
 
 unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv);
 void rkcanfd_xmit_retry(struct rkcanfd_priv *priv);
-int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev);
+netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev);
 void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 				unsigned int *frame_len_p);
 
-- 
2.45.2



