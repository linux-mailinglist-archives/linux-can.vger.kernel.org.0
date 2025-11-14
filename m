Return-Path: <linux-can+bounces-5397-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 27884C5D551
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 14:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAB8F35254C
	for <lists+linux-can@lfdr.de>; Fri, 14 Nov 2025 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16CF2EB874;
	Fri, 14 Nov 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Fmw90I8P";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="cg4bB1Jk"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA954774;
	Fri, 14 Nov 2025 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126357; cv=pass; b=UfzdVxxPWD9AxzezEHtcjtyFEMXsEsR8zTxlj7cvccdCzuBi+qTXVtUNGBEXsCZiXpRtHplmtiVXZSWiG0sBDm9WAaYOkhyqssF1O1Cs2vIMtgp7W7ziVT+A6I+y0j1YTJsbvBIzVEUQC8Oh7VQvx1LkgxeFhlbReUHVYVToMgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126357; c=relaxed/simple;
	bh=WCefLD8MeLvEQFBOevv3MBgMu0SlqXfI/7fH4G5Av+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTuymDeiiVG17HGn5xYuWw3xD5q/PZCWLSM3e0wCN0BkYbbHcs4UBDv7r0s1qPppJlub0S6VB2zb4MTrOgFArgwSf+YNqd+s6Wz3r+2lYUg58KLBrsZsLhNdCrf+103zO+82aDtEnSxQw9aVfePkm7xuyFuvtsnIt0soz7ThAmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Fmw90I8P; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=cg4bB1Jk; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763126345; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YE0kCTr5dg9ms3LP2Dvl0AuM/pj8xoU+uayL5WQ0cAUEDgOto19QKLzh1vrrfMq0tF
    fHRbIZLLD6g1t84J+t3q0CTRh8c1QoGAWamX9kVASYkSEDTZoCaCUszzP8uQJ5tLAhQG
    8zUinzS5pJ276fMkib84GfxWW+LcsEBTUEGZ+U/okPRWunfCGz8Bis6Zy3gJ1Ao34IJb
    wNRo73o/KU6jiQTJJ3/hSfRWbmpuccWntiKSKeaoxttY/oW9orjLG0TO6TxqJBE26Dwt
    xt0BOvaOKORA4MUxxqn5pXS9CrvTXEJ17neZzxKgar9TP3t/zotsxlmC0TjHL0h7Wfl3
    oDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763126345;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZE4pDXuCvY5syfpLALakPSZCnVxq3V1oMcFgAqs5YTc=;
    b=MC0e/qyy7MbY7qbiJN15iTaky1qKMESCqQ3u1/QYengPyc59LC7R9woXweMls3L/iW
    61fGEbiDB9c54qHhjpyLgHeFbJ5QAaqoMQELpO3y27WYPC8l71WshvbN4jmZQecsTNZh
    GrDsV0AlqdulEzzlrifmBhJQzCRoGtCKQZB/4xAZ9c1DqxbG9AUjqG17dh9Y5LDV4BYT
    uVfVebO/b67OyO+U1RDVjFvZ6TAUlNa4noQ65twtP+bDESfgMU4wM1kbpH4O0/tYNNqT
    0DS3yVa1rSJef+Jh5iLEPmLE+hXzaYdiX6JZtMCpD7pcYTGuLpgfT2pDJIwo66IEx+Hr
    LIIQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763126345;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZE4pDXuCvY5syfpLALakPSZCnVxq3V1oMcFgAqs5YTc=;
    b=Fmw90I8PjM/7shiHM5nQWZ9xecjSs3csQKE9O5znsMLU8b7GHt6mLASyHUpt/NkLR7
    eTakA9bDxdPtJ/3759fZXNB6s+IzMSuSdhdxozKKyuIfrzyDOI4tW4GRl0BncZg4AMN9
    k3M3o5GIE4jZeblM4KleEJiT1cYhWYenExV4H1ez+6CafPqw0Zb+/GGDVOenWjkoELtH
    7Rm95lpOGOt0+FjH2cFCETJiLZPrTQH8w+dOT/2rhzd70z8+6iHwWGqiLGKsMcblNKSE
    W9ccA12r4umo2gAnCF7UQ0Rx0aozVYfYbR2aQj+hPF1UvcJBBgVQrNPYUhfsCnMNy9eh
    H/VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763126345;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ZE4pDXuCvY5syfpLALakPSZCnVxq3V1oMcFgAqs5YTc=;
    b=cg4bB1Jkfl5sc7qEtxa5g9kiW9vILff1BQVLQe3EFc1rdyE5LC54SVxS5KcXF4BiZB
    +2EET/1jpYPMJ6ZGO2Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AEDJ4bUO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 14 Nov 2025 14:19:04 +0100 (CET)
Message-ID: <e58c90a8-c9e3-4f9b-99cb-09b87c18d657@hartkopp.net>
Date: Fri, 14 Nov 2025 14:19:04 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] can: netlink: add initial CAN XL support
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
 <20251013-canxl-netlink-v1-3-f422b7e2729f@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251013-canxl-netlink-v1-3-f422b7e2729f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 13.10.25 13:01, Vincent Mailhol wrote:
> CAN XL uses bittiming parameters different from Classical CAN and CAN
> FD. Thus, all the data bittiming parameters, including TDC, need to be
> duplicated for CAN XL.
> 
> Add the CAN XL netlink interface for all the features which are common
> with CAN FD. Any new CAN XL specific features are added later on.
> 
> Add a check that CAN XL capable nodes correctly provide
> CAN_CTRLMODE_RESTRIC_OP as mandated by ISO 11898-1:2024 §6.6.19.
> 
> The first time CAN XL is activated, the MTU is set by default to
> CANXL_MAX_MTU. The user may then configure a custom MTU within the
> CANXL_MIN_MTU to CANXL_MIN_MTU range, in which case, the custom MTU
> value will be kept as long as CAN XL remains active.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> Changelog:
> 
> RFC -> v1:
> 
>    - Correctly wipe out the CAN XL data bittiming and TDC parameters
>      when switching CAN_CTRLMODE_XL off.
> 
>    - Add one level on nesting for xl parameters so that:
> 
>       - bittiming are under priv->xl.data_bittiming{,_const}¨
>       - pwm are under priv->xl.pwm{,_const}
> 
>    - Many other code refactors.
> ---
>   drivers/net/can/dev/dev.c        | 14 ++++++-
>   drivers/net/can/dev/netlink.c    | 87 ++++++++++++++++++++++++++++++++--------
>   include/linux/can/bittiming.h    |  6 ++-
>   include/linux/can/dev.h          |  7 +++-
>   include/uapi/linux/can/netlink.h |  7 ++++
>   5 files changed, 100 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
> index 3377afb6f1c4..32f11db88295 100644
> --- a/drivers/net/can/dev/dev.c
> +++ b/drivers/net/can/dev/dev.c
> @@ -117,6 +117,12 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
>   		return "fd-tdc-manual";
>   	case CAN_CTRLMODE_RESTRICTED:
>   		return "restricted-operation";
> +	case CAN_CTRLMODE_XL:
> +		return "xl";
> +	case CAN_CTRLMODE_XL_TDC_AUTO:
> +		return "xl-tdc-auto";
> +	case CAN_CTRLMODE_XL_TDC_MANUAL:
> +		return "xl-tdc-manual";
>   	default:
>   		return "<unknown>";
>   	}
> @@ -350,7 +356,13 @@ void can_set_default_mtu(struct net_device *dev)
>   {
>   	struct can_priv *priv = netdev_priv(dev);
>   
> -	if (priv->ctrlmode & CAN_CTRLMODE_FD) {
> +	if (priv->ctrlmode & CAN_CTRLMODE_XL) {
> +		if (can_is_canxl_dev_mtu(dev->mtu))
> +			return;
> +		dev->mtu = CANXL_MTU;
> +		dev->min_mtu = CANXL_MIN_MTU;
> +		dev->max_mtu = CANXL_MAX_MTU;
> +	} else if (priv->ctrlmode & CAN_CTRLMODE_FD) {
>   		dev->mtu = CANFD_MTU;
>   		dev->min_mtu = CANFD_MTU;
>   		dev->max_mtu = CANFD_MTU;
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index f44b5dffa176..2405f1265488 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -2,7 +2,7 @@
>   /* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
>    * Copyright (C) 2006 Andrey Volkov, Varma Electronics
>    * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
> - * Copyright (C) 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> + * Copyright (C) 2021-2025 Vincent Mailhol <mailhol@kernel.org>
>    */
>   
>   #include <linux/can/dev.h>
> @@ -22,6 +22,9 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
>   	[IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
>   	[IFLA_CAN_TDC] = { .type = NLA_NESTED },
>   	[IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
> +	[IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
> +	[IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
> +	[IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
>   };
>   
>   static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
> @@ -70,7 +73,7 @@ static int can_validate_tdc(struct nlattr *data_tdc,
>   		return -EOPNOTSUPP;
>   	}
>   
> -	/* If one of the CAN_CTRLMODE_TDC_* flag is set then TDC
> +	/* If one of the CAN_CTRLMODE_{,XL}_TDC_* flags is set then TDC
>   	 * must be set and vice-versa
>   	 */
>   	if ((tdc_auto || tdc_manual) && !data_tdc) {
> @@ -82,8 +85,8 @@ static int can_validate_tdc(struct nlattr *data_tdc,
>   		return -EOPNOTSUPP;
>   	}
>   
> -	/* If providing TDC parameters, at least TDCO is needed. TDCV
> -	 * is needed if and only if CAN_CTRLMODE_TDC_MANUAL is set
> +	/* If providing TDC parameters, at least TDCO is needed. TDCV is
> +	 * needed if and only if CAN_CTRLMODE_{,XL}_TDC_MANUAL is set
>   	 */
>   	if (data_tdc) {
>   		struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
> @@ -126,10 +129,10 @@ static int can_validate_databittiming(struct nlattr *data[],
>   	bool is_on;
>   	int err;
>   
> -	/* Make sure that valid CAN FD configurations always consist of
> +	/* Make sure that valid CAN FD/XL configurations always consist of
>   	 * - nominal/arbitration bittiming
>   	 * - data bittiming
> -	 * - control mode with CAN_CTRLMODE_FD set
> +	 * - control mode with CAN_CTRLMODE_{FD,XL} set
>   	 * - TDC parameters are coherent (details in can_validate_tdc())
>   	 */
>   
> @@ -139,7 +142,10 @@ static int can_validate_databittiming(struct nlattr *data[],
>   		is_on = flags & CAN_CTRLMODE_FD;
>   		type = "FD";
>   	} else {
> -		return -EOPNOTSUPP; /* Place holder for CAN XL */
> +		data_tdc = data[IFLA_CAN_XL_TDC];
> +		tdc_flags = flags & CAN_CTRLMODE_XL_TDC_MASK;
> +		is_on = flags & CAN_CTRLMODE_XL;
> +		type = "XL";
>   	}
>   
>   	if (is_on) {
> @@ -206,6 +212,11 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
>   	if (err)
>   		return err;
>   
> +	err = can_validate_databittiming(data, extack,
> +					 IFLA_CAN_XL_DATA_BITTIMING, flags);
> +	if (err)
> +		return err;
> +
>   	return 0;
>   }
>   
> @@ -215,7 +226,8 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   {
>   	struct can_priv *priv = netdev_priv(dev);
>   	struct can_ctrlmode *cm;
> -	u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing;
> +	const u32 xl_mandatory = CAN_CTRLMODE_RESTRICTED;
> +	u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing, xl_missing;
>   
>   	if (!data[IFLA_CAN_CTRLMODE])
>   		return 0;
> @@ -229,6 +241,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   	maskedflags = cm->flags & cm->mask;
>   	notsupp = maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
>   	ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
> +	xl_missing = (priv->ctrlmode_supported & xl_mandatory) ^ xl_mandatory;
>   
>   	if (notsupp) {
>   		NL_SET_ERR_MSG_FMT(extack,
> @@ -248,21 +261,36 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   		return -EOPNOTSUPP;
>   	}
>   
> +	if ((priv->ctrlmode_supported & CAN_CTRLMODE_XL) && xl_missing) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "bad device: CAN XL capable nodes must support the %s mode",
> +				   can_get_ctrlmode_str(xl_missing));
> +		return -EOPNOTSUPP;
> +	}
> +

I'm not sure if it is our job to check for ISO 11898-1:2024 compliance 
of CAN controllers when CAN_CTRLMODE_RESTRICTED is not supported.

IMO an appropriate error message (only) when the user requests this 
feature would be better and that is already the standard behaviour.

Best regards,
Oliver

>   	/* If a top dependency flag is provided, reset all its dependencies */
>   	if (cm->mask & CAN_CTRLMODE_FD)
>   		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
> +	if (cm->mask & CAN_CTRLMODE_XL)
> +		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK);
>   
>   	/* clear bits to be modified and copy the flag values */
>   	priv->ctrlmode &= ~cm->mask;
>   	priv->ctrlmode |= maskedflags;
>   
> -	/* Wipe potential leftovers from previous CAN FD config */
> +	/* Wipe potential leftovers from previous CAN FD/XL config */
>   	if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {
>   		memset(&priv->fd.data_bittiming, 0,
>   		       sizeof(priv->fd.data_bittiming));
>   		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
>   		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
>   	}
> +	if (!(priv->ctrlmode & CAN_CTRLMODE_XL)) {
> +		memset(&priv->xl.data_bittiming, 0,
> +		       sizeof(priv->fd.data_bittiming));
> +		priv->ctrlmode &= ~CAN_CTRLMODE_XL_TDC_MASK;
> +		memset(&priv->xl.tdc, 0, sizeof(priv->xl.tdc));
> +	}
>   
>   	can_set_default_mtu(dev);
>   
> @@ -337,7 +365,10 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
>   		dbt_params = &priv->fd;
>   		tdc_mask = CAN_CTRLMODE_FD_TDC_MASK;
>   	} else {
> -		return -EOPNOTSUPP; /* Place holder for CAN XL */
> +		data_bittiming = data[IFLA_CAN_XL_DATA_BITTIMING];
> +		data_tdc = data[IFLA_CAN_XL_TDC];
> +		dbt_params = &priv->xl;
> +		tdc_mask = CAN_CTRLMODE_XL_TDC_MASK;
>   	}
>   
>   	if (!data_bittiming)
> @@ -388,7 +419,7 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
>   		 */
>   		can_calc_tdco(&dbt_params->tdc, dbt_params->tdc_const, &dbt,
>   			      tdc_mask, &priv->ctrlmode, priv->ctrlmode_supported);
> -	} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
> +	} /* else: both CAN_CTRLMODE_{,XL}_TDC_{AUTO,MANUAL} are explicitly
>   	   * turned off. TDC is disabled: do nothing
>   	   */
>   
> @@ -491,6 +522,11 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>   	if (err)
>   		return err;
>   
> +	/* CAN XL */
> +	err = can_dbt_changelink(dev, data, false, extack);
> +	if (err)
> +		return err;
> +
>   	if (data[IFLA_CAN_TERMINATION]) {
>   		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
>   		const unsigned int num_term = priv->termination_const_cnt;
> @@ -558,14 +594,14 @@ static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_para
>   {
>   	size_t size = 0;
>   
> -	if (dbt_params->data_bittiming.bitrate)		/* IFLA_CAN_DATA_BITTIMING */
> +	if (dbt_params->data_bittiming.bitrate)		/* IFLA_CAN_{,XL}_DATA_BITTIMING */
>   		size += nla_total_size(sizeof(dbt_params->data_bittiming));
> -	if (dbt_params->data_bittiming_const)		/* IFLA_CAN_DATA_BITTIMING_CONST */
> +	if (dbt_params->data_bittiming_const)		/* IFLA_CAN_{,XL}_DATA_BITTIMING_CONST */
>   		size += nla_total_size(sizeof(*dbt_params->data_bittiming_const));
> -	if (dbt_params->data_bitrate_const)		/* IFLA_CAN_DATA_BITRATE_CONST */
> +	if (dbt_params->data_bitrate_const)		/* IFLA_CAN_{,XL}_DATA_BITRATE_CONST */
>   		size += nla_total_size(sizeof(*dbt_params->data_bitrate_const) *
>   				       dbt_params->data_bitrate_const_cnt);
> -	size += can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_TDC */
> +	size += can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_{,XL}_TDC */
>   
>   	return size;
>   }
> @@ -605,6 +641,9 @@ static size_t can_get_size(const struct net_device *dev)
>   	size += can_data_bittiming_get_size(&priv->fd,
>   					    priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
>   
> +	size += can_data_bittiming_get_size(&priv->xl,
> +					    priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);
> +
>   	return size;
>   }
>   
> @@ -649,7 +688,9 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev,
>   		tdc_is_enabled = can_fd_tdc_is_enabled(priv);
>   		tdc_manual = priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL;
>   	} else {
> -		return -EOPNOTSUPP; /* Place holder for CAN XL */
> +		dbt_params = &priv->xl;
> +		tdc_is_enabled = can_xl_tdc_is_enabled(priv);
> +		tdc_manual = priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL;
>   	}
>   	tdc_const = dbt_params->tdc_const;
>   	tdc = &dbt_params->tdc;
> @@ -771,7 +812,19 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
>   
>   	    can_tdc_fill_info(skb, dev, IFLA_CAN_TDC) ||
>   
> -	    can_ctrlmode_ext_fill_info(skb, priv)
> +	    can_ctrlmode_ext_fill_info(skb, priv) ||
> +
> +	    can_bittiming_fill_info(skb, IFLA_CAN_XL_DATA_BITTIMING,
> +				    &priv->xl.data_bittiming) ||
> +
> +	    can_bittiming_const_fill_info(skb, IFLA_CAN_XL_DATA_BITTIMING_CONST,
> +					  priv->xl.data_bittiming_const) ||
> +
> +	    can_bitrate_const_fill_info(skb, IFLA_CAN_XL_DATA_BITRATE_CONST,
> +					priv->xl.data_bitrate_const,
> +					priv->xl.data_bitrate_const_cnt) ||
> +
> +	    can_tdc_fill_info(skb, dev, IFLA_CAN_XL_TDC)
>   	    )
>   
>   		return -EMSGSIZE;
> diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
> index d30816dd93c7..68d533bb7856 100644
> --- a/include/linux/can/bittiming.h
> +++ b/include/linux/can/bittiming.h
> @@ -16,10 +16,12 @@
>   
>   #define CAN_CTRLMODE_FD_TDC_MASK				\
>   	(CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_TDC_MANUAL)
> +#define CAN_CTRLMODE_XL_TDC_MASK				\
> +	(CAN_CTRLMODE_XL_TDC_AUTO | CAN_CTRLMODE_XL_TDC_MANUAL)
>   #define CAN_CTRLMODE_TDC_AUTO_MASK				\
> -	(CAN_CTRLMODE_TDC_AUTO)
> +	(CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_XL_TDC_AUTO)
>   #define CAN_CTRLMODE_TDC_MANUAL_MASK				\
> -	(CAN_CTRLMODE_TDC_MANUAL)
> +	(CAN_CTRLMODE_TDC_MANUAL | CAN_CTRLMODE_XL_TDC_MANUAL)
>   
>   /*
>    * struct can_tdc - CAN FD Transmission Delay Compensation parameters
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 9de8fde3ec9d..945c16743702 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -47,7 +47,7 @@ struct can_priv {
>   
>   	const struct can_bittiming_const *bittiming_const;
>   	struct can_bittiming bittiming;
> -	struct data_bittiming_params fd;
> +	struct data_bittiming_params fd, xl;
>   	unsigned int bitrate_const_cnt;
>   	const u32 *bitrate_const;
>   	u32 bitrate_max;
> @@ -85,6 +85,11 @@ static inline bool can_fd_tdc_is_enabled(const struct can_priv *priv)
>   	return !!(priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
>   }
>   
> +static inline bool can_xl_tdc_is_enabled(const struct can_priv *priv)
> +{
> +	return !!(priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);
> +}
> +
>   static inline u32 can_get_static_ctrlmode(struct can_priv *priv)
>   {
>   	return priv->ctrlmode & ~priv->ctrlmode_supported;
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
> index fafd1cce4798..c2c96c5978a8 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -104,6 +104,9 @@ struct can_ctrlmode {
>   #define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
>   #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
>   #define CAN_CTRLMODE_RESTRICTED		0x800	/* Restricted operation mode */
> +#define CAN_CTRLMODE_XL			0x1000	/* CAN XL mode */
> +#define CAN_CTRLMODE_XL_TDC_AUTO	0x2000	/* XL transceiver automatically calculates TDCV */
> +#define CAN_CTRLMODE_XL_TDC_MANUAL	0x4000	/* XL TDCV is manually set up by user */
>   
>   /*
>    * CAN device statistics
> @@ -139,6 +142,10 @@ enum {
>   	IFLA_CAN_BITRATE_MAX,
>   	IFLA_CAN_TDC, /* FD */
>   	IFLA_CAN_CTRLMODE_EXT,
> +	IFLA_CAN_XL_DATA_BITTIMING,
> +	IFLA_CAN_XL_DATA_BITTIMING_CONST,
> +	IFLA_CAN_XL_DATA_BITRATE_CONST,
> +	IFLA_CAN_XL_TDC,
>   
>   	/* add new constants above here */
>   	__IFLA_CAN_MAX,
> 


