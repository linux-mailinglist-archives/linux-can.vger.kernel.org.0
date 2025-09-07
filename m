Return-Path: <linux-can+bounces-4502-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B2DB4797D
	for <lists+linux-can@lfdr.de>; Sun,  7 Sep 2025 10:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E853202912
	for <lists+linux-can@lfdr.de>; Sun,  7 Sep 2025 08:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7F81F55F8;
	Sun,  7 Sep 2025 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk7gsvOa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0123CB
	for <linux-can@vger.kernel.org>; Sun,  7 Sep 2025 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757232322; cv=none; b=IIp/CZwnKtrJXsfXGFEkX6Bi7Zf0xEn962k0/rKFPJe++tKXlS5iblRrL91l5teEvEVt7aZKCp9fGnI8uVzeTv3iPcONAA1BL3/iwuLR9gomMAj3EJeFcddlosiCr8PSUG1pJL6TB2sJbc+zot6sfoxAYIqFLazz3vJx1/r0rTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757232322; c=relaxed/simple;
	bh=Nhvx5qRa/aKD6H9rSw92shtq0yx4iOcI9IsrP2zgz/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKMJRmm2oVKufsRp4iLuKZaTF0q8MHMbwPROPNmfhDvhc+OfYB6dy3cXVFRkEHCLRJpoBQ2WDlw34NsmdX3/4CnnqvAFDEjKMAYnN6M0zUsdjCY2jeCVT6bZipCftzAlhRkCvjCtMD1h+i8ANEzRf42GpYWCRcDXR/ybzMEjXJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk7gsvOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1976C4CEF0;
	Sun,  7 Sep 2025 08:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757232322;
	bh=Nhvx5qRa/aKD6H9rSw92shtq0yx4iOcI9IsrP2zgz/8=;
	h=From:To:Cc:Subject:Date:From;
	b=Pk7gsvOamfaesnrYvq9Ik3ml2CGXazALyhS4WgOtTF479pIO3cJ21UNxjPNGa6vKk
	 aKDpEwSkNNeoKynIHLlXX4u0k4z2Vy8Vw7DpfDGvCQS18xO1bquK7Vl6DRJgR9qIAE
	 1N2jttdNFi7ONa7SPCkKf9ASOMB7swUrNtDQRnHLgW5pzElapWYX16Bg2WHglVtyQN
	 mSBTHGZtrSyVmIvHguk9aPkNWYAIeklQNyYpueyrBAoQi6GZiM0+CsVJGoG2/gACnD
	 JyiUWzMZxzZARZyF2uIqUP4hddUa31gVBwZP8GpUchF43vvzbiWuYo/stv7Wmo0k+T
	 eQPqekfZzvGMA==
From: Vincent Mailhol <mailhol@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [RFC PATCH] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
Date: Sun,  7 Sep 2025 17:05:05 +0900
Message-ID: <20250907080504.598419-2-mailhol@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3272; i=mailhol@kernel.org; h=from:subject; bh=Nhvx5qRa/aKD6H9rSw92shtq0yx4iOcI9IsrP2zgz/8=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDBl7bTY0b91vqr+8/sv/pLm6679OU1xhz7zmyu40iQ7PJ +nOednJHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACZS/5zhv0fXJJGP+SoKRXqp HpNcjvdP/Wl76/W5lzfavmRr/YzSf8HIcPr1aZV+hVM6B9Z95J7REiTgsJ1zQX8hn2I9jxtnyBJ +TgA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Currently, the CAN FD skb validation logic is based on the MTU: the
interface is deemed FD capable if and only if its MTU is greater or
equal to CANFD_MTU.

This logic is showing its limits since the introduction of CAN XL.
Indeed, an interface which is configured to support CAN XL but not CAN
FD would have its MTU set to CANXL_MIN_MTU which is greater than
CANFD_MTU, thus fulfilling the CAN FD check condition. That is to say,
any CAN XL interface currently appears as CAN FD capable with no way
of configuring or probing this at the skb level.

Because of the limitation, the only non-UAPI-breaking workaround is to
perform the check at the device level using the CAN_CTRLMODE_FD flag.
Unfortunately, the virtual interfaces (vcan, vxcan) are left behind
with this approach.

Add a check on the CAN_CTRLMODE_FD flag in can_dev_dropped_skb() and
drop FD frames whenever the feature is turned off.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
While testing, I encountered a potential issue when:

  - CAN FD is off
  - CAN XL is on

My understanding is that this is allowed and, even more, it is
sometimes mandatory when, for example, disabling error signalling or
when using the transceiver mode switch (TMS) or both.

It seems to me that the current implementation is incapable of
handling this case at the skb level for the reasons listed in the
patch body.

I have two ideas to fix this issue:

  1. above patch which assumes that we are OK not being able to set
     CAN XL on and FD off on virtual interfaces

  2. add some information to the skb itself. I have not looked at this
     in detail. One potential idea would be to use:

       sk_buff->protocol

     as a bitfield. Whenever the MTU is greater than CANFD_MTU, below
     logic would apply:

       - if sk_buff->protocol & CAN_SKB_CC is true, classical CAN is
         supported

       - if sk_buff->protocol & CAN_SKB_FD is true, CAN FD is
         supported

       - if sk_buff->protocol & CAN_SKB_XL is true, CAN XL is
         supported

     with any of the combinations above accepted.

     Of course, because this comes as an afterthought, it is an UAPI
     breaking change for any existing CAN XL code. Also,
     sk_buff->protocol was not designed for this, making this solution
     an ugly hack.

Thanks for your comments.
---
 include/linux/can/dev.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 9a92cbe5b2cb7..5053d5bc20c99 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -164,12 +164,18 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
 		netdev_info_once(dev,
 				 "interface in listen only mode, dropping skb\n");
-		kfree_skb(skb);
-		dev->stats.tx_dropped++;
-		return true;
+		goto invalid_skb;
 	}
 
+	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb))
+		goto invalid_skb;
+
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


