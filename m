Return-Path: <linux-can+bounces-3754-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ACFACAEC3
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 15:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CBF189F7AD
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5981EFF8B;
	Mon,  2 Jun 2025 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="a1KWAcUK"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316D1401B;
	Mon,  2 Jun 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870291; cv=none; b=rYtSjYfre3JAxo/uq2KC6RbZC+2FV5veOTVaV+Y1KsmZvstqqU6+0H9yV6EHOx0RCiTHaxrapx+ImuzQnImM7KPghYK5LrN0rZizu5iUhgdaA4GI/xRj47zDVdnC9SxMHRqMCtqvJ+esBB01N2X+Lsxmsz2qzUMpnP5AiyDp1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870291; c=relaxed/simple;
	bh=6xVA49aPgN6bhbJktQ3Qgjr9p8G9muEybUCZeHcQbNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXZ180tuFeqTziAMNiYR4Mgy0Js1LwrgLAN1aVvLp33KWLvyT0jgxuOVSx86SA+2tVh44CIbKSw0htZ+TQleWwMmOu1v9vQbetDSU0NpH9ax6kivIHZ6s59VN2jyO4wsxDeS8JQNJVZcr2P/vndm9dGIbHe4RdoCJ9c0qPg4qAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=a1KWAcUK; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id M521u14DOVLIhM522ucJLC; Mon, 02 Jun 2025 15:16:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748870214;
	bh=+Hp49TL4jJ0TyfDOF/OoCiTSO7M0syn25/3UQuLLFp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=a1KWAcUKH1l0PbRXo58Mv3/17TgcBZqYa9GBOyV42enwCYSSMRlb5y0XfSLln9Ttg
	 WmQRjsHTNx5wd3D4fC7m9oW4FBPUyeUibCkIaGKDPR2EO6AQ6WhAwZMTDPe4DWwRgj
	 tUSGb9QO8RaNPr/spr5hw8Nfn02Mj/X3Po7qsXTflYa/ZRubTKiNzhf66pNXk2xQS/
	 XQcCujjjrQptjsombgWD7D8MNnjXXIL0OGACoEzF+IqR7We7NYhOVCPc1TcdzS9Cy/
	 I4qZ1OnaZ7Nl5q8+RCm9LpbLD24jn0MOUaHcgnZa+e0ZFGh04IdObzA1PHD4FtawGl
	 t892i0sdC5d5A==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 02 Jun 2025 15:16:54 +0200
X-ME-IP: 124.33.176.97
Message-ID: <94755286-47fb-461e-9850-e14830f2536e@wanadoo.fr>
Date: Mon, 2 Jun 2025 22:16:48 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] can: rcar_canfd: Repurpose f_dcfg base for other
 registers
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Biju Das
 <biju.das.jz@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1748863848.git.geert+renesas@glider.be>
 <f9c114fcf8cc8eaae150a3ce95dd3224cf247f6b.1748863848.git.geert+renesas@glider.be>
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
In-Reply-To: <f9c114fcf8cc8eaae150a3ce95dd3224cf247f6b.1748863848.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/06/2025 at 20:54, Geert Uytterhoeven wrote:
> Reuse the existing Channel Data Bitrate Configuration Register offset
> member in the register configuration as the base offset for all related
> channel-specific registers.
> Rename the member and update the (incorrect) comment to reflect this.
> 
> This fixes the addresses of all other (currently unused)
> channel-specific registers on R-Car Gen4 and RZ/G3E, and allows us to
> replace RCANFD_GEN4_FDCFG() by the more generic RCANFD_F_CFDCFG().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 0cad3c198e58e494..7a9a88fa5fb1a521 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -425,18 +425,16 @@
>  #define RCANFD_C_RPGACC(r)		(0x1900 + (0x04 * (r)))
>  
>  /* R-Car Gen4 Classical and CAN FD mode specific register map */
> -#define RCANFD_GEN4_FDCFG(m)		(0x1404 + (0x20 * (m)))
> -
>  #define RCANFD_GEN4_GAFL_OFFSET		(0x1800)
>  
>  /* CAN FD mode specific register map */
>  
>  /* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
> -#define RCANFD_F_DCFG(gpriv, m)		((gpriv)->info->regs->f_dcfg + (0x20 * (m)))
> -#define RCANFD_F_CFDCFG(m)		(0x0504 + (0x20 * (m)))
> -#define RCANFD_F_CFDCTR(m)		(0x0508 + (0x20 * (m)))
> -#define RCANFD_F_CFDSTS(m)		(0x050c + (0x20 * (m)))
> -#define RCANFD_F_CFDCRC(m)		(0x0510 + (0x20 * (m)))
> +#define RCANFD_F_DCFG(gpriv, m)		((gpriv)->info->regs->coffset + 0x00 + (0x20 * (m)))
> +#define RCANFD_F_CFDCFG(gpriv, m)	((gpriv)->info->regs->coffset + 0x04 + (0x20 * (m)))
> +#define RCANFD_F_CFDCTR(gpriv, m)	((gpriv)->info->regs->coffset + 0x08 + (0x20 * (m)))
> +#define RCANFD_F_CFDSTS(gpriv, m)	((gpriv)->info->regs->coffset + 0x0c + (0x20 * (m)))
> +#define RCANFD_F_CFDCRC(gpriv, m)	((gpriv)->info->regs->coffset + 0x10 + (0x20 * (m)))

I really start to dislike all those function like macros in the rcar_canfd
driver. The only benefits of a function like macro is either to have type
polymorphism or to generate integer constant expression or to work with context
specific info (e.g. __func__ or __LINE__).

Can you just change these five function like macros to static functions?

And from now on, each time there is a need to modify one of the rcar_canfd, I
would like this to become an opportunity to little by little clean up that macro
madness.

>  /* RSCFDnCFDGAFLXXXj offset */
>  #define RCANFD_F_GAFL_OFFSET		(0x1000)
> @@ -510,7 +508,7 @@ struct rcar_canfd_regs {
>  	u16 cfcc;	/* Common FIFO Configuration/Control Register */
>  	u16 cfsts;	/* Common FIFO Status Register */
>  	u16 cfpctr;	/* Common FIFO Pointer Control Register */
> -	u16 f_dcfg;	/* Global FD Configuration Register */
> +	u16 coffset;	/* Channel Data Bitrate Configuration Register */
>  	u16 rfoffset;	/* Receive FIFO buffer access ID register */
>  	u16 cfoffset;	/* Transmit/receive FIFO buffer access ID register */
>  };
> @@ -641,7 +639,7 @@ static const struct rcar_canfd_regs rcar_gen3_regs = {
>  	.cfcc = 0x0118,
>  	.cfsts = 0x0178,
>  	.cfpctr = 0x01d8,
> -	.f_dcfg = 0x0500,
> +	.coffset = 0x0500,
>  	.rfoffset = 0x3000,
>  	.cfoffset = 0x3400,
>  };
> @@ -651,7 +649,7 @@ static const struct rcar_canfd_regs rcar_gen4_regs = {
>  	.cfcc = 0x0120,
>  	.cfsts = 0x01e0,
>  	.cfpctr = 0x0240,
> -	.f_dcfg = 0x1400,
> +	.coffset = 0x1400,
>  	.rfoffset = 0x6000,
>  	.cfoffset = 0x6400,
>  };
> @@ -827,8 +825,8 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
>  
>  		for_each_set_bit(ch, &gpriv->channels_mask,
>  				 gpriv->info->max_channels)
> -			rcar_canfd_set_bit(gpriv->base, RCANFD_GEN4_FDCFG(ch),
> -					   val);
> +			rcar_canfd_set_bit(gpriv->base,
> +					   RCANFD_F_CFDCFG(gpriv, ch), val);
>  	} else {
>  		if (gpriv->fdmode)
>  			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,

Yours sincerely,
Vincent Mailhol


