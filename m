Return-Path: <linux-can+bounces-4819-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE2EB91DD2
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 17:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F45C3B27AC
	for <lists+linux-can@lfdr.de>; Mon, 22 Sep 2025 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F12DE1E4;
	Mon, 22 Sep 2025 15:12:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024D25F7B9
	for <linux-can@vger.kernel.org>; Mon, 22 Sep 2025 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758553933; cv=none; b=q6bNOycHL/m8kJmJG0FtT7UjkmZl36fN5hgBeQK0tdV0AK3L8un9Z0yDC+ZS4i6xsEx/FUdMbfTFyO96ZMLnVZM4OkxrgqniA0UCU/1sBu6py/pBD8QmVhyRDXlbqSt52cH3C/o06gBdb7rZg2tOvi1o8xzRxEoUSgqu41r5O2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758553933; c=relaxed/simple;
	bh=LaIN3J/vQ9YPefRubVXI2BAIJgu1RFfWNe2oY4chlAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwSt/zhjaspDlbM+UWIXN4U03SXG6pbsI/AyOdhahlhnF3DI0/JYEj7tPg+ucqO5c/mGm0oK9zqlHU8xEawU2rpox5+8CI+wPKUtul1rBlai5bCJwl1MHVmiqyDddCLT+v/Io+Po/w5eeZJd5Qh/fRjHzwdbrQFaTCqbQUZBQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0iCr-0006IN-Ek; Mon, 22 Sep 2025 17:11:57 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v0iCq-002c4x-0Q;
	Mon, 22 Sep 2025 17:11:56 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AD4954771B9;
	Mon, 22 Sep 2025 15:11:55 +0000 (UTC)
Date: Mon, 22 Sep 2025 17:11:55 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
	mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, mani@kernel.org, thomas.kopp@microchip.com, 
	mailhol.vincent@wanadoo.fr, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
Message-ID: <20250922-ermine-of-perpetual-culture-41ea3a-mkl@pengutronix.de>
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
 <20250918064903.241372-6-viken.dadhaniya@oss.qualcomm.com>
 <CAMRc=Mf2ycyKbL35bdy5m1WBEap7Bu8OO2Q9AdZYgc04Uynf8g@mail.gmail.com>
 <20250918-daffy-steady-griffin-5299ac-mkl@pengutronix.de>
 <CAMRc=Mfypwopu6daCBzg90i98dbO-7rwAehkiNkA-tF074fO5w@mail.gmail.com>
 <20250922-magnetic-dashing-piculet-97f38d-mkl@pengutronix.de>
 <CAMRc=MdEkp6Mztoe44Nv0orX+f4ops7nh8XS7hbJS2KvQFc3Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fgd45ycva64pju5t"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdEkp6Mztoe44Nv0orX+f4ops7nh8XS7hbJS2KvQFc3Fg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--fgd45ycva64pju5t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
MIME-Version: 1.0

On 22.09.2025 16:49:07, Bartosz Golaszewski wrote:
> On Mon, Sep 22, 2025 at 4:43=E2=80=AFPM Marc Kleine-Budde <mkl@pengutroni=
x.de> wrote:
> >
> > On 22.09.2025 16:28:53, Bartosz Golaszewski wrote:
> > > > > You must be rebased on pre v6.17 code, this will not compile with=
 current
> > > > > mainline.
> > > >
> > > > You mean "post" v6.17? Best rebase to latest net-next/main, which
> > > > already contains the new signatures for the GPIO callbacks.
> > >
> > > No, you read that right. The signature of the set() and set_multiple()
> > > callbacks changed in v6.17-rc1 so Viken must have rebased his changes
> > > on v6.16 or earlier.
> >
> > I'm not sure if I understand you correctly. This series must apply on
> > current net-next/main, which is v6.17-rc6.
>=20
> The GPIO driver interface changed between v6.16 and v6.17-rc1. This
> series uses the old interface. It will not apply on top of v6.17-rc6.

ACK, apparently we had a communication problem about what we exactly
pre/post and earlier means.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fgd45ycva64pju5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjRZzcACgkQDHRl3/mQ
kZypmAf+OPO1II+zolxOvU49bEuzELcZ/w0zUYi15K9jRVgsgzyTszm0QWCs9F5k
RhMeKPx5ABC3chks/wk5f3iXEkIk194EKHOI3x3gjcBzGvHI2FbQfXjqQOHcfQh7
UllDjL9TfrFatFTt9PyTNWhuqejsyokBOwmb+otuwjgDyxRkTdYEGmaurZXTfYS0
ZsJ0lSzgiI+JnyK+wN4td5U1FY0VG+uvG02nBWb/MLxHAuJaRNtAQfo76J+FNf05
kLXLTczvfStOfVuIm/fPVCZH1MES81u/rDIIERo5/1Yt0JSx+s3P/Je4PMp/cwik
YmZKhOwuNlrjXfjDfLcEOnWApGIiAw==
=vOMn
-----END PGP SIGNATURE-----

--fgd45ycva64pju5t--

