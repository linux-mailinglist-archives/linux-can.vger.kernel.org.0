Return-Path: <linux-can+bounces-1553-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C1983D60
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 08:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C30CAB20EF3
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 06:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F9A18054;
	Tue, 24 Sep 2024 06:53:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7867F1B85FA
	for <linux-can@vger.kernel.org>; Tue, 24 Sep 2024 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160788; cv=none; b=u62hZfo6q3/C60kPOYWV+7AGVCMdBGjBerLCYoYUenCZSve7rtRE/pj2msoqKWPVn8IUIodudRfgfciGrJmYWezfqmWdB8HnvnFwSNDw30r4Zip6l8p3bSd9y5/mq54Kf8F+Y7RZpkZ9IwdG7RfLLUOXcHdXwtDWOyNwh0aK+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160788; c=relaxed/simple;
	bh=tkf0vglU18O/SCb1aPTyywfsmDs6HKvXM0pmO6g+bKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrZ5ztBnr0J9BBk6ZmsiocO8SxSiNEHOaEc2hxmbpayHCazLFd3/8J5TKFPLIse3RceTC/u4teafKJFQ5A8ukol2/+WMXye01t2+8meWfgG7PvXMZ5TXZ8GpcBj8RP/NWgdiofYsj8/DTnFKakqDS8QjymN9lzY/lJ6OoXQ109M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sszPy-0003aM-TH; Tue, 24 Sep 2024 08:53:02 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sszPy-0018Rs-C5; Tue, 24 Sep 2024 08:53:02 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A75B7341995;
	Tue, 24 Sep 2024 06:53:01 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:53:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: Oops on mcp251xfd open on 6.6.52
Message-ID: <20240924-heretic-literate-ara-91082b-mkl@pengutronix.de>
References: <20240923115310.GA138774@francesco-nb>
 <20240923-spry-badger-of-perception-303c63-mkl@pengutronix.de>
 <20240923120027.GB138774@francesco-nb>
 <20240923-quixotic-okapi-of-rain-99ae09-mkl@pengutronix.de>
 <ZvHugNKM-Ilu4K3K@gaggiata.pivistrello.it>
 <20240924-goose-of-undeniable-discussion-efc300-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdrrqkqbknbqct2x"
Content-Disposition: inline
In-Reply-To: <20240924-goose-of-undeniable-discussion-efc300-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--fdrrqkqbknbqct2x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.09.2024 08:21:06, Marc Kleine-Budde wrote:
> > How to we move forward now? Would you ask greg to backport to stable ke=
rnel also
> > these 2 patches
>=20
> Yeah, that's pretty much what I'm going to do now :).

done:
https://lore.kernel.org/all/20240924-truthful-authentic-basilisk-aaab90-mkl=
@pengutronix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fdrrqkqbknbqct2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbyYckACgkQKDiiPnot
vG+dYQf/WVJyhETTghL+6Yx4eqaf05scJyho0a3bQ7nxbmQle5FKwUy3sthINXSf
60rX6W18NLA6ymy7CZEIVPoD4svacjugYkVHGYCuCqvtSeY6uKcHW2UX0QlGO7Sa
1PG+yHFvX85y7x1gW2S1FLgpEspVI9aRw6C8/nuTmeBVWHkbG9O335rf+7lwKand
gepvCDxeYj/f3yvVuBwAAKrI2Gko/GNelP2cM88d2y54i+saPUqM4nNZ+H8HtfV4
J7m5qpcx7uMgXmx0DaLs/gGQtkGDs2DsnxNFP35cziENTc6MKLhG6xVXNcWIBdj4
zjdRoLXLs9EKAYpBi7vdDgeUqDWj4g==
=/aHu
-----END PGP SIGNATURE-----

--fdrrqkqbknbqct2x--

