Return-Path: <linux-can+bounces-7083-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Jn+HrDAtmkWHwEAu9opvQ
	(envelope-from <linux-can+bounces-7083-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 15:22:40 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E61290FED
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 15:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B74B83009CCE
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92CD365A0D;
	Sun, 15 Mar 2026 14:22:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE0A33A9CA
	for <linux-can@vger.kernel.org>; Sun, 15 Mar 2026 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584556; cv=none; b=FYv7GmiHDgTNiPyyXy+gLijKTr6m5r+K9HiPqbUVjdFDF3UepKJaUz/XBf5hsODQsCtaluu42l42YawxftKs9BoAaIHkkiAzw+UAUcjjUQadVA3bSAGoVpwg5zeJ+ueEl6bRAm5bT0teWBy9eSzgZMIJaLPtqrPKwx+C3q6fC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584556; c=relaxed/simple;
	bh=ZWZT+NB69hs8wptJKWxSWHtp0zhV7ycS4FwC1Y91Wzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idZEhqN6+dZpFCYXjtWjRT7HRZMLod/yqCTt1n33fYqh85MTwMQzxTvQtBmct/QY3QYBxnjwpfIhD8xjmKIHzVs1PeYj8Hh7jf+fEs+UrybrVi7JTXOi0omLMni2p636hfWz82aEzyFDYJsRWL11p+sn8n9RjXClS0xVUcVDH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w1mLu-0008CV-Es; Sun, 15 Mar 2026 15:21:58 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w1mLo-000Q1K-2Q;
	Sun, 15 Mar 2026 15:21:52 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5BA3C504443;
	Sun, 15 Mar 2026 14:21:52 +0000 (UTC)
Date: Sun, 15 Mar 2026 15:21:50 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wenyuan Li <2063309626@qq.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Maud Spierings <maudspierings@gocontroll.com>, 
	Marco Crivellari <marco.crivellari@suse.com>, Alban Bedel <alban.bedel@lht.dlh.de>, gszhai@bjtu.edu.cn, 
	25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: mcp251x: add error handling for power enable in
 open and resume
Message-ID: <20260315-precious-misty-ibis-60c4df-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <tencent_C4EC82E859C642A082A288BBDB0D9179D505@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l6h6ihakysfrehop"
Content-Disposition: inline
In-Reply-To: <tencent_C4EC82E859C642A082A288BBDB0D9179D505@qq.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-7083-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-can];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url,qq.com:email]
X-Rspamd-Queue-Id: C2E61290FED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--l6h6ihakysfrehop
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: mcp251x: add error handling for power enable in
 open and resume
MIME-Version: 1.0

Hello nyuan Li,

thanks for sending the v2.

On 15.03.2026 21:24:51, Wenyuan Li wrote:
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
>  drivers/net/can/spi/mcp251x.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
> index bb7782582f40..28324eed1303 100644
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

As there can be 2 regulators, I think it's better to print which one was
failing. What about: "failed to enable transceiver power".

Please use "%pe" and "ERR_PTR(ret)" to print the error value, this way
it's translated into human readable text.

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
> +	if (priv->after_suspend & AFTER_SUSPEND_POWER) {
> +		ret =3D mcp251x_power_enable(priv->power, 1);
> +		if (ret) {
> +			dev_err(dev, "Failed to restore power: %d\n", ret);

use %pe here, too.

> +			goto out;
> +		}
> +	}
> +
> +	if (priv->after_suspend & AFTER_SUSPEND_UP) {
> +		ret =3D mcp251x_power_enable(priv->transceiver, 1);
> +		if (ret) {
> +			dev_err(dev, "Failed to restore power: %d\n", ret);

"failed to restore transceiver power"

use %pe here, too.

Do we want to power down the "priv->power" regulator? in case of an
error?

> +			goto out;
> +		}
> +	}
>
>  	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
>  		queue_work(priv->wq, &priv->restart_work);
> @@ -1529,7 +1546,8 @@ static int __maybe_unused mcp251x_can_resume(struct=
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
> --
> 2.43.0
>
>

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--l6h6ihakysfrehop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabbAfAAKCRDMOmT6rpmt
0nlJAP0Ud+ZR0DILD0ZFNg2+NCucAIpMR7yvGdvucxhEfYTKEQEA/LmRSs46k3Eh
ogvvTAqRPn9yE2oSDhVDP2vDlmWq2AU=
=1sGS
-----END PGP SIGNATURE-----

--l6h6ihakysfrehop--

