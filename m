Return-Path: <linux-can+bounces-8363-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XN6/DASrVGqIpAMAu9opvQ
	(envelope-from <linux-can+bounces-8363-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 11:08:20 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 245557491EF
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 11:08:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cX8x03Cb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8363-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8363-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D89E630013AA
	for <lists+linux-can@lfdr.de>; Mon, 13 Jul 2026 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEF63DD51D;
	Mon, 13 Jul 2026 09:07:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF583DC87B;
	Mon, 13 Jul 2026 09:07:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933627; cv=none; b=q2u8G0rTqxsUVAzsBrAGcsUTsvbFOFAu/pG315yXA4nDBWtfVpdaZntBpPpYSk9JEk1pH7xbjAPxotFaflaw33kVtehQb8jCF4oPkA+Yae6xQqpfIMpPgfaCYL/RgpW2hihzN99ieR4e3qLXp8M7S2JttsIl4vWiYB1TIqWYCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933627; c=relaxed/simple;
	bh=n0fopzEJDgafWJwnl40yoyqqaIfVImlLlNER9JEgabg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/NnPzO/6OR8E0KzJ3sOFZ2glNO9wKeVL0v1uWO6mF+da+5XU8Yn8eJTkC8wcksnd6X/7YDADvDVDPvvmvGHdab2JIV+mWT2XOtW3stvjPCRLhVVvcSTpMpq7uAtwhnqRwTWmlDa75SvIUA96tUW1IMRgCWaeHnR3v35MiXZVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cX8x03Cb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7671F000E9;
	Mon, 13 Jul 2026 09:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783933626;
	bh=j/4/GWm2mQ+EBWNv2DIOgwT1Fhljfr9slMv5bDH/jFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cX8x03CbWSr8biz2ae7QW1K2mikjRIAd6qpatzrdSo1TeXOsLmN4+KLK6y6ZIezai
	 U+p1rntzCCLw2HtGH46X6dheVRbG9rcy6CSzvtol7mmsZXy9acQvXEf/3ia6qj+0dg
	 5ETazTe2fD/WxtkcHqh9PYWKOJvkU8EeSMj7Jh0dbZi06OAjiSK+q6OQNkXOj35JCh
	 kTHx+hVavZB1p+WQ++xYeyFKMnGuJE+KKQfydV9Gg89b2Qrc60bAys5Xho5Nc/lXIn
	 C4AiWAvQ41flDvwqmXiDMjqptjgytc3U+HsXYhMHwFAEMoq545DVCGO3hQAEV2OezX
	 CPSukPoCeClWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] can: flexcan: disable all IRQ lines in
 flexcan_chip_interrupts_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: linux-can@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org, Frank.Li@kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, conor+dt@kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, devicetree@vger.kernel.org
In-Reply-To: <20260713085306.2643794-3-ciprianmarian.costea@oss.nxp.com>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-3-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 09:07:04 +0000
Message-Id: <20260713090705.9F7671F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8363-lists,linux-can=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ciprianmarian.costea@oss.nxp.com,m:linux-can@vger.kernel.org,m:imx@lists.linux.dev,m:robh@kernel.org,m:Frank.Li@kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:conor+dt@kernel.org,m:o.rempel@pengutronix.de,m:socketcan@hartkopp.net,m:devicetree@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:email,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 245557491EF

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] On multi-IRQ platforms, Wake-on-CAN is broken because `flexcan_sus=
pend` only arms the primary IRQ (`dev->irq`) for wakeup, completely ignorin=
g the state/BOFF interrupt (`priv->irq_boff`) which actually handles the wa=
keup event.
- [High] In `flexcan_resume`, the network queue is restarted (`netif_device=
_attach` and `netif_start_queue`) before the hardware is initialized (`flex=
can_chip_start`). This creates a race condition where a packet can be queue=
d for transmission just before the hardware undergoes a soft reset, leading=
 to a permanent TX stall.
--

--- Patch [2]: [PATCH v6 2/6] can: flexcan: disable all IRQ lines in flexca=
n_chip_interrupts_enable() ---
commit ca7ea75d45df1ecf13f11dcec0bd19377eccf3c6
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: flexcan: disable all IRQ lines in flexcan_chip_interrupts_enable()

flexcan_chip_interrupts_enable() disables only the primary IRQ line while
writing to the IMASK and CTRL registers. On multi-IRQ platforms, the
additional IRQ lines remain active so their handlers can fire while registe=
rs
are inconsistent. This commit disables all registered IRQ lines around the
IMASK/CTRL writes.

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index f73ff442d5304..7dde2e623defe 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1519,14 +1519,28 @@ static void flexcan_chip_interrupts_enable(const =
struct net_device *dev)
>  {
>  	const struct flexcan_priv *priv =3D netdev_priv(dev);
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	u32 quirks =3D priv->devtype_data.quirks;
>  	u64 reg_imask;
> =20
>  	disable_irq(dev->irq);
> +	if (quirks & FLEXCAN_QUIRK_NR_IRQ_3) {
> +		disable_irq(priv->irq_boff);

[Severity: High]
This is a pre-existing issue, but on multi-IRQ platforms, is Wake-on-CAN
broken because we only arm the primary IRQ during suspend?

In drivers/net/can/flexcan/flexcan-core.c:flexcan_suspend(), we see:

	if (device_may_wakeup(device)) {
		enable_irq_wake(dev->irq);
		err =3D flexcan_enter_stop_mode(priv);

Since the hardware asserts irq_boff (which handles FLEXCAN_ESR_WAK_INT) for
wakeup events, doesn't irq_boff need to be armed with enable_irq_wake() as
well? Otherwise, the system might fail to wake from suspend since the
interrupt controller won't treat the asserted IRQ line as a wakeup source.

[Severity: High]
This is also a pre-existing issue, but does flexcan_resume() restart the
network queue prematurely?

In drivers/net/can/flexcan/flexcan-core.c:flexcan_resume(), the queue is
restarted before hardware initialization:

	if (netif_running(dev)) {
		netif_device_attach(dev);
		netif_start_queue(dev);
		if (device_may_wakeup(device)) {
			...
		} else {
			...
			err =3D flexcan_chip_start(dev);

If netif_start_queue() is called before flexcan_chip_start() reinitializes
the hardware, could the networking stack concurrently call ndo_start_xmit
(flexcan_start_xmit) and queue a packet?

If so, would the subsequent flexcan_chip_start() soft reset wipe out the
freshly populated message buffers, aborting the transmission and leading to=
 a
permanent TX stall since the completion interrupt will never fire?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713085306.2643=
794-1-ciprianmarian.costea@oss.nxp.com?part=3D2

