Return-Path: <linux-can+bounces-7772-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0WaPLIckKGrx+wIAu9opvQ
	(envelope-from <linux-can+bounces-7772-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:34:47 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BF366129E
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:34:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7772-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7772-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2A203009160
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC1233FE0A;
	Tue,  9 Jun 2026 14:25:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FECE32B126;
	Tue,  9 Jun 2026 14:25:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015144; cv=none; b=YUw0BFyyJuOkt3ndhUEGeleDLyd6Wj8JXX0MeCp+xEsY6K0n92YrH9J0HonfU0/71az3Lrl0H7v3+2719XWfbLN8IZw7DbUzfjzwxsTWBcmwA/Jyofj4Yviy0t8cLcT2eLuBXpEyTAg1u/jCkMw2mm4tWoja4BUvhik7Y11Oz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015144; c=relaxed/simple;
	bh=rffY4CyethuWreEaV3IdcILtZUUY+OP61QIlf5gygF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVD6S51i5YV4M6ql9Ofnyg1L7IqHV2chzjqMed9v0mrWDBBcweiCK9imOm4w2nZpXDFiihqQf+FB+1SVCgL57sOCuBh4Zb+tlC1u0iqSCn5dEcKYrZc+enu5wFRF/jn3+d6hu3c4Z4peKQeCFhVTq3PY79c6dn9gP6+KtXVoJWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C141F00893;
	Tue,  9 Jun 2026 14:25:38 +0000 (UTC)
From: Greg Ungerer <gerg@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	arnd@kernel.org,
	wei.fang@nxp.com,
	frank.li@nxp.com,
	shenwei.wang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	nico@fluxnic.net,
	adureghello@baylibre.com,
	ulfh@kernel.org,
	linux-mmc@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org,
	olteanv@gmail.com,
	Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCHv2 1/4] net: fec: do not use readl()/writel() for ColdFire
Date: Wed, 10 Jun 2026 00:12:58 +1000
Message-ID: <20260609142139.1563360-3-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609142139.1563360-1-gerg@linux-m68k.org>
References: <20260609142139.1563360-1-gerg@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7772-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS(0.00)[m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:arnd@kernel.org,m:wei.fang@nxp.com,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:nico@fluxnic.net,m:adureghello@baylibre.com,m:ulfh@kernel.org,m:linux-mmc@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:olteanv@gmail.com,m:gerg@linux-m68k.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gerg@linux-m68k.org,linux-can@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nxp.com,lists.linux.dev,fluxnic.net,baylibre.com,gmail.com,linux-m68k.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerg@linux-m68k.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux-m68k.org:email,linux-m68k.org:mid,linux-m68k.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23BF366129E

Modify the FEC driver to not directly use readl() and writel() to access
hardware registers but instead local fec_readl() and fec_writel() methods.
This allows for different architecture users of this driver to have
different underlying access functions - to support both little and big
endian hardware.

The FEC hardware block in ColdFire SoC parts is accessed big-endian.
The usual kernel readl()/writel() IO memory access methods are defined to
access little endian data. Change access for ColdFire to use __raw_readl()
and __raw_writel() access methods - which do not modify or swap bytes
on access.

The FEC driver works today because the m68k architecture io.h has a
kludge in the definitions of the readl() and writel() functions for
ColdFire that allow big-endian access if the address of the register to
access is within the SoC's internal peripheral registers. This is being
fixed in the near future to define readl() and writel() correctly - with
no byte swapping. Thus the motivation for this fix here.

__raw_readl()/__raw_writel() access methods are used instead of the more
commonly used ioread32be()/iowrite32be() here because those are broken too,
because of the current readl()/writel() kludge. They are implemented in
asm-generic/io.h in terms of readl()/writel().

Note that even when readl() and writel() are fixed on ColdFire they will
not be the right thing to use within the FEC driver on ColdFire hardware.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
v2: changed from RFC to PATCH
    minor reordering of local variables for preferred layout

 drivers/net/ethernet/freescale/fec.h      |  15 ++
 drivers/net/ethernet/freescale/fec_main.c | 257 +++++++++++-----------
 drivers/net/ethernet/freescale/fec_ptp.c  |  78 +++----
 3 files changed, 183 insertions(+), 167 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 7176803146f3..af31d946a638 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -701,5 +701,20 @@ int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
 		struct netlink_ext_ack *extack);
 void fec_ptp_get(struct net_device *ndev, struct kernel_hwtstamp_config *config);
 
+/*
+ * ColdFire SoC peripheral blocks are big-endian, so use the raw IO access
+ * functions for them.
+ */
+#ifdef CONFIG_COLDFIRE
+#define fec_readl __raw_readl
+#define fec_writel __raw_writel
+#define fec_readl_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(__raw_readl, addr, val, cond, delay_us, timeout_us)
+#else
+#define fec_readl readl
+#define fec_writel writel
+#define fec_readl_poll_timeout_atomic readl_poll_timeout_atomic
+#endif
+
 /****************************************************************************/
 #endif /* FEC_H */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 6ebde65d7f1b..023fde9cfa3b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -497,11 +497,11 @@ static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
 				 struct fec_enet_priv_tx_q *txq)
 {
 	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active) ||
-	    !readl(txq->bd.reg_desc_active))
-		writel(0, txq->bd.reg_desc_active);
+	    !fec_readl(txq->bd.reg_desc_active) ||
+	    !fec_readl(txq->bd.reg_desc_active) ||
+	    !fec_readl(txq->bd.reg_desc_active) ||
+	    !fec_readl(txq->bd.reg_desc_active))
+		fec_writel(0, txq->bd.reg_desc_active);
 }
 
 static struct bufdesc *
@@ -1069,7 +1069,7 @@ static void fec_enet_active_rxring(struct net_device *ndev)
 	int i;
 
 	for (i = 0; i < fep->num_rx_queues; i++)
-		writel(0, fep->rx_queue[i]->bd.reg_desc_active);
+		fec_writel(0, fep->rx_queue[i]->bd.reg_desc_active);
 }
 
 static void fec_enet_enable_ring(struct net_device *ndev)
@@ -1081,23 +1081,23 @@ static void fec_enet_enable_ring(struct net_device *ndev)
 
 	for (i = 0; i < fep->num_rx_queues; i++) {
 		rxq = fep->rx_queue[i];
-		writel(rxq->bd.dma, fep->hwp + FEC_R_DES_START(i));
-		writel(fep->max_buf_size, fep->hwp + FEC_R_BUFF_SIZE(i));
+		fec_writel(rxq->bd.dma, fep->hwp + FEC_R_DES_START(i));
+		fec_writel(fep->max_buf_size, fep->hwp + FEC_R_BUFF_SIZE(i));
 
 		/* enable DMA1/2 */
 		if (i)
-			writel(RCMR_MATCHEN | RCMR_CMP(i),
-			       fep->hwp + FEC_RCMR(i));
+			fec_writel(RCMR_MATCHEN | RCMR_CMP(i),
+				   fep->hwp + FEC_RCMR(i));
 	}
 
 	for (i = 0; i < fep->num_tx_queues; i++) {
 		txq = fep->tx_queue[i];
-		writel(txq->bd.dma, fep->hwp + FEC_X_DES_START(i));
+		fec_writel(txq->bd.dma, fep->hwp + FEC_X_DES_START(i));
 
 		/* enable DMA1/2 */
 		if (i)
-			writel(DMA_CLASS_EN | IDLE_SLOPE(i),
-			       fep->hwp + FEC_DMA_CFG(i));
+			fec_writel(DMA_CLASS_EN | IDLE_SLOPE(i),
+				   fep->hwp + FEC_DMA_CFG(i));
 	}
 }
 
@@ -1112,15 +1112,15 @@ static void fec_ctrl_reset(struct fec_enet_private *fep, bool allow_wol)
 	if (!allow_wol || !(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
 		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES ||
 		    ((fep->quirks & FEC_QUIRK_NO_HARD_RESET) && fep->link)) {
-			writel(0, fep->hwp + FEC_ECNTRL);
+			fec_writel(0, fep->hwp + FEC_ECNTRL);
 		} else {
-			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
+			fec_writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
 			udelay(10);
 		}
 	} else {
-		val = readl(fep->hwp + FEC_ECNTRL);
+		val = fec_readl(fep->hwp + FEC_ECNTRL);
 		val |= (FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
-		writel(val, fep->hwp + FEC_ECNTRL);
+		fec_writel(val, fep->hwp + FEC_ECNTRL);
 	}
 }
 
@@ -1128,11 +1128,11 @@ static void fec_set_hw_mac_addr(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
-	writel(ndev->dev_addr[3] | (ndev->dev_addr[2] << 8) |
-	       (ndev->dev_addr[1] << 16) | (ndev->dev_addr[0] << 24),
-	       fep->hwp + FEC_ADDR_LOW);
-	writel((ndev->dev_addr[5] << 16) | (ndev->dev_addr[4] << 24),
-	       fep->hwp + FEC_ADDR_HIGH);
+	fec_writel(ndev->dev_addr[3] | (ndev->dev_addr[2] << 8) |
+		   (ndev->dev_addr[1] << 16) | (ndev->dev_addr[0] << 24),
+		   fep->hwp + FEC_ADDR_LOW);
+	fec_writel((ndev->dev_addr[5] << 16) | (ndev->dev_addr[4] << 24),
+		   fep->hwp + FEC_ADDR_HIGH);
 }
 
 /*
@@ -1162,7 +1162,7 @@ fec_restart(struct net_device *ndev)
 	fec_set_hw_mac_addr(ndev);
 
 	/* Clear any outstanding interrupt, except MDIO. */
-	writel((0xffffffff & ~FEC_ENET_MII), fep->hwp + FEC_IEVENT);
+	fec_writel((0xffffffff & ~FEC_ENET_MII), fep->hwp + FEC_IEVENT);
 
 	fec_enet_bd_init(ndev);
 
@@ -1171,19 +1171,19 @@ fec_restart(struct net_device *ndev)
 	/* Enable MII mode */
 	if (fep->full_duplex == DUPLEX_FULL) {
 		/* FD enable */
-		writel(0x04, fep->hwp + FEC_X_CNTRL);
+		fec_writel(0x04, fep->hwp + FEC_X_CNTRL);
 	} else {
 		/* No Rcv on Xmit */
 		rcntl |= FEC_RCR_DRT;
-		writel(0x0, fep->hwp + FEC_X_CNTRL);
+		fec_writel(0x0, fep->hwp + FEC_X_CNTRL);
 	}
 
 	/* Set MII speed */
-	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
+	fec_writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
 
 #if !defined(CONFIG_M5272)
 	if (fep->quirks & FEC_QUIRK_HAS_RACC) {
-		u32 val = readl(fep->hwp + FEC_RACC);
+		u32 val = fec_readl(fep->hwp + FEC_RACC);
 
 		/* align IP header */
 		val |= FEC_RACC_SHIFT16;
@@ -1192,8 +1192,8 @@ fec_restart(struct net_device *ndev)
 			val |= FEC_RACC_OPTIONS;
 		else
 			val &= ~FEC_RACC_OPTIONS;
-		writel(val, fep->hwp + FEC_RACC);
-		writel(min(fep->rx_frame_size, fep->max_buf_size), fep->hwp + FEC_FTRL);
+		fec_writel(val, fep->hwp + FEC_RACC);
+		fec_writel(min(fep->rx_frame_size, fep->max_buf_size), fep->hwp + FEC_FTRL);
 	}
 #endif
 
@@ -1227,8 +1227,8 @@ fec_restart(struct net_device *ndev)
 		if (fep->quirks & FEC_QUIRK_USE_GASKET) {
 			u32 cfgr;
 			/* disable the gasket and wait */
-			writel(0, fep->hwp + FEC_MIIGSK_ENR);
-			while (readl(fep->hwp + FEC_MIIGSK_ENR) & 4)
+			fec_writel(0, fep->hwp + FEC_MIIGSK_ENR);
+			while (fec_readl(fep->hwp + FEC_MIIGSK_ENR) & 4)
 				udelay(1);
 
 			/*
@@ -1240,10 +1240,10 @@ fec_restart(struct net_device *ndev)
 				? BM_MIIGSK_CFGR_RMII : BM_MIIGSK_CFGR_MII;
 			if (ndev->phydev && ndev->phydev->speed == SPEED_10)
 				cfgr |= BM_MIIGSK_CFGR_FRCONT_10M;
-			writel(cfgr, fep->hwp + FEC_MIIGSK_CFGR);
+			fec_writel(cfgr, fep->hwp + FEC_MIIGSK_CFGR);
 
 			/* re-enable the gasket */
-			writel(2, fep->hwp + FEC_MIIGSK_ENR);
+			fec_writel(2, fep->hwp + FEC_MIIGSK_ENR);
 		}
 #endif
 	}
@@ -1256,25 +1256,25 @@ fec_restart(struct net_device *ndev)
 		rcntl |= FEC_RCR_FLOWCTL;
 
 		/* set FIFO threshold parameter to reduce overrun */
-		writel(FEC_ENET_RSEM_V, fep->hwp + FEC_R_FIFO_RSEM);
-		writel(FEC_ENET_RSFL_V, fep->hwp + FEC_R_FIFO_RSFL);
-		writel(FEC_ENET_RAEM_V, fep->hwp + FEC_R_FIFO_RAEM);
-		writel(FEC_ENET_RAFL_V, fep->hwp + FEC_R_FIFO_RAFL);
+		fec_writel(FEC_ENET_RSEM_V, fep->hwp + FEC_R_FIFO_RSEM);
+		fec_writel(FEC_ENET_RSFL_V, fep->hwp + FEC_R_FIFO_RSFL);
+		fec_writel(FEC_ENET_RAEM_V, fep->hwp + FEC_R_FIFO_RAEM);
+		fec_writel(FEC_ENET_RAFL_V, fep->hwp + FEC_R_FIFO_RAFL);
 
 		/* OPD */
-		writel(FEC_ENET_OPD_V, fep->hwp + FEC_OPD);
+		fec_writel(FEC_ENET_OPD_V, fep->hwp + FEC_OPD);
 	} else {
 		rcntl &= ~FEC_RCR_FLOWCTL;
 	}
 #endif /* !defined(CONFIG_M5272) */
 
-	writel(rcntl, fep->hwp + FEC_R_CNTRL);
+	fec_writel(rcntl, fep->hwp + FEC_R_CNTRL);
 
 	/* Setup multicast filter. */
 	set_multicast_list(ndev);
 #ifndef CONFIG_M5272
-	writel(0, fep->hwp + FEC_HASH_TABLE_HIGH);
-	writel(0, fep->hwp + FEC_HASH_TABLE_LOW);
+	fec_writel(0, fep->hwp + FEC_HASH_TABLE_HIGH);
+	fec_writel(0, fep->hwp + FEC_HASH_TABLE_LOW);
 #endif
 
 	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
@@ -1290,9 +1290,9 @@ fec_restart(struct net_device *ndev)
 		 */
 		if ((fep->quirks & FEC_QUIRK_JUMBO_FRAME) &&
 		    (ndev->mtu > (PKT_MAXBUF_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN)))
-			writel(0xF, fep->hwp + FEC_X_WMRK);
+			fec_writel(0xF, fep->hwp + FEC_X_WMRK);
 		else
-			writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
+			fec_writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
 	}
 
 	if (fep->bufdesc_ex)
@@ -1307,11 +1307,11 @@ fec_restart(struct net_device *ndev)
 
 #ifndef CONFIG_M5272
 	/* Enable the MIB statistic event counters */
-	writel(0 << 31, fep->hwp + FEC_MIB_CTRLSTAT);
+	fec_writel(0 << 31, fep->hwp + FEC_MIB_CTRLSTAT);
 #endif
 
 	/* And last, enable the transmit and receive processing */
-	writel(ecntl, fep->hwp + FEC_ECNTRL);
+	fec_writel(ecntl, fep->hwp + FEC_ECNTRL);
 	fec_enet_active_rxring(ndev);
 
 	if (fep->bufdesc_ex) {
@@ -1321,9 +1321,9 @@ fec_restart(struct net_device *ndev)
 
 	/* Enable interrupts we wish to service */
 	if (fep->link)
-		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+		fec_writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
 	else
-		writel(0, fep->hwp + FEC_IMASK);
+		fec_writel(0, fep->hwp + FEC_IMASK);
 
 	/* Init the interrupt coalescing */
 	if (fep->quirks & FEC_QUIRK_HAS_COALESCE)
@@ -1384,29 +1384,30 @@ static void fec_irqs_disable(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
-	writel(0, fep->hwp + FEC_IMASK);
+	fec_writel(0, fep->hwp + FEC_IMASK);
 }
 
 static void fec_irqs_disable_except_wakeup(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
-	writel(0, fep->hwp + FEC_IMASK);
-	writel(FEC_ENET_WAKEUP, fep->hwp + FEC_IMASK);
+	fec_writel(0, fep->hwp + FEC_IMASK);
+	fec_writel(FEC_ENET_WAKEUP, fep->hwp + FEC_IMASK);
 }
 
 static void
 fec_stop(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
-	u32 val;
+	u32 rmii_mode, val;
+
+	rmii_mode = fec_readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
 
 	/* We cannot expect a graceful transmit stop without link !!! */
 	if (fep->link) {
-		writel(1, fep->hwp + FEC_X_CNTRL); /* Graceful transmit stop */
+		fec_writel(1, fep->hwp + FEC_X_CNTRL); /* Graceful transmit stop */
 		udelay(10);
-		if (!(readl(fep->hwp + FEC_IEVENT) & FEC_ENET_GRA))
+		if (!(fec_readl(fep->hwp + FEC_IEVENT) & FEC_ENET_GRA))
 			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
 	}
 
@@ -1414,20 +1415,20 @@ fec_stop(struct net_device *ndev)
 		fec_ptp_save_state(fep);
 
 	fec_ctrl_reset(fep, true);
-	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
-	writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+	fec_writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
+	fec_writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
 
 	/* We have to keep ENET enabled to have MII interrupt stay working */
 	if (fep->quirks & FEC_QUIRK_ENET_MAC &&
 		!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
-		writel(FEC_ECR_ETHEREN, fep->hwp + FEC_ECNTRL);
-		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
+		fec_writel(FEC_ECR_ETHEREN, fep->hwp + FEC_ECNTRL);
+		fec_writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
 	}
 
 	if (fep->bufdesc_ex) {
-		val = readl(fep->hwp + FEC_ECNTRL);
+		val = fec_readl(fep->hwp + FEC_ECNTRL);
 		val |= FEC_ECR_EN1588;
-		writel(val, fep->hwp + FEC_ECNTRL);
+		fec_writel(val, fep->hwp + FEC_ECNTRL);
 
 		fec_ptp_start_cyclecounter(ndev);
 		fec_ptp_restore_state(fep);
@@ -1713,8 +1714,8 @@ static int fec_enet_tx_queue(struct fec_enet_private *fep,
 
 	/* ERR006358: Keep the transmitter going */
 	if (bdp != txq->bd.cur &&
-	    readl(txq->bd.reg_desc_active) == 0)
-		writel(0, txq->bd.reg_desc_active);
+	    fec_readl(txq->bd.reg_desc_active) == 0)
+		fec_writel(0, txq->bd.reg_desc_active);
 
 	if (txq->xsk_pool) {
 		struct xsk_buff_pool *pool = txq->xsk_pool;
@@ -1923,7 +1924,7 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 			break;
 		pkt_received++;
 
-		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+		fec_writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
@@ -1991,7 +1992,7 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 		 * incoming frames.  On a heavily loaded network, we should be
 		 * able to keep up at the expense of system resources.
 		 */
-		writel(0, rxq->bd.reg_desc_active);
+		fec_writel(0, rxq->bd.reg_desc_active);
 	}
 	rxq->bd.cur = bdp;
 
@@ -2053,7 +2054,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 			break;
 		pkt_received++;
 
-		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+		fec_writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
 
 		/* Check for errors. */
 		status ^= BD_ENET_RX_LAST;
@@ -2166,7 +2167,7 @@ static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
 		 * incoming frames. On a heavily loaded network, we should be
 		 * able to keep up at the expense of system resources.
 		 */
-		writel(0, rxq->bd.reg_desc_active);
+		fec_writel(0, rxq->bd.reg_desc_active);
 	}
 
 	rxq->bd.cur = bdp;
@@ -2296,7 +2297,7 @@ static int fec_enet_rx_queue_xsk(struct fec_enet_private *fep, int queue,
 		if (unlikely(pkt_received >= budget))
 			break;
 
-		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+		fec_writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
 		xsk = rxq->rx_buf[index].xdp;
@@ -2428,7 +2429,7 @@ static int fec_enet_rx_queue_xsk(struct fec_enet_private *fep, int queue,
 		 * incoming frames. On a heavily loaded network, we should be
 		 * able to keep up at the expense of system resources.
 		 */
-		writel(0, rxq->bd.reg_desc_active);
+		fec_writel(0, rxq->bd.reg_desc_active);
 	}
 
 	rxq->bd.cur = bdp;
@@ -2475,12 +2476,12 @@ static bool fec_enet_collect_events(struct fec_enet_private *fep)
 {
 	uint int_events;
 
-	int_events = readl(fep->hwp + FEC_IEVENT);
+	int_events = fec_readl(fep->hwp + FEC_IEVENT);
 
 	/* Don't clear MDIO events, we poll for those */
 	int_events &= ~FEC_ENET_MII;
 
-	writel(int_events, fep->hwp + FEC_IEVENT);
+	fec_writel(int_events, fep->hwp + FEC_IEVENT);
 
 	return int_events != 0;
 }
@@ -2497,7 +2498,7 @@ fec_enet_interrupt(int irq, void *dev_id)
 
 		if (napi_schedule_prep(&fep->napi)) {
 			/* Disable interrupts */
-			writel(0, fep->hwp + FEC_IMASK);
+			fec_writel(0, fep->hwp + FEC_IMASK);
 			__napi_schedule(&fep->napi);
 		}
 	}
@@ -2520,7 +2521,7 @@ static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
 
 	if (max_done < budget) {
 		napi_complete_done(napi, max_done);
-		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
+		fec_writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
 		return max_done;
 	}
 
@@ -2576,9 +2577,9 @@ static int fec_get_mac(struct net_device *ndev)
 	 */
 	if (!is_valid_ether_addr(iap)) {
 		*((__be32 *) &tmpaddr[0]) =
-			cpu_to_be32(readl(fep->hwp + FEC_ADDR_LOW));
+			cpu_to_be32(fec_readl(fep->hwp + FEC_ADDR_LOW));
 		*((__be16 *) &tmpaddr[4]) =
-			cpu_to_be16(readl(fep->hwp + FEC_ADDR_HIGH) >> 16);
+			cpu_to_be16(fec_readl(fep->hwp + FEC_ADDR_HIGH) >> 16);
 		iap = &tmpaddr[0];
 	}
 
@@ -2630,8 +2631,8 @@ static int fec_enet_eee_mode_set(struct net_device *ndev, u32 lpi_timer,
 		wake_cycle = 0;
 	}
 
-	writel(sleep_cycle, fep->hwp + FEC_LPI_SLEEP);
-	writel(wake_cycle, fep->hwp + FEC_LPI_WAKE);
+	fec_writel(sleep_cycle, fep->hwp + FEC_LPI_SLEEP);
+	fec_writel(wake_cycle, fep->hwp + FEC_LPI_WAKE);
 
 	return 0;
 }
@@ -2701,11 +2702,11 @@ static int fec_enet_mdio_wait(struct fec_enet_private *fep)
 	uint ievent;
 	int ret;
 
-	ret = readl_poll_timeout_atomic(fep->hwp + FEC_IEVENT, ievent,
-					ievent & FEC_ENET_MII, 2, 30000);
+	ret = fec_readl_poll_timeout_atomic(fep->hwp + FEC_IEVENT, ievent,
+					    ievent & FEC_ENET_MII, 2, 30000);
 
 	if (!ret)
-		writel(FEC_ENET_MII, fep->hwp + FEC_IEVENT);
+		fec_writel(FEC_ENET_MII, fep->hwp + FEC_IEVENT);
 
 	return ret;
 }
@@ -2726,9 +2727,9 @@ static int fec_enet_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
 	frame_addr = regnum;
 
 	/* start a read op */
-	writel(frame_start | frame_op |
-	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
-	       FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
+	fec_writel(frame_start | frame_op |
+		   FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
+		   FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
 
 	/* wait for end of transfer */
 	ret = fec_enet_mdio_wait(fep);
@@ -2737,7 +2738,7 @@ static int fec_enet_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
 		goto out;
 	}
 
-	ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
+	ret = FEC_MMFR_DATA(fec_readl(fep->hwp + FEC_MII_DATA));
 
 out:
 	pm_runtime_put_autosuspend(dev);
@@ -2759,10 +2760,10 @@ static int fec_enet_mdio_read_c45(struct mii_bus *bus, int mii_id,
 	frame_start = FEC_MMFR_ST_C45;
 
 	/* write address */
-	writel(frame_start | FEC_MMFR_OP_ADDR_WRITE |
-	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
-	       FEC_MMFR_TA | (regnum & 0xFFFF),
-	       fep->hwp + FEC_MII_DATA);
+	fec_writel(frame_start | FEC_MMFR_OP_ADDR_WRITE |
+		   FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
+		   FEC_MMFR_TA | (regnum & 0xFFFF),
+		   fep->hwp + FEC_MII_DATA);
 
 	/* wait for end of transfer */
 	ret = fec_enet_mdio_wait(fep);
@@ -2774,9 +2775,9 @@ static int fec_enet_mdio_read_c45(struct mii_bus *bus, int mii_id,
 	frame_op = FEC_MMFR_OP_READ_C45;
 
 	/* start a read op */
-	writel(frame_start | frame_op |
-	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
-	       FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
+	fec_writel(frame_start | frame_op |
+		   FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
+		   FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
 
 	/* wait for end of transfer */
 	ret = fec_enet_mdio_wait(fep);
@@ -2785,7 +2786,7 @@ static int fec_enet_mdio_read_c45(struct mii_bus *bus, int mii_id,
 		goto out;
 	}
 
-	ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
+	ret = FEC_MMFR_DATA(fec_readl(fep->hwp + FEC_MII_DATA));
 
 out:
 	pm_runtime_put_autosuspend(dev);
@@ -2809,10 +2810,10 @@ static int fec_enet_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	frame_addr = regnum;
 
 	/* start a write op */
-	writel(frame_start | FEC_MMFR_OP_WRITE |
-	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
-	       FEC_MMFR_TA | FEC_MMFR_DATA(value),
-	       fep->hwp + FEC_MII_DATA);
+	fec_writel(frame_start | FEC_MMFR_OP_WRITE |
+		   FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
+		   FEC_MMFR_TA | FEC_MMFR_DATA(value),
+		   fep->hwp + FEC_MII_DATA);
 
 	/* wait for end of transfer */
 	ret = fec_enet_mdio_wait(fep);
@@ -2838,10 +2839,10 @@ static int fec_enet_mdio_write_c45(struct mii_bus *bus, int mii_id,
 	frame_start = FEC_MMFR_ST_C45;
 
 	/* write address */
-	writel(frame_start | FEC_MMFR_OP_ADDR_WRITE |
-	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
-	       FEC_MMFR_TA | (regnum & 0xFFFF),
-	       fep->hwp + FEC_MII_DATA);
+	fec_writel(frame_start | FEC_MMFR_OP_ADDR_WRITE |
+		   FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
+		   FEC_MMFR_TA | (regnum & 0xFFFF),
+		   fep->hwp + FEC_MII_DATA);
 
 	/* wait for end of transfer */
 	ret = fec_enet_mdio_wait(fep);
@@ -2851,10 +2852,10 @@ static int fec_enet_mdio_write_c45(struct mii_bus *bus, int mii_id,
 	}
 
 	/* start a write op */
-	writel(frame_start | FEC_MMFR_OP_WRITE |
-	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
-	       FEC_MMFR_TA | FEC_MMFR_DATA(value),
-	       fep->hwp + FEC_MII_DATA);
+	fec_writel(frame_start | FEC_MMFR_OP_WRITE |
+		   FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
+		   FEC_MMFR_TA | FEC_MMFR_DATA(value),
+		   fep->hwp + FEC_MII_DATA);
 
 	/* wait for end of transfer */
 	ret = fec_enet_mdio_wait(fep);
@@ -3132,13 +3133,13 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 		 * - writing MMFR:
 		 *	- mscr[7:0]_not_zero
 		 */
-		writel(0, fep->hwp + FEC_MII_DATA);
+		fec_writel(0, fep->hwp + FEC_MII_DATA);
 	}
 
-	writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
+	fec_writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
 
 	/* Clear any pending transaction complete indication */
-	writel(FEC_ENET_MII, fep->hwp + FEC_IEVENT);
+	fec_writel(FEC_ENET_MII, fep->hwp + FEC_IEVENT);
 
 	fep->mii_bus = mdiobus_alloc();
 	if (fep->mii_bus == NULL) {
@@ -3320,7 +3321,7 @@ static void fec_enet_get_regs(struct net_device *ndev,
 			continue;
 
 		off >>= 2;
-		buf[off] = readl(&theregs[off]);
+		buf[off] = fec_readl(&theregs[off]);
 	}
 
 	pm_runtime_put_autosuspend(dev);
@@ -3487,7 +3488,7 @@ static void fec_enet_update_ethtool_stats(struct net_device *dev)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fec_stats); i++)
-		fep->ethtool_stats[i] = readl(fep->hwp + fec_stats[i].offset);
+		fep->ethtool_stats[i] = fec_readl(fep->hwp + fec_stats[i].offset);
 }
 
 static void fec_enet_get_xdp_stats(struct fec_enet_private *fep, u64 *data)
@@ -3588,10 +3589,10 @@ static void fec_enet_clear_ethtool_stats(struct net_device *dev)
 	int i, j;
 
 	/* Disable MIB statistics counters */
-	writel(FEC_MIB_CTRLSTAT_DISABLE, fep->hwp + FEC_MIB_CTRLSTAT);
+	fec_writel(FEC_MIB_CTRLSTAT_DISABLE, fep->hwp + FEC_MIB_CTRLSTAT);
 
 	for (i = 0; i < ARRAY_SIZE(fec_stats); i++)
-		writel(0, fep->hwp + fec_stats[i].offset);
+		fec_writel(0, fep->hwp + fec_stats[i].offset);
 
 	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
 		rxq = fep->rx_queue[i];
@@ -3600,7 +3601,7 @@ static void fec_enet_clear_ethtool_stats(struct net_device *dev)
 	}
 
 	/* Don't disable MIB statistics counters */
-	writel(0, fep->hwp + FEC_MIB_CTRLSTAT);
+	fec_writel(0, fep->hwp + FEC_MIB_CTRLSTAT);
 }
 
 #else	/* !defined(CONFIG_M5272) */
@@ -3649,13 +3650,13 @@ static void fec_enet_itr_coal_set(struct net_device *ndev)
 		tx_itr |= FEC_ITR_ICTT(tx_ictt);
 	}
 
-	writel(tx_itr, fep->hwp + FEC_TXIC0);
-	writel(rx_itr, fep->hwp + FEC_RXIC0);
+	fec_writel(tx_itr, fep->hwp + FEC_TXIC0);
+	fec_writel(rx_itr, fep->hwp + FEC_RXIC0);
 	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
-		writel(tx_itr, fep->hwp + FEC_TXIC1);
-		writel(rx_itr, fep->hwp + FEC_RXIC1);
-		writel(tx_itr, fep->hwp + FEC_TXIC2);
-		writel(rx_itr, fep->hwp + FEC_RXIC2);
+		fec_writel(tx_itr, fep->hwp + FEC_TXIC1);
+		fec_writel(rx_itr, fep->hwp + FEC_RXIC1);
+		fec_writel(tx_itr, fep->hwp + FEC_TXIC2);
+		fec_writel(rx_itr, fep->hwp + FEC_RXIC2);
 	}
 }
 
@@ -4281,22 +4282,22 @@ static void set_multicast_list(struct net_device *ndev)
 	unsigned int hash_high = 0, hash_low = 0;
 
 	if (ndev->flags & IFF_PROMISC) {
-		tmp = readl(fep->hwp + FEC_R_CNTRL);
+		tmp = fec_readl(fep->hwp + FEC_R_CNTRL);
 		tmp |= 0x8;
-		writel(tmp, fep->hwp + FEC_R_CNTRL);
+		fec_writel(tmp, fep->hwp + FEC_R_CNTRL);
 		return;
 	}
 
-	tmp = readl(fep->hwp + FEC_R_CNTRL);
+	tmp = fec_readl(fep->hwp + FEC_R_CNTRL);
 	tmp &= ~0x8;
-	writel(tmp, fep->hwp + FEC_R_CNTRL);
+	fec_writel(tmp, fep->hwp + FEC_R_CNTRL);
 
 	if (ndev->flags & IFF_ALLMULTI) {
 		/* Catch all multicast addresses, so set the
 		 * filter to all 1's
 		 */
-		writel(0xffffffff, fep->hwp + FEC_GRP_HASH_TABLE_HIGH);
-		writel(0xffffffff, fep->hwp + FEC_GRP_HASH_TABLE_LOW);
+		fec_writel(0xffffffff, fep->hwp + FEC_GRP_HASH_TABLE_HIGH);
+		fec_writel(0xffffffff, fep->hwp + FEC_GRP_HASH_TABLE_LOW);
 
 		return;
 	}
@@ -4317,8 +4318,8 @@ static void set_multicast_list(struct net_device *ndev)
 			hash_low |= 1 << hash;
 	}
 
-	writel(hash_high, fep->hwp + FEC_GRP_HASH_TABLE_HIGH);
-	writel(hash_low, fep->hwp + FEC_GRP_HASH_TABLE_LOW);
+	fec_writel(hash_high, fep->hwp + FEC_GRP_HASH_TABLE_HIGH);
+	fec_writel(hash_low, fep->hwp + FEC_GRP_HASH_TABLE_LOW);
 }
 
 /* Set a MAC change in hardware. */
@@ -5003,7 +5004,7 @@ static int fec_enet_init(struct net_device *ndev)
 	ndev->netdev_ops = &fec_netdev_ops;
 	ndev->ethtool_ops = &fec_enet_ethtool_ops;
 
-	writel(FEC_RX_DISABLED_IMASK, fep->hwp + FEC_IMASK);
+	fec_writel(FEC_RX_DISABLED_IMASK, fep->hwp + FEC_IMASK);
 	netif_napi_add(ndev, &fep->napi, fec_enet_rx_napi);
 
 	if (fep->quirks & FEC_QUIRK_HAS_VLAN)
@@ -5607,9 +5608,9 @@ static int fec_resume(struct device *dev)
 				enable_irq(fep->wake_irq);
 			}
 
-			val = readl(fep->hwp + FEC_ECNTRL);
+			val = fec_readl(fep->hwp + FEC_ECNTRL);
 			val &= ~(FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
-			writel(val, fep->hwp + FEC_ECNTRL);
+			fec_writel(val, fep->hwp + FEC_ECNTRL);
 			fep->wol_flag &= ~FEC_WOL_FLAG_SLEEP_ON;
 		}
 		fec_restart(ndev);
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 56801c2009d5..07062599b522 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -102,14 +102,14 @@ static u64 fec_ptp_read(struct cyclecounter *cc)
 		container_of(cc, struct fec_enet_private, cc);
 	u32 tempval;
 
-	tempval = readl(fep->hwp + FEC_ATIME_CTRL);
+	tempval = fec_readl(fep->hwp + FEC_ATIME_CTRL);
 	tempval |= FEC_T_CTRL_CAPTURE;
-	writel(tempval, fep->hwp + FEC_ATIME_CTRL);
+	fec_writel(tempval, fep->hwp + FEC_ATIME_CTRL);
 
 	if (fep->quirks & FEC_QUIRK_BUG_CAPTURE)
 		udelay(1);
 
-	return readl(fep->hwp + FEC_ATIME);
+	return fec_readl(fep->hwp + FEC_ATIME);
 }
 
 /**
@@ -142,17 +142,17 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 	if (enable) {
 		/* clear capture or output compare interrupt status if have.
 		 */
-		writel(FEC_T_TF_MASK, fep->hwp + FEC_TCSR(fep->pps_channel));
+		fec_writel(FEC_T_TF_MASK, fep->hwp + FEC_TCSR(fep->pps_channel));
 
 		/* It is recommended to double check the TMODE field in the
 		 * TCSR register to be cleared before the first compare counter
 		 * is written into TCCR register. Just add a double check.
 		 */
-		val = readl(fep->hwp + FEC_TCSR(fep->pps_channel));
+		val = fec_readl(fep->hwp + FEC_TCSR(fep->pps_channel));
 		do {
 			val &= ~(FEC_T_TMODE_MASK);
-			writel(val, fep->hwp + FEC_TCSR(fep->pps_channel));
-			val = readl(fep->hwp + FEC_TCSR(fep->pps_channel));
+			fec_writel(val, fep->hwp + FEC_TCSR(fep->pps_channel));
+			val = fec_readl(fep->hwp + FEC_TCSR(fep->pps_channel));
 		} while (val & FEC_T_TMODE_MASK);
 
 		/* Dummy read counter to update the counter */
@@ -194,31 +194,31 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 		 * is bigger than fep->cc.mask would be a error.
 		 */
 		val &= fep->cc.mask;
-		writel(val, fep->hwp + FEC_TCCR(fep->pps_channel));
+		fec_writel(val, fep->hwp + FEC_TCCR(fep->pps_channel));
 
 		/* Calculate the second the compare event timestamp */
 		fep->next_counter = (val + fep->reload_period) & fep->cc.mask;
 
 		/* * Enable compare event when overflow */
-		val = readl(fep->hwp + FEC_ATIME_CTRL);
+		val = fec_readl(fep->hwp + FEC_ATIME_CTRL);
 		val |= FEC_T_CTRL_PINPER;
-		writel(val, fep->hwp + FEC_ATIME_CTRL);
+		fec_writel(val, fep->hwp + FEC_ATIME_CTRL);
 
 		/* Compare channel setting. */
-		val = readl(fep->hwp + FEC_TCSR(fep->pps_channel));
+		val = fec_readl(fep->hwp + FEC_TCSR(fep->pps_channel));
 		val |= (1 << FEC_T_TF_OFFSET | 1 << FEC_T_TIE_OFFSET);
 		val &= ~(1 << FEC_T_TDRE_OFFSET);
 		val &= ~(FEC_T_TMODE_MASK);
 		val |= (FEC_HIGH_PULSE << FEC_T_TMODE_OFFSET);
-		writel(val, fep->hwp + FEC_TCSR(fep->pps_channel));
+		fec_writel(val, fep->hwp + FEC_TCSR(fep->pps_channel));
 
 		/* Write the second compare event timestamp and calculate
 		 * the third timestamp. Refer the TCCR register detail in the spec.
 		 */
-		writel(fep->next_counter, fep->hwp + FEC_TCCR(fep->pps_channel));
+		fec_writel(fep->next_counter, fep->hwp + FEC_TCCR(fep->pps_channel));
 		fep->next_counter = (fep->next_counter + fep->reload_period) & fep->cc.mask;
 	} else {
-		writel(0, fep->hwp + FEC_TCSR(fep->pps_channel));
+		fec_writel(0, fep->hwp + FEC_TCSR(fep->pps_channel));
 	}
 
 	fep->pps_enable = enable;
@@ -258,26 +258,26 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
 	compare_val = fep->perout_stime - curr_time + ptp_hc;
 	compare_val &= fep->cc.mask;
 
-	writel(compare_val, fep->hwp + FEC_TCCR(fep->pps_channel));
+	fec_writel(compare_val, fep->hwp + FEC_TCCR(fep->pps_channel));
 	fep->next_counter = (compare_val + fep->reload_period) & fep->cc.mask;
 
 	/* Enable compare event when overflow */
-	temp_val = readl(fep->hwp + FEC_ATIME_CTRL);
+	temp_val = fec_readl(fep->hwp + FEC_ATIME_CTRL);
 	temp_val |= FEC_T_CTRL_PINPER;
-	writel(temp_val, fep->hwp + FEC_ATIME_CTRL);
+	fec_writel(temp_val, fep->hwp + FEC_ATIME_CTRL);
 
 	/* Compare channel setting. */
-	temp_val = readl(fep->hwp + FEC_TCSR(fep->pps_channel));
+	temp_val = fec_readl(fep->hwp + FEC_TCSR(fep->pps_channel));
 	temp_val |= (1 << FEC_T_TF_OFFSET | 1 << FEC_T_TIE_OFFSET);
 	temp_val &= ~(1 << FEC_T_TDRE_OFFSET);
 	temp_val &= ~(FEC_T_TMODE_MASK);
 	temp_val |= (FEC_TMODE_TOGGLE << FEC_T_TMODE_OFFSET);
-	writel(temp_val, fep->hwp + FEC_TCSR(fep->pps_channel));
+	fec_writel(temp_val, fep->hwp + FEC_TCSR(fep->pps_channel));
 
 	/* Write the second compare event timestamp and calculate
 	 * the third timestamp. Refer the TCCR register detail in the spec.
 	 */
-	writel(fep->next_counter, fep->hwp + FEC_TCCR(fep->pps_channel));
+	fec_writel(fep->next_counter, fep->hwp + FEC_TCCR(fep->pps_channel));
 	fep->next_counter = (fep->next_counter + fep->reload_period) & fep->cc.mask;
 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
@@ -314,13 +314,13 @@ void fec_ptp_start_cyclecounter(struct net_device *ndev)
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 
 	/* 1ns counter */
-	writel(inc << FEC_T_INC_OFFSET, fep->hwp + FEC_ATIME_INC);
+	fec_writel(inc << FEC_T_INC_OFFSET, fep->hwp + FEC_ATIME_INC);
 
 	/* use 31-bit timer counter */
-	writel(FEC_COUNTER_PERIOD, fep->hwp + FEC_ATIME_EVT_PERIOD);
+	fec_writel(FEC_COUNTER_PERIOD, fep->hwp + FEC_ATIME_EVT_PERIOD);
 
-	writel(FEC_T_CTRL_ENABLE | FEC_T_CTRL_PERIOD_RST,
-		fep->hwp + FEC_ATIME_CTRL);
+	fec_writel(FEC_T_CTRL_ENABLE | FEC_T_CTRL_PERIOD_RST,
+		   fep->hwp + FEC_ATIME_CTRL);
 
 	memset(&fep->cc, 0, sizeof(fep->cc));
 	fep->cc.read = fec_ptp_read;
@@ -397,11 +397,11 @@ static int fec_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 
-	tmp = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_MASK;
+	tmp = fec_readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_MASK;
 	tmp |= corr_ns << FEC_T_INC_CORR_OFFSET;
-	writel(tmp, fep->hwp + FEC_ATIME_INC);
+	fec_writel(tmp, fep->hwp + FEC_ATIME_INC);
 	corr_period = corr_period > 1 ? corr_period - 1 : corr_period;
-	writel(corr_period, fep->hwp + FEC_ATIME_CORR);
+	fec_writel(corr_period, fep->hwp + FEC_ATIME_CORR);
 	/* dummy read to update the timer. */
 	timecounter_read(&fep->tc);
 
@@ -493,7 +493,7 @@ static int fec_ptp_settime(struct ptp_clock_info *ptp,
 	counter = ns & fep->cc.mask;
 
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
-	writel(counter, fep->hwp + FEC_ATIME);
+	fec_writel(counter, fep->hwp + FEC_ATIME);
 	timecounter_init(&fep->tc, &fep->cc, ns);
 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 	mutex_unlock(&fep->ptp_clk_mutex);
@@ -508,7 +508,7 @@ static int fec_ptp_pps_disable(struct fec_enet_private *fep, uint channel)
 
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 	fep->perout_enable = false;
-	writel(0, fep->hwp + FEC_TCSR(channel));
+	fec_writel(0, fep->hwp + FEC_TCSR(channel));
 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
 
 	return 0;
@@ -701,15 +701,15 @@ static irqreturn_t fec_pps_interrupt(int irq, void *dev_id)
 	u8 channel = fep->pps_channel;
 	struct ptp_clock_event event;
 
-	val = readl(fep->hwp + FEC_TCSR(channel));
+	val = fec_readl(fep->hwp + FEC_TCSR(channel));
 	if (val & FEC_T_TF_MASK) {
 		/* Write the next next compare(not the next according the spec)
 		 * value to the register
 		 */
-		writel(fep->next_counter, fep->hwp + FEC_TCCR(channel));
+		fec_writel(fep->next_counter, fep->hwp + FEC_TCCR(channel));
 		do {
-			writel(val, fep->hwp + FEC_TCSR(channel));
-		} while (readl(fep->hwp + FEC_TCSR(channel)) & FEC_T_TF_MASK);
+			fec_writel(val, fep->hwp + FEC_TCSR(channel));
+		} while (fec_readl(fep->hwp + FEC_TCSR(channel)) & FEC_T_TF_MASK);
 
 		/* Update the counter; */
 		fep->next_counter = (fep->next_counter + fep->reload_period) &
@@ -813,8 +813,8 @@ void fec_ptp_save_state(struct fec_enet_private *fep)
 	fep->ptp_saved_state.ns_phc = timecounter_read(&fep->tc);
 	fep->ptp_saved_state.ns_sys = ktime_get_ns();
 
-	fep->ptp_saved_state.at_corr = readl(fep->hwp + FEC_ATIME_CORR);
-	atime_inc_corr = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_CORR_MASK;
+	fep->ptp_saved_state.at_corr = fec_readl(fep->hwp + FEC_ATIME_CORR);
+	atime_inc_corr = fec_readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_CORR_MASK;
 	fep->ptp_saved_state.at_inc_corr = (u8)(atime_inc_corr >> FEC_T_INC_CORR_OFFSET);
 
 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
@@ -823,7 +823,7 @@ void fec_ptp_save_state(struct fec_enet_private *fep)
 /* Restore PTP functionality after a reset */
 void fec_ptp_restore_state(struct fec_enet_private *fep)
 {
-	u32 atime_inc = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_MASK;
+	u32 atime_inc = fec_readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_MASK;
 	unsigned long flags;
 	u32 counter;
 	u64 ns;
@@ -833,13 +833,13 @@ void fec_ptp_restore_state(struct fec_enet_private *fep)
 	/* Reset turned it off, so adjust our status flag */
 	fep->pps_enable = 0;
 
-	writel(fep->ptp_saved_state.at_corr, fep->hwp + FEC_ATIME_CORR);
+	fec_writel(fep->ptp_saved_state.at_corr, fep->hwp + FEC_ATIME_CORR);
 	atime_inc |= ((u32)fep->ptp_saved_state.at_inc_corr) << FEC_T_INC_CORR_OFFSET;
-	writel(atime_inc, fep->hwp + FEC_ATIME_INC);
+	fec_writel(atime_inc, fep->hwp + FEC_ATIME_INC);
 
 	ns = ktime_get_ns() - fep->ptp_saved_state.ns_sys + fep->ptp_saved_state.ns_phc;
 	counter = ns & fep->cc.mask;
-	writel(counter, fep->hwp + FEC_ATIME);
+	fec_writel(counter, fep->hwp + FEC_ATIME);
 	timecounter_init(&fep->tc, &fep->cc, ns);
 
 	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
-- 
2.54.0


