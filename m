Return-Path: <linux-can+bounces-6135-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA68D1E282
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 11:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B130300D152
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B497F37F729;
	Wed, 14 Jan 2026 10:38:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D78F1E98E6
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387092; cv=none; b=DZcxHgZlu1eLBYwRVhxU7/Z5h1xNWbUu1/SwI52luRqDej0W08eLLyzDYs6V0cCIUr/id1luccknWbdLP7CNJQ881FlRbLbAMpQlZx5+27PjkOaN6wE0po+lhdiPb/QxsxnxwiJ1uGGjqVuXeN+GW5y+pqh1pG+bPRboN1mksh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387092; c=relaxed/simple;
	bh=ZQRQcXhdqzjm6TfP10qgp8HkEHaeqyb9YyObwwnOqgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkMwvbFt99PYVMJLbHk2JSh5E4R8ZLuB9bX37T63lwxa/k1LloyOFmOsOqvWBH3omNGsvrn4Bo7U15YBiRc22W6xoX+OOJFVbzMTTbIZqaNrO/HSpM+Des7UjH0RnA/Q6Wa2wzfw+Uhb+j2CT0TminQQdHr4ir7SQl2/dp46E24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfyGO-0004oQ-Eh; Wed, 14 Jan 2026 11:38:08 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfyGO-000Zdb-2U;
	Wed, 14 Jan 2026 11:38:08 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C01F14CCB45;
	Wed, 14 Jan 2026 10:38:07 +0000 (UTC)
Date: Wed, 14 Jan 2026 11:38:07 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] can: j1939: deactivate session upon receiving the second
 rts
Message-ID: <20260114-super-raptor-of-faith-028865-mkl@pengutronix.de>
References: <faee3f3c-b03d-4937-9202-97ec5920d699@I-love.SAKURA.ne.jp>
 <4b1fbe9d-5ca2-41e9-b252-1304cc7c215a@I-love.SAKURA.ne.jp>
 <aWZXX_FWwXu-ejEk@pengutronix.de>
 <b1212653-8fa1-44e1-be9d-12f950fb3a07@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wulqw52wvyifis3o"
Content-Disposition: inline
In-Reply-To: <b1212653-8fa1-44e1-be9d-12f950fb3a07@I-love.SAKURA.ne.jp>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--wulqw52wvyifis3o
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: j1939: deactivate session upon receiving the second
 rts
MIME-Version: 1.0

On 14.01.2026 00:28:47, Tetsuo Handa wrote:
> Since j1939_session_deactivate_activate_next() in j1939_tp_rxtimer() is
> called only when the timer is enabled, we need to call
> j1939_session_deactivate_activate_next() if we cancelled the timer.
> Otherwise, refcount for j1939_session leaks, which will later appear as
>
>   unregister_netdevice: waiting for vcan0 to become free. Usage count =3D=
 2.
>
> problem.
>
> Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.co=
m>
> Closes: https://syzkaller.appspot.com/bug?extid=3D881d65229ca4f9ae8c84
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to linux-can.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wulqw52wvyifis3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlncgwACgkQDHRl3/mQ
kZx//QgAj3nYTf855T00r/TTYBHOdN8gbgn6oTrP6Eg6aJOUvy1x5Gx9As8i2ww+
Cro13LWdoeiMqBdpPJRXDPNK2rMZmjkLivlEJOJKUEySdecirrlrYfU8lw2zU+XX
r0deQgJMvk3E4KkQJ6JpS5xRTMguE75R57SJGGGHuLyCZK+QDwOhajYmK46vJ0oQ
JrQzw8m0K8BpuosCIVzQ+2+swDNloJtuJmvnkKkktHKBf5NfqO7KW0MOwpJAYnHD
ekY25XtEZ1GuxGDfsSCADwfIlXNByGGPuVWDFKQOPPZweUk20EOH7pH8L8kWEzxs
FrqcE0AD01YLjEMpZ22DV6TMZsgCNw==
=Og+g
-----END PGP SIGNATURE-----

--wulqw52wvyifis3o--

