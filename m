Return-Path: <linux-can+bounces-1896-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963C39BCB35
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 12:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F345EB21025
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 11:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5761D1500;
	Tue,  5 Nov 2024 11:03:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A651CB53F
	for <linux-can@vger.kernel.org>; Tue,  5 Nov 2024 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804614; cv=none; b=SN8jEGHtL7UeZykCJufxgq26fROwuN+mPTMP5HtyRkGJq2DEj+0hjc+nzHTeUq51/NyOeQbfd9m6e4l2X50JrJoyzdEhTvO8qj410njeizWf8Uyw5qQNL87z0NoUIy6SwzGe3vSZxRHBbLpO6zAS3Pmly+g6E/iuB6gRGt580fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804614; c=relaxed/simple;
	bh=bxVePZQnmkLP886tFajV3kT7gGNa3ASjgAuLwzphQgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuaL2XyGKvMLLekYe6zHKY4PnBxH0KmeD0hK6i9VIGufbN1s+P4wfVMqUT+h3ScPGYA7dfKX+5hfZc9klGocU2daonbVFKUG87Vgbm5FScoScwUzp0p/AXT822Nt98opCdT6B3ACpMgRUtg9ocp3p0Q9dD3F+witTayipWVxpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t8HLN-0006ZU-3E; Tue, 05 Nov 2024 12:03:29 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t8HLM-002889-1g;
	Tue, 05 Nov 2024 12:03:28 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D480936A492;
	Tue, 05 Nov 2024 11:03:27 +0000 (UTC)
Date: Tue, 5 Nov 2024 12:03:27 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
	mailhol.vincent@wanadoo.fr, manivannan.sadhasivam@linaro.org, schuchmann@schleissheimer.de, 
	thomas.kopp@microchip.com
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
Message-ID: <20241105-masked-laughing-vulture-2e403e-mkl@pengutronix.de>
References: <20241104-ludicrous-quartz-kakapo-07219e-mkl@pengutronix.de>
 <20241105082801.32475-1-renjaya.zenta@formulatrix.com>
 <20241105-crazy-petrel-of-tempering-cb8f6f-mkl@pengutronix.de>
 <CAJ7t6HhXEMhpmLVh3E14iWZJ0wMaG2ECxYoe_xTYB9mXAdBd9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gs5b6ehessoot5vt"
Content-Disposition: inline
In-Reply-To: <CAJ7t6HhXEMhpmLVh3E14iWZJ0wMaG2ECxYoe_xTYB9mXAdBd9w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gs5b6ehessoot5vt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: AW: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len():
 fix length calculation
MIME-Version: 1.0

On 05.11.2024 17:20:39, Renjaya Raga Zenta wrote:
> File is attached.

Thanks. Hmmmm it looks correct to me. Are you sure, that you are
actually using the patch?

| ----------------------- FIFO  0 - TEF -----------------
|=20
| TEFSTA: tefsta(0x044)=3D0x00000007
|          TEFOVIF    		Transmit Event FIFO Overflow Interrupt Flag
|           TEFFIF   x		Transmit Event FIFO Full Interrupt Flag (0: not ful=
l)
|           TEFHIF   x		Transmit Event FIFO Half Full Interrupt Flag (0: < =
half full)
|          TEFNEIF   x		Transmit Event FIFO Not Empty Interrupt Flag (0: em=
pty)
|=20
| ----------------------- FIFO  3 - TX ------------------
|=20
| FIFOSTA: fifosta(0x078)=3D0x00000107
|           FIFOCI =3D   1		FIFO Message Index
|            TXABT    		Message Aborted Status (0: completed successfully, =
1: aborted)
|           TXLARB    		Message Lost Arbitration Status
|            TXERR    		Error Detected During Transmission
|           TXATIF    		Transmit Attempts Exhausted Interrupt Pending
|           RXOVIF    		Receive FIFO Overflow Interrupt Flag
|         TFERFFIF   x		Transmit/Receive FIFO Empty/Full Interrupt Flag
|         TFHRFHIF   x		Transmit/Receive FIFO Half Empty/Half Full Interrup=
t Flag
|         TFNRFNIF   x		Transmit/Receive FIFO Not Full/Not Empty Interrupt =
Flag

Please add this patch, compile, reproduce the issue, send me the
devcoredump and the log output.

--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -149,6 +149,10 @@ mcp251xfd_get_tef_len(struct mcp251xfd_priv *priv, u8 =
*len_p)
         len =3D (chip_tx_tail << shift) - (tail << shift);
         *len_p =3D len >> shift;
=20
+        if (*len_p =3D=3D 0)
+                netdev_err(priv->ndev, "%s: fifo_sta=3D0x%08x head=3D0x%08=
x tail=3D0x%08x\n", __func__,
+                           fifo_sta, tx_ring->head, tx_ring->tail);
+
         return 0;
 }

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gs5b6ehessoot5vt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcp+3wACgkQKDiiPnot
vG+XHAf+PFwYSuYG56xBMT5MWjhsaKQzA5dw0GB1OKh7wZsCVj3Ie4KPc1UsYma+
ntQjSO3aidVMnR3XTqHTDvl5wdSLbzpZ7N87DvutA4oLYC350g5fCi9gBqJVdABV
0kWOf0lxNpx7IYSlJtrydfXYyCCFBTZnJ8uI49RrtlwwYr+ghIVltmZbSHJhfvcH
+1Umn2w+cLmRIcyjjaOeb85ADWoS0S3qnuMfyaTU3sRcpQzz6i7N3mgCwvuqk8uV
livMHe5AMak40IMMv6suQMjAdSWr/S66/cAwc3NvPiLcVOScqxxuz4Rz/1T/5HZv
+tinzFshNehCGVyFkWAm1dmtiDq9lg==
=G+KI
-----END PGP SIGNATURE-----

--gs5b6ehessoot5vt--

