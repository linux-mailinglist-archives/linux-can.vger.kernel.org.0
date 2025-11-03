Return-Path: <linux-can+bounces-5307-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E77C2DCBC
	for <lists+linux-can@lfdr.de>; Mon, 03 Nov 2025 20:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6033BD2D3
	for <lists+linux-can@lfdr.de>; Mon,  3 Nov 2025 19:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A32742A96;
	Mon,  3 Nov 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LWKnnfrZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE32BA45
	for <linux-can@vger.kernel.org>; Mon,  3 Nov 2025 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196765; cv=pass; b=LxEqVNq8j3o1J2nOSQzdR0bHazPkIqbrRQ442FCnDpJNxgghJmMDLyesuoZotq4SAO2y1oKD1nXjrVNQ89v/Cf5uu6AvH2RN3aRWg+EfH6ZBXKPYQDIRAUrHczV+hbgtCqkHi/6RI3rO0EdkVm3NcJvZh5sL9YUKPSCP1qOIddU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196765; c=relaxed/simple;
	bh=FOopW0xEmyZk10lU70Zl1feNBX4Js4Kp2qs5kQ/ERFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WcL22eAKWR6NMSFviKtlcDAAhWSo3Jf2jcPMhat6f0wN4xtZdPGUMbDWN+esmTIbtTLPDen9WeyheKNdkibL1HwKYEl/cUx2EHQpSDdDrbYKbN4Ep6zBtVrN0+0/cNA5eB8PWSbkiOkG9ZSIoJeXuMaVs7AlyltQsur821Ppwso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LWKnnfrZ; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762196027; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=i/w2HnvkExcom6FXQkO41h/IrffrWG8get/nkrI0tPoAkL2l532eIwMOH9HiB/v1hV
    tknVGRReJpadgH4bY5xq1TOfy/LEEtQv/2y6BNcZCFsfAx4rM/raAeqKTOF6Gyvamr6w
    xcUwjFWUBz9KaH6bNiwq2+vkBDnLzc3EudO4oH8b6gn4ga63pHite/+u5o30/bYysGNe
    ihLGlg/lZ+DUWQ2cs4hU0DaXg1qjqUZ5yblwgV+s9It6O6mMDDMBFwS3HDCbXeoKka5/
    BRXMqqcBz7Kxnts/+lQHp4IEWn5bfel6jzhk/sIU2iP/qhcNBpT2aEOlJ6XLLWvAwJSF
    tQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762196027;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=dympGOfxqsOcRKzWojq2HWg1tQSIk2x85kbdpWmOGB0=;
    b=AGXdFXycdXM6tBrK/fho25/gOJ+9KpoF1qBMI04orXplN0myVdpT0i+4oOZjHFnLks
    ftH4Wymy212Xm0Pm2B0ZxCCSRZYWNKzNh0jT1jG4x+aO5BP2348n7wUEiZGIK/NXS5s9
    YM9vWNmghmJwVFdQq3e+NgLaMdiZoTQ60Fov0XnhhOeNLhs/hhwQqy1pVHtxjghXunnP
    862jTTKtEO70ejV6y5ALf/mQ3j4dYmqXKrRVWtjF7gC7T5aEA5v6KdzwCm1XHUzzoL2Y
    UU6tROASY9lY6Sz4mgSnUykr8KoFopigzlq4FdtLLymHdYKK+aSPieTV2hTl5MOmLSP+
    EJwA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762196027;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=dympGOfxqsOcRKzWojq2HWg1tQSIk2x85kbdpWmOGB0=;
    b=LWKnnfrZrS9XesUk8axxGx3mNOVvwyDZWo+qTPss2OBpwkiwf/K3h6qJwbpEugpheU
    Tw4CjQkWPUn9Hhs4cjQosz3je/xHnSkFwYQBISulxaGYyIHalMeTThghvbTFicLj+EaC
    7EI8TjHs9tf2yJJzV7+z+AKISSI9hOCKwiilVV1MO2n4D5bcMRBoL/1CpHwKQ++ZIdHz
    PJJ2h4c9fMjkp/wlD6swpl2txRFZ1e8jbxnryKjQ19KsdfnUTXSE5f53X4UNCb2W8MQp
    CJtheIX+BAon5DcuWqopUlnlgwIiQDvhl+h63vK5ccyKlroO9419/1lV0DfNTtsIWYWT
    KnCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id Kf23d01A3Irl5uc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 3 Nov 2025 19:53:47 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org,
	mailhol@kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH b4/canxl-netlink v2] can: drop unsupported CAN frames on socket and netdev level
Date: Mon,  3 Nov 2025 19:53:36 +0100
Message-ID: <20251103185336.32772-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Rework the checks for skbs containing CAN CC/FD/XL frames.

For real CAN interfaces the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL control
modes indicate whether an interface can handle those CAN FD/XL frames.

In the case a CAN XL interface is used with "TMS on" or "ERR_SIGNAL off"
neither CAN CC nor CAN FD frames are supported to be sent. Add a check
for the so-called 'mixed mode' (CC/FD/XL) in can_dev_cc_enabled().

CAN_CTRLMODE_FD is ensured to be disabled when TMS is enabled or
ERR_SIGNAL is off.

The checks are performed on CAN_RAW sockets to give an instant feedback
to the user when writing unsupported CAN frames to the interface.

Additionally we check for correct skbs on CAN netdev level in the case
the CAN frames are provided via PF_PACKET sockets.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/dev.h | 57 ++++++++++++++++++++++++++++++++++++++++-
 net/can/raw.c           | 19 +++++++-------
 2 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 945c16743702..23743c44d300 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -129,10 +129,52 @@ int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
 const char *can_get_state_str(const enum can_state state);
 const char *can_get_ctrlmode_str(u32 ctrlmode);
 
+static inline bool can_dev_cc_enabled(struct net_device *dev)
+{
+	struct can_priv *priv = safe_candev_priv(dev);
+
+#define MIXED_MODE (CAN_CTRLMODE_FD | CAN_CTRLMODE_XL)
+
+	/* When CAN XL is enabled but FD is disabled we are not running in the
+	 * so-called 'mixed mode' (CC/FD/XL with TMS OFF and ERR_SIGNAL ON).
+	 * Then either TMS is ON or ERR_SIGNAL is OFF in which cases the
+	 * resulting XL-only mode does not allow the sending of CC/FD frames.
+	 */
+	if (priv)
+		return !((priv->ctrlmode & MIXED_MODE) == CAN_CTRLMODE_XL);
+
+	/* virtual CAN interfaces always support CAN CC */
+	return true;
+}
+
+static inline bool can_dev_fd_enabled(struct net_device *dev)
+{
+	struct can_priv *priv = safe_candev_priv(dev);
+
+	/* check FD ctrlmode on real CAN interfaces */
+	if (priv)
+		return (priv->ctrlmode & CAN_CTRLMODE_FD);
+
+	/* check MTU for virtual CAN FD interfaces */
+	return (READ_ONCE(dev->mtu) >= CANFD_MTU);
+}
+
+static inline bool can_dev_xl_enabled(struct net_device *dev)
+{
+	struct can_priv *priv = safe_candev_priv(dev);
+
+	/* check XL ctrlmode on real CAN interfaces */
+	if (priv)
+		return (priv->ctrlmode & CAN_CTRLMODE_XL);
+
+	/* check MTU for virtual CAN XL interfaces */
+	return (READ_ONCE(dev->mtu) >= CANXL_MIN_MTU);
+}
+
 /* drop skb if it does not contain a valid CAN frame for sending */
 static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *skb)
 {
 	struct can_priv *priv = netdev_priv(dev);
 	u32 silent_mode = priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
@@ -142,15 +184,28 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 		netdev_info_once(dev, "interface in %s mode, dropping skb\n",
 				 can_get_ctrlmode_str(silent_mode));
 		goto invalid_skb;
 	}
 
-	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
+	/* Classical CAN */
+	if (can_is_can_skb(skb) && !can_dev_cc_enabled(dev)) {
+		netdev_info_once(dev, "CAN CC with TMS on, dropping skb\n");
+		goto invalid_skb;
+	}
+
+	/* CAN FD */
+	if (can_is_canfd_skb(skb) && !can_dev_fd_enabled(dev)) {
 		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
 		goto invalid_skb;
 	}
 
+	/* CAN XL */
+	if (can_is_canxl_skb(skb) && !can_dev_xl_enabled(dev)) {
+		netdev_info_once(dev, "CAN XL is disabled, dropping skb\n");
+		goto invalid_skb;
+	}
+
 	return can_dropped_invalid_skb(dev, skb);
 
 invalid_skb:
 	kfree_skb(skb);
 	dev->stats.tx_dropped++;
diff --git a/net/can/raw.c b/net/can/raw.c
index a53853f5e9af..645f1e0b2555 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -890,24 +890,23 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 		cxl->prio &= CANXL_PRIO_MASK;
 		cxl->prio |= ro->tx_vcid_shifted;
 	}
 }
 
-static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
+static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
+				      struct net_device *dev)
 {
-	/* Classical CAN -> no checks for flags and device capabilities */
-	if (can_is_can_skb(skb))
+	/* Classical CAN */
+	if (can_is_can_skb(skb) && can_dev_cc_enabled(dev))
 		return CAN_MTU;
 
-	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
-	if (ro->fd_frames && can_is_canfd_skb(skb) &&
-	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
+	/* CAN FD */
+	if (ro->fd_frames && can_is_canfd_skb(skb) && can_dev_fd_enabled(dev))
 		return CANFD_MTU;
 
-	/* CAN XL -> needs to be enabled and a CAN XL device */
-	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    can_is_canxl_dev_mtu(mtu))
+	/* CAN XL */
+	if (ro->xl_frames && can_is_canxl_skb(skb) && can_dev_xl_enabled(dev))
 		return CANXL_MTU;
 
 	return 0;
 }
 
@@ -959,11 +958,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto free_skb;
 
 	err = -EINVAL;
 
 	/* check for valid CAN (CC/FD/XL) frame content */
-	txmtu = raw_check_txframe(ro, skb, READ_ONCE(dev->mtu));
+	txmtu = raw_check_txframe(ro, skb, dev);
 	if (!txmtu)
 		goto free_skb;
 
 	/* only CANXL: clear/forward/set VCID value */
 	if (txmtu == CANXL_MTU)
-- 
2.47.3


