Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F73332FDD
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 21:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhCIU1R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 15:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCIU0m (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 15:26:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB58C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 12:26:42 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJiwC-0004RL-IE; Tue, 09 Mar 2021 21:26:40 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:b198:25bf:9f04:24e4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0F0175F209C;
        Tue,  9 Mar 2021 20:26:38 +0000 (UTC)
Date:   Tue, 9 Mar 2021 21:26:37 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Subject: Re: [PATCH v12 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
Message-ID: <20210309202637.mmenugxlsscvhdtx@pengutronix.de>
References: <20210308163445.103636-1-mailhol.vincent@wanadoo.fr>
 <20210308163445.103636-2-mailhol.vincent@wanadoo.fr>
 <2b43e72b-c561-d144-c01e-c4ea361cc932@pengutronix.de>
 <CAMZ6RqJADCFL_=uv-=hNjiNj+CZkUDNWjLTP3eV010KGj+H49A@mail.gmail.com>
 <20210309125708.ei75tr5vp2sanfh6@pengutronix.de>
 <CAMZ6Rq+_QTDM5R++kQAtHjUHiydaV3njcH-up+uY7Jd8dggwQA@mail.gmail.com>
 <20210309153547.q7zspf46k6terxqv@pengutronix.de>
 <CAMZ6Rq+bKzRqAg9egg6NL_mJHTwY02em2dR+O33OGe6xqt-nqg@mail.gmail.com>
 <CAMZ6RqKR3HYrJvc+=rXK40Yq=L3pgvTWwgC=reYWSN9XdQ4ksg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bkieglku3e3q2jb2"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKR3HYrJvc+=rXK40Yq=L3pgvTWwgC=reYWSN9XdQ4ksg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--bkieglku3e3q2jb2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.03.2021 03:26:12, Vincent MAILHOL wrote:
> > > > @@ -136,3 +136,11 @@ void dql_init(struct dql *dql, unsigned int ho=
ld_time)
> > > >       dql_reset(dql);
> > > >  }
> > > >  EXPORT_SYMBOL(dql_init);
> > > > +
> > > > +void dql_set_min_limit(struct dql *dql, unsigned int min_limit)
> > > > +{
> > > > +#ifdef CONFIG_BQL
> > >
> > > remove this ifdef
> > >
> > > > +     dql->min_limit =3D min_limit;
> > > > +#endif
> > > > +}
> > > > +EXPORT_SYMBOL(dql_set_min_limit);

Just for completeness. If it would be a real function, the kernel way
would be:

#ifdef CONFIG_BQL
void dql_set_min_limit(struct dql *dql, unsigned int min_limit)
{
     dql->min_limit =3D min_limit;
}

EXPORT_SYMBOL(dql_set_min_limit);
#endif

=2E..and have a static inline no-op in the header file.

> >
> > Actually, after doing a few more tests, this is a bit more complicated
> > than anticipated.
> > The dql member of struct netdev_queue is also guarded by a #ifdef CONFI=
G_BQL:
> > https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice.=
h#L629
> >
> > This means that under the current idea, we would also need to guard
> > the call to dql_set_min_limit():
> > #ifdef CONFIG_BQL
> >     dql_set_min_limit(&netdev_get_tx_queue(netdev, 0)->dql,
> >               es58x_dev->param->dql_limit_min);
> > #ifdef CONFIG_BQL
> >
> > This kills the initial intent of not using the #ifdef CONFIG_BQL to
> > set the value.
> >
> > This leads to the need to do:
> > void netdev_queue_set_dql_min_limit(struct netdev_queue *q, unsigned in=
t min_limit)
>=20
> Of course, I meant:
> static inline void netdev_queue_set_dql_min_limit(struct netdev_queue
> *q, unsigned int min_limit)
>=20
> > {
> > #ifdef CONFIG_BQL
> >     q->dql.min_limit =3D min_limit;
> > #endif
> > }
> > which would probably be inside /include/linux/netdevice.h.
> >
> > Does it make sense?

Yes, or the other way in illustrated above, if someone doesn't like
static inlines with ifdefs inside the function.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--bkieglku3e3q2jb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBH2fsACgkQqclaivrt
76lA5Qf/VF2Ko+rCULAEnENpJ3vF2HEz/FXHspeMctqLDmYHfW7q1w4dh3iFHmC8
mt0/OGi+kDGinjrtT2PSmKHbzyJ/6BpFMCGnxpDulzHA12XVOwvD+FfQiCbycVS5
9iJlIRhg8iREYnyKlOgais7JsY2bEND6yziI7aK7Mp85NtgL9Vpm7pnYrUPHyLkY
daj5OW5xJfdqt8T7G2R9WH9rc4U2FnbY08ZfhB+MT03AiMZZQNjfEOZKCq3JFzFc
VOJI7F3u8jPt1ZnFIh1lQLd0Kl8CYIiC+IXmdJDyo7Ugas9RjZhn50mDIiJL6esY
bxvR9w1/z5ujKhNNYBdZg85CKYyvYQ==
=y5DY
-----END PGP SIGNATURE-----

--bkieglku3e3q2jb2--
