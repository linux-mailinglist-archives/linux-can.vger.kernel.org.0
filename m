Return-Path: <linux-can+bounces-3402-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5BCA89A46
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 12:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 338BF7A24D7
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C042309B6;
	Tue, 15 Apr 2025 10:31:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7C268FF4
	for <linux-can@vger.kernel.org>; Tue, 15 Apr 2025 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713080; cv=none; b=AQhQlQVfH4JAP1yv6eQCF0urH1Zm6MG4iGnNr94GTWnI5YQtkv5c6etS4+ugMFDgo0YU4bmxuslzPyQH+0RwcTX4BsEIM3g3tdQj3KjeIMBxYRBm9cH4XezrgBBZIO1YIW7xw0VczphHZN84LYsWiK6ksWHlFVcqCasr3ACymyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713080; c=relaxed/simple;
	bh=FLZYQl/9prDX0eLEC/XoYXKAHhhffs0dRY+G5p5tNjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohhjN9eqNLUUMrN7JGLuLyg7t/et0B7PQ9wpE1Q/tdXOdC6aZRscGFv+NnC2q+rTMESv+d+GUdGJ3wmEk0kcArA0PDhx7y7WhF6ozkov7JnCYQGKTyXM0txSYczW6Qjjf1RGfeBVIMlFSan3n6p9MAziZJL1pnWorgZhToJ025I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4dZP-0005vb-7M; Tue, 15 Apr 2025 12:31:11 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4dZO-000P3u-1l;
	Tue, 15 Apr 2025 12:31:10 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 45B213F9BCA;
	Tue, 15 Apr 2025 10:31:10 +0000 (UTC)
Date: Tue, 15 Apr 2025 12:31:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Heiko Stuebner <heiko@sntech.de>, kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: rockchip_canfd: fix broken quirks checks
Message-ID: <20250415-glorious-spider-of-imagination-2c084f-mkl@pengutronix.de>
References: <20250324114416.10160-1-o451686892@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5niwputommw5d6bc"
Content-Disposition: inline
In-Reply-To: <20250324114416.10160-1-o451686892@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--5niwputommw5d6bc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: rockchip_canfd: fix broken quirks checks
MIME-Version: 1.0

On 24.03.2025 19:44:16, Weizhao Ouyang wrote:
> First get the devtype_data then check quirks.
>=20
> Fixes: bbdffb341498 ("can: rockchip_canfd: add quirk for broken CAN-FD su=
pport")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--5niwputommw5d6bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmf+NWsACgkQDHRl3/mQ
kZwmzgf9EQR3QqPh+Se+JjLbC/f3lT2pfHqQCqOiObr7flwz+27gHXmsQHjMfYt8
P8r00Km0qdMN37hnSWlrde5POFa+ubE2SQXyCILdcOUZc4fTs4Ehi8kX9nbuN76w
K39/SgcfCMTib4VGhzuB2ZBOpmIljZkKlfYkjolYMBmjoJXANe2P+D3eP2tM4HKu
pLXWLS0flXatk2Jt2q86d1ObggIFTakkog1AM3XKBX7DnE2si1vfc4AXFxx3SHGG
vpT9OD2snz91AMWweE9142o2ny1AVTSszTI8Z861/V6zZZ13EexTU6BvCXUjBabV
fHMRDSBSy4xFAaci/e3DJD8SRNNrFQ==
=/XME
-----END PGP SIGNATURE-----

--5niwputommw5d6bc--

