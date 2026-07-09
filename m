Return-Path: <linux-can+bounces-8242-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nuK3MNnqT2rrqAIAu9opvQ
	(envelope-from <linux-can+bounces-8242-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:39:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BB9734586
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:39:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Wfyy23KB;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8242-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8242-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5D7A300680B
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DEA3CB2F0;
	Thu,  9 Jul 2026 18:39:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6552727E2;
	Thu,  9 Jul 2026 18:39:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622355; cv=none; b=Z0k1KzZTdxlY/b3H5ZFN8Frw90cOjmPwBo6CnWV7axW2M8/XtUkdQISfzgEcuXskIsJoS/Tve4pBUBClOOp4WKuYOP79eOLejcX/PeTWNHlEOIsYgbZbvRWv3MNt8g3c00YUktzGnRg+UyKPBJJJlDWF79GagrHGhFVZ5J8EIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622355; c=relaxed/simple;
	bh=kthlNggLV8cjKugeNVz1xcqh3SrQj5D/p+kYszwI4MM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xa5zVdsvvZPjN6sAnQgMLkFlqnlcIx2P/AxLts3HHxrv53z/NdfnKzlJWJY+1bXy905jcsnCnRbTMNrofONI3i5IwUSU+FhKFY8Tntu9w5Pi4Qb3n5NjtbvH5/MV8auvvOf4ZmsEKS16BCDMTwiT63GAbv3cql3TQA5E2r9n2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wfyy23KB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE70A1F000E9;
	Thu,  9 Jul 2026 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622353;
	bh=RR4O13mvpaMveVVYQSVUe7t3bKIa3fr3WN6LbjYV3/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wfyy23KB8pvYP5uyEtb9KSFeR0L6rzXsCByO4M1nID1FQ1knI/Io/t4fKb4THYPw9
	 Tm8Q9ASqA373hETpSfnV1owuZB9MBjouZ0M1ZVgleoLMIlCXZ7CZmkXcD0m0XniJWa
	 2+L1Wne02ISyDG+TbEFBsS1955wNK5lJ8XQVPohu0NMxvimuohoWg7haJqUtQQP4Tp
	 /qa6jTbhlD+UmZ8Y+udeHyASFX2rxUmmy9ooOpbMSvnCwhJqjvg/BhofsWHAIg7pSb
	 qtAUfrYDT7oGskS3ZFRvN72KOLCTxIBbGUIiQW6Uns7dsUY2b/jVbwfX+es7Waz5Yu
	 Hyh60pt6QiJPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] can: rcar_canfd: Add support for Renesas RZ/G3S
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea+renesas@tuxon.dev>
Cc: conor+dt@kernel.org, robh@kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260709182332.876408-7-claudiu.beznea+renesas@tuxon.dev>
References: <20260709182332.876408-1-claudiu.beznea+renesas@tuxon.dev>
 <20260709182332.876408-7-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:39:12 +0000
Message-Id: <20260709183912.DE70A1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8242-lists,linux-can=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea+renesas@tuxon.dev,m:conor+dt@kernel.org,m:robh@kernel.org,m:mkl@pengutronix.de,m:devicetree@vger.kernel.org,m:wsa+renesas@sang-engineering.com,m:o.rempel@pengutronix.de,m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:claudiu.beznea@tuxon.dev,m:conor@kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,renesas.com:email,smtp.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4BB9734586

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The `max_aflpn` field is incorrectly configured to 127, modeling 20=
48 acceptance filter rules instead of the hardware's 128 rules.

Pre-existing issues:
- [High] Silent data truncation of received CAN FD frames when the interfac=
e is configured in Classical CAN mode.
--

--- Patch [6]: [PATCH v2 6/8] can: rcar_canfd: Add support for Renesas RZ/G=
3S ---
commit dd7ffbc8ce8271e811932ba34aecef0183db4270
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

can: rcar_canfd: Add support for Renesas RZ/G3S

The Renesas RZ/G3S CAN-FD controller is largely compatible with the
variant found on the Renesas RZ/G3E. The main differences are:
- the RZ/G3S provides 128 acceptance filters
- the RZ/G3S supports only two channels
- the RZ/G3S supports only CAN-FD operation and does not implement the
  bits used to select between classical CAN-only and CAN FD-only modes.
- the RZ/G3S includes an internal divider that allows the peripheral
  clock to be used as the CAN FD clock source.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 22f87491cd913..e74b72e60272e 100644
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
> +	.max_aflpn =3D 127,

[Severity: Low]
Is this max_aflpn value correct for the RZ/G3S hardware?

The commit message mentions the RZ/G3S provides 128 acceptance filters.
Setting max_aflpn to 127 configures a mask for up to 128 pages (2048 rules).

Should this mask be 7 (for 8 pages / 128 filters) to match the hardware
specification?

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
This is a pre-existing issue, but does adding a controller with=20
mode_select_na =3D 1 expose a silent data truncation issue?

If a user requests Classical CAN mode via the DT property renesas,no-can-fd,
the controller will still receive FD frames because mode_select_na prevents
hardware-level Classical CAN mode on this SoC.

When a CAN FD frame is received, rcar_canfd_rx_pkt() checks the ctrlmode:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_rx_pkt() {
    if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) &&
        sts & RCANFD_RFFDSTS_RFFDF)
        skb =3D alloc_canfd_skb(ndev, &cf);
    else
        skb =3D alloc_can_skb(ndev, (struct can_frame **)&cf);
    ...
}

Since CAN_CTRLMODE_FD is disabled, it allocates a Classical CAN skb instead
of dropping the unsupported FD frame. It then truncates the DLC and copies
up to 8 bytes:

drivers/net/can/rcar/rcar_canfd.c:rcar_canfd_rx_pkt() {
    ...
    } else {
        cf->len =3D can_cc_dlc2len(RCANFD_RFPTR_RFDLC(dlc));
        if (id & RCANFD_RFID_RFRTR)
            cf->can_id |=3D CAN_RTR_FLAG;
        else if (gpriv->info->shared_can_regs)
            rcar_canfd_get_data(priv, cf, RCANFD_F_RFDF(gpriv, ridx, 0));
    ...
}

Can this cause an FD frame to be silently truncated and passed to userspace
as a valid Classical CAN frame?

> +};
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709182332.8764=
08-1-claudiu.beznea+renesas@tuxon.dev?part=3D6

