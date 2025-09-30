Return-Path: <linux-can+bounces-5069-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DBABADF00
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 17:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B49E1C774D
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299633081B7;
	Tue, 30 Sep 2025 15:40:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B4A3081C0
	for <linux-can@vger.kernel.org>; Tue, 30 Sep 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246832; cv=none; b=j/IifnZCUCoFp79DeM/bc0uLI9o12ybogqL63zctbYPYOR/YLxfJvtt3lHpOotfy/KT3GxzZYFwc2LnN4QLTgrJCTN2w5+lecEBlNLgvr8NWr9XKyOas7ApTpCl+MDwxgNiYwbf+bxSUxbVhA6MsU8KJZjd4rWu3lnIFKd0mGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246832; c=relaxed/simple;
	bh=08nF264kPnb09l/Vpi/EDkqosub5X+SZ4wkXjGyuHJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1DHI0/+txgD3UR+XHU5qw0z/8t3A0YMaeaGuIMVyGJW05yqWrnAOhIpPRlmNCiF/TMu41lUTa1xhGnKBd078R02KVD/z1RPoOlPY3IjC0+H6XYGzf4as9qUhqcAE5LdT0XvT7rnXMb+vP+uBWWZ1sKTSu6erPTIOj0N4OO0gL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v3cSn-0004af-2I; Tue, 30 Sep 2025 17:40:25 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v3cSm-001Gqw-19;
	Tue, 30 Sep 2025 17:40:24 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EF79F47D51F;
	Tue, 30 Sep 2025 15:40:23 +0000 (UTC)
Date: Tue, 30 Sep 2025 17:40:23 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Maximilian Schneider <max@schneidersoft.net>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] net/can/gs_usb: populate net_device->dev_port
Message-ID: <20250930-adorable-loud-scallop-faed25-mkl@pengutronix.de>
References: <20250930-gs-usb-populate-net_device-dev_port-v1-1-68a065de6937@coelacanthus.name>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lnucko7usyhni2xq"
Content-Disposition: inline
In-Reply-To: <20250930-gs-usb-populate-net_device-dev_port-v1-1-68a065de6937@coelacanthus.name>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--lnucko7usyhni2xq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net/can/gs_usb: populate net_device->dev_port
MIME-Version: 1.0

On 30.09.2025 14:53:39, Celeste Liu wrote:
> The gs_usb driver supports USB devices with more than 1 CAN channel. In
> old kernel before 3.15, it uses net_device->dev_id to distinguish
> different channel in userspace, which was done in commit
> acff76fa45b4 ("can: gs_usb: gs_make_candev(): set netdev->dev_id").
> But since 3.15, the correct way is populating net_device->dev_port. And
> according to documentation, if network device support multiple interface,
> lack of net_device->dev_port SHALL be treated as a bug.
>=20
> Fixes: acff76fa45b4 ("can: gs_usb: gs_make_candev(): set netdev->dev_id")
> Cc: stable@vger.kernel.org
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lnucko7usyhni2xq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjb+eQACgkQDHRl3/mQ
kZypgAf/Xj9cS2TujQe8t0YRmaldbPu6iIqp+AZkIh1VJR5iIfjjMtDJZMmN/CA5
ah97zSKuvE93FnPYChI0lcmICoVZ4k1Gv4R+xywOlPL8ASiuEv48FjVJb9ggPuue
ps/qEVtoJs0MHvEskN0QzI8oMzbYZk8YV/0dMKeipKQjhDM28WUYvpvd8HA1QVag
A3AFhIuyfUq0mjkEJw8nqZUdoo0/tZVze48nMB8Z04rSGrhme6ItjHNvnxsPKQka
Yn35AzxBw82yRtOfE8Wa46yQVh9EhoQIrCvA2lrgFHYF4JmCpyY/KrBMWfIGp8k+
IBVaFfesLljyqTpnQrpPGKX5P7JECw==
=9VQW
-----END PGP SIGNATURE-----

--lnucko7usyhni2xq--

