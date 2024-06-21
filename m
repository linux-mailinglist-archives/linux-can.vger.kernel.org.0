Return-Path: <linux-can+bounces-825-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D983911EC7
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25E81C20BEC
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FFD3EA64;
	Fri, 21 Jun 2024 08:30:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A44168C3F
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958624; cv=none; b=tpfHlAbK3HPNKiM4jrWuzUJxZ6BFg4fRXZFfGDeiqVSuSzKMptvLZ2nlPJz6V+QKsfUDq5Xk5NmxIxBpP7KvzPLl7coYjVhZHOJmMm8ZzkBk2MRV8K5RZ2Hr3StLSpRDYaU78KET9wgzTvX9cld5v9Uil8QHZyRMK8Z7KbJGPUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958624; c=relaxed/simple;
	bh=C7qnlFRvJKxuce6YIfz8yqFM63eLWrnuHKW1satKhMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTG1vJqiLWtjOrYvDJ7a5NtKOFZkjKzM7zNMhQ/+91CPVCrP1b/V0vxFuUc9atAEdcpth3+o2bUK1H+/1z/sv5zLSSyzjimSmPLPKePEOHg7ynVRO1PaJZw0D/8mpGqeOIrfi5q1SQKj5FCtiWVDBRSMnkwe9GHSMQQRMnMFn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZf0-0000Av-Lq; Fri, 21 Jun 2024 10:30:18 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZf0-003toN-3m; Fri, 21 Jun 2024 10:30:18 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B86A02EE569;
	Fri, 21 Jun 2024 08:30:17 +0000 (UTC)
Date: Fri, 21 Jun 2024 10:30:17 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Martin Jocic <martin.jocic@kvaser.com>
Cc: linux-can@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	extja@kvaser.com
Subject: Re: [PATCH v2 2/2] can: kvaser_pciefd: Add MSI interrupts
Message-ID: <20240621-fanatic-cuddly-gecko-8125d0-mkl@pengutronix.de>
References: <20240620181320.235465-1-martin.jocic@kvaser.com>
 <20240620181320.235465-3-martin.jocic@kvaser.com>
 <20240621-giga-gopher-from-uranus-230ff0-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2gq3vwsti6w57gww"
Content-Disposition: inline
In-Reply-To: <20240621-giga-gopher-from-uranus-230ff0-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2gq3vwsti6w57gww
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.06.2024 09:12:45, Marc Kleine-Budde wrote:
> On 20.06.2024 20:13:20, Martin Jocic wrote:
> > Use MSI interrupts with fallback to INTx interrupts.
> >=20
> > Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
> > ---
> >=20
> >  Changes since v1:
> >   * Implemented review comments from Jimmy Assarsson:
> >     - Add missing pci_free_irq_vectors() in kvaser_pciefd_remove()
> >     - Replace dev_info() with dev_err() when reporting errors
> >=20
> >   * Implemented review comment from Marc Kleine-Budde:
> >     - Replace deprecated #define PCI_IRQ_LEGACY with PCI_IRQ_INTX
> >=20
> > Thank you for your comments.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2gq3vwsti6w57gww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmZ1OhYACgkQKDiiPnot
vG92IQgAgl7qTVRL3aYzWjkbPHEsq750yE6Xf5a4hylVotIDWtpf3kZgJGXbtcaH
1tNUugDaz7KwLIhsNLBqDj2oM4zLMq1zlFkXTAvpLOjouPxJzaeIUOmtnHt//7PU
J7upBSgU0hSzMqSqK7ZEWCX7rRAIZuns5e8kCOkRzYkGV3zt09RLi5wp1o/mTd4a
xWSvS0a7FNjkRVaqDUt5ODTtHKMj9C6tpxeZ71Hkms9sNuhh4s0YjXqA9GNpnOav
SE0PDMcxeWqRmXggWszC+I0XKTaC7mniN6dp6fVHbHRbpNNhF7X5LZOStvMkWDXP
81kh/sn9LjXK2QKczpQZ9WFbpD828g==
=+awH
-----END PGP SIGNATURE-----

--2gq3vwsti6w57gww--

