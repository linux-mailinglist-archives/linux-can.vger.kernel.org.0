Return-Path: <linux-can+bounces-2276-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538299DE6D8
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 14:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F3F2824B5
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F871A00C9;
	Fri, 29 Nov 2024 12:59:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06781A01CC
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885174; cv=none; b=Yo0ahbBoizV42IcDrhOu5dyjHQ/EAKvOn52Nxj3YqJLKOogN9vxrVvoOmk5s68wKSj/G0zTIpNd9WR4VXnVZOh+lMTAdjkuMT5niuE2i2irIGwJ7ErfeNFrimJyNU5nUTLrhJRZo3SBP8X7VVjqtVCBu/eCfiK3i56B26v0t+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885174; c=relaxed/simple;
	bh=ajZlqTOjVIvZXilK9+F2snwFCw86LVpPnQHMGyjhqbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+ZC7NURsrnaMSAw8CYyfzxqfF5lmiDRsnOHa7obceMnq7DlaAF3E0fD+jWwXbkA2Q2Ptd8MDsAcbLsAmUD9D1hTOW8JN6oboqVyjzOJwhADJiBT1xy8H/U7+GM9fbRBm4IjgxgvStIa3g1cejp7dL4M4dwNS/N8YAmQDvHN15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH0an-0008C2-AQ; Fri, 29 Nov 2024 13:59:29 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tH0am-000n3V-0w;
	Fri, 29 Nov 2024 13:59:29 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AEEBB381266;
	Fri, 29 Nov 2024 12:59:28 +0000 (UTC)
Date: Fri, 29 Nov 2024 13:59:28 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, 
	Robin van der Gracht <robin@protonic.nl>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: fix skb reference counting in j1939_session_new()
Message-ID: <20241129-poetic-snake-of-recreation-32e05a-mkl@pengutronix.de>
References: <20241105094823.2403806-1-dmantipov@yandex.ru>
 <Z0m53JjLCTEm7On8@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nllt2tnzj4yrt63h"
Content-Disposition: inline
In-Reply-To: <Z0m53JjLCTEm7On8@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--nllt2tnzj4yrt63h
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: fix skb reference counting in j1939_session_new()
MIME-Version: 1.0

On 29.11.2024 13:55:56, Oleksij Rempel wrote:
> On Tue, Nov 05, 2024 at 12:48:23PM +0300, Dmitry Antipov wrote:
> > Since 'j1939_session_skb_queue()' do an extra 'skb_get()' for each
> > new skb, I assume that the same should be done for an initial one
> > in 'j1939_session_new()' just to avoid refcount underflow.
> >=20
> > Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dd4e8dc385d9258220c31
> > Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>=20
> Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Can you re-phrase the commit message. The "assume" is not appropriate :)

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nllt2tnzj4yrt63h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdJuq0ACgkQKDiiPnot
vG9WmQf/Xri8Lr0sxN03VRlwe+6Mi7jxfvaDuIwiaLufZPMR5TsvsRncPNoVWECi
XtLqdTwtCamQ/Qh2aMeghgRowUYtYXtwONWm08DNFjMPyvoisb6k8A4Wj4X/kz+3
RMXIrOMo45QKv/mM/unTQdQrqoCMvn0mDXRYbG6QzSUVq9SbR18pcTzNXIvZhpEL
m0EmeICGciMMPJZqounHWenFGSjF4d+XFcN4HPzih+wcxqVu+3XkHZEmJiwUhmz8
LWkB9erM9AOPYirUr9e3pOkeha3JOHhCeOybfFXRYP5Cm/ACJ77LbGFwWjU93zz+
MaRK6jEneiSWxWEN7GiRB7zHKFphkg==
=F8/T
-----END PGP SIGNATURE-----

--nllt2tnzj4yrt63h--

