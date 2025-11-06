Return-Path: <linux-can+bounces-5315-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A936C39A79
	for <lists+linux-can@lfdr.de>; Thu, 06 Nov 2025 09:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182513BC1EB
	for <lists+linux-can@lfdr.de>; Thu,  6 Nov 2025 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6443090E6;
	Thu,  6 Nov 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="F1nyCmFX"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9C3309DAB;
	Thu,  6 Nov 2025 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419047; cv=pass; b=hDWPwTq6ql57XnkkL8WCwFxPbbeZotuSXscOOGQk48vp4Q8i6YNfN+HLUIC6FE5OUPHgTgC5Mnt+Xdg9T9ydifrrlsCpMh4VBW7LlGyTc9M0ztHuxlGrOWb/t90/ki5qKLDrKfzFGU6TY3N7cVIvvx784wPcYLMHLQvTB1MUVqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419047; c=relaxed/simple;
	bh=o1xaYpRnb9AFlPq8FL2poEcml+3NGX/hgiJvSZ4vtLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCN4Z2ugWeqayM/l7KmlgJ7sO4/zlIms7T3fneSwMOErlUeFxnAoVXX8LcAGVkRlsXPedf6/dGEx5isGYK1DXAFLdhU3+tt9wbxIwRQQhWm10h1pKtfowTz6kld49Ep04777+mYGFFNaKgvtiYKChcSaOmsf6cnlk5824GpnKTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=F1nyCmFX; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762419037; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tYBfJJ9cNxULP21prutAab5ghwGFbBELWYVgBGL3ThJV+Gd5LDnx5U59AXH+1RgAhU
    dQPNuJyTl3gOaX+IG3fRRiw4uEcsVJDSS/eiEP+XG2hGkyZOOmdjUkLnjwBuntbwr4fg
    Yh+sR69DovSl+prz8WGiJ1Qf1gLH9iP1JQPTwmvCYZ9eowgfbLUfpXhI2/K6vMXJlBRG
    UvGuUe5LkJ4mygC0J+TLnivBErWImBq58or7G7ZR7fy5MzwxBpZ67j9J66vWphOP/uWo
    e+eR0S7KOJWqY8R2CC4Lk/sOAKD87jt58ZtpfRHFoc3Rek1b0mlSVMmQZ57/XYFPBSZq
    D4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762419037;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HSSq9zvRYIAv2hPb7GnzWmnL2nQ0k4LEPQN8u6uR94I=;
    b=TXjidCinfs7wbgwN9L5xbmgQIzAjiLIMyV41D8N0A3Ba7Wm9+wPkjn+H/rZBwVVdnV
    V1YD5CLKHKX6i7+n0WOIW6pyBSUtN8qetRp0Trss59dOZ7CwiLPePJJ3gM0lGlRLIA5q
    ekjOgQa+lbxW+2IBz1he9a7hCKa5dQZksf0tlZ5HseoxbVjFAmrLoYnbO150LQ9E5geM
    w5zYrG7Y3GSRODRRC+Vac+u4nkHdSirHc0D11GfwX/9rmfaKaMFOZKngypRelwclhcjd
    5ui9uUGqYe7s5sY2SrZ97NEnjFVEWgf2gl1qMStBpNNft6e3oO0Am/7k5pBPlA0VCVgX
    jjdw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762419037;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HSSq9zvRYIAv2hPb7GnzWmnL2nQ0k4LEPQN8u6uR94I=;
    b=F1nyCmFXh/g2hPuh4Vvf/p1y7O8rB30f0rdQjtWQVsUFrDuLnziRloyur/cNUNlnkM
    9fPTgV6QfmI4n2aL/9s4P9U+wWRm9RgGpBFtBXzyYNzjMeUzHSjcIzJZ3xXeu8rPPW0f
    uO+S4TLMQKaloFmqcc81oLUMcLQjRpsSbn4LCPuJdQC90ksvJbCDKdgJn/u1X2D8dIjd
    fWsYMS3uogsz9znNz0kvuzksgyTufAg9AMbLnkmOLP6TZkKyWt1O9zS/k1zk435u4f1y
    lxipBV9T+fAEEzQUsplLTe9G4Kyi4tgUl2c2jCauFMqwXgc6PAQKeD/gg4CFIR6UwIxy
    b6Gg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id Kf23d01A68oaVia
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 6 Nov 2025 09:50:36 +0100 (CET)
Message-ID: <2c75aca3-a19a-4144-8be5-8fb7524e581e@hartkopp.net>
Date: Thu, 6 Nov 2025 09:50:36 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] can: netlink: add CAN_CTRLMODE_XL_ERR_SIGNAL
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
 <20251021-canxl-netlink-v2-6-8b8f58257ab6@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251021-canxl-netlink-v2-6-8b8f58257ab6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21.10.25 17:47, Vincent Mailhol wrote:
> Classical CAN and CAN FD must generate error frames on the CAN bus
> when detecting a protocol violation.
> 
> CAN XL's error signaling is different and works as follows:
> 
>    - In interoperability mode (both FD and XL), error signaling must be
>      on.
> 
>    - When operating a CAN controller in CAN XL only mode but with TMS
>      off, the user can decide whether the error signalling is enabled
>      or disabled.
> 
>    - On the contrary, when using TMS, error signalling must be off.
> 
> Introduce the new CAN_CTRLMODE_XL_ERR_SIGNAL control mode. This new
> option is only made available for CAN XL, so despite the error
> signalling being always on for Classical CAN and CAN FD, forbid the
> use of this flag when CAN XL is off.
> 
> If the user provides the error signalling flag, check its validity. If
> the flag is omitted, activate error signalling by default whenever
> possible. This is summarized in below table:
> 
> 			CAN_CTRLMODE_XL_ERR_SIGNAL
> 	-------------------------------------------
> 	CC/FD		option not available
> 	CC/FD/XL	on

Yes. This is the 'mixed-mode'
I would propose to use the 'mixed-mode' expression in the patch description.

> 	XL TMS off	configurable (default on)

Good default.

> 	XL TMS on	off
> 
> Suggested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Link: https://lore.kernel.org/linux-can/20250527195625.65252-9-socketcan@hartkopp.net/
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
>   drivers/net/can/dev/dev.c        |  2 ++
>   drivers/net/can/dev/netlink.c    | 29 +++++++++++++++++++++++++++--
>   include/uapi/linux/can/netlink.h |  1 +
>   3 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 1de5babcc4f3..0c16d0174f7f 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -125,6 +125,8 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
>   		return "xl-tdc-manual";
>   	case CAN_CTRLMODE_XL_TMS:
>   		return "xl-tms";
> +	case CAN_CTRLMODE_XL_ERR_SIGNAL:
> +		return "xl-error-signalling";
>   	default:
>   		return "<unknown>";
>   	}
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 8afd2baa03cf..6126b191fea0 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -191,7 +191,8 @@ static int can_validate_xl_flags(struct netlink_ext_ack *extack,
>   		}
>   		if (masked_flags & CAN_CTRLMODE_XL_TMS) {
>   			const u32 tms_conflicts_mask = CAN_CTRLMODE_FD |
> -				CAN_CTRLMODE_XL_TDC_MASK;
> +				CAN_CTRLMODE_XL_TDC_MASK |
> +				CAN_CTRLMODE_XL_ERR_SIGNAL;
>   			u32 tms_conflicts = masked_flags & tms_conflicts_mask;
>   
>   			if (tms_conflicts) {
> @@ -201,11 +202,23 @@ static int can_validate_xl_flags(struct netlink_ext_ack *extack,
>   				return -EOPNOTSUPP;
>   			}
>   		}
> +		if ((masked_flags & CAN_CTRLMODE_FD) &&
> +		    (mask & CAN_CTRLMODE_XL_ERR_SIGNAL) &&
> +		    !(masked_flags & CAN_CTRLMODE_XL_ERR_SIGNAL)) {
> +			NL_SET_ERR_MSG(extack,
> +				       "When using both CAN FD and XL, error signalling must be on");

This implicitly tells us that mixed-mode is CC/FD/XL ;-)
  > +			return -EOPNOTSUPP;
> +		}
>   	} else {
>   		if (mask & CAN_CTRLMODE_XL_TMS) {
>   			NL_SET_ERR_MSG(extack, "TMS requires CAN XL");
>   			return -EOPNOTSUPP;
>   		}
> +		if (mask & CAN_CTRLMODE_XL_ERR_SIGNAL) {
> +			NL_SET_ERR_MSG(extack,
> +				       "Error signalling is only configurable with CAN XL");
> +			return -EOPNOTSUPP;
> +		}
>   	}
>   
>   	return 0;
> @@ -310,6 +323,11 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   				       "TMS can not be activated while CAN FD is on");
>   			return -EOPNOTSUPP;
>   		}
> +		if (deactivated & CAN_CTRLMODE_XL_ERR_SIGNAL) {
> +			NL_SET_ERR_MSG(extack,
> +				       "Error signalling can not be deactivated while CAN FD is on");
> +			return -EOPNOTSUPP;
> +		}
>   	}
>   
>   	/* If a top dependency flag is provided, reset all its dependencies */
> @@ -317,12 +335,19 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
>   	if (cm->mask & CAN_CTRLMODE_XL)
>   		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK |
> -				    CAN_CTRLMODE_XL_TMS);
> +				    CAN_CTRLMODE_XL_TMS |
> +				    CAN_CTRLMODE_XL_ERR_SIGNAL);
>   
>   	/* clear bits to be modified and copy the flag values */
>   	priv->ctrlmode &= ~cm->mask;
>   	priv->ctrlmode |= maskedflags;
>   
> +	/* If omitted, set error signalling on if possible */
> +	if ((maskedflags & CAN_CTRLMODE_XL) &&
> +	    !(cm->mask & CAN_CTRLMODE_XL_ERR_SIGNAL) &&
> +	    !(priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
> +		priv->ctrlmode |= CAN_CTRLMODE_XL_ERR_SIGNAL;
> +
>   	/* Wipe potential leftovers from previous CAN FD/XL config */
>   	if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {
>   		memset(&priv->fd.data_bittiming, 0,
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
> index ebafb091d80f..30d446921dc4 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -108,6 +108,7 @@ struct can_ctrlmode {
>   #define CAN_CTRLMODE_XL_TDC_AUTO	0x2000	/* XL transceiver automatically calculates TDCV */
>   #define CAN_CTRLMODE_XL_TDC_MANUAL	0x4000	/* XL TDCV is manually set up by user */
>   #define CAN_CTRLMODE_XL_TMS		0x8000	/* Transceiver Mode Switching */
> +#define CAN_CTRLMODE_XL_ERR_SIGNAL	0x10000	/* XL error signalling */
>   
>   /*
>    * CAN device statistics
> 
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Best regards,
Oliver


