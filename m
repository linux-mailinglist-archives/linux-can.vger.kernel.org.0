Return-Path: <linux-can+bounces-3251-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ACAA74606
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 10:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED12C16925E
	for <lists+linux-can@lfdr.de>; Fri, 28 Mar 2025 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179921147B;
	Fri, 28 Mar 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="K3qNB49R"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF711D5170;
	Fri, 28 Mar 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153048; cv=none; b=WyX0EEIjeEIyYLEE8T7+q9Ujt9wKCKc+pDQwXJ2nh8U4sR8AWDlOyC18OYW9qPMXqXdOA9AwNCKgUNM7SDk1BXmAgfykk/gGFdz6o0PYKopW8YRdam/m1gRw4j+uxC86S6uR2817u35qC+bY38GdLBXuG4JQN4eyjVYcjtwvWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153048; c=relaxed/simple;
	bh=aJFtBn/W9nwQlQkzaoGg0TwPw2wKIrEvlBLp7hU5rls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGVYg+qftIlg+aRcrqyaE/HBFScClPDjTGFFfPd0RQ5/OJHBM/tiTmCUIuwH/dWaanxORgZy1ALx0rhGIKOjbt8/nWFNewwX3XzUZk1PYicbG8Jv/wN3S9CXZp2+CTlxyf1YnnpkVJ1p/Wh2a+sO9HRSaVQktTk6pEWoeuodffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=K3qNB49R; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id y5jNt9f8pyvSyy5jStZJHx; Fri, 28 Mar 2025 10:10:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743153033;
	bh=/ogY/TXxLRS2IQLKGXJZ48BTCxT4SkIk7Rb1cxc54f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=K3qNB49RiSPLmqJB8JyB0bXxXyQAI/mLnSWNx8WdOCIskQfSZXtqHLDhX2/lWL69N
	 Jn/ZbjChus6ymToW9H73jayMTsidRn1fqLvsyfcFpE97tMwapUMBkEfLEWOvhGmgsI
	 Vx4bEQJw7GjRvXsHtzv/P84fTqhfb683GCh+kIcCtVMB39qHP+vgHBG3SPrv+Ruqhs
	 tg1wNs+XsEu2Pz4pYO6L0JGLEvkJxeU1YXduRq5//QleuEK9qTu590FwMZofo2GJWI
	 wfN60qUU+JtEnH60KIvnjbnLdriiSg3WDyww9tqR1nh+epY5IVAFboTDhYeqxh0CH7
	 wGhcwh8irCDRg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Mar 2025 10:10:33 +0100
X-ME-IP: 124.33.176.97
Message-ID: <40392a70-3be4-4d11-8614-eebd5d9d24a8@wanadoo.fr>
Date: Fri, 28 Mar 2025 18:10:25 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros
 in RCANFD_GERFL_ERR
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-can@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
 <20250326122003.122976-6-biju.das.jz@bp.renesas.com>
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
In-Reply-To: <20250326122003.122976-6-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/03/2025 à 21:19, Biju Das wrote:
> The macros RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by
> gpriv->channels_mask << 16.
> 
> After this drop the macro RCANFD_GERFL_EEF0_7 as it is unused.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v6->v7:
>  * No change.
> v5->v6:
>  * Collected tag.
> v5:
>  * New patch.
> ---
>  drivers/net/can/rcar/rcar_canfd.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 565a91c2ca83..a9e962a1510e 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -74,7 +74,6 @@
>  #define RCANFD_GSTS_GNOPM		(BIT(0) | BIT(1) | BIT(2) | BIT(3))
>  
>  /* RSCFDnCFDGERFL / RSCFDnGERFL */
> -#define RCANFD_GERFL_EEF0_7		GENMASK(23, 16)
>  #define RCANFD_GERFL_EEF(ch)		BIT(16 + (ch))
>  #define RCANFD_GERFL_CMPOF		BIT(3)	/* CAN FD only */
>  #define RCANFD_GERFL_THLES		BIT(2)
> @@ -82,9 +81,7 @@
>  #define RCANFD_GERFL_DEF		BIT(0)
>  
>  #define RCANFD_GERFL_ERR(gpriv, x) \
> -	((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
> -			 RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
> -		RCANFD_GERFL_MES | \
> +	((x) & ((gpriv->channels_mask << 16) | RCANFD_GERFL_MES | \

The previous RCANFD_GERFL_EEF0_7 macro documented that the register was
from bit index 16 to bit index 23. Here, we loose this piece of information.

What about:

	FIELD_PREP(RCANFD_GERFL_EEF0_7, gpriv->channels_mask)

?


Yours sincerely,
Vincent Mailhol


