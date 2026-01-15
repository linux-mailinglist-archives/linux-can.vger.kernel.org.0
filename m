Return-Path: <linux-can+bounces-6161-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E51D23629
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 10:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74A213007274
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 09:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0462934677D;
	Thu, 15 Jan 2026 09:12:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE130BBBF
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468337; cv=none; b=ft0HsPv2FQXKXSEe7ahdyfIsv7+BxdsxUazLx3310at3nMjbnj18hITtBt00MGEgWQ5XMJxdfc+YrgYfZ+cpOl9VvPaW/TVcdODI4rocT2vXoqMzsdLFMPxVhGrx+sZg26LxAujE1BCFl7zqR4OXNTck7MEpfSsLuOdbK9Gcgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468337; c=relaxed/simple;
	bh=LVvYUTqC/oEI4gN4LmMhQdNkMf8OhpvENex0r8YMyt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkKZiNy5zW/Qx0m8oYtpTYSx0NaEbcgRzhjHecmLeOwDAMdTzFlj7Tmnk75D6Dzfmspna28X6u6z5WkaJ4qIg8p5XuV1LBo1Yn2IfTUILri+jIlyP+ozWWtXhfUUBKwPhUqxInjPzhMS1xs1GK2x0PVGDymSTRX6sGzIPNXvzR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgJOn-0005Xa-Mx; Thu, 15 Jan 2026 10:12:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgJOn-000jHX-39;
	Thu, 15 Jan 2026 10:12:13 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0141F4CD6EB;
	Thu, 15 Jan 2026 09:12:12 +0000 (UTC)
Date: Thu, 15 Jan 2026 10:12:12 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/4] pull-request: can 2026-01-14
Message-ID: <20260115-acoustic-adaptable-cougar-a8cd74-mkl@pengutronix.de>
References: <20260114105212.1034554-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jgx3ky55dpjbc3ss"
Content-Disposition: inline
In-Reply-To: <20260114105212.1034554-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--jgx3ky55dpjbc3ss
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/4] pull-request: can 2026-01-14
MIME-Version: 1.0

On 14.01.2026 11:44:59, Marc Kleine-Budde wrote:
> Hello netdev-team,
>
> this is a pull request of 4 patches for net/main.

This PR is Super-seeded by:
https://lore.kernel.org/all/20260115090603.1124860-2-mkl@pengutronix.de/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jgx3ky55dpjbc3ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlor2kACgkQDHRl3/mQ
kZxeawf9HdIIVePhlbspkufhxAInFz21dJVgFRn24xxTkS3cp6uXcT4U7GfYvgGF
2lM2n/3ZTV2xDsqcDqKKJkxC6X9vZoOLIxO8tHAmG1A5PcUmz+eDyJ231kYu/dU8
HVVTSJhy42jzrLZz7Mx9yNErlB5wX/1KpKHEuhuAZlYvaBLiM5zDX204u0Nd9gt3
3F1qNK2tL7GV6zKToThfAHlWZXy13/2QVhZf869nSpSIR8HGALtpCmzg9fO4nHx2
eldQ4eFXyRrC89rlbqLqaXmH5Jd7XwLUQNmEJ24ppNfnebb3H/qbiYIiusL8tTw8
K1l1fFtWrfptLA8xpUAauljmj6y0HQ==
=oEPJ
-----END PGP SIGNATURE-----

--jgx3ky55dpjbc3ss--

