Return-Path: <linux-can+bounces-5770-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B5C93DD1
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 13:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7623A73A0
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7201224B0D;
	Sat, 29 Nov 2025 12:51:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA6309EF9
	for <linux-can@vger.kernel.org>; Sat, 29 Nov 2025 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764420681; cv=none; b=piADDWvBsVmXJyeCe+e60HKky5NyMcnjAtoABgztSRk5SmNZ9HUdRxJ6CNESjmhZ2lZigB5QFiXz3xjGQo745PyFNN9D7HjLcCO/K/WpzY5cxY9aBmV4fiq1/5ponICOg0WUt7DIWmZ5nHfdjVLM1g/yKte8gP3F+TZykbWwjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764420681; c=relaxed/simple;
	bh=+OBYirfwq4Bz9hCBP4m/Z51qgzp0m5zImiabdO9z0TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSuEsPEqz5VPAXvn600fNnRqZIpMMYI3y9h7IoUxVCuvOKvQ2/aHFwOCm9V14Gmhyo4XSJLp3llS6qTv6ZaSdZAHjRsDqBFUEnVRDN38TWtCYclZAYw8jj/FaZ/GP8C5yl54ybbXxLAcyQN3Y+i6MEz3EgkCuX9SXnL5FCxlcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vPKPt-0006Tp-HR; Sat, 29 Nov 2025 13:51:09 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vPKPs-0037TS-1e;
	Sat, 29 Nov 2025 13:51:08 +0100
Received: from blackshift.org (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6E1554AAB47;
	Sat, 29 Nov 2025 12:51:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next] can: Kconfig: select CAN driver infrastructure by default
Date: Sat, 29 Nov 2025 13:47:19 +0100
Message-ID: <20251129125036.467177-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251129125036.467177-1-mkl@pengutronix.de>
References: <20251129125036.467177-1-mkl@pengutronix.de>
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

From: Oliver Hartkopp <socketcan@hartkopp.net>

The CAN bus support enabled with CONFIG_CAN provides a socket-based
access to CAN interfaces. With the introduction of the latest CAN protocol
CAN XL additional configuration status information needs to be exposed to
the network layer than formerly provided by standard Linux network drivers.

This requires the CAN driver infrastructure to be selected by default.
As the CAN network layer can only operate on CAN interfaces anyway all
distributions and common default configs enable at least one CAN driver.

So selecting CONFIG_CAN_DEV when CONFIG_CAN is selected by the user has
no effect on established configurations but solves potential build issues
when CONFIG_CAN[_XXX]=y is set together with CANFIG_CAN_DEV=m

Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
Reported-by: Vincent Mailhol <mailhol@kernel.org>
Closes: https://lore.kernel.org/all/CAMZ6RqL_nGszwoLPXn1Li8op-ox4k3Hs6p=Hw6+w0W=DTtobPw@mail.gmail.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511280531.YnWW2Rxc-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511280842.djCQ0N0O-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511282325.uVQFRTkA-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511291520.guIE1QHj-lkp@intel.com/
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20251129090500.17484-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/dev.h | 7 +++++++
 net/can/Kconfig         | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 52c8be5c160e..f6416a56e95d 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -111,7 +111,14 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 void free_candev(struct net_device *dev);
 
 /* a candev safe wrapper around netdev_priv */
+#if IS_ENABLED(CONFIG_CAN_NETLINK)
 struct can_priv *safe_candev_priv(struct net_device *dev);
+#else
+static inline struct can_priv *safe_candev_priv(struct net_device *dev)
+{
+	return NULL;
+}
+#endif
 
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
diff --git a/net/can/Kconfig b/net/can/Kconfig
index af64a6f76458..e4ccf731a24c 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -5,6 +5,7 @@
 
 menuconfig CAN
 	tristate "CAN bus subsystem support"
+	select CAN_DEV
 	help
 	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
 	  communications protocol. Development of the CAN bus started in

base-commit: ff736a286116d462a4067ba258fa351bc0b4ed80
-- 
2.51.0


