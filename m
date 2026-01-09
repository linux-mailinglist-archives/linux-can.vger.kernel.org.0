Return-Path: <linux-can+bounces-6088-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC859D0AE3B
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 16:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14C63300B375
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EA1363C60;
	Fri,  9 Jan 2026 15:25:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F159363C5E
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972318; cv=none; b=PFsMoymnGuo1yUliuak3MURF14CXLmI1AvcJphQDLtUDScRO3ORlzwtdwjvvvF4EsH64kcDFXVvDmY+ul7FdsNa7pQEkbTSdf694yuh3GV/eQo2eV6Z9ExUHULyjEGZ1FfA6hKsWDAF8cbqtT4q9Z98gzTq3Vjn0mkTAaQAbBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972318; c=relaxed/simple;
	bh=/6ilq4FSPArR9l0V24OI6/WSOBF+7LG3fP5NvLoTm9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frxxke7QAbYua/KvS3ShJ+xlYPQ0ExdTvu1qXOLzc7Z+IZ2RRbyO9jpxhu7JbD7mC6rqT9vOeNFOO30OKwz9QeJL+wrls7EB0UEZUNM9TWADl52JkpoKx2NNBnVriNy/peo9jxzBrjUF6q7vjNMnXcNUunqGpPslIXg05bOpt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1veEMU-0004LN-Ve; Fri, 09 Jan 2026 16:25:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1veEMU-009rpj-2K;
	Fri, 09 Jan 2026 16:25:14 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 563F54C9AAC;
	Fri, 09 Jan 2026 15:25:14 +0000 (UTC)
Date: Fri, 9 Jan 2026 16:25:12 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH 0/3] Revert "can: raw: instantly reject unsupported CAN
 frames"
Message-ID: <20260109-therapeutic-true-rattlesnake-7477e1-mkl@pengutronix.de>
References: <20260109144135.8495-1-socketcan@hartkopp.net>
 <20260109-overjoyed-refreshing-eel-f887b6-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="azl6venxzgxtxaaz"
Content-Disposition: inline
In-Reply-To: <20260109-overjoyed-refreshing-eel-f887b6-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--azl6venxzgxtxaaz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] Revert "can: raw: instantly reject unsupported CAN
 frames"
MIME-Version: 1.0

I've given the series a more descriptive name: "can: raw: better
approach to instantly reject unsupported CAN frames"...

On 09.01.2026 16:19:48, Marc Kleine-Budde wrote:
> On 09.01.2026 15:41:32, Oliver Hartkopp wrote:
> > This reverts commit 1a620a723853a0f49703c317d52dc6b9602cbaa8

=2E.. and replaced this by: "1a620a723853 ("can: raw: instantly reject
unsupported CAN frames")"

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--azl6venxzgxtxaaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlhHdUACgkQDHRl3/mQ
kZzZkgf/XJ9CRA6N4/C7mnkSPvGC/Wzb05zW4d2rNIm9s1YttSpEyRiNslIQkQQL
QFTSyL39Cvck/Iu/M+jh3xODEMsWiDvOKs8w6yzMGaoAjyA99vt1Z0nmOm3wC3Gs
Ue1zPjUnaHBkknq9Ua2x+e/gQpALZJrL4eMnh8hZN3d5UFWRFJxkkzLfaLPkWziA
lTF7gL3ApxmYGqmr/5Ro6Tjm/hJ0qSznWnlTCrbl9LYgScJI4tAArKfTyXivalse
eHTj9WsaAXxRp5l7W0G7aE8pyYWBPisNDKTsjzIQPPbhI0whjZCtlStx6m5yva49
gFjhqgUhI3f0QMviQfxQw27jYwkwIw==
=7ssB
-----END PGP SIGNATURE-----

--azl6venxzgxtxaaz--

