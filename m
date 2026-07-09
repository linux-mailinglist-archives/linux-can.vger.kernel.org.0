Return-Path: <linux-can+bounces-8239-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yHozD/XpT2q+qAIAu9opvQ
	(envelope-from <linux-can+bounces-8239-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:35:33 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D6B73451B
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:35:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JlyQdMR9;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8239-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-8239-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A06E2301AAB8
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 18:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E639A3B388A;
	Thu,  9 Jul 2026 18:35:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39C2DA75C;
	Thu,  9 Jul 2026 18:35:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622130; cv=none; b=rMTmi9XIaWzI2nMDis0cn9LSwelIdV36O22fk6C6QKEBOq7or0bFstr8YLuwZN/vGUWWFEaBJGfrzRAjPZhoxPX9mvSXuWZa76qG4Xsu+G68qIsriXCU9AJfi51kiH9jVt0m0FzNjFt/UNemiF61Ls5ecnLi6YIOvcPzvPlh9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622130; c=relaxed/simple;
	bh=bGfG1R9tGv1X9oJXk+3B01J3EtPcQKdVt5vrlOs3Mzg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HQBw+llZ7bXZbzZTWKDEgY8UZRNgDdhTGiCZizQc1frZVZJmdrO+vRnbYIcH4Ow//uNtjYMcDD+a2fnmbkIqWp+5R9SU1yGRClP6LGyARN6by0aJOxqWlIPoDGrCVHiZ2R64zCpL7O7W89MNeTJM2bgk+EcwDiqvh3C0ERAOixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlyQdMR9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCB81F000E9;
	Thu,  9 Jul 2026 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622129;
	bh=muZKBxbTDNcwDwKPshS+loxZreKpCDhK1Bft7STGHqg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JlyQdMR9Dg10Ny40XsRF3Ut3qnA55AXuVCKWzSySwJ9T+yhPWjbHPGxrtNedG6x6a
	 GBRDlZY/oCCpR8ID4OHumxNYbEHhnx8Mq6S6xnqQHPYYpVNz53PkoYX0IguRRVohPQ
	 PK8djsefnEZbNTCBepfGCv4zHv4cm1MXo1kTlpyVQ63dAPVdDVUdQTzK3DPzRMs15c
	 EU1OfcsmjR8Mtpz52eyh4KUucM/sBfDRkYTV/YqO5j7FrE0x7cGbUo2txF2OXS3cEJ
	 zJhq0QjU8XL8L59GHFpuE98D34+clDStbW40eIagR23tVaZe9D6E9UvMxzoBu6dR8e
	 ayZmFpmULST/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, wsa+renesas@sang-engineering.com, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260709182332.876408-5-claudiu.beznea+renesas@tuxon.dev>
References: <20260709182332.876408-1-claudiu.beznea+renesas@tuxon.dev>
 <20260709182332.876408-5-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:35:28 +0000
Message-Id: <20260709183528.ACCB81F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8239-lists,linux-can=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea+renesas@tuxon.dev,m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:wsa+renesas@sang-engineering.com,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:mailhol@kernel.org,m:claudiu.beznea@tuxon.dev,m:wsa@sang-engineering.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can,renesas,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94D6B73451B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unhandled ERR_PTR dereference leading to kernel panic in clock API.

Pre-existing issues:
- [High] Use-After-Free and Double Free on probe error path.
--

--- Patch [4]: [PATCH v2 4/8] can: rcar_canfd: Allow the CAN FD clock to be=
 sourced from fck ---
commit 4210af3a91e163ec149ddcdedbbe130decc7d427
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Allow the CAN FD clock to be sourced from fck

Adjust the existing canfd clock handling code to support the RZ/G3S CAN.
When fck is used, it is divided internally by the CAN FD controller.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wana=
doo.fr

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index b40ae5998c1da..0283620ebcf8d 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
[ ... ]
> @@ -2190,13 +2196,19 @@ static int rcar_canfd_probe(struct platform_devic=
e *pdev)
>  	 */
>  	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
>  	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=3D 0)) {
> -		gpriv->can_clk =3D devm_clk_get(dev, "canfd");
> -		if (IS_ERR(gpriv->can_clk))
> -			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> -					     "cannot get canfd clock\n");
> +		if (info->fcan_pclk) {
> +			fcan_freq =3D clk_get_rate(gpriv->clkp);
> +		} else {

[Severity: High]
If info->fcan_pclk is true and can_clk is not present, gpriv->can_clk
retains an ERR_PTR value here.

When the interface is brought up later, rcar_canfd_open() calls
clk_prepare_enable(gpriv->can_clk):

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_open() {
    ...
	/* Peripheral clock is already enabled in probe */
	err =3D clk_prepare_enable(gpriv->can_clk);
	if (err) {
    ...
}

Because clk_prepare_enable() checks for NULL but not for IS_ERR(), will
this dereference the error pointer and cause a kernel panic? Should
gpriv->can_clk be explicitly set to NULL when using the fcan_pclk fallback?

> +			gpriv->can_clk =3D devm_clk_get(dev, "canfd");
> +			if (IS_ERR(gpriv->can_clk))
> +				return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> +						     "cannot get canfd clock\n");
> +
> +			fcan_freq =3D clk_get_rate(gpriv->can_clk);
> +		}
> =20
>  		/* CANFD clock may be further divided within the IP */
> -		fcan_freq =3D clk_get_rate(gpriv->can_clk) / info->postdiv;
> +		fcan_freq /=3D info->postdiv;
>  	} else {
>  		fcan_freq =3D clk_get_rate(gpriv->can_clk);
>  		gpriv->extclk =3D gpriv->info->external_clk;

[Severity: High]
This is a pre-existing issue, but there is a use-after-free and double
free on the probe error path.

In rcar_canfd_channel_probe():

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_channel_probe() {
    ...
	gpriv->ch[priv->channel] =3D priv;
	err =3D register_candev(ndev);
	if (err) {
		dev_err(dev, "register_candev() failed: %pe\n", ERR_PTR(err));
		goto fail_candev;
	}
    ...
fail_candev:
	netif_napi_del(&priv->napi);
fail:
	free_candev(ndev);
	return err;
}

If register_candev() fails, ndev (which contains priv) is freed via
free_candev(), but the global pointer gpriv->ch[priv->channel] is not
cleared.

Then in the parent rcar_canfd_probe(), the error handler cleans up:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_probe() {
    ...
fail_channel:
	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
		rcar_canfd_channel_remove(gpriv, ch);
    ...
}

And rcar_canfd_channel_remove() bypasses the NULL check:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_channel_remove() {
	struct rcar_canfd_channel *priv =3D gpriv->ch[ch];

	if (priv) {
		unregister_candev(priv->ndev);
		netif_napi_del(&priv->napi);
		free_candev(priv->ndev);
	}
}

Will this cause unregister_candev() to be called on an already freed device,
followed by a second free_candev()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709182332.8764=
08-1-claudiu.beznea+renesas@tuxon.dev?part=3D4

