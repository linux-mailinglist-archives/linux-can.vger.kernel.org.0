Return-Path: <linux-can+bounces-6059-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A800FD082CC
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 10:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C76B30501AC
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450A3590BC;
	Fri,  9 Jan 2026 09:23:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59B316192
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767950615; cv=none; b=ibUw598gH/bJhZjuh0IMN9Tp2SfShmwybEerrOZUHAunSH/SsW1uIBISJR5d5QxjnRqs6IzMYe94dDcLOyP3erJp1aCKe+N9ck9QHEFEB8zjnCCZzjuF6g8W395hbN9YZh3MZ3kIqTHPQNvlrHCahPPB781WcYxN8VoMiD5nczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767950615; c=relaxed/simple;
	bh=CJENwtAdLfQGVLxs53+fsNsqxbdp4Zv4kgotdHiXYxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jI/7BB6f+1e6NEv5IhLLtjTmKwkX8WmBtfOj69YhwpPm51A5lHe8TLlE2qBowKeRdkdjt2BW3DmYOrZWXEqExzwVbaYAmlVGLORsOx+6EBM4N320LYWLFy+UB2qjhRA8CZcAE8V89NKFql/Kuu6XuXymfkHdiZyoQlTMcv9h6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve8iO-0004kh-Rb; Fri, 09 Jan 2026 10:23:28 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ve8iO-009p0R-0r;
	Fri, 09 Jan 2026 10:23:28 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C6ED04C9692;
	Fri, 09 Jan 2026 09:23:27 +0000 (UTC)
Date: Fri, 9 Jan 2026 10:23:25 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] can: propagate CAN device capabilities via ml_priv
Message-ID: <20260109-precious-bettong-of-courtesy-989324-mkl@pengutronix.de>
References: <20260101191330.1836-1-socketcan@hartkopp.net>
 <20260101191330.1836-2-socketcan@hartkopp.net>
 <16a623ec-beb9-4968-bf16-75676d516c0e@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7gq2rb2kk5jlaqo"
Content-Disposition: inline
In-Reply-To: <16a623ec-beb9-4968-bf16-75676d516c0e@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--f7gq2rb2kk5jlaqo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] can: propagate CAN device capabilities via ml_priv
MIME-Version: 1.0

On 06.01.2026 16:40:07, Oliver Hartkopp wrote:
> On 01.01.26 20:13, Oliver Hartkopp wrote:
> > Commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames=
")
> > caused a sequence of dependency and linker fixes.
> >
> > The entire problem was caused by the requirement that a new network lay=
er
> > feature needed to know about the protocol capabilities of the CAN devic=
es.
> > Instead of accessing CAN device internal data structures which caused t=
he
> > dependency problems this patch introduces capability information into t=
he
> > CAN specific ml_priv data which is accessible from both sides.
> >
> > With this change the CAN network layer can check the required features =
and
> > the decoupling of the driver layer and network layer is restored.
> >
> > Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames=
")
>
> Are you fine with this patch set?
> I've tested it and it works as expected.

It seems to be OK as an interim solution, that fixes current mess.

But the main problem is, that we don't have the "struct can_priv can" in
the netdev_priv of virtual devices. That should be fixed sooner or
later.

> IMO the two patches after the revert should have no problems to be accept=
ed
> as they restore the functionality we already had in 6.19-rc1.

Yes, I think so.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--f7gq2rb2kk5jlaqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlgyQoACgkQDHRl3/mQ
kZwV0ggAk5KWV5k0g6gBke4/MEFnKIJ9RySx/MigXwWDiKIXcp/Q+qb1jS7z1utu
7Nrudtpk8/umndCo3gjdGrDdGdwm/hOHf6uEm9RjdMoIsy6tps/V4Qvdz8PNDAdF
2IzXqS8QZggTrl9Ozujk6oKMU9rGwHw7uPPYoMwUtpFsqM82GYf74/LhE7CT18ne
xsXp4UtBG+K7Tlozv5NI4h9+OdSNtfYBmI+BruJbaMrb5TBVbHTjSAd0B1kZLzmv
6iDuo29VFiDj/zafLgXKLrWsjx9uzOyTM7SeHkJ/eo3rpAl1EipIBJgW+V17ohx/
2NG6HfHQMlvX47s6Ugcqhwy/C6wvRg==
=nVXD
-----END PGP SIGNATURE-----

--f7gq2rb2kk5jlaqo--

