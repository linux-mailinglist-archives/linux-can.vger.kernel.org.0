Return-Path: <linux-can+bounces-4066-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0299B0F265
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 14:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22FA3A8C35
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C9A2E5B2A;
	Wed, 23 Jul 2025 12:36:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C726C3BD
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753274218; cv=none; b=Lq33E5I4V7kIUK5n0QXgMck7QWvUY7oXEh8RIMPgLNFH7vl99jlGqJhPiU2L2ce7R7CMwVqX2QUan77QgA8O2TuPW4P6ExSB/REP2niLXxNbrLeYjHaPkaJIXVc9mEJ9nFPnj8xBWsVhC6zjos3W4aedwJxL4BWufdzuaGPVepc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753274218; c=relaxed/simple;
	bh=DBXv1gq0XGgehaww1wGqajVbqK1/XcD1Bp+hnqehVxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPY5b77rJeXx5fEKCgYxbXc1y0C4ZVXiWQYvGI8eZQoBH+UIPuCKs/6XlZ9PzHGJUc0UBM/nb7Ju4XfMkfzHyKpp7imuD4brhnQXzt/JTGHecncwksaF17bd32BhdqQZptgc9p5buGhUYc3+hRquInyDwVFAGulZY3gOWUMqNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ueYiJ-0004Zn-1z; Wed, 23 Jul 2025 14:36:51 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ueYiI-009tAV-24;
	Wed, 23 Jul 2025 14:36:50 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 41FE1447539;
	Wed, 23 Jul 2025 12:36:50 +0000 (UTC)
Date: Wed, 23 Jul 2025 14:36:49 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org, 
	Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH 7/9] can: kvaser_pciefd: Add devlink support
Message-ID: <20250723-bold-partridge-of-agreement-5f7ce1-mkl@pengutronix.de>
References: <20250723083236.9-1-extja@kvaser.com>
 <20250723083236.9-8-extja@kvaser.com>
 <642e30bc-b79f-4d14-b20f-141000939555@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gnwtoe5yl2p4no4j"
Content-Disposition: inline
In-Reply-To: <642e30bc-b79f-4d14-b20f-141000939555@wanadoo.fr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--gnwtoe5yl2p4no4j
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 7/9] can: kvaser_pciefd: Add devlink support
MIME-Version: 1.0

On 23.07.2025 21:31:31, Vincent Mailhol wrote:

[...]

> > diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h b/drivers/ne=
t/can/kvaser_pciefd/kvaser_pciefd.h
> > index 55bb7e078340..34ba393d6093 100644
> > --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
> > +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
> > @@ -13,6 +13,7 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/timer.h>
> >  #include <linux/types.h>
> > +#include <net/devlink.h>
> > =20
> >  #define KVASER_PCIEFD_MAX_CAN_CHANNELS 8UL
> >  #define KVASER_PCIEFD_DMA_COUNT 2U
> > @@ -87,4 +88,5 @@ struct kvaser_pciefd {
> >  	struct kvaser_pciefd_fw_version fw_version;
> >  };
> > =20
> > +extern const struct devlink_ops kvaser_pciefd_devlink_ops;
>=20
> Nitpick: I would rather like to see a kvaser_pciefd_devlink.h instead of =
this.

IMHO 1 header file is enough.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gnwtoe5yl2p4no4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmiA110ACgkQDHRl3/mQ
kZwKVgf/ZSjhtZcZnf2w74gkkxZlQ/X3h9FrSucyCtuT5Wyzt1qRgYaxPBautCH2
lJyuHtp1XaL+dPQYVS+sUAhehmkF14yA//kxmBuep/ZbIK1ICZu3dhqAb9Dp4oBo
ZDOKkixQIpJuMfqJfKf4m83muPAS/aKmpq+nqAL0z4mOxgoXyVSdTz6edCRuiHgi
4XoOaeEbWeiKhaNar7FNxEBkZ6dsvSYCu0W3WOfi1b0Xw/yDSmQf+rO5nFkMEdvp
Mzk5mBnKyCOkPu1KXy+BsagPl+oUZ19gs4fw3yeT31xHrjZT5aexyMQSQ9woDXbD
0qTevSPQb3piOYgR8/s3qIWk3v7OkQ==
=5RmA
-----END PGP SIGNATURE-----

--gnwtoe5yl2p4no4j--

