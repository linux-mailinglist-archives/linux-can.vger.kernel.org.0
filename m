Return-Path: <linux-can+bounces-1238-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C331965FB1
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 12:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166751F20F55
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AA015C147;
	Fri, 30 Aug 2024 10:56:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C161531CD
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015380; cv=none; b=lWiwk0gaqH6GWXpPXPEIpA/kdxJcuuZu6Tm88bKR759QpryIYB0cUj6uG/SoKTWRZf2djW1SOPsDXuKVHnLRkzRVvmu9e6aTTDraaCN3hmwEK0rt7qPXKqqoTvvOWhBgNc0iXv1u3oKNM+RpzDtxEiTo4kdUI8lZRZ4XKvfGK+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015380; c=relaxed/simple;
	bh=l0hJPpbG+vbwB96JafgTb9z3xRE+yGxdHxkInHu4Ue4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGDucqFBbGgU1xw8dPY023xygHO8Il1RMfRalEi+SbPItS7VyfhtWTc+gQwzCCbc7AroYx9r6imcjU2d1mEVAvwSZamO0EnWANCrsoAC6XXj7u1xo3fIKsq+H3gTcmeeMZfCFi7NdXYjfShfFWeJ1iG1I6DUA1rAsD+BvM71t5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjzIW-00057Q-Uo; Fri, 30 Aug 2024 12:56:08 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sjzIW-0048A3-58; Fri, 30 Aug 2024 12:56:08 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C22D532DCFC;
	Fri, 30 Aug 2024 10:56:07 +0000 (UTC)
Date: Fri, 30 Aug 2024 12:56:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: socketcan@hartkopp.net, davem@davemloft.net, 
	david.hunter.linux@gmail.com, edumazet@google.com, javier.carrasco.cruz@gmail.com, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org
Subject: Re: [PATCH 1/1] Net: bcm.c: Remove Subtree Instead of Entry
Message-ID: <20240830-cuddly-calculating-flounder-5ccb7e-mkl@pengutronix.de>
References: <2bf44b8d-b286-4a94-8e1d-6c4e736a1d07@hartkopp.net>
 <20240809202249.16183-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mf377dq3tmpywr4d"
Content-Disposition: inline
In-Reply-To: <20240809202249.16183-1-kuniyu@amazon.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mf377dq3tmpywr4d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.08.2024 13:22:49, Kuniyuki Iwashima wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> Date: Fri, 9 Aug 2024 11:57:41 +0200
> > Hello David,
> >=20
> > many thanks for the patch and the description.
> >=20
> > Btw. the data structures of the elements inside that bcm proc dir shoul=
d=20
> > have been removed at that point, so that the can-bcm dir should be empt=
y.
> >=20
> > I'm not sure what happens to the open sockets that are (later) removed=
=20
> > in bcm_release() when we use remove_proc_subtree() as suggested.=20
> > Removing this warning probably does not heal the root cause of the issu=
e.
>=20
> I posted a patch to fix bcm's proc entry leak few weeks ago, and this mig=
ht
> be related.
> https://lore.kernel.org/netdev/20240722192842.37421-1-kuniyu@amazon.com/
>=20
> Oliver, could you take this patch to can tree ?

That patch is included in my latest PR to net:

https://lore.kernel.org/all/20240829192947.1186760-1-mkl@pengutronix.de

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mf377dq3tmpywr4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbRpUQACgkQKDiiPnot
vG+80Qf/ZNGilE+i+T/ayO25y6z1GvGcm1RQ+dZQEmcTq6GuSysHj/azWV3RG8KD
lLZ6Hunu7SrqqDIAL9xEqd8dXLuQBknMeBbiUsJwVJPmaYc7ulonhSSUxrVKwBnJ
MUPTQFWULg/kjbKFIH656pbb5FHcCRF5nVs7emr/uWkfi8ozdYJlQfwEKMjcI9xd
ehBHxGCIydlEtsqTkOboVvWqEpd3rRbYZ4kVdcHs0P6FfBt/q737kMyvPzlHFBp1
OLafPnRxE6Ke0wVthE9jIviSVdKYTZlRTtxL2YCFTIco1TfDmgsq3+k5h7TbNBBY
CP3EUE7BidIM9w9rAhTAzDC0a2sIlg==
=+tJQ
-----END PGP SIGNATURE-----

--mf377dq3tmpywr4d--

