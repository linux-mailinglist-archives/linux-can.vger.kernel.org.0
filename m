Return-Path: <linux-can+bounces-2375-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217769EB1E6
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 14:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14602883F9
	for <lists+linux-can@lfdr.de>; Tue, 10 Dec 2024 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE21A9B3C;
	Tue, 10 Dec 2024 13:28:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880E41C64
	for <linux-can@vger.kernel.org>; Tue, 10 Dec 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837283; cv=none; b=SCxHtaB0JPuJqOjHdhHtE+9iEYuH5ZvUhWsJxJfxcUKYHs8MWkxfEC78Q1MagXG8TdWV86jqxMFr4rcqaHEFS8EYUhcxO7dQv0B5AnATMBP5ZPHq2qi7YWqHmEn3BxxTIDb5ZrAsXHtNATCex3CY/IbKHukdpsIsqdaPmioKGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837283; c=relaxed/simple;
	bh=rnvTy5IPn1k5Si1lIEswV3hisQRz+/TSIDKf/YS/lpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to0VUzpkFpm13f5m1EiXe5ApS7mQWIoKR2ttrvgy6VGTsGHH0TFBnlEKdMLO+XfbUft5rWGdl//kMzpkTlaVvz2HNlkneyVLu8E9Lv2X+bBjGSfv0eWP4dsB8XUeaLYfLnHXLjktsZ0BjM+/+1YwHQLvDndSvs/m20EdWQo/PPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tL0HM-0000ok-N6; Tue, 10 Dec 2024 14:27:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tL0HK-002hK7-2x;
	Tue, 10 Dec 2024 14:27:55 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5365738ABE0;
	Tue, 10 Dec 2024 13:27:55 +0000 (UTC)
Date: Tue, 10 Dec 2024 14:27:54 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?Q?Pr=C3=BCckl?= Thomas <T.Prueckl@hainzl.at>
Cc: "rcsekar@samsung.com" <rcsekar@samsung.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: net: m_can: missing mutexes in tx_work_queue and isr-handler
Message-ID: <20241210-sly-impressive-kittiwake-aff4f1-mkl@pengutronix.de>
References: <f6a9e128fbc04dcebd70e9b254b344e2@hainzl.at>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7z3it5fbfqvswz3h"
Content-Disposition: inline
In-Reply-To: <f6a9e128fbc04dcebd70e9b254b344e2@hainzl.at>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7z3it5fbfqvswz3h
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: net: m_can: missing mutexes in tx_work_queue and isr-handler
MIME-Version: 1.0

On 10.12.2024 09:02:37, Pr=C3=BCckl Thomas wrote:
> Hi Chandrasekar,
>=20
> I'm using the m_can driver with the externals TCAN4550-Q1 can controller =
(SPI) on an IMX8MN controller.
> After some time the driver stops working.
>=20
> After reviewing the driver (m_can.c) I noticed that there are not mutex l=
ocks preventing concurrent access of=20
> m_can_isr and m_can_tx_work_queue.
>=20
> After I added mutex_lock in these functions the driver was working fine.

Can you show us the patch?

> Is the driver really missing the locking or is it done on another level?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7z3it5fbfqvswz3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdYQdcACgkQKDiiPnot
vG/K4gf/WPxjoaat68QgKgDCMGQsLFtLEJSNdVHb3rv6Uh+7VrDnUjcMxDRmoRoB
fWH67nhfIYhHpzAq8//7eSeHCSezqMcVTuHTigdArXUee0q2sD/rzfPay+OM5bJy
O6dr823RvQVGX3dE6kSfKdiGfd9lbySHaqulh9pfy5tg72/PSeMRmVK2eeY7vMSM
SmoXnMhKhieSm+RKqfbq6cDUL/5lojMn41PYmr3ZS7mov/0Raj5vfMwWKvOmW8dZ
G0P2QQWLZ0x3mDT5Ogc1FJak9WvWIX84SMAcmjmARAWb97EBmZnuFAoG8ut0K33q
NX4AHy7DJu1ZO6Xg8vaICXx+QI8FIA==
=lig1
-----END PGP SIGNATURE-----

--7z3it5fbfqvswz3h--

