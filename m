Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816693529E0
	for <lists+linux-can@lfdr.de>; Fri,  2 Apr 2021 12:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhDBKrl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Apr 2021 06:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBKrk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Apr 2021 06:47:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E67C0613E6
        for <linux-can@vger.kernel.org>; Fri,  2 Apr 2021 03:47:39 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lSHKy-0000yQ-Sv; Fri, 02 Apr 2021 12:47:36 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:df90:cea7:131e:a899])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E30B760695D;
        Fri,  2 Apr 2021 10:47:35 +0000 (UTC)
Date:   Fri, 2 Apr 2021 12:47:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Subject: Re: [PATCH v14 1/4] can: etas_es58x: add core support for ETAS ES58X
 CAN USB interfaces
Message-ID: <20210402104735.ucv6it3pk4ze4umy@pengutronix.de>
References: <20210321104103.213308-1-mailhol.vincent@wanadoo.fr>
 <20210321104103.213308-2-mailhol.vincent@wanadoo.fr>
 <20210329123636.5xrgzdxyt54y7coe@pengutronix.de>
 <CAMZ6RqKeEoNGN0iZUfEG8x=FMHu4d2ZE=0QPiOxSXTrXFjg9rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6theihddu7a74w4x"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKeEoNGN0iZUfEG8x=FMHu4d2ZE=0QPiOxSXTrXFjg9rg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--6theihddu7a74w4x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.04.2021 18:56:33, Vincent MAILHOL wrote:
> > > +int es58x_rx_err_msg(struct net_device *netdev, enum es58x_err error,
> > > +                  enum es58x_event event, u64 timestamp)
> > > +{
> > > +     struct es58x_priv *priv =3D es58x_priv(netdev);
> > > +     struct can_priv *can =3D netdev_priv(netdev);
> > > +     struct can_device_stats *can_stats =3D &can->can_stats;
> > > +     struct can_frame *cf;
> >
> > =3D NULL;
> >
> > So that the if (cf) properly works...
>=20
> I actually expected cfto be set to NULL when an error
> occurred (same as skb).
>=20
> But indeed, cf is not initialised if the allocation fails. I was
> wondering if it would not be better to make both alloc_can_skb()
> and and alloc_canfd_skb() set cf to NULL. That would remove a
> pitfall.

Makes sense.

> If you like the idea, I can submit a patch.

Sorry creating this drive by patch. The patch description took longer
than the actual patch :)

[...]

> > > +/**
> > > + * es58x_flush_cmd_buf() - Reset the buffer for URB commands.
> > > + * @es58x_dev: ES58X device.
> > > + */
> > > +static void es58x_flush_cmd_buf(struct es58x_device *es58x_dev)
> > > +{
> > > +     memset(&es58x_dev->rx_cmd_buf, 0, es58x_dev->param->rx_urb_cmd_=
max_len);
> >
> > I think you can skip the memset, as you're overwriting the data anyways
> > and account the valid length.
>=20
> The idea was that this buffer might contain confidential
> data (e.g. an UDS seed and key pair or a VIN) so I cleared it out
> of precaution.

I see, I think the kernel takes care of explicitly clearing not key
material after using, but not unencrypted (i.e. plaintext) network
traffic.

> I recognize that this is useless as an attacker can just retrieve
> the information from a candump, no need to look into some kernel
> temporary buffer for that...
>=20
> I will remove it.

Ok.

[...]

> > > +static signed int es58x_split_urb(struct es58x_device *es58x_dev,
> > > +                               struct urb *urb)
> > > +{
> > > +     const u8 es58x_is_alive =3D 0x11;
> >
> > We usually use #defines for this
>=20
> ACK.
>=20
> > > +     union es58x_urb_cmd *urb_cmd;
> > > +     u8 *raw_cmd =3D urb->transfer_buffer;
> > > +     ssize_t raw_cmd_len =3D urb->actual_length;
> >
> > urb->actual_length is an u32
>=20
> Below, I test that (raw_cmd_len > 0) in a while loop. I want to
> make this variable signed to avoid an infinite loop in case of an
> off by one error (which should not occur, see this as a safety
> net).

makes sense

> I will make this a s32.
>=20
> Also, the size is represented by a u16 on the device so s32 is
> more than enough.
>=20
> > > +     int ret;
> > > +
> > > +     if (es58x_dev->rx_cmd_buf_len !=3D 0) {
> > > +             ret =3D es58x_handle_incomplete_cmd(es58x_dev, urb);
> > > +             if (ret !=3D -ENODATA)
> > > +                     es58x_flush_cmd_buf(es58x_dev);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +
> > > +             raw_cmd +=3D ret;
> > > +             raw_cmd_len -=3D ret;
> > > +     }
> > > +
> > > +     while (raw_cmd_len > 0) {
> > > +             if (raw_cmd[0] =3D=3D es58x_is_alive) {
> > > +                     raw_cmd++;
> > > +                     raw_cmd_len--;
> > > +                     continue;
> > > +             }
> > > +             urb_cmd =3D (union es58x_urb_cmd *)raw_cmd;
> > > +             ret =3D es58x_check_rx_urb(es58x_dev, urb_cmd, raw_cmd_=
len);
> > > +             if (ret > 0) {
> >
> > Here the length field in the usb_cmd is valid, it lies within the total
> > length of the rx'ed urb.
> >
> > > +                     es58x_handle_urb_cmd(es58x_dev, urb_cmd);
> >
> > As far as I see you're checking in ops->handle_urb_cmd() if the
> > urb_cmd's length is long enough for the command that's currently
> > processed, right?
>=20
> The check of the urb_cmd's length occurs in es58x_check_rx_urb():
>     if (urb_cmd_len > param->rx_urb_cmd_max_len) {
> In that same function, I then check that urb_cmd's length is long enough:
>     } else if (urb_actual_len < urb_cmd_len) {
> If it is not long enough, the not-yet-consumed data of the urb
> is buffered and once a new urb comes up, those are concatenated.
>=20
> After that, ops->handle_urb_cmd() will dispatch the command
> depending on the cmd_id and additional checks will be done on the
> size of the payload.

Good, this is how I understood the code.

[...]

> > > +/**
> > > + * es58x_open() - Open and start network device.
> > > + * @netdev: CAN network device.
> > > + *
> > > + * Called when the network transitions to the up state.
> > > + *
> > > + * Return: zero on success, errno when any error occurs.
> > > + */
> > > +static int es58x_open(struct net_device *netdev)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret =3D open_candev(netdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret =3D es58x_enable_channel(netdev);
> > > +     if (ret)
> > > +             return ret;
> >
> > Please do an as complete as possible reset and configuration during
> > open(). If there is any error a ifdown/ifup should fix it. Here on a USB
> > device with multiple interfaces it's not as easy as on devices with only
> > one CAN interface.
>=20
> ACK.
>=20
> I will use a function as below to check if all interfaces are
> down.
>=20
> static bool es58x_are_all_channels_closed(struct es58x_device *es58x_dev)
> {
>     int i;
>=20
>     for (i =3D 0; i < es58x_dev->num_can_ch; i++) {
>         struct can_priv *can_priv =3D netdev_priv(es58x_dev->netdev[i]);
>         if (can_priv->state !=3D CAN_STATE_STOPPED)
>             return false;
>     }
>     return true;
> }
>=20
> I will modify both es58x_open() and es58x_close().

Have a look at
https://elixir.bootlin.com/linux/v5.11/source/include/linux/kref.h

I'm not sure if kref is overkill here :)

[...]

> > > +/**
> > > + * es58x_start_xmit() - Transmit an skb.
> > > + * @skb: socket buffer of a CAN message.
> > > + * @netdev: CAN network device.
> > > + *
> > > + * Called when a packet needs to be transmitted.
> > > + *
> > > + * This function relies on Byte Queue Limits (BQL). The main benefit
> > > + * it to increase the throughput by allowing bulk transfers
> > > + * (c.f. xmit_more flag).
> > > + *
> > > + * Queues up to tx_bulk_max messages in &tx_urb buffer and does
> > > + * a bulk send of all messages in one single URB.
> > > + *
> > > + * Return:
> > > + * NETDEV_TX_OK if we could manage the @skb (either transmit it or
> > > + * drop it)
> > > + *
> > > + * NETDEV_TX_BUSY if the device is busy (this is a bug, the network
> > > + * device stop/wake management should prevent this return code to
> > > + * occur).
> > > + */
> > > +static netdev_tx_t es58x_start_xmit(struct sk_buff *skb,
> > > +                                 struct net_device *netdev)
> > > +{
> > > +     struct es58x_priv *priv =3D es58x_priv(netdev);
> > > +     struct es58x_device *es58x_dev =3D priv->es58x_dev;
> > > +     unsigned int packet_idx, frame_len;
> > > +     int ret;
> > > +
> > > +     if (can_dropped_invalid_skb(netdev, skb)) {
> > > +             if (priv->tx_urb)
> > > +                     goto xmit_commit;
> > > +             return NETDEV_TX_OK;
> > > +     }
> > > +
> > > +     if (!priv->tx_urb) {
> > > +             priv->tx_urb =3D es58x_get_tx_urb(es58x_dev);
> > > +             if (!priv->tx_urb) {
> > > +                     ret =3D -ENOMEM;
> > > +                     goto drop_skb;
> > > +             }
> > > +             memset(priv->tx_urb->transfer_buffer, 0,
> > > +                    es58x_dev->param->tx_urb_cmd_max_len);
> >
> > Is this memset() needed?
>=20
> In current state, it is, but a small modification should be
> enough to have it removed.

nice!

> > > +             priv->tx_urb->transfer_buffer_length =3D
> > > +                 es58x_dev->param->urb_cmd_header_len;
> > > +             priv->tx_can_msg_cnt =3D 0;
> > > +             priv->tx_can_msg_is_fd =3D can_is_canfd_skb(skb);
> > > +     } else if (priv->tx_can_msg_is_fd !=3D can_is_canfd_skb(skb)) {
> > > +             /* Can not do bulk send with mixed CAN and CAN FD frame=
s. */
> > > +             ret =3D es58x_xmit_commit(netdev);
> > > +             if (ret)
> > > +                     goto drop_skb;
> > > +             return es58x_start_xmit(skb, netdev);
> >
> > In the kernel the stack is limited, does it make sense to re-arrange
> > this to avoid recursion?
>=20
> This is a tail recursion so with the good optimisation, it will
> not increase the stack. And also, the recursive call occurs one
> time max. So I thought it was acceptable.

This were my thoughts as well.

> Regardless, rearranging the code is trivial, so I will remove
> this recursion.

fine
[...]

> > > +/**
> > > + * struct es58x_priv - All information specific to a CAN channel.
> > > + * @can: struct can_priv must be the first member (Socket CAN relies
> > > + *   on the fact that function netdev_priv() returns a pointer to
> > > + *   a struct can_priv).
> > > + * @es58x_dev: pointer to the corresponding ES58X device.
> > > + * @tx_urb: Used as a buffer to concatenate the TX messages and to do
> > > + *   a bulk send. Please refer to es58x_start_xmit() for more
> > > + *   details.
> > > + * @tx_tail: Index of the oldest packet still pending for
> > > + *   completion. @tx_tail & echo_skb_mask represents the beginning
> > > + *   of the echo skb FIFO, i.e. index of the first element.
> > > + * @tx_head: Index of the next packet to be sent to the
> > > + *   device. @tx_head & echo_skb_mask represents the end of the
> > > + *   echo skb FIFO plus one, i.e. the first free index.
> >
> > Is this the description 100% correct? In xmit() you're using tx_head +
> > tx_can_msg_cnt to address the next packet to be send.
> >
> > >> +    packet_idx =3D priv->tx_head + priv->tx_can_msg_cnt;
> >
> > But in xmit_more() you're not taking tx_can_msg_cnt into account.
>=20
> The idea was that in es58x_start_xmit() and es58x_xmit_more(),
> the changes were not yet committed and thus tx_head not yet
> updated.
>=20
> After a bit more thinking, it seems better to directly update
> tx_head each time a packet is queued in can_echo_skb[]. I will
> keep above description and modify the code.

fine

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6theihddu7a74w4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBm9kMACgkQqclaivrt
76l/iwf9FIQjNv+qJPmhVFaH/mNluFTXPy4BlqcjHgv+TGbawCpikEJ2we1kTp1W
GL9764CPlQaDatt3g/z1Nqwlc64AAsq9GzfB4s4AdhYdo48XLSSEW5ZKmHOOJu80
t2UL2LO3/n1si1ImmPnMlULDCL/Bts26F1872qGvhuBCRs9eCorEeRzIK7s9lSCc
UubDYuVidr8dtmqyhr8V+mJPwmjNfCNAvUZKthYhYprWZRxdBkgTCq0g+epF3cxx
uliwoH3vaH9cWYkONKJ/t3DJ4cK1S+4TTQ+TjY+frJbKaGWtjpSV0b8UKFeveLvP
JTOlS9XCuyw+pTeLnyXl9uqzbYOD7A==
=TFzQ
-----END PGP SIGNATURE-----

--6theihddu7a74w4x--
