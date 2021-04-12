Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D125135C4A0
	for <lists+linux-can@lfdr.de>; Mon, 12 Apr 2021 13:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbhDLLDY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Apr 2021 07:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbhDLLDX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Apr 2021 07:03:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DC2C061574
        for <linux-can@vger.kernel.org>; Mon, 12 Apr 2021 04:03:05 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lVuLQ-00037u-3n; Mon, 12 Apr 2021 13:03:04 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3d5d:9164:44d1:db57])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0E9FF60CD8C;
        Mon, 12 Apr 2021 11:03:02 +0000 (UTC)
Date:   Mon, 12 Apr 2021 13:03:02 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [RFC]: can-next 2021-04-06: peak_usb cleanups
Message-ID: <20210412110302.h3qulblayeqn2tuy@pengutronix.de>
References: <20210406111622.1874957-1-mkl@pengutronix.de>
 <PA4PR03MB6797F3132E6EF387A0C809B5D6709@PA4PR03MB6797.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4l7ewioiwvb62iu7"
Content-Disposition: inline
In-Reply-To: <PA4PR03MB6797F3132E6EF387A0C809B5D6709@PA4PR03MB6797.eurprd03.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--4l7ewioiwvb62iu7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.04.2021 10:45:07, St=C3=A9phane Grosjean wrote:
> I've tested that serie of patches with all the CAN-FD USB interfaces
> from PEAK-System GmbH (that is, PCAN-USB FD, PCAN-USB Pro FD, PCAN-USB
> X6 and PCAN-Chip USB) as well as with the CAN 2.0 only USB interfaces
> PCAN-USB and PCAN-USB Pro, and I confirm all of them.

Thanks for testing!

> Do you need my Acked-by and/or Tested-by for each patch?

No need to, I can add them here. What should I add?
Acked-by?
Tested-by?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4l7ewioiwvb62iu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmB0KOIACgkQqclaivrt
76kv2wf/WJ1K4JvEc3tofocjlDn65NltgSD+JeZnai2AyB4Byc03wbKwMoJ3TX+b
rKUEwkk/3XhEUbI0dB7LCBygyKZacU3Pl0HjiKLR9h/XPoUqjRJl/ISZlFmzFJnW
Xr/1TPIaG9D8cUFor+3DGjJu39g0VVNt46OZWAa2HdRrVS5BGcQj/qCimg767xka
NvHU/wPso/EwTER6vWQOl+vrjLD8iNcGmGnWwBcTr/PsdoXQo2/nhdl0FI6yjHTa
vNamLa8UJe4zE6qBlh8mhutxQiROPZNRYq+jU6r4etAErYG/ykeW8qnLa6vPobJM
eiebKy47oF/YN+6zROwy52C4W0jXHA==
=QALs
-----END PGP SIGNATURE-----

--4l7ewioiwvb62iu7--
