Return-Path: <linux-can+bounces-353-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966AB86FB16
	for <lists+linux-can@lfdr.de>; Mon,  4 Mar 2024 08:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DC0282240
	for <lists+linux-can@lfdr.de>; Mon,  4 Mar 2024 07:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30CD53A6;
	Mon,  4 Mar 2024 07:48:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C415AF9
	for <linux-can@vger.kernel.org>; Mon,  4 Mar 2024 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538494; cv=none; b=B9pdMUuDWtoUN5Y6HJAdekbLHHKPwUltwo2AGv93Aapa7OAj6b/HSCls9AWsqCQpXajvPMr4Z5bJIEX4IWntS1+bfZAMubcf0EFHP/PEAFB7b3rqveMhLZPmrh8TwgjA6zAjRX6nriPXXX65lcE/SK6YWfWtMfZwteZfM3LtLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538494; c=relaxed/simple;
	bh=aIN39bUo3gjFZZSC11gA1VIKz9YxqAkbd4XBbjYyyek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKOcqW55zKmi+zOUVxEn+SpnWR78cvFpxOo7xwKcz486rhVC3fApTLIWjsfG3ke6hI2xN4JkQxu2//j5LKlT2aK6bakntUO9+3cRjTGo6/FEXw/x0qELAWPUFzDBd2NyhWShhXDs56/tJBwId6qsPrc+jKgfbO2xPYi6M7ztuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh33S-0002nZ-BY; Mon, 04 Mar 2024 08:48:10 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh33R-004J5V-Sn; Mon, 04 Mar 2024 08:48:09 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9C41329C9C3;
	Mon,  4 Mar 2024 07:48:09 +0000 (UTC)
Date: Mon, 4 Mar 2024 08:48:09 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH] can: kvaser_usb: Add support for Leaf v3
Message-ID: <20240304-glitzy-synopses-f477e799918a-mkl@pengutronix.de>
References: <20240223095217.43783-1-extja@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4fzoxwuuvzv4ly7"
Content-Disposition: inline
In-Reply-To: <20240223095217.43783-1-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--p4fzoxwuuvzv4ly7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.02.2024 10:52:17, Jimmy Assarsson wrote:
> Add support for Kvaser Leaf v3, based on the hydra platform.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--p4fzoxwuuvzv4ly7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXlfLYACgkQKDiiPnot
vG8O5gf/TAyOUtUvURugK9w3Qicv2Gzf7JklqykKXGQBMew0KeRvPIDR3pLhpOQV
qlKe05pa2f+jN9w9ZQiDDOiHjC6474au+TYnVIH98OFawN2i9sl6M0hL3FPsM+g9
x7YE3TDLAPMKxHsYcMK15ShXGb4XVo4lwJ7LTxVxo3RE5k2evDctGTFDKbY0BLUJ
1TdpSloTUAKsOn7zVTsj5TOCFL2lHHEcrDGfmL2MTIMpf1eGhYgRvgU9aNXPZ+Du
+G1X2Idb9MGuu9IbiTRZL57AOXWUC38RJROXlmj5ub9/OkbPMpZspjE2jD4jZ3fk
KL7nHFXya+esqjkEPAD0ncIuY0xU3Q==
=Ktv5
-----END PGP SIGNATURE-----

--p4fzoxwuuvzv4ly7--

