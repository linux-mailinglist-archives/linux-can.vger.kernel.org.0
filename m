Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CC429ACC2
	for <lists+linux-can@lfdr.de>; Tue, 27 Oct 2020 14:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbgJ0NGR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Oct 2020 09:06:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42835 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441366AbgJ0NGR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Oct 2020 09:06:17 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kXOg3-0001ts-9P; Tue, 27 Oct 2020 14:06:15 +0100
Received: from [IPv6:2a03:f580:87bc:d400:73e2:4ffe:a133:aaa3] (unknown [IPv6:2a03:f580:87bc:d400:73e2:4ffe:a133:aaa3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E4FAC583315;
        Tue, 27 Oct 2020 13:06:13 +0000 (UTC)
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201023203017.3485-1-socketcan@hartkopp.net>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
Message-ID: <d5ad34b5-7232-eadb-94a0-c58c111fa443@pengutronix.de>
Date:   Tue, 27 Oct 2020 14:06:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201023203017.3485-1-socketcan@hartkopp.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lkKVJIkWCKBCzU8QvXd7o3WWyE9qTHgeN"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lkKVJIkWCKBCzU8QvXd7o3WWyE9qTHgeN
Content-Type: multipart/mixed; boundary="kkyqJ7wGxSrkWmRU6QleXHMxXD7iKE5VI";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, mailhol.vincent@wanadoo.fr
Cc: linux-can@vger.kernel.org
Message-ID: <d5ad34b5-7232-eadb-94a0-c58c111fa443@pengutronix.de>
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
References: <20201023203017.3485-1-socketcan@hartkopp.net>
In-Reply-To: <20201023203017.3485-1-socketcan@hartkopp.net>

--kkyqJ7wGxSrkWmRU6QleXHMxXD7iKE5VI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/23/20 10:30 PM, Oliver Hartkopp wrote:
> ISO 11898-1 Chapter 8.4.2.3 defines a 4 bit data length code (DLC) tabl=
e which
> maps the DLC to the payload length of the CAN frame in bytes:
>=20
>     DLC      ->  payload length
>     0 .. 8   ->  0 .. 8
>     9 .. 15  ->  8
>=20
> Although the DLC values 8 .. 15 in Classical CAN always result in a pay=
load
> length of 8 bytes these DLC values are transparently transmitted on the=
 CAN
> bus. As the struct can_frame only provides a 'len' element (formerly 'c=
an_dlc')
> which contains the plain payload length ( 0 .. 8 ) of the CAN frame, th=
e raw
> DLC is not visible to the application programmer, e.g. for testing use-=
cases.
>=20
> To access the raw DLC values 9 .. 15 the len8_dlc element is introduced=
, which
> is only valid when the payload length 'len' is 8 and the DLC is greater=
 than 8.
>=20
> The len8_dlc element is filled by the CAN interface driver and used for=
 CAN
> frame creation by the CAN driver when the CAN_CTRLMODE_CC_LEN8_DLC flag=
 is

CC stands for Classic CAN? Is this the "official" name?

For example there was a press release to harmonize the CAN transceiver na=
meing
recently:

https://can-cia.org/news/press-releases/view/harmonized-transceiver-namin=
g/2020/7/16/

> supported by the driver and enabled via netlink configuration interface=
=2E
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/uapi/linux/can.h         | 36 ++++++++++++++++++++------------=

>  include/uapi/linux/can/netlink.h |  1 +
>  2 files changed, 24 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index 6a6d2c7655ff..bcf28ae7f14c 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -82,34 +82,44 @@ typedef __u32 canid_t;
>   */
>  typedef __u32 can_err_mask_t;
> =20
>  /* CAN payload length and DLC definitions according to ISO 11898-1 */
>  #define CAN_MAX_DLC 8
> +#define CAN_MAX_RAW_DLC 15
>  #define CAN_MAX_DLEN 8
> =20
>  /* CAN FD payload length and DLC definitions according to ISO 11898-7 =
*/
>  #define CANFD_MAX_DLC 15
>  #define CANFD_MAX_DLEN 64
> =20
>  /**
>   * struct can_frame - basic CAN frame structure
> - * @can_id:  CAN ID of the frame and CAN_*_FLAG flags, see canid_t def=
inition
> - * @can_dlc: frame payload length in byte (0 .. 8) aka data length cod=
e
> - *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a=
 1:1
> - *           mapping of the 'data length code' to the real payload len=
gth
> - * @__pad:   padding
> - * @__res0:  reserved / padding
> - * @__res1:  reserved / padding
> - * @data:    CAN frame payload (up to 8 byte)
> + * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t de=
finition
> + * @len:      CAN frame payload length in byte (0 .. 8)
> + * @can_dlc:  deprecated name for CAN frame payload length in byte (0 =
=2E. 8)
> + * @__pad:    padding
> + * @__res0:   reserved / padding
> + * @len8_dlc: optional DLC value (9 .. 15) at 8 byte payload length=20
> + *            len8_dlc contains values from 9 .. 15 when the payload l=
ength is
> + *            8 bytes but the DLC value (see ISO 11898-1) is greater t=
hen 8.
> + *            CAN_CTRLMODE_CC_LEN8_DLC flag has to be enabled in CAN d=
river.
> + * @data:     CAN frame payload (up to 8 byte)
>   */
>  struct can_frame {
>  	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> -	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) =
*/
> -	__u8    __pad;   /* padding */
> -	__u8    __res0;  /* reserved / padding */
> -	__u8    __res1;  /* reserved / padding */
> -	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
> +	union {
> +		/* CAN frame payload length in byte (0 .. CAN_MAX_DLEN)
> +		 * was previously named can_dlc so we need to carry that
> +		 * name for legacy support
> +		 */
> +		__u8 len;
> +		__u8 can_dlc; /* deprecated */
> +	};

There was an old compiler version, which struggled with C99 initialized u=
nions
within structs.....So this change would break existing source, but I thin=
k that
old compilers are long gone (for good).

> +	__u8 __pad; /* padding */
> +	__u8 __res0; /* reserved / padding */
> +	__u8 len8_dlc; /* optional DLC for 8 byte payload length (9 .. 15) */=

> +	__u8 data[CAN_MAX_DLEN] __attribute__((aligned(8)));
>  };
> =20
>  /*
>   * defined bits for canfd_frame.flags
>   *
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/=
netlink.h
> index 6f598b73839e..f730d443b918 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -98,10 +98,11 @@ struct can_ctrlmode {
>  #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
>  #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
>  #define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
>  #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
>  #define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
> +#define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
> =20
>  /*
>   * CAN device statistics
>   */
>  struct can_device_stats {
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--kkyqJ7wGxSrkWmRU6QleXHMxXD7iKE5VI--

--lkKVJIkWCKBCzU8QvXd7o3WWyE9qTHgeN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+YG0EACgkQqclaivrt
76muVwgAnX7ueSkE45FDaNDjLMtidVIQ2ZG1YB6uZ1EfwDqKaHMcfvBw84zjK7xT
kGdgIKCILfI7fHZDxox1Gd1VvLl5It41CvuNBCuecl/ipSrPeDToM7YPWUVY9tHV
p3I35O/0Gl7ApPpa7sY84WZ8QnpS7QH57oXpk4ABeYwZ99mDbAyXoNfvx2XQHDwv
NWwZ/MSM9H2lN3A8y9snw1aFf2Aj6/w7k/S2G/zai3XHoEi0plS0UZhOGbvB7mHL
z92DS7LSF7iP57weQeY/yW8A1wwzvq/4Xs2n2kZWLIbQN1PGfEaLToYaT/ntHZEl
1T1Cgmn80zC/47hciEp61AfiKiJ/SA==
=o+/j
-----END PGP SIGNATURE-----

--lkKVJIkWCKBCzU8QvXd7o3WWyE9qTHgeN--
