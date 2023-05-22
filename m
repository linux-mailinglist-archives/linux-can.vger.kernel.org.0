Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D9C70CA55
	for <lists+linux-can@lfdr.de>; Mon, 22 May 2023 22:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjEVUG6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 May 2023 16:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjEVUG4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 May 2023 16:06:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD75897
        for <linux-can@vger.kernel.org>; Mon, 22 May 2023 13:06:54 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1q1Bnv-0006gn-5g; Mon, 22 May 2023 22:06:51 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1805D1C9E09;
        Mon, 22 May 2023 20:06:50 +0000 (UTC)
Date:   Mon, 22 May 2023 22:06:49 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        linux-can@vger.kernel.org, Florian Ferg <flfe@hms-networks.de>,
        socketcan@hms-networks.de
Subject: Re: [PATCH v8] can: usb: IXXAT USB-to-CAN adapters drivers
Message-ID: <20230522-hesitant-dehydrate-d2af514565d0-mkl@pengutronix.de>
References: <20230515212930.1019702-1-mkl@pengutronix.de>
 <CAMZ6RqKToYbfsOX4v_jK7X28hLyiYnH7j784eVeFuKrj7ujRSA@mail.gmail.com>
 <20230522215354.2c79c007@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75ev2itd2dqhdhpm"
Content-Disposition: inline
In-Reply-To: <20230522215354.2c79c007@gmx.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--75ev2itd2dqhdhpm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.05.2023 21:53:54, Peter Seiderer wrote:
> > > +static int ixxat_usb_init_ctrl(struct ixxat_usb_device *dev)
> > > +{
> > > +       const struct can_bittiming *bt =3D &dev->can.bittiming;
> > > +       const u16 port =3D dev->ctrl_index;
> > > +       int err;
> > > +       struct ixxat_usb_init_cl1_cmd *cmd;
> > > +       const u32 rcv_size =3D sizeof(cmd->res);
> > > +       const u32 snd_size =3D sizeof(*cmd); =20
> >=20
> > Remove those size variables and directly use sizeof(cmd->res) and
> > sizeof(*cmd) in the code.
>=20
> O.k.
>=20
> >=20
> > > +       u8 opmode =3D IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_ST=
ANDARD;
> > > +       u8 btr0 =3D ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) <=
< 6); =20
> >=20
> > Add a macro definition for the 0x3f  and 0x3 masks using GENMASK() and
> > then calculate the value using FIELD_PREP().
>=20
> O.k., define names o.k.?

ACK

> +#define IXXAT_USB_CAN_BTR0_BRP_MASK GENMASK(5, 0)
> +#define IXXAT_USB_CAN_BTR0_SJW_MASK GENMASK(7, 6)

Now use:
        btr0 =3D FIELD_PREP(IXXAT_USB_CAN_BTR0_BRP_MASK, bt->brp - 1) |
                FIELD_PREP(IXXAT_USB_CAN_BTR0_SJW_MASK, bt->sjw - 1);
       =20
[...]

> > > +static void ixxat_usb_update_ts_now(struct ixxat_usb_device *dev, u3=
2 ts_now)
> > > +{
> > > +       u32 *ts_dev =3D &dev->time_ref.ts_dev_0;
> > > +       ktime_t *kt_host =3D &dev->time_ref.kt_host_0;
> > > +       u64 timebase =3D (u64)0x00000000FFFFFFFF - (u64)(*ts_dev) + (=
u64)ts_now; =20
> >=20
> > Replace 0x00000000FFFFFFFF by U32_MAX from linux/limits.h
>=20
> O.k.

Can you read the free running timer register a USB transfer? If so, it's
better to use the cyclecounter/timecounter framework.

[...]

> > > +static void ixxat_usb_decode_buf(struct urb *urb)
> > > +{
> > > +       struct ixxat_usb_device *dev =3D urb->context;
> > > +       struct net_device *netdev =3D dev->netdev;
> > > +       struct ixxat_can_msg *can_msg;
> > > +       int err =3D 0;
> > > +       u32 pos =3D 0;
> > > +       u8 *data =3D urb->transfer_buffer;
> > > +
> > > +       while (pos < urb->actual_length) {
> > > +               u32 time;
> > > +               u8 size;
> > > +               u8 type;
> > > +
> > > +               can_msg =3D (struct ixxat_can_msg *)&data[pos];
> > > +               if (!can_msg || !can_msg->base.size) {
> > > +                       err =3D -ENOTSUPP;
>=20
> checkpatch.pl warns about this one:
>=20
> 	WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> 	#1045: FILE: drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c:644:
> 	+			err =3D -ENOTSUPP;
>=20
> Is EOPNOTSUPP appropriate (or EBADMSG as below)?

EBADMSG sounds good.

[...]

> > > +static void ixxat_usb_read_bulk_callback(struct urb *urb)
> > > +{
> > > +       struct ixxat_usb_device *dev =3D urb->context;
> > > +       const struct ixxat_usb_adapter *adapter =3D dev->adapter;
> > > +       struct net_device *netdev =3D dev->netdev;
> > > +       struct usb_device *udev =3D dev->udev;
> > > +       int err;
> > > +
> > > +       if (!netif_device_present(netdev))
> > > +               return;
> > > +
> > > +       switch (urb->status) {
> > > +       case 0: /* success */
> > > +               break;
> > > +       case -EPROTO:
> > > +       case -EILSEQ:
> > > +       case -ENOENT:
> > > +       case -ECONNRESET:
> > > +       case -ESHUTDOWN:
> > > +               return;
> > > +       default:
> > > +               netdev_err(netdev, "Rx urb aborted /(%d)\n", urb->sta=
tus); =20
> >=20
> > Do not use parenthesis in log messages.
> >=20
> > Ref: https://www.kernel.org/doc/html/latest/process/coding-style.html#p=
rinting-kernel-messages
> >=20
> >   Printing numbers in parentheses (%d) adds no value and should be avoi=
ded.
> >=20
>=20
> O.k., seems a common pattern, at least the same logging used in peak_usb,
> change it there as well (but seems you answered this in another thread
> already '...but bonus points if you send a clean-up patch to fix
> the existing log messages...')?

IIRC the %pe is quite new compared to the peak_usb driver. Code evolves
and new code should not be based on outdated examples/drivers.

[...]

> > > +/**
> > > + * struct ixxat_canbtp Bittiming parameters (CL2)
> > > + * @mode: Operation mode
> > > + * @bps: Bits per second
> > > + * @ts1: First time segment
> > > + * @ts2: Second time segment
> > > + * @sjw: Synchronization jump width
> > > + * @tdo: Transmitter delay offset
> > > + *
> > > + * Bittiming parameters of a CL2 initialization request
> > > + */
> > > +struct ixxat_canbtp {
> > > +       __le32 mode;
> > > +       __le32 bps;
> > > +       __le16 ts1;
> > > +       __le16 ts2;
> > > +       __le16 sjw;
> > > +       __le16 tdo; =20
> >=20
> > It seems that your device supports TDC. What is the reason to not confi=
gure it?
> >=20
> > Please have a look at struct can_tdc:
> >=20
> >   https://elixir.bootlin.com/linux/v6.2/source/include/linux/can/bittim=
ing.h#L21
> >=20
> > Please refer to this patch if you want an example of how to use TDC:
> >=20
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D1010a8fa9608
> >=20
>=20
> Not sure about this one (and I have limited knowledge of the hardware det=
ails),
> seems I need to find more (spare) time to look into this one, or maybe
> something better for an follow-up patch?

We usually need TDC for bit rates > 1..2 MBit/s

ACK.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--75ev2itd2dqhdhpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRry1YACgkQvlAcSiqK
BOgzxwf/Zr5FW5wsb1aYdUFNmU+1riPqWZT516EJ9l+Hl2i3Lxh0atVRZcyMmPF3
nZUr1wXbwx5elIz8vJFprzg1OleNWreZGIFqIzv7g5KCdDtmW7Fyb7T3KW8Ppo5Q
kyiaylkc5QrgXSjxE3kwBt68JzXALgsUDbYvl1C450TB15HnxopMwm3dfrgzb6jo
xuf3G3Cxw6Wy0x/p4B9GQPEgTbtFXJFYJCVQEvGPdckgPkJskHI04Jgvqf7+p8Lb
aNIXW6kEGSJoU52Maq/OGqSCivrwbAGL4ZwSewtGg4f2kNGquPlPCisjtojuGwzM
pnNL0+ZEBLQXRLYx0DalFl0mg5npjA==
=8Rrj
-----END PGP SIGNATURE-----

--75ev2itd2dqhdhpm--
