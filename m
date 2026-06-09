Return-Path: <linux-can+bounces-7775-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OarLGLUmKGqM/AIAu9opvQ
	(envelope-from <linux-can+bounces-7775-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:44:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5935A66147C
	for <lists+linux-can@lfdr.de>; Tue, 09 Jun 2026 16:44:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7775-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7775-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 271783091C58
	for <lists+linux-can@lfdr.de>; Tue,  9 Jun 2026 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67EB341068;
	Tue,  9 Jun 2026 14:27:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352434D3B5;
	Tue,  9 Jun 2026 14:27:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015238; cv=none; b=JVyz4dI3tb+TOFyFlYHuVntsPAaqx/QSKm+soKrSc9lPgtnfiVqSUdKFOmXBgxlqm5B20IWk0XRqrtzBqEqHHcLbhZyjOVZmSjo9FRAzAR774xLBO+EjRfbLG/NQREK1gJliBHoab1Jz4sCnkk4IhT5OU37sapxCFr6viAIhbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015238; c=relaxed/simple;
	bh=nB6yR+5lHkcKXtcSPQmcAn47ObOmCovFrFplIEFItSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEdAVKjwEd9qtAqWmLoOyGzZJzqxenerF5zhhu2ijVk7IVPeXhFBwCMUK3zN+LQLtZIkm3Hu+TtY0l4S+syceub+nAlSUy8DN0FA5tWn+wtT/7VfPGE5dVoNbhE32AAqCj3U7x4TVdD7rxr6WOphQtYHsm8hWZCB2D12x1ahN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A421F00893;
	Tue,  9 Jun 2026 14:27:12 +0000 (UTC)
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
	Greg Ungerer <gerg@linux-m68k.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCHv2 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
Date: Wed, 10 Jun 2026 00:13:01 +1000
Message-ID: <20260609142139.1563360-6-gerg@linux-m68k.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7775-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS(0.00)[m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:arnd@kernel.org,m:wei.fang@nxp.com,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:nico@fluxnic.net,m:adureghello@baylibre.com,m:ulfh@kernel.org,m:linux-mmc@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:olteanv@gmail.com,m:gerg@linux-m68k.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gerg@linux-m68k.org,linux-can@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nxp.com,lists.linux.dev,fluxnic.net,baylibre.com,gmail.com,linux-m68k.org,pengutronix.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux-m68k.org:email,linux-m68k.org:mid,linux-m68k.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5935A66147C

Remove the local ColdFire definitions of readb()/readw()/readl() and
writeb()/writew()/writel() and use the asm-generic versions of them.

The implementation of the readX()/writeX() family of IO access functions
is non-standard on ColdFire platforms. They either return big-endian (that
is native endian) data, or on platforms with PCI bus support check the
supplied address and return either big or little endian data based on that
check. This is non-standard, they are expected to always return
little-endian byte ordered data. Unfortunately this behavior also means
that ioreadX()/iowroteX() and their big-endian counter parts
ioreadXbe()/iowriteXbe() are currently broken because they are implemented
using the readX()/writeX() functions.

The change to use the asm-generic versions of readX()/writeX() itself is
quite strait forward, just remove the ColdFire local versions of them.  But
this of course has implications for any remaining drivers that use any of
these IO access functions. A number of drivers can be independently fixed,
before this final fix to readX()/writeX() for ColdFire. A small number of
drivers cannot easily be independently fixed and remain in a working
state. Those drivers are fixed here as well:

drivers/dma/mcf-edma-main.c
  Supports big-endian access by setting the big-endian flag of
  the drivers struct fsl_edma_engine. But locally should be using
  ioread32be() and iowrite32be() instead of ioread32() and iowrite32().

drivers/net/can/flexcan/flexcan-core.c
  Setting the driver quirks flag for big-endian access will force
  driver to use correct access functions.

drivers/spi/spi-fsl-dspi.c
  Setting the regmap format_endian flags to use native endian will
  force driver to use appropriate big or little endian access on
  whatever platform it is built for.

These drivers have only been compile tested.

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for drivers/net/can/flexcan
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
v2: changed from RFC to PATCH
    use separate regmap config for mcf5441x (spi-fsl-dspi.c)
    reorder quirks for mcf5441x (flexcan-core.c)

 arch/m68k/include/asm/io_no.h          | 68 +++-----------------------
 drivers/dma/mcf-edma-main.c            | 14 +++---
 drivers/net/can/flexcan/flexcan-core.c |  1 +
 drivers/spi/spi-fsl-dspi.c             | 14 +++++-
 4 files changed, 27 insertions(+), 70 deletions(-)

diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
index 4f0f34b06e37..2f12f4ed0da5 100644
--- a/arch/m68k/include/asm/io_no.h
+++ b/arch/m68k/include/asm/io_no.h
@@ -3,15 +3,10 @@
 #define _M68KNOMMU_IO_H
 
 /*
- * Convert a physical memory address into a IO memory address.
- * For us this is trivially a type cast.
- */
-#define iomem(a)	((void __iomem *) (a))
-
-/*
- * The non-MMU m68k and ColdFire IO and memory mapped hardware access
- * functions have always worked in CPU native endian. We need to define
- * that behavior here first before we include asm-generic/io.h.
+ * Historically the raw native endian IO access macros for non-MMU m68k and
+ * ColdFire have accepted any integral value as the address argument.
+ * The asm-generic versions of these expect "void __iomem *" for the address,
+ * so define local permissive versions here.
  */
 #define __raw_readb(addr) \
     ({ u8 __v = (*(__force volatile u8 *) (addr)); __v; })
@@ -45,66 +40,15 @@
  * applies just the same of there is no MMU but something like a PCI bus
  * is present.
  */
-static int __cf_internalio(unsigned long addr)
+static inline int __cf_internalio(unsigned long addr)
 {
 	return (addr >= IOMEMBASE) && (addr <= IOMEMBASE + IOMEMSIZE - 1);
 }
 
-static int cf_internalio(const volatile void __iomem *addr)
+static inline int cf_internalio(const volatile void __iomem *addr)
 {
 	return __cf_internalio((unsigned long) addr);
 }
-
-/*
- * We need to treat built-in peripherals and bus based address ranges
- * differently. Local built-in peripherals (and the ColdFire SoC parts
- * have quite a lot of them) are always native endian - which is big
- * endian on m68k/ColdFire. Bus based address ranges, like the PCI bus,
- * are accessed little endian - so we need to byte swap those.
- */
-#define readw readw
-static inline u16 readw(const volatile void __iomem *addr)
-{
-	if (cf_internalio(addr))
-		return __raw_readw(addr);
-	return swab16(__raw_readw(addr));
-}
-
-#define readl readl
-static inline u32 readl(const volatile void __iomem *addr)
-{
-	if (cf_internalio(addr))
-		return __raw_readl(addr);
-	return swab32(__raw_readl(addr));
-}
-
-#define writew writew
-static inline void writew(u16 value, volatile void __iomem *addr)
-{
-	if (cf_internalio(addr))
-		__raw_writew(value, addr);
-	else
-		__raw_writew(swab16(value), addr);
-}
-
-#define writel writel
-static inline void writel(u32 value, volatile void __iomem *addr)
-{
-	if (cf_internalio(addr))
-		__raw_writel(value, addr);
-	else
-		__raw_writel(swab32(value), addr);
-}
-
-#else
-
-#define readb __raw_readb
-#define readw __raw_readw
-#define readl __raw_readl
-#define writeb __raw_writeb
-#define writew __raw_writew
-#define writel __raw_writel
-
 #endif /* IOMEMBASE */
 
 #if defined(CONFIG_COLDFIRE)
diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
index 9e1c6400c77b..4ed0ce644e37 100644
--- a/drivers/dma/mcf-edma-main.c
+++ b/drivers/dma/mcf-edma-main.c
@@ -21,9 +21,9 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *dev_id)
 	unsigned int ch;
 	u64 intmap;
 
-	intmap = ioread32(regs->inth);
+	intmap = ioread32be(regs->inth);
 	intmap <<= 32;
-	intmap |= ioread32(regs->intl);
+	intmap |= ioread32be(regs->intl);
 	if (!intmap)
 		return IRQ_NONE;
 
@@ -43,7 +43,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
 	struct edma_regs *regs = &mcf_edma->regs;
 	unsigned int err, ch;
 
-	err = ioread32(regs->errl);
+	err = ioread32be(regs->errl);
 	if (!err)
 		return IRQ_NONE;
 
@@ -55,7 +55,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *dev_id)
 		}
 	}
 
-	err = ioread32(regs->errh);
+	err = ioread32be(regs->errh);
 	if (!err)
 		return IRQ_NONE;
 
@@ -203,8 +203,8 @@ static int mcf_edma_probe(struct platform_device *pdev)
 		edma_write_tcdreg(mcf_chan, cpu_to_le32(0), csr);
 	}
 
-	iowrite32(~0, regs->inth);
-	iowrite32(~0, regs->intl);
+	iowrite32be(~0, regs->inth);
+	iowrite32be(~0, regs->intl);
 
 	ret = mcf_edma->drvdata->setup_irq(pdev, mcf_edma);
 	if (ret)
@@ -248,7 +248,7 @@ static int mcf_edma_probe(struct platform_device *pdev)
 	}
 
 	/* Enable round robin arbitration */
-	iowrite32(EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
+	iowrite32be(EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
 
 	return 0;
 }
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..f0571b97817b 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -295,6 +295,7 @@ static_assert(sizeof(struct flexcan_regs) ==  0x4 * 18 + 0xfb8);
 
 static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN |
 		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
 		FLEXCAN_QUIRK_SUPPORT_RX_FIFO,
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 9f2a7b8163b1..abd3b20c2f17 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -192,6 +192,7 @@ enum {
 	DSPI_XSPI_REGMAP,
 	S32G_DSPI_XSPI_REGMAP,
 	DSPI_PUSHR,
+	MCF5441X_DSPI_REGMAP,
 };
 
 static const struct regmap_config dspi_regmap_config[] = {
@@ -238,6 +239,17 @@ static const struct regmap_config dspi_regmap_config[] = {
 		.reg_stride	= 2,
 		.max_register	= 0x2,
 	},
+	[MCF5441X_DSPI_REGMAP] = {
+		.reg_bits	= 32,
+		.val_bits	= 32,
+		.reg_stride	= 4,
+		.max_register	= SPI_RXFR3,
+		.volatile_table	= &dspi_volatile_table,
+		.rd_table	= &dspi_access_table,
+		.wr_table	= &dspi_access_table,
+		.reg_format_endian = REGMAP_ENDIAN_BIG,
+		.val_format_endian = REGMAP_ENDIAN_BIG,
+	},
 };
 
 static const struct fsl_dspi_devtype_data devtype_data[] = {
@@ -303,7 +315,7 @@ static const struct fsl_dspi_devtype_data devtype_data[] = {
 		.trans_mode		= DSPI_DMA_MODE,
 		.max_clock_factor	= 8,
 		.fifo_size		= 16,
-		.regmap			= &dspi_regmap_config[DSPI_REGMAP],
+		.regmap			= &dspi_regmap_config[MCF5441X_DSPI_REGMAP],
 	},
 	[S32G] = {
 		.trans_mode	  = DSPI_XSPI_MODE,
-- 
2.54.0


