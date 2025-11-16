Return-Path: <linux-can+bounces-5451-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 597A8C61BCE
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 20:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 023BE4E236D
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 19:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF0A22578A;
	Sun, 16 Nov 2025 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Ynv555VC";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="h3H9vDRr"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983663B1B3
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763321526; cv=pass; b=mMfQorPoZ89ow5Qsj/X35R5sGrqBuxOyNnmWyY/dal2KzaDlC4ELTszcR+uo0K83614aOWWRh9Qbx5csdrKxe6PqLUhLzWN6EgyQ3GhzE8DX0/zwvgntQxPUKSBuYj/eY5bFQb3BXWsQ4wjjYU6vzD8r+ZSekzW+AXUOh+rO4Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763321526; c=relaxed/simple;
	bh=oGh0yteFdmqjmc6bmUqhnbJqu/4FoU0ImGLDITgMCcQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hv+kTxdrfFdOrZR52w/OH1qIt2mQvjqnIb/6yeHcpDnjIpAu/OLMpbWTENmrOlylziBrxq9tu5ZIRKmtOPHAAF5KPlNZf6cdfoYX7LZ3+uvrpvr+dpBEKtRJQztK+K+yiOqqBkvkjhCr3vw3iVJaoXr+Fk4MdeY4xw2knnkJWxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Ynv555VC; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=h3H9vDRr; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763321515; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HyE2Xbqaytlfa818Dyc1VIv8mRAsxKK66WOOeLbJAgaJWwvvEQJ8fqf/gxml568SWT
    2J2WQwZwbUDfhwOHLXvxuroJROcIPxC/U2q7lk8H+G0wlrak+lBL/TZDdyDnPaPyLY82
    o8KatuwfZhn/DvBVjit2tC/ew1X6CmeAZ9aja0p0Sc4u0uK+IcpPXxvXaLTHCGmlpWVb
    yAi1j88+UONZmZMe6Oddzmbfmx11kObl3I56mWgDW9SfFn0qGJegEITTN54YXLoOKrAd
    bjcYxBQWU/aYfsZJ81/+WwdmiJRm/bDlnBi1//kcSL1i9StroABSstrhOw7U8WDLrGF4
    wsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763321515;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=afRheB7S6S/ZtgMB+5DevSRr4bPkIiuAOdaBcUqP9WU=;
    b=HQ+lUa/qP76wPcqTEaEGctT9CWGYvd4Ap6olJCpohWgN+9dmfXNSV0rUubumO5J2KQ
    ixL/Ceog5GJrfy1In5N2KtONyE82vrnZretm1kUOTjd55D6qRV9QXD8Wp2ExMSPgkpk0
    w3F7tGXYsLMgtj9IKB8TljJoFG64hrehtKMfLVt5PZvuU0N9l/VTfFfhJUEJPzAA71mq
    O1BSRQPh3jZw8iAztqNkxDcocOwQoC1mwDjYSrBiiogODoydMpVNBJe6+kffm6k3CCoN
    kid/SeU328611Jo4VXC88GI+id0wTVMsn7dLdBnsbYNQTb+ukkgxOJFIh9mTVkJuWSWV
    NNZg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763321515;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=afRheB7S6S/ZtgMB+5DevSRr4bPkIiuAOdaBcUqP9WU=;
    b=Ynv555VC2dAmVA53RU8L8m9VFqQLctiZevAK5QPCJZowYmNmUtojqtZr8vGgZyWwH5
    /hCBnAT7Ms1fufK5AV5wbzHA7pTwvMf7rEWlR17onqLewBOZdYJQVkyj0JFvFZCTwA5A
    CvACqnWxzvk9KEhzRQU9CQNsr58ldLKV/xYSe+YPvtLjdzFBrlnf1ILzzu+9ZVVvKS6o
    nxAjPOPBqlTZP/gI0cO/mpGyZHAfd2CBZ7pvVMaeJUhTZOOllcGY0cgdGoL/GoGwbDsv
    SKmq0m/HqcwPTRIMmeG+izVXU99O1+vO2VyJ17kZ/xlWBQkV+uN1B77cy2LVIMFfSQMZ
    JqiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763321515;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=afRheB7S6S/ZtgMB+5DevSRr4bPkIiuAOdaBcUqP9WU=;
    b=h3H9vDRrYpHPFes/0ogXBv/Y08YCpm3pwrqiXlyI8K8KUq/fAbGNU9QRQxuprgQagd
    VVCj0bkvp3L2gUjCNJCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AGJVshKs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 16 Nov 2025 20:31:54 +0100 (CET)
Message-ID: <c77caed0-5d88-4b2c-b371-3e2870324b4d@hartkopp.net>
Date: Sun, 16 Nov 2025 20:31:49 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v2 05/15] can: netlink: add CAN_CTRLMODE_XL_TMS flag
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20251115163740.7875-1-socketcan@hartkopp.net>
 <20251115163740.7875-6-socketcan@hartkopp.net>
Content-Language: en-US
In-Reply-To: <20251115163740.7875-6-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 15.11.25 17:37, Oliver Hartkopp wrote:
> From: Vincent Mailhol <mailhol@kernel.org>
> 
> The Transceiver Mode Switching (TMS) indicates whether the CAN XL
> controller shall use the PWM or NRZ encoding during the data phase.
> 
> The term "transceiver mode switching" is used in both ISO 11898-1 and
> CiA 612-2 (although only the latter one uses the abbreviation TMS). We
> adopt the same naming convention here for consistency.
> 
> Add the CAN_CTRLMODE_XL_TMS flag to the list of the CAN control modes.
> 
> Add can_validate_xl_flags() to check the coherency of the TMS flag.
> That function will be reused in upcoming changes to validate the other
> CAN XL flags.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
>   drivers/net/can/dev/dev.c        |  2 ++
>   drivers/net/can/dev/netlink.c    | 48 ++++++++++++++++++++++++++++++--
>   include/uapi/linux/can/netlink.h |  1 +
>   3 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 443692587217..9da3da8c6225 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -121,10 +121,12 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
>   		return "xl";
>   	case CAN_CTRLMODE_XL_TDC_AUTO:
>   		return "xl-tdc-auto";
>   	case CAN_CTRLMODE_XL_TDC_MANUAL:
>   		return "xl-tdc-manual";
> +	case CAN_CTRLMODE_XL_TMS:
> +		return "xl-tms";
>   	default:
>   		return "<unknown>";
>   	}
>   }
>   EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 26c25e660e31..5a628c629109 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -179,10 +179,36 @@ static int can_validate_databittiming(struct nlattr *data[],
>   		return err;
>   
>   	return 0;
>   }
>   
> +static int can_validate_xl_flags(struct netlink_ext_ack *extack,
> +				 u32 masked_flags, u32 mask)
> +{
> +	if (masked_flags & CAN_CTRLMODE_XL) {
> +		if (masked_flags & CAN_CTRLMODE_XL_TMS) {
> +			const u32 tms_conflicts_mask = CAN_CTRLMODE_FD |
> +				CAN_CTRLMODE_XL_TDC_MASK;
> +			u32 tms_conflicts = masked_flags & tms_conflicts_mask;
> +
> +			if (tms_conflicts) {
> +				NL_SET_ERR_MSG_FMT(extack,
> +						   "TMS and %s are mutually exclusive",
> +						   can_get_ctrlmode_str(tms_conflicts));

root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 dbitrate 
2000000 fd on xbitrate 4000000 xl on tms on
Error: TMS and fd are mutually exclusive.

The error messages should look consistent in terms of capitalization.

Maybe can_get_ctrlmode_str() should deliver capitalized strings as we 
see it in the 'ip' tool output:

root@de1soc1:~# ./ip -det link show can0
11: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 2060 qdisc pfifo_fast state UP 
mode DEFAULT group default qlen 10
     link/can  promiscuity 0 allmulti 0 minmtu 16 maxmtu 16
     can <FD,TDC-AUTO,XL,XL-TDC-AUTO> state STOPPED restart-ms 0

> +				return -EOPNOTSUPP;
> +			}
> +		}
> +	} else {
> +		if (mask & CAN_CTRLMODE_XL_TMS) {
> +			NL_SET_ERR_MSG(extack, "TMS requires CAN XL");

This looks good btw.

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
>   	u32 flags = 0;
>   	int err;
> @@ -199,10 +225,14 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
>   		    (flags & CAN_CTRLMODE_RESTRICTED)) {
>   			NL_SET_ERR_MSG(extack,
>   				       "Listen-only and restricted modes are mutually exclusive");

IMO this should also be capitalized ...

"LISTEN-MODE and RESTRICTED modes are mutually exclusive");

>   			return -EOPNOTSUPP;
>   		}
> +
> +		err = can_validate_xl_flags(extack, flags, cm->mask);
> +		if (err)
> +			return err;
>   	}
>   
>   	err = can_validate_bittiming(data, extack, IFLA_CAN_BITTIMING);
>   	if (err)
>   		return err;
> @@ -224,11 +254,11 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   				   struct nlattr *data[],
>   				   struct netlink_ext_ack *extack)
>   {
>   	struct can_priv *priv = netdev_priv(dev);
>   	struct can_ctrlmode *cm;
> -	u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing;
> +	u32 ctrlstatic, maskedflags, deactivated, notsupp, ctrlstatic_missing;
>   
>   	if (!data[IFLA_CAN_CTRLMODE])
>   		return 0;
>   
>   	/* Do not allow changing controller mode while running */
> @@ -236,10 +266,11 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   		return -EBUSY;
>   
>   	cm = nla_data(data[IFLA_CAN_CTRLMODE]);
>   	ctrlstatic = can_get_static_ctrlmode(priv);
>   	maskedflags = cm->flags & cm->mask;
> +	deactivated = ~cm->flags & cm->mask;
>   	notsupp = maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
>   	ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
>   
>   	if (notsupp) {
>   		NL_SET_ERR_MSG_FMT(extack,
> @@ -257,15 +288,25 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   				   "missing required %s static control mode",
>   				   can_get_ctrlmode_str(ctrlstatic_missing));
>   		return -EOPNOTSUPP;
>   	}
>   
> +	/* If FD was active and is not turned off, check for XL conflicts */
> +	if (priv->ctrlmode & CAN_CTRLMODE_FD & ~deactivated) {
> +		if (maskedflags & CAN_CTRLMODE_XL_TMS) {
> +			NL_SET_ERR_MSG(extack,
> +				       "TMS can not be activated while CAN FD is on");
"TMS can not be activated while FD is on");

And this also.

Best regards,
Oliver

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
>   	priv->ctrlmode |= maskedflags;
>   
> @@ -393,11 +434,12 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
>   
>   	memset(&dbt_params->tdc, 0, sizeof(dbt_params->tdc));
>   	if (data[IFLA_CAN_CTRLMODE]) {
>   		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
>   
> -		need_tdc_calc = !(cm->mask & tdc_mask);
> +		if (fd || !(priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
> +			need_tdc_calc = !(cm->mask & tdc_mask);
>   	}
>   	if (data_tdc) {
>   		/* TDC parameters are provided: use them */
>   		err = can_tdc_changelink(dbt_params, data_tdc, extack);
>   		if (err) {
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
> index c2c96c5978a8..ebafb091d80f 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -105,10 +105,11 @@ struct can_ctrlmode {
>   #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
>   #define CAN_CTRLMODE_RESTRICTED		0x800	/* Restricted operation mode */
>   #define CAN_CTRLMODE_XL			0x1000	/* CAN XL mode */
>   #define CAN_CTRLMODE_XL_TDC_AUTO	0x2000	/* XL transceiver automatically calculates TDCV */
>   #define CAN_CTRLMODE_XL_TDC_MANUAL	0x4000	/* XL TDCV is manually set up by user */
> +#define CAN_CTRLMODE_XL_TMS		0x8000	/* Transceiver Mode Switching */
>   
>   /*
>    * CAN device statistics
>    */
>   struct can_device_stats {


