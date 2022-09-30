Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C845F0D53
	for <lists+linux-can@lfdr.de>; Fri, 30 Sep 2022 16:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiI3OUX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 30 Sep 2022 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiI3OUM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 30 Sep 2022 10:20:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC18883D1
        for <linux-can@vger.kernel.org>; Fri, 30 Sep 2022 07:20:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oeGs1-0003fz-RZ; Fri, 30 Sep 2022 16:20:05 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 96681F16FD;
        Fri, 30 Sep 2022 14:20:04 +0000 (UTC)
Date:   Fri, 30 Sep 2022 16:20:03 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Lukas Magel <lukas.magel@posteo.net>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        linux-can@vger.kernel.org
Subject: Re: [RESEND PATCH v2] can: peak_usb: export PCAN device ID as sysfs
 device attribute
Message-ID: <20220930142003.j2scusjbndcuzxa7@pengutronix.de>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20220915095410.31854-1-lukas.magel@posteo.net>
 <1ca3bad7-f660-5516-d3a9-adaae07d142a@posteo.net>
 <20220930120649.eqew4xfcjmwplqlh@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="767r6ccq5jesljvv"
Content-Disposition: inline
In-Reply-To: <20220930120649.eqew4xfcjmwplqlh@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--767r6ccq5jesljvv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.09.2022 14:06:49, Marc Kleine-Budde wrote:
> On 28.09.2022 20:43:19, Lukas Magel wrote:
> > I was made aware by St=C3=A9phane that there has previously been discus=
sion about
> > registering a sysfs file for reading and writing the device ID [1]. IMH=
O, I
> > believe the sysfs file approach would have one important advantage over=
 using
> > ethtool: udev rule matching.
> >=20
> > I often work with setups that feature several CAN interfaces. In such a=
 setup, I
> > want to assign persistent interface names via udev in case device probi=
ng is not
> > deterministic or the devices are plugged in to different ports. At the =
moment,
> > the PEAK device driver and the underlying USB interface do not export a=
ny
> > practically usable identifier for discriminating between different inte=
rfaces of
> > the same type. The device ID solves this problem since it can be config=
ured per
> > CAN interface to uniquely identify the interface. If the device ID is e=
xported
> > as sysfs file, it is directly available for matching in udev rules via =
the
> > ATTR{...} key. This would solve the CAN interface identification proble=
m and
> > allow easy read and write access to the device ID without Windows users=
pace tools.
>=20
> I'm fine with a RO sysfs attribute. For writing the ethtool interface
> should be used instead.
>=20
> Please document the sysfs entry in
> Documentation/ABI/testing/sysfs-class-net-FOO, with foo according to
> /sys/class/net/<iface>/FOO,

I mean with FOO the name of the driver, as in the target of the link
"/sys/class/net/<iface>/device/driver", which is peak_usb in this case.

> see "Documentation/ABI/testing/sysfs-class-net-grcan" as an example.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
> index 27b0a72fd885..7af3dd0a1b35 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -15,6 +15,8 @@
>  #include <linux/netdevice.h>
>  #include <linux/usb.h>
>  #include <linux/ethtool.h>
> +#include <linux/device.h>
> +#include <linux/sysfs.h>
> =20
>  #include <linux/can.h>
>  #include <linux/can/dev.h>
> @@ -53,6 +55,15 @@ static const struct usb_device_id peak_usb_table[] =3D=
 {
> =20
>  MODULE_DEVICE_TABLE(usb, peak_usb_table);
> =20
> +static ssize_t device_id_show(struct device *dev, struct device_attribut=
e *attr, char *buf)
> +{
> +	struct net_device *netdev =3D to_net_dev(dev);
> +	struct peak_usb_device *peak_dev =3D netdev_priv(netdev);
> +
> +	return sysfs_emit(buf, "%08X\n", peak_dev->device_number);

I just noticed that the driver prints the device ID, but in decimal:

| =E2=9E=9C (pts/0) frogger@riot:~ (master) journalctl -k|grep peak
| Sep 30 14:23:24 riot kernel: peak_usb 1-1.4:1.0: PEAK-System PCAN-USB FD =
v1 fw v3.2.0 (1 channels)
| Sep 30 14:23:24 riot kernel: peak_usb 1-1.4:1.0 can1: attached to PCAN-US=
B FD channel 0 (device 1144201745)
| Sep 30 14:23:24 riot kernel: usbcore: registered new interface driver pea=
k_usb
| =E2=9E=9C (pts/0) frogger@riot:~ (master) cat /sys/class/net/can1/device_=
id=20
| 44332211

While the sysfs attribute is in hex. I have overwritten my original
device ID with 0x44332211 while testing St=C3=A9phane's patch. I'm wondering
if the serial number printed on the device's housing corresponds to the
default device ID. Is the printed device ID in hex or dec?

Mine is IPEH-004022-019814:
- it has leading zeros
- interpreted as hex, it doesn't fit into 32 bits
- interpreted as dec and converted into hex: 0xefbb26e6
  it would fit in 32 bits

If the default device ID corresponds to the printed-on number, do we
want to see/use this number in the sysfs, too?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--767r6ccq5jesljvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmM2+xAACgkQrX5LkNig
011GrQf9E/pJPdISEvx/Rj8y+dEy8h05W/WCF29qzu8ia3gPvoOB58ZAEg/YmGPU
n0TFeny4tII1tEb2uzuribkkDHX2OvAhWDCV9YhQfN9WN2ciRRsQETt5c0VtJxRY
/E2WNE1shW6UN2vlt4/mwp770KIS2Q+HWBMSHxzivDXfa/YY8hbze0g/K0baNgJ1
rKEbBPa9bgw0VcM9RX5ug+evTLNty1TXkM44F9jQf2kFfWt0tLOJHFs3qG2IGF1+
jIm89nVIhPSnHawHR60sA7mnqpAQbgUhA5w+i7D0PjA2ZpvIOxxEirebrWzBrI4I
CdDsQtKnphaNMKN1aua6kWCah/2N1g==
=DZLV
-----END PGP SIGNATURE-----

--767r6ccq5jesljvv--
