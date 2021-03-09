Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDB9332A9E
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 16:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhCIPgK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 10:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhCIPfv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 10:35:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C43AC06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 07:35:51 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJeOj-0008Tw-OS; Tue, 09 Mar 2021 16:35:49 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7F8725F1E9C;
        Tue,  9 Mar 2021 15:35:48 +0000 (UTC)
Date:   Tue, 9 Mar 2021 16:35:47 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Subject: Re: [PATCH v12 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
Message-ID: <20210309153547.q7zspf46k6terxqv@pengutronix.de>
References: <20210308163445.103636-1-mailhol.vincent@wanadoo.fr>
 <20210308163445.103636-2-mailhol.vincent@wanadoo.fr>
 <2b43e72b-c561-d144-c01e-c4ea361cc932@pengutronix.de>
 <CAMZ6RqJADCFL_=uv-=hNjiNj+CZkUDNWjLTP3eV010KGj+H49A@mail.gmail.com>
 <20210309125708.ei75tr5vp2sanfh6@pengutronix.de>
 <CAMZ6Rq+_QTDM5R++kQAtHjUHiydaV3njcH-up+uY7Jd8dggwQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o3x2ifhrjnq67qfr"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+_QTDM5R++kQAtHjUHiydaV3njcH-up+uY7Jd8dggwQA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--o3x2ifhrjnq67qfr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 22:10:08, Vincent MAILHOL wrote:
> Sounds good to me. I will prepare a patch to explain the issue
> and try to introduce the dql_set_min_limit() function.
>=20
> Meanwhile, I would be thankful if you could continue the review :)

Thanks for the mail, looks good.

One note for the patch, though:

> diff --git a/include/linux/dynamic_queue_limits.h b/include/linux/dynamic=
_queue_limits.h
> index 407c2f281b64..32437f168a35 100644
> --- a/include/linux/dynamic_queue_limits.h
> +++ b/include/linux/dynamic_queue_limits.h
> @@ -103,6 +103,9 @@ void dql_reset(struct dql *dql);
>  /* Initialize dql state */
>  void dql_init(struct dql *dql, unsigned int hold_time);
> =20
> +/* Set the dql minimum limit */
#ifdef CONFIG_DQL
> +void dql_set_min_limit(struct dql *dql, unsigned int min_limit);
#else
static inline void dql_set_min_limit(struct dql *dql, unsigned int min_limi=
t)
{
}
#endif
> +
>  #endif /* _KERNEL_ */
> =20
>  #endif /* _LINUX_DQL_H */
> diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
> index fde0aa244148..8b6ad1e0a2e3 100644
> --- a/lib/dynamic_queue_limits.c
> +++ b/lib/dynamic_queue_limits.c

This file is only compiled if CONFIG_DQL is set, see lib/Makefile:

| obj-$(CONFIG_DQL) +=3D dynamic_queue_limits.o

> @@ -136,3 +136,11 @@ void dql_init(struct dql *dql, unsigned int hold_tim=
e)
>  	dql_reset(dql);
>  }
>  EXPORT_SYMBOL(dql_init);
> +
> +void dql_set_min_limit(struct dql *dql, unsigned int min_limit)
> +{
> +#ifdef CONFIG_BQL

remove this ifdef

> +	dql->min_limit =3D min_limit;
> +#endif
> +}
> +EXPORT_SYMBOL(dql_set_min_limit);

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--o3x2ifhrjnq67qfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBHldEACgkQqclaivrt
76lSfAf/UpH3sEtiQZmsUBAXjDH6BAup/KGPBJDzjV0Iso5nuf/BURPZ+y7AefnT
IbjLawqEvKueZqEybx/EYYa8HTZbCr2Bg1KOroZAZXGwFsBDbTPVkmoz+ymM0SjK
PJjW/JKvvOUvxnDkDbIWcLtzu3+5oUgNOdkysJ2oPAQE9AMqe02kdq8rHfNAM4Em
cGZVerfKwDMmC+vaQNYmiqI1mhj1Wpixz1W7p5rvxjqZTHE5rdXJNXNH6CYqbGrq
GAH9PHgVLoZV5L30sHxMRohGCXHtXGVfKQP6WdEt2k410B7hVMdNKN+KOGQvL6e+
nhJuW9doof56bwA+Oz6vZSLmWu/UiQ==
=hfuf
-----END PGP SIGNATURE-----

--o3x2ifhrjnq67qfr--
