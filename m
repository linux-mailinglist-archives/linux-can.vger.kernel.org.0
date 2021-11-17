Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB98B4549B7
	for <lists+linux-can@lfdr.de>; Wed, 17 Nov 2021 16:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhKQPTv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 Nov 2021 10:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhKQPTp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Nov 2021 10:19:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA24CC061570
        for <linux-can@vger.kernel.org>; Wed, 17 Nov 2021 07:16:46 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mnMg1-0004VX-6Y; Wed, 17 Nov 2021 16:16:45 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-4798-8309-bab4-98da.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:4798:8309:bab4:98da])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D8C1C6AE46A;
        Wed, 17 Nov 2021 15:16:43 +0000 (UTC)
Date:   Wed, 17 Nov 2021 16:16:42 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 6/6] can: peak_usb: add sysfs interface to internal
 device user value
Message-ID: <20211117151642.flj7qxvckvwwbakd@pengutronix.de>
References: <20211117150132.37056-1-s.grosjean@peak-system.com>
 <20211117150132.37056-7-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ofwlvz5hvyku6xrg"
Content-Disposition: inline
In-Reply-To: <20211117150132.37056-7-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ofwlvz5hvyku6xrg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.11.2021 16:01:32, Stephane Grosjean wrote:
> This patch adds under /sys/class/net/canX a new group named "peak_usb"
> which contains a "dev_num" entry accessible for reading (display in
> decimal of the numerical value stored in non-volatile memory of the USB
> device) and also for writing (modification by the user of this value).
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Please have a look at the ethtool eeprom interface:

| ethtool -e|--eeprom-dump devname [raw on|off] [offset N] [length N]
| ethtool -E|--change-eeprom devname [magic N] [offset N] [length N] [value=
 N]

That looks better than adding a custom sysfs entry.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ofwlvz5hvyku6xrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGVHNcACgkQqclaivrt
76nZNwf+IxXsKp9/t5M3ng6ejB9OOZLSJqylW++N/Z8vf8SgXz3A9zeCK7uW4L5J
3uIbcTHBt7huGskJ2JaP1niY9FNA9fHiYCA8mk7Mt+Ik6L8UVfOHQttxemPxhm4W
qnjzGp6t/mohD3knVf0ngNBDtu0O+193TIc1yeRAdb8T2PY/lYEdmxs9K5Y0zW/D
jkb5nBfWbmVR1i23OHjXRLow0hYBt6UtFTsLLf0D6quroQomO8HXRIG/P37yNpba
6pHVpyIadJ9iWoHQXfHYxfsWdIeeE6ivPa0zqZlKpFNhyMAmqNomf7nfJI0NlF2G
4yKtuSsN6gd/4qMqlqm1hLCXcbSgtg==
=yNW8
-----END PGP SIGNATURE-----

--ofwlvz5hvyku6xrg--
