Return-Path: <linux-can+bounces-8365-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Mg1QBBOrVGqOpAMAu9opvQ
	(envelope-from <linux-can+bounces-8365-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 11:08:35 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A477491FF
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 11:08:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NRKVU4lD;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8365-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8365-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95ED530080AB
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBD23DD873;
	Mon, 13 Jul 2026 09:08:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858133DC4D9;
	Mon, 13 Jul 2026 09:08:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933685; cv=none; b=BioKK2TLv7jD4CpJF9J8paTaYjAF89s2D1U4m/bUjVCLbMPfddZMm1TJ1Qbt++PZ4B47NDLBgAtUVq/ocknQ1W2XOedAgk2Nub7Pv4hUWucchT1ofJCjQiadBzjAq2fTDHLhIKoPQE6WLG4sbh827ssG1SFs3J4LlrCt+l9miIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933685; c=relaxed/simple;
	bh=WXdQ64FnbvMK/zCMnFDlvGEKEG8Kd/9OYVw/hEnpGKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shaEt2A75QXprFpUW6F6I1aE+4qpNesG86WtroFqfR6bB6MyYMOqJl2zdYsi0eY6d2JpJZ3rvUST1+0fccl/Bq9Nijtu4bWxzXQ++Lp2D2+iC2NHFiOhkULUqO20XmfqcxmgaFYXEkeFfEeDw7bKLgg64j+FojhMdEqRmECUWAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRKVU4lD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE2E1F000E9;
	Mon, 13 Jul 2026 09:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783933684;
	bh=oG8N0x2HPr/aG7utMltCOwMhDrp7w9Ua/DIi3vGNREY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRKVU4lDTAG13uBxLNMIOa2xDZ66PfQW0QX483bgZrl3Jr/baoSnzi2U4ivVZnP7m
	 /Hmf4k/UAS7MzkgVgCGUgQOIQTnI7xx0ALwgD8tb5J/qssG6+6jaenNSczd2c2yuyG
	 XI18fgSv6vwJbMwHcziY6vTv1vuxhS5zKEVSdLaxHtXpsrGO74N+HEIIlpq604kF/Z
	 g1vqe2aRqNFjWK4pQu5Qkzkd05Aohpn0fmWbde5wbX8SccFO9MhQOY/Djyas/0rOV0
	 KjdD7YP6QOHX205k5gVsK5ml3mawFVJRKgxdLtNDPB8zaPO4OgufwPKinicvslaCsG
	 zvi46uNH7llAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] can: flexcan: split rx/tx masks per mailbox IRQ
 line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, imx@lists.linux.dev, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20260713085306.2643794-4-ciprianmarian.costea@oss.nxp.com>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-4-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 09:08:03 +0000
Message-Id: <20260713090803.CCE2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8365-lists,linux-can=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ciprianmarian.costea@oss.nxp.com,m:robh@kernel.org,m:conor+dt@kernel.org,m:Frank.Li@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:imx@lists.linux.dev,m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:devicetree@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,smtp.kernel.org:mid,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78A477491FF

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of multiple flexcan IRQ handlers causes lockl=
ess list corruption in the can_rx_offload queue.
--

--- Patch [3]: [PATCH v6 3/6] can: flexcan: split rx/tx masks per mailbox I=
RQ line ---
commit 9f143e05fb5957d463ce1d05d4126d168798b0d8
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: flexcan: split rx/tx masks per mailbox IRQ line

This commit updates flexcan to process split rx/tx masks based on the
mailbox IRQ line for platforms like S32G2. It introduces MB0 and MB1 masks
and passes them to flexcan_do_mb() to only process the relevant mailbox
range for each IRQ.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c

[ ... ]

> @@ -1244,8 +1255,14 @@ static irqreturn_t flexcan_irq_mb(int irq, void *d=
ev_id)
>  	struct net_device *dev =3D dev_id;
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
>  	irqreturn_t handled;
> +	u64 mb_mask =3D ~0ULL;
> +
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
> +		mb_mask =3D (irq =3D=3D priv->irq_secondary_mb) ?
> +			  FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK :
> +			  FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
> =20
> -	handled =3D flexcan_do_mb(dev);
> +	handled =3D flexcan_do_mb(dev, mb_mask);
> =20
>  	if (handled)
>  		can_rx_offload_irq_finish(&priv->offload);

[Severity: High]
This is a pre-existing issue, but does this concurrent execution risk
corrupting the lockless rx-offload queues?

Since the primary and secondary mailbox IRQs are separate lines (e.g., on
S32G2), they can be dispatched concurrently on different CPUs when frames
arrive simultaneously for both mailbox groups.

If both IRQs execute at the same time:

CPU1
flexcan_irq_mb()
   flexcan_do_mb()
      can_rx_offload_irq_offload_timestamp()
         __skb_queue_add_sort(&offload->skb_irq_queue, ...)

CPU2
flexcan_irq_mb()
   flexcan_do_mb()
      can_rx_offload_irq_offload_timestamp()
         __skb_queue_add_sort(&offload->skb_irq_queue, ...)

Or if CPU2 reaches the finish step while CPU1 is still adding:

CPU2
flexcan_irq_mb()
   can_rx_offload_irq_finish()
      skb_queue_splice_tail_init(&offload->skb_irq_queue, ...)

Since __skb_queue_add_sort() and skb_queue_splice_tail_init() operate
locklessly on offload->skb_irq_queue, could this lead to corrupted linked
list next/prev pointers or infinite loops during list traversal?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713085306.2643=
794-1-ciprianmarian.costea@oss.nxp.com?part=3D3

