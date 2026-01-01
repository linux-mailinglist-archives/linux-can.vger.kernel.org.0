Return-Path: <linux-can+bounces-5984-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BFBCED4B0
	for <lists+linux-can@lfdr.de>; Thu, 01 Jan 2026 20:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D1F13006A9D
	for <lists+linux-can@lfdr.de>; Thu,  1 Jan 2026 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB98145348;
	Thu,  1 Jan 2026 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XAx2rt3v";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+kandYcm"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374421B918
	for <linux-can@vger.kernel.org>; Thu,  1 Jan 2026 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767294850; cv=pass; b=rabnSmDbjYc4e+xvm5/8r5K1MKAGegDq1hkFkS3nWdJzrU62/wyCoHQsbaFnWzmSL1MPI51jzCD2/LRKznYaS1RlDuHyD+Mbc7T3ehw6NfLuhF0Zvmr2E7sriAdjm4HvH04lHKqixMb6AuBB3HmyXXOoiGPgtGe4cGa4c57Ibtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767294850; c=relaxed/simple;
	bh=3ZlvuSGStjzyxQi4wMCX6o3LH9T0K1dtKj3Iy8Vy6DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PwnXh/q4BpZubLiErCsJg9pzjyJsFA9tAh0qrfcErFaW0KT+uV0xJ62z0FOUF5b/XKh/aXOxQJd6rVIGo712YxVjB9vuW6dCw7g/pV2Kzes/2FixDAdA9gCtpBLhq1wXtrNyFz4b+LpJ1TrcDGfybyjnOZOSS6tdJXyiY0W4888=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XAx2rt3v; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+kandYcm; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767294827; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TCajq9zYOTDCvZf2hacUCHzQoZ5yvnsavVEhQ5qt6brOW+srpSmgjBZ1Uh0tuJO2q0
    H+WVv8+nstPGJyXasGL20Jx8qZkq6/iu8LH14tuxVuHfSMvUg1Oy/tndMGId5uUO3pD/
    f0ajtUIagoNDnAGs0Qd5mkgu4M4V1LN909LMAgSDtgj2vXFnD0HmcM2CgYhC9WvGqAVT
    NNZbk3OBYjUQs5iquFqcvAZbu1c8V3+cMm7hqnG3PB6WGLJ2kHSkP2P9IZDuWo0vlof4
    rCFCpbKoDsZ76QTvJupws2Z9p5q6YLvwxzfYxCSCyMOqV7CKnwcBWbI7FmpYnIr6e0pS
    emeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767294827;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xYFY8G71BYJmYDayFNyuOpEgGseAGVi+V//F9fuuUmU=;
    b=Ftn+EThs9QlxduuH2+VNfkPI4+qXlTYh+KBIXfBajfWqQeorxDJSmmhhTak4fW2FMC
    m6NIkK1gimlz+Ft60WFBdfcRN68NYetlCK9cdkuff83Flfcev3f6yU1Q0xlVDmvaRec5
    vt5cOXh7lQ3ccNmYnKqeAtkgU54pBKUoP3OlksIga/YacgUrh6ON2lZjLzNbncylf24w
    c3ayel2U833u7ms99zrEUwAHb4tL2iZZ4+79ZbORlU95D4VJeg0ivBDZMGTuI3CDII3o
    hHLjqx/rnX/8WwPtStt/UZJvR/d/IFpWlkj0o+iipFh7/23/Y4la9pDWZW7wkD4JOKYc
    np9A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767294827;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xYFY8G71BYJmYDayFNyuOpEgGseAGVi+V//F9fuuUmU=;
    b=XAx2rt3vvAG7nstqYqxB7RMCakM+tMSDx0Xg8xh16iviSU14kPu1JHgAMdNP0wxxD2
    LaEusPniUQU+fYzvkqpAmNLe1xYIp7z/MidNIpeKTTLC1dKQxvQUCJlNKWd7LThkghvl
    k6Fgf0WmMcz8vZIbAQjrNBkg3ciYLKcDDhHn8uRjzjNUGVlsFyAYNE5U8Dh3j1acrWQP
    7BnZSAs/apakLZ9aGowyKYcW+0rOj9xqPxqKClNb98mqfdgbDltJaW36+BrYDgmwfA5J
    1RLLkbcwKnlaSFrFxzmvsHvAIqvoWcCrdSBxeMVINnT2zNHBS0mELOcblAXeOE10j/Ad
    WF/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767294827;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xYFY8G71BYJmYDayFNyuOpEgGseAGVi+V//F9fuuUmU=;
    b=+kandYcmKe20PJzY3NdV8d64MugFHFNlZz1qbQgzpuY1I4/0EzYCduTBgcPlYyy/n0
    MawhlfUJwHYJma1o+nAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b201JDle41
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 1 Jan 2026 20:13:47 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 1/3] Revert "can: raw: instantly reject unsupported CAN frames"
Date: Thu,  1 Jan 2026 20:13:28 +0100
Message-ID: <20260101191330.1836-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This reverts commit 1a620a723853a0f49703c317d52dc6b9602cbaa8

and its follow-up fixes for the introduced dependency issues.

commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
commit cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
commit 6abd4577bccc ("can: fix build dependency")
commit 5a5aff6338c0 ("can: fix build dependency")

The entire problem was caused by the requirement that a new network layer
feature needed to know about the protocol capabilities of the CAN devices.
Instead of accessing CAN device internal data structures which caused the
dependency problems a better approach has been developed which makes use of
CAN specific ml_priv data which is accessible from both sides.

Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/Kconfig      |  7 +++--
 drivers/net/can/Makefile     |  2 +-
 drivers/net/can/dev/Makefile |  5 ++--
 include/linux/can/dev.h      |  7 -----
 net/can/raw.c                | 54 ++++++------------------------------
 5 files changed, 17 insertions(+), 58 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index cfaea6178a71..e15e320db476 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menuconfig CAN_DEV
-	bool "CAN Device Drivers"
+	tristate "CAN Device Drivers"
 	default y
 	depends on CAN
 	help
 	  Controller Area Network (CAN) is serial communications protocol up to
 	  1Mbit/s for its original release (now known as Classical CAN) and up
@@ -15,11 +15,14 @@ menuconfig CAN_DEV
 
 	  This section contains all the CAN(-FD) device drivers including the
 	  virtual ones. If you own such devices or plan to use the virtual CAN
 	  interfaces to develop applications, say Y here.
 
-if CAN_DEV && CAN
+	  To compile as a module, choose M here: the module will be called
+	  can-dev.
+
+if CAN_DEV
 
 config CAN_VCAN
 	tristate "Virtual Local CAN Interface (vcan)"
 	help
 	  Similar to the network loopback devices, vcan offers a
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 37e2f1a2faec..d7bc10a6b8ea 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -5,11 +5,11 @@
 
 obj-$(CONFIG_CAN_VCAN)		+= vcan.o
 obj-$(CONFIG_CAN_VXCAN)		+= vxcan.o
 obj-$(CONFIG_CAN_SLCAN)		+= slcan/
 
-obj-$(CONFIG_CAN_DEV)		+= dev/
+obj-y				+= dev/
 obj-y				+= esd/
 obj-y				+= rcar/
 obj-y				+= rockchip/
 obj-y				+= spi/
 obj-y				+= usb/
diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
index 64226acf0f3d..633687d6b6c0 100644
--- a/drivers/net/can/dev/Makefile
+++ b/drivers/net/can/dev/Makefile
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_CAN) += can-dev.o
+obj-$(CONFIG_CAN_DEV) += can-dev.o
+
+can-dev-y += skb.o
 
-can-dev-$(CONFIG_CAN_DEV) += skb.o
 can-dev-$(CONFIG_CAN_CALC_BITTIMING) += calc_bittiming.o
 can-dev-$(CONFIG_CAN_NETLINK) += bittiming.o
 can-dev-$(CONFIG_CAN_NETLINK) += dev.o
 can-dev-$(CONFIG_CAN_NETLINK) += length.o
 can-dev-$(CONFIG_CAN_NETLINK) += netlink.o
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index f6416a56e95d..52c8be5c160e 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -109,18 +109,11 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 #define alloc_candev_mq(sizeof_priv, echo_skb_max, count) \
 	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count)
 void free_candev(struct net_device *dev);
 
 /* a candev safe wrapper around netdev_priv */
-#if IS_ENABLED(CONFIG_CAN_NETLINK)
 struct can_priv *safe_candev_priv(struct net_device *dev);
-#else
-static inline struct can_priv *safe_candev_priv(struct net_device *dev)
-{
-	return NULL;
-}
-#endif
 
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 void can_set_default_mtu(struct net_device *dev);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,
diff --git a/net/can/raw.c b/net/can/raw.c
index be1ef7cf4204..f36a83d3447c 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -890,62 +890,24 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
 		cxl->prio &= CANXL_PRIO_MASK;
 		cxl->prio |= ro->tx_vcid_shifted;
 	}
 }
 
-static inline bool raw_dev_cc_enabled(struct net_device *dev,
-				      struct can_priv *priv)
+static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
 {
-	/* The CANXL-only mode disables error-signalling on the CAN bus
-	 * which is needed to send CAN CC/FD frames
-	 */
-	if (priv)
-		return !can_dev_in_xl_only_mode(priv);
-
-	/* virtual CAN interfaces always support CAN CC */
-	return true;
-}
-
-static inline bool raw_dev_fd_enabled(struct net_device *dev,
-				      struct can_priv *priv)
-{
-	/* check FD ctrlmode on real CAN interfaces */
-	if (priv)
-		return (priv->ctrlmode & CAN_CTRLMODE_FD);
-
-	/* check MTU for virtual CAN FD interfaces */
-	return (READ_ONCE(dev->mtu) >= CANFD_MTU);
-}
-
-static inline bool raw_dev_xl_enabled(struct net_device *dev,
-				      struct can_priv *priv)
-{
-	/* check XL ctrlmode on real CAN interfaces */
-	if (priv)
-		return (priv->ctrlmode & CAN_CTRLMODE_XL);
-
-	/* check MTU for virtual CAN XL interfaces */
-	return can_is_canxl_dev_mtu(READ_ONCE(dev->mtu));
-}
-
-static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
-				      struct net_device *dev)
-{
-	struct can_priv *priv = safe_candev_priv(dev);
-
-	/* Classical CAN */
-	if (can_is_can_skb(skb) && raw_dev_cc_enabled(dev, priv))
+	/* Classical CAN -> no checks for flags and device capabilities */
+	if (can_is_can_skb(skb))
 		return CAN_MTU;
 
-	/* CAN FD */
+	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
 	if (ro->fd_frames && can_is_canfd_skb(skb) &&
-	    raw_dev_fd_enabled(dev, priv))
+	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
 		return CANFD_MTU;
 
-	/* CAN XL */
+	/* CAN XL -> needs to be enabled and a CAN XL device */
 	if (ro->xl_frames && can_is_canxl_skb(skb) &&
-	    raw_dev_xl_enabled(dev, priv))
+	    can_is_canxl_dev_mtu(mtu))
 		return CANXL_MTU;
 
 	return 0;
 }
 
@@ -997,11 +959,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto free_skb;
 
 	err = -EINVAL;
 
 	/* check for valid CAN (CC/FD/XL) frame content */
-	txmtu = raw_check_txframe(ro, skb, dev);
+	txmtu = raw_check_txframe(ro, skb, READ_ONCE(dev->mtu));
 	if (!txmtu)
 		goto free_skb;
 
 	/* only CANXL: clear/forward/set VCID value */
 	if (txmtu == CANXL_MTU)
-- 
2.47.3


