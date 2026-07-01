Return-Path: <linux-can+bounces-7941-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W5pxFif4RGoI4QoAu9opvQ
	(envelope-from <linux-can+bounces-7941-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 13:21:11 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6CB6ECBC6
	for <lists+linux-can@lfdr.de>; Wed, 01 Jul 2026 13:21:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7941-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7941-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EF843036AED
	for <lists+linux-can@lfdr.de>; Wed,  1 Jul 2026 11:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F03E3FBB66;
	Wed,  1 Jul 2026 11:07:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C527E1C5;
	Wed,  1 Jul 2026 11:07:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904068; cv=none; b=TXm4E8s3VY/C6Kzpwt8WbJsCpMP/QV6hcccOGBQhM16CYjoFF3eTWJS675/yOW+4m6RYTsNaPymhR60AlzTnDZoqVIZLUFX2MuMQExtXy9L66AVQe3y7BcNbo2Ei11KPLbK2grInXPnpS+21lfFbbsxq/XGdev9ykcn2XurM4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904068; c=relaxed/simple;
	bh=9ycf7UENsfYVCVxKpQ0cuazaRGuTf4YFcNTUv0lSMO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peG/Lk8hYOfvUPYmuoWsYZeaiQnm7kWIP0ObZS5OtB0vuN4f0ZXPvFQdMmtpDY3r4AZLPKRwq+1VLwPEe7i2HGcwL5fjujzbnnC7WY+j4zYjUEuK9iRb1ecjTSMJPdKGXIO3PCkkecGsb3JjJuKEVbpQ16HUgA5PV2y1KOucz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 61568201975;
	Wed, 01 Jul 2026 13:07:38 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wesn4-005ZKD-0y;
	Wed, 01 Jul 2026 13:07:38 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F3D9255D58F;
	Wed, 01 Jul 2026 11:07:37 +0000 (UTC)
Date: Wed, 1 Jul 2026 13:07:37 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, 1579567540@qq.com, 
	Vincent Mailhol <mailhol@kernel.org>, kernel@pengutronix.de, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
Message-ID: <20260701-flashy-crocodile-of-flowers-a6a23e-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260701070128.2096267-1-1579567540@qq.com>
 <tencent_124D6134EB32480979234201E688087E5408@qq.com>
 <2064877.jZfb76A358@diego>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zddsmsw5y2ehct5y"
Content-Disposition: inline
In-Reply-To: <2064877.jZfb76A358@diego>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	TAGGED_FROM(0.00)[bounces-7941-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:heiko@sntech.de,m:linux-can@vger.kernel.org,m:1579567540@qq.com,m:mailhol@kernel.org,m:kernel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,qq.com,kernel.org,pengutronix.de,lists.infradead.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:url,pengutronix.de:from_mime,qq.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B6CB6ECBC6


--zddsmsw5y2ehct5y
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] can: rockchip: add RK3588 CAN-FD support
MIME-Version: 1.0

On 01.07.2026 11:55:39, Heiko St=C3=BCbner wrote:
> Hi,
>
> Am Mittwoch, 1. Juli 2026, 09:01:27 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb 1579567540@qq.com:
> > From: luch00 <1579567540@qq.com>
>
> please use a real name, not an alias.
>
>
> > Add support for the RK3588v2 CAN-FD controller by introducing a
> > dedicated model ID and OF match entry.
> >
> > The block is closely related to the existing RK3568 variants, but it
> > cannot reuse their match data unchanged. In particular, RK3588v2
> > encodes RX_FIFO_CNT in bits 7:5 instead of 6:4, so the RX path needs
> > SoC-specific handling.
> >
> > Validation on RK3588v2 also shows that its observed errata profile does
> > not fully match rk3568v2/rk3568v3, so keep a dedicated devtype for this
> > variant instead of relying on an rk3568 fallback.
>
> Funnily enough, we seem to have worked on the same topic
> at the same time :-)
>
> https://lore.kernel.org/lkml/20260630164336.3444550-1-heiko@sntech.de/
>
> > Signed-off-by: luch00 <1579567540@qq.com>
> > ---
> >  drivers/net/can/rockchip/rockchip_canfd-core.c | 14 ++++++++++++++
> >  drivers/net/can/rockchip/rockchip_canfd-rx.c   |  5 ++++-
> >  drivers/net/can/rockchip/rockchip_canfd.h      | 12 +++++++++++-
> >  3 files changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/n=
et/can/rockchip/rockchip_canfd-core.c
> > index 29de0c01e..3c2480785 100644
> > --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> > +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> > @@ -50,6 +50,15 @@ static const struct rkcanfd_devtype_data rkcanfd_dev=
type_data_rk3568v3 =3D {
> >  		RKCANFD_QUIRK_CANFD_BROKEN,
> >  };
> >
> > +/* Tests on the rk3588v2 reproduce Erratum 5, but not
> > + * Erratum 6 or the special CAN-FD frames that trigger Error Interrupts
> > + * on rk3568v2/rk3568v3.
> > + */
>
> Here I could reproduce erratum 6 though:
> https://lore.kernel.org/lkml/20260630164336.3444550-4-heiko@sntech.de/
>
>
> [...]
>
> > diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net=
/can/rockchip/rockchip_canfd-rx.c
> > index 475c0409e..fe64db373 100644
> > --- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
> > +++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
> > @@ -281,7 +281,10 @@ rkcanfd_rx_fifo_get_len(const struct rkcanfd_priv =
*priv)
> >  {
> >  	const u32 reg =3D rkcanfd_read(priv, RKCANFD_REG_RX_FIFO_CTRL);
> >
> > -	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT, reg);
> > +	if (priv->devtype_data.model =3D=3D RKCANFD_MODEL_RK3588V2)
> > +		return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3588, reg);
> > +
> > +	return FIELD_GET(RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3568, reg);
> >  }
> >
> >  int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv)
> > diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/ca=
n/rockchip/rockchip_canfd.h
> > index 93131c7d7..f6105b904 100644
> > --- a/drivers/net/can/rockchip/rockchip_canfd.h
> > +++ b/drivers/net/can/rockchip/rockchip_canfd.h
> > @@ -214,7 +214,8 @@
> >  #define RKCANFD_REG_TXEVENT_FIFO_CTRL_TXE_FIFO_ENABLE BIT(0)
> >
> >  #define RKCANFD_REG_RX_FIFO_CTRL 0x118
> > -#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT GENMASK(6, 4)
> > +#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3568 GENMASK(6, 4)
> > +#define RKCANFD_REG_RX_FIFO_CTRL_RX_FIFO_CNT_RK3588 GENMASK(7, 5)
>
> Oh, didn't see this when doing my variant of the support, so cool that you
> found this.

The "Rockchip RK3588 TRM V1.0-Part1-20220309.pdf" datasheet says bits
"7:5" are RX_FIFO_FRAME_CNT, while bit "6" is marked as reserved. =F0=9F=A4=
=B7

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zddsmsw5y2ehct5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCakT09wAKCRDMOmT6rpmt
0ptJAP0V1ggWlmdXB4K6fWYKfQM6O0/UiXoS8io2aIaPk936IQD/fJPILelVtYoR
mRtNCMATzYSF6Az4KXu0H6TsCNQvsww=
=9f9+
-----END PGP SIGNATURE-----

--zddsmsw5y2ehct5y--

