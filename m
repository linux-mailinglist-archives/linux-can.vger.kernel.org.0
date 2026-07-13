Return-Path: <linux-can+bounces-8367-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cbTkHL6tVGpOpQMAu9opvQ
	(envelope-from <linux-can+bounces-8367-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 11:19:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2606D749398
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 11:19:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L1aSuhNZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8367-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8367-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DDF33013456
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064B13DEAEC;
	Mon, 13 Jul 2026 09:19:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B213D0914;
	Mon, 13 Jul 2026 09:19:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934392; cv=none; b=fqiTi3cizPmTlkIh3lcBWqx4CyVANpTXHklhOuW997m/OnUPvohrhbGH7agazeJGVNUmcjslP5ssyXv1Xi7riYMR50rjkMRtzRqvkT1+f9QxqqgR9SsI8GsLaMm1NQ+USjc32ti7BtZrRzopltoRDoDo0vVgOhuhWLjj4PxsY0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934392; c=relaxed/simple;
	bh=ouTRcIFjz+QYZNuSX6uuuPwKcabd7zspmQIFbqeA7Rs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X1yZxMscnvF0osZtzcLS+S3IkXij4AttVe/MAeXMTB0Sto5mQwggf51tpbxOTWlU+CKpfPr1bSEosIpE0NucdQ6ssuSYkrZIWW3WjsPQXZiFQifU/mWD4J7jkTQw9GD53OKJXOY7xb21W5CqgVgPnvQGJ1JRPKgjGjURR0rAj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1aSuhNZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047A01F00A3A;
	Mon, 13 Jul 2026 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783934391;
	bh=b80d1FGTgriFwEBTyhkzxIjSntfSE9mLoTvcQaX991I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L1aSuhNZA9IZ78B8MXNOSqdtXdo50nqUqs8DtmOUNUlI7H4S+6tBA265drxJPFssa
	 fvB1LZqx+LmHoIAtVC1byWB+r6D3nOSnjKseQ/fITyP/vMIZ3XptJHHdj1XX5mmD7+
	 y7vmuTBHVYjXBW6HLjwgDMH5fndi6u/evZq4DfhohwuvWwK4bXPGQ7BSFBrl3EPIUL
	 GKdraD47xhl0IanmUr7NVcJlWNo+XaHIi5hDP1DsSXoi4Q1bu6KDWSNk7Kwo8HGH+S
	 i2NSZq9TOPUXPs8/NGEz2KsM5dV07zlhPRjCp7uJw7Gg1WFqeoM1T43m80T3DocX2n
	 UDHajYThuYSng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, robh@kernel.org, imx@lists.linux.dev, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260713085306.2643794-6-ciprianmarian.costea@oss.nxp.com>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-6-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 09:19:50 +0000
Message-Id: <20260713091951.047A01F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8367-lists,linux-can=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ciprianmarian.costea@oss.nxp.com,m:o.rempel@pengutronix.de,m:robh@kernel.org,m:imx@lists.linux.dev,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:conor+dt@kernel.org,m:Frank.Li@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2606D749398

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of separate hardware interrupt handlers (`dev=
->irq` and `priv->irq_err`) modifies the lockless `can_rx_offload` IRQ queu=
e (`skb_irq_queue`), leading to list corruption.
--

--- Patch [5]: [PATCH v6 5/6] can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quir=
k ---
commit 97d482f1edd202225930276cf268822cd49ea3d2
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: flexcan: add FLEXCAN_QUIRK_IRQ_BERR quirk

Introduce FLEXCAN_QUIRK_IRQ_BERR quirk to handle hardware integration
where the FlexCAN module has a dedicated interrupt line for signaling
bus errors and device state changes. This adds the flexcan_irq_esr() handler
and is required for NXP S32N79 SoC support.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index 8b70952f7f05d..e7e3fb41f55e7 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1300,6 +1300,22 @@ static irqreturn_t flexcan_irq_boff(int irq, void =
*dev_id)
>  	return handled;
>  }
> =20
> +/* Combined bus error and state change IRQ handler */
> +static irqreturn_t flexcan_irq_esr(int irq, void *dev_id)
> +{
> +	struct net_device *dev =3D dev_id;
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	irqreturn_t handled;
> +
> +	handled =3D flexcan_do_state(dev);
> +	handled |=3D flexcan_do_berr(dev);
> +
> +	if (handled)
> +		can_rx_offload_irq_finish(&priv->offload);
> +
> +	return handled;
> +}

[Severity: High]
This is a pre-existing issue, but could this lead to list corruption
if these separate IRQs run concurrently on different CPUs?

Since flexcan_irq_esr() and flexcan_irq_mb() are registered as separate
interrupts, they might fire at the same time. If flexcan_irq_esr()
processes a bus error and flexcan_irq_mb() processes a mailbox interrupt,
they both end up modifying the lockless offload->skb_irq_queue.

CPU1 handling dev->irq (flexcan_irq_mb):
flexcan_irq_mb()
  can_rx_offload_irq_offload_timestamp()
    __skb_queue_add_sort(&offload->skb_irq_queue, ...)

CPU2 handling priv->irq_err (flexcan_irq_esr):
flexcan_irq_esr()
  flexcan_do_berr()
    flexcan_irq_bus_err()
      can_rx_offload_queue_timestamp()
        __skb_queue_add_sort(&offload->skb_irq_queue, ...)

Furthermore, both handlers unconditionally call can_rx_offload_irq_finish(),
which locklessly splices the skb_irq_queue list:

can_rx_offload_irq_finish()
  skb_queue_splice_tail_init(&offload->skb_irq_queue, ...)

Are there existing synchronization mechanisms preventing these IRQ
handlers from running simultaneously and corrupting the lockless
skb_irq_queue list pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713085306.2643=
794-1-ciprianmarian.costea@oss.nxp.com?part=3D5

