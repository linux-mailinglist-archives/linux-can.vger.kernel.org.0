Return-Path: <linux-can+bounces-5767-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03278C93ACD
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 10:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965CB3A5844
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9C31E3DDB;
	Sat, 29 Nov 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eI9oXloz";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pUFSeI7e"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520C182B7;
	Sat, 29 Nov 2025 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764407144; cv=pass; b=hMEIrky4o2vQu9CwHC9Lqmu+2Xn0ND+O3F2C8HnleSF9078PtSWA6LMVeWKeq4To4pKCosX6CW9E1ipiHmD17xg2gk1YF5nMYoBRhISlCV69/Rq9/Xn+xpG61BcxNPOY4S++I0igeHip7R7oQhD7ahLgImPvunOEnIyyxMSyTAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764407144; c=relaxed/simple;
	bh=bfMBh4mimLEPfGPDi75INKA79yyZVuJeabO1DwElFPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ruWFw92MayRNtvoP2PkRRQMg0EfDfgU9i+hUpc12bcfvVDCijdV/OyG1WyKJtUMmrwz6raD6QPMfShPzBIbtuh4iCoPmG/vje6/wvYrSrYBoLHKvJA2yWIEFJczFEWyh08ddd+9BMeRVY+iwb3iP2pDYmdwyp21R9k8y14N9BJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eI9oXloz; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pUFSeI7e; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764407120; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=efE7kTKabNBm82ie9wqEguihMXevEEj4taeX8DYM9MtQCowfZibngzDAZ6oAnWKcWB
    R+7AQBBLVW1fQ6SjQoV92qxLnfere6C9YqWoxuy0QxDmmqAPcx+nxvDpr/OSeBHR2XxX
    aS41J1ZYlumyDjXfsS+UqtZmnuGwjEHboAPtwZBZsfXk47j7W40FNCT6Z5qa5JHPNjx1
    PQr+xgilnTntGkthVDbl+t3i0aZm1EexBmyuesLMbilnS3HcSa/LwZThzs9Y3GvpHRBd
    d0sq+P3tck9Tks9aVo4glmY1b9r3sNsdqhYiGQTAGZCsgoHB2sVF4SyGmw4KFB2WAboy
    f5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764407120;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Ozjv4i0J+m53PPTrH8/6rc/sa1uDjmueK5DsDlPmUYY=;
    b=f0ViQELnIkW78lblQbdeKNfVdfGimrMpJ4AClEp5COgxjgZpN9tfXUST5y04Gts2rU
    bYiyKMgYlr4C0XTMvWRdcFrqdRtxh2lM2LRSek7y9PAt2XUu3nhiu3yrLHHa2KiWVLBW
    7I8xhmR1Ph6aW9BQFfNzBw8onuZtleZnKenvAPU8Cy/qshEACcqa3SVwWsELlZHVnrsq
    Kga0TFclYhvZUuB+JkexonZd/tC77mgq5OVa1edWc9cw8L1J7q0Uc961aSGhihCf3WU6
    Ddrw+oaxijKxcYQ6uHHpFC/QTv+QQnv7ZhtPO7OSlenbpT53HwUSET8uwIWGJ5qWaG9H
    OF5A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764407120;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Ozjv4i0J+m53PPTrH8/6rc/sa1uDjmueK5DsDlPmUYY=;
    b=eI9oXlozKQin2YljHHEQ5ZU3jSKHbG9p9voB3+b+imG7e2gw/GHT2WlBgY3hfQ8kX7
    I/zbJULvh3gKwKdIcXtKS49+OpunQgLBNyLjswrpZWwbCeXHSOMhZ1vYAlXNhRQVgO5K
    M2oobY2XwJH+MMA11NJ3RuhgxnRVJ/q+EuG/KpPw1JTGpDTdfu4rkGjHPAzeGa6coKDQ
    720rH4OQu8NeUZhxTb3f5s1EYgd2Wh4m9KLv40767GObKZ6rLVluIf3qc/08aCiSv62d
    OF06f0W0D9qw9WTO7HcqttMjyDRiYG7TOk9fBPHp8aadirjiTOhrBc492e5Tv331Vr6s
    48gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764407120;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Ozjv4i0J+m53PPTrH8/6rc/sa1uDjmueK5DsDlPmUYY=;
    b=pUFSeI7eDzmWLsJLUWffY/2YKiWhHcd4KdHbJAlabZwZclgrHafnzWcfF0j6S79RlI
    Q3niX1oEZTK2X6pBjPAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AT95IiQW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 29 Nov 2025 10:05:18 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	kernel@pengutronix.de,
	mkl@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [can-next v3] can: Kconfig: select CAN driver infrastructure by default
Date: Sat, 29 Nov 2025 10:05:00 +0100
Message-ID: <20251129090500.17484-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511282325.uVQFRTkA-lkp@intel.com/
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---

v2: In fact CONFIG_CAN_NETLINK was missing too. Reported by kernel test robot.
v3: With the change in dev.h the compilation of the of the netlink code can be
    avoided when only virtual CAN interfaces (vcan, vxcan) are required.

---

 include/linux/can/dev.h | 7 +++++++
 net/can/Kconfig         | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 13b25b0dceeb..2514a5c942e5 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -109,11 +109,18 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 #define alloc_candev_mq(sizeof_priv, echo_skb_max, count) \
 	alloc_candev_mqs(sizeof_priv, echo_skb_max, count, count)
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
 void can_set_default_mtu(struct net_device *dev);
 int __must_check can_set_static_ctrlmode(struct net_device *dev,
diff --git a/net/can/Kconfig b/net/can/Kconfig
index af64a6f76458..e4ccf731a24c 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -3,10 +3,11 @@
 # Controller Area Network (CAN) network layer core configuration
 #
 
 menuconfig CAN
 	tristate "CAN bus subsystem support"
+	select CAN_DEV
 	help
 	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
 	  communications protocol. Development of the CAN bus started in
 	  1983 at Robert Bosch GmbH, and the protocol was officially
 	  released in 1986. The CAN bus was originally mainly for automotive,
-- 
2.47.3


