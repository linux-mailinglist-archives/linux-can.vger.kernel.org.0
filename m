Return-Path: <linux-can+bounces-3056-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCB3A60C0C
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 09:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D003B6F9A
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618EA13B29B;
	Fri, 14 Mar 2025 08:49:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ECB19D8AC
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942149; cv=none; b=J4x2zE8UDNVC6rGVGtUKYGM/NVbfmDCOIOXNnxCcx6m5yAJE5JBmN+i7+Af+pYbj8jKsxcEK8vee5uXX41mRjSdC0IBlNkCsq1L/V5+ps1wxOy+Kga+KItegzNNcNXXcIGj4M7oQj9v3Q0cAu16cb5HlEqcguVhwKLUzS4gdMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942149; c=relaxed/simple;
	bh=Ykf2hyLE1t4CLUAywotOc3hjOESc2yvYnoikikp7Ut4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZnFB+vfAm1kQkmHkhoeg7+jEC4RDZV8cwXk9UyJsrxBsIiCRdBpUpbRiN8LZBDdRKm4QwRSejUNRpy98PmkN3BcEKLodiM2ROG/+eHXhrJ5ldMD1KRD0ucBWwKdoW0tHdlq0v2ieMf+672wSGLwpAEE7S9wlGOZm8qM8iLU9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt0j3-0006uu-Jy; Fri, 14 Mar 2025 09:49:05 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt0j2-005flv-0w;
	Fri, 14 Mar 2025 09:49:04 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F30BD3DB830;
	Fri, 14 Mar 2025 08:49:03 +0000 (UTC)
Date: Fri, 14 Mar 2025 09:49:03 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, 
	syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com
Subject: Re: [PATCH] can: statistics: use atomic access in hot path
Message-ID: <20250314-rapid-pastel-fulmar-d66126-mkl@pengutronix.de>
References: <20250310143353.3242-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kgew7zp72wkgmpen"
Content-Disposition: inline
In-Reply-To: <20250310143353.3242-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--kgew7zp72wkgmpen
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: statistics: use atomic access in hot path
MIME-Version: 1.0

On 10.03.2025 15:33:53, Oliver Hartkopp wrote:
> In can_send() and can_receive() CAN messages and CAN filter matches are
> counted to be visible in the CAN procfs files.
>=20
> KCSAN detected a data race within can_send() when two CAN frames have
> been generated by a timer event writing to the same CAN netdevice at the
> same time. Use atomic operations to access the statistics in the hot path
> to fix the KCSAN complaint.
>=20
> Reported-by: syzbot+78ce4489b812515d5e4d@syzkaller.appspotmail.com
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--kgew7zp72wkgmpen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfT7X0ACgkQDHRl3/mQ
kZw5eAgAlRs6L/NP4eigW2ElIFOHGXryw0Eweol5292HSogPM1IExPK5hhneGl6V
Gii14Cp58GgGdVKMf0byiE59WYNMkg5dvrg/cCh4lWAxxn2+DJ3rZM/10jMQIjNI
w4G3PbOtHVQZ8pHyNt3gD/0gYj8HzL5p6GVKpCLdZ08AD4ympwHCjKl5aaNAXt5Q
fJBvD2CTAqVma6vrBy6FdbYUBTB1ch2QYKdd/ituvZHe3rBhUwkQBgv4qc3vTmEQ
tvP0YBXAeJoIjwY7AyuiZYrv4h5pbXMufnsZorisFtAWFBAIrsK41WXH2Nr82hCv
bClxRbB867uVjqfVW5YnIJYEodnXNw==
=aLB9
-----END PGP SIGNATURE-----

--kgew7zp72wkgmpen--

