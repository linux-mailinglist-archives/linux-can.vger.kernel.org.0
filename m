Return-Path: <linux-can+bounces-8063-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nMDzA47aTGrJqwEAu9opvQ
	(envelope-from <linux-can+bounces-8063-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:53:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F162D71AA85
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:53:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DIE7F4Bc;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8063-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8063-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D69FF30DC28B
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6C3E8353;
	Tue,  7 Jul 2026 10:30:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30B3E0223;
	Tue,  7 Jul 2026 10:30:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420244; cv=none; b=dvDbd1GzX0sejkM5xSlIlxvs+sZlEMuG9mR+pRRuyeDBcr3NdglLJtVBNJETyt8heSGoUk9B5hKHhb85fvmSm+kSn/vo3Zt312lT8qwu07O1BQIj8SmcVj5pU6o+yPW63Qk5gsbN1gWwcj/qyNd5rIEZbLvLQgpfPnuFMe5moZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420244; c=relaxed/simple;
	bh=Fh2562xFR+b06IGSG+Y7DjNpBurAZZCDNxPIXMo1afY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gSgs5IIlnTBRcpLCDUEJa7DN1h5bcB0KEI1DlmdJhQcUEX964FqAM4c/AKpkBE3DZJSL88kcAh5xJLGA7OHa7otnYmG+LCC0TKUhHfxdQO7xmJiLigXDhtoG6EvM7Gyg2+YqsPEstvWhp30VHE+eDitArjK7C7QeXU5Ob5RubeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIE7F4Bc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021DE1F000E9;
	Tue,  7 Jul 2026 10:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783420240;
	bh=S1/77vz/t24hjbhg9+zyUG6PBcvJkSVfavbNXHyn8UY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DIE7F4Bcigvhkseol1CH+AicaEkLL4dURZLPET9MQYlNr2AtWwUlVYZTVQdnd/iif
	 brJwS/PVdyOo/hShtLx3sxSU7DIuyRZoUELfd3F60/0nnMtyLdaj4RxApFV1snWgh3
	 E56SCW6vdZAxPDEMydoXD9NiGjb8zC/MmUc1pTPCo6C0Mz9xoEx6afyCWaRWMiaBiX
	 EZROQM1E7OFVaTcyaMWfGSybPxuA3M1eItYC66jXW3yrOId1HbPGonWgL7SvZqHdLl
	 QInUhDRAz8npuvF/yBnoqj0VZzjyTThI3MnvGkwDnUNX6CY558opXi0YCCVj5lXuTY
	 ecnzyjnpfxc3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, robh@kernel.org, conor+dt@kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260707102418.1646159-3-claudiu.beznea+renesas@tuxon.dev>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
 <20260707102418.1646159-3-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 10:30:39 +0000
Message-Id: <20260707103040.021DE1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8063-lists,linux-can=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea+renesas@tuxon.dev,m:mkl@pengutronix.de,m:robh@kernel.org,m:conor+dt@kernel.org,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:wsa+renesas@sang-engineering.com,m:socketcan@hartkopp.net,m:claudiu.beznea@tuxon.dev,m:conor@kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F162D71AA85

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The schema fails to forbid the `renesas,no-can-fd` and `renesas,=
fd-only` properties for the RZ/G3S (`renesas,r9a08g045-canfd`) SoC, allowin=
g unsupported hardware configurations to pass schema validation.
--

--- Patch [2]: [PATCH 2/8] dt-bindings: can: renesas,rcar-canfd: Document R=
Z/G3S SoC ---
commit fc07d92ff1acfa102fb8f08fa8b6ff1a0537c592
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC

This commit documents the CAN FD controller found on the Renesas RZ/G3S SoC.
It updates the bindings since the RZ/G3S provides only two channels, suppor=
ts
only CAN FD operation, and does not require assigned-clocks properties.

> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index b9d9dd7a79676..f8b4d3dd54afc 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml

[ ... ]

> @@ -350,6 +352,17 @@ allOf:
>        properties:
>          reset-names: false
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: renesas,r9a08g045-canfd
> +    then:
> +      required:
> +        - assigned-clocks
> +        - assigned-clock-rates
> +

[Severity: Medium]
Since the commit message states that the RZ/G3S supports only CAN FD operat=
ion,
should the schema also explicitly forbid the renesas,no-can-fd and
renesas,fd-only properties for the renesas,r9a08g045-canfd compatible?

Without an if-then block restricting these properties to false, the schema
will incorrectly validate device trees that specify these unsupported modes.

>  unevaluatedProperties: false
> =20
>  examples:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707102418.1646=
159-1-claudiu.beznea+renesas@tuxon.dev?part=3D2

