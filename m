Return-Path: <linux-can+bounces-8452-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id woSkI9R2Vmq+6AAAu9opvQ
	(envelope-from <linux-can+bounces-8452-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:50:12 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A037579CF
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:50:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=INCOpQZz;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8452-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8452-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BC733148A80
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996FD426ED3;
	Tue, 14 Jul 2026 17:47:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E7340A4D;
	Tue, 14 Jul 2026 17:47:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051262; cv=none; b=csNpGseaIEYEeiG06l9+AxeFS7uRP5C/1HI6ZSShDbReMn8xjVut62hRbgjr3XrKssIO2fVjez9uah0ovr3VH6GEGu26uUmqygp2MWLdV/+ziYYzcq1+6LfYXmlaWcwYsPYTqjvB4gwpJAgPqA3xPw5YD2gyBM3vS+SDn/afark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051262; c=relaxed/simple;
	bh=VKzHFOo3L1rWY7OCoN0w8hIbefwu3sydU3DcF9u8Uec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TYnd8Eldy78GyTkIGbSlqWJG1OUrOHNXVrNDxfZ+MJsYxyryAF2/cXpmCKnQOA0fvNePbplFkff9uvm+Lr2AYq3040Gr4htP14bVhzukTcfyoL4IpJhy0pyZVdpjuStiukgWqomKkIBpyem+W45y5sR43gqBoDn6Vmy69VXOZcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INCOpQZz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2141F000E9;
	Tue, 14 Jul 2026 17:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784051255;
	bh=s2rvJEOJkcdhlc3Ed/XLSln1jRgH9LJfXcV1/XDZmH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=INCOpQZzokMsVm+UH6Stq6lFYeuLLtXxXQ7IkFrzqtDMwDOznywkSzVw+jV1WKZHS
	 G1GY3j0fEfPE7i1MsCLXM3oXu3bz3SBnuXYBZsWXTEnk6ckWpAFzcm4f5A57Sp8ZyU
	 aJH9iRharcE5Tm8Lh4y5fWTbuIUvYOe/svs3B/CBu+mOxNLWf3dczCxT153eYeXiaK
	 qCibc9+iBuzKyFOH3WsCUsnho7M2vU1qt/8qCZbPTZauBzivjPGqXaZ/JI9QmZJOV+
	 A1KnJi5PUSYYOFpl6pe5RmQlBtQtkGDal5j3T47P1KxdPCVjJjGeHIt+4pop3ECsrh
	 VjCK57D7eWPUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: robh@kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, devicetree@vger.kernel.org, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, wsa+renesas@sang-engineering.com, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, conor+dt@kernel.org
In-Reply-To: <20260714173315.1981708-5-claudiu.beznea+renesas@tuxon.dev>
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
 <20260714173315.1981708-5-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:47:34 +0000
Message-Id: <20260714174734.7A2141F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8452-lists,linux-can=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea+renesas@tuxon.dev,m:robh@kernel.org,m:mailhol@kernel.org,m:devicetree@vger.kernel.org,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,m:wsa+renesas@sang-engineering.com,m:o.rempel@pengutronix.de,m:conor+dt@kernel.org,m:claudiu.beznea@tuxon.dev,m:wsa@sang-engineering.com,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,renesas.com:email,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7A037579CF

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver ignores `-EPROBE_DEFER` when acquiring the optional `ca=
n_clk`, leading to an incorrect clock source fallback or spurious probe fai=
lures.
- [High] Double free of `ndev` and UAF via `unregister_candev` if `register=
_candev` fails during channel probe.
- [High] Unbalanced clock disable and reset assert when `rcar_canfd_global_=
init` fails.
--

--- Patch [4]: [PATCH v3 4/8] can: rcar_canfd: Allow the CAN FD clock to be=
 sourced from fck ---
commit a52a5e318c0ad2d299e214595e95da5df928f319
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Allow the CAN FD clock to be sourced from fck

This commit adjusts the clock handling in the RZ/G3S CAN FD driver to allow
the clock to be sourced from the peripheral clock instead of an external
clock. It also updates existing hardware info structures to support this.

Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wana=
doo.fr

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index b40ae5998c1da..2e84dc5dfa34d 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
[ ... ]
> @@ -2190,13 +2196,20 @@ static int rcar_canfd_probe(struct platform_devic=
e *pdev)
>  	 */
>  	gpriv->can_clk =3D devm_clk_get(dev, "can_clk");
>  	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) =3D=3D 0)) {
> -		gpriv->can_clk =3D devm_clk_get(dev, "canfd");
> -		if (IS_ERR(gpriv->can_clk))
> -			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> -					     "cannot get canfd clock\n");
> +		if (info->fcan_pclk) {

[Severity: High]
This is a pre-existing issue, but the driver appears to ignore -EPROBE_DEFER
when acquiring the optional can_clk.

If can_clk is defined in the device tree but its provider has not yet probe=
d,
devm_clk_get() returns -EPROBE_DEFER. Because the driver checks IS_ERR() and
blindly coalesces all errors into the fallback path, platforms with fcan_pc=
lk
will silently fall back to the peripheral clock instead of deferring the pr=
obe.

Could this cause the CAN controller to run on the wrong clock, resulting in
invalid CAN baud rates? Should devm_clk_get_optional() be used here to
correctly propagate -EPROBE_DEFER?

> +			fcan_freq =3D clk_get_rate(gpriv->clkp);
> +			gpriv->can_clk =3D NULL;
> +		} else {
> +			gpriv->can_clk =3D devm_clk_get(dev, "canfd");
> +			if (IS_ERR(gpriv->can_clk))
> +				return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
> +						     "cannot get canfd clock\n");
> +
> +			fcan_freq =3D clk_get_rate(gpriv->can_clk);
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a double=
 free
and use-after-free risk during channel probe failure.

In rcar_canfd_channel_probe(), the channel pointer is assigned before calli=
ng
register_candev():

	gpriv->ch[priv->channel] =3D priv;
	err =3D register_candev(ndev);
	if (err) {
		...
		goto fail_candev;
	}

If register_candev() fails, the error path frees ndev (which embeds priv) v=
ia
free_candev(ndev), but leaves the dangling pointer in gpriv->ch.

When this error propagates back to rcar_canfd_probe(), the cleanup loop cal=
ls
rcar_canfd_channel_remove() for all channels:

	struct rcar_canfd_channel *priv =3D gpriv->ch[ch];
	if (priv) {
		unregister_candev(priv->ndev);
		netif_napi_del(&priv->napi);
		free_candev(priv->ndev);
	}

Will this dereference the dangling pointer, incorrectly call unregister_can=
dev()
on invalid memory, and double-free ndev?

[Severity: High]
This is a pre-existing issue, but there seems to be an unbalanced clock dis=
able
and reset assert when rcar_canfd_global_init() fails.

Inside rcar_canfd_global_init(), if an initialization step fails, the error
path correctly cleans up:

fail_ram_clk:
	clk_disable_unprepare(gpriv->clk_ram);
fail_clk:
	clk_disable_unprepare(gpriv->clkp);
fail_reset2:
	reset_control_assert(gpriv->rstc2);
fail_reset1:
	reset_control_assert(gpriv->rstc1);
	return err;

However, the error then propagates back to rcar_canfd_probe(), which jumps
to fail_mode and blindly calls rcar_canfd_global_deinit():

fail_mode:
	rcar_canfd_global_deinit(gpriv, false);

Since rcar_canfd_global_deinit() disables the exact same clocks and asserts
the exact same resets again, could this result in an unbalanced clock disab=
le
(enable count underflow) and trigger kernel warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714173315.1981=
708-1-claudiu.beznea+renesas@tuxon.dev?part=3D4

