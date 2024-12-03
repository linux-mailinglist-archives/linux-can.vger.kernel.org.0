Return-Path: <linux-can+bounces-2316-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 558B29E27A1
	for <lists+linux-can@lfdr.de>; Tue,  3 Dec 2024 17:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E0EB44DC2
	for <lists+linux-can@lfdr.de>; Tue,  3 Dec 2024 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D271DEFE1;
	Tue,  3 Dec 2024 14:29:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237751EF08A
	for <linux-can@vger.kernel.org>; Tue,  3 Dec 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236180; cv=none; b=Xi9BTXlBU0ig3v5RCIiCkthpaItU11RPID7qytn1tRh3xk9b9Rzr5cfW7vPcF5dUgkp/Lx6aYgAXRPVBTBmcjjHkv5ygDXXv/CrNNlmC63q/Ka66oF8TElJLdWWWMF5IAuNNYU3pvuBOLxNtHyFJ23cVkUPJaP94zmRgomDjgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236180; c=relaxed/simple;
	bh=/e9aRfi0eZg+tK/j8d496YgB9JjHS+zdMQ+60HfffdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc4fpBSM9wA1idIHuD9HltGZKrNoT64MyuMyiw2/eOsV8+blMVWOqXDteUFCRDwX2AdE8Y5SPrI5CYFI0PIW6kRT+6hb/VJ97z0DmaKCmM+RLZ/i+lqi3wKlatcXRaQAjmyj5uX97CstTOq4K9kXzb0ENRehZkB0WZOeHHYltC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tITu8-0006iC-Vg; Tue, 03 Dec 2024 15:29:32 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tITu7-001UbM-2x;
	Tue, 03 Dec 2024 15:29:32 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5F65D384A07;
	Tue, 03 Dec 2024 14:29:32 +0000 (UTC)
Date: Tue, 3 Dec 2024 15:29:32 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org
Cc: Stefano Offredi <stefano.offredi@daosgroup.it>, 
	stefano.offredi@gmail.com
Subject: Re: ACPI compatible mcp251xfd driver
Message-ID: <20241203-frisky-badger-of-fury-8c68c2-mkl@pengutronix.de>
References: <CA+VHkVF89EZOtnqWFGfS4JFtuLdkX2uJNwY7vicJ=i3RiZtbZw@mail.gmail.com>
 <20241202-organic-caracal-of-skill-4faeac-mkl@pengutronix.de>
 <CA+VHkVHhE5tT6D60MJadVvJ1nvM9gK2kMmZYD_MRP6iJF89pYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cgnocm2hzaxb3egj"
Content-Disposition: inline
In-Reply-To: <CA+VHkVHhE5tT6D60MJadVvJ1nvM9gK2kMmZYD_MRP6iJF89pYg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--cgnocm2hzaxb3egj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: ACPI compatible mcp251xfd driver
MIME-Version: 1.0

On 03.12.2024 15:05:04, Stefano Offredi wrote:
> In these days I have modified the driver, and I was able to register
> it and get it in ip link show.
> I manage to do this porting looking at the spidev and st33zp24 driver.
> I see now a similar implementation
> also in mvpp2 you have just proposed to me (thanks again).

Can you share the modifications with us?

> Now I'm dealing with a problem in bringing UP the can0 interface with:
> ip link set can0 type can bitrate 1000000
> ip link set up can0
> RTNETLINK answers: Invalid argument
> ..I'm debugging it.

anything of interest in demsg?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cgnocm2hzaxb3egj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdPFckACgkQKDiiPnot
vG+FcwgAhigsxN9afZh89VjrBXl9BmLFMrgyuL3KujqwtnSfakcCGOoEM8PT5uMa
cAbJCgbSmklCVRcDvXfW1g05el1CPJzKL27i7fRFeG6lxvSOk1tYO8cE8ks+0i0w
cD7ANpAc2NuzW7sG/iMNlXkmIHV1lk2AhLHxqjwa9ff7euN1c9pM/LQ18IWHnAta
aCHNX5IgRuJ8UYh2mG7HE7a2UACXiu+JqA3xu0Zzq5+lCG4Acjgn0JAe2WS9rJ3H
9KihxLhm30ALyGHpMQAQMJ8lQ4aW6r0qvS22p9lG9ywMbicgbsFWHOd9CY2c0WRD
hLEkTnV9l+H7e9S73fli+2H+pIxtbA==
=UEUf
-----END PGP SIGNATURE-----

--cgnocm2hzaxb3egj--

