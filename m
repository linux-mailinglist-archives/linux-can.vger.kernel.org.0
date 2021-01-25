Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FCD3024DA
	for <lists+linux-can@lfdr.de>; Mon, 25 Jan 2021 13:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbhAYMVG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jan 2021 07:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbhAYMUm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jan 2021 07:20:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC28C061A2A
        for <linux-can@vger.kernel.org>; Mon, 25 Jan 2021 03:52:50 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l40QI-0005lf-Ht; Mon, 25 Jan 2021 12:52:46 +0100
Received: from [IPv6:2a03:f580:87bc:d400:41dd:30c9:182f:703e] (unknown [IPv6:2a03:f580:87bc:d400:41dd:30c9:182f:703e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AA57E5CD37F;
        Mon, 25 Jan 2021 11:43:39 +0000 (UTC)
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Abhijeet Badurkar <abhijeet.badurkar@duagon.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        linux-can <linux-can@vger.kernel.org>,
        andreas.geissler@duagon.com, stefan.schlosser@duagon.com
References: <20210122110533.2728-1-abhijeet.badurkar@duagon.com>
 <CAMZ6Rq+MPpknpxwKv0-eV8J3FbKw7AigWrzbMC1HJgEUv8f56A@mail.gmail.com>
 <0673cb4c-f6ce-027c-8028-62161ca47f9c@duagon.com>
 <CAMZ6RqLLU2BC1m_F8Dfi9_n_AoQ6CgfOgtY3xwTscdLvJN4+Ag@mail.gmail.com>
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
Subject: Re: [PATCH v6] net: can: Introduce MEN 16Z192-00 CAN controller
 driver
Message-ID: <b50ee651-880a-9093-9c79-d6f398fe4280@pengutronix.de>
Date:   Mon, 25 Jan 2021 12:43:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqLLU2BC1m_F8Dfi9_n_AoQ6CgfOgtY3xwTscdLvJN4+Ag@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="aX8XWbS3EO0ToEimKj1n317VMsn0r6HKQ"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aX8XWbS3EO0ToEimKj1n317VMsn0r6HKQ
Content-Type: multipart/mixed; boundary="K4Or60kXnr5symxGOCwXtoLdMPSN1jPHZ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
 Abhijeet Badurkar <abhijeet.badurkar@duagon.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 linux-can <linux-can@vger.kernel.org>, andreas.geissler@duagon.com,
 stefan.schlosser@duagon.com
Message-ID: <b50ee651-880a-9093-9c79-d6f398fe4280@pengutronix.de>
Subject: Re: [PATCH v6] net: can: Introduce MEN 16Z192-00 CAN controller
 driver
References: <20210122110533.2728-1-abhijeet.badurkar@duagon.com>
 <CAMZ6Rq+MPpknpxwKv0-eV8J3FbKw7AigWrzbMC1HJgEUv8f56A@mail.gmail.com>
 <0673cb4c-f6ce-027c-8028-62161ca47f9c@duagon.com>
 <CAMZ6RqLLU2BC1m_F8Dfi9_n_AoQ6CgfOgtY3xwTscdLvJN4+Ag@mail.gmail.com>
In-Reply-To: <CAMZ6RqLLU2BC1m_F8Dfi9_n_AoQ6CgfOgtY3xwTscdLvJN4+Ag@mail.gmail.com>

--K4Or60kXnr5symxGOCwXtoLdMPSN1jPHZ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/25/21 12:01 PM, Vincent MAILHOL wrote:
>>>> +/* CTL/BTR Register Bits */
>>>> +#define MEN_Z192_CTL0_INITRQ           BIT(0)
>>>> +#define MEN_Z192_CTL0_SLPRQ            BIT(1)
>>>> +#define MEN_Z192_CTL1_INITAK           BIT(8)
>>>> +#define MEN_Z192_CTL1_SLPAK            BIT(9)
>>>> +#define MEN_Z192_CTL1_LISTEN           BIT(12)
>>>> +#define MEN_Z192_CTL1_LOOPB            BIT(13)
>>>> +#define MEN_Z192_CTL1_CANE             BIT(15)
>>>> +#define MEN_Z192_BTR0_BRP              GENMASK(21, 16)
>>>> +#define MEN_Z192_BTR0_SJW              GENMASK(23, 22)
>>>> +#define MEN_Z192_BTR1_TSEG1            GENMASK(27, 24)
>>>> +#define MEN_Z192_BTR1_TSEG2            GENMASK(30, 28)
>>>> +#define MEN_Z192_BTR1_SAMP             BIT(31)
>>>
>>> Please use only one space between the #define and the value.
>> I had tried that before, but that makes the code difficult to read. Th=
e other drivers in mainline have also used more than one space.
>=20
> When I sent my first patch, I received the same comment asking me
> to remove extra spaces. I am not here to argue which one is the
> most readable. I just recommend you to do as such because it is
> the prefered style here.

IMHO one space only pays out, once you add something to the driver, which=

doesn't fit into the current indention level.

[...]

>>>> +struct men_z192_cf_buf {
>>>> +       u32 can_id;
>>>> +       u32 data[2];
>>>
>>> Is it possible to make it u8 data[CAN_MAX_DLEN]?
>> The core has two 32-bit registers for data, therefore array of two 32-=
bit
>> elements has been used.
>=20
> First thing, u32 is wrong, it should be either __le32 or __be32
> to make your code portable.

You should describe the memory/packet/etc... layout of the hardware here,=
 so if
it's organized in 32 bit values, use them here.

If you have to use __le32, __be32 or u32 depends on how the HW is connect=
ed to
your linux box. If it's USB you have to use the le or be variants.

For memory mapped IO with readl/writel and friend, according to:

> https://elixir.bootlin.com/linux/latest/source/include/asm-generic/io.h=
#L141

{read,write}{b,w,l,q}() access little endian memory and return result in =
native
endianness.

> The data field of struct can_frame is an array of bytes. You have
> to make a choice which is either casting cf->data to
> __be32[] (what you did) or make your data field a u8[].
>=20
> If I am correct, u8[] and __be32[] has the same memory
> layout. Thus I think it is more readable to declare it your data
> field as a u8[] despite how it is declared on the
> controller (and you can add a comment to reflect that).

See above, that should describe your controller.

[...]

>>>> +static int men_z192_xmit(struct sk_buff *skb, struct net_device *nd=
ev)
>>>> +{
>>>> +       struct can_frame *cf =3D (struct can_frame *)skb->data;
>>>> +       struct men_z192 *priv =3D netdev_priv(ndev);
>>>> +       struct men_z192_regs __iomem *regs =3D priv->regs;
>>>> +       struct men_z192_cf_buf __iomem *cf_buf;
>>>> +       int status;
>>>> +       u32 id;
>>>> +       u16 id_11_bits;
>>>> +       u32 id_18_bits;
>>>> +
>>>> +       if (can_dropped_invalid_skb(ndev, skb))
>>>> +               return NETDEV_TX_OK;
>>>> +
>>>> +       status =3D readl(&regs->rx_tx_sts);
>>>> +
>>>> +       if (FIELD_GET(MEN_Z192_TX_BUF_CNT, status) =3D=3D MEN_Z192_M=
AX_BUF_LVL) {
>>>> +               netif_stop_queue(ndev);
>>>> +               netdev_err(ndev, "not enough space in TX buffer\n");=

>>>> +
>>>> +               return NETDEV_TX_BUSY;
>>>> +       }
>>>
>>> Could you stop the queue in advance to prevent returning NETDEV_TX_BU=
SY?
>> sorry, didn'get you. You mean before checking buffer count for max lev=
el? The queue is to be stopped when there are no transmission buffers lef=
t in the hardawre, right?
>> And since now buffer is full, means NETDEV_TX_BUSY?
>=20
> Please refer to: https://www.kernel.org/doc/html/latest//networking/dri=
ver.html

In short:
Once your TX-buffer is full, call netif_stop_queue(). This stops the stac=
k to
call your xmit function. Onc you've successfully send a CAN frame, call
netif_start_queue().

Have a look at the mcp251xfd driver, how to implement that race-free. You=
 can
check if xmit is called with full buffer as a safety net and reutrn TX_BU=
SY, but
if that happens your driver is racy.

>>>> +
>>>> +       cf_buf =3D priv->dev_base + MEN_Z192_TX_BUF_START;
>>>> +
>>>> +       if (cf->can_id & CAN_EFF_FLAG) {
>>>> +               /* Extended frame */
>>>> +               id =3D cf->can_id & CAN_EFF_MASK;
>>>> +               id_11_bits =3D FIELD_GET(MEN_Z192_CAN_ID_11_BITS, id=
);
>>>> +               id_18_bits =3D FIELD_GET(MEN_Z192_CAN_ID_18_BITS, id=
);
>>>> +
>>>> +               id =3D FIELD_PREP(MEN_Z192_CFBUF_ID_11_BITS, id_11_b=
its) |
>>>> +                    MEN_Z192_CFBUF_SRR |
>>>> +                    MEN_Z192_CFBUF_IDE |
>>>> +                    FIELD_PREP(MEN_Z192_CFBUF_ID_18_BITS, id_18_bit=
s);
>>>> +
>>>> +               if (cf->can_id & CAN_RTR_FLAG)
>>>> +                       id |=3D MEN_Z192_CFBUF_E_RTR;
>>>> +       } else {
>>>> +               /* Standard frame */
>>>> +               id =3D FIELD_PREP(MEN_Z192_CFBUF_ID_11_BITS, cf->can=
_id);
>>>> +
>>>> +               if (cf->can_id & CAN_RTR_FLAG)
>>>> +                       id |=3D MEN_Z192_CFBUF_S_RTR;
>>>> +       }
>>>> +
>>>> +       writel(id, &cf_buf->can_id);
>>>> +       writel(cf->can_dlc, &cf_buf->length);
>>>> +
>>>> +       if (!(cf->can_id & CAN_RTR_FLAG) && cf->can_dlc) {
>>>> +               writel(be32_to_cpup((__be32 *)(cf->data)), &cf_buf->=
data[0]);
>>>> +               if (cf->can_dlc > 4)
>>>> +                       writel(be32_to_cpup((__be32 *)(cf->data + 4)=
),
>>>> +                              &cf_buf->data[1]);
>>>
>>> Why do you cast cf->data to __be32? Shouldn't the cf_buf->data
>>> which should be of type __be32 instead (or as commented above,
>>> make cf_buf->data an array of bytes).

cf->data is in __be32 format. (As Vincent said above, an an u8 array for =
4
members has the same mem layout as a __be32).

>> wanted to write 4 bytes with correct byte ordering. When function
>> be32_to_cpup is used for that purpose, it's parameter has to be of typ=
e
>> __be32, which is why casting is done. As already said, there are two 3=
2-bit
>> registers for storing entire 8-byte CAN data, so it is realized with a=
n
>> array of 32-bit type with length of 2.

> be32_to_cpup is to convert endianness from the device to the cpu.
>=20
> As commented above, the type of your data[] is wrong.

I don't think so, as writel assumes a __le32 HW-register converted to nat=
ive
endianess.

> Also, did you test your code on a big endian architecture?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--K4Or60kXnr5symxGOCwXtoLdMPSN1jPHZ--

--aX8XWbS3EO0ToEimKj1n317VMsn0r6HKQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAOruMACgkQqclaivrt
76kDLgf/QiwHlc3FjvF8YYdLiZF2koM2rGS39txv+LoW7bW7gKbC50mnxA/+Wqgu
TKAteAVfL/b+A4ws3AHKJEke911hQY0jSyu1kSeHuofbDFLDOrtjqXBcckCxpFET
NjYG5kSVDtkcnSogA8o24fKP+SFoYwUL3z12VnhJucX/UEhw4DxWdSsHSKaEYtkf
1hUdPO/tKkdk8BWEOWesEy/QtwptAi06Chl5hHGkQ+bX70vCafAjYi+xx2gJSFzl
swwBVXxEYeSg+zoGb/omo8ZJM6YaHM56U8boZ0SobLXlrDbGxaS9996/K5RUUaI9
maH11NYXko45/nj2h3dnIEpUo4ybsQ==
=oOsw
-----END PGP SIGNATURE-----

--aX8XWbS3EO0ToEimKj1n317VMsn0r6HKQ--
