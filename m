Return-Path: <linux-can+bounces-5155-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C81BD2B0B
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 13:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B66803444D7
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B752EAB72;
	Mon, 13 Oct 2025 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbT0nuqP"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD22E36EC;
	Mon, 13 Oct 2025 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353339; cv=none; b=iHWcQmKtxkGJO+mNcUbp97Mq790vbByM0hvj3FTttjJRhP2vbQYkqUqMfdBqR4odAsWKn7Ee5fRVaKoc08WkoIeqpBsar2mCPwHmTNy3LQTewLGGzm2OqMnutCNNRJlv0tl6l6cekvDnlJ1yawurtyIS8UIBg4IfGuY27ZxAtts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353339; c=relaxed/simple;
	bh=Z/lAhsBfAiGioe6wx17saWxZPcTan9gEXDbid8qhzYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hj+2UFUE2xJ8uK8p9SS0NYJ5XCdrXX+p6JsPzoRfgVeFGWgCC8sFXKS6zC4mJp2CoIDmJY5KakEYl32gCxK7ajWUlt+UgUq5nc6QaHDVVH+BKBxcpKk96OxN+SsomguE2e+O2fp0V2SeGuLLpKF6va+QGM1bYj4Ltce6BtL3Fys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbT0nuqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70906C4CEFE;
	Mon, 13 Oct 2025 11:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760353338;
	bh=Z/lAhsBfAiGioe6wx17saWxZPcTan9gEXDbid8qhzYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZbT0nuqPZoKCX75AM9hXYI/WKVFyV+spRzukkgTh16l1Ak9CFPy8Ic9IZexSDTLb+
	 2qrEj19eGm+7VW2YTUgJoZGMZIPLgVGBpTIsQy/gm81RWst0TXEUvfuaEZGuOPzu5W
	 rPBcvZEJs02JNGLX3br1rMT7KElWaDwil0uDdSvRV8sH3dXfgHV6Cri0tZ4aiGEn/G
	 kjQFXvEXGCNpk8eIf81cBhflrCT41yEBZNc+3zQiU5XWQ1mZyHyX0SHW8fhFH/2MoT
	 HS+TEc4/TaFUKwDoj5R3b9PJcHTavc4daqmyPZRQbEHoPZE+n0S/k2tJGMh4zEn/nQ
	 e6CV1W67tnyGA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 13 Oct 2025 20:01:23 +0900
Subject: [PATCH 1/9] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD
 is off
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-canxl-netlink-v1-1-f422b7e2729f@kernel.org>
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
In-Reply-To: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=Z/lAhsBfAiGioe6wx17saWxZPcTan9gEXDbid8qhzYw=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlv7sjwPe84w9Vj5f1Hb3r527cpP35FOTVGdzm9S/jYu
 ZOn9GpbRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIm8Pc7wv7bY+3L7Au4a/d1F
 bc/TX0g5lAvF2O5zYe66O/XWBcl+OYY/fIZ11+72Hf0kKvBQjc1yZ9CzS7WMp2/yrfzUq8LDuI+
 FGQA=
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
2.49.1


