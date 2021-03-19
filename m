Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B1534171B
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 09:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhCSIIK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 04:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbhCSIIA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 04:08:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DEBC06174A
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 01:07:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNAAm-0002v0-DF; Fri, 19 Mar 2021 09:07:56 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7ffa:65dd:d990:c71d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6F83A5FA659;
        Fri, 19 Mar 2021 08:07:55 +0000 (UTC)
Date:   Fri, 19 Mar 2021 09:07:54 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Wadepohl, Wolfram" <wolfram.wadepohl@storopack.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: newbie question to atu baudrate detection
Message-ID: <20210319080754.yht6civzpazioo5f@pengutronix.de>
References: <34a81be300da495db62c369863ae9873@stpinfexc1vp.corporate.storopack.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="toye4y7kyconok5b"
Content-Disposition: inline
In-Reply-To: <34a81be300da495db62c369863ae9873@stpinfexc1vp.corporate.storopack.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--toye4y7kyconok5b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.03.2021 07:44:23, Wadepohl, Wolfram wrote:
> Is it possible to automatically detect baudrate via socketCAN?

There is ready to use code for this. Contributions are welcome :)

> How can I set the CAN controller to "silent mode" not generating any
> ACK or error frames? help would be appreciated. thanks.

If your CAN controller and driver support silent mode, you can use
netlink to configure it. You probably don't want to code netlink "by
hand". In the shell use "ip":

| ip link set dev can0 down
| ip link set can0 up type can bitrate 500000 listen-only on

In C, you can use libsocketcan:

| https://git.pengutronix.de/cgit/tools/libsocketcan

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--toye4y7kyconok5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBUW9gACgkQqclaivrt
76kp7wf8CiKU69lbuGJFuUY0xyGtoTd873eSFBxzgehpqxTaW+/XOTEHS6LDGfiP
ey482b8CSuo4+Be7xWHdwMibK0SqUdGsY7WERF3/zxvUKs6keZMwGEKFYXwoxNt2
BhrizFyZG85kZr80oOXrD8/JNCHsSh7RIzuzHAbJYdQlrngmpsHUXwc90w1S+zld
x1noUkOLCeIWH9+9GdfBGL2kqnB/euQ+aOdg3vL9EJzbtnaOrK3RUCPiUvg5G6JE
We2fN0IcMMJXXkIjPMhUHDOrc0A0XSCOk5+O+WtpG98q6g0SA7/PBDzz9c893SiF
e2zIroCZTsDZpxi+PrwOArtYVHLY/w==
=Gqhw
-----END PGP SIGNATURE-----

--toye4y7kyconok5b--
