Return-Path: <linux-can+bounces-5335-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD5C4E838
	for <lists+linux-can@lfdr.de>; Tue, 11 Nov 2025 15:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40F51896763
	for <lists+linux-can@lfdr.de>; Tue, 11 Nov 2025 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EEADF76;
	Tue, 11 Nov 2025 14:35:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E62D8DDA
	for <linux-can@vger.kernel.org>; Tue, 11 Nov 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871726; cv=none; b=gbM8M1TCyDupKA0nPvGS8cQNX5dkR01QwVvGFAO3uAOrDGCHQY7M/evm+3ynN78OAw+5XrzMSz7izywFS1l9PHa/DTr4kKtSXjImyI+WzHwYxCkXQ6TNItATMKLnT3nb9e7uFOG4ZIbseAnr3O2/zie8htBTEU/Z883u+ycssSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871726; c=relaxed/simple;
	bh=JTrl+5c+KM67zyb4vk0jknU9NS1WkTcTeyTZ47rmEeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRVSLaqCuEbItJ0YAK7ZrH+ukRJL6Li89rX8FyjoQra2bD27GxTjbGL+JoPzNHo0Giiul4bstXcrnTyoUEOIQY8zbbojgE1xVG1nWG7eo7LoNb4YyQC11St8DTwt+KZFqq1yIf8PyYBiz2XlgVDO5ashMqMjtbOyeGnYa3f0dQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vIpSn-0004Hl-V1; Tue, 11 Nov 2025 15:35:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vIpSn-008DbB-0j;
	Tue, 11 Nov 2025 15:35:17 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BEA5349D0A4;
	Tue, 11 Nov 2025 13:55:26 +0000 (UTC)
Date: Tue, 11 Nov 2025 14:55:26 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Henrik Brix Andersen <henrik@brixandersen.dk>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Maximilian Schneider <max@schneidersoft.net>, Wolfgang Grandegger <wg@grandegger.com>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can 3/3] can: gs_usb: gs_usb_receive_bulk_callback():
 check actual_length before accessing data
Message-ID: <20251111-abiding-observant-beetle-e3575f-mkl@pengutronix.de>
References: <20251108-gs_usb-fix-usb-callbacks-v1-0-8a2534a7ea05@pengutronix.de>
 <20251108-gs_usb-fix-usb-callbacks-v1-3-8a2534a7ea05@pengutronix.de>
 <A5BD68A4-076C-4ADD-B2A8-5D8A128D0473@brixandersen.dk>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ki34qkgihig4krx"
Content-Disposition: inline
In-Reply-To: <A5BD68A4-076C-4ADD-B2A8-5D8A128D0473@brixandersen.dk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2ki34qkgihig4krx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can 3/3] can: gs_usb: gs_usb_receive_bulk_callback():
 check actual_length before accessing data
MIME-Version: 1.0

On 11.11.2025 13:31:06, Henrik Brix Andersen wrote:
> > +static unsigned int
> > +gs_usb_get_minimum_length(const struct gs_can *dev, const struct gs_ho=
st_frame *hf,
> > +  unsigned int *data_length_p)
> > +{
> > + unsigned int minimum_length, data_length;
> > +
> > + /* TX echo only uses the header */
> > + if (hf->echo_id !=3D GS_HOST_FRAME_ECHO_ID_RX) {
> > + *data_length_p =3D 0;
> > + return sizeof(hf->header);
> > + }
>
> Is this correct? The embedded timestamp is also used in the
> gs_usb_get_echo_skb() function.

Right, will update.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2ki34qkgihig4krx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkTQEsACgkQDHRl3/mQ
kZxukgf/Q/SYj2Mgk2ee0Hmn5W0aTr8iFN8NbbxbedBErXlMKpihPJBmL+Ypwzjk
/87YZZymYsYWOZmOpkZgFmqM7Pyhwhpqv837STWQ34Y0eyGn7zeV+vOfAxKh7g/O
ksI6NT64jV/fPZAhP2YXVZazoRNYV1KGYaMEk6CTKkmOrYjyjMyXhlrrmKQyQFHF
REBChJ4yHOk2HlKQkk6ITdXzReXWGTl5it7GQInVjN0rnNf8PlaOGwTFe2r9/Axy
VYK0PgX5tLx3fz5UNL1aTjWEnKEeiAm4aCVQGx51ycQ5mrGiPPK+hKjYGlLcuw2j
DjkZsK7yVJXjHUXimJQMZgjLFl4Beg==
=sKdY
-----END PGP SIGNATURE-----

--2ki34qkgihig4krx--

