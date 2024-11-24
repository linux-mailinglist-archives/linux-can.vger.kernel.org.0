Return-Path: <linux-can+bounces-2207-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBF39D7540
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 16:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF7316838A
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FF31917CE;
	Sun, 24 Nov 2024 14:34:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0718FC70
	for <linux-can@vger.kernel.org>; Sun, 24 Nov 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732458850; cv=none; b=bcJQEYjFRTtg7uHLTqRPYthcJeKKJqQH2zcY4qq1CoVvTnjiKopYwZ8LSc6skgPn3nThUSuFzn3J4OX2q77OjblGuGLi8Et975CdrJ40GefouA4AVyo/7IdIXt/7N0dA5hCOq4m2KUVQW1F9jgRmSCDFgeENdC8mJ4ACt32Yhjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732458850; c=relaxed/simple;
	bh=Qg6cgcT+Q7pGGKORiV9NKRVTyIHdmA1hySkMhq+dSEU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9IOkoOxoYASdI0E1Lvgw0YlpdqSUDhrvxoy/QT1eXVQBaf2uJbSqEsxNrSaiDEQwvHVzdE50q6M7JU2AB2D4YmB1DdI0S/6YgvmP1kEqbVpa+xHR9RuiIHrI29EksNg/o9t9EFYFVIdEtjUgzRGp8c2t9yEeB4GfL1+orUnwfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFDgb-0006Fc-0c; Sun, 24 Nov 2024 15:34:05 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tFDga-002PL1-2c;
	Sun, 24 Nov 2024 15:34:04 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 835CE37B51A;
	Sun, 24 Nov 2024 14:34:04 +0000 (UTC)
Date: Sun, 24 Nov 2024 15:34:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org, mw@iot-make.de
Subject: Re: socanui
Message-ID: <20241124-inquisitive-brawny-macaque-df303d-mkl@pengutronix.de>
References: <20241124-solid-micro-hummingbird-776382-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ue2wmvfia5o7g5fr"
Content-Disposition: inline
In-Reply-To: <20241124-solid-micro-hummingbird-776382-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ue2wmvfia5o7g5fr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: socanui
MIME-Version: 1.0

Hello Michael,

awesome project!

On 24.11.2024 15:31:24, Marc Kleine-Budde wrote:
> I just stumbled over https://github.com/miwagner/socanui by Michael
> Wagner (Cc'ed). Haven't tested it yet, but it looks awesome.

I one thing I just noticed, you probably don't want to parse the output
of "ip" with regex, but rather add the command line parameter "--json"
(and "--pretty" while debugging) and use the json output.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ue2wmvfia5o7g5fr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdDOVkACgkQKDiiPnot
vG+aXQf8Crz4W2d7dtvrO+HDMX0aFQmOwCVoRDhjSPZqpYqPdX+fXfi+fjbAQob2
Q7OyNYGAOoAnHdc3Ivlo8zWDHYa76l3r6FLpKUIL7a9k+MUscCPB8cDJJX4buZjE
HnmSMIQZ/YDFBwP+ks4mgPrKjbXdQTxRW8oDSKZSAJFOvC58avkDA+65QeVXhFLW
1LHJRLFWhb5wZ+h+voF0Qll1771HQq9Ld5Vhlb8Zjd0EmISulR5fSbUkxtfL53G8
hgkgAKr5Pbcs44ZlvzrEEXoAhYXv0Hn0FZRox6maHLp/IpKhUlr9jTgzUmwJKs4d
5Uqs/4nI75kuSfWmf1e95X5UU0K1hg==
=ctLy
-----END PGP SIGNATURE-----

--ue2wmvfia5o7g5fr--

