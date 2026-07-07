Return-Path: <linux-can+bounces-8065-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6+XBN+nWTGqXqgEAu9opvQ
	(envelope-from <linux-can+bounces-8065-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:37:29 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E18571A78D
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:37:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mxV64MX4;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8065-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8065-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6DA93038A73
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD93E0C5C;
	Tue,  7 Jul 2026 10:33:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197213B47D0;
	Tue,  7 Jul 2026 10:33:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420411; cv=none; b=Y2VjY0zFq05UIjxt6ger9QZfSifL1aEe95GqakSFFfYqPy2yjsEeNcmZJIKSopzkogtHt+4tzvJ13YEi9/sLMAltE2Mu7Qr52QuGxVr4jlL5bKclxwJoY7aeYgt4rOoCU1OOMPsaAhDixJlZQrl4Z7bvTLWGjGaxrfN1XZLXyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420411; c=relaxed/simple;
	bh=1RcZfF8fA2kad4mum3yJyos1gfcKrxHYs1UO/DkzJMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NY/159yfx6d1Fde5yRKUqh6FJG0RokYx+ezd7704IVv3JwUolSXfqR98uYOLSne8psoH1W51P2Wir/Pj3JJX4Xkdla3vHlNZhpw9ZLY3JPy7Y8yPk6/0O49c8sycWkXbaO+saUVBovJqk49u5IFwR9q/9YzQC3zlKywEUhLu3JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxV64MX4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9561F00A3A;
	Tue,  7 Jul 2026 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420409;
	bh=XnC/zt2QZCOV500ok7D6tnGd+z8RbxANfyh2cvrGJOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxV64MX4xeZ8X0SZ1/Zx5bVizDwYi7GMGMzRqg7S1fWGznpIvTEbF4HsBskLMOGef
	 hnuirFgjlro2lOhWenZU/VvUDGiCZDe04e3ixTOfVip20h7Otohspsp61ZqWh2y6Fo
	 I+cqtcbb6EdbUdVZ8bmm3XfHixIbHA1D4OWfGjI9W3xO4JiSJ6kzX8LFSHd6x0w1H7
	 0vccY2rK9dVuUyTyXTtSlNZVMB9ykIbmJuuSP0shk3y4jEBWT3RqTIE0IJeKgaNcZh
	 gG44Uz5FeBRcvAg5SBfHOkwAdkZ9U0Rc8EfWkcY/lxKcekawTbpqvqXtPxugwAiecv
	 4s+RJQBGmNrVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, devicetree@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, conor+dt@kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, robh@kernel.org, linux-can@vger.kernel.org, wsa+renesas@sang-engineering.com, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260707102418.1646159-5-claudiu.beznea+renesas@tuxon.dev>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
 <20260707102418.1646159-5-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:33:28 +0000
Message-Id: <20260707103329.3E9561F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8065-lists,linux-can=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea+renesas@tuxon.dev,m:mailhol@kernel.org,m:devicetree@vger.kernel.org,m:o.rempel@pengutronix.de,m:conor+dt@kernel.org,m:mkl@pengutronix.de,m:robh@kernel.org,m:linux-can@vger.kernel.org,m:wsa+renesas@sang-engineering.com,m:socketcan@hartkopp.net,m:claudiu.beznea@tuxon.dev,m:conor@kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can,renesas,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,renesas.com:email,sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E18571A78D

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uninitialized variable usage when 'canfd' clock is missing on plat=
forms where 'fcan_pclk' is 0.
--

--- Patch [4]: [PATCH 4/8] can: rcar_canfd: Allow the CAN FD clock to be so=
urced from fck ---
commit 0fffa3e660d5596983dd22ee45ce4eb746f70520
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Allow the CAN FD clock to be sourced from fck

This commit adjusts the CAN FD clock handling in the R-Car CAN FD driver to
allow sourcing the clock from the peripheral clock (fck) for the RZ/G3S
platform, changing the "canfd" clock lookup to be optional.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wana=
doo.fr

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index b40ae5998c1da..6ec2d7a031238 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c

[ ... ]

> @@ -2190,13 +2196,18 @@ static int rcar_canfd_probe(struct platform_devic=
e *pdev)
>  	 */
>  	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
>  	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=3D 0)) {
> -		gpriv->can_clk =3D devm_clk_get(dev, "canfd");
> +		gpriv->can_clk =3D devm_clk_get_optional(dev, "canfd");
>  		if (IS_ERR(gpriv->can_clk))
>  			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
>  					     "cannot get canfd clock\n");
> =20
> +		if (gpriv->can_clk)
> +			fcan_freq =3D clk_get_rate(gpriv->can_clk);
> +		else if (info->fcan_pclk)
> +			fcan_freq =3D clk_get_rate(gpriv->clkp);
> +

[Severity: High]
Does this code leave fcan_freq uninitialized on legacy platforms if the dev=
ice
tree is missing the "canfd" clock?

Because devm_clk_get_optional() returns NULL when the clock is missing,
gpriv->can_clk will be NULL. On platforms where info->fcan_pclk is 0, both
conditions in this if/else block evaluate to false.

>  		/* CANFD clock may be further divided within the IP */
> -		fcan_freq =3D clk_get_rate(gpriv->can_clk) / info->postdiv;
> +		fcan_freq /=3D info->postdiv;

If fcan_freq is uninitialized here, it will divide random stack memory and =
pass
that downstream to configure CAN bus bit timings. Should there be an error
returned if neither clock source is available?

>  	} else {
>  		fcan_freq =3D clk_get_rate(gpriv->can_clk);
>  		gpriv->extclk =3D gpriv->info->external_clk;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707102418.1646=
159-1-claudiu.beznea+renesas@tuxon.dev?part=3D4

