Return-Path: <linux-can+bounces-5205-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262EBE92E4
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 16:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10E584F958E
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3C833970D;
	Fri, 17 Oct 2025 14:22:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857A3396F3
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710979; cv=none; b=rKsZETX5A6U0dGICB25P+gcaGBoVxe+tasilfMvVpeut9u36X30Y1DaE/ME8JMhoOc8vnKzPwJI5Vty4FNhNAWdg/Gve+gJfJFpc+4jllnYDt/NTCl05a325V/FjMKFyLbxbyKgJsqLbF80m36vkW33Q4lcHKMxk880Gjj9fO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710979; c=relaxed/simple;
	bh=SYIHGf6m73xHlhNo8BXF7fNULMV8Yi3AmyB/w3cDH7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQqAO7v0OPs6WFda5WgPv95QFTE6dbYXSUiO4CgyeJik4Mb652SC1ch4zoDQg5b3oXztPn73jSagBTW2EYvcEZMpcusi8vCHyhqaroq48Z/TjTULWkvOuqhTTN2djsKUAoAnOiNxKr/xsRHfWbuVt/FxD6X0zRvFhyQISLoRq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9lM3-00054V-Rk; Fri, 17 Oct 2025 16:22:51 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9lM2-0044Yj-2H;
	Fri, 17 Oct 2025 16:22:50 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5D88A489214;
	Fri, 17 Oct 2025 14:22:50 +0000 (UTC)
Date: Fri, 17 Oct 2025 16:22:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Vincent Mailhol <mailhol@kernel.org>, Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH 0/7] can: m_can: various cleanups
Message-ID: <20251017-fervent-encouraging-oxpecker-3b09d4-mkl@pengutronix.de>
References: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dv3yr3mdgpvnj5et"
Content-Disposition: inline
In-Reply-To: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dv3yr3mdgpvnj5et
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/7] can: m_can: various cleanups
MIME-Version: 1.0

On 08.10.2025 21:07:35, Marc Kleine-Budde wrote:
> While working on the m_can driver, I created several cleanups commits, ma=
ke
> m_can_init_ram() static, rename hrtimer function, convert debugging and
> error output to netdev_(), replace open coded register write by
> m_can_write(), remove not needed error messages and sanity checks and don=
't
> wake up hte controller during m_can_get_berr_counter() if the interface is
> down.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied to linux-can-next.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dv3yr3mdgpvnj5et
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjyUTMACgkQDHRl3/mQ
kZxDlAgArmuBGKJo7AoMWxkFPkgIJr/FCX1WSMJRQCJvttQYzVLAwDhZX3eWWdpt
krw+uB3169PQ/05/IPmE5OmsGqEctSV4Vj+AImXFdDaseV9VmZVgHldHgy56C0a8
HBG3mgkYPyuN7KKNcrJ65rQI5Y5bhf56q+QZbxgG/sco00lkbgRP9O7iJOjYMFdc
7Tca9GXjJ9Mmw+vtvTqv+IdSiYLdSybh/1VMdlsocSKkg1IXEa3iEMKctmPwRUMa
zFvs0tTCm0MIlhonQnnlvcOiBWz7lTHiiluE1Z0rUz0RTnRb7lm6e/+iYEa8mzwW
a91gCOwp3ReyZNQu2O5QCAJZYGvVjg==
=zXe6
-----END PGP SIGNATURE-----

--dv3yr3mdgpvnj5et--

