Return-Path: <linux-can+bounces-5446-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A3AC61818
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 17:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8D974E89EE
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 16:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FFE29E0E5;
	Sun, 16 Nov 2025 16:06:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C44C22756A
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763309195; cv=none; b=RbpOHB2U4AlWCExtZAV0e1/1D7A+rb4UGx24DDHoWOEu7FDAKfjx5FJJAJ0tbE9zQKSD8HIMLVazVPMZk2uIVRqjlKQlWxJVU9eho3EAo9AihO0+om03+RIhFx1AA7GVhEu9fqAR1ukhJhj14vM3Z9+D/1C4bGETNF1FfW7MIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763309195; c=relaxed/simple;
	bh=XeaTCk6RhFVEzSy69JHS2VWwY815EcoJ4pxGhnHH8rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9SdsZXpxk30+hSfmbD4/YOQ8Hpv6YL0LOkTZSNQpU6ePWl3sGWfOChXcc+L2/AbH3xJZqDUW7jMRzAtXODKdIUeLWNirFreB0gibVF03H+W3NFplhKVH5huL3yOu3Qw2kCyzqelwQ44TEEH9pvERHXoYmsehs5lD2wtiQB2vmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKfGl-0007JH-UK; Sun, 16 Nov 2025 17:06:27 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vKfGl-000lws-11;
	Sun, 16 Nov 2025 17:06:27 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0233A4A0D85;
	Sun, 16 Nov 2025 16:06:26 +0000 (UTC)
Date: Sun, 16 Nov 2025 17:06:26 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
	Wolfgang Grandegger <wg@grandegger.com>, Maximilian Schneider <max@schneidersoft.net>
Cc: Henrik Brix Andersen <henrik@brixandersen.dk>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can 0/3] can: gs_usb: fix USB bulk in and out callbacks
Message-ID: <20251116-rare-quoll-of-swiftness-7db5da-mkl@pengutronix.de>
References: <20251114-gs_usb-fix-usb-callbacks-v1-0-a29b42eacada@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zjz4sbkqa3hszjs7"
Content-Disposition: inline
In-Reply-To: <20251114-gs_usb-fix-usb-callbacks-v1-0-a29b42eacada@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zjz4sbkqa3hszjs7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can 0/3] can: gs_usb: fix USB bulk in and out callbacks
MIME-Version: 1.0

On 14.11.2025 09:36:42, Marc Kleine-Budde wrote:
> The bulk-out callback gs_usb_xmit_callback() does not take care of the
> cleanup of failed transfers of URBs. The 1st patch adds the missing
> cleanup.
>
> The bulk-in callback gs_usb_receive_bulk_callback() accesses the buffer of
> the URB without checking how much data has actually been received. The la=
st
> 2 patches fix this problem.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zjz4sbkqa3hszjs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkZ9n8ACgkQDHRl3/mQ
kZz5aAf7BFXKbxD5JSP4ukINYpo8JY+wvrMvpkTaz6f7NnPJzd6ZiZEcm6oNigP1
PxyiZ2wOW8blAJW81BM4dhY0yA7emd4CYUGp2f9EsGpLqE+gSuwG/co1tyIntNHt
82frWFFXMQV/RDewZKWLoZNaws1iAPPiAPeQiHZeoJ2AMGCyzgvK9kc2oMD6ISNe
3EBuL9YgsB/dO6XqfGs1Tlmlvzvqa5k6ZJEESrRthLUeDhIIjDx7XZZlMfyRkTa0
VHbZbGWBbR4WgsvE01CBaS1mjQ6ayZIuIvacXzef5j7xuUts1LNrkKCTS4tlQ8WI
i+pZKuhtGp9DTxf26Iaxd8vRlY0Hww==
=zoOy
-----END PGP SIGNATURE-----

--zjz4sbkqa3hszjs7--

