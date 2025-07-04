Return-Path: <linux-can+bounces-3946-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42718AF858E
	for <lists+linux-can@lfdr.de>; Fri,  4 Jul 2025 04:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95C93B63E7
	for <lists+linux-can@lfdr.de>; Fri,  4 Jul 2025 02:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6D01D86DC;
	Fri,  4 Jul 2025 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eOJ3olbo"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722F262A6;
	Fri,  4 Jul 2025 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751595972; cv=none; b=p/X8b3xW05POl3Anjo3p0GSa+w9O8Bi1FRJU3kgt/tPc74DXyMIvRCGBgtnRvAzYr/tjbFby8ThpOR3bg6npYsLzrF3Erkvgio9XG1c1xsE/M9PvWPNzQHEkRcH6IHcjs8QsVqv3eIpWkD2HALY/Hi7TcfhJ3J5dLJ7eawhW5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751595972; c=relaxed/simple;
	bh=iPm5Ofn8MRGPd8y0n+5MUJ9kYHfvaz5TIzctrIo/Jes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPkkX76+lv+JL2CbzVDBuS39zYN863dsf+8iV7aEpixWV7VYKuCJVpnqt3RR57nNeMM7AvgRtJnsDbi5yQx6yAkFBlkT5u8ISC6r2Rbu/IuxjneOSgLmbP3DQZEIhM7QI5KxpOxpxQksszG7ZmnQfgEZ6XPZIl6yllmsbuTVTog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eOJ3olbo; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id XW6cuC2lby0xoXW6du2g4p; Fri, 04 Jul 2025 04:24:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1751595896;
	bh=hwT/0WA5UQJcEXIk+bnpVULAHVu9hoVPiRAeyJ+99ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=eOJ3olboslrS95tWL1l2W7Eeng2bAyyJxdSTWROxn06eBuiTqoOCa9pD1vXAU1JBM
	 pZrCvlGlOn8MTQnqseEVzEivP94ZE8D9r08euIT6qF/s0UUZKuCVEf7kWtlKNuZfY2
	 v0DoEw2HnUyjCi6EsXohRlobOYls9QYI4hMSw34rpmKKCXFcp0I0qZsSTV2SGTqonr
	 geyxGC+DwOlX2y223qvbQoWkKCvHSX/AfMb7hmVm1RIwR3NDM3llllc06cIYzoYIa5
	 +in3zGzRqmyopx3bcOoe3/+n6/QvhnimVIBT2pt5dK3TgZxcRVs2eCknW8kWb8BE3n
	 RDmT3YhGhYBrw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 04 Jul 2025 04:24:56 +0200
X-ME-IP: 124.33.176.97
Message-ID: <dc6d1cdf-0c93-4d7a-b3c4-722d1e58f5cf@wanadoo.fr>
Date: Fri, 4 Jul 2025 11:24:49 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] can: rcar_canfd: Replace RCANFD_CFG_* macros with
 FIELD_PREP
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
References: <20250703183411.332828-1-biju.das.jz@bp.renesas.com>
 <20250703183411.332828-5-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250703183411.332828-5-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Biju,

On 04/07/2025 at 03:34, Biju Das wrote:
> Replace RCANFD_CFG_* macros with simpler FIELD_PREP macro.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index b5b059e83374..dd87b4e8e688 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -102,12 +102,6 @@
>  
>  /* Channel register bits */
>  
> -/* RSCFDnCmCFG - Classical CAN only */
> -#define RCANFD_CFG_SJW(x)		(((x) & 0x3) << 24)
> -#define RCANFD_CFG_TSEG2(x)		(((x) & 0x7) << 20)
> -#define RCANFD_CFG_TSEG1(x)		(((x) & 0xf) << 16)
> -#define RCANFD_CFG_BRP(x)		(((x) & 0x3ff) << 0)
> -
>  /* RSCFDnCFDCmCTR / RSCFDnCmCTR */
>  #define RCANFD_CCTR_CTME		BIT(24)
>  #define RCANFD_CCTR_ERRD		BIT(23)
> @@ -1418,8 +1412,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
>  	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
>  		cfg = rcar_canfd_compute_nominal_bit_rate_cfg(gpriv->info, tseg1, brp, sjw, tseg2);
>  	} else {
> -		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
> -		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
> +		cfg = FIELD_PREP(GENMASK(19, 16), tseg1) | FIELD_PREP(GENMASK(9, 0), brp) |
> +		      FIELD_PREP(GENMASK(25, 24), sjw) | FIELD_PREP(GENMASK(22, 20), tseg2);
>  	}

You can still keep the macro definition to give a meaning to the magic number:

  #define RCANFD_CFG_SJW_MASK GENMASK(25, 24)

and do a:

  FIELD_PREP(RCANFD_CFG_SJW_MASK, sjw)

(same for the other fields).

>  	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);


Yours sincerely,
Vincent Mailhol


