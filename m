Return-Path: <linux-can+bounces-6441-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIZtBZ9DfmndWgIAu9opvQ
	(envelope-from <linux-can+bounces-6441-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 19:02:07 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC0CC3769
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 19:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6853F3007B10
	for <lists+linux-can@lfdr.de>; Sat, 31 Jan 2026 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B181535CB8B;
	Sat, 31 Jan 2026 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxf9mYK+"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879FD2472A5;
	Sat, 31 Jan 2026 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769882509; cv=none; b=YfB71Wg79yRANiQcK0cPvb9Pv0M9tOH8NMsDt4hlvmj3jjIebu+VXkmLo3r5YfTfN25JhV0emB9FAEJ2DS58IMfT47RZk3HjaOKACgw5X6l7cm9tTBTxflcgwRGmMUtHhJgYBXZe0Cy3DCAbIGz8rB868MbJ863/ed+Tf1dCtEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769882509; c=relaxed/simple;
	bh=h3sHRNhd6LWAMOJi2q65CpHktFtBLPcu5uN9obg1hB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faNxYzC3xJondgzKcNrG+VhCjsOy3l+jRUg3R26rLG1qXsbf6yDBfh/vQ6WNrVEZBWQGfkTKG7jthciQ5IGqE7IQpGire3on3rbzcmNDA5FzBqYsuvNZIi15OwDrpLkPcHHH0hca7r+UVRTS0HHzSItzckPrL22NN5g7gvpsRe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxf9mYK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73587C4CEF1;
	Sat, 31 Jan 2026 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769882509;
	bh=h3sHRNhd6LWAMOJi2q65CpHktFtBLPcu5uN9obg1hB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hxf9mYK+pu5fN9zy66iZL93zb70NR0akn1q1/VDNc3Ap/nPm8VQcAlLl6X5lEg5dK
	 UZsaBqgdA2UmjCxF+/pg6CSGQKgOVGTrzZNLPLgQrv6njqG7JqTVd/RuvWiALK+fso
	 7/d7tCp96ZfPJnuNak2j5/FQMF9oW9Om6xeckRZ73EMScsO2hXIAfcH/1phU+29OFP
	 lNot9D4wDDRh3oKQQqBiGXuGJcdaLIfSgDTBro3Kl+Tzex8OfQ8aaCwm1erSEp+PE0
	 lWGWtrN8wTgS2PsTw1at/i5O4oECfGqpRDoIaPbA56sXpn8HWWuDz5NAtOtsE9mI3u
	 0uZzktbgLipsQ==
From: Jakub Kicinski <kuba@kernel.org>
To: socketcan@hartkopp.net
Cc: Jakub Kicinski <kuba@kernel.org>,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	robin@protonic.nl,
	netdev@vger.kernel.org,
	linux-can@vger.kernel.org,
	davem@davemloft.net,
	mailhol@kernel.org,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	mkl@pengutronix.de
Subject: Re: [net-next,v7,2/6] can: add CAN skb extension infrastructure
Date: Sat, 31 Jan 2026 10:00:26 -0800
Message-ID: <20260131180025.1124810-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131-can_skb_ext-v7-2-dd0f8f84a83d@hartkopp.net>
References: <20260131-can_skb_ext-v7-2-dd0f8f84a83d@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6441-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 3BC0CC3769
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says:

  Not sure about the first issue, I think you mentioned we have
  an extra ref? The uninitialized errors should probably be fixed
  "in net", before this series? :(

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
can: add CAN skb extension infrastructure

This patch introduces CAN skb extension infrastructure to store per-frame
metadata (interface index, frame length, gateway hops, flags) using the
standard skb_ext mechanism instead of the private CAN bus skb headroom.

> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index f14c6f02b662..53d7d9046f85 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c

[ ... ]

> @@ -39,6 +40,7 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
>  	struct vxcan_priv *priv = netdev_priv(dev);
>  	struct net_device *peer;
>  	struct net_device_stats *peerstats, *srcstats = &dev->stats;
> +	struct can_skb_ext *csx;
>  	struct sk_buff *skb;
>  	unsigned int len;
>
> @@ -63,6 +65,18 @@ static netdev_tx_t vxcan_xmit(struct sk_buff *oskb, struct net_device *dev)
>  		goto out_unlock;
>  	}
>
> +	/* the cloned skb points to the skb extension of the original oskb
> +	 * with an increased refcount. skb_ext_add() creates a copy to
> +	 * separate the skb extension data which is needed to start with a
> +	 * fresh can_gw_hops counter in the other namespace.
> +	 */
> +	csx = skb_ext_add(skb, SKB_EXT_CAN);
> +	if (!csx) {
> +		kfree_skb(skb);
> +		kfree_skb(oskb);
                ^^^^^^^^^^^^^^^^

Is this a double-free of oskb? Looking at the code flow:

    skb = skb_clone(oskb, GFP_ATOMIC);  /* line 60 */
    if (unlikely(!skb)) { ... }
    consume_skb(oskb);                   /* line 62 - frees oskb */

At this point oskb has been freed by consume_skb(). If skb_ext_add() then
fails, the error handler calls kfree_skb(oskb) on the already-freed pointer.

This can occur under memory pressure when skb_clone() succeeds but the
subsequent skb_ext_add() allocation fails. The kfree_skb(oskb) line should
be removed from this error path.

> +		goto out_unlock;
> +	}

[ ... ]

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 4bb60b8f9b96..94103fe654ff 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1005,6 +1022,13 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  		goto err_out_drop;
>  	}
>
> +	csx = can_skb_ext_add(skb);
> +	if (!csx) {
> +		kfree_skb(skb);
> +		netdev_put(dev, NULL);
> +		goto err_out_drop;
> +	}

Does this error path return an uninitialized value to userspace? The variable
err is declared without initialization at line 959 and sock_alloc_send_skb()
only sets it on failure. When can_skb_ext_add() fails after a successful
sock_alloc_send_skb(), err contains garbage.

Other error paths in this function set err explicitly before jumping to
err_out_drop. Should this add err = -ENOMEM before the goto?

> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 1589e8ca634e..fc28a7677369 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c

[ ... ]

> @@ -895,6 +897,12 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
>  	if (!skb)
>  		goto failure;
>
> +	csx = can_skb_ext_add(skb);
> +	if (!csx) {
> +		kfree_skb(skb);
> +		goto failure;
> +	}

Similar concern here: ret is declared without initialization at line 891.
sock_alloc_send_skb() only writes to ret on failure. When can_skb_ext_add()
fails after successful allocation, ret is uninitialized when returned via
*errcode at the failure label.

Should this set ret = -ENOMEM before goto failure?

> diff --git a/net/can/raw.c b/net/can/raw.c
> index fb4f9c854df0..03438e9bc535 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c

[ ... ]

> @@ -956,6 +958,12 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  	if (!skb)
>  		goto put_dev;
>
> +	csx = can_skb_ext_add(skb);
> +	if (!csx) {
> +		kfree_skb(skb);
> +		goto put_dev;
> +	}

This returns -EINVAL (from line 923) when can_skb_ext_add() fails due to
memory allocation failure. Should this be -ENOMEM instead? The
sock_alloc_send_skb() above this code returns -ENOMEM for allocation
failures.
-- 
pw-bot: cr

