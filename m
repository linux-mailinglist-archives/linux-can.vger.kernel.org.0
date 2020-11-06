Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE232A9B36
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKFRvX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKFRvX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:51:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F941C0613CF
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 09:51:23 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kb5tR-0007SH-8N; Fri, 06 Nov 2020 18:51:21 +0100
Received: from [IPv6:2a03:f580:87bc:d400:33f0:799f:c05f:fe06] (unknown [IPv6:2a03:f580:87bc:d400:33f0:799f:c05f:fe06])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E006C58C6B6;
        Fri,  6 Nov 2020 17:51:19 +0000 (UTC)
To:     Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        linux-can@vger.kernel.org
Cc:     wg@grandegger.com
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-10-uttenthaler@ems-wuensche.com>
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
Subject: Re: [PATCH 09/17] can: ems_usb: For CPC-USB/FD added clock
 definitions, bittiming constants, set_bittiming functions, bittiming init
 function and add all that to probe function
Message-ID: <e10bf6e4-559a-176b-904c-a7a5f5933f2b@pengutronix.de>
Date:   Fri, 6 Nov 2020 18:51:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106170206.32162-10-uttenthaler@ems-wuensche.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VKEGHnWqbXEwIUjGBbc0lk66qUQptet5J"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VKEGHnWqbXEwIUjGBbc0lk66qUQptet5J
Content-Type: multipart/mixed; boundary="3CDjrjSagQxYyiPNMMIT4icfKrvxTDYxU";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
 linux-can@vger.kernel.org
Cc: wg@grandegger.com
Message-ID: <e10bf6e4-559a-176b-904c-a7a5f5933f2b@pengutronix.de>
Subject: Re: [PATCH 09/17] can: ems_usb: For CPC-USB/FD added clock
 definitions, bittiming constants, set_bittiming functions, bittiming init
 function and add all that to probe function
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
 <20201106170206.32162-10-uttenthaler@ems-wuensche.com>
In-Reply-To: <20201106170206.32162-10-uttenthaler@ems-wuensche.com>

--3CDjrjSagQxYyiPNMMIT4icfKrvxTDYxU
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/6/20 6:01 PM, Gerhard Uttenthaler wrote:
> Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
> ---
>  drivers/net/can/usb/ems_usb.c | 141 +++++++++++++++++++++++++++++++++-=

>  1 file changed, 139 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_us=
b.c
> index 6a9ea6a4e687..d6b52b265536 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -108,6 +108,17 @@ MODULE_LICENSE("GPL v2");
>   */
>  #define EMS_USB_ARM7_CLOCK 8000000
> =20
> +/* CPC-USB/FD supports the following CAN clocks
> + */
> +#define EMS_USB_FD_8MHZ   8000000
                          ^^^ one space only
> +#define EMS_USB_FD_16MHZ 16000000
> +#define EMS_USB_FD_20MHZ 20000000
> +#define EMS_USB_FD_24MHZ 24000000
> +#define EMS_USB_FD_32MHZ 32000000
> +#define EMS_USB_FD_40MHZ 40000000
> +#define EMS_USB_FD_80MHZ 80000000

are these used?

> +#define EMS_USB_FD_CLOCK EMS_USB_FD_40MHZ
> +
>  #define CPC_TX_QUEUE_TRIGGER_LOW	25
>  #define CPC_TX_QUEUE_TRIGGER_HIGH	35
> =20
> @@ -970,6 +981,30 @@ static const struct can_bittiming_const ems_usb_bi=
ttiming_const_arm7 =3D {
>  	.brp_inc =3D 1,
>  };
> =20
> +static const struct can_bittiming_const ems_usb_bittiming_const_generi=
c =3D {
> +	.name =3D "ems_usb_fd",
> +	.tseg1_min =3D 1,
> +	.tseg1_max =3D 256,
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D 128,
> +	.sjw_max =3D 128,
> +	.brp_min =3D 1,
> +	.brp_max =3D 512,
> +	.brp_inc =3D 1,
> +};
> +
> +static const struct can_bittiming_const ems_usb_bittiming_const_generi=
c_data =3D {
> +	.name =3D "ems_usb_fd",
> +	.tseg1_min =3D 1,
> +	.tseg1_max =3D 16,
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D 16,
> +	.sjw_max =3D 16,
> +	.brp_min =3D 1,
> +	.brp_max =3D 32,
> +	.brp_inc =3D 1,
> +};
> +
>  static int ems_usb_set_mode(struct net_device *netdev, enum can_mode m=
ode)
>  {
>  	struct ems_usb *dev =3D netdev_priv(netdev);
> @@ -1016,6 +1051,76 @@ static int ems_usb_set_bittiming_arm7(struct net=
_device *netdev)
>  	return ems_usb_command_msg(dev, &dev->active_params);
>  }
> =20
> +static int ems_usb_set_bittiming_generic(struct net_device *netdev)
> +{
> +	struct ems_usb *dev =3D netdev_priv(netdev);
> +	struct can_bittiming *bt =3D &dev->can.bittiming;
> +	struct cpc_generic_can_params *gcp =3D
> +		&dev->active_params.msg.can_params.cc_params.generic;
> +	int err;
> +
> +	gcp->config =3D 0;
> +	gcp->can_clk =3D dev->can.clock.freq;
> +
> +	gcp->n.tseg1 =3D bt->prop_seg + bt->phase_seg1;
> +	gcp->n.tseg2 =3D bt->phase_seg2;
> +	gcp->n.brp =3D bt->brp;
> +	gcp->n.sjw =3D bt->sjw;
> +
> +	err =3D ems_usb_clear_cmd_queue(dev);
> +	if (err)
> +		return err;
> +
> +	netdev_info(netdev, "Set nominal bit timing for CPC-USB/FD with confi=
g %X\n",
> +		    gcp->config);
> +	netdev_info(netdev, "CAN Clock: %uMHz, Tseg1: %u, Tseg2: %u, BRP: %u,=
 SJW: %u\n",
> +		    gcp->can_clk / 1000000,
> +		    gcp->n.tseg1,
> +		    gcp->n.tseg2,
> +		    gcp->n.brp,
> +		    gcp->n.sjw);

I suggest to have a more quit driver, make this _dbg() instead.

> +
> +	return ems_usb_command_msg(dev, &dev->active_params);
> +}
> +
> +static int ems_usb_set_bittiming_generic_data(struct net_device *netde=
v)
> +{
> +	struct ems_usb *dev =3D netdev_priv(netdev);
> +	struct can_bittiming *bt =3D &dev->can.data_bittiming;
> +	struct cpc_generic_can_params *gcp =3D
> +		&dev->active_params.msg.can_params.cc_params.generic;
> +	int err;
> +
> +	if (dev->can.ctrlmode & CAN_CTRLMODE_FD) {
> +		gcp->config |=3D CPC_GENERICCONF_FD;
> +		if (dev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
> +			gcp->config |=3D CPC_GENERICCONF_FD_BOSCH;
> +	} else {
> +		// If CAN FD is not requested we can return here

no C++ comments

Better make it:

if (!(dev->can.ctrlmode & CAN_CTRLMODE_FD))
	return 0;

> +		return 0;
> +	}
> +
> +	gcp->d.tseg1 =3D bt->prop_seg + bt->phase_seg1;
> +	gcp->d.tseg2 =3D bt->phase_seg2;
> +	gcp->d.brp =3D bt->brp;
> +	gcp->d.sjw =3D bt->sjw;
> +
> +	err =3D ems_usb_clear_cmd_queue(dev);
> +	if (err)
> +		return err;
> +
> +	netdev_info(netdev, "Set data bit timing for CPC-USB/FD with config %=
X\n",
> +		    gcp->config);
> +	netdev_info(netdev, "CAN Clock: %uMHz, Tseg1: %u, Tseg2: %u, BRP: %u,=
 SJW: %u\n",
> +		    gcp->can_clk / 1000000,
> +		    gcp->d.tseg1,
> +		    gcp->d.tseg2,
> +		    gcp->d.brp,
> +		    gcp->d.sjw);

I suggest to have a more quit driver, make this _dbg() instead.

> +
> +	return ems_usb_command_msg(dev, &dev->active_params);
> +}
> +
>  static void init_params_sja1000(struct ems_cpc_msg *msg)
>  {
>  	struct cpc_sja1000_params *sja1000 =3D
> @@ -1024,6 +1129,8 @@ static void init_params_sja1000(struct ems_cpc_ms=
g *msg)
>  	msg->type =3D CPC_CMD_TYPE_CAN_PARAMS;
>  	msg->length =3D sizeof(struct cpc_can_params);
>  	msg->msgid =3D 0;
> +	msg->ts_sec =3D 0;
> +	msg->ts_nsec =3D 0;
> =20
>  	msg->msg.can_params.cc_type =3D CPC_CC_TYPE_SJA1000;
> =20
> @@ -1046,6 +1153,24 @@ static void init_params_sja1000(struct ems_cpc_m=
sg *msg)
>  	sja1000->mode =3D SJA1000_MOD_RM;
>  }
> =20
> +static void init_params_generic(struct ems_cpc_msg *msg)
> +{
> +	struct cpc_generic_can_params *gcp =3D
> +		&msg->msg.can_params.cc_params.generic;
> +
> +	msg->type =3D CPC_CMD_TYPE_CAN_PARAMS;
> +	msg->length =3D sizeof(struct cpc_can_params);
> +	msg->msgid =3D 0;
> +	msg->ts_sec =3D 0;
> +	msg->ts_nsec =3D 0;
> +
> +	memset((u8 *)gcp, 0, sizeof(struct cpc_generic_can_params));
> +	msg->msg.can_params.cc_type =3D CPC_CC_TYPE_GENERIC;
> +
> +	gcp->config =3D CPC_GENERICCONF_RESET_MODE;
> +	gcp->can_clk =3D EMS_USB_FD_CLOCK;
> +}
> +
>  /* probe function for new CPC-USB devices
>   */
>  static int ems_usb_probe(struct usb_interface *intf,
> @@ -1076,14 +1201,26 @@ static int ems_usb_probe(struct usb_interface *=
intf,
>  	dev->can.bittiming_const =3D &ems_usb_bittiming_const_arm7;
>  	dev->can.do_set_bittiming =3D ems_usb_set_bittiming_arm7;
>  	dev->can.do_set_mode =3D ems_usb_set_mode;
> -	dev->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE=
_LISTENONLY;
> +	dev->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
> +				      CAN_CTRLMODE_LISTENONLY;

unrelated

>  	init_params_sja1000(&dev->active_params);
>  	dev->ems_usb_write_mode =3D ems_usb_write_mode_arm7;
>  	dev->bulk_rd_buf_size =3D 64;
>  	break;
> =20
>  	case USB_CPCUSB_FD_PRODUCT_ID:
> -	// Placeholder for next patchess
> +		dev->can.clock.freq =3D EMS_USB_FD_CLOCK;
> +		dev->can.bittiming_const =3D &ems_usb_bittiming_const_generic;
> +		dev->can.data_bittiming_const =3D &ems_usb_bittiming_const_generic_d=
ata;
> +		dev->can.do_set_bittiming =3D ems_usb_set_bittiming_generic;
> +		dev->can.do_set_data_bittiming =3D ems_usb_set_bittiming_generic_dat=
a;
> +		dev->can.ctrlmode_supported =3D CAN_CTRLMODE_LISTENONLY |
> +				CAN_CTRLMODE_ONE_SHOT |
> +				CAN_CTRLMODE_BERR_REPORTING |
> +				CAN_CTRLMODE_FD |
> +				CAN_CTRLMODE_FD_NON_ISO;
> +		init_params_generic(&dev->active_params);
> +		dev->bulk_rd_buf_size =3D 512;
>  	break;
> =20
>  	default:
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--3CDjrjSagQxYyiPNMMIT4icfKrvxTDYxU--

--VKEGHnWqbXEwIUjGBbc0lk66qUQptet5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl+ljRMACgkQqclaivrt
76l8vQf8Dpgj1jKYkVfNzapWlrYtOWEwDjjei8T5j2ynimkgu+JGUd3jRaWjFOtm
vRuUZiviQFezcpJxwgrhIXhqHpe8/SHFyG+dz49QK0OWy89gaDQ4ZbROMctvkAyi
+KGNrA4cC+RAzh0n0TSHWkOyaAsvBpALKPmZOy2io0ZGOiMEiaHvudGpyy6SVMeB
S0Za+8brFFnMv2ls/7NuE2mX+ldmtuWHuF0g6Ai6ujZ1ygIyChRwcZkCynr0V87c
mNQwqmTuNiRZXQq+7zc53AyNs9yduqlYgc8f34MT9BmQ3QQo1r5H3OZQG+r72iZa
BJha984aIngXc7Fhgdt0vOJjAEfVLw==
=d733
-----END PGP SIGNATURE-----

--VKEGHnWqbXEwIUjGBbc0lk66qUQptet5J--
