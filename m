Return-Path: <linux-can+bounces-301-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B1E859FFF
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 10:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E66C1F2233D
	for <lists+linux-can@lfdr.de>; Mon, 19 Feb 2024 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CFA2377E;
	Mon, 19 Feb 2024 09:42:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80BC23741
	for <linux-can@vger.kernel.org>; Mon, 19 Feb 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335722; cv=none; b=uTqScIkfivfsk0x1L/bQWh4zNQfxqLyHoRNaOXpGdSLphoZ2VW7NwesyneV1PCznsNfQLfGn0pzBpYPFn70+nA+2i+H4j6A2WP3ZIsp8z6ZhfTz4VazBeq0lJxc5RhVAHs+XwKcriPUJY/EjHnxvWc7PwMLw4fPLR9SXphORYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335722; c=relaxed/simple;
	bh=9Mwx3cn2u7xWh1QnsT9nUyOVoZDHnymR83qjl4tETZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8D+VoNByHENVOcKqcWqY/rijJOL4x62ZpQhaQI5lMATDZfzGVSaSnb3xgIM72HBufcDzJkPhRKFIa119K7h+Gv6wiCAqoP4kMm1S8i3XOGtKZCqyqbKPfizXF8079k6oYzeNfU4Yiw0/90wkbKQPJk4IxDq3RO0DmHM6JZddMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rc09Z-0001Yn-CW; Mon, 19 Feb 2024 10:41:37 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rc09X-001cN7-O7; Mon, 19 Feb 2024 10:41:35 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 661C0291669;
	Mon, 19 Feb 2024 09:41:35 +0000 (UTC)
Date: Mon, 19 Feb 2024 10:41:34 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next 22/23] can: canxl: add virtual CAN network
 identifier support
Message-ID: <20240219-activist-smartly-87263f328a0c-mkl@pengutronix.de>
References: <20240213113437.1884372-1-mkl@pengutronix.de>
 <20240213113437.1884372-23-mkl@pengutronix.de>
 <20240219083910.GR40273@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2kutbo2fbwfxs45c"
Content-Disposition: inline
In-Reply-To: <20240219083910.GR40273@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--2kutbo2fbwfxs45c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.02.2024 08:39:10, Simon Horman wrote:
> +Dan Carpenter
>=20
> On Tue, Feb 13, 2024 at 12:25:25PM +0100, Marc Kleine-Budde wrote:
> > From: Oliver Hartkopp <socketcan@hartkopp.net>
> >=20
> > CAN XL data frames contain an 8-bit virtual CAN network identifier (VCI=
D).
> > A VCID value of zero represents an 'untagged' CAN XL frame.
> >=20
> > To receive and send these optional VCIDs via CAN_RAW sockets a new sock=
et
> > option CAN_RAW_XL_VCID_OPTS is introduced to define/access VCID content:
> >=20
> > - tx: set the outgoing VCID value by the kernel (one fixed 8-bit value)
> > - tx: pass through VCID values from the user space (e.g. for traffic re=
play)
> > - rx: apply VCID receive filter (value/mask) to be passed to the user s=
pace
> >=20
> > With the 'tx pass through' option CAN_RAW_XL_VCID_TX_PASS all valid VCID
> > values can be sent, e.g. to replay full qualified CAN XL traffic.
> >=20
> > The VCID value provided for the CAN_RAW_XL_VCID_TX_SET option will
> > override the VCID value in the struct canxl_frame.prio defined for
> > CAN_RAW_XL_VCID_TX_PASS when both flags are set.
> >=20
> > With a rx_vcid_mask of zero all possible VCID values (0x00 - 0xFF) are
> > passed to the user space when the CAN_RAW_XL_VCID_RX_FILTER flag is set.
> > Without this flag only untagged CAN XL frames (VCID =3D 0x00) are deliv=
ered
> > to the user space (default).
> >=20
> > The 8-bit VCID is stored inside the CAN XL prio element (only in CAN XL
> > frames!) to not interfere with other CAN content or the CAN filters
> > provided by the CAN_RAW sockets and kernel infrastruture.
> >=20
> > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > Link: https://lore.kernel.org/all/20240212213550.18516-1-socketcan@hart=
kopp.net
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Hi Oliver and Marc,
>=20
> I understand this pull-request has been accepted.

ACK

> But I noticed the problem described below which
> seems worth bringing to your attention.

Thanks Simon.

>=20
> ...
>=20
> > @@ -786,6 +822,21 @@ static int raw_getsockopt(struct socket *sock, int=
 level, int optname,
> >  		val =3D &ro->xl_frames;
> >  		break;
> > =20
> > +	case CAN_RAW_XL_VCID_OPTS:
> > +		/* user space buffer to small for VCID opts? */
> > +		if (len < sizeof(ro->raw_vcid_opts)) {
> > +			/* return -ERANGE and needed space in optlen */
> > +			err =3D -ERANGE;
> > +			if (put_user(sizeof(ro->raw_vcid_opts), optlen))
> > +				err =3D -EFAULT;
> > +		} else {
> > +			if (len > sizeof(ro->raw_vcid_opts))
> > +				len =3D sizeof(ro->raw_vcid_opts);
> > +			if (copy_to_user(optval, &ro->raw_vcid_opts, len))
> > +				err =3D -EFAULT;
> > +		}
> > +		break;
> > +
> >  	case CAN_RAW_JOIN_FILTERS:
> >  		if (len > sizeof(int))
> >  			len =3D sizeof(int);
>=20
> At the end of the switch statement the following code is present:
>=20
>=20
> 	if (put_user(len, optlen))
> 		return -EFAULT;
> 	if (copy_to_user(optval, val, len))
> 		return -EFAULT;
> 	return 0;
>=20
> And the call to copy_to_user() depends on val being set.
>=20
> It appears that for all other cases handled by the switch statement,
> either val is set or the function returns. But neither is the
> case for CAN_RAW_XL_VCID_OPTS which seems to mean that val may be used
> uninitialised.
>=20
> Flagged by Smatch.

And "err" is not evaluated, too.

Oliver, please send a fix and squash in this chance to reduce the scope
of "err" to the cases where it's actually used.

diff --git a/net/can/raw.c b/net/can/raw.c
index cb8e6f788af8..d4e27877c143 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -756,7 +756,6 @@ static int raw_getsockopt(struct socket *sock, int leve=
l, int optname,
         struct raw_sock *ro =3D raw_sk(sk);
         int len;
         void *val;
-        int err =3D 0;
=20
         if (level !=3D SOL_CAN_RAW)
                 return -EINVAL;
@@ -766,7 +765,9 @@ static int raw_getsockopt(struct socket *sock, int leve=
l, int optname,
                 return -EINVAL;
=20
         switch (optname) {
-        case CAN_RAW_FILTER:
+        case CAN_RAW_FILTER: {
+                int err =3D 0;
+
                 lock_sock(sk);
                 if (ro->count > 0) {
                         int fsize =3D ro->count * sizeof(struct can_filter=
);
@@ -791,7 +792,7 @@ static int raw_getsockopt(struct socket *sock, int leve=
l, int optname,
                 if (!err)
                         err =3D put_user(len, optlen);
                 return err;
-
+        }
         case CAN_RAW_ERR_FILTER:
                 if (len > sizeof(can_err_mask_t))
                         len =3D sizeof(can_err_mask_t);
@@ -822,7 +823,9 @@ static int raw_getsockopt(struct socket *sock, int leve=
l, int optname,
                 val =3D &ro->xl_frames;
                 break;
=20
-        case CAN_RAW_XL_VCID_OPTS:
+        case CAN_RAW_XL_VCID_OPTS: {
+                int err =3D 0;
+
                 /* user space buffer to small for VCID opts? */
                 if (len < sizeof(ro->raw_vcid_opts)) {
                         /* return -ERANGE and needed space in optlen */
@@ -836,7 +839,7 @@ static int raw_getsockopt(struct socket *sock, int leve=
l, int optname,
                                 err =3D -EFAULT;
                 }
                 break;
-
+        }
         case CAN_RAW_JOIN_FILTERS:
                 if (len > sizeof(int))
                         len =3D sizeof(int);

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2kutbo2fbwfxs45c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXTIkkACgkQKDiiPnot
vG8faQf/Y/rXZgKwoUCozsxwoMahVJCCxvCpazZmRg0RgW9DcpVLeiH1RtaAtS2F
Z56hRXgY+s8ftbcw1iXjnEG3uGeJ9msdoyvbRFqraD4XjBxdBl0fduFeH4UumtZL
ekEbWTrbkQ4AD7/ZJ8t/BK3q5XKgSjvUh0rbu7XT5wLWx7Re6ZTX+2NaIKiGqgvG
3HC9W4nBVvakf+YUAyrQLvCNWk2Se3QpzyS41f33o7S+wVh/7GelcdFRWMd0LbSO
xZWKzxwgZlJG7Nqs+tjQD+kdOgEvyE0BVlG5u5td0DEm00gLKcKcS/AmeJx194SY
Fb6w+Xyg2RS0FIjgL30ErUew55roJg==
=qEBn
-----END PGP SIGNATURE-----

--2kutbo2fbwfxs45c--

