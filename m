Return-Path: <linux-can+bounces-7075-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF2UJGNvsml9MgAAu9opvQ
	(envelope-from <linux-can+bounces-7075-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2026 08:46:43 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5E526E6A4
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2026 08:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EF75305FFC3
	for <lists+linux-can@lfdr.de>; Thu, 12 Mar 2026 07:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4515A282F0E;
	Thu, 12 Mar 2026 07:46:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2532C1586
	for <linux-can@vger.kernel.org>; Thu, 12 Mar 2026 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301598; cv=none; b=TSM/Mj9ejSFBwwYT11VLErTPAeBY0+24F3HVf4I2Yi3I5vzPiioNalgf1RjTf6Pp2kQVsyzckgC3WqIRA2jhb1n2GhslceQovfNRqxJo0wTy0MUrLUE5Ztr0Za8iBQNKAgRFegCQQanwMPIza4jbyyZYlQUbrEmJgh6fkyeggIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301598; c=relaxed/simple;
	bh=QsqfHo0TjAf2bpTJBzauvugCtIqJg55gJNK+IVInp1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXCw1Y59ILB3eSdwk5mIUFGUNw3j9f4HKyS1e2DEB1a3PxwzTvoersRi1MwDfGXqg8EBGgCFMYOqwO0yhiwPoq9SEGb8gjQ0gOMsNLxBIhNbVrB1hnR2TYh0ugDxJNDROJMZ/FrnJ+uW7uegrR8oyb8xMaqenvhQg0hK7k9/Pms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w0akJ-0008MA-S3; Thu, 12 Mar 2026 08:46:15 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w0akA-004zDk-1W;
	Thu, 12 Mar 2026 08:46:07 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 72DDB4FF6C4;
	Thu, 12 Mar 2026 07:46:07 +0000 (UTC)
Date: Thu, 12 Mar 2026 08:46:06 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wenyuan Li <2063309626@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Maud Spierings <maudspierings@gocontroll.com>, 
	Marco Crivellari <marco.crivellari@suse.com>, Alban Bedel <alban.bedel@lht.dlh.de>, gszhai@bjtu.edu.cn, 
	25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: mcp251x: add error handling for power enable in
 open and resume
Message-ID: <20260312-peridot-galago-of-painting-7d6e1c-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <tencent_6A462B2C8A50BA55116D560D2FFE9EED2D09@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7j7ck7jovbtksuf"
Content-Disposition: inline
In-Reply-To: <tencent_6A462B2C8A50BA55116D560D2FFE9EED2D09@qq.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-7075-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:email,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: EC5E526E6A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--f7j7ck7jovbtksuf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: mcp251x: add error handling for power enable in
 open and resume
MIME-Version: 1.0

On 11.03.2026 23:50:53, Wenyuan Li wrote:
> Add missing error handling for mcp251x_power_enable() calls in both
> mcp251x_open() and mcp251x_can_resume() functions.
>
> In mcp251x_open(), if power enable fails, the driver should not continue
> with device initialization. Add proper error checking and jump to
> existing out_close label.
>
> In mcp251x_can_resume(), if power enable fails during system resume,
> propagate the error to PM framework and log the error with dev_err()
> for debugging.
>
> This ensures the driver properly handles power control failures and
> maintains correct device state.
> Signed-off-by: Wenyuan Li <2063309626@qq.com>
> ---
>  drivers/net/can/spi/mcp251x.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index bb7782582f40..807293a7857f 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -1225,7 +1225,11 @@ static int mcp251x_open(struct net_device *net)
>  	}
>
>  	mutex_lock(&priv->mcp_lock);
> -	mcp251x_power_enable(priv->transceiver, 1);
> +	ret =3D mcp251x_power_enable(priv->transceiver, 1);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to enable power: %d\n", ret);
> +		goto out_close_candev;
> +	}
>
>  	priv->force_quit =3D 0;
>  	priv->tx_skb =3D NULL;
> @@ -1272,6 +1276,7 @@ static int mcp251x_open(struct net_device *net)
>  	mcp251x_hw_sleep(spi);
>  out_close:
>  	mcp251x_power_enable(priv->transceiver, 0);
> +out_close_candev:
>  	close_candev(net);
>  	mutex_unlock(&priv->mcp_lock);
>  	if (release_irq)
> @@ -1516,11 +1521,23 @@ static int __maybe_unused mcp251x_can_resume(stru=
ct device *dev)
>  {
>  	struct spi_device *spi =3D to_spi_device(dev);
>  	struct mcp251x_priv *priv =3D spi_get_drvdata(spi);
> +	int ret =3D 0;
>
> -	if (priv->after_suspend & AFTER_SUSPEND_POWER)
> -		mcp251x_power_enable(priv->power, 1);
> -	if (priv->after_suspend & AFTER_SUSPEND_UP)
> -		mcp251x_power_enable(priv->transceiver, 1);
                                           ^^^^^^^^^^^

The original code enables the "transceiver"

> +	if (priv->after_suspend & AFTER_SUSPEND_POWER) {
> +		ret =3D mcp251x_power_enable(priv->power, 1);
> +		if (ret) {
> +			dev_err(dev, "Failed to restore power: %d\n", ret);
> +			goto out;
> +		}
> +	}
> +
> +	if (priv->after_suspend & AFTER_SUSPEND_UP) {
> +		ret =3D mcp251x_power_enable(priv->power, 1);
                                                 ^^^^^

You enable the "power".

> +		if (ret) {
> +			dev_err(dev, "Failed to restore power: %d\n", ret);
> +			goto out;
> +		}
> +	}
>
>  	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
>  		queue_work(priv->wq, &priv->restart_work);
> @@ -1529,6 +1546,7 @@ static int __maybe_unused mcp251x_can_resume(struct=
 device *dev)
>
>  	priv->force_quit =3D 0;
>  	enable_irq(spi->irq);
> +out:
>  	return 0;

Do you want to return "ret" instead of "0"?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--f7j7ck7jovbtksuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabJvOwAKCRDMOmT6rpmt
0vNTAQDvd5W8J6NM3ZrP8wXpliyodzyS8EaLzpsY3heNbAgL9wD+Kiune13U8QRg
d2X1vVupF9JzerVav5f2AmhGquiK2AE=
=Y67K
-----END PGP SIGNATURE-----

--f7j7ck7jovbtksuf--

