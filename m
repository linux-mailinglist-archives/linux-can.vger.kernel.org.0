Return-Path: <linux-can+bounces-1267-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3699669E5
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE11283431
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 19:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546F1BA292;
	Fri, 30 Aug 2024 19:33:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55051BD4E8
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046424; cv=none; b=CHd6ReWxENByOq7pd3Zr3jrHLU0eYWou8tq9q2otPRPZyAbnWBBD1Ck0abqToydMXMy4DbLIPdzvF/QxIsFb3UvJQFSTfcZsdU8AN3HaUBkqQc/M90TRPkZXqn6aIwpt+090UF54yRcyHXwMIk9Zqhb5hhOywpZNkIV+m/55NgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046424; c=relaxed/simple;
	bh=AZFaq2r3hKbzSWF9nhGUccqEw86w4sEcBqhPeYy+xy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAjZ52O6BldICasM6KSFVHwxri2zCFAs0Otvnnhuybc05kEkbO1YFZktxZTFnnaeSHWLgObLKG6PCIVkTGgxjfSac1A0qwT8Eb3oBkvcxH8L4BsepGasj1f1NXHaD4Yxk5MrgNKzjOnXzk45orPIBEY/y+OmsjRSpX9eMi3F+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7NL-0006c8-Sx; Fri, 30 Aug 2024 21:33:39 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk7NK-004E75-Ty; Fri, 30 Aug 2024 21:33:38 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A679432E37A;
	Fri, 30 Aug 2024 19:33:38 +0000 (UTC)
Date: Fri, 30 Aug 2024 21:33:38 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	extja@kvaser.com
Subject: Re: [PATCH v2] can: kvaser_pciefd: Use a single write when releasing
 RX buffers
Message-ID: <20240830-happy-pistachio-husky-46729a-mkl@pengutronix.de>
References: <20240830153113.2081440-1-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cychdlyubtvbptkr"
Content-Disposition: inline
In-Reply-To: <20240830153113.2081440-1-martin.jocic@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--cychdlyubtvbptkr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.08.2024 17:31:13, Martin Jocic wrote:
> Kvaser's PCIe cards uses the KCAN FPGA IP block which has dual 4K buffers=
 for
> incoming messages shared by all (currently up to eight) channels. While t=
he
> driver processes messages in one buffer, new incoming messages are stored=
 in
> the other and so on.
>=20
> The design of KCAN is such that a buffer must be fully read and then rele=
ased.
> Releasing a buffer will make the FPGA switch buffers. If the other buffer
> contains at least one incoming message the FPGA will also instantly issue=
 a
> new interrupt, if not the interrupt will be issued after receiving the fi=
rst
> new message.
>=20
> With IRQx interrupts, it takes a little time for the interrupt to happen,
> enough for any previous ISR call to do it's business and return, but MSI
> interrupts are way faster so this time is reduced to almost nothing.
>=20
> So with MSI, releasing the buffer HAS to be the very last action of the I=
SR
> before returning, otherwise the new interrupt might be "masked" by the ke=
rnel
> because the previous ISR call hasn't returned. And the interrupts are edg=
e-
> triggered so we cannot loose one, or the ping-pong reading process will s=
top.
>=20
> This is why this patch modifies the driver to use a single write to the S=
RB_CMD
> register before returning.
>=20
> Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>

Thanks for the detailed commit message. I've added a fixed tag:

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan dev=
ices")

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cychdlyubtvbptkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbSHo4ACgkQKDiiPnot
vG+gSgf/VKwKDbPZSTokHjVRBaHqxTAVYUDVfR8LAeFyk3Q9sUl3ueG13iVYhMPu
aqa2TflbHQIX2hZHuljtT5d0U2haAWdqsehXyZGt5Es5LWbxP1STQU14l8ueTcO1
A71sPn1Q0WAV/awS2CxVezCeqmVq2aIGiWDXpLePob0ipvfStBtvj4ky2V+tohNc
4FVf7T+zcYGKLj2CdnTBABaqAn98xigQ8//mX2+STi6KuBpNjcjCKJHWewwxpjAp
3pB+LGluni+k2JzzfUXi9S7CVY/hBelm0BdZy8sgw+w0Gfof7w98PzdMWix9WyPs
ML/uOOfcwy3+DUKrTkGODVGLEtFUhw==
=QXDY
-----END PGP SIGNATURE-----

--cychdlyubtvbptkr--

