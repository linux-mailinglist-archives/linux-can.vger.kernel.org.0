Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD445442043
	for <lists+linux-can@lfdr.de>; Mon,  1 Nov 2021 19:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhKASvS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Nov 2021 14:51:18 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:25540 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbhKASup (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Nov 2021 14:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635792217;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=yJZmvd24RARFGolUOOawHlE6JgNvQytUlTm9wy+u8GA=;
    b=YwRAqsSn9vE203/kQVO/MheZRbZrWWpy6p0BvK0H9nS2l8R2+A7UavQ+tCsHbWjbck
    //lt0k3vql7Su2oIv7BlxDywbXKp+BWkxYH2dZFbC4LWqq5Z6vivx/8knt1hlUEod7I8
    rxh+Az5zim+hFayH4PXO6yvqDPKwYh+skH7cE7THGDaShTHQ6cd7RtxEvptZ9bNgc03T
    W7BN/xlc0Srbv1m1xCO+CgVKZAV4D6EOLRe6KsoYDdtFl7tbNDW1tLjgxfK71L9iTQnR
    SqyHpu1XsfX8zKTDvW6LVaX2VmxLPSgeTqdUwtJDYMghLTRZItG4MMTaR8iQXDLCXizA
    yvzQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.33.8 AUTH)
    with ESMTPSA id 900f80xA1Ihbvjo
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 1 Nov 2021 19:43:37 +0100 (CET)
Subject: Re: [PATCH v5] can: netlink: report the CAN controller mode supported
 flags
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
References: <20211101123125.67488-1-mailhol.vincent@wanadoo.fr>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ba2a284e-557a-454a-b699-1c80cfbc3947@hartkopp.net>
Date:   Mon, 1 Nov 2021 19:43:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211101123125.67488-1-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Vincent,

On 01.11.21 13:31, Vincent Mailhol wrote:
> Currently, the CAN netlink interface provides no easy ways to check
> the capabilities of a given controller. The only method from the
> command line is to try each CAN_CTRLMODE_* individually to check
> whether the netlink interface returns an -EOPNOTSUPP error or not
> (alternatively, one may find it easier to directly check the source
> code of the driver instead...)
> 
> This patch introduces a method for the user to check both the
> supported and the static capabilities. The proposed method introduces
> a new IFLA nest: IFLA_CAN_CTRLMODE_EXT which extends the current
> IFLA_CAN_CTRLMODE. This is done to guaruanty a full forward and

guaranty ?!?

> backward compatibility between the kernel and the user land
> applications.
> 
> The IFLA_CAN_CTRLMODE_EXT nest contains one single entry:
> IFLA_CAN_CTRLMODE_SUPPORTED. Because this single entry is only used in
> one direction: kernel to userland, no new struct nla_policy are
> introduced.
> 
> Below table explains how IFLA_CAN_CTRLMODE_SUPPORTED (hereafter:
> "supported") and can_ctrlmode::flags (hereafter: "flags") allow us to
> identify both the supported and the static capabilities, when masked
> with any of the CAN_CTRLMODE_* bit flags:

This is not clear to me.

What I understood: You are using the existing 'struct can_ctrlmode'.

But this struct looks like this:

struct can_ctrlmode {
         __u32 mask;
         __u32 flags;
};

So 'mask' and 'flags' contain the capability information for the 
supported features according to the table below.

And not 'supported' and 'flags', right?

Regards,
Oliver

> 
>   supported &	flags &		Controller capabilities
>   CAN_CTRLMODE_*	CAN_CTRLMODE_*
>   -----------------------------------------------------------------------
>   false		false		Feature not supported (always disabled)
>   false		true		Static feature (always enabled)
>   true		false		Feature supported but disabled
>   true		true		Feature supported and enabled
> 
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> I will send a iproute2-next patch right after for those how would like
> to try this.
> 
> Hi Marc,
> 
> Finally, I also implemented the IFLA_CAN_CTRLMODE_EXT solution as you
> suggested in:
> 
> https://lore.kernel.org/linux-can/20211029124608.u7zbprvojifjpa7j@pengutronix.de/T/#m78118c94072083a6f8d2f0f769b120f847ac1384
> 
> I have a small preference with the v4 (reuse struct can_ctrlmode but
> discard can_ctrlmode::supported in userland when it is zero). But at
> the end, both the v4 and the v5 seem acceptable to me. So I let you
> pick the one you prefer.
> 
> 
> Yours sincerely,
> Vincent Mailhol
> ---
>   drivers/net/can/dev/netlink.c    | 31 ++++++++++++++++++++++++++++++-
>   include/uapi/linux/can/netlink.h | 13 +++++++++++++
>   2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 26c336808be5..7633d98e3912 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -21,6 +21,7 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
>   	[IFLA_CAN_DATA_BITTIMING_CONST]	= { .len = sizeof(struct can_bittiming_const) },
>   	[IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
>   	[IFLA_CAN_TDC] = { .type = NLA_NESTED },
> +	[IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
>   };
>   
>   static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
> @@ -383,6 +384,12 @@ static size_t can_tdc_get_size(const struct net_device *dev)
>   	return size;
>   }
>   
> +static size_t can_ctrlmode_ext_get_size(void)
> +{
> +	return nla_total_size(0) +		/* nest IFLA_CAN_CTRLMODE_EXT */
> +		nla_total_size(sizeof(u32));	/* IFLA_CAN_CTRLMODE_SUPPORTED */
> +}
> +
>   static size_t can_get_size(const struct net_device *dev)
>   {
>   	struct can_priv *priv = netdev_priv(dev);
> @@ -415,6 +422,7 @@ static size_t can_get_size(const struct net_device *dev)
>   				       priv->data_bitrate_const_cnt);
>   	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
>   	size += can_tdc_get_size(dev);				/* IFLA_CAN_TDC */
> +	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
>   
>   	return size;
>   }
> @@ -472,6 +480,25 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
>   	return -EMSGSIZE;
>   }
>   
> +static int can_ctrlmode_ext_fill_info(struct sk_buff *skb,
> +				      const struct can_priv *priv)
> +{
> +	struct nlattr *nest;
> +
> +	nest = nla_nest_start(skb, IFLA_CAN_CTRLMODE_EXT);
> +	if (!nest)
> +		return -EMSGSIZE;
> +
> +	if (nla_put_u32(skb, IFLA_CAN_CTRLMODE_SUPPORTED,
> +			priv->ctrlmode_supported)) {
> +		nla_nest_cancel(skb, nest);
> +		return -EMSGSIZE;
> +	}
> +
> +	nla_nest_end(skb, nest);
> +	return 0;
> +}
> +
>   static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
>   {
>   	struct can_priv *priv = netdev_priv(dev);
> @@ -531,7 +558,9 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
>   		     sizeof(priv->bitrate_max),
>   		     &priv->bitrate_max)) ||
>   
> -	    (can_tdc_fill_info(skb, dev))
> +	    can_tdc_fill_info(skb, dev) ||
> +
> +	    can_ctrlmode_ext_fill_info(skb, priv)
>   	    )
>   
>   		return -EMSGSIZE;
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
> index 75b85c60efb2..02ec32d69474 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -137,6 +137,7 @@ enum {
>   	IFLA_CAN_DATA_BITRATE_CONST,
>   	IFLA_CAN_BITRATE_MAX,
>   	IFLA_CAN_TDC,
> +	IFLA_CAN_CTRLMODE_EXT,
>   
>   	/* add new constants above here */
>   	__IFLA_CAN_MAX,
> @@ -166,6 +167,18 @@ enum {
>   	IFLA_CAN_TDC_MAX = __IFLA_CAN_TDC - 1
>   };
>   
> +/*
> + * IFLA_CAN_CTRLMODE_EXT nest: controller mode extended parameters
> + */
> +enum {
> +	IFLA_CAN_CTRLMODE_UNSPEC,
> +	IFLA_CAN_CTRLMODE_SUPPORTED,	/* u32 */
> +
> +	/* add new constants above here */
> +	__IFLA_CAN_CTRLMODE,
> +	IFLA_CAN_CTRLMODE_MAX = __IFLA_CAN_CTRLMODE - 1
> +};
> +
>   /* u16 termination range: 1..65535 Ohms */
>   #define CAN_TERMINATION_DISABLED 0
>   
> 
