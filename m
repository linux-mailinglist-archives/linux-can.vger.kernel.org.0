Return-Path: <linux-can+bounces-6191-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3FCD38626
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 20:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B08F301D943
	for <lists+linux-can@lfdr.de>; Fri, 16 Jan 2026 19:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9664834105D;
	Fri, 16 Jan 2026 19:43:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435BA34C140
	for <linux-can@vger.kernel.org>; Fri, 16 Jan 2026 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592637; cv=none; b=tqkBofEC/nvoMSA6Udy62sAD8zLlvTFDYZz5o5bCBgtugI2YHq3EzH3ANRKneeEs4SojUlHLslIKor9wmvw1C+j4MIPGyffSiOFLnGD/ZVYcxERurZFv6n1g4MMRynEIIF8Oc8KZYyxV2m3xZuGIpNK83HGLtks145edW3tMQEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592637; c=relaxed/simple;
	bh=wmvTCWoMQJqTgx4hgtZ5LKPpnkL02H/2WdAcTMwFMWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDriKnL8zej+IjRla/owgwUtzEIiRcPeGD9XWYZVcIB9NoAecgEgKAk4nXMy5dD+fwwd6sZ4mau7bOmUZgR2w5bQPiO8g4HlHJ/7idJQQ0AS11Qh+xOAbKMmMuDgygdBsX1fRT/TYwXlW+SMbiYivnTvypp2TO2OW319c3ZZIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgpjc-0001lc-1J; Fri, 16 Jan 2026 20:43:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgpjc-000yKz-0p;
	Fri, 16 Jan 2026 20:43:51 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5716F4CEF2E;
	Fri, 16 Jan 2026 19:43:51 +0000 (UTC)
Date: Fri, 16 Jan 2026 20:43:51 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): unanchor
 URL on usb_submit_urb() error
Message-ID: <20260116-certain-spicy-ibis-48e797-mkl@pengutronix.de>
References: <20260116-can_usb-fix-reanchor-v1-1-9d74e7289225@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zhxpk23yqymtabux"
Content-Disposition: inline
In-Reply-To: <20260116-can_usb-fix-reanchor-v1-1-9d74e7289225@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--zhxpk23yqymtabux
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): unanchor
 URL on usb_submit_urb() error
MIME-Version: 1.0

On 16.01.2026 18:00:31, Marc Kleine-Budde wrote:
> In commit 7352e1d5932a ("can: gs_usb: gs_usb_receive_bulk_callback(): fix
> URB memory leak"), the URB was re-anchored before usb_submit_urb() in
> gs_usb_receive_bulk_callback() to prevent a leak of this URB during
> cleanup.
>
> However, this patch did not take into account that usb_submit_urb() could
> fail. The URB remains anchored and
> usb_kill_anchored_urbs(&parent->rx_submitted) in gs_can_close() loops
> infinitely since the anchor list never becomes empty.
>
> To fix the bug, unanchor the URB when an usb_submit_urb() error occurs,
> also print an info message
>
> Fixes: 7352e1d5932a ("can: gs_usb: gs_usb_receive_bulk_callback(): fix UR=
B memory leak")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/all/20260110223836.3890248-1-kuba@kernel.=
org/
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zhxpk23yqymtabux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlqlPMACgkQDHRl3/mQ
kZwFzwgAr6LF6bUngxyc8Rz8ChBvRWyg4gEKRPWuMjXTOigq0LCOSewxGwSUzCAm
I74OkeFaLkqIrNcm/ZKq/8UcM/JCxzkl2z/7LXpepFWufrhs/BycVrF4/U0qz5EK
1XSPHR2QVgZoizu4e6RDVcT6rcN3shO/LjS5kk5KveopbOHcsbCWl9zYOh10cj9a
/pIL4sV/G09NFNXCHpQuzkUYKJWwb4THOgSvCCektCedP7SRYvmaSdi5sms0M5s+
WtHmWgoLi3XDwMKu5W+rPTu1W6ALuKvYvsFxgPlSUGL5R614szLBRAxUiiaKim1g
tAJBBG9tlvLOsap6/ZN8OtK/57xlTw==
=+EPC
-----END PGP SIGNATURE-----

--zhxpk23yqymtabux--

