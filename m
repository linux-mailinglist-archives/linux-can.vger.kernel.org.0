Return-Path: <linux-can+bounces-1239-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC1B965FEA
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 13:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCF11F2465E
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 11:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376641531CD;
	Fri, 30 Aug 2024 11:02:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE417C7D9
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015757; cv=none; b=X/KqSU6rym5UbTGbLcfGNHO3odtUpACVKH2erLWGvgiD9H+9qRxCsBjLWcFlDqiYIlRjnTSPa4U6YLeUD6JunHvGJKM/g7/DFDO6N3VpbhCmUErHsblJnZfdKOQTnctjIpPtvQpeMX01ivmfG7dCQ5KUIYek7iCqSf41j1I9B34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015757; c=relaxed/simple;
	bh=zT486oUDecA4FgC3kSRPRe2OzQi4NhpvEyFt+k2Wze8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhwCgfqwBkcsvuYo+pRF0/qnI/Qj16GjwWYRBorwC9Ve8Ufbs5wjbfImgpk/adZfkUVHsC343195xMQEVgtTYU2G0kLk3PgDz0E3j1mAJ1gcLyAbAEuYc0clTeI3aCrepoqLU2HwKz1SVZ1u7JOF0wgYTcKHutrqgHa7eNEBPD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjzOd-0001bA-06; Fri, 30 Aug 2024 13:02:27 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjzOb-0048Ec-KQ; Fri, 30 Aug 2024 13:02:25 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3DE2132DD0B;
	Fri, 30 Aug 2024 11:02:25 +0000 (UTC)
Date: Fri, 30 Aug 2024 13:02:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] can: netlink: avoid call to do_set_data_bittiming
 callback with stale can_priv::ctrlmode
Message-ID: <20240830-prompt-heavy-badger-caa81f-mkl@pengutronix.de>
References: <20240808164224.213522-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k57voe37pir2hjrg"
Content-Disposition: inline
In-Reply-To: <20240808164224.213522-1-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--k57voe37pir2hjrg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.08.2024 18:42:24, Stefan M=C3=A4tje wrote:
> This patch moves the evaluation of data[IFLA_CAN_CTRLMODE] in function
> can_changelink in front of the evaluation of data[IFLA_CAN_BITTIMING].
>=20
> This avoids a call to do_set_data_bittiming providing a stale
> can_priv::ctrlmode with a CAN_CTRLMODE_FD flag not matching the
> requested state when switching between a CAN Classic and CAN-FD bitrate.
>=20
> In the same manner the evaluation of data[IFLA_CAN_CTRLMODE] in function
> can_validate is also moved in front of the evaluation of
> data[IFLA_CAN_BITTIMING].
>=20
> This is a preparation for patches where the nominal and data bittiming
> may have interdependencies on the driver side depending on the
> CAN_CTRLMODE_FD flag state.
>=20
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>

Added to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--k57voe37pir2hjrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbRpr4ACgkQKDiiPnot
vG8h5wf/avgrYoKlK534ZQbyqamgMyuRJMNipoxXXZDPMFXB6+uWzZSkg4+GQGgd
0lkO2xdLEGt92hHTPUqLJBHXjiV3MxEb0aZfA4cohesNOFkKUfnrb1aV4p/H+UcM
wg93437hp4syf9Ch2LjlyY55EyJ1hEqNxIsS0jrtHi5IU7t3RMmzsFiU1mwd3TW2
BE2oIDRvR/MDdtIsyy+t0m1T+UhXF/Y3MeKTZH9cq68Qe5DnOPPXsuqQdkmmq1WZ
JIQGiEYKfr2YppxamnYppqESM81J/Lnt+WnrhpN1XKART8QlV2s99pXimv4WnUzS
SwZ+FZj/c6K/ttkXLdoeUk6ta0cPcg==
=rb44
-----END PGP SIGNATURE-----

--k57voe37pir2hjrg--

