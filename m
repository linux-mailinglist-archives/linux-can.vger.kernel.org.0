Return-Path: <linux-can+bounces-8453-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /k2nKAZ4VmpU6QAAu9opvQ
	(envelope-from <linux-can+bounces-8453-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:55:18 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0FF757A40
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:55:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=muU7WOqm;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8453-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8453-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE7D31D172D
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 17:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461FD426ED3;
	Tue, 14 Jul 2026 17:49:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E28417BD4;
	Tue, 14 Jul 2026 17:49:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051367; cv=none; b=eu0I+BDWfs9bQBWjKQlzVHN0/meNswwYipqr2vR4aa7SyyyzuJ0CgItPKQD/q+zIAZy+O8LDq8wj4HLwVtgpZGMyWTAGGQLzH2dXPP8i0ejU1vgkcpop/fRpkH9jBJd85rAabjSODwD74zhT5WDSiJPJvxMECQunAYhQftQrmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051367; c=relaxed/simple;
	bh=plBVf4Qq9Yx+9VN5ELVAES2tnouHE6PyguLQhz4RWKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fMqeFsDKIHwBEVWU+bkivemnxvOwrChphYk6gb7f1SiLLnVisGjbtItfLSazL1nNhRc7oraq0VZPeI10m+Ojswa5if7g8S479AQJzHLclKGFjBZMuN4QiJ5ntGGfBxz3jlBvoSdUxJoAjN2ph4UExarUp8x8TAh9BHruPexUIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muU7WOqm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC541F000E9;
	Tue, 14 Jul 2026 17:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784051353;
	bh=NI9NEGzerRHhMpTBhp+LeJd0IlviLPYWCght087UhOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=muU7WOqm5Z2WS7Oki9vYmzlkm+/DW2v2N/BToskZdA0vPf0rNUJZFIzkJrI1FRkBJ
	 XuGAAuHGcN6YpajifZcbG/uBLnjz5NkvPwbFwiPay07U8xL4+TkdZOg7+rchuqrCW8
	 tXnYQ0vQJOKvzpmnmW1nw1bTAwWNKmWkpQ95z4H81GtPFQBdXTmMUS4H6tkJzRQcHT
	 zhk5zeibFnXF733tiPF92kYkC5eAnrGhNMM25FaogtFJYvf0SKSzCazH0jYgq37fVi
	 5K4uWNvP7n/nnbSwFb0HXVDw0aNTr1GkzkB+cVnm1oVoxD+GHznTHqpGtv6DYi3nqW
	 cyHXCmLeoqdzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] can: rcar_canfd: Add support for Renesas RZ/G3S
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: conor+dt@kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, wsa+renesas@sang-engineering.com, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260714173315.1981708-7-claudiu.beznea+renesas@tuxon.dev>
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
 <20260714173315.1981708-7-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:49:12 +0000
Message-Id: <20260714174912.BBC541F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8453-lists,linux-can=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea+renesas@tuxon.dev,m:conor+dt@kernel.org,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:o.rempel@pengutronix.de,m:wsa+renesas@sang-engineering.com,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:claudiu.beznea@tuxon.dev,m:conor@kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email,lists.linux.dev:replyto,smtp.kernel.org:mid,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC0FF757A40

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Allowing 'renesas,no-can-fd' on hardware that does not support cla=
ssical CAN-only mode can cause RX FIFO corruption or unintended behavior.
--

--- Patch [6]: [PATCH v3 6/8] can: rcar_canfd: Add support for Renesas RZ/G=
3S ---
commit 72c4132759d04f40214ddc81cfa2c30db8c17906
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Add support for Renesas RZ/G3S

The Renesas RZ/G3S CAN-FD controller is largely compatible with the
variant found on the Renesas RZ/G3E. The RZ/G3S provides 16 AFL pages,
supports two channels, operates only in CAN-FD mode, and includes an
internal divider for the CAN FD clock source.

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 5cb6048d610e9..2eabe4a8be8dc 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -661,6 +661,26 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info=
 =3D {
>  	.mode_select_na =3D 0,
>  };
> =20
> +static const struct rcar_canfd_hw_info r9a08g045_hw_info =3D {
> +	.nom_bittiming =3D &rcar_canfd_gen4_nom_bittiming_const,
> +	.data_bittiming =3D &rcar_canfd_gen4_data_bittiming_const,
> +	.tdc_const =3D &rcar_canfd_gen4_tdc_const,
> +	.regs =3D &rcar_gen4_regs,
> +	.sh =3D &rcar_gen4_shift_data,
> +	.rnc_field_width =3D 16,
> +	.max_aflpn =3D 15,
> +	.max_cftml =3D 31,
> +	.max_channels =3D 2,
> +	.postdiv =3D 2,
> +	.shared_global_irqs =3D 0,
> +	.multi_channel_irqs =3D 1,
> +	.ch_interface_mode =3D 1,
> +	.shared_can_regs =3D 1,
> +	.external_clk =3D 1,
> +	.fcan_pclk =3D 1,
> +	.mode_select_na =3D 1,

[Severity: High]
Since this hardware does not implement mode select bits and operates
exclusively in CAN-FD mode, could it cause internal hardware FIFO RAM overf=
low
if a device tree is ported over with the renesas,no-can-fd property?

In rcar_canfd_probe(), the renesas,no-can-fd property unconditionally forces
gpriv->fdmode =3D false.

If gpriv->fdmode is false:
1. rcar_canfd_configure_controller() will skip setting RCANFD_GCFG_CMPOC
   which normally truncates oversized payloads.
2. rcar_canfd_configure_rx() will incorrectly configure the RX FIFO payload=
 size
   for 8 bytes (rfpls =3D 0).

Since the hardware is physically fixed in CAN-FD mode, would receiving a CA=
N-FD
frame larger than 8 bytes then write the full payload to the 8-byte FIFO sl=
ots
without truncation and corrupt memory?

> +};
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714173315.1981=
708-1-claudiu.beznea+renesas@tuxon.dev?part=3D6

