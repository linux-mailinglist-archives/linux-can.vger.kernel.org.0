Return-Path: <linux-can+bounces-5893-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3933ECD447A
	for <lists+linux-can@lfdr.de>; Sun, 21 Dec 2025 20:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6B143003528
	for <lists+linux-can@lfdr.de>; Sun, 21 Dec 2025 19:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B40235C01;
	Sun, 21 Dec 2025 19:06:59 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD51E32CF
	for <linux-can@vger.kernel.org>; Sun, 21 Dec 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766344019; cv=none; b=bvF4PSKvkB7IKPD4f7T+rxnrLkPlvEsZrNgEJ6hUJMx9ZI9h6iEh/+xd1TRBpOPO4CxJSoHv5qFT6afQZcStp02AHLfxItUwcFki4uqJ1a8XBk4UEPHoKXWjR45flFLVll1vLEXuG8ewF4BeIRK3wnxZfCMX9+4tVQjNwlWmnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766344019; c=relaxed/simple;
	bh=sUKAv7uEe00zZJ4BWIzOiyrzJfaw2w+F8g0SqxlPUhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Esz7CS6AfD5nGEIPEU+xhLDCMJkEjXt3SN4vmPSiBJbaGLJgXFa0ltHasdH4p78GYnXTY+zuBdU0/XxwbCBKEPrcZyniBTV4z2UOucPkXM8HkphMgDaQz5gfMgLkQ3y5iLt+4JwPpGIC7vlF0VrIgJ5xlBgyfn1mA6QmvN3EKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vXOlS-000746-Eh; Sun, 21 Dec 2025 20:06:46 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vXOlR-006oiG-2M;
	Sun, 21 Dec 2025 20:06:45 +0100
Received: from pengutronix.de (2a02-8206-24ec-9200-ea64-e5e7-d732-eca2.dynamic.ewe-ip-backbone.de [IPv6:2a02:8206:24ec:9200:ea64:e5e7:d732:eca2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 35A934BB416;
	Sun, 21 Dec 2025 19:06:45 +0000 (UTC)
Date: Sun, 21 Dec 2025 20:06:44 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, Prithvi <activprithvi@gmail.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	netdev@vger.kernel.org
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
Message-ID: <20251221-ochre-macaw-of-serenity-f3ed07-mkl@pengutronix.de>
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
 <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
 <aSx++4VrGOm8zHDb@inspiron>
 <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
 <20251220173338.w7n3n4lkvxwaq6ae@inspiron>
 <01190c40-d348-4521-a2ab-3e9139cc832e@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dv742mcs2z62dkh7"
Content-Disposition: inline
In-Reply-To: <01190c40-d348-4521-a2ab-3e9139cc832e@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--dv742mcs2z62dkh7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
MIME-Version: 1.0

On 21.12.2025 19:29:37, Oliver Hartkopp wrote:
> we have a "KMSAN: uninit value" problem which is created by
> netif_skb_check_for_xdp() and later pskb_expand_head().
>
> The CAN netdev interfaces (ARPHRD_CAN) don't have XDP support and the CAN
> bus related skbs allocate 16 bytes of pricate headroom.
>
> Although CAN netdevs don't support XDP the KMSAN issue shows that the
> headroom is expanded for CAN skbs and a following access to the CAN skb
> private data via skb->head now reads from the beginning of the XDP expand=
ed
> head which is (of course) uninitialized.
>
> Prithvi thankfully did some investigation (see below!) which proved my
> estimation about "someone is expanding our CAN skb headroom".
>
> Prithvi also proposed two ways to solve the issue (at the end of his mail
> below), where I think the first one is a bad hack (although it was my ide=
a).
>
> The second idea is a change for dev_xdp_attach() where your expertise wou=
ld
> be necessary.
>
> My sugestion would rather go into the direction to extend dev_xdp_mode()
>
> https://elixir.bootlin.com/linux/v6.19-rc1/source/net/core/dev.c#L10170
>
> in a way that it allows to completely disable XDP for CAN skbs, e.g. with=
 a
> new XDP_FLAGS_DISABLED that completely keeps the hands off such skbs.

That sounds not like a good idea to me.

> Do you have any (better) idea how to preserve the private data in the
> skb->head of CAN related skbs?

We probably have to place the data somewhere else.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dv742mcs2z62dkh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlIRUAACgkQDHRl3/mQ
kZygZQf/UmKaAxPVwzWqndXIpIo1QSUPkdFOJMTQ8pvw0PGRuqmPP2RNDBYmAM7X
wKbSIp3zW+PuQOIEGlyM9ZfYpWGi2idIdHsWAZiKczQuABsNPDmmljb9mDoEnb3w
lFzSBq8rZd80qYQwRjwxKeJ78I/QL8S7tWfIMe6jFvJwyDHr/0SNjSZSd36jvknm
lacNvwviZ6lBbHNWMn/iz0pZ6q98ToeyVaV7uCWKO0WhNe/JULjuW4qyIQIsgjZp
Eza9x6wYrVRQQydxT2zJMDjRrej4rfbZxXZB23AUAa0vaE9FiutzaFZ8ncBm8wyc
PE4HEVKhL/zA8DSjuVKroaQvN3VmuA==
=J3CU
-----END PGP SIGNATURE-----

--dv742mcs2z62dkh7--

