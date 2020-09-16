Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CAC26C574
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 18:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIPQ6g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Sep 2020 12:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgIPQ6O (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Sep 2020 12:58:14 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD369C02B8C5;
        Wed, 16 Sep 2020 05:14:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z22so10003885ejl.7;
        Wed, 16 Sep 2020 05:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BlFW35Z2ose/hJ4ArV2sT9rGpEacqRaGA06kVYXz91I=;
        b=BYevA3wyl87qjUNGoFnoejqLIx8Vu306vYI7b2zAUqvjmUVTfnxjumT/gRRmLYRMVe
         l0rlQYLdeo/ZeTfiw1dIFg6/yVzzCasI1RGfNWuMJVtjDdgjinLW5Dq5PMZw5YKmxzod
         A3dHe0FWFKeq7/FAEjgvbEBkrpZTu4142tb7ipCs4jr9goRghaRjtEiskcKCOM9d3Pdw
         AVvoqrl9lxGKBkmL5YnXSoNEAtXi2dbQer/DBPgFBUdc7CNaJEZ4PjaO7vL5kFqpOwe4
         ul2SYkcxFY8SALAYiMPPC2h04SETJDtOtBKF0iO/Y3NIyddAw9E1pxZj+cCdexDfQ+jU
         Fx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BlFW35Z2ose/hJ4ArV2sT9rGpEacqRaGA06kVYXz91I=;
        b=fn88MHVtekTrQr64a6w0miuvoh2Y8GTUIPMsE2dV2dfi1lwKKl3IkApJINxvKEjJgB
         hdt3xh+KQDOKVW4LtSH5vbcVlOdGOhsIZHPvTsa5KfMuACtBTqfNYvzr8tEhK6c9u2AY
         F73yELKGL3XKEXMKwxD83SGGTvfmFFJb0SiwALOFqHTzq21tklJpmiJVCyrVTJiZ6OO2
         DpujmrNEqLBxdrA2EGZyTLdwzLHbb9C6a7ehgQFCkyZQocpXN+TjosvgU5VGdzDoPaQR
         hYrnYncgisc94BZ3Wlub3+cq2irQMvH6It/Wo59exkUHRjIldJ9JE9Wq5jViqCw07Mzs
         3IMg==
X-Gm-Message-State: AOAM531TcOwhylcgFQRCo5X6vn+DireXUb2vJ2ieWoOmaTMF2khDuLhk
        ovat5c0+jM01XajMJV64vsk=
X-Google-Smtp-Source: ABdhPJyS9ePx8vjXwplfpRpBj8k1kFb24c1xMLces3WXqKS7LLF8JNXUdA8OR1GNlzb52ipklwWySg==
X-Received: by 2002:a17:907:43f6:: with SMTP id mu6mr25947963ejb.244.1600258480327;
        Wed, 16 Sep 2020 05:14:40 -0700 (PDT)
Received: from skbuf ([188.25.217.212])
        by smtp.gmail.com with ESMTPSA id d6sm14442376edm.31.2020.09.16.05.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 05:14:39 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:14:37 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     wg@grandegger.com, pankaj.bansal@nxp.com,
        pankaj.bansal@oss.nxp.com, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com, linux-kernel@vger.kernel.org,
        vladimir.oltean@nxp.com
Subject: Re: canfdtest on flexcan loopback
Message-ID: <20200916121437.lfk5vd22qfe3pyjg@skbuf>
References: <VI1PR04MB4093944944C574B138371F51F12F0@VI1PR04MB4093.eurprd04.prod.outlook.com>
 <20200916110154.hp4up6yhyokduvf2@skbuf>
 <20200916110448.dsla6vjzy4fvdr22@skbuf>
 <12688d2b-a198-ef5e-dd8f-64957df36574@pengutronix.de>
 <20200916114533.3hlthhfd7xmpamoa@skbuf>
 <77d5c83d-1fb2-0d8a-f1ed-bec4857796e7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d5c83d-1fb2-0d8a-f1ed-bec4857796e7@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Sep 16, 2020 at 02:01:11PM +0200, Marc Kleine-Budde wrote:
> On 9/16/20 1:45 PM, Vladimir Oltean wrote:
> > On Wed, Sep 16, 2020 at 01:32:49PM +0200, Marc Kleine-Budde wrote:
> >> Which driver are you using? The mainline driver only uses one TX buffer.
> >
> > Are there multiple flexcan drivers in circulation? Yes, the mainline
> > driver with a single priv->tx_mb.
>
> I assume nxp has several patches on their kernels. Are you using the mainline
> kernel or the one that's provided by nxp?

Ah, ok, that's what you mean.

So, yes, I'm using an NXP-provided kernel, just because the NXP
maintainers didn't bother to submit the SoC support upstream,
apparently.

Here's the diff to net-next, some things were added by me for debugging:
flexcan_dump_regs() and trace_canfd_frame().

I am using the fsl_lx2160a_r1_devtype_data structure, looking at the
delta it seems to me like most of the additions (CAN FD) should be
bypassed because I have commented out FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD.

Nonetheless, you bring up a good point. I'll try to bring into net-next
the minimum amount of required delta (which seems to be the
fsl_lx2160a_r1_devtype_data structure only), and I'll re-test.

--- net-next/drivers/net/can/flexcan.c	2020-05-20 14:15:30.365471681 +0300
+++ qoriq-linux/drivers/net/can/flexcan.c	2020-09-16 12:16:49.362992279 +0300
@@ -6,6 +6,7 @@
 // Copyright (c) 2009 Sascha Hauer, Pengutronix
 // Copyright (c) 2010-2017 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
 // Copyright (c) 2014 David Jander, Protonic Holland
+// Copyright 2015, 2018 NXP
 //
 // Based on code originally by Andrey Volkov <avolkov@varma-el.com>
 
@@ -26,7 +27,14 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/regmap.h>
+#include <trace/events/can.h>
+
+#ifdef CONFIG_IMX_SCU_SOC
+#include <linux/firmware/imx/sci.h>
+#include <dt-bindings/firmware/imx/rsrc.h>
+#endif
 
 #define DRV_NAME			"flexcan"
 
@@ -52,6 +60,7 @@
 #define FLEXCAN_MCR_IRMQ		BIT(16)
 #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
 #define FLEXCAN_MCR_AEN			BIT(12)
+#define FLEXCAN_MCR_FDEN		BIT(11)
 /* MCR_MAXMB: maximum used MBs is MAXMB + 1 */
 #define FLEXCAN_MCR_MAXMB(x)		((x) & 0x7f)
 #define FLEXCAN_MCR_IDAM_A		(0x0 << 8)
@@ -91,6 +100,7 @@
 #define FLEXCAN_CTRL2_MRP		BIT(18)
 #define FLEXCAN_CTRL2_RRS		BIT(17)
 #define FLEXCAN_CTRL2_EACEN		BIT(16)
+#define FLEXCAN_CTRL2_ISOCANFDEN	BIT(12)
 
 /* FLEXCAN memory error control register (MECR) bits */
 #define FLEXCAN_MECR_ECRWRDIS		BIT(31)
@@ -134,8 +144,30 @@
 	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)
 #define FLEXCAN_ESR_ALL_INT \
 	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
-	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
-	 FLEXCAN_ESR_WAK_INT)
+	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
+
+/* FLEXCAN Bit Timing register (CBT) bits */
+#define FLEXCAN_CBT_BTF			BIT(31)
+#define FLEXCAN_CBT_EPRESDIV(x)		(((x) & 0x3ff) << 21)
+#define FLEXCAN_CBT_ERJW(x)		(((x) & 0x0f) << 16)
+#define FLEXCAN_CBT_EPROPSEG(x)		(((x) & 0x3f) << 10)
+#define FLEXCAN_CBT_EPSEG1(x)		(((x) & 0x1f) << 5)
+#define FLEXCAN_CBT_EPSEG2(x)		((x) & 0x1f)
+
+/* FLEXCAN FD control register (FDCTRL) bits */
+#define FLEXCAN_FDCTRL_FDRATE		BIT(31)
+#define FLEXCAN_FDCTRL_TDCEN		BIT(15)
+#define FLEXCAN_FDCTRL_TDCFAIL		BIT(14)
+#define FLEXCAN_FDCTRL_MBDSR1(x)	(((x) & 0x3) << 19)
+#define FLEXCAN_FDCTRL_MBDSR0(x)	(((x) & 0x3) << 16)
+#define FLEXCAN_FDCTRL_TDCOFF(x)	(((x) & 0x1f) << 8)
+
+/* FLEXCAN FD Bit Timing register (FDCBT) bits */
+#define FLEXCAN_FDCBT_FPRESDIV(x)	(((x) & 0x3ff) << 20)
+#define FLEXCAN_FDCBT_FRJW(x)		(((x) & 0x07) << 16)
+#define FLEXCAN_FDCBT_FPROPSEG(x)	(((x) & 0x1f) << 10)
+#define FLEXCAN_FDCBT_FPSEG1(x)		(((x) & 0x07) << 5)
+#define FLEXCAN_FDCBT_FPSEG2(x)		((x) & 0x07)
 
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
@@ -161,6 +193,9 @@
 #define FLEXCAN_MB_CODE_TX_DATA		(0xc << 24)
 #define FLEXCAN_MB_CODE_TX_TANSWER	(0xe << 24)
 
+#define FLEXCAN_MB_CNT_EDL		BIT(31)
+#define FLEXCAN_MB_CNT_BRS		BIT(30)
+#define FLEXCAN_MB_CNT_ESI		BIT(29)
 #define FLEXCAN_MB_CNT_SRR		BIT(22)
 #define FLEXCAN_MB_CNT_IDE		BIT(21)
 #define FLEXCAN_MB_CNT_RTR		BIT(20)
@@ -172,15 +207,17 @@
 /* FLEXCAN hardware feature flags
  *
  * Below is some version info we got:
- *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR re-
- *                                Filter? connected?  Passive detection  ception in MB
- *   MX25  FlexCAN2  03.00.00.00     no        no        no       no        no
- *   MX28  FlexCAN2  03.00.04.00    yes       yes        no       no        no
- *   MX35  FlexCAN2  03.00.00.00     no        no        no       no        no
- *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no
- *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes
- *   VF610 FlexCAN3  ?               no       yes        no      yes       yes?
- * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no       yes
+ *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR rece-   FD Mode
+ *                                Filter? connected?  Passive detection  ption in MB Supported?
+ *   MX25  FlexCAN2  03.00.00.00     no        no        no       no        no           no
+ *   MX28  FlexCAN2  03.00.04.00    yes       yes        no       no        no           no
+ *   MX35  FlexCAN2  03.00.00.00     no        no        no       no        no           no
+ *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no           no
+ *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes           no
+ *  MX8QM  FlexCAN3  03.00.23.00    yes       yes        no       no       yes          yes
+ *   VF610 FlexCAN3  ?               no       yes        no      yes       yes?          no
+ * LS1021A FlexCAN2  03.00.04.00     no       yes        no       no       yes           no
+ * LX2160A FlexCAN3  03.00.23.00     no       yes        no       no       yes          yes
  *
  * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
  */
@@ -192,6 +229,8 @@
 #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error passive */
 #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE register access */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE		BIT(8) /* Setup stop mode to support wakeup */
+#define FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD	BIT(9) /* Use timestamp then support can fd mode */
+#define FLEXCAN_QUIRK_USE_SCFW			BIT(10) /* Use System Controller Firmware */
 
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -225,7 +264,8 @@
 	u32 crcr;		/* 0x44 */
 	u32 rxfgmask;		/* 0x48 */
 	u32 rxfir;		/* 0x4c */
-	u32 _reserved3[12];	/* 0x50 */
+	u32 cbt;		/* 0x50 */
+	u32 _reserved3[11];	/* 0x54 */
 	u8 mb[2][512];		/* 0x80 */
 	/* FIFO-mode:
 	 *			MB
@@ -250,6 +290,10 @@
 	u32 rerrdr;		/* 0xaf4 */
 	u32 rerrsynr;		/* 0xaf8 */
 	u32 errsr;		/* 0xafc */
+	u32 _reserved7[64];	/* 0xb00 */
+	u32 fdctrl;		/* 0xc00 */
+	u32 fdcbt;		/* 0xc04 */
+	u32 fdcrc;		/* 0xc08 */
 };
 
 struct flexcan_devtype_data {
@@ -287,6 +331,11 @@
 	struct regulator *reg_xceiver;
 	struct flexcan_stop_mode stm;
 
+#ifdef CONFIG_IMX_SCU_SOC
+	/* IPC handle when enable stop mode by System Controller firmware(scfw) */
+	struct imx_sc_ipc *sc_ipc_handle;
+#endif
+
 	/* Read and Write APIs */
 	u32 (*read)(void __iomem *addr);
 	void (*write)(u32 val, void __iomem *addr);
@@ -313,18 +362,36 @@
 		FLEXCAN_QUIRK_SETUP_STOP_MODE,
 };
 
+static struct flexcan_devtype_data fsl_imx8qm_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD | FLEXCAN_QUIRK_SETUP_STOP_MODE |
+		FLEXCAN_QUIRK_USE_SCFW,
+};
+
 static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
 		FLEXCAN_QUIRK_BROKEN_PERR_STATE,
 };
 
+static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE,
+#if 0
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD,
+#endif
+};
 static const struct flexcan_devtype_data fsl_ls1021a_r2_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
 		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
 };
 
+static struct flexcan_devtype_data fsl_s32v234_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_DISABLE_MECR,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -337,6 +404,30 @@
 	.brp_inc = 1,
 };
 
+static const struct can_bittiming_const flexcan_fd_bittiming_const = {
+	.name = DRV_NAME,
+	.tseg1_min = 2,
+	.tseg1_max = 96,
+	.tseg2_min = 2,
+	.tseg2_max = 32,
+	.sjw_max = 16,
+	.brp_min = 1,
+	.brp_max = 1024,
+	.brp_inc = 1,
+};
+
+static const struct can_bittiming_const flexcan_fd_data_bittiming_const = {
+	.name = DRV_NAME,
+	.tseg1_min = 2,
+	.tseg1_max = 39,
+	.tseg2_min = 2,
+	.tseg2_max = 8,
+	.sjw_max = 4,
+	.brp_min = 1,
+	.brp_max = 1024,
+	.brp_inc = 1,
+};
+
 /* FlexCAN module is essentially modelled as a little-endian IP in most
  * SoCs, i.e the registers as well as the message buffer areas are
  * implemented in a little-endian fashion.
@@ -389,7 +480,7 @@
 		(&priv->regs->mb[bank][priv->mb_size * mb_index]);
 }
 
-static int flexcan_low_power_enter_ack(struct flexcan_priv *priv)
+static int flexcan_enter_low_power_ack(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs = priv->regs;
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
@@ -403,7 +494,7 @@
 	return 0;
 }
 
-static int flexcan_low_power_exit_ack(struct flexcan_priv *priv)
+static int flexcan_exit_low_power_ack(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs = priv->regs;
 	unsigned int timeout = FLEXCAN_TIMEOUT_US / 10;
@@ -432,6 +523,74 @@
 	priv->write(reg_mcr, &regs->mcr);
 }
 
+#ifdef CONFIG_IMX_SCU_SOC
+static void flexcan_stop_mode_enable_scfw(struct flexcan_priv *priv, bool enabled)
+{
+	struct device_node *np = priv->dev->of_node;
+	u32 rsrc_id, val;
+	int idx;
+
+	idx = of_alias_get_id(np, "can");
+	if (idx == 0)
+		rsrc_id = IMX_SC_R_CAN_0;
+	else if (idx == 1)
+		rsrc_id = IMX_SC_R_CAN_1;
+	else
+		rsrc_id = IMX_SC_R_CAN_2;
+
+	val = enabled ? 1 : 0;
+	/* stop mode request */
+	imx_sc_misc_set_control(priv->sc_ipc_handle, rsrc_id, IMX_SC_C_IPG_STOP, val);
+}
+#else
+static int flexcan_stop_mode_enable_scfw(struct flexcan_priv *priv, bool enabled)
+{
+	return 0;
+}
+#endif
+
+static void flexcan_dump_regs(struct flexcan_priv *priv)
+{
+	struct flexcan_regs __iomem *regs = priv->regs;
+	int i;
+
+	dev_err(priv->dev, "mcr      = 0x%08x\n", priv->read(&regs->mcr));
+	dev_err(priv->dev, "ctrl     = 0x%08x\n", priv->read(&regs->ctrl));
+	dev_err(priv->dev, "timer    = 0x%08x\n", priv->read(&regs->timer));
+	dev_err(priv->dev, "rxgmask  = 0x%08x\n", priv->read(&regs->rxgmask));
+	dev_err(priv->dev, "rx14mask = 0x%08x\n", priv->read(&regs->rx14mask));
+	dev_err(priv->dev, "rx15mask = 0x%08x\n", priv->read(&regs->rx15mask));
+	dev_err(priv->dev, "ecr      = 0x%08x\n", priv->read(&regs->ecr));
+	dev_err(priv->dev, "esr      = 0x%08x\n", priv->read(&regs->esr));
+	dev_err(priv->dev, "imask2   = 0x%08x\n", priv->read(&regs->imask2));
+	dev_err(priv->dev, "imask1   = 0x%08x\n", priv->read(&regs->imask1));
+	dev_err(priv->dev, "iflag2   = 0x%08x\n", priv->read(&regs->iflag2));
+	dev_err(priv->dev, "iflag1   = 0x%08x\n", priv->read(&regs->iflag1));
+	dev_err(priv->dev, "ctrl2    = 0x%08x\n", priv->read(&regs->ctrl2));
+	dev_err(priv->dev, "esr2     = 0x%08x\n", priv->read(&regs->esr2));
+	dev_err(priv->dev, "imeur    = 0x%08x\n", priv->read(&regs->imeur));
+	dev_err(priv->dev, "lrfr     = 0x%08x\n", priv->read(&regs->lrfr));
+	dev_err(priv->dev, "crcr     = 0x%08x\n", priv->read(&regs->crcr));
+	dev_err(priv->dev, "rxfgmask = 0x%08x\n", priv->read(&regs->rxfgmask));
+	dev_err(priv->dev, "rxfir    = 0x%08x\n", priv->read(&regs->rxfir));
+	dev_err(priv->dev, "cbt      = 0x%08x\n", priv->read(&regs->cbt));
+	for (i = 0; i < 64; i++)
+		dev_err(priv->dev, "rximr[%2d]= 0x%08x\n", i,
+			priv->read(&regs->rximr[i]));
+	dev_err(priv->dev, "gfwr_mx6 = 0x%08x\n", priv->read(&regs->gfwr_mx6));
+	dev_err(priv->dev, "mecr     = 0x%08x\n", priv->read(&regs->mecr));
+	dev_err(priv->dev, "erriar   = 0x%08x\n", priv->read(&regs->erriar));
+	dev_err(priv->dev, "erridpr  = 0x%08x\n", priv->read(&regs->erridpr));
+	dev_err(priv->dev, "errippr  = 0x%08x\n", priv->read(&regs->errippr));
+	dev_err(priv->dev, "rerrar   = 0x%08x\n", priv->read(&regs->rerrar));
+	dev_err(priv->dev, "rerrdr   = 0x%08x\n", priv->read(&regs->rerrdr));
+	dev_err(priv->dev, "rerrsynr = 0x%08x\n", priv->read(&regs->rerrsynr));
+	dev_err(priv->dev, "errsr    = 0x%08x\n", priv->read(&regs->errsr));
+	dev_err(priv->dev, "fdctrl   = 0x%08x\n", priv->read(&regs->fdctrl));
+	dev_err(priv->dev, "fdcbt    = 0x%08x\n", priv->read(&regs->fdcbt));
+	dev_err(priv->dev, "fdcrc    = 0x%08x\n", priv->read(&regs->fdcrc));
+}
+
 static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs = priv->regs;
@@ -441,11 +600,15 @@
 	reg_mcr |= FLEXCAN_MCR_SLF_WAK;
 	priv->write(reg_mcr, &regs->mcr);
 
-	/* enable stop request */
-	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
-			   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
+	 /* enable stop request */
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_SCFW)
+		flexcan_stop_mode_enable_scfw(priv, true);
+	else
+		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
+				   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
 
-	return flexcan_low_power_enter_ack(priv);
+	/* get stop acknowledgment */
+	return flexcan_enter_low_power_ack(priv);
 }
 
 static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
@@ -454,15 +617,18 @@
 	u32 reg_mcr;
 
 	/* remove stop request */
-	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
-			   1 << priv->stm.req_bit, 0);
-
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_SCFW)
+		flexcan_stop_mode_enable_scfw(priv, false);
+	else
+		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
+				   1 << priv->stm.req_bit, 0);
 
 	reg_mcr = priv->read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_SLF_WAK;
 	priv->write(reg_mcr, &regs->mcr);
 
-	return flexcan_low_power_exit_ack(priv);
+	/* get stop acknowledgment */
+	return flexcan_exit_low_power_ack(priv);
 }
 
 static inline void flexcan_error_irq_enable(const struct flexcan_priv *priv)
@@ -527,7 +693,7 @@
 	reg &= ~FLEXCAN_MCR_MDIS;
 	priv->write(reg, &regs->mcr);
 
-	return flexcan_low_power_exit_ack(priv);
+	return flexcan_exit_low_power_ack(priv);
 }
 
 static int flexcan_chip_disable(struct flexcan_priv *priv)
@@ -539,7 +705,7 @@
 	reg |= FLEXCAN_MCR_MDIS;
 	priv->write(reg, &regs->mcr);
 
-	return flexcan_low_power_enter_ack(priv);
+	return flexcan_enter_low_power_ack(priv);
 }
 
 static int flexcan_chip_freeze(struct flexcan_priv *priv)
@@ -628,29 +794,37 @@
 static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
-	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	u32 can_id;
 	u32 data;
-	u32 ctrl = FLEXCAN_MB_CODE_TX_DATA | (cf->can_dlc << 16);
+	u32 ctrl = FLEXCAN_MB_CODE_TX_DATA | ((can_len2dlc(cfd->len)) << 16);
 	int i;
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(dev);
 
-	if (cf->can_id & CAN_EFF_FLAG) {
-		can_id = cf->can_id & CAN_EFF_MASK;
+	if (cfd->can_id & CAN_EFF_FLAG) {
+		can_id = cfd->can_id & CAN_EFF_MASK;
 		ctrl |= FLEXCAN_MB_CNT_IDE | FLEXCAN_MB_CNT_SRR;
 	} else {
-		can_id = (cf->can_id & CAN_SFF_MASK) << 18;
+		can_id = (cfd->can_id & CAN_SFF_MASK) << 18;
 	}
 
-	if (cf->can_id & CAN_RTR_FLAG)
+	if (cfd->can_id & CAN_RTR_FLAG)
 		ctrl |= FLEXCAN_MB_CNT_RTR;
 
-	for (i = 0; i < cf->can_dlc; i += sizeof(u32)) {
-		data = be32_to_cpup((__be32 *)&cf->data[i]);
+	if (can_is_canfd_skb(skb)) {
+		ctrl |= FLEXCAN_MB_CNT_EDL;
+
+		if (cfd->flags & CANFD_BRS)
+			ctrl |= FLEXCAN_MB_CNT_BRS;
+	}
+
+	for (i = 0; i < cfd->len; i += sizeof(u32)) {
+		data = be32_to_cpup((__be32 *)&cfd->data[i]);
 		priv->write(data, &priv->tx_mb->data[i / sizeof(u32)]);
 	}
 
@@ -667,6 +841,8 @@
 	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 		    &priv->tx_mb_reserved->can_ctrl);
 
+	trace_canfd_frame(skb, __func__, __LINE__);
+
 	return NETDEV_TX_OK;
 }
 
@@ -822,7 +998,7 @@
 	struct flexcan_regs __iomem *regs = priv->regs;
 	struct flexcan_mb __iomem *mb;
 	struct sk_buff *skb;
-	struct can_frame *cf;
+	struct canfd_frame *cfd;
 	u32 reg_ctrl, reg_id, reg_iflag1;
 	int i;
 
@@ -859,8 +1035,11 @@
 		reg_ctrl = priv->read(&mb->can_ctrl);
 	}
 
-	skb = alloc_can_skb(offload->dev, &cf);
-	if (!skb) {
+	if (reg_ctrl & FLEXCAN_MB_CNT_EDL)
+		skb = alloc_canfd_skb(offload->dev, &cfd);
+	else
+		skb = alloc_can_skb(offload->dev, (struct can_frame **)&cfd);
+	if (unlikely(!skb)) {
 		skb = ERR_PTR(-ENOMEM);
 		goto mark_as_read;
 	}
@@ -870,17 +1049,28 @@
 
 	reg_id = priv->read(&mb->can_id);
 	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
-		cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
+		cfd->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
-		cf->can_id = (reg_id >> 18) & CAN_SFF_MASK;
+		cfd->can_id = (reg_id >> 18) & CAN_SFF_MASK;
+
+	if (reg_ctrl & FLEXCAN_MB_CNT_EDL) {
+		cfd->len = can_dlc2len(get_canfd_dlc((reg_ctrl >> 16) & 0xf));
+
+		if (reg_ctrl & FLEXCAN_MB_CNT_BRS)
+			cfd->flags |= CANFD_BRS;
+	} else {
+		cfd->len = get_can_dlc((reg_ctrl >> 16) & 0xf);
+
+		if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
+			cfd->can_id |= CAN_RTR_FLAG;
+	}
 
-	if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
-		cf->can_id |= CAN_RTR_FLAG;
-	cf->can_dlc = get_can_dlc((reg_ctrl >> 16) & 0xf);
+	if (reg_ctrl & FLEXCAN_MB_CNT_ESI)
+		cfd->flags |= CANFD_ESI;
 
-	for (i = 0; i < cf->can_dlc; i += sizeof(u32)) {
+	for (i = 0; i < cfd->len; i += sizeof(u32)) {
 		__be32 data = cpu_to_be32(priv->read(&mb->data[i / sizeof(u32)]));
-		*(__be32 *)(cf->data + i) = data;
+		*(__be32 *)(cfd->data + i) = data;
 	}
 
  mark_as_read:
@@ -895,6 +1085,7 @@
 	 */
 	priv->read(&regs->timer);
 
+	trace_canfd_frame(skb, __func__, __LINE__);
 	return skb;
 }
 
@@ -961,6 +1152,12 @@
 
 	reg_esr = priv->read(&regs->esr);
 
+	/* ACK wakeup interrupt */
+	if (reg_esr & FLEXCAN_ESR_WAK_INT) {
+		handled = IRQ_HANDLED;
+		priv->write(reg_esr & FLEXCAN_ESR_WAK_INT, &regs->esr);
+	}
+
 	/* ACK all bus error and state change IRQ sources */
 	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
 		handled = IRQ_HANDLED;
@@ -1021,27 +1218,14 @@
 
 static void flexcan_set_bittiming(struct net_device *dev)
 {
-	const struct flexcan_priv *priv = netdev_priv(dev);
-	const struct can_bittiming *bt = &priv->can.bittiming;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct can_bittiming *bt = &priv->can.bittiming;
+	struct can_bittiming *dbt = &priv->can.data_bittiming;
 	struct flexcan_regs __iomem *regs = priv->regs;
-	u32 reg;
+	u32 reg, reg_cbt, reg_fdcbt, reg_fdctrl;
 
 	reg = priv->read(&regs->ctrl);
-	reg &= ~(FLEXCAN_CTRL_PRESDIV(0xff) |
-		 FLEXCAN_CTRL_RJW(0x3) |
-		 FLEXCAN_CTRL_PSEG1(0x7) |
-		 FLEXCAN_CTRL_PSEG2(0x7) |
-		 FLEXCAN_CTRL_PROPSEG(0x7) |
-		 FLEXCAN_CTRL_LPB |
-		 FLEXCAN_CTRL_SMP |
-		 FLEXCAN_CTRL_LOM);
-
-	reg |= FLEXCAN_CTRL_PRESDIV(bt->brp - 1) |
-		FLEXCAN_CTRL_PSEG1(bt->phase_seg1 - 1) |
-		FLEXCAN_CTRL_PSEG2(bt->phase_seg2 - 1) |
-		FLEXCAN_CTRL_RJW(bt->sjw - 1) |
-		FLEXCAN_CTRL_PROPSEG(bt->prop_seg - 1);
-
+	reg &= ~(FLEXCAN_CTRL_LPB | FLEXCAN_CTRL_SMP | FLEXCAN_CTRL_LOM);
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
 		reg |= FLEXCAN_CTRL_LPB;
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
@@ -1052,9 +1236,115 @@
 	netdev_dbg(dev, "writing ctrl=0x%08x\n", reg);
 	priv->write(reg, &regs->ctrl);
 
-	/* print chip status */
-	netdev_dbg(dev, "%s: mcr=0x%08x ctrl=0x%08x\n", __func__,
-		   priv->read(&regs->mcr), priv->read(&regs->ctrl));
+	if (priv->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
+		reg_cbt = priv->read(&regs->cbt);
+		reg_cbt &= ~(FLEXCAN_CBT_EPRESDIV(0x3ff) |
+			     FLEXCAN_CBT_EPSEG1(0x1f) |
+			     FLEXCAN_CBT_EPSEG2(0x1f) |
+			     FLEXCAN_CBT_ERJW(0x1f) |
+			     FLEXCAN_CBT_EPROPSEG(0x3f) |
+			     FLEXCAN_CBT_BTF);
+
+		/* CBT[EPSEG1] is 5 bit long and CBT[EPROPSEG] is 6 bit long.
+		 * The can_calc_bittiming tries to divide the tseg1 equally
+		 * between phase_seg1 and prop_seg, which may not fit in CBT
+		 * register. Therefore, if phase_seg1 is more than possible
+		 * value, increase prop_seg and decrease phase_seg1
+		 */
+		if (bt->phase_seg1 > 0x20) {
+			bt->prop_seg += (bt->phase_seg1 - 0x20);
+			bt->phase_seg1 = 0x20;
+		}
+
+		reg_cbt = FLEXCAN_CBT_EPRESDIV(bt->brp - 1) |
+				FLEXCAN_CBT_EPSEG1(bt->phase_seg1 - 1) |
+				FLEXCAN_CBT_EPSEG2(bt->phase_seg2 - 1) |
+				FLEXCAN_CBT_ERJW(bt->sjw - 1) |
+				FLEXCAN_CBT_EPROPSEG(bt->prop_seg - 1) |
+				FLEXCAN_CBT_BTF;
+		priv->write(reg_cbt, &regs->cbt);
+
+		netdev_dbg(dev, "bt: prediv %d seg1 %d seg2 %d rjw %d propseg %d\n",
+			   bt->brp - 1, bt->phase_seg1 - 1, bt->phase_seg2 - 1,
+			   bt->sjw - 1, bt->prop_seg - 1);
+
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+			reg_fdcbt = priv->read(&regs->fdcbt);
+			reg_fdcbt &= ~(FLEXCAN_FDCBT_FPRESDIV(0x3ff) |
+				       FLEXCAN_FDCBT_FPSEG1(0x07) |
+				       FLEXCAN_FDCBT_FPSEG2(0x07) |
+				       FLEXCAN_FDCBT_FRJW(0x07) |
+				       FLEXCAN_FDCBT_FPROPSEG(0x1f));
+
+			/* FDCBT[FPSEG1] is 3 bit long and FDCBT[FPROPSEG] is 5 bit long.
+			 * The can_calc_bittiming tries to divide the tseg1 equally
+			 * between phase_seg1 and prop_seg, which may not fit in FDCBT
+			 * register. Therefore, if phase_seg1 is more than possible
+			 * value, increase prop_seg and decrease phase_seg1
+			 */
+			if (dbt->phase_seg1 > 0x8) {
+				dbt->prop_seg += (dbt->phase_seg1 - 0x8);
+				dbt->phase_seg1 = 0x8;
+			}
+
+			reg_fdcbt = FLEXCAN_FDCBT_FPRESDIV(dbt->brp - 1) |
+					FLEXCAN_FDCBT_FPSEG1(dbt->phase_seg1 - 1) |
+					FLEXCAN_FDCBT_FPSEG2(dbt->phase_seg2 - 1) |
+					FLEXCAN_FDCBT_FRJW(dbt->sjw - 1) |
+					FLEXCAN_FDCBT_FPROPSEG(dbt->prop_seg);
+			priv->write(reg_fdcbt, &regs->fdcbt);
+
+			/* enable transceiver delay compensation(TDC) for fd frame.
+			 * TDC must be disabled when Loop Back mode is enabled.
+			 */
+			reg_fdctrl = priv->read(&regs->fdctrl);
+			if (!(reg & FLEXCAN_CTRL_LPB)) {
+				reg_fdctrl |= FLEXCAN_FDCTRL_TDCEN;
+				reg_fdctrl &= ~FLEXCAN_FDCTRL_TDCOFF(0x1f);
+				/* for the TDC to work reliably, the offset has to use optimal settings */
+				reg_fdctrl |= FLEXCAN_FDCTRL_TDCOFF(((dbt->phase_seg1 - 1) + dbt->prop_seg + 2) *
+								    ((dbt->brp -1) + 1));
+			}
+			priv->write(reg_fdctrl, &regs->fdctrl);
+
+			if (bt->brp != dbt->brp)
+				netdev_warn(dev, "Warning!! data brp = %d and brp = %d don't match.\n"
+					    "flexcan may not work. consider using different bitrate or data bitrate\n",
+					    dbt->brp, bt->brp);
+
+			netdev_dbg(dev, "fdbt: prediv %d seg1 %d seg2 %d rjw %d propseg %d\n",
+				   dbt->brp - 1, dbt->phase_seg1 - 1, dbt->phase_seg2 - 1,
+				   dbt->sjw - 1, dbt->prop_seg);
+
+			netdev_dbg(dev, "%s: mcr=0x%08x ctrl=0x%08x cbt=0x%08x fdcbt=0x%08x\n",
+				   __func__, priv->read(&regs->mcr),
+				   priv->read(&regs->ctrl),
+				   priv->read(&regs->cbt),
+				   priv->read(&regs->fdcbt));
+		}
+	} else {
+		reg = priv->read(&regs->ctrl);
+		reg &= ~(FLEXCAN_CTRL_PRESDIV(0xff) |
+			 FLEXCAN_CTRL_RJW(0x3) |
+			 FLEXCAN_CTRL_PSEG1(0x7) |
+			 FLEXCAN_CTRL_PSEG2(0x7) |
+			 FLEXCAN_CTRL_PROPSEG(0x7));
+
+		reg |= FLEXCAN_CTRL_PRESDIV(bt->brp - 1) |
+			FLEXCAN_CTRL_PSEG1(bt->phase_seg1 - 1) |
+			FLEXCAN_CTRL_PSEG2(bt->phase_seg2 - 1) |
+			FLEXCAN_CTRL_RJW(bt->sjw - 1) |
+			FLEXCAN_CTRL_PROPSEG(bt->prop_seg - 1);
+		priv->write(reg, &regs->ctrl);
+
+		netdev_dbg(dev, "bt: prediv %d seg1 %d seg2 %d rjw %d propseg %d\n",
+			   bt->brp - 1, bt->phase_seg1 - 1, bt->phase_seg2 - 1,
+			   bt->sjw - 1, bt->prop_seg - 1);
+
+		/* print chip status */
+		netdev_dbg(dev, "%s: mcr=0x%08x ctrl=0x%08x\n", __func__,
+			   priv->read(&regs->mcr), priv->read(&regs->ctrl));
+	}
 }
 
 /* flexcan_chip_start
@@ -1066,7 +1356,7 @@
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
-	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr;
+	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr, reg_fdctrl;
 	u64 reg_imask;
 	int err, i;
 	struct flexcan_mb __iomem *mb;
@@ -1163,6 +1453,32 @@
 	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
 	priv->write(reg_ctrl, &regs->ctrl);
 
+	/* FDCTRL */
+	if (priv->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
+		reg_fdctrl = priv->read(&regs->fdctrl) & ~FLEXCAN_FDCTRL_FDRATE;
+		reg_fdctrl &= ~FLEXCAN_FDCTRL_TDCEN;
+		reg_fdctrl &= ~(FLEXCAN_FDCTRL_MBDSR1(0x3) | FLEXCAN_FDCTRL_MBDSR0(0x3));
+		reg_mcr = priv->read(&regs->mcr) & ~FLEXCAN_MCR_FDEN;
+		reg_ctrl2 = priv->read(&regs->ctrl2) & ~FLEXCAN_CTRL2_ISOCANFDEN;
+
+		/* support BRS when set CAN FD mode
+		 * 64 bytes payload per MB and 7 MBs per RAM block by default
+		 * enable CAN FD mode
+		 */
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+			reg_fdctrl |= FLEXCAN_FDCTRL_FDRATE;
+			reg_fdctrl |= FLEXCAN_FDCTRL_MBDSR1(0x3) | FLEXCAN_FDCTRL_MBDSR0(0x3);
+			reg_mcr |= FLEXCAN_MCR_FDEN;
+
+			if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO))
+				reg_ctrl2 |= FLEXCAN_CTRL2_ISOCANFDEN;
+		}
+
+		priv->write(reg_fdctrl, &regs->fdctrl);
+		priv->write(reg_mcr, &regs->mcr);
+		priv->write(reg_ctrl2, &regs->ctrl2);
+	}
+
 	if ((priv->devtype_data->quirks & FLEXCAN_QUIRK_ENABLE_EACEN_RRS)) {
 		reg_ctrl2 = priv->read(&regs->ctrl2);
 		reg_ctrl2 |= FLEXCAN_CTRL2_EACEN | FLEXCAN_CTRL2_RRS;
@@ -1288,6 +1604,12 @@
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES) &&
+	    (priv->can.ctrlmode & CAN_CTRLMODE_FD)) {
+		netdev_err(dev, "three samples mode and fd mode can't be used together\n");
+		return -EINVAL;
+	}
+
 	err = pm_runtime_get_sync(priv->dev);
 	if (err < 0)
 		return err;
@@ -1300,7 +1622,10 @@
 	if (err)
 		goto out_close;
 
-	priv->mb_size = sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+		priv->mb_size = sizeof(struct flexcan_mb) + CANFD_MAX_DLEN;
+	else
+		priv->mb_size = sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
 	priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
 			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
 
@@ -1342,6 +1667,8 @@
 	can_rx_offload_enable(&priv->offload);
 	netif_start_queue(dev);
 
+	flexcan_dump_regs(priv);
+
 	return 0;
 
  out_offload_del:
@@ -1518,11 +1845,6 @@
 		gpr_np->full_name, priv->stm.req_gpr, priv->stm.req_bit,
 		priv->stm.ack_gpr, priv->stm.ack_bit);
 
-	device_set_wakeup_capable(&pdev->dev, true);
-
-	if (of_property_read_bool(np, "wakeup-source"))
-		device_set_wakeup_enable(&pdev->dev, true);
-
 	return 0;
 
 out_put_node:
@@ -1530,7 +1852,32 @@
 	return ret;
 }
 
+#ifdef CONFIG_IMX_SCU_SOC
+static int flexcan_setup_stop_mode_scfw(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+	struct flexcan_priv *priv;
+	int ret;
+
+	priv = netdev_priv(dev);
+
+	ret = imx_scu_get_handle(&(priv->sc_ipc_handle));
+	if (ret < 0) {
+		dev_err(&pdev->dev, "get ipc handle used by SCU failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+#else
+static int flexcan_setup_stop_mode_scfw(struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 static const struct of_device_id flexcan_of_match[] = {
+	{ .compatible = "fsl,imx8qm-flexcan", .data = &fsl_imx8qm_devtype_data, },
 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
 	{ .compatible = "fsl,imx53-flexcan", .data = &fsl_imx25_devtype_data, },
@@ -1539,6 +1886,9 @@
 	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
+	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
+	{ .compatible = "fsl,s32v234-flexcan",
+	  .data = &fsl_s32v234_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
@@ -1645,6 +1995,18 @@
 	priv->devtype_data = devtype_data;
 	priv->reg_xceiver = reg_xceiver;
 
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD) {
+		if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+			priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO;
+			priv->can.bittiming_const = &flexcan_fd_bittiming_const;
+			priv->can.data_bittiming_const = &flexcan_fd_data_bittiming_const;
+		} else {
+			dev_err(&pdev->dev, "can fd mode can't work on fifo mode\n");
+			err = -EINVAL;
+			goto failed_register;
+		}
+	}
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -1658,9 +2020,19 @@
 	devm_can_led_init(dev);
 
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
-		err = flexcan_setup_stop_mode(pdev);
-		if (err)
+		if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_SCFW)
+			err = flexcan_setup_stop_mode_scfw(pdev);
+		else
+			err = flexcan_setup_stop_mode(pdev);
+
+		if (err) {
 			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
+		} else {
+			device_set_wakeup_capable(&pdev->dev, true);
+
+			if (of_property_read_bool(pdev->dev.of_node, "wakeup-source"))
+				device_set_wakeup_enable(&pdev->dev, true);
+		}
 	}
 
 	return 0;
@@ -1685,7 +2057,7 @@
 {
 	struct net_device *dev = dev_get_drvdata(device);
 	struct flexcan_priv *priv = netdev_priv(dev);
-	int err = 0;
+	int err;
 
 	if (netif_running(dev)) {
 		/* if wakeup is enabled, enter stop mode
@@ -1697,25 +2069,28 @@
 			if (err)
 				return err;
 		} else {
-			err = flexcan_chip_disable(priv);
+			flexcan_chip_stop(dev);
+
+			err = pm_runtime_force_suspend(device);
 			if (err)
 				return err;
 
-			err = pm_runtime_force_suspend(device);
+			pinctrl_pm_select_sleep_state(device);
 		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
 	}
 	priv->can.state = CAN_STATE_SLEEPING;
 
-	return err;
+	return 0;
 }
 
 static int __maybe_unused flexcan_resume(struct device *device)
 {
 	struct net_device *dev = dev_get_drvdata(device);
 	struct flexcan_priv *priv = netdev_priv(dev);
-	int err = 0;
+	int err;
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
@@ -1727,15 +2102,19 @@
 			if (err)
 				return err;
 		} else {
+			pinctrl_pm_select_default_state(device);
+
 			err = pm_runtime_force_resume(device);
 			if (err)
 				return err;
 
-			err = flexcan_chip_enable(priv);
+			err = flexcan_chip_start(dev);
+			if (err)
+				return err;
 		}
 	}
 
-	return err;
+	return 0;
 }
 
 static int __maybe_unused flexcan_runtime_suspend(struct device *device)


Thanks,
-Vladimir
