Return-Path: <linux-can+bounces-3753-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA809ACAE7A
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 15:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A191BA0AA8
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E79020F066;
	Mon,  2 Jun 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="T2kEEHuV"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-73.smtpout.orange.fr [193.252.22.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E226619049B;
	Mon,  2 Jun 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748869366; cv=none; b=p3c4cugpR3XfcL0cFbHptUZm6UUtjnBhgn0B+uSOZ4M6osT3qgUga4aqDDjjk6ue2h6KJg9Idp09RZvsLl6hVMY0V9AkCtXK3ZcDUGDTgjLoK1a+/HKwR9FwBZ43Z+Uu+ph7Pc4JqPDEaWPHrEBiHQKJQqxMEeZ0b53x609u4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748869366; c=relaxed/simple;
	bh=cU8USTqkBSFoKA9f8WFdyWC6Qqhj9/RbvON8idYUL68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7CZ1MDXu8PeORftxHUPv77gff6sHPUIISj5bCHGZ+z2/B5VuPv0Z2Lqm1sBZv2jkVf0MWyJOqRVYZ6PmVI/NJraD0nLayNBVky6W3wGIpx7xTXb8iCoc6CYSGPHLhuL0srZGM63Gza6cCf9iRmuWSHCktGFnK/Q8b4UwupHT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=T2kEEHuV; arc=none smtp.client-ip=193.252.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id M4n8u8Zdb411zM4n9uLAd4; Mon, 02 Jun 2025 15:01:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748869291;
	bh=FieVAEWznLoIbNcxXAkkWP3eu6tZdHagdagZTMItcqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=T2kEEHuVKwlzIZJ0gPdHg2NgeNN6OyHGBgkvsWK97ab8cnnrM5dfqY0kpBuJg43xi
	 YDzS099GBMnjIBI6E7AmvSEkzMguH7ERcPxchTros2Auut3J6sm5MdKFABwVBXdK/o
	 oUugewbduXNfAml7PulHND5Y4U3aTLRWA/s+41ltaZJXOus3/qHzuE6QRgWxPtXg17
	 jwe9C6pxYUjabKurmLXBkX4NtZjOfEo58RZd7yw20akU1TuffIFG+e8qNdQZMsMFJi
	 +Zp0+ZjO3xAaFAYAGDBXLKqZntkCY7EDkCb28tqN3lEQerPbDoJgz8R+cLA+3Lb6QK
	 KEeZFqYu+jKdw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 02 Jun 2025 15:01:31 +0200
X-ME-IP: 124.33.176.97
Message-ID: <3dccf669-3d09-4eaf-b4d4-09841d19bd84@wanadoo.fr>
Date: Mon, 2 Jun 2025 22:01:25 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] can: rcar_canfd: Use ndev parameter in
 rcar_canfd_set_bittiming()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <cover.1748863848.git.geert+renesas@glider.be>
 <002c3ab28323210e83ab3d35462dad40d22128ff.1748863848.git.geert+renesas@glider.be>
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
In-Reply-To: <002c3ab28323210e83ab3d35462dad40d22128ff.1748863848.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/06/2025 at 20:54, Geert Uytterhoeven wrote:
> There is no need to do a back-and-forth "priv = netdev_priv(ndev)" and
> "priv->ndev" where the "ndev" parameter is available.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Are these still useful anyhow? You can get all the bittiming values through the
netlink interface.

Well, if you tell me these are still useful, then I trust you and OK to keep. If
not, consider removing.

> ---
>  drivers/net/can/rcar/rcar_canfd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 2174c9667cabce54..dbf17b16c18aa5cc 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -1458,7 +1458,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
>  		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
>  
>  		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
> -		netdev_dbg(priv->ndev, "nrate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
> +		netdev_dbg(ndev, "nrate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
>  			   brp, sjw, tseg1, tseg2);
>  
>  		/* Data bit timing settings */
> @@ -1471,7 +1471,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
>  		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
>  
>  		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
> -		netdev_dbg(priv->ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
> +		netdev_dbg(ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
>  			   brp, sjw, tseg1, tseg2);
>  	} else {
>  		/* Classical CAN only mode */
> @@ -1488,8 +1488,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
>  		}
>  
>  		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
> -		netdev_dbg(priv->ndev,
> -			   "rate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
> +		netdev_dbg(ndev, "rate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
>  			   brp, sjw, tseg1, tseg2);
>  	}
>  }

Yours sincerely,
Vincent Mailhol


