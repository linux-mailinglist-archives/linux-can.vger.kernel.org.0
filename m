Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84E9341926
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 11:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCSKCB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 06:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhCSKBn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 06:01:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FC8C06174A
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 03:01:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNBws-0007D6-3X; Fri, 19 Mar 2021 11:01:42 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7ffa:65dd:d990:c71d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1EA365FA761;
        Fri, 19 Mar 2021 10:01:41 +0000 (UTC)
Date:   Fri, 19 Mar 2021 11:01:40 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 3/3] can/peak_usb: add support of ONE_SHOT mode
Message-ID: <20210319100140.nq6ftsmwq7apy6mz@pengutronix.de>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-4-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="brv4ua57ofntjhcx"
Content-Disposition: inline
In-Reply-To: <20210309082128.23125-4-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--brv4ua57ofntjhcx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 09:21:28, Stephane Grosjean wrote:
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -39,6 +39,7 @@ MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro adapt=
er");
> =20
>  #define PCAN_USBPRO_RTR			0x01
>  #define PCAN_USBPRO_EXT			0x02
> +#define PCAN_USBPRO_SS			0x08
> =20
>  #define PCAN_USBPRO_CMD_BUFFER_SIZE	512
> =20
> @@ -779,9 +780,13 @@ static int pcan_usb_pro_encode_msg(struct peak_usb_d=
evice *dev,
> =20
>  	flags =3D 0;
>  	if (cf->can_id & CAN_EFF_FLAG)
> -		flags |=3D 0x02;
> +		flags |=3D PCAN_USBPRO_EXT;
>  	if (cf->can_id & CAN_RTR_FLAG)
> -		flags |=3D 0x01;
> +		flags |=3D PCAN_USBPRO_RTR;

I've put this change in a separate patch and applied both to linux-can-next=
/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--brv4ua57ofntjhcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBUdoAACgkQqclaivrt
76nQiAf/Y4GQhUsao0Y6P5gDjEQ8xyT1A9TSHdJ++fc18tNpSQFlqCOzGGg8PwEq
BgJJSTtrnrDcEcy8M0xVHcY8TES9DAuuB5Ze1KYCRvUIV/dN1BtYctFtntgTQavJ
Rc0fg4P1qSvJTpV8AKGKlA4vq6W1/Fh8aWGLuLvrCU83axi6PpA9IyryGsAXxXC4
E9iCNoWV4PK+MhiiVfXi56AN6RqY3v41FIfuNYhHdMWEMVHfX0yxxFcwz3Ihpe8D
UFJq1/gmsgZQCDAFX1xDtbqyyt+AVuBYddBDGqivDlpWStZMt0hSOdV+KQGPvFjW
EzLqd2px0kC0HKwvGU60tNwoeZpmRA==
=JMIV
-----END PGP SIGNATURE-----

--brv4ua57ofntjhcx--
