Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 420B573004
	for <lists+linux-can@lfdr.de>; Wed, 24 Jul 2019 15:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfGXNgX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 Jul 2019 09:36:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48299 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfGXNgX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Jul 2019 09:36:23 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hqHRN-00029k-CK; Wed, 24 Jul 2019 15:36:21 +0200
Received: from [IPv6:2003:c7:729:c703:c9d4:83d5:b99:4f4d] (unknown [IPv6:2003:c7:729:c703:c9d4:83d5:b99:4f4d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5D69B437E4E;
        Wed, 24 Jul 2019 13:36:20 +0000 (UTC)
To:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20190723130003.17733-1-socketcan@hartkopp.net>
 <20190723130003.17733-2-socketcan@hartkopp.net>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 2/2] can: gw: add support for CAN FD frames
Message-ID: <3c5aabfc-10cf-51b1-e76e-08c5cce8b56f@pengutronix.de>
Date:   Wed, 24 Jul 2019 15:36:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723130003.17733-2-socketcan@hartkopp.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ib9xUgT2AmhpgM8ujZjI23KND1pu5SyvA"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ib9xUgT2AmhpgM8ujZjI23KND1pu5SyvA
Content-Type: multipart/mixed; boundary="34iUuO2WvReYf4SIEUeZwQs82qNpPwCkZ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <3c5aabfc-10cf-51b1-e76e-08c5cce8b56f@pengutronix.de>
Subject: Re: [PATCH 2/2] can: gw: add support for CAN FD frames
References: <20190723130003.17733-1-socketcan@hartkopp.net>
 <20190723130003.17733-2-socketcan@hartkopp.net>
In-Reply-To: <20190723130003.17733-2-socketcan@hartkopp.net>

--34iUuO2WvReYf4SIEUeZwQs82qNpPwCkZ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 7/23/19 3:00 PM, Oliver Hartkopp wrote:
> Introduce CAN FD support which needs an extension of the netlink API to=
 pass
> CAN FD type content to the kernel which has a different size to Classic=
 CAN.
> Additionally the struct canfd_frame has a new 'flags' element that can =
now
> be modified with can-gw.
>=20
> The new CGW_FLAGS_CAN_FD option flag defines whether the routing job ha=
ndles
> Classic CAN or CAN FD frames. This setting is very strict at reception =
time
> and enables the new possibilities, e.g. CGW_FDMOD_* and modifying the f=
lags
> element of struct canfd_frame, only when CGW_FLAGS_CAN_FD ist set.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---

I've added these patches to the testing branch:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/lo=
g/?h=3Dtesting

While applying I've fixes some checkpatch warnings/errors.

>  include/uapi/linux/can/gw.h |  14 ++-
>  net/can/gw.c                | 233 ++++++++++++++++++++++++++++++++----=

>  2 files changed, 220 insertions(+), 27 deletions(-)
>=20
> diff --git a/include/uapi/linux/can/gw.h b/include/uapi/linux/can/gw.h
> index ed811bc463b5..3aea5388c8e4 100644
> --- a/include/uapi/linux/can/gw.h
> +++ b/include/uapi/linux/can/gw.h
> @@ -80,6 +80,10 @@ enum {
>  	CGW_DELETED,	/* number of deleted CAN frames (see max_hops param) */
>  	CGW_LIM_HOPS,	/* limit the number of hops of this specific rule */
>  	CGW_MOD_UID,	/* user defined identifier for modification updates */
> +	CGW_FDMOD_AND,	/* CAN FD frame modification binary AND */
> +	CGW_FDMOD_OR,	/* CAN FD frame modification binary OR */
> +	CGW_FDMOD_XOR,	/* CAN FD frame modification binary XOR */
> +	CGW_FDMOD_SET,	/* CAN FD frame modification set alternate values */
>  	__CGW_MAX
>  };
> =20
> @@ -88,6 +92,7 @@ enum {
>  #define CGW_FLAGS_CAN_ECHO 0x01
>  #define CGW_FLAGS_CAN_SRC_TSTAMP 0x02
>  #define CGW_FLAGS_CAN_IIF_TX_OK 0x04
> +#define CGW_FLAGS_CAN_FD 0x08
> =20
>  #define CGW_MOD_FUNCS 4 /* AND OR XOR SET */
> =20
> @@ -96,8 +101,9 @@ enum {
>  #define CGW_MOD_DLC	0x02		/* contains the data length in bytes */
>  #define CGW_MOD_LEN	CGW_MOD_DLC	/* CAN FD length representation */
>  #define CGW_MOD_DATA	0x04
> +#define CGW_MOD_FLAGS	0x08		/* CAN FD flags */
> =20
> -#define CGW_FRAME_MODS 3 /* ID DLC/LEN DATA */
> +#define CGW_FRAME_MODS 4 /* ID DLC/LEN DATA FLAGS */
> =20
>  #define MAX_MODFUNCTIONS (CGW_MOD_FUNCS * CGW_FRAME_MODS)
> =20
> @@ -106,7 +112,13 @@ struct cgw_frame_mod {
>  	__u8 modtype;
>  } __attribute__((packed));
> =20
> +struct cgw_fdframe_mod {
> +	struct canfd_frame cf;
> +	__u8 modtype;
> +} __attribute__((packed));
> +
>  #define CGW_MODATTR_LEN sizeof(struct cgw_frame_mod)
> +#define CGW_FDMODATTR_LEN sizeof(struct cgw_fdframe_mod)
> =20
>  struct cgw_csum_xor {
>  	__s8 from_idx;
> diff --git a/net/can/gw.c b/net/can/gw.c
> index aecccc15c972..b75c0897540a 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -60,7 +60,7 @@
>  #include <net/net_namespace.h>
>  #include <net/sock.h>
> =20
> -#define CAN_GW_VERSION "20170425"
> +#define CAN_GW_VERSION "20190105"
>  #define CAN_GW_NAME "can-gw"
> =20
>  MODULE_DESCRIPTION("PF_CAN netlink gateway");
> @@ -150,6 +150,18 @@ struct cgw_job {
>  	u16 flags;
>  };
> =20
> +/* make sure we get a valid CAN frame data length after manipulation *=
/
> +const u8 validate_len[] =3D {0, 1, 2, 3, 4, 5, 6, 7, 8,		/* 0 - 8 */
> +			   12, 12, 12, 12,			/* 9 - 12 */
> +			   16, 16, 16, 16,			/* 13 - 16 */
> +			   20, 20, 20, 20,			/* 17 - 20 */
> +			   24, 24, 24, 24,			/* 21 - 24 */
> +			   32, 32, 32, 32, 32, 32, 32, 32,	/* 25 - 32 */
> +			   48, 48, 48, 48, 48, 48, 48, 48,	/* 33 - 40 */
> +			   48, 48, 48, 48, 48, 48, 48, 48,	/* 41 - 48 */
> +			   64, 64, 64, 64, 64, 64, 64, 64,	/* 49 - 56 */
> +			   64, 64, 64, 64, 64, 64, 64, 64};	/* 57 - 64 */
> +
>  /* modification functions that are invoked in the hot path in can_can_=
gw_rcv */
> =20
>  #define MODFUNC(func, op) static void func(struct canfd_frame *cf, \
> @@ -157,17 +169,56 @@ struct cgw_job {
> =20
>  MODFUNC(mod_and_id, cf->can_id &=3D mod->modframe.and.can_id)
>  MODFUNC(mod_and_len, cf->len &=3D mod->modframe.and.len)
> +MODFUNC(mod_and_flags, cf->flags &=3D mod->modframe.and.flags)
>  MODFUNC(mod_and_data, *(u64 *)cf->data &=3D *(u64 *)mod->modframe.and.=
data)
>  MODFUNC(mod_or_id, cf->can_id |=3D mod->modframe.or.can_id)
>  MODFUNC(mod_or_len, cf->len |=3D mod->modframe.or.len)
> +MODFUNC(mod_or_flags, cf->flags |=3D mod->modframe.or.flags)
>  MODFUNC(mod_or_data, *(u64 *)cf->data |=3D *(u64 *)mod->modframe.or.da=
ta)
>  MODFUNC(mod_xor_id, cf->can_id ^=3D mod->modframe.xor.can_id)
>  MODFUNC(mod_xor_len, cf->len ^=3D mod->modframe.xor.len)
> +MODFUNC(mod_xor_flags, cf->flags ^=3D mod->modframe.xor.flags)
>  MODFUNC(mod_xor_data, *(u64 *)cf->data ^=3D *(u64 *)mod->modframe.xor.=
data)
>  MODFUNC(mod_set_id, cf->can_id =3D mod->modframe.set.can_id)
>  MODFUNC(mod_set_len, cf->len =3D mod->modframe.set.len)
> +MODFUNC(mod_set_flags, cf->flags =3D mod->modframe.set.flags)
>  MODFUNC(mod_set_data, *(u64 *)cf->data =3D *(u64 *)mod->modframe.set.d=
ata)
> =20
> +static void mod_and_fddata(struct canfd_frame *cf, struct cf_mod *mod)=

> +{
> +	int i;
> +
> +	for(i =3D 0; i < CANFD_MAX_DLEN; i +=3D 8)
> +		*(u64 *)(cf->data + i) &=3D *(u64 *)(mod->modframe.and.data + i);
> +
> +	return;
> +}
> +
> +static void mod_or_fddata(struct canfd_frame *cf, struct cf_mod *mod)
> +{
> +	int i;
> +
> +	for(i =3D 0; i < CANFD_MAX_DLEN; i +=3D 8)
> +		*(u64 *)(cf->data + i) |=3D *(u64 *)(mod->modframe.or.data + i);
> +
> +	return;
> +}
> +
> +static void mod_xor_fddata(struct canfd_frame *cf, struct cf_mod *mod)=

> +{
> +	int i;
> +
> +	for(i =3D 0; i < CANFD_MAX_DLEN; i +=3D 8)
> +		*(u64 *)(cf->data + i) ^=3D *(u64 *)(mod->modframe.xor.data + i);
> +
> +	return;
> +}
> +
> +static void mod_set_fddata(struct canfd_frame *cf, struct cf_mod *mod)=

> +{
> +	memcpy(cf->data, mod->modframe.set.data, CANFD_MAX_DLEN);
> +}
> +
>  static void canframecpy(struct canfd_frame *dst, struct can_frame *src=
)
>  {
>  	/*
> @@ -181,10 +232,27 @@ static void canframecpy(struct canfd_frame *dst, =
struct can_frame *src)
>  	*(u64 *)dst->data =3D *(u64 *)src->data;
>  }
> =20
> -static int cgw_chk_csum_parms(s8 fr, s8 to, s8 re)
> +static void canfdframecpy(struct canfd_frame *dst, struct canfd_frame =
*src)
> +{
> +	/*
> +	 * Copy the struct members separately to ensure that no uninitialized=

> +	 * data are copied in the 2 bytes hole of the struct. This is needed
> +	 * to make easy compares of the data in the struct cf_mod.
> +	 */
> +
> +	dst->can_id =3D src->can_id;
> +	dst->flags =3D src->flags;
> +	dst->len =3D src->len;
> +	memcpy(dst->data, src->data, CANFD_MAX_DLEN);
> +}
> +
> +static int cgw_chk_csum_parms(s8 fr, s8 to, s8 re, struct rtcanmsg *r)=

>  {
>  	s8 dlen =3D CAN_MAX_DLEN;
> =20
> +	if (r->flags & CGW_FLAGS_CAN_FD)
> +		dlen =3D CANFD_MAX_DLEN;
> +
>  	/*
>  	 * absolute dlc values 0 .. 7 =3D> 0 .. 7, e.g. data [0]
>  	 * relative to received dlc -1 .. -8 :
> @@ -355,6 +423,15 @@ static void can_can_gw_rcv(struct sk_buff *skb, vo=
id *data)
>  	struct sk_buff *nskb;
>  	int modidx =3D 0;
> =20
> +	/* process strictly Classic CAN or CAN FD frames */
> +	if (gwj->flags & CGW_FLAGS_CAN_FD) {
> +		if (skb->len !=3D CANFD_MTU)
> +			return;
> +	} else {
> +		if (skb->len !=3D CAN_MTU)
> +			return;
> +	}
> +
>  	/*
>  	 * Do not handle CAN frames routed more than 'max_hops' times.
>  	 * In general we should never catch this delimiter which is intended
> @@ -425,23 +502,22 @@ static void can_can_gw_rcv(struct sk_buff *skb, v=
oid *data)
>  		int max_len =3D nskb->len - offsetof(struct canfd_frame, data);

I know, this is original code...but max_len can either be 8 (for CAN
frames) or 64 (for CAN-FD frames)? Because we always have full can_frame
or canfd_frame in the skb, right?  I assume a lot more will break if the
len neither 8 nor 64.

> =20
>  		/* dlc may have changed, make sure it fits to the CAN frame */
> -		if (cf->len > max_len)
> -			goto out_delete;
> +		if (cf->len > max_len) {
> +			/* delete frame due to misconfiguration */
> +			gwj->deleted_frames++;
> +			kfree_skb(nskb);
> +			return;
> +		}
> =20
> -		/* check for checksum updates in classic CAN length only */
> -		if (gwj->mod.csumfunc.crc8) {
> -			if (cf->len > 8)
> -				goto out_delete;
> +		/* ensure a valid CAN (FD) frame data length */
> +		cf->len =3D validate_len[cf->len];

This looks strange to me, but I cannot say if I don't userstand this or
if there really is a potential problem:
- first you calculate max_len
- the cf->len > max_len is discarded
- but then cf->len is "rounded up" via validate_len[].

What's the purpose of the last step?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--34iUuO2WvReYf4SIEUeZwQs82qNpPwCkZ--

--ib9xUgT2AmhpgM8ujZjI23KND1pu5SyvA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl04Xs4ACgkQWsYho5Hk
nSCorwf9FdeKR48TglJ8WZTdQnKToapx7Y0xp2O/a4IOPh3aqBnqG9Y2NLv8502L
CgoHQ9QQdzjKNg4qY0XSYxhtCywKlnFigplRCBOszVcmBejGD5U27kDNvRHHcU9J
Hs6pd/wooN1kXK9j0y4ROJwGcPAw0IcV8kKWmSLdPU+tMLgb14D8/u458JafQzvD
nRO5IVehoynyxWEQbJbuvk1sOQMx6PRXIPFIy6CTobgwqzTh9fPpJBlw4O8IMbFj
1dFdjxBiuqqsz2g4VR5b/RZTCfEJO6B/8kdOJWXJDUl3Gk5QV4DNDwNv9NKDwB9z
DLKov0pu3JugIyjJT7WDNNPW1lvcRQ==
=az8s
-----END PGP SIGNATURE-----

--ib9xUgT2AmhpgM8ujZjI23KND1pu5SyvA--
