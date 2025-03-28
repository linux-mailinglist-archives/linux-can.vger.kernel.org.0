Return-Path: <linux-can+bounces-3280-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5ABA74C54
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 15:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4D31887F95
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF781C5D79;
	Fri, 28 Mar 2025 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="nOvP62wm"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653001BDAA0;
	Fri, 28 Mar 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171556; cv=none; b=XjT1btxj+BfvLfBpz2mbKzBCft4ZHVl/c6Lzl04JrMuZtyM9FzINEq4kDpJeNsDwAOddf73kTURyhfrwjPKfKE9F2I+Q899yG3NYyRZgSg2k8+OLjAlftEEI5TtNRy/din6cQ8D4AneFw/FBFvD9ll2SqoEy50ESjDXAjt2kALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171556; c=relaxed/simple;
	bh=/2gzlGTMeTcyXlWYxj938SoC8uBgbmqPjay4fmGgQhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFd2N9tcnDn1oSEMpAIpzPl5YByAKV9jwBmxky6hPnINwuCbcCUiqg/MHkeYWx5o64fdSjziLbf8lHyhwcF/E+UTB9HUYsaaP3Yzt/s5AVsSyB0Ff6rd7vbq3TS3J4rUG/qaMKVPktaxCSA3ik/aVuLvVOS4og2Jvfps47TYDgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=nOvP62wm; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id yAY3teqtMVyltyAY7taaT4; Fri, 28 Mar 2025 15:19:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743171551;
	bh=n1NdEMzqSvi5FwHMEhzbaySmh09oT0jKAh2Z6epovok=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=nOvP62wmgLNHiIEhNhjP7QBTipJfHRgfchjmDkYcSdrun9hJvn9OQQAK3zKPDbDVf
	 WVzCI+PxZqbxxQUta9wqqDGRUmIJ5CqXj30BmI+4q0gesDeBNoNhRc4OLz1kWzwUk0
	 To9LxGjP+xrJfJdNQ+d1Pk76tMtv1UAKxFj6nIRxJnWJYpRRozZo5O4TGOORgAtZ7Z
	 fMeDy4WjPxDvlDyPrhBbMpN76SUFtBIiSQrznab5wLr5GHyiSQ7oUCXOHgF/itqvHG
	 wK9l5cs3srDvQXY8E56PHljaOVdy2Knyefpbwk8EDnJK3th0JqUGn6Z/fZg9wYdzoQ
	 V8p0Y6bn8YElA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 15:19:11 +0100
X-ME-IP: 124.33.176.97
Message-ID: <014afe2e-768a-45ad-9e43-f2fd6a003663@wanadoo.fr>
Date: Fri, 28 Mar 2025 23:19:03 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/18] can: rcar_canfd: Add register mapping table to
 struct rcar_canfd_hw_info
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-15-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-15-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2025 at 21:19, Biju Das wrote:
> R-Car Gen3 and Gen4 have some differences in the register offsets. Add a
> mapping table to handle these differences.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v6->v7:
>  * No change.
> v5->v6:
>  * No change.
> v4->v5:
>  * Improved commit description by replacing has->have.
>  * Collected tag.
> v3->v4:
>  * Added prefix RCANFD_* to enum rcar_canfd_reg_offset_id.
> v3:
>  * New patch.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 48 ++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 360999e6ab45..a96cf499f04b 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -298,7 +298,7 @@
>  #define RCANFD_RMND(y)			(0x00a8 + (0x04 * (y)))
>  
>  /* RSCFDnCFDRFCCx / RSCFDnRFCCx */
> -#define RCANFD_RFCC(gpriv, x)		(reg_gen4(gpriv, 0x00c0, 0x00b8) + (0x04 * (x)))
> +#define RCANFD_RFCC(gpriv, x)		((gpriv)->info->regs[RCANFD_RFCC] + (0x04 * (x)))
>  /* RSCFDnCFDRFSTSx / RSCFDnRFSTSx */
>  #define RCANFD_RFSTS(gpriv, x)		(RCANFD_RFCC(gpriv, x) + 0x20)
>  /* RSCFDnCFDRFPCTRx / RSCFDnRFPCTRx */
> @@ -308,13 +308,13 @@
>  
>  /* RSCFDnCFDCFCCx / RSCFDnCFCCx */
>  #define RCANFD_CFCC(gpriv, ch, idx) \
> -	(reg_gen4(gpriv, 0x0120, 0x0118) + (0x0c * (ch)) + (0x04 * (idx)))
> +	((gpriv)->info->regs[RCANFD_CFCC] + (0x0c * (ch)) + (0x04 * (idx)))
>  /* RSCFDnCFDCFSTSx / RSCFDnCFSTSx */
>  #define RCANFD_CFSTS(gpriv, ch, idx) \
> -	(reg_gen4(gpriv, 0x01e0, 0x0178) + (0x0c * (ch)) + (0x04 * (idx)))
> +	((gpriv)->info->regs[RCANFD_CFSTS] + (0x0c * (ch)) + (0x04 * (idx)))
>  /* RSCFDnCFDCFPCTRx / RSCFDnCFPCTRx */
>  #define RCANFD_CFPCTR(gpriv, ch, idx) \
> -	(reg_gen4(gpriv, 0x0240, 0x01d8) + (0x0c * (ch)) + (0x04 * (idx)))
> +	((gpriv)->info->regs[RCANFD_CFPCTR] + (0x0c * (ch)) + (0x04 * (idx)))
>  
>  /* RSCFDnCFDFESTS / RSCFDnFESTS */
>  #define RCANFD_FESTS			(0x0238)
> @@ -430,7 +430,7 @@
>  /* CAN FD mode specific register map */
>  
>  /* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
> -#define RCANFD_F_DCFG(gpriv, m)		(reg_gen4(gpriv, 0x1400, 0x0500) + (0x20 * (m)))
> +#define RCANFD_F_DCFG(gpriv, m)		((gpriv)->info->regs[RCANFD_F_DCFG] + (0x20 * (m)))
>  #define RCANFD_F_CFDCFG(m)		(0x0504 + (0x20 * (m)))
>  #define RCANFD_F_CFDCTR(m)		(0x0508 + (0x20 * (m)))
>  #define RCANFD_F_CFDSTS(m)		(0x050c + (0x20 * (m)))
> @@ -446,7 +446,7 @@
>  #define RCANFD_F_RMDF(q, b)		(0x200c + (0x04 * (b)) + (0x20 * (q)))
>  
>  /* RSCFDnCFDRFXXx -> RCANFD_F_RFXX(x) */
> -#define RCANFD_F_RFOFFSET(gpriv)	reg_gen4(gpriv, 0x6000, 0x3000)
> +#define RCANFD_F_RFOFFSET(gpriv)	((gpriv)->info->regs[RCANFD_RFOFFSET])
>  #define RCANFD_F_RFID(gpriv, x)		(RCANFD_F_RFOFFSET(gpriv) + (0x80 * (x)))
>  #define RCANFD_F_RFPTR(gpriv, x)	(RCANFD_F_RFOFFSET(gpriv) + 0x04 + (0x80 * (x)))
>  #define RCANFD_F_RFFDSTS(gpriv, x)	(RCANFD_F_RFOFFSET(gpriv) + 0x08 + (0x80 * (x)))
> @@ -454,7 +454,7 @@
>  	(RCANFD_F_RFOFFSET(gpriv) + 0x0c + (0x80 * (x)) + (0x04 * (df)))
>  
>  /* RSCFDnCFDCFXXk -> RCANFD_F_CFXX(ch, k) */
> -#define RCANFD_F_CFOFFSET(gpriv)	reg_gen4(gpriv, 0x6400, 0x3400)
> +#define RCANFD_F_CFOFFSET(gpriv)	((gpriv)->info->regs[RCANFD_CFOFFSET])
>  
>  #define RCANFD_F_CFID(gpriv, ch, idx) \
>  	(RCANFD_F_CFOFFSET(gpriv) + (0x180 * (ch)) + (0x80 * (idx)))
> @@ -501,11 +501,22 @@
>   */
>  #define RCANFD_CFFIFO_IDX		0
>  
> +enum rcar_canfd_reg_offset_id {
> +	RCANFD_RFCC,		/* RX FIFO Configuration/Control Register */
> +	RCANFD_CFCC,		/* Common FIFO Configuration/Control Register */
> +	RCANFD_CFSTS,		/* Common FIFO Status Register */
> +	RCANFD_CFPCTR,		/* Common FIFO Pointer Control Register */
> +	RCANFD_F_DCFG,		/* Global FD Configuration Register */
> +	RCANFD_RFOFFSET,	/* Receive FIFO buffer access ID register */
> +	RCANFD_CFOFFSET,	/* Transmit/receive FIFO buffer access ID register */
> +};
> +
>  struct rcar_canfd_global;
>  
>  struct rcar_canfd_hw_info {
>  	const struct can_bittiming_const *nom_bittiming;
>  	const struct can_bittiming_const *data_bittiming;
> +	const u16 *regs;
>  	u16 num_supported_rules;
>  	u8 rnc_stride;
>  	u8 rnc_field_width;
> @@ -612,9 +623,30 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
>  	.brp_inc = 1,
>  };
>  
> +static const u16 rcar_gen3_regs[] = {
> +	[RCANFD_RFCC] = 0x00b8,
> +	[RCANFD_CFCC] = 0x0118,
> +	[RCANFD_CFSTS] = 0x0178,
> +	[RCANFD_CFPCTR] = 0x01d8,
> +	[RCANFD_F_DCFG] = 0x0500,
> +	[RCANFD_RFOFFSET] = 0x3000,
> +	[RCANFD_CFOFFSET] = 0x3400,
> +};
> +
> +static const u16 rcar_gen4_regs[] = {
> +	[RCANFD_RFCC] = 0x00c0,
> +	[RCANFD_CFCC] = 0x0120,
> +	[RCANFD_CFSTS] = 0x01e0,
> +	[RCANFD_CFPCTR] = 0x0240,
> +	[RCANFD_F_DCFG] = 0x1400,
> +	[RCANFD_RFOFFSET] = 0x6000,
> +	[RCANFD_CFOFFSET] = 0x6400,
> +};

The mapping is convinient when you want to iterate throught it. Here, if
you just want to access the offset value from its name, a structure
looks more appropriate. This way:

  gpriv->info->regs[RCANFD_RFOFFSET]

becomes:

  gpriv->info->rfoffset

and so on.

Internally, it is the same layout, but no need for the enum anymore.

Note that you can either inline those values in struct
rcar_canfd_hw_info or have a separate struct rcar_regs, as you prefer!

>  static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>  	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
>  	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
> +	.regs = rcar_gen3_regs,
>  	.num_supported_rules = 256,
>  	.rnc_stride = 4,
>  	.rnc_field_width = 8,
> @@ -628,6 +660,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
>  static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>  	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
>  	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
> +	.regs = rcar_gen4_regs,
>  	.num_supported_rules = 512,
>  	.rnc_stride = 2,
>  	.rnc_field_width = 16,
> @@ -643,6 +676,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>  static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>  	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
>  	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
> +	.regs = rcar_gen3_regs,
>  	.num_supported_rules = 256,
>  	.rnc_stride = 4,
>  	.rnc_field_width = 8,

Yours sincerely,
Vincent Mailhol


