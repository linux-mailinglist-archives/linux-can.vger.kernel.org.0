Return-Path: <linux-can+bounces-2438-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E29F65D1
	for <lists+linux-can@lfdr.de>; Wed, 18 Dec 2024 13:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42EE188986C
	for <lists+linux-can@lfdr.de>; Wed, 18 Dec 2024 12:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB191ACEA4;
	Wed, 18 Dec 2024 12:20:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0CC198822
	for <linux-can@vger.kernel.org>; Wed, 18 Dec 2024 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524435; cv=none; b=HPfMH8OqeVBYqX8VGVcXsyjIFOWESumxP9qftyPxEGGXEoh1/r2BZAt6Vd75lb+MHoT62MpkM0a5gZpnrWl3W+PI1o6LOBlQX00jNH2obcq+u31KkhtAEZhV8zbHUh6hr0bSiCqB1o1VChcEmZ0q5RH9SpaI+2XZ00VmLYOOfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524435; c=relaxed/simple;
	bh=NpUdBiOBjaWWavN0YQxon0a1X9zWaQH2bBIjxZKE4GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnnVqk8mBceOJRRz0+0dr7yXt+qKnehlFGMMmN17d7BtFX1keizDIZwnqQjUdQs6XtmJQuBA23WU8fc6TyYlA8eadH9jmf48FqCNuftplbXtYbZSjoiG7Oa6GAXabXLVNV7d4lGDz3F2IDQkVa2VttBnyrs4bMtS25hCtoHWohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tNt2V-0004MX-BN; Wed, 18 Dec 2024 13:20:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tNt2U-0041wa-0p;
	Wed, 18 Dec 2024 13:20:31 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ADF753916AB;
	Wed, 18 Dec 2024 12:20:30 +0000 (UTC)
Date: Wed, 18 Dec 2024 13:20:30 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Renjaya Raga Zenta <ragazenta@gmail.com>
Cc: linux-can@vger.kernel.org, martin@geanix.com, 
	matthias.schiffer@ew.tq-group.com, msp@baylibre.com
Subject: Re: [PATCH v4 1/2] can: m_can: set init flag earlier in probe
Message-ID: <20241218-gorgeous-sapphire-kingfisher-7caa81-mkl@pengutronix.de>
References: <20241210-rational-abiding-guppy-0160a3-mkl@pengutronix.de>
 <20241218045853.88388-1-ragazenta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="omfot57e5fkgb6ur"
Content-Disposition: inline
In-Reply-To: <20241218045853.88388-1-ragazenta@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--omfot57e5fkgb6ur
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/2] can: m_can: set init flag earlier in probe
MIME-Version: 1.0

On 18.12.2024 11:58:53, Renjaya Raga Zenta wrote:
> On 10.12.2024 21:37:19, Marc Kleine-Budde wrote:
> > Applied to linux-can.
>=20
> Hi Marc,
>=20
> I can't find this patch in linux-can main [1] or testing [2]. Did
> you apply it to somewhere else?

I haven't pushed the testing branch, but this is now done. Also I've
send a PR which includes that fix, see tag:

| linux-can-fixes-for-6.13-20241218

and

https://lore.kernel.org/all/20241218121722.2311963-1-mkl@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--omfot57e5fkgb6ur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdivgsACgkQKDiiPnot
vG/hCwf/dOjIKV76sx1MBnFztq6yx9EcCqIXvQk4D7PQOsXlM1howv4WUm4pAXML
ggnI7W5NRPoYezt7nGu1f9sZPww1GK5/yAyRFybbzvVFQMGSbE4p60F0CFTkKkXG
e/JBDrUelH6R3o9Hfz6Zq0FZ10oF6NwZPAgUVhom3vvbtLcdpc1tvbB/xQf3YN8G
mmJc+KlaeuguMuvRu40TSRVzxJCv4AtpvKNqNupKQujm7jTGoGH1cdEptELdX669
qbJ0wnSFSe1KNGG7Bo6RwRk2uCnLZhhyRX2shaLPJnStHCwgcaLn/3T/Q3mf0G2C
8caHwAWOuY7+LioHlPJxNE7488LSfg==
=XAql
-----END PGP SIGNATURE-----

--omfot57e5fkgb6ur--

