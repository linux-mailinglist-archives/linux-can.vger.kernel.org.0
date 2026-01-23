Return-Path: <linux-can+bounces-6280-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PgcBlB7c2kfwAAAu9opvQ
	(envelope-from <linux-can+bounces-6280-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 14:44:48 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3B2766FE
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 14:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59F463004065
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6FE23505E;
	Fri, 23 Jan 2026 13:44:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E83246F4
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175883; cv=none; b=HnzLCEgrY+NBPyMEEhfDhaCnWYoZ7MBEDjn81LJL62pSeuqXKlllJdX4zXezfwj28JqonTeiujXt1LZJ1IQQa4/awnH47iwS5ZInCZRub3KSZtojr+ZBp1ECTRF7x1xt7ZCaXXlSs8KCmCrucwhyd6AWHsR+sFc7lU/ayeooNp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175883; c=relaxed/simple;
	bh=kXysKOuSXdnuQ1oT4fbzzSZVGff2tfGJWUdMZuKhUBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKvfpVlnGsTMC1H900ysvbqZAa8KfRT6j8f2adAXX7iY3LfLOgt0oDytB1wKZey0iSjq17bvV1zT4Wf2OT96jRelcgLuXFaAImvdjBqlLWEA/Gp3lc1wXFVVpygcO9CRbYX18ubPcR8nKwh1arp98jQm9saaTkuu3YsrKk7/pOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjHSi-00071s-Ah; Fri, 23 Jan 2026 14:44:32 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjHSi-0026JT-1u;
	Fri, 23 Jan 2026 14:44:31 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8FB064D6F18;
	Fri, 23 Jan 2026 13:44:31 +0000 (UTC)
Date: Fri, 23 Jan 2026 14:44:31 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, Daniel Hellstrom <daniel@gaisler.com>
Subject: Re: [PATCH v3 04/15] can: grcan: Add clock handling
Message-ID: <20260123-astonishing-swine-from-mars-0f9b52-mkl@pengutronix.de>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
 <20260122121038.7910-5-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g6vecznlvgkopda7"
Content-Disposition: inline
In-Reply-To: <20260122121038.7910-5-arun.muthusamy@gaisler.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6280-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E3B2766FE
X-Rspamd-Action: no action


--g6vecznlvgkopda7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 04/15] can: grcan: Add clock handling
MIME-Version: 1.0

On 22.01.2026 13:10:27, Arun Muthusamy wrote:
> From: Daniel Hellstrom <daniel@gaisler.com>
>
> Add clock handling and add error messages for missing 'freq' DT property.
>
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  drivers/net/can/grcan.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index 3b1b09943436..538a9b4f82ab 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -34,7 +34,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> -
> +#include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>
>  #define DRV_NAME	"grcan"
> @@ -1644,6 +1644,7 @@ static int grcan_probe(struct platform_device *ofde=
v)
>  {
>  	struct device_node *np =3D ofdev->dev.of_node;
>  	struct device_node *sysid_parent;
> +	struct clk *clk;
>  	u32 sysid, ambafreq;
>  	int irq, err;
>  	void __iomem *base;
> @@ -1663,8 +1664,20 @@ static int grcan_probe(struct platform_device *ofd=
ev)
>
>  	err =3D of_property_read_u32(np, "freq", &ambafreq);
>  	if (err) {
> -		dev_err(&ofdev->dev, "unable to fetch \"freq\" property\n");
> -		goto exit_error;
> +		clk =3D devm_clk_get(&ofdev->dev, NULL);
> +		if (IS_ERR(clk)) {
> +			dev_err_probe(&ofdev->dev, PTR_ERR(clk),
> +				      "Failed both to get \"freq\" property and clock for fallback\n=
");
> +			err =3D PTR_ERR(clk);
> +			goto exit_error;
> +		}

I think devm_clk_get() either returns an error pointer or a valid clock
pointer.

> +		if (clk) {
> +			ambafreq =3D clk_get_rate(clk);
> +			if (!ambafreq) {
> +				dev_err(&ofdev->dev, "Invalid or Uninitialized clock\n");
> +				return -EINVAL;
> +			}
> +		}
>  	}
>
>  	base =3D devm_platform_ioremap_resource(ofdev, 0);

Marc
--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g6vecznlvgkopda7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlzezwACgkQDHRl3/mQ
kZzq+wf8C7aI/cFdFNry0LAJ6039g6wEzdPuNv9U5YL9DQzNMza7W91pdTeIa+c5
+7OchDdJGWVAouJerMTdwFq5syjBxyRWDttDteYp7XWNqA5IJ7GKPCEPeaZJ1PnO
vC7x1GvAQiEwz+y8qd4+xLWM9Dl6EqDkaxhJZn1plF/VSrZPUP/wKI9vD6oJ+DnP
0M7Vp/Rx4GozmNhwi77ZpwFdxL5SmCnzusEJO+yFGTt/yinRPe5bkpmOdzAEoqXX
bdNZ171ottvAnUrXypAiHDhXNcjRGHk2OcE2VybiBOTM/K4NfKsK1EqeGCH+t4RG
3vL0miJ71P9LIUBqeRtJ7ZJkxrfJ7w==
=CUJU
-----END PGP SIGNATURE-----

--g6vecznlvgkopda7--

