Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEBF5F0B4F
	for <lists+linux-can@lfdr.de>; Fri, 30 Sep 2022 14:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiI3MHV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 30 Sep 2022 08:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiI3MHD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 30 Sep 2022 08:07:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A493716DDFF
        for <linux-can@vger.kernel.org>; Fri, 30 Sep 2022 05:06:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oeEn7-0001mY-IE; Fri, 30 Sep 2022 14:06:53 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EFCEDF155C;
        Fri, 30 Sep 2022 12:06:51 +0000 (UTC)
Date:   Fri, 30 Sep 2022 14:06:49 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Lukas Magel <lukas.magel@posteo.net>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        linux-can@vger.kernel.org
Subject: Re: [RESEND PATCH v2] can: peak_usb: export PCAN device ID as sysfs
 device attribute
Message-ID: <20220930120649.eqew4xfcjmwplqlh@pengutronix.de>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20220915095410.31854-1-lukas.magel@posteo.net>
 <1ca3bad7-f660-5516-d3a9-adaae07d142a@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rfdilusqrww2vvmc"
Content-Disposition: inline
In-Reply-To: <1ca3bad7-f660-5516-d3a9-adaae07d142a@posteo.net>
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


--rfdilusqrww2vvmc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.09.2022 20:43:19, Lukas Magel wrote:
> I was made aware by St=C3=A9phane that there has previously been discussi=
on about
> registering a sysfs file for reading and writing the device ID [1]. IMHO,=
 I
> believe the sysfs file approach would have one important advantage over u=
sing
> ethtool: udev rule matching.
>=20
> I often work with setups that feature several CAN interfaces. In such a s=
etup, I
> want to assign persistent interface names via udev in case device probing=
 is not
> deterministic or the devices are plugged in to different ports. At the mo=
ment,
> the PEAK device driver and the underlying USB interface do not export any
> practically usable identifier for discriminating between different interf=
aces of
> the same type. The device ID solves this problem since it can be configur=
ed per
> CAN interface to uniquely identify the interface. If the device ID is exp=
orted
> as sysfs file, it is directly available for matching in udev rules via the
> ATTR{...} key. This would solve the CAN interface identification problem =
and
> allow easy read and write access to the device ID without Windows userspa=
ce tools.

I'm fine with a RO sysfs attribute. For writing the ethtool interface
should be used instead.

Please document the sysfs entry in
Documentation/ABI/testing/sysfs-class-net-FOO, with foo according to
/sys/class/net/<iface>/FOO, see
"Documentation/ABI/testing/sysfs-class-net-grcan" as an example.

> Regards,
> Lukas
>=20
> [1]
> https://lore.kernel.org/linux-can/20211117150132.37056-1-s.grosjean@peak-=
system.com/
>=20
> On 15.09.22 11:54, Lukas Magel wrote:
> > Peak USB devices support a configurable u8 / u32 device ID. In
> > multi-device setups, this device ID can be configured and used to
> > identify individual CAN interfaces independent of the order in which
> > they are plugged into the system. At the current time, the device ID
> > is already queried from the device and stored in the peak_usb_device
> > struct.
> >
> > This patch exports the device ID (called device_number in the struct)
> > as a sysfs attribute. The attribute name was chosen to be device_id
> > instead of device_number because the latter has been deprecated by Peak
> > in their API.
> >
> > Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
> > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > CC: Stephane Grosjean <s.grosjean@peak-system.com>
> > ---
> > V2: Update netdev_warn to output the mnemonic of the error value
> >
> > Resubmission of the patch. Also added St=C3=A9phane as maintainer in CC.
> >
> >  drivers/net/can/usb/peak_usb/pcan_usb_core.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net=
/can/usb/peak_usb/pcan_usb_core.c
> > index 27b0a72fd885..7af3dd0a1b35 100644
> > --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> > +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> > @@ -15,6 +15,8 @@
> >  #include <linux/netdevice.h>
> >  #include <linux/usb.h>
> >  #include <linux/ethtool.h>
> > +#include <linux/device.h>
> > +#include <linux/sysfs.h>

Please sort the include files alphabetically.

> > =20
> >  #include <linux/can.h>
> >  #include <linux/can/dev.h>
> > @@ -53,6 +55,15 @@ static const struct usb_device_id peak_usb_table[] =
=3D {
> > =20
> >  MODULE_DEVICE_TABLE(usb, peak_usb_table);
> > =20
> > +static ssize_t device_id_show(struct device *dev, struct device_attrib=
ute *attr, char *buf)
> > +{
> > +	struct net_device *netdev =3D to_net_dev(dev);
> > +	struct peak_usb_device *peak_dev =3D netdev_priv(netdev);
> > +
> > +	return sysfs_emit(buf, "%08X\n", peak_dev->device_number);
> > +}
> > +static DEVICE_ATTR_RO(device_id);
> > +
> >  /*
> >   * dump memory
> >   */
> > @@ -887,6 +898,11 @@ static int peak_usb_create_dev(const struct peak_u=
sb_adapter *peak_usb_adapter,
> >  	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
> >  			peak_usb_adapter->name, ctrl_idx, dev->device_number);
> > =20
> > +	err =3D device_create_file(&netdev->dev, &dev_attr_device_id);
> > +	/* Do not error out since device was configured successfully */
> > +	if (err)
> > +		netdev_warn(netdev, "unable to expose device_id via sysfs: %pe\n", E=
RR_PTR(err));
> > +

This is racy, please use a sysfs_groups instead, see
https://git.kernel.org/torvalds/c/3a5655a5b545e9647c3437473ee3d815fe1b9050

> >  	return 0;
> > =20
> >  adap_dev_free:
> > @@ -923,6 +939,8 @@ static void peak_usb_disconnect(struct usb_interfac=
e *intf)
> >  		dev->state &=3D ~PCAN_USB_STATE_CONNECTED;
> >  		strlcpy(name, netdev->name, IFNAMSIZ);
> > =20
> > +		device_remove_file(&netdev->dev, &dev_attr_device_id);
> > +
> >  		unregister_netdev(netdev);
> > =20
> >  		kfree(dev->cmd_buf);
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--rfdilusqrww2vvmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmM229UACgkQrX5LkNig
011hUggAq39wDHlJHEJNBbwvA4LLchrcayn19HyI6iJa1L0WhwbMO+0kIHQAJpEB
7VPeyb/r6IUvwog3AoAkbCm7yErNDJEOguh8PP3WURkeCWjwkvT2+vcU/zU//mr5
vqFWIVLMBW0kyt9aTZhDZ80Wb7D14zJ2PRoYm6cqMK97PuGYbN4eNyySIo9h4vy4
XfGF5fyvj2ECInzjeKkV7MmiSOANis7BuLT5aq35XKML3p4acMSlRC+O3aFwHgPJ
l/WftpIAHjG0cPrqNKAH9v0R2zGagEenlriytLS8WzmcETMMzyBu1dSE1VMgGyKM
JbpzSekOWFy/+oj+h+36X0uPLq7Ssw==
=5AEh
-----END PGP SIGNATURE-----

--rfdilusqrww2vvmc--
