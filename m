Return-Path: <linux-can+bounces-3580-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26EAABC27E
	for <lists+linux-can@lfdr.de>; Mon, 19 May 2025 17:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690A93B1B18
	for <lists+linux-can@lfdr.de>; Mon, 19 May 2025 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDB82749C8;
	Mon, 19 May 2025 15:32:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2E2741DF
	for <linux-can@vger.kernel.org>; Mon, 19 May 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668739; cv=none; b=U7sZaUU4gZFhjcBAroaBwH5GEMpFpxdpYxcVMu70qZ6rplPfGiguVaPQIIN3OYACTQVtMSGvYw3DIsMY50bjmjyUhOhSrBcyoDpk63qPygz6Ld3JGawgXb2iwcYnB7iCbNRhm+XIMi0erbXC+Uha+0a/+iULMVVpjlA65uqSoRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668739; c=relaxed/simple;
	bh=4BtWMi4vVXtnbbsCIwl7PtH0qxxBu4h5xvX1qw+SUhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhB7gOhAn5EKEF9FjuPRmZJhhrWREjdTWuVtk8taNLvSS5IYAo824ilGMLN6O42aO735USuA/Vy87uMdyqAXvSPNKQ0uflfw0Tpy2uUyRsL/nvdVOPA/R12zCUhQtzoR8XRkSWaDz67BEkRXl/gS4CKNSiP19y2p479t/v0uyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uH2TP-0003Ga-3I; Mon, 19 May 2025 17:32:15 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uH2TO-000GiQ-29;
	Mon, 19 May 2025 17:32:14 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:2260:2009:2000::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3157941532F;
	Mon, 19 May 2025 15:32:14 +0000 (UTC)
Date: Mon, 19 May 2025 17:32:13 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Axel Forsman <axfo@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr
Subject: Re: [PATCH v2 0/3] can: kvaser_pciefd: Fix ISR race conditions
Message-ID: <20250519-magic-fat-cow-ba6fa0-mkl@pengutronix.de>
References: <20250513150939.61319-1-axfo@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f3yf7qie6xvo3ey3"
Content-Disposition: inline
In-Reply-To: <20250513150939.61319-1-axfo@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--f3yf7qie6xvo3ey3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] can: kvaser_pciefd: Fix ISR race conditions
MIME-Version: 1.0

On 13.05.2025 17:09:36, Axel Forsman wrote:
> This patch series fixes a couple of race conditions in the
> kvaser_pciefd driver surfaced by enabling MSI interrupts and the new
> Kvaser PCIe 8xCAN.

Which tree does this series apply to?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--f3yf7qie6xvo3ey3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmgrTvoACgkQDHRl3/mQ
kZwmEgf/VPQBCsw14K4ZaJx+qpB//EqXfLserXYXP3hGUyKR98RWzNsfUq4pGo+T
7kLRGMRsAAe7gdefDcXyLXlbtftl+QLlmUk4u9wrazTm+ylb+zpWIcXMXhKlbEeM
ZikyyjgJTvhxV0RGgt0JgUtzW63/xwlttwXWJ+iuVwxw0qDYKvC8uJtdHDucXKLG
KxzCLBqIpAajiKri0L4IWLhxGDtYiMvwBkT9mnWNXSa74pl6AXeX/TMgAqpOFFOT
6lGP4ObbB/vyhonHuWz+sASwU8ZF+czgzTzRdpGE36pB3v2OMpGMeTmDKRh8Pd5V
4uVzIZMic+IxXHArE6JikO1TJCEvSw==
=EDiu
-----END PGP SIGNATURE-----

--f3yf7qie6xvo3ey3--

