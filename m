Return-Path: <linux-can+bounces-3821-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37E5AD6699
	for <lists+linux-can@lfdr.de>; Thu, 12 Jun 2025 06:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624BE3A2DD1
	for <lists+linux-can@lfdr.de>; Thu, 12 Jun 2025 04:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543E71C32FF;
	Thu, 12 Jun 2025 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CZ6nRvX6"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E92F4321;
	Thu, 12 Jun 2025 04:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700905; cv=none; b=HWQ0DMgwSeFQyIUnXI1YOpgY/F7KslBWDTV9MxD8vqpAh47bSujYTM52ZNH6Ove+TWnXwIDfRck29UeGnQvlKPbHNUVUe7KkMTwOOssz8sR1u35oqFj6OIyoFPkeBxDfyLZ79Rgu5F3ljkSfpoYv66dxS3BG2uEJTg4K32ZhNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700905; c=relaxed/simple;
	bh=Xl9IJk+Or3dcsl1dHrURMatMQESPYHgQIYPxqiSWVfg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O/jEZrFM8hsP4lTAe+uQo/yF4R/1JWW/7grZWqYp2YbWV8mFiKds0465HkKCvpUEE/tyotTSeJt+cDuIZEyB+DnvA6RHWVd2VXr1gMpOnpAAwqV5SVA/N/BhBi9+ryONeC/s2koLfQeMjvKeED/ySrHWBlznoJZnLcjh2GHbqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=CZ6nRvX6; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id PZ6ouUow4A6zePZ72ux1Ti; Thu, 12 Jun 2025 06:00:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1749700829;
	bh=piFlliUk5gxIuODns+BuKiQaW1Okfu37ZFTizIK+/5E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=CZ6nRvX6/RBt/P65SG22jp38/9ROvXwFbqWuH0MvUN/n9KQubcfOgzw/NibJ/QI0a
	 +DINoaA/8GhcDVEugnVjXcHl7dTBivVN5n+nm8xfElGr/+btTSdlYE/DpqBUbIoHiy
	 TX6Kte6Dq0PfLIGhIjcZeie2K0haE2RTpfJgBI7eNqBjPBQoWH3sZAk4qsIOP30Ypb
	 jiz7UjBEcg/oWvc4gFEHsMnMXs5/IYz6RMd6LFgEHschpCsJSJaD4ImNU/zp9cW4fJ
	 phCXq1XpUNQuofRlw3yCg8rt8fzeJnQ6me3V7SYG5dVCGMTxJwKauZDtfKjgSmACRs
	 sJRF1ouMxZtPw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 12 Jun 2025 06:00:29 +0200
X-ME-IP: 124.33.176.97
Message-ID: <420d37b1-5648-4209-8d6f-1ac9d780eea2@wanadoo.fr>
Date: Thu, 12 Jun 2025 13:00:09 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v2 06/10] can: rcar_canfd: Repurpose f_dcfg base for other
 registers
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <cover.1749655315.git.geert+renesas@glider.be>
 <75c8197c849fc9e360a75d4fa55bc01c1d850433.1749655315.git.geert+renesas@glider.be>
Content-Language: en-US
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <75c8197c849fc9e360a75d4fa55bc01c1d850433.1749655315.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/06/2025 at 00:37, Geert Uytterhoeven wrote:
> Reuse the existing Channel Data Bitrate Configuration Register offset
> member in the register configuration as the base offset for all related
> channel-specific registers.
> Rename the member and update the (incorrect) comment to reflect this.
> Replace the function-like channel-specific register offset macros by
> inline functions.
> 
> This fixes the offsets of all other (currently unused) channel-specific
> registers on R-Car Gen4 and RZ/G3E, and allows us to replace
> RCANFD_GEN4_FDCFG() by the more generic rcar_canfd_f_cfdcfg().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> v2:
>   - Add Reviewed-by.
>   - Replace function-like macros by inline functions,

Thanks!

>   - s/addresses/offsets/.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 52 ++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index dded509793bb93ec..8baf8a928da757f2 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -425,19 +425,10 @@
>  #define RCANFD_C_RPGACC(r)		(0x1900 + (0x04 * (r)))
>  
>  /* R-Car Gen4 Classical and CAN FD mode specific register map */
> -#define RCANFD_GEN4_FDCFG(m)		(0x1404 + (0x20 * (m)))
> -
>  #define RCANFD_GEN4_GAFL_OFFSET		(0x1800)
>  
>  /* CAN FD mode specific register map */
>  
> -/* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
> -#define RCANFD_F_DCFG(gpriv, m)		((gpriv)->info->regs->f_dcfg + (0x20 * (m)))
> -#define RCANFD_F_CFDCFG(m)		(0x0504 + (0x20 * (m)))
> -#define RCANFD_F_CFDCTR(m)		(0x0508 + (0x20 * (m)))
> -#define RCANFD_F_CFDSTS(m)		(0x050c + (0x20 * (m)))
> -#define RCANFD_F_CFDCRC(m)		(0x0510 + (0x20 * (m)))
> -
>  /* RSCFDnCFDGAFLXXXj offset */
>  #define RCANFD_F_GAFL_OFFSET		(0x1000)
>  
> @@ -510,7 +501,7 @@ struct rcar_canfd_regs {
>  	u16 cfcc;	/* Common FIFO Configuration/Control Register */
>  	u16 cfsts;	/* Common FIFO Status Register */
>  	u16 cfpctr;	/* Common FIFO Pointer Control Register */
> -	u16 f_dcfg;	/* Global FD Configuration Register */
> +	u16 coffset;	/* Channel Data Bitrate Configuration Register */
>  	u16 rfoffset;	/* Receive FIFO buffer access ID register */
>  	u16 cfoffset;	/* Transmit/receive FIFO buffer access ID register */
>  };
> @@ -641,7 +632,7 @@ static const struct rcar_canfd_regs rcar_gen3_regs = {
>  	.cfcc = 0x0118,
>  	.cfsts = 0x0178,
>  	.cfpctr = 0x01d8,
> -	.f_dcfg = 0x0500,
> +	.coffset = 0x0500,
>  	.rfoffset = 0x3000,
>  	.cfoffset = 0x3400,
>  };
> @@ -651,7 +642,7 @@ static const struct rcar_canfd_regs rcar_gen4_regs = {
>  	.cfcc = 0x0120,
>  	.cfsts = 0x01e0,
>  	.cfpctr = 0x0240,
> -	.f_dcfg = 0x1400,
> +	.coffset = 0x1400,
>  	.rfoffset = 0x6000,
>  	.cfoffset = 0x6400,
>  };
> @@ -800,6 +791,37 @@ static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
>  		rcar_canfd_write(priv->base, off + i * sizeof(u32), data[i]);
>  }
>  
> +/* RSCFDnCFDCmXXX -> rcar_canfd_f_xxx(gpriv, ch) */
> +static inline unsigned int rcar_canfd_f_dcfg(struct rcar_canfd_global *gpriv,
> +					     unsigned int ch)
> +{
> +	return gpriv->info->regs->coffset + 0x00 + 0x20 * ch;
> +}
> +
> +static inline unsigned int rcar_canfd_f_cfdcfg(struct rcar_canfd_global *gpriv,
> +					       unsigned int ch)
> +{
> +	return gpriv->info->regs->coffset + 0x04 + 0x20 * ch;
> +}
> +
> +static inline unsigned int rcar_canfd_f_cfdctr(struct rcar_canfd_global *gpriv,
> +					       unsigned int ch)
> +{
> +	return gpriv->info->regs->coffset + 0x08 + 0x20 * ch;
> +}
> +
> +static inline unsigned int rcar_canfd_f_cfdsts(struct rcar_canfd_global *gpriv,
> +					       unsigned int ch)
> +{
> +	return gpriv->info->regs->coffset + 0x0c + 0x20 * ch;
> +}
> +
> +static inline unsigned int rcar_canfd_f_cfdcrc(struct rcar_canfd_global *gpriv,
> +					       unsigned int ch)
> +{
> +	return gpriv->info->regs->coffset + 0x10 + 0x20 * ch;
> +}
> +
>  static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
>  {
>  	u32 i;
> @@ -827,8 +849,8 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
>  
>  		for_each_set_bit(ch, &gpriv->channels_mask,
>  				 gpriv->info->max_channels)
> -			rcar_canfd_set_bit(gpriv->base, RCANFD_GEN4_FDCFG(ch),
> -					   val);
> +			rcar_canfd_set_bit(gpriv->base,
> +					   rcar_canfd_f_cfdcfg(gpriv, ch), val);
>  	} else {
>  		if (gpriv->fdmode)
>  			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
> @@ -1468,7 +1490,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
>  		cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
>  		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
>  
> -		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
> +		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
>  	} else {
>  		/* Classical CAN only mode */
>  		if (gpriv->info->shared_can_regs) {

Thinking of your code, you are still using some magic numbers, e.g.

  0x04 + 0x20 * ch

to access your registers. But at the end those magic numbers are just describing
a memory layout.

I think this can be describe as a C structure. This is what I have in mind:

--------------8<--------------
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 1e559c0ff038..487f40320c20 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -560,10 +560,21 @@ struct rcar_canfd_channel {
 	spinlock_t tx_lock;			/* To protect tx path */
 };
 
+struct rcar_canfd_f {
+	u32 dcfg;
+	u32 cfdcfg;
+	u32 cfdctr;
+	u32 cfdsts;
+	u32 cfdcrc;
+	u32 padding[3];
+};
+static_assert(sizeof(struct rcar_canfd_f) == 0x20);
+
 /* Global priv data */
 struct rcar_canfd_global {
 	struct rcar_canfd_channel *ch[RCANFD_NUM_CHANNELS];
 	void __iomem *base;		/* Register base address */
+	struct rcar_canfd_f __iomem *cbase;
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
@@ -803,6 +814,26 @@ static void rcar_canfd_update_bit(void __iomem *base, u32 reg,
 	rcar_canfd_update(mask, val, base + reg);
 }
 
+static inline u32 rcar_canfd_read_reg(void __iomem *addr)
+{
+	return readl(addr);
+}
+
+static inline void rcar_canfd_write_reg(void __iomem *addr, u32 val)
+{
+	writel(val, addr);
+}
+
+static void rcar_canfd_set_bit_reg(void __iomem *addr, u32 val)
+{
+	rcar_canfd_update(val, val, addr);
+}
+
+static void rcar_canfd_update_bit_reg(void __iomem *addr, u32 mask, u32 val)
+{
+	rcar_canfd_update(mask, val, addr);
+}
+
 static void rcar_canfd_get_data(struct rcar_canfd_channel *priv,
 				struct canfd_frame *cf, u32 off)
 {
@@ -825,37 +856,6 @@ static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
 		rcar_canfd_write(priv->base, off + i * sizeof(u32), data[i]);
 }
 
-/* RSCFDnCFDCmXXX -> rcar_canfd_f_xxx(gpriv, ch) */
-static inline unsigned int rcar_canfd_f_dcfg(struct rcar_canfd_global *gpriv,
-					     unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x00 + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdcfg(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x04 + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdctr(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x08 + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdsts(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x0c + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdcrc(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x10 + 0x20 * ch;
-}
-
 static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 {
 	u32 i;
@@ -883,8 +883,7 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 
 		for_each_set_bit(ch, &gpriv->channels_mask,
 				 gpriv->info->max_channels)
-			rcar_canfd_set_bit(gpriv->base,
-					   rcar_canfd_f_cfdcfg(gpriv, ch), val);
+			rcar_canfd_set_bit_reg(&gpriv->cbase[ch].cfdcfg, val);
 	} else {
 		if (gpriv->fdmode)
 			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
@@ -1533,7 +1532,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
 	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
-	rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
+	rcar_canfd_write_reg(&gpriv->cbase[ch].dcfg, cfg);
 
 	/* Transceiver Delay Compensation */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO) {
@@ -1546,8 +1545,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		tdco = min(tdc->tdcv + tdc->tdco, tdc_const->tdco_max) - 1;
 	}
 
-	rcar_canfd_update_bit(gpriv->base, rcar_canfd_f_cfdcfg(gpriv, ch), mask,
-			      tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
+	rcar_canfd_update_bit_reg(&gpriv->cbase[ch].cfdcfg, mask,
+				  tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
@@ -1861,7 +1860,7 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
 static unsigned int rcar_canfd_get_tdcr(struct rcar_canfd_global *gpriv,
 					unsigned int ch)
 {
-	u32 sts = rcar_canfd_read(gpriv->base, rcar_canfd_f_cfdsts(gpriv, ch));
+	u32 sts = rcar_canfd_read_reg(&gpriv->cbase[ch].cfdsts);
 	u32 tdcr = FIELD_GET(RCANFD_FDSTS_TDCR, sts);
 
 	return tdcr & (gpriv->info->tdc_const->tdcv_max - 1);
@@ -2170,6 +2169,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		goto fail_dev;
 	}
 	gpriv->base = addr;
+	gpriv->cbase = gpriv->base + gpriv->info->regs->coffset;
 
 	/* Request IRQ that's common for both channels */
 	if (info->shared_global_irqs) {
-------------->8--------------

(this applies on top of the last patch of your series)


To be honnest, I am happy to accept your patch as it is now, but what
do you think of the above? I think that this approach works with your
other macro as well.


Yours sincerely,
Vincent Mailhol

