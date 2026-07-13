Return-Path: <linux-can+bounces-8364-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fv0nBvCrVGrApAMAu9opvQ
	(envelope-from <linux-can+bounces-8364-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 11:12:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A58ED749274
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 11:12:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="PYXXy/fc";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8364-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8364-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC462300C5A0
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643913D647F;
	Mon, 13 Jul 2026 09:07:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1191D3D0914;
	Mon, 13 Jul 2026 09:07:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933669; cv=none; b=Te6uWfCGgCv0ytcc4JEos4Q54oY+4NitEGR/2hbHC4TZ00HU4h/whJQ82XVCN//cDYzpF4ikkjYfFo9A9FPMtrbssyAFW8Bmm6GRPtcw1RgeuMYxdNtXnlzLkTBHhDpSgv3tKsdrttzT/3fc6eV1S3OMjs7WqLlRlAI8z/h6CpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933669; c=relaxed/simple;
	bh=4Jm5jHY9f0eEv5jD7Jtroh2SqI2yb/WChCS9auOpBIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KHjFl5BEU5xe8Jrp0RvHA7s+0C5npZqeGyvg5O+bM/MTsz98L4MSEt4dPQU5SYNTuzROn6QmPQg1ntryul0W/dfKzrrcLyW0fu/gOoLidg6uhsuz0fnnuxTVlWF/u7BNHQMAacygUpd2bOJT1YO0PPedVjHixnnWblRRZUIynsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYXXy/fc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B4B1F000E9;
	Mon, 13 Jul 2026 09:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783933667;
	bh=2RbEjEqzpTIP27fCNXN28VXfMme6Uw3NP3qwKFizSq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYXXy/fc6p5JiAeerx/eh3Lcl8QDph2FZYGPFTmErSdlA7wuBNELQkME6nLuFBe5J
	 zXIJKMqGdU0t0G4P5qhSAO198mJwWashzJaHtrikG6osvCCtGcT1NxB49s5MwGn8YU
	 1ZNod95nz2YZEjC1aNS6sH7nY/c0mP0FDtizN0A3nSwVGOUwE29SAEJgQ3+Zf/EZSx
	 isxA1Ti/lRPOBOoEyoAPE1NDr95Cz9w9+xZoaltjpOOQIUm2kmGt+tDTWL5ZA0nmzy
	 He3zH2EpWHxrqsv0Q/1yaKz6zn8Qxr4ssWo4x74/cgcqlyvAfARTyv60Lig8w9XmCM
	 FpYQb6Cez7bCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] can: flexcan: use dedicated IRQ handlers for
 multi-IRQ platforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, devicetree@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, linux-can@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260713085306.2643794-2-ciprianmarian.costea@oss.nxp.com>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-2-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 09:07:46 +0000
Message-Id: <20260713090746.D2B4B1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8364-lists,linux-can=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ciprianmarian.costea@oss.nxp.com,m:mkl@pengutronix.de,m:devicetree@vger.kernel.org,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:linux-can@vger.kernel.org,m:robh@kernel.org,m:conor+dt@kernel.org,m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A58ED749274

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Splitting the IRQ handler breaks the FLEXCAN_QUIRK_BROKEN_PERR_STA=
TE workaround on multi-IRQ platforms.

Pre-existing issues:
- [Critical] Concurrent lockless modifications of `skb_irq_queue` by multip=
le IRQ handlers causes list corruption.
- [High] Incomplete fix for duplicate frame processing on platforms with se=
condary mailbox IRQs.
--

--- Patch [1]: [PATCH v6 1/6] can: flexcan: use dedicated IRQ handlers for =
multi-IRQ platforms ---
commit b6f6f5d373c333a28a06c2ed84ea386f9dc5b122
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: flexcan: use dedicated IRQ handlers for multi-IRQ platforms
   =20
On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
registered to the same flexcan_irq() handler. Since these are distinct IRQ
numbers, they can be dispatched concurrently on different CPUs. Both
instances then read the same iflag and ESR registers unconditionally,
leading to duplicate frame processing.

Fix this by splitting the monolithic handler into focused parts:
- flexcan_do_mb(): processes mailbox events
- flexcan_do_state(): processes device state change events
- flexcan_do_berr(): processes bus error events
   =20
Introduce dedicated IRQ handlers for multi-IRQ platforms:
- flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
- flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
- flexcan_irq_berr(): bus-error-only, used for berr IRQ line
   =20
The combined flexcan_irq() handler is preserved for single-IRQ
platforms with no functional change.

Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f5d22c61503fa..f73ff442d5304 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1188,6 +1218,65 @@ static irqreturn_t flexcan_irq(int irq, void *dev_=
id)
>  		}
>  	}
> =20
> +	return handled;
> +}
> +
> +/* Combined IRQ handler for single-IRQ platforms */
> +static irqreturn_t flexcan_irq(int irq, void *dev_id)
> +{
> +	struct net_device *dev =3D dev_id;
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	irqreturn_t handled;
> +
> +	handled =3D flexcan_do_mb(dev);
> +	handled |=3D flexcan_do_state(dev);
> +	handled |=3D flexcan_do_berr(dev);
> +
> +	if (handled)
> +		can_rx_offload_irq_finish(&priv->offload);
> +
> +	return handled;
> +}
> +
> +/* Mailbox IRQ handler for multi-IRQ platforms */
> +static irqreturn_t flexcan_irq_mb(int irq, void *dev_id)
> +{
> +	struct net_device *dev =3D dev_id;
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	irqreturn_t handled;
> +
> +	handled =3D flexcan_do_mb(dev);

[Severity: High]
Does isolating mailbox handling into flexcan_irq_mb() break the
FLEXCAN_QUIRK_BROKEN_PERR_STATE workaround?

On multi-IRQ platforms with this quirk (such as MCF5441X and S32G2), the
hardware fails to trigger a state change interrupt, meaning flexcan_irq_bof=
f()
won't fire. The baseline driver worked around this by polling the state via
flexcan_do_state() during every mailbox interrupt in the monolithic handler.

Since flexcan_irq_mb() completely bypasses flexcan_do_state(), could this c=
ause
the driver to silently miss CAN error state transitions (e.g., Error Passiv=
e)
when the error rate increases?

> +
> +	if (handled)
> +		can_rx_offload_irq_finish(&priv->offload);
> +
> +	return handled;
> +}
> +
> +/* Bus error IRQ handler for multi-IRQ platforms */
> +static irqreturn_t flexcan_irq_berr(int irq, void *dev_id)
> +{
> +	struct net_device *dev =3D dev_id;
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	irqreturn_t handled;
> +
> +	handled =3D flexcan_do_berr(dev);

[Severity: Critical]
This is a pre-existing issue, but does having dedicated IRQ handlers
running concurrently on different CPUs cause a race condition in the rx off=
load
framework?

If flexcan_irq_mb() and flexcan_irq_berr() fire simultaneously, both will
eventually call into the CAN rx offload framework (e.g., via
can_rx_offload_queue_timestamp()):

drivers/net/can/dev/rx-offload.c:can_rx_offload_queue_timestamp() {
    ...
    __skb_queue_add_sort(&offload->skb_irq_queue, skb,
                         can_rx_offload_compare);
    ...
}

Since __skb_queue_add_sort() locklessly modifies skb_irq_queue, could
concurrent execution of these handlers corrupt the sk_buff linked lists?

> +
> +	if (handled)
> +		can_rx_offload_irq_finish(&priv->offload);
> +
> +	return handled;
> +}
> +
> +/* Device state change IRQ handler for multi-IRQ platforms */
> +static irqreturn_t flexcan_irq_boff(int irq, void *dev_id)
> +{

[ ... ]

> @@ -1761,25 +1850,30 @@ static int flexcan_open(struct net_device *dev)
> =20
>  	can_rx_offload_enable(&priv->offload);
> =20
> -	err =3D request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
> +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_NR_IRQ_3)
> +		err =3D request_irq(dev->irq, flexcan_irq_mb,
> +				  IRQF_SHARED, dev->name, dev);
> +	else
> +		err =3D request_irq(dev->irq, flexcan_irq,
> +				  IRQF_SHARED, dev->name, dev);

[ ... ]

>  	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ) {
>  		err =3D request_irq(priv->irq_secondary_mb,
> -				  flexcan_irq, IRQF_SHARED, dev->name, dev);
> +				  flexcan_irq_mb, IRQF_SHARED, dev->name, dev);

[Severity: High]
This isn't a bug introduced by this patch, but does registering the same
flexcan_irq_mb() handler for both primary and secondary MB IRQ lines leave =
the
duplicate frame processing bug unfixed on platforms with secondary mailboxe=
s?

If both IRQ lines fire concurrently on S32G2, flexcan_irq_mb() is dispatche=
d to
both CPUs. Since flexcan_do_mb() doesn't check which IRQ line triggered it,
won't both CPUs unconditionally process all mailboxes, resulting in every
frame being processed twice?

>  		if (err)
>  			goto out_free_irq_err;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713085306.2643=
794-1-ciprianmarian.costea@oss.nxp.com?part=3D1

