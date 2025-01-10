Return-Path: <linux-can+bounces-2566-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70155A08D86
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABB81888F9A
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE5220D50C;
	Fri, 10 Jan 2025 10:09:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174F20B818
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503769; cv=none; b=cLVpQ24EbM3NKc2uzDDOZAOLy0UzvX4Ko39QCYu459xQ3EUGWILVPtbrKILBAlUSmnZTfD+ycq3EswfyZKMH2sRNj+k+CRXkVMU9SAivKAEgIJ4vTI8o+WrWCXOD9Mpv1toTUUtUP/76RP9mRjZ17NIq9qlAuHkL0/dpl7UoUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503769; c=relaxed/simple;
	bh=vLhQg1ATZFjCPaqLzbbeePcjKxfp+KDgALDR32pvO5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJZ7SseAZPRVuvbz+xLsBjiJo8C157ZWPqEX+s6SDqi7nfD5TYK4cO+ZAqqWIMC+OBC5DZ7183OYtRKf/21KbYzYdt/9JK8VLbnbhT8fMCx1D9rsmU2D7nbQhrRSWUtXCBfl9PzWtId/kcdJHGgfzBC9qjabpSBxholuojrujG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWBwv-0005ni-OS; Fri, 10 Jan 2025 11:09:05 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWBwt-0008nh-25;
	Fri, 10 Jan 2025 11:09:03 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 51D633A4487;
	Fri, 10 Jan 2025 10:09:03 +0000 (UTC)
Date: Fri, 10 Jan 2025 11:09:03 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next v3 0/3] can: tcan4x5x/m_can: use standby mode
 when down and in suspend
Message-ID: <20250110-truthful-adventurous-dodo-576e9e-mkl@pengutronix.de>
References: <20241122-tcan-standby-v3-0-90bafaf5eccd@geanix.com>
 <xn36paqpsjld52s7tkpanyu5v5626vz6bglu76xe225a2y64fh@mz4jvy7avkeh>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j7jh2i2ta4ra47o3"
Content-Disposition: inline
In-Reply-To: <xn36paqpsjld52s7tkpanyu5v5626vz6bglu76xe225a2y64fh@mz4jvy7avkeh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--j7jh2i2ta4ra47o3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 0/3] can: tcan4x5x/m_can: use standby mode
 when down and in suspend
MIME-Version: 1.0

On 03.01.2025 13:37:19, Sean Nyekjaer wrote:
> On Fri, Nov 22, 2024 at 03:52:21PM +0100, Sean Nyekjaer wrote:
> > When downing the tcan4x5x there is no reason to keep the tcan4x5x in
> > "normal" mode and waste power.
> > So set standby mode when the interface is down and normal mode when
> > interface is up.
> >=20
> > Also when going into suspend, set the tcan4x5x into standby mode. The
> > tcan4x5x can still be used as a wake-source when in standby as low power
> > rx is enabled.
> >=20
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > Changes in v3:
> > - Run deinit in m_can_stop() in any case even if m_can_cccr_update_bits=
() fails
> > - Link to v2: https://lore.kernel.org/r/20241115-tcan-standby-v2-0-4eb0=
2026b237@geanix.com
> >=20
> > Changes in v2:
> > - Reduced code in tcan4x5x_deinit()
> > - Taken care of return values from deinit callback
> > - Link to v1: https://lore.kernel.org/r/20241111-tcan-standby-v1-0-f933=
7ebaceea@geanix.com
> >=20
> > ---
>=20
> Hi,
>=20
> Anything needed from my side on this?

I think this all could be hidden behind runtime PM, but that would mean
a bigger re-write and a lot of testing. So applied to linux-can-next as
is.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--j7jh2i2ta4ra47o3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeA8bwACgkQKDiiPnot
vG+vRwf9H/W50oHDEOojLvWV2gej8GuHDgzBbYOjjQ/+R2o8LU/yLlgmfY5Ll20S
DpzSppczsI3fCvcpXU4SvhHuuGa8a2lNdk/Cs0vR1jXT467RJbhNquLIkIqJaSRb
kFakrdhRqlZp1sTAaoDkfMuKgZm4R5sQgMaaProCB1+RhGCcU41cDiM26L3UrNSK
cMUQmsif0Wjlbhzeq2tlh3yMH7MP1UGdifs5wF8egORSByuAYnHbUcgeFPDdUtVK
F1qjIFw/LqbKoYATwDvY0RrdX82mkkpc84F4PCbCWnWPGYqqHfwRj8mctIUo13yi
YzuLleMwnJB4iGjjTrOkbo6DzznnIA==
=Aegn
-----END PGP SIGNATURE-----

--j7jh2i2ta4ra47o3--

