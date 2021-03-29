Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25D734CCE5
	for <lists+linux-can@lfdr.de>; Mon, 29 Mar 2021 11:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhC2JTJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Mar 2021 05:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhC2JSq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Mar 2021 05:18:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDEEC061574
        for <linux-can@vger.kernel.org>; Mon, 29 Mar 2021 02:18:46 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lQo2n-0007Zj-3E; Mon, 29 Mar 2021 11:18:45 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:44b9:f06e:1c40:69b1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B9B5B602D7D;
        Mon, 29 Mar 2021 09:18:43 +0000 (UTC)
Date:   Mon, 29 Mar 2021 11:18:42 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>, kernel@pengutronix.de,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Subject: Re: [PATCH v13 01/11] can: etas_es58x: add core support for ETAS
 ES58X CAN USB interfaces
Message-ID: <20210329091842.xhssovbectrooj7f@pengutronix.de>
References: <20210319124141.247844-1-mkl@pengutronix.de>
 <20210319124141.247844-2-mkl@pengutronix.de>
 <88fc8ae5-a585-e5a7-b8c8-3f4481cea7e1@pengutronix.de>
 <CAMZ6RqL+n4tRy-B-W+fzW5B3QV6Bedrko57pU_0TE023Oxw_5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mffehwydzhopqchj"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqL+n4tRy-B-W+fzW5B3QV6Bedrko57pU_0TE023Oxw_5w@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--mffehwydzhopqchj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.03.2021 19:33:02, Vincent MAILHOL wrote:
> > > +/**
> > > + * es58x_set_skb_timestamp() - Set the hardware timestamp of an skb.
> > > + * @netdev: CAN network device.
> > > + * @skb: socket buffer of a CAN message.
> > > + * @timestamp: Timestamp received from an ES58X device.
> > > + *
> > > + * Used for both received and loopback messages.
> > > + *
> > > + * Return: zero on success, -EFAULT if @skb is NULL.
> >
> > That's not correct.
> >
> > Please make sure to call it with skb !=3D NULL and make it a void funct=
ion.
>=20
> Ack.
> All calls to that function already checked that the skb was not NULL.
> I will make the function void.
>=20
> > Does it make sense for you to use of struct cyclecounter/struct timecou=
nter.
> > Have a look at:
> >
> > https://lore.kernel.org/linux-can/20210304160328.2752293-6-mkl@pengutro=
nix.de/
> >
> > As your device already provides a u64 timestamp you don't need the work=
er.
>=20
> I saw your patch but because my device already uses a 64 bit
> counter, I did not see a benefit to do so.
>=20
> Which problem would the struct cyclecounter/struct timecounter
> solve for my driver?

It probably doesn't matter.

>=20
> > > + */
> > > +static int es58x_set_skb_timestamp(struct net_device *netdev,
> > > +                                struct sk_buff *skb, u64 timestamp)
> > > +{
> > > +     struct es58x_device *es58x_dev =3D es58x_priv(netdev)->es58x_de=
v;
> > > +     struct skb_shared_hwtstamps *hwts;
> > > +
> > > +     hwts =3D skb_hwtstamps(skb);
> > > +     /* Ignoring overflow (overflow on 64 bits timestamp with nano
> > > +      * second precision would occur after more than 500 years).
> > > +      */
> > > +     hwts->hwtstamp =3D ns_to_ktime(es58x_timestamp_to_ns(timestamp)=
 +
> > > +                                  es58x_dev->realtime_diff_ns);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +/**
> > > + * es58x_rx_timestamp() - Handle a received timestamp.
> > > + * @es58x_dev: ES58X device.
> > > + * @timestamp: Timestamp received from a ES58X device.
> > > + *
> > > + * Calculate the difference between the ES58X device and the kernel
> > > + * internal clocks. This difference will be later used as an offset =
to
> > > + * convert the timestamps of RX and loopback messages to match the
> > > + * kernel system time (e.g. convert to UNIX time).
> >
> > I'm not sure if we want to have the timestamp based on the kernel syste=
m time.
> > The problem I see is that your clock is not synchronized to your system=
 clock
> > and will probably drift, so you might accumulate an offset.
> >
> > When looking at candump output, a timestamp that more or less current t=
ime gives
> > a false sense of correctness, but if the timestamp is short after 01.0.=
1970 you
> > don't expect it to be correct.
> >
> > But this is a different problem.....
>=20
> Here, we are discussing tastes and colors. I am perfectly aware
> that the two quartz used by the device and the kernel are not in
> sync and will drift away from each other. However, when looking
> at my traces, I like to have a hint of when an event occurs. In
> the worst case, the quartz might drift away up to four seconds a day,
> but the date, the hours and the minutes stay accurate.
>=20
> So it is a discussion of making it convenient versus making it dummy proo=
f.
>=20
> If there is a strong consensus not to base the hardware timestamp
> on the kernel, then I will remove it. But if I have the choice, I
> prefer to keep it as it is.

I've changed the mcp251xfd timestamp to sync to the kernel time, too :)

[...]

> > > +/**
> > > + * es58x_rx_err_msg() - Handle a received CAN event or error message.
> > > + * @netdev: CAN network device.
> > > + * @error: Error code.
> > > + * @event: Event code.
> > > + * @timestamp: Timestamp received from a ES58X device.
> > > + *
> > > + * Handle the errors and events received by the ES58X device, create
> > > + * a CAN error skb and post it.
> > > + *
> > > + * In some rare cases the devices might get stucked alternating betw=
een
> > > + * CAN_STATE_ERROR_PASSIVE and CAN_STATE_ERROR_WARNING. To prevent
> > > + * this behavior, we force a bus off state if the device goes in
> > > + * CAN_STATE_ERROR_WARNING for ES58X_MAX_CONSECUTIVE_WARN consecutive
> > > + * times with no successful transmission or reception in between.
> > > + *
> > > + * Once the device is in bus off state, the only way to restart it is
> > > + * through the drivers/net/can/dev.c:can_restart() function. The
> > > + * device is technically capable to recover by itself under certain
> > > + * circumstances, however, allowing self recovery would create
> > > + * complex race conditions with drivers/net/can/dev.c:can_restart()
> > > + * and thus was not implemented. To activate automatic restart, plea=
se
> > > + * set the restart-ms parameter (e.g. ip link set can0 type can
> > > + * restart-ms 100).
> > > + *
> > > + * If the bus is really instable, this function would try to send a
> > > + * lot of log messages. Those are rate limited (i.e. you will see
> > > + * messages such as "net_ratelimit: XXX callbacks suppressed" in
> > > + * dmesg).
> > > + *
> > > + * Return: zero on success, errno when any error occurs.
> > > + */
> > > +int es58x_rx_err_msg(struct net_device *netdev, enum es58x_err error,
> > > +                  enum es58x_event event, u64 timestamp)
> > > +{
[...]
> > > +     switch (event) {
> > > +     case ES58X_EVENT_OK:    /* 0: No event */
> > > +             break;
> > > +
> > > +     case ES58X_EVENT_CRTL_ACTIVE:
> > > +             if (can->state =3D=3D CAN_STATE_BUS_OFF) {
> > > +                     netdev_err(netdev,
> > > +                                "%s: state transition: BUS OFF -> AC=
TIVE\n",
> > > +                                __func__);
> >
> > Your device should not go autoamtically from bus off to active. Only wh=
en it's
> > restarted by the kernel (or the user).
>=20
> Agree, this is why it is an error message.
>=20
> CAN controllers are allowed to automatically recover under very
> specific conditions (c.f. ISO 11898-1, section 10.9.4 "Bus
> integration state": "Nodes that are in bus-off state shall
> re-enter the bus integration state immediately after detecting
> the idle condition if the bus-off recovery condition is not yet
> met").

On Linux the controllers should not recover automatically, but
controlled by the kernel as configured by restart-ms. So shut down the
controller in case of a bus off and wait for the kernel to recover via
priv->can.do_set_mode(CAN_MODE_START).

> Aside from the idle condition, I do not think that the nodes are
> allowed to self-recover.

ACK

> But because the can_restart() function does not use locks for the
> echo_skb[], I treat this scenario by printing an error message and
> ignoring it.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--mffehwydzhopqchj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBhm3AACgkQqclaivrt
76m7Xwf+NaCLsWegYoIi4bv5ku9OALRANNAiItx1JwJ0JciznkZC2399GcI7XTZ4
ayvAw+6YtOb1H0z8qk3U0ky2TTRM16sFc2KL1xzIyF8rERYessCxVVbLxL9P/ckd
VwanO9Q95LQ3ZjUVRYJWxJ1iKFNam9HF43l5C4gUIcangu9B8XPnPQ+OW9JDohAr
rJSR1U2f/QTBKt8a42MHjS0gu+Qz3xd1ecNg62QJvEfuon1dfQzv0bm4Ex9ZLwFH
pxzzqeaA/QFS0wKKvM/RpeFcrocR13QevZQikajmmq/XBL7r1nHlzxvW6FlNDi9W
rqtH0+Foc3p0CMXmr8JAWQufwX+UWw==
=/aRw
-----END PGP SIGNATURE-----

--mffehwydzhopqchj--
