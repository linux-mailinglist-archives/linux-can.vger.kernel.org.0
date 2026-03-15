Return-Path: <linux-can+bounces-7085-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RojaKX/RtmmvJAEAu9opvQ
	(envelope-from <linux-can+bounces-7085-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 16:34:23 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4C7291324
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 16:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C012C300F188
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A819E18D658;
	Sun, 15 Mar 2026 15:34:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0284207A
	for <linux-can@vger.kernel.org>; Sun, 15 Mar 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773588858; cv=none; b=Ttf6QU0ITip7/3chJABrwcydBWZniW54+Iiu3C1IbauV0ObaP2mrXj+4K4lDMY3B6oEnQLskEmB81N/oGDQHFU0y0bJI+9IjJaWZiLkklTVCZJRfW8vrco633MChJHvb3yZFS1K+dIYJ5e44TBPo4aeqYhaKuSdYVpmGWa6oC84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773588858; c=relaxed/simple;
	bh=IMrD2+x/evpnnfMrjSyjiflndJfLy/7YWj439/+uhcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0WVGT2DMYjtqp9KdLg+e4TVxbWFdUU1aHtU/LBHoSVMMk/cNt1mNK9Zn3f6ByuMd2IlEJ0g182U55ARlNHq8MqwwtqEUerjDhGPOgnLc6s74r7KugzZwf4UCRUuBRHOPwSRi3klP99fB9wRi/d54WK7+KIGT+NjsYJV0WhXv7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w1nTd-0004hi-U6; Sun, 15 Mar 2026 16:34:01 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w1nTb-000QQx-1g;
	Sun, 15 Mar 2026 16:33:59 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3432D50448E;
	Sun, 15 Mar 2026 15:33:59 +0000 (UTC)
Date: Sun, 15 Mar 2026 16:33:58 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wenyuan Li <2063309626@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, gszhai@bjtu.edu.cn, 
	25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] V3-can: mcp251x: add error handling for power enable in
 open and resume
Message-ID: <20260315-courageous-authentic-junglefowl-a318d2-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <tencent_3DBF7B03B16695EA62EA19C742BDE2A6A805@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4nd7qfwaofe6mwa6"
Content-Disposition: inline
In-Reply-To: <tencent_3DBF7B03B16695EA62EA19C742BDE2A6A805@qq.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7085-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 0B4C7291324
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--4nd7qfwaofe6mwa6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] V3-can: mcp251x: add error handling for power enable in
 open and resume
MIME-Version: 1.0

Hello Wenyuan Li,

the patch looks almost perfect, good work! Some minor nitpicks inside.

A small tip for the v4, use "git send-email -v4", so that the "v4" goes
to the correct place in the subject. For you next patches have a look at
the great tool b4: https://b4.docs.kernel.org/en/latest/

On 15.03.2026 23:14:45, Wenyuan Li wrote:
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
>
> Add missing error handling for mcp251x_power_enable() calls in both
> mcp251x_open() and mcp251x_can_resume() functions.
>
> In mcp251x_open(), if power enable fails, jump to error path to close
> candev without attempting to disable power again.
>
> In mcp251x_can_resume(), properly check return values of power enable
> calls for both power and transceiver regulators. If any fails, return
> the error code to the PM framework and log the failure.
>
> This ensures the driver properly handles power control failures and
> maintains correct device state.
>
> Signed-off-by: Wenyuan Li <2063309626@qq.com>
> ---
>  drivers/net/can/spi/mcp251x.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index bb7782582f40..6e17133a4e03 100644
> --- a/drivers/net/can/spi/mcp251x.c
> +++ b/drivers/net/can/spi/mcp251x.c
> @@ -1225,7 +1225,11 @@ static int mcp251x_open(struct net_device *net)
>  	}
>
>  	mutex_lock(&priv->mcp_lock);
> -	mcp251x_power_enable(priv->transceiver, 1);
> +	ret =3D mcp251x_power_enable(priv->transceiver, 1);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to enable transceiver power: %pe\n", ERR_PT=
R(ret));
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
> @@ -1516,11 +1521,26 @@ static int __maybe_unused mcp251x_can_resume(stru=
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
> +	if (priv->after_suspend & AFTER_SUSPEND_POWER) {
> +		ret =3D mcp251x_power_enable(priv->power, 1);
> +		if (ret) {
> +			dev_err(dev, "Failed to restore power: %pe\n", ERR_PTR(ret));
> +			goto out;

As we don't do any cleanups you can do a "return ret;" instead of the
goto.

Please use "failed" or "Failed" consistently in the patch.

> +		}
> +	}
> +
> +	if (priv->after_suspend & AFTER_SUSPEND_UP) {
> +		ret =3D mcp251x_power_enable(priv->transceiver, 1);
> +		if (ret) {
> +			dev_err(dev, "Failed to restore transceiver power: %pe\n", ERR_PTR(re=
t));
> +			/* If the transceiver fails to be enabled, turn off the power that ha=
s been enabled.*/

IMHO that comment states the obvious, please remove.

> +			if (priv->after_suspend & AFTER_SUSPEND_POWER)
> +				mcp251x_power_enable(priv->power, 0);
> +			goto out;
> +		}
> +	}
>
>  	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
>  		queue_work(priv->wq, &priv->restart_work);
> @@ -1529,7 +1549,8 @@ static int __maybe_unused mcp251x_can_resume(struct=
 device *dev)
>
>  	priv->force_quit =3D 0;
>  	enable_irq(spi->irq);
> -	return 0;
> +out:
> +	return ret;
>  }
>
>  static SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--4nd7qfwaofe6mwa6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabbRZAAKCRDMOmT6rpmt
0iUvAP40be61qfFw/1cfJ0oH4xiVozb3eagoXCyF2+1GLzmszQD/Ul/buPfhBlYL
zPK6OoYpsZrZaeHupHwxWBJklEC9Xgg=
=HxPj
-----END PGP SIGNATURE-----

--4nd7qfwaofe6mwa6--

