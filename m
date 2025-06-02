Return-Path: <linux-can+bounces-3756-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF73ACAF40
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 15:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 940B97A4BC0
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D0B14901B;
	Mon,  2 Jun 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Y92FEGfp"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-67.smtpout.orange.fr [193.252.22.67])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CDE220685;
	Mon,  2 Jun 2025 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871700; cv=none; b=PDczIAJUWkS7uAKVbvHaeLyPnCNh0PWff+MQMXyF08BKxicHpiBQ5b+MbiBZGiHSLXGjDEtt09Iic5vmplOMO3KjJ7PA+Y8/FYJ8ISkJOiJxA4qorXmhXgB2WJchS9chiBTQnXR/NBqlnUEOoYPyhyI3iTlEl+UVzdIHBAJ8Q8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871700; c=relaxed/simple;
	bh=cWfiu1OUPJcMoJNmFL1xjlidXJ7lRtFSGyx1M+3m50U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9N1+9G9WM2Lg0zVQUDMke33KqPDTif4s7BxE7STkKqrQzkE+jishRCH05r0LyNMgdxGmxsswl6c23nP1lKT7f4HR8vnM3lfRrHAsHEBFuMVN2979RSyeQ3MaEbVZ60Bqiwhy/M80tEAyxfiCG7QtnAZ27Z2kYJ0OWIwHHGs43o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Y92FEGfp; arc=none smtp.client-ip=193.252.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id M5PouaRZyZN2yM5Ppu1QQj; Mon, 02 Jun 2025 15:41:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748871690;
	bh=bMMF5g45Q+ymyDWkhMCc1UIIIe7G4AdjzYvdgWdsS0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Y92FEGfplZ44aYZfSSWuyLDHOXK0k9gWjkBm85500jEkdVwAr7Pm2JyFZz/Lf3SK+
	 AuNJdezJbZODkkmcJpHW4bE3X5fv9dk8FbynOpVVcSDNPKjZXpOSQmz2lO9h31Wmpq
	 /WD+D1YzuTvbGLyQ0jqBRUZidiMOsdixuKtqNfIwXeoeuh9re28TQELHxWTg7Gvsvy
	 upSFENhAGmhMMF+aCrTddXQZ168IJa7ICgyHsa05PVJ1a0y72uVr7Bm7BSlKPiJOnx
	 d1/r516AQyxPKH3mTzx6CT07KGpL5O5SCh4Z81dc7fEGe5P3TUM9xJt/tSfRaDJKgT
	 zXc56/BminQMA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 02 Jun 2025 15:41:30 +0200
X-ME-IP: 124.33.176.97
Message-ID: <7df51717-ffd1-43c1-8c5a-ab181439f580@wanadoo.fr>
Date: Mon, 2 Jun 2025 22:41:23 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] can: rcar_canfd: Add support for Transceiver Delay
 Compensation
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Biju Das
 <biju.das.jz@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1748863848.git.geert+renesas@glider.be>
 <c830bd8b65d5f96c8831a2967c5b4c0eeb30e0af.1748863848.git.geert+renesas@glider.be>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
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
In-Reply-To: <c830bd8b65d5f96c8831a2967c5b4c0eeb30e0af.1748863848.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/06/2025 at 20:54, Geert Uytterhoeven wrote:
> The Renesas CAN-FD hardware block supports configuring Transceiver Delay
> Compensation, and reading back the Transceiver Delay Compensation
> Result, which is needed to support high transfer rates like 8 Mbps.
> The Secondary Sample Point is either the measured delay plus the
> configured offset, or just the configured offset.
> 
> Fix the existing RCANFD_FDCFG_TDCO() macro for the intended use case
> (writing instead of reading the field).  Add register definition bits
> for the Channel n CAN-FD Status Register.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 80 +++++++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 7b6bb67ed6f76f14..a9c5b4ac040bdc0a 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -191,9 +191,19 @@
>  /* RSCFDnCFDCmFDCFG */
>  #define RCANFD_GEN4_FDCFG_CLOE		BIT(30)
>  #define RCANFD_GEN4_FDCFG_FDOE		BIT(28)
> +#define RCANFD_FDCFG_TDCO		GENMASK(23, 16)
>  #define RCANFD_FDCFG_TDCE		BIT(9)
>  #define RCANFD_FDCFG_TDCOC		BIT(8)
> -#define RCANFD_FDCFG_TDCO(x)		(((x) & 0x7f) >> 16)
> +
> +/* RSCFDnCFDCmFDSTS */
> +#define RCANFD_FDSTS_SOC		GENMASK(31, 24)
> +#define RCANFD_FDSTS_EOC		GENMASK(23, 16)
> +#define RCANFD_GEN4_FDSTS_PNSTS		GENMASK(13, 12)
> +#define RCANFD_FDSTS_SOCO		BIT(9)
> +#define RCANFD_FDSTS_EOCO		BIT(8)
> +#define RCANFD_FDSTS_TDCR(gpriv, x)	((x) & ((gpriv)->info->tdc_const->tdcv_max - 1))
> +#define RCANFD_FDSTS_TDCVF(gpriv) \
> +	((gpriv)->info->tdc_const->tdcv_max > 128 ? BIT(15) : BIT(7))

See my previous comment: no more function like macro please.

>  /* RSCFDnCFDRFCCx */
>  #define RCANFD_RFCC_RFIM		BIT(12)
> @@ -527,6 +537,7 @@ struct rcar_canfd_shift_data {
>  struct rcar_canfd_hw_info {
>  	const struct can_bittiming_const *nom_bittiming;
>  	const struct can_bittiming_const *data_bittiming;
> +	const struct can_tdc_const *tdc_const;
>  	const struct rcar_canfd_regs *regs;
>  	const struct rcar_canfd_shift_data *sh;
>  	u8 rnc_field_width;
> @@ -634,6 +645,25 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
>  	.brp_inc = 1,
>  };
>  
> +/* CAN FD Transmission Delay Compensation constants */
> +static const struct can_tdc_const rcar_canfd_gen3_tdc_const = {
> +	.tdcv_min = 1,

Interesting. This is the first time I see a driver with the tdcv_min and the
tdco_min different than 0. At one point in time, I wanted those to be implicit
values. Guess it was finally a good idea to include those minimums to the framework.

> +	.tdcv_max = 128,
> +	.tdco_min = 1,
> +	.tdco_max = 128,
> +	.tdcf_min = 0,	/* Filter window not supported */
> +	.tdcf_max = 0,
> +};
> +
> +static const struct can_tdc_const rcar_canfd_gen4_tdc_const = {
> +	.tdcv_min = 1,
> +	.tdcv_max = 256,
> +	.tdco_min = 1,
> +	.tdco_max = 256,
> +	.tdcf_min = 0,	/* Filter window not supported */
> +	.tdcf_max = 0,
> +};
> +
>  static const struct rcar_canfd_regs rcar_gen3_regs = {
>  	.rfcc = 0x00b8,
>  	.cfcc = 0x0118,
> @@ -679,6 +709,7 @@ static const struct rcar_canfd_shift_data rcar_gen4_shift_data = {
>  static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>  	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
>  	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
> +	.tdc_const = &rcar_canfd_gen3_tdc_const,
>  	.regs = &rcar_gen3_regs,
>  	.sh = &rcar_gen3_shift_data,
>  	.rnc_field_width = 8,
> @@ -695,6 +726,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>  static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>  	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
>  	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
> +	.tdc_const = &rcar_canfd_gen4_tdc_const,
>  	.regs = &rcar_gen4_regs,
>  	.sh = &rcar_gen4_shift_data,
>  	.rnc_field_width = 16,
> @@ -711,6 +743,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>  static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
>  	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
> +	.tdc_const = &rcar_canfd_gen3_tdc_const,
>  	.regs = &rcar_gen3_regs,
>  	.sh = &rcar_gen3_shift_data,
>  	.rnc_field_width = 8,
> @@ -727,6 +760,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
>  	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
>  	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
> +	.tdc_const = &rcar_canfd_gen4_tdc_const,
>  	.regs = &rcar_gen4_regs,
>  	.sh = &rcar_gen4_shift_data,
>  	.rnc_field_width = 16,
> @@ -1436,12 +1470,15 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
>  
>  static void rcar_canfd_set_bittiming(struct net_device *ndev)
>  {
> +	u32 mask = RCANFD_FDCFG_TDCO | RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
>  	struct rcar_canfd_channel *priv = netdev_priv(ndev);
>  	struct rcar_canfd_global *gpriv = priv->gpriv;
>  	const struct can_bittiming *bt = &priv->can.bittiming;
>  	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
> +	const struct can_tdc_const *tdc_const = priv->can.fd.tdc_const;
> +	const struct can_tdc *tdc = &priv->can.fd.tdc;
> +	u32 cfg, tdcmode = 0, tdco = 0;
>  	u16 brp, sjw, tseg1, tseg2;
> -	u32 cfg;
>  	u32 ch = priv->channel;
>  
>  	/* Nominal bit timing settings */
> @@ -1477,6 +1514,22 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
>  	rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
>  	netdev_dbg(ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
>  		   brp, sjw, tseg1, tseg2);
> +
> +	/* Transceiver Delay Compensation */
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO) {
> +		/* TDC enabled, measured + offset */
> +		tdcmode = RCANFD_FDCFG_TDCE;
> +		tdco = tdc->tdco - 1;
> +		netdev_dbg(ndev, "tdc: auto %u\n", tdco);

Same as previously. Are those debugs really useful? You can get the value
through the netlink interface (OK, you still have to do the minus one by hand,
but don't tell me that's the reason).

> +	} else if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
> +		/* TDC enabled, offset only */
> +		tdcmode = RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
> +		tdco = min(tdc->tdcv + tdc->tdco, tdc_const->tdco_max) - 1;

That's an edge case I did not think of and that is thus not handled by the
framework. This min() is a bit hacky, but I do not see a better workaround.
Also, I guess that this edge case will rarely occur.

> +		netdev_dbg(ndev, "tdc: manual %u\n", tdco);
> +	}
> +
> +	rcar_canfd_update_bit(gpriv->base, RCANFD_F_CFDCFG(gpriv, ch), mask,
> +			      tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
>  }
>  
>  static int rcar_canfd_start(struct net_device *ndev)
> @@ -1787,6 +1840,22 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
>  	return num_pkts;
>  }
>  
> +static int rcar_canfd_get_auto_tdcv(const struct net_device *ndev, u32 *tdcv)
> +{
> +	struct rcar_canfd_channel *priv = netdev_priv(ndev);
> +	struct rcar_canfd_global *gpriv = priv->gpriv;
> +	u32 sts = rcar_canfd_read(priv->base, RCANFD_F_CFDSTS(gpriv, priv->channel));
> +	u32 tdco = priv->can.fd.tdc.tdco;
> +	u32 tdcr;
> +
> +	/* Transceiver Delay Compensation Result */
> +	tdcr = RCANFD_FDSTS_TDCR(gpriv, sts) + 1;
> +
> +	*tdcv = tdcr < tdco ? 0 : tdcr - tdco;
> +
> +	return 0;
> +}
> +
>  static int rcar_canfd_do_set_mode(struct net_device *ndev, enum can_mode mode)
>  {
>  	int err;
> @@ -1909,12 +1978,17 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
>  	if (gpriv->fdmode) {
>  		priv->can.bittiming_const = gpriv->info->nom_bittiming;
>  		priv->can.fd.data_bittiming_const = gpriv->info->data_bittiming;
> +		priv->can.fd.tdc_const = gpriv->info->tdc_const;
>  
>  		/* Controller starts in CAN FD only mode */
>  		err = can_set_static_ctrlmode(ndev, CAN_CTRLMODE_FD);
>  		if (err)
>  			goto fail;
> -		priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
> +
> +		priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING |
> +					       CAN_CTRLMODE_TDC_AUTO |
> +					       CAN_CTRLMODE_TDC_MANUAL;
> +		priv->can.fd.do_get_auto_tdcv = rcar_canfd_get_auto_tdcv;
>  	} else {
>  		/* Controller starts in Classical CAN only mode */
>  		priv->can.bittiming_const = &rcar_canfd_bittiming_const;

Yours sincerely,
Vincent Mailhol


