Return-Path: <linux-can+bounces-5251-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E52FBF77B6
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 17:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8879487134
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4685345750;
	Tue, 21 Oct 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMCg31+e"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3E345745;
	Tue, 21 Oct 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061672; cv=none; b=Jz066HhExsRfUb2QiDB63efph+Ntrw/SP1kK+53Qt2CklkRteHylSo1UgFcuDUEWUkCPx52/NEhmNhT4xrvdVLbya4PHoXgA1spuig2XAELxaCFZMNc7d+zypVnMId8sPJGULQ66fUB6VK64q45IaeGQ5gj3fThbcgleqvnAf/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061672; c=relaxed/simple;
	bh=scjXXTT0e+4ezgrthuEqjLN50AjGyZwgsF4n5XZ73B8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VZYZeDsI0GvM6F7H/iAPbrvbtCccvbTf1PQh+Fj8QoR9BwYgGKDhACC5n5Ijbjxy6ax+y1idynASOuh992FSSevl6qp9jkRQr0TTJTxWYb9hMk0TeV0GUfsFLXxRx/MTBmOvlzR3wk2hwR4cpbSiVhtEK+vZrApZmzQsHTXG3vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMCg31+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8F1C116C6;
	Tue, 21 Oct 2025 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061672;
	bh=scjXXTT0e+4ezgrthuEqjLN50AjGyZwgsF4n5XZ73B8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pMCg31+ekrgrx66bI9BiNlbkZk1HnIqDGM0tzpd956/5XhLQnHwYFcWYopNgzrUp7
	 o9TOD+2t+7rWXDNqJ0Th1aBGZBw2p3LKN46OJEMUPWWYspAzGGlKyPB60e9I+5bqzv
	 K6YdD/iBIW2xwX1aa4R0A54Fzxo0KtMWiDB9YGuk1NBxrduGPJscLwO0dcHbaUR6n1
	 UkI6lMIF0N+1Ybdqpd4vrTXGBcI+Rl5G9+/0BH8V0Lo9Jgf1SwlLZLu85+/guwoKgc
	 LdwjyXnRz5x5pH3EJ+taIvWVkVVSV959STH4Jz8yWc96CgH8Jpuno806WO5XLVGm0v
	 iWTohvL5pv8Rg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 21 Oct 2025 17:47:02 +0200
Subject: [PATCH v2 02/10] can: dev: can_dev_dropped_skb: drop CAN FD skbs
 if FD is off
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-canxl-netlink-v2-2-8b8f58257ab6@kernel.org>
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
In-Reply-To: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=scjXXTT0e+4ezgrthuEqjLN50AjGyZwgsF4n5XZ73B8=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnfV7PdEk7K4GbVWhbOvv1zV7yl4M/MxQzFyz+4979xu
 bEo4P3JjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABOZms/IcLjDj0Np6YSunboq
 3lf9El+HNvzNyIlyiaqZm+5Uv19lAcMfvgVb2F3DVM9feZhSflhc91NYlTBL7LWgF6/WqrxmEnj
 MBgA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Currently, the CAN FD skb validation logic is based on the MTU: the
interface is deemed FD capable if and only if its MTU is greater or
equal to CANFD_MTU.

This logic is showing its limit with the introduction of CAN XL. For
example, consider the two scenarios below:

  1. An interface configured with CAN FD on and CAN XL on

  2. An interface configured with CAN FD off and CAN XL on

In those two scenarios, the interfaces would have the same MTU:

  CANXL_MTU

making it impossible to differentiate which one has CAN FD turned on
and which one has it off.

Because of the limitation, the only non-UAPI-breaking workaround is to
do the check at the device level using the can_priv->ctrlmode flags.
Unfortunately, the virtual interfaces (vcan, vxcan), which do not have
a can_priv, are left behind.

Add a check on the CAN_CTRLMODE_FD flag in can_dev_dropped_skb() and
drop FD frames whenever the feature is turned off.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

RFC -> v1:

  - add an netdev_info_once() message.

  - this was sent as a standalone patch for discussion, it is now
    integrated in the CAN XL series.

  Link: https://lore.kernel.org/linux-can/20250907080504.598419-2-mailhol@kernel.org/
---
 include/linux/can/dev.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 0fe8f80f223e..d59b283c981a 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -103,12 +103,20 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
 		netdev_info_once(dev,
 				 "interface in listen only mode, dropping skb\n");
-		kfree_skb(skb);
-		dev->stats.tx_dropped++;
-		return true;
+		goto invalid_skb;
+	}
+
+	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
+		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
+		goto invalid_skb;
 	}
 
 	return can_dropped_invalid_skb(dev, skb);
+
+invalid_skb:
+	kfree_skb(skb);
+	dev->stats.tx_dropped++;
+	return true;
 }
 
 void can_setup(struct net_device *dev);

-- 
2.51.0


