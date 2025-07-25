Return-Path: <linux-can+bounces-4119-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CA4B11A41
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 10:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B19E170CC8
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B71221703;
	Fri, 25 Jul 2025 08:51:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B21EDA1A
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433515; cv=none; b=jNJvp6HuYSNwPZZ2q/pQf+CJfpPpbv/9NMyE4ol17bOTq9XBKx/h0KqXy8AnsjEUdYzLSJRQ47qkHGNjrHsxA+07VHjtJLSmfrizPp2NPcGXGY0BenMU4z3gOIL1qRM+qz5yLBzVlbymF10q2UJV93NIQyrktneV5qT4GXtCOdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433515; c=relaxed/simple;
	bh=krHuaO35W9bhEGRE8djxxabvNCe4+fTRyBw9hZJ/P3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixlt8vz9ysjJZ85l/TPkgC5mo2FSQCH/WPFIMieyLMVahucF3xA7KzZCKOPd7hmXrcYtt5Eaa7egl9Wn7z1HwI4bSqzY/RuRkuXfH3NoEFCNZtSSAk46ykQ0BDEmaD6JyIxEo16zchv+qhq93exHyFA3YIoO5ZLUl7ozWQZV+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufE9d-0003lE-Cr; Fri, 25 Jul 2025 10:51:49 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufE9c-00ABrD-37;
	Fri, 25 Jul 2025 10:51:48 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 989144492F3;
	Fri, 25 Jul 2025 08:51:48 +0000 (UTC)
Date: Fri, 25 Jul 2025 10:51:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/10] can: kvaser_pciefd: Simplify identification of
 physical CAN interfaces
Message-ID: <20250725-furry-precise-jerboa-d9e29d-mkl@pengutronix.de>
References: <20250724073021.8-1-extja@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ti3ks7o5nqqj7rie"
Content-Disposition: inline
In-Reply-To: <20250724073021.8-1-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ti3ks7o5nqqj7rie
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/10] can: kvaser_pciefd: Simplify identification of
 physical CAN interfaces
MIME-Version: 1.0

On 24.07.2025 09:30:11, Jimmy Assarsson wrote:
> This patch series simplifies the process of identifying which network
> interface (can0..canX) corresponds to which physical CAN channel on
> Kvaser PCIe based CAN interfaces.

Since Linus is traveling during the merge window, the last PR for
net-next should go out today. If you manage to send the next version of
the pcie and usb patch series before about 16:00 CEST, I will send it
out today.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ti3ks7o5nqqj7rie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmiDRaAACgkQDHRl3/mQ
kZzRuQf/d2ldwRhcsFUtm2Q8BeuxR9dxfSPi1TzSMnpALwVrBDCD2VN94Ulja7eI
tJK9+Qn44oSWBnKf2LM8DDSIZEL69bbZg8tRyw2g/ePpujNn14hU6Tf+P4PC+bqf
txiwhy1gvQXB5zEUGBSdaLPUS7alFL1n0hnGbQJPCriKxol95nGv2/hxHHwWzm/v
Ir9V1Mg8FtKYSMGwGAKVdTDu0bBoADQfyPULM/Pe36zy5vK/eW5F0qZWSkT576xX
0RA57Z2VDXO9EGGt7WwOqpElib71kwCjigLlIicl9m/QqIpU8HvcvJWxbfJoLoWY
WjP5FgasSGu1QTORTwKWofHVhFdiEg==
=tNH+
-----END PGP SIGNATURE-----

--ti3ks7o5nqqj7rie--

