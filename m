Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161712F845C
	for <lists+linux-can@lfdr.de>; Fri, 15 Jan 2021 19:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbhAOS2h (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Jan 2021 13:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAOS2h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Jan 2021 13:28:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A35C061757
        for <linux-can@vger.kernel.org>; Fri, 15 Jan 2021 10:27:56 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l0Tp6-00080d-0i; Fri, 15 Jan 2021 19:27:48 +0100
Received: from [IPv6:2a03:f580:87bc:d400:2295:8eab:d63d:3b03] (unknown [IPv6:2a03:f580:87bc:d400:2295:8eab:d63d:3b03])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8E56A5C4BF7;
        Fri, 15 Jan 2021 18:27:45 +0000 (UTC)
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20210112130538.14912-1-mailhol.vincent@wanadoo.fr>
 <20210112130538.14912-2-mailhol.vincent@wanadoo.fr>
 <981eb251-1573-5852-4b16-2e207eb3c4da@hartkopp.net>
 <CAMZ6RqKeGVsF+CcqoAWC7JXEo2oLTS5E5B3Jk4oeiF9XWEC3Sw@mail.gmail.com>
 <3daf39cb-2835-379d-86df-91b17282594a@pengutronix.de>
 <47a39992-2368-1403-e55c-3bee4793b91c@hartkopp.net>
 <7b41612e-6c99-a713-5285-a044402066bd@pengutronix.de>
 <CAMZ6RqLFLtcGQsnRLPF8VD4=OhSArM3HVT_2MNG-9HVBuPMV=Q@mail.gmail.com>
 <580003bc-af06-9d97-dfd1-aa56e306943a@pengutronix.de>
 <CAMZ6RqJ4dpbQdh96xSJyyVg_Ztzt0dw2z8Bn+e32vzq2=y1Gyg@mail.gmail.com>
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
Subject: Re: [PATCH v10 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
Message-ID: <b3088f7e-b5f1-a5bf-4e6c-a14cd1dec25b@pengutronix.de>
Date:   Fri, 15 Jan 2021 19:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqJ4dpbQdh96xSJyyVg_Ztzt0dw2z8Bn+e32vzq2=y1Gyg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="s7U5NVACQAdV331zoBsy4NPD9gE7qoRDW"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s7U5NVACQAdV331zoBsy4NPD9gE7qoRDW
Content-Type: multipart/mixed; boundary="QDkL9O860frGkd3PowVdm2vw6Sv56EXeD";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 linux-can <linux-can@vger.kernel.org>,
 Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>,
 Wolfgang Grandegger <wg@grandegger.com>, Jimmy Assarsson <extja@kvaser.com>,
 Masahiro Yamada <masahiroy@kernel.org>
Message-ID: <b3088f7e-b5f1-a5bf-4e6c-a14cd1dec25b@pengutronix.de>
Subject: Re: [PATCH v10 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
References: <20210112130538.14912-1-mailhol.vincent@wanadoo.fr>
 <20210112130538.14912-2-mailhol.vincent@wanadoo.fr>
 <981eb251-1573-5852-4b16-2e207eb3c4da@hartkopp.net>
 <CAMZ6RqKeGVsF+CcqoAWC7JXEo2oLTS5E5B3Jk4oeiF9XWEC3Sw@mail.gmail.com>
 <3daf39cb-2835-379d-86df-91b17282594a@pengutronix.de>
 <47a39992-2368-1403-e55c-3bee4793b91c@hartkopp.net>
 <7b41612e-6c99-a713-5285-a044402066bd@pengutronix.de>
 <CAMZ6RqLFLtcGQsnRLPF8VD4=OhSArM3HVT_2MNG-9HVBuPMV=Q@mail.gmail.com>
 <580003bc-af06-9d97-dfd1-aa56e306943a@pengutronix.de>
 <CAMZ6RqJ4dpbQdh96xSJyyVg_Ztzt0dw2z8Bn+e32vzq2=y1Gyg@mail.gmail.com>
In-Reply-To: <CAMZ6RqJ4dpbQdh96xSJyyVg_Ztzt0dw2z8Bn+e32vzq2=y1Gyg@mail.gmail.com>

--QDkL9O860frGkd3PowVdm2vw6Sv56EXeD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/15/21 5:30 PM, Vincent MAILHOL wrote:
>>>>>>> I would just like your opinion on one topic: the tdco is specific=

>>>>>>> to CAN FD. If we add it, we have two choices:
>>>>>>>    1. put it in struct can_bittiming: that will mean that we will=

>>>>>>>       have an unused field for classical CAN (field bittiming of
>>>>>>>       struct can_priv).
>>>>>>>    2. put it in struct can_priv (but outside of struct
>>>>>>>       can_bittiming): no unused field but less pretty.
>>>>>>
>>>>>> 3. Deprecate struct can_bittiming as the user space interface
>>>>>>     and transfer each member individually via netlink. Extend
>>>>>>     the kernel-only can_bittiming by the tdc related
>>>>>>     parameters, and add these to the new netlink interface.
>>>
>>> Wow, didn't see that third option coming!
>>>
>>> By "extend the kernel-only can_bittiming by the tdc related
>>> parameters" do you mean to still use a single struct
>>> can_bittiming for classical CAN and CAN FD with the tdc
>>> parameters in both (a bit like what I suggested in 1.)?
>>
>> Let's put it this way, we need 3. in order to implement 1. As we need =
a stable
>> userspace ABI.
>=20
> I was not familiar enough with the netlink interface to foresee
> all those dependencies but thanks to your explanations, now
> everything starts to make sense.

>> Option 4:
>> We can introduce a struct can_bitiming_fd with the first member being =
the struct
>> can_bitiming and add tdc related variables after that. This way we can=
 use the
>> same function to calculate the bit timing on both CAN and CAN-FD.
>=20
> While option 3 is slightly easier, my preference will go to option 4.

We still need the netlink enhancement from option 3.

>> What about future developments?
>>
>> Does anyone have a clue about CAN-XL? Will we ever see real HW?
>=20
> Recent news would suggest that CiA will release the CAN XL
> specification this year:
> https://www.can-cia.org/news/cia-in-action/view/a-bright-future-for-can=
/2021/1/2/

Thanks, I've missed this.

>> Or will
>> 10Base-T1 and 100Base-T1 take the market?
>=20
> My guts tell me that 100Base-T1 will take the market for
> autonomous driving (camera, Lidar...) and that CAN(-FD) has still
> a bright future for safety critical domains, at least in the next
> decade.

There are already automotive equipment out there, that uses CAN-FD and
100Base-T1. Wakeup via CAN-FD, once alive do other stuff via 100Base-T1.

> Will CAN XL find its place or will it meet the same
> destiny as flexray? I do not know. But once the specification and
> the first hardware are out, we would probably start to implement
> it in Socket CAN before knowing if it will win the market :)
>=20
> Nonetheless, if we follow your idea of transferring each member
> individually via netlink, then we will have enough flexibility to
> adjust the new kernel only can_bitiming structures to our liking.

ACK

>> There are also these new transceivers in development that should be be=
tter
>> suited for "special" bus setups.
>=20
> Do these require additional bittiming parameters?
Don't know - haven't had one of those in my hands, yet. They are called "=
CAN SIC
Transceivers" the slides promise Signal Improvement and former "Ringing
Suppression".

Back to TDC, which values do you want to provide to user space?

>> +		netdev_vdbg(netdev,
>> +			    "Transmitter Delay Compensation        =3D %d\n",
>> +			    tx_conf_msg->tdc);
>> +		netdev_vdbg(netdev,
>> +			    "Transmitter Delay Compensation Offset =3D %d\n",
>> +			    le16_to_cpu(tx_conf_msg->tdco));
>> +		netdev_vdbg(netdev,
>> +			    "Transmitter Delay Compensation Filter =3D %d\n",
>> +			    le16_to_cpu(tx_conf_msg->tdcf));

Can we describe them in a HW independent way?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--QDkL9O860frGkd3PowVdm2vw6Sv56EXeD--

--s7U5NVACQAdV331zoBsy4NPD9gE7qoRDW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAB3p4ACgkQqclaivrt
76kVmQf/ROXXVZj5frU2dho7y6Nv/7Pnk/hmovK67IAbv1kvyVOLIQNGF8YpVyPe
DmphJnlPoXKdhZ6bTQNWRTjY4aQwN3lqdAZZ7ytXSnhUGLDvh+XXsUjdLpKDhJmb
/CKO2XS9ceJTaVTTcxuito/fttIIo9IKukt1HtctdTLRR4tC7XFT3Was5sutvEwI
3afSPlc8WTl+lkTOpOALzEvduCAP4qvv6uN9OInMPSkfKdCI9bRu4eEEMfviuyHt
avqUCZ5I0s2CmmRNGGtm3oHJU4wTHZ4CfLoGFiyjXVbLnacmCKNfMR7UDMRpHXYq
4X/b6RkLNwD6ZlJ82ik6b0ilMvFA9Q==
=0Bk7
-----END PGP SIGNATURE-----

--s7U5NVACQAdV331zoBsy4NPD9gE7qoRDW--
