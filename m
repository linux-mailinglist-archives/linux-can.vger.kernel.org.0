Return-Path: <linux-can+bounces-5513-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0369AC75F69
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 19:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BE7834BCA5
	for <lists+linux-can@lfdr.de>; Thu, 20 Nov 2025 18:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCDC1F3BA4;
	Thu, 20 Nov 2025 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sqNBwVEs";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="a6ObilsS"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D71EB5FD
	for <linux-can@vger.kernel.org>; Thu, 20 Nov 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664334; cv=pass; b=WDE1+nD7eL4hByG1DlOzxD0aGK2ItujF/f4dRawVm19PuaHqak7d+WGolkpSzWDj2vKdHVjGUIQqp8+foB9ugwUhaTYidWF/fK2NoK8HBm/7ykPEw7a/a4mD03gUsTW0yuXY80gyMNP4nVzAZtbQP3xRvT72Y9ZB7/sHEwdM5mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664334; c=relaxed/simple;
	bh=763O7b50HhSXxC0PWYbJMawZSqyGGOShMQL2VLkUu3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUEHoPuRLN9LbOXAVu9Z3BEivSI/zZh9vSD0ZFwAARlTYGmNnoDOFJN6TUSqpKtY4b6bmBpPPA9Hp+rgW0HjyMPH50rnzcT3TGjb5jkKKNsjQI+grJbsom3OdzWFPnP+juhnjlRl8QnKRlISP3OwRpWTGF2nhtM14G3IymeVpXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sqNBwVEs; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=a6ObilsS; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763664321; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FJB3Y/fSF6Rm1Ep49MbE9Wgb09XTcKy8ztgpQUcrMe2/rqGJy/iCd+r7Ey5uhOU3gX
    2sdjNxoqp8cHlY+ia6OAVybrWEW39bQe8YHG6AoSYxx3RPbkwIKVcjgDO8VSzvomSSDy
    QuQ881mJzUtH10mus8T+POQW984u8VS5OhCPaOAnYmsILuSHwrPN4yfVALWjA+O8AmPT
    DiL3T4ByEtDbDE3yV83bZP4MnY2fMpJ1aThNyOxq6GbkAA6ozM8a87XzD3vCl/hiH/wn
    9yzlqPhE68ucBnv+Bo/1vWzsjOOs3nfJ9ZpuP/U1WNWlxLoXke3zvq5r4fsWcpiL0vnj
    J2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664321;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=Zlq+xm6efMt6s766X1PLqJcbuTpqyMM1Sp66YWS2iQLsviMLGYgGberRA9MCl1VRom
    eyfrI0xIV89eJ/goQVXwt5O1Q/+xoVn33skA3LQnFHSyk3ipFFoVeRzPq4uzrTNt+MB4
    eoWV5uIfu5aTTpx2u19qYYvNuL+YJO/hasRd/yK18iW5r5u2VTAZSXEOPmIlapoK8KJE
    qMXSHRCepjsqlfOoknzjzpOMd4JkvOSMWjmlEC+2hF78cGpxMjwRMlnMErAJ6NV5FB/i
    1GcFmbeMmaC26Y0RMZsLRLyIOP0L28ZGt2Jc73tBHAyoglzB5Iz1ZdoIPNhtLYEygmrX
    7AiQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763664321;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=sqNBwVEsZMOBKrUAWq0A9o6//0I16/irSVzuMWfHZJdnhQrurixxYxCBY90IbbGz/o
    wE143Ok9BtxZ/ILsudsxYCtKumUzgyIYJmQ6JuRCZjcu/gnDC8s9S+SQ9euaNjZOeXeH
    cYmwoUhU47v44g+fqmSTElVp+hZ1N3FVtfL7Fv+5dafYXGXlVvRm1TatoQPr53nQwllu
    RTxZlNE7PTHfbYIDupE2Kk7xm9WT7zjseBqqtEnBuXJdyi/ttP2UdDHVFC6jhwXhNbdI
    iPQNUxkTZ9R/Gf82vQclXOvpA4RkOSNHEnfzhmJBkV+O3LRb4d5oSWMjkXyDSnhjHzvP
    USxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763664321;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LG3Urxe8pmGbWGjgXk2KNAQtE01ZON6ODg6OQ1bmVnM=;
    b=a6ObilsSgV2PhD0JXubbLbu1l+JCvlTi9ujBQ5SgBOASyHu2cC/2SFsk5gq7tKmOrb
    3SkIrVwUhCfv7KFyUcCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AKIjK9DM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 20 Nov 2025 19:45:20 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [canxl v3 02/17] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
Date: Thu, 20 Nov 2025 19:44:46 +0100
Message-ID: <20251120184501.27597-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120184501.27597-1-socketcan@hartkopp.net>
References: <20251120184501.27597-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol@kernel.org>

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
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/dev.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 0fe8f80f223e..d59b283c981a 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -101,16 +101,24 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	struct can_priv *priv = netdev_priv(dev);
 
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
 
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
-- 
2.47.3


