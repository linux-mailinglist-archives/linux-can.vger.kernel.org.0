Return-Path: <linux-can+bounces-5755-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9214C904A4
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 23:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF5A3A6894
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 22:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47A231282D;
	Thu, 27 Nov 2025 22:22:30 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42890286419
	for <linux-can@vger.kernel.org>; Thu, 27 Nov 2025 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764282150; cv=none; b=B11qzDUYWQGkim5hGhO0aEan1jDA+J2xeOyn1FCZ3tjEKpEG4yvQNOf/cl5BAOOuepCo+2JijhtF8P5eflFb6a6WVnLYnv7HP7kfOWP77LVhSZY32Q0ip6queZgJW35Sf1iL4eTaERJ3mFAtKsAFCt9/ODmIDPMq1ZadzLzig5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764282150; c=relaxed/simple;
	bh=zZg8C2i3kVT+TP0viHZwxBloXL5RAwOhRLKDe4iqW7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEC9GTmgsEOnwk/pCMIpX2iFJ3GjE5+OKVDUgiBqMWJs6mYDPrr1sGDqCOavbhOH0sc+A8p4F/dR5wNUUNaQcJgOOgchoB452ephAo7yeolpuO7vrJAC8IKPY3BrKXXnK2F/0QT3FRY2w1TEVflfmPvdhvB36MOXHvnQZYTxL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOkNX-0005sL-Pl; Thu, 27 Nov 2025 23:22:19 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOkNW-002rEo-1z;
	Thu, 27 Nov 2025 23:22:18 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 06A084A9DE8;
	Thu, 27 Nov 2025 22:22:17 +0000 (UTC)
Date: Thu, 27 Nov 2025 23:22:15 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [net-next] can: raw: fix build without CONFIG_CAN_DEV
Message-ID: <20251127-inquisitive-vegan-boobook-abac0e-mkl@pengutronix.de>
References: <20251127210710.25800-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ncd5olu4mnzgg5gn"
Content-Disposition: inline
In-Reply-To: <20251127210710.25800-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ncd5olu4mnzgg5gn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [net-next] can: raw: fix build without CONFIG_CAN_DEV
MIME-Version: 1.0

On 27.11.2025 22:07:10, Oliver Hartkopp wrote:
> The feature to instantly reject unsupported CAN frames makes use of CAN
> netdevice specific flags which are only accessible when the CAN device
> driver infrastructure is built.
>
> Therefore check for CONFIG_CAN_DEV and fall back to MTU testing when the
> CAN device driver infrastructure is absent.
>
> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> Reported-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

That's not sufficient. We can build the CAN_DEV as a module but compile
CAN_RAW into the kernel.

This patch does the same as your's but only with a single ifdef in the
header file.

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 52c8be5c160e..14d58461430e 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -111,7 +111,14 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, u=
nsigned int echo_skb_max,
 void free_candev(struct net_device *dev);

 /* a candev safe wrapper around netdev_priv */
+#ifdef CONFIG_CAN_DEV
 struct can_priv *safe_candev_priv(struct net_device *dev);
+#else
+static inline struct can_priv *safe_candev_priv(struct net_device *dev)
+{
+        return NULL;
+}
+#endif

 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ncd5olu4mnzgg5gn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkozwsACgkQDHRl3/mQ
kZz5lgf+Mqt9tOViMSNRUNowAl/pm+ZzDqhWNCg8ONmdVGxkvR5NasY8GVgN2dqo
Ly/IDEr+l3hVmTH7/2Pn+hHvDRJRrvxSKZog/jJgLwsXybnzk2tvaFkiPg5IkTsX
mLA+OmNp8Ewjm+FaoSuZrdZcfYpdO48Fu6L6hQ9P3oC9Kg3zdffDi0QDlFSmLiLs
4A2LeW3A9e3s8wejBbPwmAAujevJEhPe528zwPd3ymRO7ZqZZWj2/x+i7Gc7AVVB
aufvwIP+4jdL5FIbkxNXLthTj0WbBjoKmDmreG0y+1Zy02yfwB61tvwPoF+peWZB
YgGCT8dceK5OodSEqw+jjkjifWDCfg==
=gDSF
-----END PGP SIGNATURE-----

--ncd5olu4mnzgg5gn--

