Return-Path: <linux-can+bounces-6154-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2ACD2351F
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 10:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E996230066D2
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 09:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9550B33F38D;
	Thu, 15 Jan 2026 09:00:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F98340DA4
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467613; cv=none; b=Ch8dZWgetmf2oE/K+zEnYdyZUWTxGmkrjLtGNJZlLQFEF9F/SQu6Gb29o3PCwJ5cs6ewjHzHkXSyP5pWEErdI95yHrYqWHJtevivfCE/EWndzgewAINk+N/kaC5CKSTSBTFjIxWqPQ+l0w8J6moILyKKsmf7oczqGCxyUVVKtZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467613; c=relaxed/simple;
	bh=N51LlDUpjO6nG2AB/FIFj/rA+OEhaQnY6r/uTqJJCMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGt0zpWpyShRvE1fbeVJNbf3t3pYINXOHnhl+TSzqNI8Zh0bSugle8lm5FiLp967XRddegBUMIGahXU0ZgITeuZ3qUuXv0P/zVzUtnBnVn2TSA7h8BWY6NAlYmTPuDVhjAJMornZtQGzXHGIvNFYsGMe1W7yrKH8l2uXtA9aHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgJCy-0003ED-G1; Thu, 15 Jan 2026 10:00:00 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vgJCx-000izc-1M;
	Thu, 15 Jan 2026 09:59:58 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 787A14CD691;
	Thu, 15 Jan 2026 08:59:58 +0000 (UTC)
Date: Thu, 15 Jan 2026 09:59:58 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, Arnd Bergmann <arnd@arndb.de>, 
	Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH net 3/4] can: raw: instantly reject disabled CAN frames
Message-ID: <20260115-cordial-conscious-warthog-aa8079-mkl@pengutronix.de>
References: <20260114105212.1034554-1-mkl@pengutronix.de>
 <20260114105212.1034554-4-mkl@pengutronix.de>
 <0636c732-2e71-4633-8005-dfa85e1da445@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qbipjlflq6gvwbe5"
Content-Disposition: inline
In-Reply-To: <0636c732-2e71-4633-8005-dfa85e1da445@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--qbipjlflq6gvwbe5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 3/4] can: raw: instantly reject disabled CAN frames
MIME-Version: 1.0

On 15.01.2026 08:55:33, Oliver Hartkopp wrote:
> Hello Marc,
>
> On 14.01.26 11:45, Marc Kleine-Budde wrote:
> > From: Oliver Hartkopp <socketcan@hartkopp.net>
>
> > @@ -944,6 +945,10 @@ static int raw_sendmsg(struct socket *sock, struct=
 msghdr *msg, size_t size)
> >   	if (!dev)
> >   		return -ENXIO;
> > +	/* no sending on a CAN device in read-only mode */
> > +	if (can_cap_enabled(dev, CAN_CAP_RO))
> > +		return -EACCES;
> > +
> >   	skb =3D sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
> >   				  msg->msg_flags & MSG_DONTWAIT, &err);
> >   	if (!skb)
>
> At midnight the AI review from the netdev patchwork correctly identified a
> problem with the above code:
>
> https://netdev-ai.bots.linux.dev/ai-review.html?id=3Dfb201338-eed0-488f-b=
b32-5240af254cf4

Is the review sent exclusively in a direct email or available in a
mailing list?

> Can you please change it in your tree and send an updated PR?

yes

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qbipjlflq6gvwbe5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlorIkACgkQDHRl3/mQ
kZxFDwgAtJk3auYuCN0/h3rwhtIEXDOljJS5FzyyxvuE1OXi6h++4hv+Ux0rrpMH
/+h1E9tv7qR+bbkFalfBWfOrcjsbpyb4ElrKwKAbWvTPmeBfSmZ6BlNqmNUlRNt6
Wkxs2p6ZdMChxk+p17mj9k+jyG/bXpwNp+3QUZY0FJYw4OAop3DupQZABFjaBDrX
gjTHGJ2etR6/CG5dZ32ndk2SVIimq51YCj0Li4nvhb16I2MFaHX3MsEsSOYcK4R2
PesQqDbCa3UmN4L3/pDw77u4vAfkuplD0b5LTbCkrvesbkQua4apVykpGG5xECFw
lsk1HYc9o5bfX8ZkStxDAeSV+blvQA==
=/ihj
-----END PGP SIGNATURE-----

--qbipjlflq6gvwbe5--

