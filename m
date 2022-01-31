Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666E14A4A4E
	for <lists+linux-can@lfdr.de>; Mon, 31 Jan 2022 16:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346522AbiAaPR4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Jan 2022 10:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347119AbiAaPRm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Jan 2022 10:17:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03539C061714
        for <linux-can@vger.kernel.org>; Mon, 31 Jan 2022 07:17:41 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nEYR2-0003LT-Gc; Mon, 31 Jan 2022 16:17:40 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CABE128712;
        Mon, 31 Jan 2022 15:17:38 +0000 (UTC)
Date:   Mon, 31 Jan 2022 16:17:35 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     petter@ka-long.de
Cc:     linux-can@vger.kernel.org
Subject: Re: MCP2518FD : Failed to detect MCP2518FD (osc=0x00000000)
Message-ID: <20220131151735.mfxzloeppny62ow2@pengutronix.de>
References: <20220131083304.122C45B0007E@dd15738.kasserver.com>
 <20220131084205.53otmukeyt2dt4zj@pengutronix.de>
 <20220131093554.505C65B0025F@dd15738.kasserver.com>
 <20220131095849.5iw4jgeexc3egnb6@pengutronix.de>
 <20220131124428.B17CE5B0007E@dd15738.kasserver.com>
 <20220131130911.nyfg5ojq77hbqc7d@pengutronix.de>
 <20220131141503.C111C5B00631@dd15738.kasserver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3kvbksnnmwgrl3hw"
Content-Disposition: inline
In-Reply-To: <20220131141503.C111C5B00631@dd15738.kasserver.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--3kvbksnnmwgrl3hw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 31.01.2022 15:15:03, petter@ka-long.de wrote:
>
> Hi Marc,
>
> CS = High (de-asserted, slave not selected)
> CS = low (asserted, slave selected)
>
> I also did not like the 0/1 starting point, but it is defined here:
>
>         aliases {
>                 gpio0 = &gpio1;
>                 gpio1 = &gpio2;
>                 gpio2 = &gpio3;
>                 ...
>
>
>
> &gpio1 3 = gpiochip0 = 0*32 + 3 = gpio3
> &gpio5 1 = gpiochip4 = 4*32 + 1 = gpio129

In your output of /sys/kernel/debug/gpio, gpiochip3 starts at 128:

>> gpiochip3: GPIOs 128-159, parent: platform/30240000.gpio, 30240000.gpio:
>>  gpio-128 (                    |cd                  ) in  hi IRQ ACTIVE LOW
>>  gpio-129 (                    |spi1 CS0            ) out hi ACTIVE LOW

Here it looks like this:

gpiochip4: GPIOs 128-159, parent: platform/20ac000.gpio, 20ac000.gpio:
 gpio-130 (EIM_A25             |user1               ) out lo ACTIVE LOW
 gpio-133 (GPIO5_05            )
 gpio-134 (GPIO5_06            |reset               ) out lo
 gpio-135 (GPIO5_07            )
 gpio-136 (GPIO5_08            )
 gpio-137 (CSPI2_CS1           |spi1 CS1            ) out hi ACTIVE LOW
 gpio-138 (CSPI2_MOSI          )
 gpio-139 (CSPI2_MISO          )
 gpio-140 (CSPI2_CS0           |spi1 CS0            ) out hi ACTIVE LOW
 gpio-141 (CSPI2_CLK           )

> Interresting with ACTIVE HIGH / LOW. cat debug/gpio tells me "ACTIVE
> LOW" but anyway I did not see CS toggle at all. Also tested "1" but
> nothing changed.
>
> By the way, the old kernel is working with the new device tree.
>
> I did a make clean and make sure that I really use latest build
> artefacts. Everything is okay. Still failure.
>
> Maybe there are problems when using "make imx_v7_defconfig" ...
> possible conflicts between drivers because there are much changes
> between 5.4 and 5.10 whats enabled and/or new by default ? Try to go
> with a very small kernel.

There shouldn't be any conflicts between drivers.

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--3kvbksnnmwgrl3hw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmH3/YwACgkQqclaivrt
76nU/Af9HzDNRbB/SlqmL2O0VyRGc8RZvalXpSoRfjgssWzt1KwdaWOOtW8mjaYG
OuDCBx9PQxrqZWjl5BQz+gEq34zmJIDKBd0k2ulwM4GLaxDeG102z8lwV6jxx0y6
L43UutByWEcnT1+mkHTKYUDE+D5TxT2YfkO+DXg32D7/adEFNw/13L9yLgTaqJ7c
kyp3NJWSIRdkx07+4RcENEHhF1lHy43/Vu91djG/7y+SEEi6bdxWSEFf84cf5t4T
UwhNxmXubgNQxuYodeR2tHGcnYw41HRB5IWvccVxgIfZRFvoB/fydXxMr1jxkr//
GBlsFHTay7lFl7MzqJA+wfJarVK2+A==
=89Eo
-----END PGP SIGNATURE-----

--3kvbksnnmwgrl3hw--
