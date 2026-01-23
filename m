Return-Path: <linux-can+bounces-6282-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCKRAmF/c2mQwwAAu9opvQ
	(envelope-from <linux-can+bounces-6282-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 15:02:09 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 572C676967
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 15:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C1D53056159
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CCC2BDC28;
	Fri, 23 Jan 2026 14:00:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617C3B1B3
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176819; cv=none; b=Z0FTInl2cPBCBn5l5ihwjrtJGpPapV7oX2CX0Vm39caB2Z+mLsN/jii6DNwf/rVZ5j4BwFR+O8KkvLuKwJrU6IdWZ0bet6ggQacg9vtOFAvBouEzNjsrAUaTECMPuSJPVyJdOb4MpwAGM5dJvKTLv8rfBJ0I9BCl5aUqkdOE5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176819; c=relaxed/simple;
	bh=JQzDr2wa459ee38VP0WagG9PEfEOEICCIZutSaELcdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1AHngEubZGiquHkDsSJcSKJMX0Y0frJgXeOhwTMNoUpqu7Ig/1DsL1ocQTyQStTMwCVFu5cifZdrNua3/tVagKsi5g7DmjTs+a9N1wVhEZ3VW8HJ7dJcpVxBxtTh09m8Vf6Po+sdDmlpzRgx3g+QQzmCLd08jwihiZbC/WOVPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjHhq-0000Er-GD; Fri, 23 Jan 2026 15:00:10 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjHhq-0026Ks-32;
	Fri, 23 Jan 2026 15:00:10 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F388E4D6F46;
	Fri, 23 Jan 2026 14:00:09 +0000 (UTC)
Date: Fri, 23 Jan 2026 15:00:09 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, Daniel Hellstrom <daniel@gaisler.com>
Subject: Re: [PATCH v3 10/15] can: grcan: Add saving and restoring of CAN FD
 baud-rate registers
Message-ID: <20260123-original-manipulative-bulldog-07cf38-mkl@pengutronix.de>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
 <20260122121038.7910-11-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hpwst4y3s5nxqy43"
Content-Disposition: inline
In-Reply-To: <20260122121038.7910-11-arun.muthusamy@gaisler.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6282-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Queue-Id: 572C676967
X-Rspamd-Action: no action


--hpwst4y3s5nxqy43
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 10/15] can: grcan: Add saving and restoring of CAN FD
 baud-rate registers
MIME-Version: 1.0

On 22.01.2026 13:10:33, Arun Muthusamy wrote:
> From: Daniel Hellstrom <daniel@gaisler.com>
>
> While reset the GRCAN baud-rates are preserved, since GRCANFD has the
> baud-rate in different registers we need to add saving of those
> registers too.
>
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  drivers/net/can/grcan.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index a2a5a5c868ff..0ee6e9bfbe7f 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -517,15 +517,27 @@ static void grcan_reset(struct net_device *dev)
>  	struct grcan_priv *priv =3D netdev_priv(dev);
>  	struct grcan_registers __iomem *regs =3D priv->regs;
>  	u32 config =3D grcan_read_reg(&regs->conf);
> +	u32 nbtr, fdbtr;
> +
> +	if (priv->hwcap->fd) {
> +		nbtr =3D grcan_read_reg(&regs->nbtr);

Why do you save nbtr....

> +		fdbtr =3D grcan_read_reg(&regs->fdbtr);

   Who writes fdbtr in the first place?

> +	}
>
>  	grcan_set_bits(&regs->ctrl, GRCAN_CTRL_RESET);
>  	grcan_write_reg(&regs->conf, config);
> +	if (priv->hwcap->fd) {
> +		grcan_write_reg(&regs->nbtr, nbtr);
> +		grcan_write_reg(&regs->fdbtr, fdbtr);
> +	}
>
>  	priv->eskbp =3D grcan_read_reg(&regs->txrd);
>  	priv->can.state =3D CAN_STATE_STOPPED;
>
>  	/* Turn off hardware filtering - regs->rxcode set to 0 by reset */
>  	grcan_write_reg(&regs->rxmask, 0);
> +
> +	priv->hwcap->set_bittiming(dev);

=2E..if you configure the bit timing again, wich writes nbtr?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hpwst4y3s5nxqy43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlzfuYACgkQDHRl3/mQ
kZyzNQf/X4KCwQqI/VabGEOY4xaS9oa6+oSnJ5T9lOIuS6LIQIHihzbbYzKibJo9
D0OUsin3vup4LbnxY6INn5Dc+dGMtv6L717TsL0ZHOiV/rcSSBAJxQjBGMbyckvO
DuVuWZ7GSa23RcL/sVSWzFTQAFkkcitkN7wrlEud/w1OJGjA/MHHwwGzWPZpLJ31
tQiUdyxF2dEn0HnttMohS7i3o8HhQ1fTxM02EyDlFWpbPU9qbu039O2/8JtLibMF
RMp4xoauSxNYktNo7T+wPPakbNW+c6ooIDdvc241tcfWy6XirlWawy1/E3VQtFFf
uFp+0O5ChzzzbnNkYA5KU7QL3W+X/w==
=HVpZ
-----END PGP SIGNATURE-----

--hpwst4y3s5nxqy43--

