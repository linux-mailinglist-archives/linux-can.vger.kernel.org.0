Return-Path: <linux-can+bounces-4558-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAB0B4ACBE
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 13:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485741C24D90
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 11:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B06D1F30A9;
	Tue,  9 Sep 2025 11:49:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57A1E0DE3
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418571; cv=none; b=T7mI2+9xNdIavowuKuBHP+y6W1MV0Q8U7BtQJcIQLZJEOmj/65n3R6eWQ2diF4HTBs4xUNNNX5lCe3LY2oKLqHrIDAoMXrbe7/xJNctwLjeqvgV61vJgvSddNGhTsPm4pHHRD9+2ex1+FuK2FxMC1fUPAvjN1qqJIyXRxZWfT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418571; c=relaxed/simple;
	bh=kvWSehw6D10YI+IZTOM+M4Lu96BZwfK1FTCs7UigPx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lox3+CqgPlmbk1WUmYodW4g4H8z0H9sciTQz3F07xanLRtoy7po8EUTkn2XGbLVeu6j8hHfSAA/sjtoInAeNRCpQ51Cp/4hgbNraXEREl47eTUsWSXBcmtSTWBi+eL9ChdwN6qckMnlLUw8QpYSFNHe6e6+U+aDdnkzYSIKWcIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvwqk-00047E-5f; Tue, 09 Sep 2025 13:49:26 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvwqj-000PdS-36;
	Tue, 09 Sep 2025 13:49:25 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A8F83469E8A;
	Tue, 09 Sep 2025 11:49:25 +0000 (UTC)
Date: Tue, 9 Sep 2025 13:49:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: j1939: call j1939_priv_put() immediately when
 j1939_local_ecu_get() failed
Message-ID: <20250909-victorious-holistic-skylark-cccba8-mkl@pengutronix.de>
References: <4f49a1bc-a528-42ad-86c0-187268ab6535@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gemnvnusrnqcmhiv"
Content-Disposition: inline
In-Reply-To: <4f49a1bc-a528-42ad-86c0-187268ab6535@I-love.SAKURA.ne.jp>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gemnvnusrnqcmhiv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: j1939: call j1939_priv_put() immediately when
 j1939_local_ecu_get() failed
MIME-Version: 1.0

On 24.08.2025 19:30:09, Tetsuo Handa wrote:
> Commit 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct
> callback") expects that a call to j1939_priv_put() can be unconditionally
> delayed until j1939_sk_sock_destruct() is called. But a refcount leak will
> happen when j1939_sk_bind() is called again after j1939_local_ecu_get()
>  from previous j1939_sk_bind() call returned an error. We need to call
> j1939_priv_put() before j1939_sk_bind() returns an error.
>=20
> Fixes: 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct =
callback")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gemnvnusrnqcmhiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjAFEEACgkQDHRl3/mQ
kZweQAf8Cn3goD4lkC1/GSx0fSTsB8tHpk/dgFq/Xn+Ym0bDzXyeud1ZplPlmw/a
X1LdxxVGJISwXrw1Mqarvx8zKZJyEgGRUh8zyKFQdHne/Q6UArjHInDGwPZnhwVp
tE/mFi8ivgX/mjP5NJ68Ov4RF+wEc6rC7OJ33cSXzpTESVrHSOM8rOwplp994uCE
kKU75a2j75QvcYHC4kub9R+cJP/LIRaZ0z5pV1qk+i4Y6CQNbD+ihieCrbAeg5ba
sZ9tIOYR4H0x+5Rrpoo4+EsTItGw3/PIfzhPG2dC3YBGzItn7g/HqAV2COJDrigQ
k1aEvx3F4YKm/ZEBK8otmtALSK7mkw==
=Ovck
-----END PGP SIGNATURE-----

--gemnvnusrnqcmhiv--

