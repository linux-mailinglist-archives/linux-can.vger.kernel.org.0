Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3154E34178D
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 09:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhCSIfu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 04:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhCSIff (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 04:35:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34722C06174A
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 01:35:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNAbV-0005se-Mt; Fri, 19 Mar 2021 09:35:33 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7ffa:65dd:d990:c71d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 913F35FA68E;
        Fri, 19 Mar 2021 08:35:32 +0000 (UTC)
Date:   Fri, 19 Mar 2021 09:35:31 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>,
        linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 1/3] can/peak_usb: add support of ethtool set_phys_id()
Message-ID: <20210319083531.qhnozidc2msjir7p@pengutronix.de>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
 <20210309082128.23125-2-s.grosjean@peak-system.com>
 <bf2f6330-2f28-54ba-7025-55828f916074@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmyuyvwas5cl62xr"
Content-Disposition: inline
In-Reply-To: <bf2f6330-2f28-54ba-7025-55828f916074@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--nmyuyvwas5cl62xr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 13:15:27, Marc Kleine-Budde wrote:
> > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/=
can/usb/peak_usb/pcan_usb_pro.h
> > index 6bb12357d078..421104ee29f4 100644
> > --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
> > +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
> > @@ -115,6 +115,12 @@ struct __packed pcan_usb_pro_devid {
> >  	__le32 serial_num;
> >  };
> > =20
> > +#define FW_USBPRO_LED_DEVICE		0x00
> > +#define FW_USBPRO_LED_BLINK_FAST	0x01
> > +#define FW_USBPRO_LED_BLINK_SLOW	0x02
> > +#define FW_USBPRO_LED_ON		0x03
> > +#define FW_USBPRO_LED_OFF		0x04
>=20
> What about replacing the FW_ with PCAN_, so that we're using the same pre=
fix
> within the driver? I can do this while applying.

I've replaced the FW_ with PCAN_ while applying the patch.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--nmyuyvwas5cl62xr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBUYlEACgkQqclaivrt
76mWIwgAtIa13CAZp60lkJGFLoL65/fnu1ZXOyOzXK7pRbiETKlnUxUgvA33xGuL
gZ7XGM6q2nXu7ryNBykpn5ohiHLbgT9pPFVDIDoZ8GgpwImFAxxPcu8RW/9rcXW+
mwOMhVTxZr/nANv4jv0wcZT7cYBDQeRy8I7hybF8bOwIIOFwHMD0WaIot73DrBZG
b7RFChhl4H62kBaiDrs7NpE5hUnVpDUEvDXUvzUkLyh9qJqLKWivMmZwBAYrAqdf
DtYV9UgIKoTG1Z9MPVFY2lO2BEHjjFI2vK5eFU3RdMTRT/bTY33RjApcgBEsCI2I
kkTlNFj91laIucVsXkxyN3FcjfIupg==
=0xf4
-----END PGP SIGNATURE-----

--nmyuyvwas5cl62xr--
