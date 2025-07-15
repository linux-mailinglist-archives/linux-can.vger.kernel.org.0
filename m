Return-Path: <linux-can+bounces-3988-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18373B056C6
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 11:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0737F166EB4
	for <lists+linux-can@lfdr.de>; Tue, 15 Jul 2025 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0FA2D8DB7;
	Tue, 15 Jul 2025 09:37:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD52D7810
	for <linux-can@vger.kernel.org>; Tue, 15 Jul 2025 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572241; cv=none; b=UreOWWLlq5wOFkqUVse/UH2dB4cpPoSlCGK3DXXXX4Rt+dVEYSmz02bLdea8guLLcO/yGK7KFaxQqoF+09zdkj1pMIbj7+zhXxsN+WU60P5UGxJfLLdN3tTHAGyyEhXkiD9ph8L/F9w8o1PQf4DDlUEPBHD98JFeQOgA8+K/SNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572241; c=relaxed/simple;
	bh=6NrFY5hFo7dm3+jpyDGSMoW1n7BKvGLblVZJQrMnbYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3li0GQS9iOa7/QFzkhpzP+4L8yz+VQNxOcohPjjjY41Z1uG3bwSeGA3T2BnMNGwZ66oJr9Lr5Xe4meB5IfrSbiz0QGNYZ8Zc7Cca5DZnZPzipnttm2XEWE1wRubaTIT0oNkf+IfxrD60Ha8234gEMse7tDOev/odFZUOsaRxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubc68-0001zb-Ma; Tue, 15 Jul 2025 11:37:16 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ubc68-008Yg7-1J;
	Tue, 15 Jul 2025 11:37:16 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 12703442282;
	Tue, 15 Jul 2025 09:37:16 +0000 (UTC)
Date: Tue, 15 Jul 2025 11:37:15 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andrei Lalaev <andrey.lalaev@gmail.com>
Cc: mailhol.vincent@wanadoo.fr, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [RFC PATCH] can: gs_usb: fix kernel oops during restart
Message-ID: <20250715-almond-zebra-of-perception-9d2e6c-mkl@pengutronix.de>
References: <20250714175520.307467-1-andrey.lalaev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n3pnp4ous3s7jckn"
Content-Disposition: inline
In-Reply-To: <20250714175520.307467-1-andrey.lalaev@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--n3pnp4ous3s7jckn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] can: gs_usb: fix kernel oops during restart
MIME-Version: 1.0

On 14.07.2025 19:55:02, Andrei Lalaev wrote:
> When CAN adapter in BUS_OFF state and "can_restart" is called,
> it causes the following kernel oops:

Doh!

I wonder why no one stumbled over this before. That's a systematic
problem for all CAN drivers that don't implement this callback.

What about this fix?

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 13826e8a707b..94603c9eb4aa 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -285,6 +285,12 @@ static int can_changelink(struct net_device *dev, stru=
ct nlattr *tb[],
         }
=20
         if (data[IFLA_CAN_RESTART_MS]) {
+                if (!priv->do_set_mode) {
+                        NL_SET_ERR_MSG(extack,
+                                       "device doesn't support restart fro=
m Bus Off");
+                        return -EOPNOTSUPP;
+                }
+
                 /* Do not allow changing restart delay while running */
                 if (dev->flags & IFF_UP)
                         return -EBUSY;
@@ -292,6 +298,12 @@ static int can_changelink(struct net_device *dev, stru=
ct nlattr *tb[],
         }
=20
         if (data[IFLA_CAN_RESTART]) {
+                if (!priv->do_set_mode) {
+                        NL_SET_ERR_MSG(extack,
+                                       "device doesn't support restart fro=
m Bus Off");
+                        return -EOPNOTSUPP;
+                }
+
                 /* Do not allow a restart while not running */
                 if (!(dev->flags & IFF_UP))
                         return -EINVAL;

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--n3pnp4ous3s7jckn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmh2IUcACgkQDHRl3/mQ
kZyJgwf+MXl3zNNKRds+eGQdMyyYPcR8AFTM/aKNLFwi7m3HHOzJA8dtmV7EerVg
b2seSwNRLubl9hcHKth+iws6gvsTTyqGGNn0pnTntv6b1zzPKWTnkdmp10hG9kDG
Ex9QgKfsI7/TsNvg/hOm1tlfBF+tafGPak8k8GMur3k9LE34rXcgsWlb2n20f0V9
ncd8bDZgVmka+fNEEI9MhoRJoraciiEYydtu/PBDC0q2YYUY1eALFSih4b9edegj
Y/hVXuhvTTDKaiW7EighKZJdPym0/4rp8K/DZ6bdR3V5OEOuWngi9cf1HYdVzP+4
WiBeZ6snOPfHkCPzuF27hpTxDSvbUg==
=3wB8
-----END PGP SIGNATURE-----

--n3pnp4ous3s7jckn--

