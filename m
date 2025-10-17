Return-Path: <linux-can+bounces-5225-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BA3BEAB3E
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 18:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADB29416AE
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46421330B11;
	Fri, 17 Oct 2025 15:34:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802B330B00
	for <linux-can@vger.kernel.org>; Fri, 17 Oct 2025 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715294; cv=none; b=Jjci9x+XaqQdpAX743gTLKrs1h5NgMW0BB5lTLkRx7oI1f31IXBI+NWDP8M5nurkSsKrcDFzk4iEePM0CnzNzC50BzIA5heoPIvkUpN6/PeichXQTcxdTVFcyyxDOJ6ghJTt2bwlNaPsl1u1rOtEfdFcdC95bysYPPSUFPR/sCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715294; c=relaxed/simple;
	bh=mQGMC1kGzNhg+CDr8KB0wyiCAqA5MX1g+2SpQ2e0ZdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/nUPyuUUsajylZ9HzKZqyudPHiVju7JFb4n0gs5DYaFVa2X3qvrbfBggwi/eD+Y/ft3Fa8Vo3Gl7Hv8SFgN21FI3HNNN6JhEWrKlLx+GpYMt9COhPR+DkKtGzqzBm6A8KuKwpzRwUtvoKqd6XZkQ8Mf4cRPO9D3d65y94RqERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9mTc-0007nI-UD; Fri, 17 Oct 2025 17:34:44 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v9mTc-00459a-0g;
	Fri, 17 Oct 2025 17:34:44 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D8AB548938B;
	Fri, 17 Oct 2025 15:34:43 +0000 (UTC)
Date: Fri, 17 Oct 2025 17:34:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] can: dev: can_dev_dropped_skb: drop CAN FD skbs if
 FD is off
Message-ID: <20251017-fierce-orangutan-of-happiness-180503-mkl@pengutronix.de>
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
 <20251013-canxl-netlink-v1-1-f422b7e2729f@kernel.org>
 <20251017-determined-jackdaw-of-painting-e2ff64-mkl@pengutronix.de>
 <20251017-bizarre-enchanted-quokka-f3c704-mkl@pengutronix.de>
 <00e3d382-99e7-4b64-955a-cceffe9e471f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="azoyov6dmsdpxtxg"
Content-Disposition: inline
In-Reply-To: <00e3d382-99e7-4b64-955a-cceffe9e471f@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--azoyov6dmsdpxtxg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/9] can: dev: can_dev_dropped_skb: drop CAN FD skbs if
 FD is off
MIME-Version: 1.0

On 18.10.2025 00:30:45, Vincent Mailhol wrote:
> >> What about merging both can_dev_dropped_skb() an
> >> can_dropped_invalid_skb() in the skb.c, so that there is no stub in the
> >> header file anymore.
> >=20
> > Ouch! Don't do this. We still need can_dropped_invalid_skb() for virtual
> > interfaces. See commit ae64438be192 ("can: dev: fix skb drop check").
>=20
> Exactly!
>=20
> > But then I'm asking: Why is there the difference between virtual and
> > non-virtual interface in the first place? Can we get rid of it?
>=20
> The fact is that:
>=20
>   - We need a function for the physical interfaces to check the
>     CAN_CTRLMODE_LISTENONLY, i.e. with an access to struct can_priv.
>=20
>   - We need a similar function but which work for the virtual
>     interfaces which do not have a can_priv member.
>=20
> So unless we do a major code refactor so that the virtual interfaces,
> I do not see how we could get rid of it.

Ack...There are more interesting/important tasks.

> >> Someone (i.e. me) used can_dropped_invalid_skb() in a driver, that mea=
ns
> >> the check for CAN_CTRLMODE_LISTENONLY is missing :/ (I'll send a fix).
>=20
> At least, this does not seem like a security breach like it was the
> case for the missing net_device_ops->ndo_change_mtu().
>=20
> > These drivers need this fix:
> >=20
> > | drivers/net/can/bxcan.c:845:     if (can_dropped_invalid_skb(ndev, sk=
b))
> > | drivers/net/can/esd/esdacc.c:257:        if (can_dropped_invalid_skb(=
netdev, skb))
> > | drivers/net/can/rockchip/rockchip_canfd-tx.c:75: if (can_dropped_inva=
lid_skb(ndev, skb))
>=20
> Yeah, I think that this is a pitfall, but at the same time, I do not
> see how to get rid of this can_dev_dropped_skb() and
> can_dropped_invalid_skb() pair. The best I can think of it to be
> careful on this problem doing the code review now that we are aware
> about it.

Ack.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--azoyov6dmsdpxtxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjyYg0ACgkQDHRl3/mQ
kZz+ZggAiUqLfRFBnoDDH33QiFuJ5wr26Ua4KP57M3IomqRYfm1ZZJC+RrgmHq/A
P6cCL0NykI2rcF7A0AFoxueWBmG+/LsrawdzGVYjetcV0t90V4b9OFHcI1u+RUcv
wdO/zP5leAm1ngSYhQeU41Z0vwtY695q6zj0lq1+BRxWSHL0YrVCRhylePn2IZxX
fXss03GpijPqVBZny1FMmIaOf54Goq4Y0JwMFbw+25+K8xsXhVEq+zG9Mt+gcG/z
7a0bkZb25VFiqS12y5czj+SO8pZLTNschn7CTtKzIXRR/gzvG6tDd4cewk3pmyxf
kZ4ihIpvH7fZLV++eEMYhENmMTveZw==
=yXQn
-----END PGP SIGNATURE-----

--azoyov6dmsdpxtxg--

