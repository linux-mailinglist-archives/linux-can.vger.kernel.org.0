Return-Path: <linux-can+bounces-6420-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id up1vEE9QfWnORQIAu9opvQ
	(envelope-from <linux-can+bounces-6420-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 01:43:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A64CBFADD
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 01:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 266BF301829D
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 00:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1B930FC01;
	Sat, 31 Jan 2026 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoiHGZOq"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFE30C615
	for <linux-can@vger.kernel.org>; Sat, 31 Jan 2026 00:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769820234; cv=none; b=Cr+9bRddjajkFr8w4hVD9Qt1uCB9G0GJOO3tcEb1igt61dQvjUf56v8gTh5Clp2g7wx5vtQcpPVERoewffQx+Cs1X4cSx8eECYmEsbI/PriqkWCbDFafl6bkrYP6EN+qLB9QE9msaB1z4ceABvdJtdH8ySmGCctNYXAAH1gGgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769820234; c=relaxed/simple;
	bh=gAMxZn0Bbk69ZZJxMKMKvrwOH+mTYEZ1m8iOZgJYkZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P60Bmn29UlVshf//hPPtZFA+iL0gGSa5wq9EC9Pg5af7n5zE0XSSwlHTV8tEwasZ8wkjqPvIenGAkrT7v3sqhjvOEMcwpz31bYr9uKaW378mpF1ccSY+/V15/Y0LcBf1Fx4r8nxFKUKOtyX2Epu854zp1PZf5iWsIJTQDHO+Xgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoiHGZOq; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-124a95e592fso4764566c88.0
        for <linux-can@vger.kernel.org>; Fri, 30 Jan 2026 16:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769820230; x=1770425030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz/w+ViHe1NFxGhmvKw2Td3oBT35x8hZuCkuGLcRPRE=;
        b=EoiHGZOq1n+YqkmJ8RdCd+vjNLjMRY8d7N0js7XEzTUkM/k4VsCUrOCG8r9Rtltflp
         SURYEBQwRWjFb/LLK3zls1RwRTQcw6yeyP82KeLblFalF8WOg1kOC++vEb62lgRoy1y3
         AhCZfU724LbU6Kw6WFzNfGik3fy/yXDXi4982mgcQ/5AvZFn0TfaDWIEM+zNdypUc1sS
         IxvURZ4X584Lima7TJXbyOmxXA2RHa77Pg4KBmwtN0lC6JBQzfzn2NX4azPIU1awHW/J
         VwXPcO0KL0i0aKGD8I4RkYUXCoxNjJ5GlQvsO6lNd7K4ZWivXKPKJrjy7dqF2f7P2inL
         zNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769820230; x=1770425030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz/w+ViHe1NFxGhmvKw2Td3oBT35x8hZuCkuGLcRPRE=;
        b=uP/CBh5bjRfSouShKWQmvHdHHcCWaLkXPDw4G+Iw7L2V/I+aOvvHtnNBlLPOu/U539
         NW7yyQlpSeq2B584Dz9dBbC6P1HWiB/PnPbn7T9AouylUy+Lx462VfeZis00eFu0hLb1
         tr4zIAD/Mx9fHJ8t78HpUHu2IJmUq4e10OISS72Zo/kAHhsLUt1ILNIWWErCRl+dE/z6
         /U5VgSJ8zUAAcrw2EaSHIow0qvPEszj1o91kfl3yggQZnXGtYee9QDJCNiI+UDDxQQEF
         J1xZPbEsgmR5GIPgeTNsySGsQLt1ddgY9TvCoznplzMMHCXcqVNVyRoHZgv1nHyNGe1b
         W1rA==
X-Forwarded-Encrypted: i=1; AJvYcCXsf8cGMUzhPK7APCn5K56kvhBgZBsPauaAxqEjD68P8V0g3lSpqDuuhUfB8y49JS0mex9WBqUR+mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyumI8JouMBdNQS+Zfoy61Z11CDoKZJVw/uqMDOz6+YXlj035Wi
	D6iV+/XCGIQt9a6BBdP5fesTMTFlOU1LwZb8MenP0GiYD3iB1qHY8La0
X-Gm-Gg: AZuq6aInAe1btrrIxhrflmDMopp8dhqpBkjdUiOgLX9v3V/tBA+SisB5DixxFSdpHMG
	yJuwIivuuXsXWcfLzRho0cf16Boy72V2hoA7IseQXvyzZ9STIO5uZMkTXuk6M2H1HR1O+KnbK65
	KAq9eVAJoaZsH5K8aulse5lzp3/kWuGWOJlwpxlH8iLPyxU96TzSUSOFvFSfmDjTDYiQ33lKvmX
	GgE4xSoD2eiRdKx6b5tY2/EyqXQysakEeXeUfYZEuTBohi+tf0I5GEkfZt2NfdWtFHA5vpkr8cJ
	wQuKV4NL0MFSvDChj+m2Mr4mbNzE21c8JLiah/AkqPDjxwPzZz8dk9dSN0OWpSwHsbbSIVfgKnf
	PjRCpgXyTJscpoTMCUoHEpKgOpBBe8JMWTFU3feHAn+Fch4ntX9gyFjGEyZ07tp4IF8s/p85DCy
	tSQxfjGeB3H7k3hYU/17YW9boedDv8VjIihqLLRjuDbw3rFG4+UxTT2QZIuhSyUp1reIOxeysaz
	2v9yXz6uxqm/ctKeRpFDiTirfuU/+BBpdhNULrLHrIZoLMGsMLhygrLHowo6T0LRueCeZl7HDDA
	+ReY
X-Received: by 2002:a05:7022:e25:b0:11b:9386:a3cf with SMTP id a92af1059eb24-125c10211dbmr2225916c88.48.1769820229772;
        Fri, 30 Jan 2026 16:43:49 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8f2sm14710638eec.7.2026.01.30.16.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 16:43:49 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Ping-Ke Shih <pkshih@realtek.com>,
	=?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH net-next] net: remove unnecessary module_init/exit functions
Date: Fri, 30 Jan 2026 16:42:56 -0800
Message-ID: <20260131004327.18112-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,intel.com,toke.dk,realtek.com,posteo.net,hartkopp.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-6420-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,che.eu:email,mellanox.com:email,realtek.com:email]
X-Rspamd-Queue-Id: 9A64CBFADD
X-Rspamd-Action: no action

Many network drivers have unnecessary empty module_init and module_exit
functions. Remove them (including some that just print a message). Note
that if a module_init function exists, a module_exit function must also
exist; otherwise, the module cannot be unloaded.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/com20020.c                 | 16 ----------
 drivers/net/can/sja1000/sja1000.c             | 16 ----------
 drivers/net/ethernet/8390/8390.c              | 14 ---------
 drivers/net/ethernet/8390/8390p.c             | 11 -------
 drivers/net/ethernet/mellanox/mlxsw/pci.c     | 12 --------
 drivers/net/hamradio/hdlcdrv.c                | 20 -------------
 drivers/net/net_failover.c                    | 13 ---------
 drivers/net/wireless/ath/ath9k/common.c       | 12 --------
 .../realtek/rtlwifi/btcoexist/rtl_btc.c       | 13 ---------
 drivers/net/wireless/rsi/rsi_91x_main.c       | 29 -------------------
 10 files changed, 156 deletions(-)

diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index a0053e3992a3..b8526805ffac 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -401,19 +401,3 @@ EXPORT_SYMBOL(com20020_netdev_ops);
 
 MODULE_DESCRIPTION("ARCnet COM20020 chipset core driver");
 MODULE_LICENSE("GPL");
-
-#ifdef MODULE
-
-static int __init com20020_module_init(void)
-{
-	if (BUGLVL(D_NORMAL))
-		pr_info("%s\n", "COM20020 chipset support (by David Woodhouse et al.)");
-	return 0;
-}
-
-static void __exit com20020_module_exit(void)
-{
-}
-module_init(com20020_module_init);
-module_exit(com20020_module_exit);
-#endif				/* MODULE */
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index a8fa0d6516b9..7c5aa8d399d4 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -725,19 +725,3 @@ void unregister_sja1000dev(struct net_device *dev)
 	unregister_candev(dev);
 }
 EXPORT_SYMBOL_GPL(unregister_sja1000dev);
-
-static __init int sja1000_init(void)
-{
-	printk(KERN_INFO "%s CAN netdevice driver\n", DRV_NAME);
-
-	return 0;
-}
-
-module_init(sja1000_init);
-
-static __exit void sja1000_exit(void)
-{
-	printk(KERN_INFO "%s: driver removed\n", DRV_NAME);
-}
-
-module_exit(sja1000_exit);
diff --git a/drivers/net/ethernet/8390/8390.c b/drivers/net/ethernet/8390/8390.c
index c5636245f1ca..8e4354568f04 100644
--- a/drivers/net/ethernet/8390/8390.c
+++ b/drivers/net/ethernet/8390/8390.c
@@ -86,19 +86,5 @@ void NS8390_init(struct net_device *dev, int startp)
 }
 EXPORT_SYMBOL(NS8390_init);
 
-#if defined(MODULE)
-
-static int __init ns8390_module_init(void)
-{
-	return 0;
-}
-
-static void __exit ns8390_module_exit(void)
-{
-}
-
-module_init(ns8390_module_init);
-module_exit(ns8390_module_exit);
-#endif /* MODULE */
 MODULE_DESCRIPTION("National Semiconductor 8390 core driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/8390/8390p.c b/drivers/net/ethernet/8390/8390p.c
index 6d429b11e9c6..a0bfc8e34f79 100644
--- a/drivers/net/ethernet/8390/8390p.c
+++ b/drivers/net/ethernet/8390/8390p.c
@@ -91,16 +91,5 @@ void NS8390p_init(struct net_device *dev, int startp)
 }
 EXPORT_SYMBOL(NS8390p_init);
 
-static int __init NS8390p_init_module(void)
-{
-	return 0;
-}
-
-static void __exit NS8390p_cleanup_module(void)
-{
-}
-
-module_init(NS8390p_init_module);
-module_exit(NS8390p_cleanup_module);
 MODULE_DESCRIPTION("National Semiconductor 8390 core for ISA driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 8769cba2c746..7da9ef254b72 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -2542,18 +2542,6 @@ void mlxsw_pci_driver_unregister(struct pci_driver *pci_driver)
 }
 EXPORT_SYMBOL(mlxsw_pci_driver_unregister);
 
-static int __init mlxsw_pci_module_init(void)
-{
-	return 0;
-}
-
-static void __exit mlxsw_pci_module_exit(void)
-{
-}
-
-module_init(mlxsw_pci_module_init);
-module_exit(mlxsw_pci_module_exit);
-
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Jiri Pirko <jiri@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox switch PCI interface driver");
diff --git a/drivers/net/hamradio/hdlcdrv.c b/drivers/net/hamradio/hdlcdrv.c
index 2263029d1a20..3b88e465d08f 100644
--- a/drivers/net/hamradio/hdlcdrv.c
+++ b/drivers/net/hamradio/hdlcdrv.c
@@ -742,26 +742,6 @@ EXPORT_SYMBOL(hdlcdrv_unregister);
 
 /* --------------------------------------------------------------------- */
 
-static int __init hdlcdrv_init_driver(void)
-{
-	printk(KERN_INFO "hdlcdrv: (C) 1996-2000 Thomas Sailer HB9JNX/AE4WA\n");
-	printk(KERN_INFO "hdlcdrv: version 0.8\n");
-	return 0;
-}
-
-/* --------------------------------------------------------------------- */
-
-static void __exit hdlcdrv_cleanup_driver(void)
-{
-	printk(KERN_INFO "hdlcdrv: cleanup\n");
-}
-
-/* --------------------------------------------------------------------- */
-
 MODULE_AUTHOR("Thomas M. Sailer, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu");
 MODULE_DESCRIPTION("Packet Radio network interface HDLC encoder/decoder");
 MODULE_LICENSE("GPL");
-module_init(hdlcdrv_init_driver);
-module_exit(hdlcdrv_cleanup_driver);
-
-/* --------------------------------------------------------------------- */
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 5b50d9186f12..d0361aaf25ef 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -819,18 +819,5 @@ void net_failover_destroy(struct failover *failover)
 }
 EXPORT_SYMBOL_GPL(net_failover_destroy);
 
-static __init int
-net_failover_init(void)
-{
-	return 0;
-}
-module_init(net_failover_init);
-
-static __exit
-void net_failover_exit(void)
-{
-}
-module_exit(net_failover_exit);
-
 MODULE_DESCRIPTION("Failover driver for Paravirtual drivers");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/wireless/ath/ath9k/common.c b/drivers/net/wireless/ath/ath9k/common.c
index ffcf2276eb92..f55b3afb3777 100644
--- a/drivers/net/wireless/ath/ath9k/common.c
+++ b/drivers/net/wireless/ath/ath9k/common.c
@@ -403,15 +403,3 @@ void ath9k_cmn_init_crypto(struct ath_hw *ah)
 		ath_hw_keyreset(common, (u16) i);
 }
 EXPORT_SYMBOL(ath9k_cmn_init_crypto);
-
-static int __init ath9k_cmn_init(void)
-{
-	return 0;
-}
-module_init(ath9k_cmn_init);
-
-static void __exit ath9k_cmn_exit(void)
-{
-	return;
-}
-module_exit(ath9k_cmn_exit);
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c
index 4641999f3fe9..e88d92d3ae7a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c
@@ -519,16 +519,3 @@ MODULE_AUTHOR("Realtek WlanFAE	<wlanfae@realtek.com>");
 MODULE_AUTHOR("Larry Finger	<Larry.FInger@lwfinger.net>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek 802.11n PCI wireless core");
-
-static int __init rtl_btcoexist_module_init(void)
-{
-	return 0;
-}
-
-static void __exit rtl_btcoexist_module_exit(void)
-{
-	return;
-}
-
-module_init(rtl_btcoexist_module_init);
-module_exit(rtl_btcoexist_module_exit);
diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index 2112d8d277a9..a9bb37d5d581 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -425,35 +425,6 @@ void rsi_91x_deinit(struct rsi_hw *adapter)
 }
 EXPORT_SYMBOL_GPL(rsi_91x_deinit);
 
-/**
- * rsi_91x_hal_module_init() - This function is invoked when the module is
- *			       loaded into the kernel.
- *			       It registers the client driver.
- * @void: Void.
- *
- * Return: 0 on success, -1 on failure.
- */
-static int rsi_91x_hal_module_init(void)
-{
-	rsi_dbg(INIT_ZONE, "%s: Module init called\n", __func__);
-	return 0;
-}
-
-/**
- * rsi_91x_hal_module_exit() - This function is called at the time of
- *			       removing/unloading the module.
- *			       It unregisters the client driver.
- * @void: Void.
- *
- * Return: None.
- */
-static void rsi_91x_hal_module_exit(void)
-{
-	rsi_dbg(INIT_ZONE, "%s: Module exit called\n", __func__);
-}
-
-module_init(rsi_91x_hal_module_init);
-module_exit(rsi_91x_hal_module_exit);
 MODULE_AUTHOR("Redpine Signals Inc");
 MODULE_DESCRIPTION("Station driver for RSI 91x devices");
 MODULE_VERSION("0.1");
-- 
2.43.0


