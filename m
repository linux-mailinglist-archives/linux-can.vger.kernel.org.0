Return-Path: <linux-can+bounces-2732-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DEFA2A2C5
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 08:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A15A163740
	for <lists+linux-can@lfdr.de>; Thu,  6 Feb 2025 07:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4AB22541F;
	Thu,  6 Feb 2025 07:57:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4F2248AF
	for <linux-can@vger.kernel.org>; Thu,  6 Feb 2025 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828654; cv=none; b=Z38kgvBAdGmGZQIVuDZ6J6aRpZ5ck4WUy0Q15fd2VWdHtGhTiN2ZaW3J56+xlozU9HU7G301+BZUcZrhzJAK87ppeXt/ixqPg+RNOqzqGGV7EH8/troD5gpImHRngWhh0iP5igZCvp/z5gg2P3ja3kFPSLtHfoO4E10QXnrlXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828654; c=relaxed/simple;
	bh=IsfheFkeW3aK9Dj4FbT+9dI3HDMlhnby8Wl7RqWp58c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhQqM/Du1ifa/vhX1BZ3bG5JRb/pzZIKjz7sd7LYBNCQ8h8PPQqIFZA/TdT9GSHfkNlXGZqQRzW39puoAc33L6g5MkbYgX4gdC6ibOu1JzO2bfEi2uuCGRgjRndYLLfqriRpZIpQwu/nqwGDQuSL8tS1C1yGjuK7aOW43S0qVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tfwlD-0003Ee-JI; Thu, 06 Feb 2025 08:57:19 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tfwlB-003lij-2r;
	Thu, 06 Feb 2025 08:57:17 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 76DCB3BB10C;
	Thu, 06 Feb 2025 07:57:17 +0000 (UTC)
Date: Thu, 6 Feb 2025 08:57:17 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, socketcan@hartkopp.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, 
	kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] j1939: fix unable to send messages with data length zero
Message-ID: <20250206-pumpkin-angelfish-of-temperance-853268-mkl@pengutronix.de>
References: <20250205174651.103238-1-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="esbm7kkxi2whuprp"
Content-Disposition: inline
In-Reply-To: <20250205174651.103238-1-alexander.hoelzl@gmx.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--esbm7kkxi2whuprp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] j1939: fix unable to send messages with data length zero
MIME-Version: 1.0

On 05.02.2025 18:46:51, Alexander H=C3=B6lzl wrote:
> The J1939 standard requires the transmission of messages of length 0.
> For example the proprietary messages are specified with a data length
> of 0 to 1785. The transmission of such messages was not possible.
> Sending such a message resulted in no error being returned but no
> corresponding can frame being generated.
> This patch enables the transmission of zero length J1939 messages.
> In order to facilitate this two changes were necessary.
>
> First when the transmission of a new message is requested from userspace
> the message is segmented in j1939_sk_send_loop. The segmentation did
> account for zero length messages and terminated immediately without
> queuing the corresponding skb.
>
> Second in j1939_session_skb_get_by_offset, when selecting the next skb to
> transmit for a session, it was not checked that there now might be a
> zero length skb in the queue.
>
> Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>

Rephrased commit message to imperative style and added Oleksij's
Acked-by:

    can: j1939: j1939_sk_send_loop(): fix unable to send messages with data=
 length zero

    The J1939 standard requires the transmission of messages of length 0.

    For example proprietary messages are specified with a data length of 0
    to 1785. The transmission of such messages is not possible. Sending
    results in no error being returned but no corresponding can frame
    being generated.

    Enable the transmission of zero length J1939 messages. In order to
    facilitate this two changes are necessary:

    1) If the transmission of a new message is requested from user space
    the message is segmented in j1939_sk_send_loop(). Let the segmentation
    take into account zero length messages, do not terminate immediately,
    queue the corresponding skb.

    2) j1939_session_skb_get_by_offset() selects the next skb to transmit
    for a session. Take into account that there might be zero length skbs
    in the queue.

    Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
    Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
    Link: https://patch.msgid.link/20250205174651.103238-1-alexander.hoelzl=
@gmx.net
    Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
    [mkl: commit message rephrased]
    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Added to linux-can.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--esbm7kkxi2whuprp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmeka1kACgkQDHRl3/mQ
kZylfQf+IlOKgcVQaBt8vRw+eacJAXQsa41gzqvGNgwCTOKDyy2M7jD72xZA0DhH
Zy4rG8S4UMsjZhVla5wX7PucSiCr9Ia9uFk42aAoj2uOcK46aLeRp6xs/KNhjDSO
IvYUm5TvVIfLLQElghN8nb97XFbj7HQF4DlHR0PbGZ9tYnuzzD6wllfvm0aIgTey
6AZrMi54qNsY9GGH3/ABrgyZmBSZVHazHJR7TqjIu8WAo+mo/Xxv0Nr/bl5Ro8bW
h79QDA/ZfIKgPALFB0KgBau9l9NgbXjzt7ijNI1MPjZX1ZjiXKEinB0HXDBORNJP
y4cpBcxrmnwxPVLtLpcU6WDUfl12ww==
=4QrP
-----END PGP SIGNATURE-----

--esbm7kkxi2whuprp--

