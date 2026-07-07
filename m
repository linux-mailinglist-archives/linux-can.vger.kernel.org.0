Return-Path: <linux-can+bounces-8066-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Om+BLnXYTGobqwEAu9opvQ
	(envelope-from <linux-can+bounces-8066-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:44:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6476B71A912
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:44:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L2MkDtxc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8066-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8066-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0B5D3039A36
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8493ED135;
	Tue,  7 Jul 2026 10:34:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275F3D47DD;
	Tue,  7 Jul 2026 10:34:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420490; cv=none; b=Uzo/ex6NkbqZSiVV45OHow8ApVkmwjXVSpBc6FZCO6D5BFswdYd7FxZJxMfcbhyELDx4lB7QLHCclNoZVfi3CZGQdtGdqhCMric8Mq6Mk8UZuk+M07BEmy1OyUhSqAT33e9r+py/SPvGOUvRhq8leieVRO7RFODVsHdf6IBkOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420490; c=relaxed/simple;
	bh=IwV6giYEfzEjkAj1zP5cBNsJEQre6GJPdaV6jt9mISU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IK7oUdpFSpGz003HphD3SsdhNw3ccnIIMoCVIxx0A6Ecl1eawEbYB5H+GPyCJDv1KI0X0yc1G4HrG3Tm+u8pAhX4R5h/x0qTlc+eqQjls2nMhK5MRl4bNGwGfGofSMe+UAPjBCvJx3qz81qt86ZtIZclRQkzHQMtf6bu53lGJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2MkDtxc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C2D1F000E9;
	Tue,  7 Jul 2026 10:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420489;
	bh=cyJB2MIiJ2gaAoak0Kq14RiiqK9//DKMVx6unJcLtFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2MkDtxcOt+7FvX83FkLwmLWDGRTIG45y42Ord/A/I2Szb2hGJR/nqU+5lV/q333/
	 gy94suX51z2lLiYI63OA5cZ4WB8Cejg7RqeOn8n9MApgSB+o9RQqQiA1h7FrUuw7dX
	 G4fg5NbPwTcfOimQqR6ROXD1gz3gEGDpPc/bk1YwIJgby0IegSIm7ojY5Il5zqpSEL
	 wX7NbjSgOKBrvWSCM7zYtxzKFMflh5tVCIZKJzGG2tP4xX9Mb4UrVwgz3y25FDm8iT
	 NnuvlTkC2JqrJVJM4UcOZaIUUksNqdQyDtHzTLBVdiVKHzCJqeHEb8EyBb12kXmzZe
	 v5az3VPxwY8yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] clk: r9a08g045-cpg: Add clocks and resets for
 CAN-FD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: wsa+renesas@sang-engineering.com, "Vincent Mailhol" <mailhol@kernel.org>, robh@kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, devicetree@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, conor+dt@kernel.org
In-Reply-To: <20260707102418.1646159-2-claudiu.beznea+renesas@tuxon.dev>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
 <20260707102418.1646159-2-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:34:48 +0000
Message-Id: <20260707103448.A9C2D1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8066-lists,linux-can=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea+renesas@tuxon.dev,m:wsa+renesas@sang-engineering.com,m:mailhol@kernel.org,m:robh@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:devicetree@vger.kernel.org,m:socketcan@hartkopp.net,m:conor+dt@kernel.org,m:claudiu.beznea@tuxon.dev,m:wsa@sang-engineering.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,renesas,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:email,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6476B71A912

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The P4 core clock is registered using an internal enum ID instead =
of its Device Tree exported ID, rendering it inaccessible to DT consumers.
--

--- Patch [1]: [PATCH 1/8] clk: r9a08g045-cpg: Add clocks and resets for CA=
N-FD ---
commit 6c9b264ec67002e41ec321d8af3b04f800484a8a
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

clk: r9a08g045-cpg: Add clocks and resets for CAN-FD
   =20
Renesas RZ/G3S SoC has a CAN-FD IP. Add clocks and resets for it.

> diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9=
a08g045-cpg.c
> index 1232fec913eb5..34927d1ee4639 100644
> --- a/drivers/clk/renesas/r9a08g045-cpg.c
> +++ b/drivers/clk/renesas/r9a08g045-cpg.c
> @@ -88,6 +88,8 @@ enum clk_ids {
>  	CLK_SEL_PLL4,
>  	CLK_P1_DIV2,
>  	CLK_P3_DIV2,
> +	CLK_P4,

[Severity: High]
Should this clock be exported to the device tree instead of being added as =
an
internal enum?

Because CLK_P4 is defined after LAST_DT_CORE_CLK in clk_ids, it seems device
tree consumers requesting <&cpg CPG_CORE R9A08G045_CLK_P4> would fail to
probe with -ENOENT.

> +	CLK_P4_DIV2,
>  	CLK_SD0_DIV4,

[ ... ]

> @@ -182,6 +184,8 @@ static const struct cpg_core_clk r9a08g045_core_clks[=
] __initconst =3D {
>  		    dtable_1_32, 0, 0, 0, NULL),
>  	DEF_G3S_DIV("P3", R9A08G045_CLK_P3, CLK_PLL3_DIV2_4, DIVPL3C, G3S_DIVPL=
3C_STS,
>  		    dtable_1_32, 0, 0, 0, NULL),
> +	DEF_FIXED("P4", CLK_P4, CLK_PLL2_DIV2, 1, 5),

[Severity: High]
Looking at the surrounding definitions for P1, P2, P3, and P5 in
r9a08g045_core_clks, they all use their respective R9A08G045_CLK_* macros.

Does P4 need to be registered with the exported R9A08G045_CLK_P4 macro inst=
ead
of CLK_P4 to ensure the clock populates correctly at the intended device tr=
ee
index?

> +	DEF_FIXED("P4_DIV2", CLK_P4_DIV2, CLK_P4, 1, 2),
>  	DEF_FIXED("P3_DIV2", CLK_P3_DIV2, R9A08G045_CLK_P3, 1, 2),

[ ... ]

> @@ -285,6 +289,10 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks=
[] =3D {
>  					MSTOP(BUS_MCPU2, BIT(5))),
>  	DEF_MOD("scif5_clk_pck",	R9A08G045_SCIF5_CLK_PCK, R9A08G045_CLK_P0, 0x5=
84, 5,
>  					MSTOP(BUS_MCPU3, BIT(4))),
> +	DEF_MOD("canfd_pclk",		R9A08G045_CANFD_PCLK, CLK_P4_DIV2, 0x594, 0,
> +					MSTOP(BUS_MCPU2, BIT(9))),
> +	DEF_MOD("canfd_clk_ram",	R9A08G045_CANFD_CLK_RAM, CLK_P4, 0x594, 1,

[Severity: High]
If P4 is exported as R9A08G045_CLK_P4, should this module clock reference
the exported macro as its parent here in r9a08g045_mod_clks?

> +					MSTOP(BUS_MCPU2, BIT(9))),
>  	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707102418.1646=
159-1-claudiu.beznea+renesas@tuxon.dev?part=3D1

