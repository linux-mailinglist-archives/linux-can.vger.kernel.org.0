Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B3B2A9AD4
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgKFRcs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFRcp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:32:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07123C0613CF
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 09:32:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kb5bO-0005au-P1; Fri, 06 Nov 2020 18:32:42 +0100
Received: from [IPv6:2a03:f580:87bc:d400:33f0:799f:c05f:fe06] (unknown [IPv6:2a03:f580:87bc:d400:33f0:799f:c05f:fe06])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CAEF358C688;
        Fri,  6 Nov 2020 17:32:41 +0000 (UTC)
Subject: Re: [PATCH 08/17] can: ems_usb: Modified ems_usb_read_bulk_callback
 to be able to handle also CPC-USB/FD
To:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        linux-can@vger.kernel.org
Cc:     wg@grandegger.com
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-9-uttenthaler@ems-wuensche.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 mQINBFFVq30BEACtnSvtXHoeHJxG6nRULcvlkW6RuNwHKmrqoksispp43X8+nwqIFYgb8UaX
 zu8T6kZP2wEIpM9RjEL3jdBjZNCsjSS6x1qzpc2+2ivjdiJsqeaagIgvy2JWy7vUa4/PyGfx
 QyUeXOxdj59DvLwAx8I6hOgeHx2X/ntKAMUxwawYfPZpP3gwTNKc27dJWSomOLgp+gbmOmgc
 6U5KwhAxPTEb3CsT5RicsC+uQQFumdl5I6XS+pbeXZndXwnj5t84M+HEj7RN6bUfV2WZO/AB
 Xt5+qFkC/AVUcj/dcHvZwQJlGeZxoi4veCoOT2MYqfR0ax1MmN+LVRvKm29oSyD4Ts/97cbs
 XsZDRxnEG3z/7Winiv0ZanclA7v7CQwrzsbpCv+oj+zokGuKasofzKdpywkjAfSE1zTyF+8K
 nxBAmzwEqeQ3iKqBc3AcCseqSPX53mPqmwvNVS2GqBpnOfY7Mxr1AEmxdEcRYbhG6Xdn+ACq
 Dq0Db3A++3PhMSaOu125uIAIwMXRJIzCXYSqXo8NIeo9tobk0C/9w3fUfMTrBDtSviLHqlp8
 eQEP8+TDSmRP/CwmFHv36jd+XGmBHzW5I7qw0OORRwNFYBeEuiOIgxAfjjbLGHh9SRwEqXAL
 kw+WVTwh0MN1k7I9/CDVlGvc3yIKS0sA+wudYiselXzgLuP5cQARAQABtCZNYXJjIEtsZWlu
 ZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPokCVAQTAQoAPgIbAwIeAQIXgAULCQgHAwUV
 CgkICwUWAgMBABYhBMFAC6CzmJ5vvH1bXCte4hHFiupUBQJfEWX4BQkQo2czAAoJECte4hHF
 iupUvfMP/iNtiysSr5yU4tbMBzRkGov1/FjurfH1kPweLVHDwiQJOGBz9HgM5+n8boduRv36
 0lU32g3PehN0UHZdHWhygUd6J09YUi2mJo1l2Fz1fQ8elUGUOXpT/xoxNQjslZjJGItCjza8
 +D1DO+0cNFgElcNPa7DFBnglatOCZRiMjo4Wx0i8njEVRU+4ySRU7rCI36KPts+uVmZAMD7V
 3qiR1buYklJaPCJsnXURXYsilBIE9mZRmQjTDVqjLWAit++flqUVmDjaD/pj2AQe2Jcmd2gm
 sYW5P1moz7ACA1GzMjLDmeFtpJOIB7lnDX0F/vvsG3V713/701aOzrXqBcEZ0E4aWeZJzaXw
 n1zVIrl/F3RKrWDhMKTkjYy7HA8hQ9SJApFXsgP334Vo0ea82H3dOU755P89+Eoj0y44MbQX
 7xUy4UTRAFydPl4pJskveHfg4dO6Yf0PGIvVWOY1K04T1C5dpnHAEMvVNBrfTA8qcahRN82V
 /iIGB+KSC2xR79q1kv1oYn0GOnWkvZmMhqGLhxIqHYitwH4Jn5uRfanKYWBk12LicsjRiTyW
 Z9cJf2RgAtQgvMPvmaOL8vB3U4ava48qsRdgxhXMagU618EszVdYRNxGLCqsKVYIDySTrVzu
 ZGs2ibcRhN4TiSZjztWBAe1MaaGk05Ce4h5IdDLbOOxhuQENBF8SDLABCADohJLQ5yffd8Sq
 8Lo9ymzgaLcWboyZ46pY4CCCcAFDRh++QNOJ8l4mEJMNdEa/yrW4lDQDhBWV75VdBuapYoal
 LFrSzDzrqlHGG4Rt4/XOqMo6eSeSLipYBu4Xhg59S9wZOWbHVT/6vZNmiTa3d40+gBg68dQ8
 iqWSU5NhBJCJeLYdG6xxeUEtsq/25N1erxmhs/9TD0sIeX36rFgWldMwKmZPe8pgZEv39Sdd
 B+ykOlRuHag+ySJxwovfdVoWT0o0LrGlHzAYo6/ZSi/Iraa9R/7A1isWOBhw087BMNkRYx36
 B77E4KbyBPx9h3wVyD/R6T0Q3ZNPu6SQLnsWojMzABEBAAGJAjwEGAEKACYWIQTBQAugs5ie
 b7x9W1wrXuIRxYrqVAUCXxIMsAIbDAUJAucGAAAKCRArXuIRxYrqVOu0D/48xSLyVZ5NN2Bb
 yqo3zxdv/PMGJSzM3JqSv7hnMZPQGy9XJaTc5Iz/hyXaNRwpH5X0UNKqhQhlztChuAKZ7iu+
 2VKzq4JJe9qmydRUwylluc4HmGwlIrDNvE0N66pRvC3h8tOVIsippAQlt5ciH74bJYXr0PYw
 Aksw1jugRxMbNRzgGECg4O6EBNaHwDzsVPX1tDj0d9t/7ClzJUy20gg8r9Wm/I/0rcNkQOpV
 RJLDtSbGSusKxor2XYmVtHGauag4YO6Vdq+2RjArB3oNLgSOGlYVpeqlut+YYHjWpaX/cTf8
 /BHtIQuSAEu/WnycpM3Z9aaLocYhbp5lQKL6/bcWQ3udd0RfFR/Gv7eR7rn3evfqNTtQdo4/
 YNmd7P8TS7ALQV/5bNRe+ROLquoAZvhaaa6SOvArcmFccnPeyluX8+o9K3BCdXPwONhsrxGO
 wrPI+7XKMlwWI3O076NqNshh6mm8NIC0mDUr7zBUITa67P3Q2VoPoiPkCL9RtsXdQx5BI9iI
 h/6QlzDxcBdw2TVWyGkVTCdeCBpuRndOMVmfjSWdCXXJCLXO6sYeculJyPkuNvumxgwUiK/H
 AqqdUfy1HqtzP2FVhG5Ce0TeMJepagR2CHPXNg88Xw3PDjzdo+zNpqPHOZVKpLUkCvRv1p1q
 m1qwQVWtAwMML/cuPga78rkBDQRfEXGWAQgAt0Cq8SRiLhWyTqkf16Zv/GLkUgN95RO5ntYM
 fnc2Tr3UlRq2Cqt+TAvB928lN3WHBZx6DkuxRM/Y/iSyMuhzL5FfhsICuyiBs5f3QG70eZx+
 Bdj4I7LpnIAzmBdNWxMHpt0m7UnkNVofA0yH6rcpCsPrdPRJNOLFI6ZqXDQk9VF+AB4HVAJY
 BDU3NAHoyVGdMlcxev0+gEXfBQswEcysAyvzcPVTAqmrDsupnIB2f0SDMROQCLO6F+/cLG4L
 Stbz+S6YFjESyXblhLckTiPURvDLTywyTOxJ7Mafz6ZCene9uEOqyd/h81nZOvRd1HrXjiTE
 1CBw+Dbvbch1ZwGOTQARAQABiQNyBBgBCgAmFiEEwUALoLOYnm+8fVtcK17iEcWK6lQFAl8R
 cZYCGwIFCQLnoRoBQAkQK17iEcWK6lTAdCAEGQEKAB0WIQQreQhYm33JNgw/d6GpyVqK+u3v
 qQUCXxFxlgAKCRCpyVqK+u3vqatQCAC3QIk2Y0g/07xNLJwhWcD7JhIqfe7Qc5Vz9kf8ZpWr
 +6w4xwRfjUSmrXz3s6e/vrQsfdxjVMDFOkyG8c6DWJo0TVm6Ucrf9G06fsjjE/6cbE/gpBkk
 /hOVz/a7UIELT+HUf0zxhhu+C9hTSl8Nb0bwtm6JuoY5AW0LP2KoQ6LHXF9KNeiJZrSzG6WE
 h7nf3KRFS8cPKe+trbujXZRb36iIYUfXKiUqv5xamhohy1hw+7Sy8nLmw8rZPa40bDxX0/Gi
 98eVyT4/vi+nUy1gF1jXgNBSkbTpbVwNuldBsGJsMEa8lXnYuLzn9frLdtufUjjCymdcV/iT
 sFKziU9AX7TLZ5AP/i1QMP9OlShRqERH34ufA8zTukNSBPIBfmSGUe6G2KEWjzzNPPgcPSZx
 Do4jfQ/m/CiiibM6YCa51Io72oq43vMeBwG9/vLdyev47bhSfMLTpxdlDJ7oXU9e8J61iAF7
 vBwerBZL94I3QuPLAHptgG8zPGVzNKoAzxjlaxI1MfqAD9XUM80MYBVjunIQlkU/AubdvmMY
 X7hY1oMkTkC5hZNHLgIsDvWUG0g3sACfqF6gtMHY2lhQ0RxgxAEx+ULrk/svF6XGDe6iveyc
 z5Mg5SUggw3rMotqgjMHHRtB3nct6XqgPXVDGYR7nAkXitG+nyG5zWhbhRDglVZ0mLlW9hij
 z3Emwa94FaDhN2+1VqLFNZXhLwrNC5mlA6LUjCwOL+zb9a07HyjekLyVAdA6bZJ5BkSXJ1CO
 5YeYolFjr4YU7GXcSVfUR6fpxrb8N+yH+kJhY3LmS9vb2IXxneE/ESkXM6a2YAZWfW8sgwTm
 0yCEJ41rW/p3UpTV9wwE2VbGD1XjzVKl8SuAUfjjcGGys3yk5XQ5cccWTCwsVdo2uAcY1MVM
 HhN6YJjnMqbFoHQq0H+2YenTlTBn2Wsp8TIytE1GL6EbaPWbMh3VLRcihlMj28OUWGSERxat
 xlygDG5cBiY3snN3xJyBroh5xk/sHRgOdHpmujnFyu77y4RTZ2W8
Message-ID: <2ba9eb58-6275-39cd-73e7-07f4db485035@pengutronix.de>
Date:   Fri, 6 Nov 2020 18:32:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106170206.32162-9-uttenthaler@ems-wuensche.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="q4QaWkqvuCjYHhuFDoCu0P4DpjgJ3x99a"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q4QaWkqvuCjYHhuFDoCu0P4DpjgJ3x99a
Content-Type: multipart/mixed; boundary="MCp0PaRhb3ovyD3f77Ga9biUjnbW3UiHV";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
 linux-can@vger.kernel.org
Cc: wg@grandegger.com
Message-ID: <2ba9eb58-6275-39cd-73e7-07f4db485035@pengutronix.de>
Subject: Re: [PATCH 08/17] can: ems_usb: Modified ems_usb_read_bulk_callback
 to be able to handle also CPC-USB/FD
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-9-uttenthaler@ems-wuensche.com>
In-Reply-To: <20201106170206.32162-9-uttenthaler@ems-wuensche.com>

--MCp0PaRhb3ovyD3f77Ga9biUjnbW3UiHV
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/6/20 6:01 PM, Gerhard Uttenthaler wrote:
> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
> ---
>  drivers/net/can/usb/ems_usb.c | 83 ++++++++++++++++++-----------------=

>  1 file changed, 42 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_us=
b.c
> index c664af4499a1..6a9ea6a4e687 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -460,6 +460,7 @@ static void ems_usb_read_bulk_callback(struct urb *=
urb)
>  	struct ems_usb *dev =3D urb->context;
>  	struct net_device *netdev;
>  	int retval;
> +	u32 length, start;
> =20
>  	netdev =3D dev->netdev;
> =20
> @@ -478,50 +479,50 @@ static void ems_usb_read_bulk_callback(struct urb=
 *urb)
>  		goto resubmit_urb;
>  	}
> =20
> -	if (urb->actual_length > CPC_HEADER_SIZE) {
> +	length =3D urb->actual_length;
> +	start =3D CPC_HEADER_SIZE;
> +
> +	while (length >=3D CPC_MSG_HEADER_LEN) {
>  		struct ems_cpc_msg *msg;
>  		u8 *ibuf =3D urb->transfer_buffer;
> -		u8 msg_count, start;
> -
> -		msg_count =3D ibuf[0] & ~0x80;
> -
> -		start =3D CPC_HEADER_SIZE;
> -
> -		while (msg_count) {
> -			msg =3D (struct ems_cpc_msg *)&ibuf[start];
> -
> -			switch (msg->type) {
> -			case CPC_MSG_TYPE_CAN_STATE:
> -				/* Process CAN state changes */
> -				ems_usb_rx_err(dev, msg);
> -				break;
> -
> -			case CPC_MSG_TYPE_CAN_FRAME:
> -			case CPC_MSG_TYPE_EXT_CAN_FRAME:
> -			case CPC_MSG_TYPE_RTR_FRAME:
> -			case CPC_MSG_TYPE_EXT_RTR_FRAME:
> -				ems_usb_rx_can_msg(dev, msg);
> -				break;
> -
> -			case CPC_MSG_TYPE_CAN_FRAME_ERROR:
> -				/* Process errorframe */
> -				ems_usb_rx_err(dev, msg);
> -				break;
> -
> -			case CPC_MSG_TYPE_OVERRUN:
> -				/* Message lost while receiving */
> -				ems_usb_rx_err(dev, msg);
> -				break;
> -			}
> -
> -			start +=3D CPC_MSG_HEADER_LEN + msg->length;
> -			msg_count--;
> -
> -			if (start > urb->transfer_buffer_length) {
> -				netdev_err(netdev, "format error\n");
> -				break;
> -			}
> +		u32 read_count;
> +
> +		msg =3D (struct ems_cpc_msg *)&ibuf[start];
> +
> +		switch (msg->type) {

Is there a check, that that you don't access the buffer after its actual_=
length?

> +		case CPC_MSG_TYPE_CAN_STATE:
> +			/* Process CAN state changes */
> +			ems_usb_rx_err(dev, msg);
> +			break;
> +
> +		case CPC_MSG_TYPE_CAN_FRAME:
> +		case CPC_MSG_TYPE_EXT_CAN_FRAME:
> +		case CPC_MSG_TYPE_RTR_FRAME:
> +		case CPC_MSG_TYPE_EXT_RTR_FRAME:
> +			ems_usb_rx_can_msg(dev, msg);
> +			break;
> +
> +		case CPC_MSG_TYPE_CAN_FRAME_ERROR:
> +			/* Process errorframe */
> +			ems_usb_rx_err(dev, msg);
> +			break;
> +
> +		case CPC_MSG_TYPE_OVERRUN:
> +			/* Message lost while receiving */
> +			ems_usb_rx_err(dev, msg);
> +			break;
>  		}
> +
> +		read_count =3D CPC_MSG_HEADER_LEN + msg->length;
> +		start +=3D read_count;
> +
> +		if (start > urb->transfer_buffer_length) {
> +			netdev_err(netdev, "format error\n");
> +			break;
> +		}
> +
> +		if (read_count <=3D length)
> +			length -=3D read_count;
>  	}
> =20
>  resubmit_urb:
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--MCp0PaRhb3ovyD3f77Ga9biUjnbW3UiHV--

--q4QaWkqvuCjYHhuFDoCu0P4DpjgJ3x99a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+liLUACgkQqclaivrt
76nLowf+JSv4Q2BkmlRGgCdRyZAf3mGU8uvXm3ZkiB6h6/cyfeO0VFlwjKDJIR1p
eUORn9IvP8i0G9n0iTtYHgbYqJzdMjE71ldSSmMOsTy+0cnWMzXGRR4iBFi/HMBf
wC3YnXXVaCbDt3543xF9KLNoJnUFhuC0a78yub2G1JZMrDwJqK3HpKFmx4F/YMFw
H50dGUjzoEkFnQPHJsiEdxbFju8MLBkx1zIFd4VREmdmsBmODQ9pJyTOBxMt5+uF
siA/86TigjoYOjGvFTwkJbF/WVJRT1JBunLfisItvnDu6pXq/3F8HPzVaDURDlkW
kkJy1BO9KTVu+X/fcxFgPjmKyCzEnw==
=dYWr
-----END PGP SIGNATURE-----

--q4QaWkqvuCjYHhuFDoCu0P4DpjgJ3x99a--
