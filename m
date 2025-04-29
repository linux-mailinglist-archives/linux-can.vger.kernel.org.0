Return-Path: <linux-can+bounces-3501-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78DCAA01E0
	for <lists+linux-can@lfdr.de>; Tue, 29 Apr 2025 07:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CA31A844A5
	for <lists+linux-can@lfdr.de>; Tue, 29 Apr 2025 05:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32024212D7C;
	Tue, 29 Apr 2025 05:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="T9hq1KA0"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6991DDA09
	for <linux-can@vger.kernel.org>; Tue, 29 Apr 2025 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745905076; cv=none; b=OR9GIe0Lnxl2aCylmnEv6prztscq4GX9owNjdPc7NvDYGnPfnb+UFkF4T3Mgb0nHKGbtEgID8lwwIdQT3x6gRsU1zBJk+x9+uvR4/lwJww5mNHfI6/XFUVu6r7N1fQ6mc0bF2VnNUtjQnEvzta2TCe8dS38RTaMVrd9fzUgXBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745905076; c=relaxed/simple;
	bh=B8WyxCDMV5x2ORAoSXLCEjT34lfczY63IFdmZJiBgww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caXivAQCCYhaSd/dGcOjsGX99rzghFpcaovl49luaL4NtQh1Z9iBTniu1D55G3rD8YyryW3Cdy5mIgivyv+UW1b3xmTOk3TvT59ZsjYPXyVuLT204IQKhrk6IeVM3C02dZi5GfQ+f/HG4Y8MkiNuKBcZBrY61gyQBIbB4XsihdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=T9hq1KA0; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 9df0uHBPTTWi89df4uT2os; Tue, 29 Apr 2025 07:37:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745905064;
	bh=rJ01QcA2oSAovK2h3mBtEWwIdiAmXNHuEGEuwyJRoQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=T9hq1KA0AEc2sM+Otkt4CiifxRm+EfW6bZTlholKBnk6Bk5vRfUFy1kr5jsHDZyDV
	 0Fq5Izo6h2fGBDzpBI2OFnuO6UCdEXZ3xsGt0+4seMmW5p58SZoXxPNnoEW3oYOE6+
	 SGTfrh6oH9pXDcHWd5JdL31iC4SzP3QfLNB+XjXLwbznQ7W2kqfQ085vVQapjX2FJr
	 4tKlhpfMbOVWKLohBNT2+nZMJEDJU3NHKcKDz3c6ZoepEcG657yGTHQvSMlHL2MqTb
	 WmL+OFFIP+EtkA25rthBWOHdOCVuYbvWAb1Pc0WMLqNAOkFDp71Eqzy9e7TKzw4ttu
	 w2NIIApu/1CTQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 29 Apr 2025 07:37:44 +0200
X-ME-IP: 124.33.176.97
Message-ID: <388e98aa-d923-4bb9-af44-d1bdd0d1c729@wanadoo.fr>
Date: Tue, 29 Apr 2025 14:37:37 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] can: mcp251xfd: fix TDC setting for low data bit rates
To: Kelsey Maes <kelsey@vpprocess.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20250428171501.75830-1-kelsey@vpprocess.com>
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
In-Reply-To: <20250428171501.75830-1-kelsey@vpprocess.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kelsey,

The tdco logic seems inverted. While at it, I also added a suggestion to add
TDCV support.

On 29/04/2025 at 02:15, Kelsey Maes wrote:
> The TDC is currently hardcoded enabled. This means that even for lower CAN-FD
> data bitrates (with a DBRP (data bitrate prescaler) > 2) a TDC is configured.
> This leads to a bus-off condition.
> 
> ISO 11898-1 section 11.3.3 says "Transmitter delay compensation" (TDC) is only
> applicable if DBRP is 1 or 2.
> 
> To fix the problem, switch the driver to use the TDC calculation provided by the
> CAN driver framework (which respects ISO 11898-1 section 11.3.3). This has the
> positive side effect that userspace can control TDC as needed.
> 
> Demonstration of the feature in action:
>   $ ip link set can0 up type can bitrate 125000 dbitrate 500000 fd on
>   $ ip -details link show can0
>   3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
>       link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
>       can <FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>   	  bitrate 125000 sample-point 0.875
>   	  tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 2
>   	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
>   	  dbitrate 500000 dsample-point 0.875
>   	  dtq 125 dprop-seg 6 dphase-seg1 7 dphase-seg2 2 dsjw 1 dbrp 5
>   	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
>   	  tdco 0..63
>   	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0
>   $ ip link set can0 up type can bitrate 1000000 dbitrate 4000000 fd on
>   $ ip -details link show can0
>   3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
>       link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
>       can <FD,TDC-AUTO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>   	  bitrate 1000000 sample-point 0.750
>   	  tq 25 prop-seg 14 phase-seg1 15 phase-seg2 10 sjw 5 brp 1
>   	  mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
>   	  dbitrate 4000000 dsample-point 0.700
>   	  dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1 dbrp 1
>   	  tdco 7
>   	  mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
>   	  tdco 0..63
>   	  clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0
> 
> There has been some confusion about the MCP2518FD using a relative or absolute
> TDCO due to the datasheet specifying a range of [-64,63]. I have a custom board
> with a 40 MHz clock and an estimated loop delay of 100 to 216 ns. During testing
> at a data bit rate of 4 Mbit/s I found that using can_get_relative_tdco()
> resulted in bus-off errors. The final TDCO value was 1 which corresponds to a
> 10% SSP in an absolute configuration. This behavior is expected if the TDCO
> value is really absolute and not relative. Using priv->can.tdc.tdco instead
> results in a final TDCO of 8, setting the SSP at exactly 80%. This configuration
> works.
> 
> Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxFD SPI CAN")
> Reported-by: Kelsey Maes <kelsey@vpprocess.com>
> Closes: https://lore.kernel.org/all/C2121586-C87F-4B23-A933-845362C29CA1@vpprocess.com
> Signed-off-by: Kelsey Maes <kelsey@vpprocess.com>> ---
>  .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 25 +++++++++++++------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 3bc56517f..d2184a32d 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -75,6 +75,15 @@ static const struct can_bittiming_const mcp251xfd_data_bittiming_const = {
>  	.brp_inc = 1,
>  };
>  
> +static const struct can_tdc_const mcp251xfd_tdc_const = {
> +	.tdcv_min = 0,
> +	.tdcv_max = 63,

I missed this in my previous review, sorry.

Does the mcp251xfd support the manual TDC? Unless you add the
CAN_CTRLMODE_TDC_MANUAL flag, the TDCV value is simply ignored, c.f.

  https://elixir.bootlin.com/linux/v6.14/source/include/linux/can/bittiming.h#L92

All the macro are already there:


https://elixir.bootlin.com/linux/v6.14/source/drivers/net/can/spi/mcp251xfd/mcp251xfd.h#L76

So that shouldn't be hard. Can you test this in mcp251xfd_set_bittiming()?

  u32 tdcmod, val;

  /* ... */

  /* Transmitter Delay Compensation */
  if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO)
  	tdcmod = MCP251XFD_REG_TDC_TDCMOD_AUTO;
  else if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_MANUAL)
  	tdcmod = MCP251XFD_REG_TDC_TDCMOD_MANUAL;
  else
  	tdcmod = MCP251XFD_REG_TDC_TDCMOD_DISABLED;

  val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK, tdcmod) |
  	FIELD_PREP(MCP251XFD_REG_TDC_TDCV_MASK, priv->can.tdc.tdcv) |
  	FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);

  return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);

(and yes, in my previous message, I said that it is better to move the tdco's
FIELD_PREP inside the if, but this only applies for a simple if/else, if we have
three branches, the above looks better).

> +	.tdco_min = 0,
> +	.tdco_max = 63,
> +	.tdcf_min = 0,
> +	.tdcf_max = 0,
> +};
> +
>  static const char *__mcp251xfd_get_model_str(enum mcp251xfd_model model)
>  {
>  	switch (model) {
> @@ -511,7 +520,6 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
>  	const struct can_bittiming *bt = &priv->can.bittiming;
>  	const struct can_bittiming *dbt = &priv->can.data_bittiming;
>  	u32 val = 0;
> -	s8 tdco;
>  	int err;
>  
>  	/* CAN Control Register
> @@ -575,11 +583,13 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
>  		return err;
>  
>  	/* Transmitter Delay Compensation */
> -	tdco = clamp_t(int, dbt->brp * (dbt->prop_seg + dbt->phase_seg1),
> -		       -64, 63);
> -	val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
> -			 MCP251XFD_REG_TDC_TDCMOD_AUTO) |
> -		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
> +	if (can_tdc_is_enabled(&priv->can))
> +		val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
> +				 MCP251XFD_REG_TDC_TDCMOD_AUTO);
> +	else
> +		val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
> +				 MCP251XFD_REG_TDC_TDCMOD_DISABLED) |
> +			FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);

Shouldn't this have been the opposite?

  if (can_tdc_is_enabled(&priv->can))
  	val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
  			 MCP251XFD_REG_TDC_TDCMOD_AUTO) |
  		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);
  else
  	val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
  			 MCP251XFD_REG_TDC_TDCMOD_DISABLED);

Did you reconfirm that the device works well with high bitrates (e.g. 5 Mbps)
with no bus off conditions after the change?

>  	return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
>  }
> @@ -2083,10 +2093,11 @@ static int mcp251xfd_probe(struct spi_device *spi)
>  	priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
>  	priv->can.bittiming_const = &mcp251xfd_bittiming_const;
>  	priv->can.data_bittiming_const = &mcp251xfd_data_bittiming_const;
> +	priv->can.tdc_const = &mcp251xfd_tdc_const;
>  	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>  		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
>  		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
> -		CAN_CTRLMODE_CC_LEN8_DLC;
> +		CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO;
>  	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
>  	priv->ndev = ndev;
>  	priv->spi = spi;


Yours sincerely,
Vincent Mailhol


