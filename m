Return-Path: <linux-can+bounces-6416-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKBUNxd6fGmWNAIAu9opvQ
	(envelope-from <linux-can+bounces-6416-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 10:29:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD08B8EE0
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 10:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8251E300B84A
	for <lists+linux-can@lfdr.de>; Fri, 30 Jan 2026 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79370352FBB;
	Fri, 30 Jan 2026 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SHPrz4qQ";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WgU2qaie"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9D2BD597;
	Fri, 30 Jan 2026 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769765395; cv=pass; b=dZFbKRGBlnp2RSpeZohhGxeXlZMqQC8vZIeDaZ1nLsH2yObrMh6EL6mtuDZJ22Ao/873PkHlZxW2FJDpdsJknmRkd+Kc6Z9me1YtVuiG9HBcVFphhZYV/WwrKrXN8fIYFB4160hw0ZiYn8o3k5cvRvvYR5I1zpQI8R8k6qnuPSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769765395; c=relaxed/simple;
	bh=eTi299TA4ib3ukVA/wScWqLiLs4dJNFHQARXFUdJ0zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtbtMwRArOOjJKR78IjotNjrdIjh2XBQrWLJ3w/x3IvWbd0TBWzsb4jp6QljI+dbZNWlS1WWX3i7CgVW1yw18Qxkkv6pSFoN+OiLtoURPmxuFQbqMWUNTjXyXXRzXSyzWMvwZVMkwnQiA0cjsOAgrUq9pHQkg9hwo4vzT3kY2Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=SHPrz4qQ; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WgU2qaie; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769765383; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W0HzXwzSGE2/BDiXY+acBwtrX7xE9s9a/3lWvKZMwh1yCYaz+QPEc5fzizZfKmeEkL
    s9svq+HJJ1xcohvZS/FHdUzo1qus2vfG+ukUWYzIKyCBQTuQiQdg7TKptynvQPnd4vCr
    cT/dWhlB7sCJ4pvKJpZl++4/yu5SkF2sWcuoB19IVscrWZcoD8jJjk5/Th4qfVDMqkYz
    K0xXSuuexwpLnOGuvX5Y/Tcxem4+eJkdEpKvWkaAo4VUSm8oa9ZFhXFqXbMqiUpKkS2i
    YjpyIi6YYbVMcJF67ERAZuIFZ1+xqoEvAnHZ9hnh289TX8N7PDMDWDZCDC+MLxD6rgou
    ZdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769765383;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6Zl2IB9736D6Zj2sKyt1hKruk6QIOMbeRfa7hmxsvrw=;
    b=AqgE2CgNxWmYbiIkXclA6l1alb55vkq7cdZse+Ev46EvVM3KtyexxarzSqW02hhOna
    wFr7dOuybYK/vf4QtKBFVBsXmOw1klrr3Go+8+le4WSTEdjVN3zRaWo7OuRoCyL8B3Mh
    xLXV0Saw9qwDYxFjuqsnG7qryMfo/ZWEYQXzLs7hXgaECq+DP1rMZ+dYd79tZ/mjjgEg
    ZyBaNwHVxuuRt9xeyKvwwpd1XWRxEO1yCCLCf3h4Nim2TyYR7WV/bZeGcKUugq+Hf9ea
    fpi4P1LXvgHmJRCxIn44Ic1onpdywCo1lqD+FhVDpUwfH8IB/8RRsRm1wnuN6kCdWGUv
    g/yA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769765383;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6Zl2IB9736D6Zj2sKyt1hKruk6QIOMbeRfa7hmxsvrw=;
    b=SHPrz4qQErm55bhoNcnw1YN2HzGMOEHOdeQd2FVtCaOYyObWrLI+HVXXo3EJKJGtMz
    y0qM1sBAaQVm3D7Tio5EqeWXeUBK8hmKurWqv1yT2QD7slrvC+N+m3xFCAIi74nkm7hI
    5/bNh8E/M1o05McbHUS3UQGUeoMtp4BIDqxwURsBZwnggnKaittNoJYNYxOUbFOg+t16
    6DNmzjCIRs0Bc5kMUOMNgUvg49bY21L0djEw6tB9cy8ScsLIYgNyvQ7SVpWU1pluB0TC
    z1f5qMqrkfaDvOAg9kaKgEjdb1MLIdNFGGF//+fjYdWKuQCNkgnhrBTTKgXCBlKyEVT/
    y8Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769765383;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=6Zl2IB9736D6Zj2sKyt1hKruk6QIOMbeRfa7hmxsvrw=;
    b=WgU2qaieZ6rUZbu8oj2lsTdTOysHtQAGJstgbYO+bWEbmX+XplWTWsL5LhZ6T9/Hta
    x8g/MzWTQ23OUzSi8MCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7tnMDLztswwlyqon4XDpA0w0c7HaA=="
Received: from [IPV6:2a00:6020:4a38:6810:ae1c:f386:228b:f98a]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Ka861020U9Th2nR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 30 Jan 2026 10:29:43 +0100 (CET)
Message-ID: <93d61e1c-5cdf-498e-8699-43e57cbb221b@hartkopp.net>
Date: Fri, 30 Jan 2026 10:29:37 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 6/6] can: gw: use can_gw_hops instead of
 sk_buff::csum_start
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260130-can_skb_ext-v6-0-8fceafab7f26@hartkopp.net>
 <20260130-can_skb_ext-v6-6-8fceafab7f26@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260130-can_skb_ext-v6-6-8fceafab7f26@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6416-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DD08B8EE0
X-Rspamd-Action: no action



On 30.01.26 09:42, Oliver Hartkopp via B4 Relay wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> As CAN skbs don't use IP checksums the skb->csum_start variable was used to
> store the can-gw CAN frame time-to-live counter together with
> skb->ip_summed set to CHECKSUM_UNNECESSARY.
> 
> Remove the 'hack' using the skb->csum_start variable and move the content
> to can_skb_ext::can_gw_hops of the CAN skb extensions.
> 
> The module parameter 'max_hops' has been reduced to a single byte to fit
> can_skb_ext::can_gw_hops as the maximum value to be stored is 6.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   drivers/net/can/vxcan.c |  7 ++++++-
>   net/can/gw.c            | 23 ++++++-----------------
>   2 files changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index f14c6f02b662..6e642909d6ca 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -19,10 +19,11 @@
>   #include <linux/can/dev.h>
>   #include <linux/can/skb.h>
>   #include <linux/can/vxcan.h>
>   #include <linux/can/can-ml.h>
>   #include <linux/slab.h>
> +#include <net/can.h>
>   #include <net/rtnetlink.h>
>   
>   #define DRV_NAME "vxcan"
>   
>   MODULE_DESCRIPTION("Virtual CAN Tunnel");
> @@ -37,10 +38,11 @@ struct vxcan_priv {
>   static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
>   {
>   	struct vxcan_priv *priv = netdev_priv(dev);
>   	struct net_device *peer;
>   	struct net_device_stats *peerstats, *srcstats = &dev->stats;
> +	struct can_skb_ext *csx;
>   	struct sk_buff *skb;
>   	unsigned int len;
>   
>   	if (can_dropped_invalid_skb(dev, oskb))
>   		return NETDEV_TX_OK;
> @@ -62,11 +64,14 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
>   		kfree_skb(oskb);
>   		goto out_unlock;
>   	}
>   
>   	/* reset CAN GW hop counter */
> -	skb->csum_start = 0;
> +	csx = can_skb_ext_find(skb);
> +	if (csx)
> +		csx->can_gw_hops = 0;
> +

We are dealing with a cloned skb here, where we can not be sure that the 
original skb ("oskb") was not cloned before too.

Therefore we need to take care that the skb extension can be written 
without affecting potential clones of oskb.

csx = can_skb_ext_add(skb) would do a potential cow for us and also sets 
can_gw_hops to zero.

Therefore the only change for vxcan.c should look like this:

if (!can_skb_ext_add(skb)) {
	kfree_skb(skb);
	goto out_unlock;
}

I'll wait for a respin until tomorrow.
Maybe there are other remarks for this patch set too.

Best regards,
Oliver

>   	skb->pkt_type   = PACKET_BROADCAST;
>   	skb->dev        = peer;
>   	skb->ip_summed  = CHECKSUM_UNNECESSARY;
>   
>   	len = can_skb_get_data_len(skb);
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 6f158abd61aa..d83fc8242e0b 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -69,12 +69,12 @@ MODULE_ALIAS(CAN_GW_NAME);
>   
>   #define CGW_MIN_HOPS 1
>   #define CGW_MAX_HOPS 6
>   #define CGW_DEFAULT_HOPS 1
>   
> -static unsigned int max_hops __read_mostly = CGW_DEFAULT_HOPS;
> -module_param(max_hops, uint, 0444);
> +static unsigned char max_hops __read_mostly = CGW_DEFAULT_HOPS;
> +module_param(max_hops, byte, 0444);
>   MODULE_PARM_DESC(max_hops,
>   		 "maximum " CAN_GW_NAME " routing hops for CAN frames "
>   		 "(valid values: " __stringify(CGW_MIN_HOPS) "-"
>   		 __stringify(CGW_MAX_HOPS) " hops, "
>   		 "default: " __stringify(CGW_DEFAULT_HOPS) ")");
> @@ -478,23 +478,12 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>   		return;
>   
>   	/* Do not handle CAN frames routed more than 'max_hops' times.
>   	 * In general we should never catch this delimiter which is intended
>   	 * to cover a misconfiguration protection (e.g. circular CAN routes).
> -	 *
> -	 * The Controller Area Network controllers only accept CAN frames with
> -	 * correct CRCs - which are not visible in the controller registers.
> -	 * According to skbuff.h documentation the csum_start element for IP
> -	 * checksums is undefined/unused when ip_summed == CHECKSUM_UNNECESSARY.
> -	 * Only CAN skbs can be processed here which already have this property.
>   	 */
> -
> -#define cgw_hops(skb) ((skb)->csum_start)
> -
> -	BUG_ON(skb->ip_summed != CHECKSUM_UNNECESSARY);
> -
> -	if (cgw_hops(skb) >= max_hops) {
> +	if (csx->can_gw_hops >= max_hops) {
>   		/* indicate deleted frames due to misconfiguration */
>   		gwj->deleted_frames++;
>   		return;
>   	}
>   
> @@ -534,15 +523,15 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>   		gwj->dropped_frames++;
>   		return;
>   	}
>   
>   	/* put the incremented hop counter in the cloned skb */
> -	cgw_hops(nskb) = cgw_hops(skb) + 1;
> +	ncsx->can_gw_hops = csx->can_gw_hops + 1;
>   
>   	/* first processing of this CAN frame -> adjust to private hop limit */
> -	if (gwj->limit_hops && cgw_hops(nskb) == 1)
> -		cgw_hops(nskb) = max_hops - gwj->limit_hops + 1;
> +	if (gwj->limit_hops && ncsx->can_gw_hops == 1)
> +		ncsx->can_gw_hops = max_hops - gwj->limit_hops + 1;
>   
>   	nskb->dev = gwj->dst.dev;
>   
>   	/* pointer to modifiable CAN frame */
>   	cf = (struct canfd_frame *)nskb->data;
> 


