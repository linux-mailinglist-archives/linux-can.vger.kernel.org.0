Return-Path: <linux-can+bounces-5314-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65909C39A31
	for <lists+linux-can@lfdr.de>; Thu, 06 Nov 2025 09:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DD914EBACF
	for <lists+linux-can@lfdr.de>; Thu,  6 Nov 2025 08:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B672E8E08;
	Thu,  6 Nov 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="f8RX5CBQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926A23717F;
	Thu,  6 Nov 2025 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418940; cv=pass; b=awgnUqSQyq16MDlUjlnKKe63KMz9QZe0DyVY34i/KAafB7nhOChTUCI2W3Shp5MfjBmrppdQbI3FXxIsOlEBKeVwFLCCEGMfGZi+jrt7us166NcymIcdfYzaXAlQmVukLuSFir/7E4KRAwZGua/aDgxW7EHs0biqxAFazoPw3K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418940; c=relaxed/simple;
	bh=WbDYYEgM0lun2x/60zeAkKTNla3YSzoL7/gEh9PEzfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pF+tBEI8f/PGb8Q/0r9ZLzKp5fSdjRT6+wrsHaXcbWQiYCtqaTR3ejjuakFBA1X0KvX14WjRuuBwoBJb5VwguZizcjnHFBViJiv0dy3HTTaO6lUSbEXq/6oTiTVwHDma7EbNO1eKPhSzzpC7BO/Kw94O3Y5Pjbhaz7DW/ATivpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=f8RX5CBQ; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762418567; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NubCG0NhhaQKSWnHCBIqjGyCP2t3MJ974qezJPGZMcXC6mgyZbGuwX/2hQgi9hUYQx
    oer6ocYRtur8VtLgx7xIwCjJCasJSyHnJ2IlPT8z5odI6s2yhcKMbtReOsIVQxarcWO8
    43N8CAJSSapl+9znpjpiAaBcH5buVEMIIz45FIiHU1X+TnEvbpMokvHFt3bB16Os+Gdn
    eI9Li/YREj44NoB15TEhEoAuiGvQiZYHrlZCbEqnYpoPhNutF2/unN38fxU6N6drkap+
    n75w7bbrN4Ac7zsTZO71aTFCqsWNk1NvKye4uvmHqkrzIWPgcgqn18CxQoWJkklfZcS8
    VbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762418567;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xN8Jx8Tr/aseoy1eIg38mWzDr/XeALsXajwN6LPD7IY=;
    b=GSzMpDxctMUaLMopmftkfN+R9nbqhFh7GRLssMgdtjQM/mDc5xqe+li2WzYdqEa2ft
    5xB1wzBE5ovCKt/J7ZvThpXHPT0AHMe4nC8rb/stEx8XvoMvCL69ttrnttgCNNP4C3jc
    ic+11CE4IL5JwQbV1xCS5tVaZ4QRj8wRcuq2oeqjXpb277QnIEu29RyTSRo0NMLfzo2X
    /R57p8aJCt9eR62oxVrZN7jnDSlreaFnnsRyI17Lu/u3QFEqn+W+r/7om0yht9xnJcoF
    OLwyu5AQOdp/tFjj9Y2fclYoLgqrLJ2awV7vQnhFMPZX71Bi6Yi99n3zjnrNnNLfvELk
    LA+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762418567;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xN8Jx8Tr/aseoy1eIg38mWzDr/XeALsXajwN6LPD7IY=;
    b=f8RX5CBQMxO/QqU3pEi1uZH1mfrr0vl5etwqiwU5Bn4yzDofCjHbE/4htv2948n+Yi
    05GaC1XelEjj/5IVm06SvqRuLFbr0+oAnhDyHOkaG6c7og9s8PZC3fX++vklWTg2fyUr
    sLscQ81ZFdoWu8ZLbdHJcbg5NFpaL1G/sVqNih4BOK2Oc+Z/VdoHUQmnrvvK7nWZzEqV
    Rh9itmIYxTeZrQnqHQjjB3HOhQD837XuAwrZkngmqqMx5IuhOzWwdBkJKi1r3giSpl3K
    eAyp0jzHrQJaXJnyn/8qRGkvcdfsCB0mb+Wadh80HpK+kNlLx2X75rHS+OfyKY9j+JsD
    IIKA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 53.4.2 AUTH)
    with ESMTPSA id Kf23d01A68gkVZv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 6 Nov 2025 09:42:46 +0100 (CET)
Message-ID: <a50a77c8-85ef-4ac8-b649-33b880ec4b17@hartkopp.net>
Date: Thu, 6 Nov 2025 09:42:41 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] can: netlink: add CAN_CTRLMODE_XL_TMS flag
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
 <20251021-canxl-netlink-v2-5-8b8f58257ab6@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251021-canxl-netlink-v2-5-8b8f58257ab6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

On 21.10.25 17:47, Vincent Mailhol wrote:
> The Transceiver Mode Switching (TMS) indicates whether the CAN XL
> controller shall use the PWM or NRZ encoding during the data phase.
> 
> The term "transceiver mode switching" is used in both ISO 11898-1 and
> CiA 612-2 (although only the latter one uses the abbreviation TMS). We
> adopt the same naming convention here for consistency.
> 
> Add the CAN_CTRLMODE_XL_TMS flag to the list of the CAN control modes.
> 
> In the netlink interface, each boolean option is in reality a tristate
> in disguise: on, off or omitted. For the moment, TMS is implemented as
> below:
> 
>    - CAN_CTRLMODE_XL_TMS is set to false: TMS is disabled.
>    - CAN_CTRLMODE_XL_TMS is set to true: TMS is enabled.
>    - CAN_CTRLMODE_XL_TMS is omitted: return -EOPNOTSUPP.

I would propose to follow the usual pattern:

- TMS off (default)
- TMS on (when selected on the command line)

> For most of the other control modes, omitting a flag default to the
> option turned off. It could also be possible to provide a default
> behaviour if the TMS flag is omitted (i.e. either default to TMS off
> or on). However, it is not clear for the moment which default
> behaviour is preferable. If the usage shows a clear trend (for example
> if the vast majority of the users want TMS on by default), it is still
> possible to revisit that choice in the future. Whereas once a default
> option is provided, we can not change it back without breaking the
> interface.
> 
> As a corollary, for the moment, the users will be forced to specify
> the TMS in the ip tool when using CAN XL.
> 
> Add can_validate_xl_flags() to check the coherency of the TMS flag.
> That function will be reused in upcoming changes to validate the other
> CAN XL flags.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> Question:
> 
> Is it still possible to send Classical CAN frames when TMS is on? If
> not, we need to also add this filter in can_dev_dropped_skb():

No.

I've now learned there are two "CANXL-only" modes:

1. TMS on -> no CC/FD traffic
2. TMS off and ERR_SIG off -> no CC/FD traffic, because CC/FD require 
ERR_SIG on for a compliant transmission

And there is a "mixed-mode" with CC/FD/XL with TMS off ('ERR_SIG on' is 
default anyway).

This "mixed-mode" requires all bitrates for CC/FD/XL to be set and all 
these CAN protocols can be sent.

Currently the "mixed mode" consistency check does not insist on having 
FD on.

> 	if ((priv->ctrlmode & CAN_CTRLMODE_XL_TMS) && !can_is_canxl_skb(skb)) {
> 		netdev_info_once(dev,
> 				 "Classical CAN frames are not allowed under CAN XL's TMS mode\n");
> 		goto invalid_skb;
> 	}

Disabling CC & FD traffic with TMS on resp. ERR_SIG off is addressed in 
my patch:

[PATCH b4/canxl-netlink v2] can: drop unsupported CAN frames on socket 
and netdev level

https://lore.kernel.org/linux-can/20251103185336.32772-1-socketcan@hartkopp.net/T/#u

TMS on resp. ERR_SIG off urges FD to be off. And with this condition CC 
traffic is also disabled by that patch.

> My current assumption is that this is possible.

No.

> But the standard being
> not crystal clear on that point, I want to double check this with you!

Done ;-)

Best regards,
Oliver

> ---
>   drivers/net/can/dev/dev.c        |  2 ++
>   drivers/net/can/dev/netlink.c    | 52 +++++++++++++++++++++++++++++++++++++---
>   include/uapi/linux/can/netlink.h |  1 +
>   3 files changed, 52 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 32f11db88295..1de5babcc4f3 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -123,6 +123,8 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
>   		return "xl-tdc-auto";
>   	case CAN_CTRLMODE_XL_TDC_MANUAL:
>   		return "xl-tdc-manual";
> +	case CAN_CTRLMODE_XL_TMS:
> +		return "xl-tms";
>   	default:
>   		return "<unknown>";
>   	}
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 2405f1265488..8afd2baa03cf 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -181,6 +181,36 @@ static int can_validate_databittiming(struct nlattr *data[],
>   	return 0;
>   }
>   
> +static int can_validate_xl_flags(struct netlink_ext_ack *extack,
> +				 u32 masked_flags, u32 mask)
> +{
> +	if (masked_flags & CAN_CTRLMODE_XL) {
> +		if (!(mask & CAN_CTRLMODE_XL_TMS)) {
> +			NL_SET_ERR_MSG(extack, "Specify whether TMS is on or off");
> +			return -EOPNOTSUPP;
> +		}
> +		if (masked_flags & CAN_CTRLMODE_XL_TMS) {
> +			const u32 tms_conflicts_mask = CAN_CTRLMODE_FD |
> +				CAN_CTRLMODE_XL_TDC_MASK;
> +			u32 tms_conflicts = masked_flags & tms_conflicts_mask;
> +
> +			if (tms_conflicts) {
> +				NL_SET_ERR_MSG_FMT(extack,
> +						   "TMS and %s are mutually exclusive",
> +						   can_get_ctrlmode_str(tms_conflicts));
> +				return -EOPNOTSUPP;
> +			}
> +		}
> +	} else {
> +		if (mask & CAN_CTRLMODE_XL_TMS) {
> +			NL_SET_ERR_MSG(extack, "TMS requires CAN XL");
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int can_validate(struct nlattr *tb[], struct nlattr *data[],
>   			struct netlink_ext_ack *extack)
>   {
> @@ -201,6 +231,10 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
>   				       "Listen-only and restricted modes are mutually exclusive");
>   			return -EOPNOTSUPP;
>   		}
> +
> +		err = can_validate_xl_flags(extack, flags, cm->mask);
> +		if (err)
> +			return err;
>   	}
>   
>   	err = can_validate_bittiming(data, extack, IFLA_CAN_BITTIMING);
> @@ -227,7 +261,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   	struct can_priv *priv = netdev_priv(dev);
>   	struct can_ctrlmode *cm;
>   	const u32 xl_mandatory = CAN_CTRLMODE_RESTRICTED;
> -	u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing, xl_missing;
> +	u32 ctrlstatic, maskedflags, deactivated, notsupp, ctrlstatic_missing, xl_missing;
>   
>   	if (!data[IFLA_CAN_CTRLMODE])
>   		return 0;
> @@ -239,6 +273,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   	cm = nla_data(data[IFLA_CAN_CTRLMODE]);
>   	ctrlstatic = can_get_static_ctrlmode(priv);
>   	maskedflags = cm->flags & cm->mask;
> +	deactivated = ~cm->flags & cm->mask;
>   	notsupp = maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
>   	ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
>   	xl_missing = (priv->ctrlmode_supported & xl_mandatory) ^ xl_mandatory;
> @@ -268,11 +303,21 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   		return -EOPNOTSUPP;
>   	}
>   
> +	/* If FD was active and is not turned off, check for XL conflicts */
> +	if (priv->ctrlmode & CAN_CTRLMODE_FD & ~deactivated) {
> +		if (maskedflags & CAN_CTRLMODE_XL_TMS) {
> +			NL_SET_ERR_MSG(extack,
> +				       "TMS can not be activated while CAN FD is on");
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
>   	/* If a top dependency flag is provided, reset all its dependencies */
>   	if (cm->mask & CAN_CTRLMODE_FD)
>   		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
>   	if (cm->mask & CAN_CTRLMODE_XL)
> -		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK);
> +		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK |
> +				    CAN_CTRLMODE_XL_TMS);
>   
>   	/* clear bits to be modified and copy the flag values */
>   	priv->ctrlmode &= ~cm->mask;
> @@ -404,7 +449,8 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
>   	if (data[IFLA_CAN_CTRLMODE]) {
>   		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
>   
> -		need_tdc_calc = !(cm->mask & tdc_mask);
> +		if (fd || !(priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
> +			need_tdc_calc = !(cm->mask & tdc_mask);
>   	}
>   	if (data_tdc) {
>   		/* TDC parameters are provided: use them */
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
> index c2c96c5978a8..ebafb091d80f 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -107,6 +107,7 @@ struct can_ctrlmode {
>   #define CAN_CTRLMODE_XL			0x1000	/* CAN XL mode */
>   #define CAN_CTRLMODE_XL_TDC_AUTO	0x2000	/* XL transceiver automatically calculates TDCV */
>   #define CAN_CTRLMODE_XL_TDC_MANUAL	0x4000	/* XL TDCV is manually set up by user */
> +#define CAN_CTRLMODE_XL_TMS		0x8000	/* Transceiver Mode Switching */
>   
>   /*
>    * CAN device statistics
> 


