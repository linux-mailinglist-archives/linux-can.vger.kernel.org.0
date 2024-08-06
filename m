Return-Path: <linux-can+bounces-1154-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A219498C1
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 22:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4621282DAE
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 20:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9B6EB4A;
	Tue,  6 Aug 2024 20:02:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE238DD8
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974559; cv=none; b=EzJBQeL1HSP8lUcVQJ9gTkD5MrY7ORyxq8Gdcup94KkUrQT+/nRqiF+dOtLz44XViGlBpigAVR6GdKQlfiWGugHdvmJdn70amvpyzvBoTrIhkODsM32lgyosZrcU+DHL4jPDR9mxJIeBmoWIhxgI5oEsCX+F9e/Zsddlqmjdl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974559; c=relaxed/simple;
	bh=26g9Ojmfp/XWsHZOBrHzTOF07DGuNxqX2cmP6duZhec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZC55TyIiAZn+qMMsLrr5jXUoZRwHKUK952B3By1Y/GbJBmxEwCl05JSDG1ZqYY8eQDQkrMoPnt4YhB2u82DuIbwdsU8TQo5da25SAo78Agf+kZoh7j5m7iW7MDciLhuqt3IyNhT1vMoYQ5dcaFnjrEsvqJnFCSVd8ITIDEXVkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbQO2-0006ca-Cw; Tue, 06 Aug 2024 22:02:26 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbQO0-0051lx-Pq; Tue, 06 Aug 2024 22:02:24 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6C38431837B;
	Tue, 06 Aug 2024 20:02:24 +0000 (UTC)
Date: Tue, 6 Aug 2024 22:02:24 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Anup Kulkarni <quic_anupkulk@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, thomas.kopp@microchip.com, 
	mailhol.vincent@wanadoo.fr, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com, quic_vdadhani@quicinc.com
Subject: Re: [PATCH v1] can: mcp251xfd: Enable transceiver using gpio
Message-ID: <20240806-industrious-augmented-crane-44239a-mkl@pengutronix.de>
References: <20240806090339.785712-1-quic_anupkulk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2namxbm3ltw7rz3l"
Content-Disposition: inline
In-Reply-To: <20240806090339.785712-1-quic_anupkulk@quicinc.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2namxbm3ltw7rz3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.08.2024 14:33:39, Anup Kulkarni wrote:
> Ensure the CAN transceiver is active during mcp251xfd_open() and
> inactive during mcp251xfd_close() by utilizing
> mcp251xfd_transceiver_mode(). Adjust GPIO_0 to switch between
> NORMAL and STANDBY modes of transceiver.

There is still the gpio support patch pending, which I have to review
and test.

https://lore.kernel.org/all/20240522-mcp251xfd-gpio-feature-v3-0-8829970269=
c5@ew.tq-group.com/

After this has been merged, we can have a look at this patch.

It might actually not be needed anymore, as we can describe a CAN
transceiver switched by a GPIO in the DT. Hopefully we don't run into
some crazy circular dependencies or similar issues.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2namxbm3ltw7rz3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmaygUwACgkQKDiiPnot
vG9+QQgAggrdk32CWlLAoZBayn4qT025uirjqvwMZlzCEGSvX9lMXPfzM1dnOwRh
8IK+cKSJMGE3ntnzj/2MSlm9P/PPgNvoysPDzDgf82FYiVRMzl5EWFXZQxeh3kLT
ORG/syZSKhSvI+EfKRV9vVF7jPUi4Ibkvk8dvfNSvY9NZEiimHnH4YFXwe5guaRt
xBmx37tijZDyHprPDD4TAUmUk9v5dXu7rjZDAbBZwayhRyD4ShSnEfu1vmr8bWaI
hg2pT9jpQSWXaaPk02EoTb6yfh8GcFT3TfnBdpajWJMdZ0Pz/4jzihR7UKkwI0q1
qASw8iKfTE3sO2ALEdyuRqmaM0ZQjA==
=rN/9
-----END PGP SIGNATURE-----

--2namxbm3ltw7rz3l--

