Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3C17F65F
	for <lists+linux-can@lfdr.de>; Fri,  2 Aug 2019 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfHBMDL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 2 Aug 2019 08:03:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54033 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfHBMDL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 2 Aug 2019 08:03:11 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1htWH6-0006Go-NU; Fri, 02 Aug 2019 14:03:08 +0200
Received: from [IPv6:2a03:f580:87bc:d400:595f:209f:a34b:fbc1] (unknown [IPv6:2a03:f580:87bc:d400:595f:209f:a34b:fbc1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 91B8243D733;
        Fri,  2 Aug 2019 12:03:07 +0000 (UTC)
Subject: Re: Disable Network Statistics - CAN
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Tom Prohaszka <tprohaszka@capp-tech.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <CANRGksgbzcwt+XYNbZNrRMy=MXrT4WjXXW814=xYUgiJG+9twA@mail.gmail.com>
 <e4b4d4ea-735c-fa26-3c19-369b1e19b9f7@hartkopp.net>
 <4a7e43fc-dce5-218c-6ebf-85e48ee42936@pengutronix.de>
 <CANRGkshBMbe+JHr0Ya4fZ5L06UQpdJ5ScAc3Xpc-yYsmw1X1EA@mail.gmail.com>
 <db34f851-8f2f-b4bf-011b-fef985c79afe@pengutronix.de>
 <a708c8a5-0e5c-dd5e-37e0-c6928c86615d@grandegger.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
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
 CgkICwUWAgMBABYhBMFAC6CzmJ5vvH1bXCte4hHFiupUBQJcUsSbBQkM366zAAoJECte4hHF
 iupUgkAP/2RdxKPZ3GMqag33jKwKAbn/fRqAFWqUH9TCsRH3h6+/uEPnZdzhkL4a9p/6OeJn
 Z6NXqgsyRAOTZsSFcwlfxLNHVxBWm8pMwrBecdt4lzrjSt/3ws2GqxPsmza1Gs61lEdYvLST
 Ix2vPbB4FAfE0kizKAjRZzlwOyuHOr2ilujDsKTpFtd8lV1nBNNn6HBIBR5ShvJnwyUdzuby
 tOsSt7qJEvF1x3y49bHCy3uy+MmYuoEyG6zo9udUzhVsKe3hHYC2kfB16ZOBjFC3lH2U5An+
 yQYIIPZrSWXUeKjeMaKGvbg6W9Oi4XEtrwpzUGhbewxCZZCIrzAH2hz0dUhacxB201Y/faY6
 BdTS75SPs+zjTYo8yE9Y9eG7x/lB60nQjJiZVNvZ88QDfVuLl/heuIq+fyNajBbqbtBT5CWf
 mOP4Dh4xjm3Vwlz8imWW/drEVJZJrPYqv0HdPbY8jVMpqoe5jDloyVn3prfLdXSbKPexlJaW
 5tnPd4lj8rqOFShRnLFCibpeHWIumqrIqIkiRA9kFW3XMgtU6JkIrQzhJb6Tc6mZg2wuYW0d
 Wo2qvdziMgPkMFiWJpsxM9xPk9BBVwR+uojNq5LzdCsXQ2seG0dhaOTaaIDWVS8U/V8Nqjrl
 6bGG2quo5YzJuXKjtKjZ4R6k762pHJ3tnzI/jnlc1sXzuQENBFxSzJYBCAC58uHRFEjVVE3J
 31eyEQT6H1zSFCccTMPO/ewwAnotQWo98Bc67ecmprcnjRjSUKTbyY/eFxS21JnC4ZB0pJKx
 MNwK6zq71wLmpseXOgjufuG3kvCgwHLGf/nkBHXmSINHvW00eFK/kJBakwHEbddq8Dr4ewmr
 G7yr8d6A3CSn/qhOYWhIxNORK3SVo4Io7ExNX/ljbisGsgRzsWvY1JlN4sabSNEr7a8YaqTd
 2CfFe/5fPcQRGsfhAbH2pVGigr7JddONJPXGE7XzOrx5KTwEv19H6xNe+D/W3FwjZdO4TKIo
 vcZveSDrFWOi4o2Te4O5OB/2zZbNWPEON8MaXi9zABEBAAGJA3IEGAEKACYWIQTBQAugs5ie
 b7x9W1wrXuIRxYrqVAUCXFLMlgIbAgUJAeKNmgFACRArXuIRxYrqVMB0IAQZAQoAHRYhBJrx
 JF84Dn3PPNRrhVrGIaOR5J0gBQJcUsyWAAoJEFrGIaOR5J0grw4H/itil/yryJCvzi6iuZHS
 suSHHOiEf+UQHib1MLP96LM7FmDabjVSmJDpH4TsMu17A0HTG+bPMAdeia0+q9FWSvSHYW8D
 wNhfkb8zojpa37qBpVpiNy7r6BKGSRSoFOv6m/iIoRJuJ041AEKao6djj/FdQF8OV1EtWKRO
 +nE2bNuDCcwHkhHP+FHExdzhKSmnIsMjGpGwIQKN6DxlJ7fN4W7UZFIQdSO21ei+akinBo4K
 O0uNCnVmePU1UzrwXKG2sS2f97A+sZE89vkc59NtfPHhofI3JkmYexIF6uqLA3PumTqLQ2Lu
 bywPAC3YNphlhmBrG589p+sdtwDQlpoH9O7NeBAAg/lyGOUUIONrheii/l/zR0xxr2TDE6tq
 6HZWdtjWoqcaky6MSyJQIeJ20AjzdV/PxMkd8zOijRVTnlK44bcfidqFM6yuT1bvXAO6NOPy
 pvBRnfP66L/xECnZe7s07rXpNFy72XGNZwhj89xfpK4a9E8HQcOD0mNtCJaz7TTugqBOsQx2
 45VPHosmhdtBQ6/gjlf2WY9FXb5RyceeSuK4lVrz9uZB+fUHBge/giOSsrqFo/9fWAZsE67k
 6Mkdbpc7ZQwxelcpP/giB9N+XAfBsffQ8q6kIyuFV4ILsIECCIA4nt1rYmzphv6t5J6PmlTq
 TzW9jNzbYANoOFAGnjzNRyc9i8UiLvjhTzaKPBOkQfhStEJaZrdSWuR/7Tt2wZBBoNTsgNAw
 A+cEu+SWCvdX7vNpsCHMiHtcEmVt5R0Tex1Ky87EfXdnGR2mDi6Iyxi3MQcHez3C61Ga3Baf
 P8UtXR6zrrrlX22xXtpNJf4I4Z6RaLpB/avIXTFXPbJ8CUUbVD2R2mZ/jyzaTzgiABDZspbS
 gw17QQUrKqUog0nHXuaGGA1uvreHTnyBWx5P8FP7rhtvYKhw6XdJ06ns+2SFcQv0Bv6PcSDK
 aRXmnW+OsDthn84x1YkfGIRJEPvvmiOKQsFEiB4OUtTX2pheYmZcZc81KFfJMmE8Z9+LT6Ry
 uSS5AQ0EXFLNDgEIAL14qAzTMCE1PwRrYJRI/RSQGAGF3HLdYvjbQd9Ozzg02K3mNCF2Phb1
 cjsbMk/V6WMxYoZCEtCh4X2GjQG2GDDW4KC9HOa8cTmr9Vcno+f+pUle09TMzWDgtnH92WKx
 d0FIQev1zDbxU7lk1dIqyOjjpyhmR8Put6vgunvuIjGJ/GapHL/O0yjVlpumtmow6eME2muc
 TeJjpapPWBGcy/8VU4LM8xMeMWv8DtQML5ogyJxZ0Smt+AntIzcF9miV2SeYXA3OFiojQstF
 vScN7owL1XiQ3UjJotCp6pUcSVgVv0SgJXbDo5Nv87M2itn68VPfTu2uBBxRYqXQovsR++kA
 EQEAAYkCPAQYAQoAJhYhBMFAC6CzmJ5vvH1bXCte4hHFiupUBQJcUs0OAhsMBQkB4o0iAAoJ
 ECte4hHFiupUbioQAJ40bEJmMOF28vFcGvQrpI+lfHJGk9zSrh4F4SlJyOVWV1yWyUAINr8w
 v1aamg2nAppZ16z4nAnGU/47tWZ4P8blLVG8x4SWzz3D7MCy1FsQBTrWGLqWldPhkBAGp2VH
 xDOK4rLhuQWx3H5zd3kPXaIgvHI3EliWaQN+u2xmTQSJN75I/V47QsaPvkm4TVe3JlB7l1Fg
 OmSvYx31YC+3slh89ayjPWt8hFaTLnB9NaW9bLhs3E2ESF9Dei0FRXIt3qnFV/hnETsx3X4h
 KEnXxhSRDVeURP7V6P/z3+WIfddVKZk5ZLHi39fJpxvsg9YLSfStMJ/cJfiPXk1vKdoa+FjN
 7nGAZyF6NHTNhsI7aHnvZMDavmAD3lK6CY+UBGtGQA3QhrUc2cedp1V53lXwor/D/D3Wo9wY
 iSXKOl4fFCh2Peo7qYmFUaDdyiCxvFm+YcIeMZ8wO5udzkjDtP4lWKAn4tUcdcwMOT5d0I3q
 WATP4wFI8QktNBqF3VY47HFwF9PtNuOZIqeAquKezywUc5KqKdqEWCPx9pfLxBAh3GW2Zfjp
 lP6A5upKs2ktDZOC2HZXP4IJ1GTk8hnfS4ade8s9FNcwu9m3JlxcGKLPq5DnIbPVQI1UUR4F
 QyAqTtIdSpeFYbvH8D7pO4lxLSz2ZyBMk+aKKs6GL5MqEci8OcFW
Message-ID: <aadfb941-5ee3-07a7-56b7-8c580f7a2266@pengutronix.de>
Date:   Fri, 2 Aug 2019 14:03:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a708c8a5-0e5c-dd5e-37e0-c6928c86615d@grandegger.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="s5SA19xPCmwmbytQtIXXAjob4sREqLQXg"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s5SA19xPCmwmbytQtIXXAjob4sREqLQXg
Content-Type: multipart/mixed; boundary="X06FnXjijwF1nlnsBwXcfabn4aULPkUIl";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>,
 Tom Prohaszka <tprohaszka@capp-tech.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <aadfb941-5ee3-07a7-56b7-8c580f7a2266@pengutronix.de>
Subject: Re: Disable Network Statistics - CAN
References: <CANRGksgbzcwt+XYNbZNrRMy=MXrT4WjXXW814=xYUgiJG+9twA@mail.gmail.com>
 <e4b4d4ea-735c-fa26-3c19-369b1e19b9f7@hartkopp.net>
 <4a7e43fc-dce5-218c-6ebf-85e48ee42936@pengutronix.de>
 <CANRGkshBMbe+JHr0Ya4fZ5L06UQpdJ5ScAc3Xpc-yYsmw1X1EA@mail.gmail.com>
 <db34f851-8f2f-b4bf-011b-fef985c79afe@pengutronix.de>
 <a708c8a5-0e5c-dd5e-37e0-c6928c86615d@grandegger.com>
In-Reply-To: <a708c8a5-0e5c-dd5e-37e0-c6928c86615d@grandegger.com>

--X06FnXjijwF1nlnsBwXcfabn4aULPkUIl
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/2/19 1:50 PM, Wolfgang Grandegger wrote:
> Hello,
>=20
> Am 02.08.19 um 13:07 schrieb Marc Kleine-Budde:
>> On 8/2/19 1:49 AM, Tom Prohaszka wrote:
>>> I found this for the V5 commit:
>=20
> If I remember correctly, the latest version of this series is V7.
>=20
>>> https://www.spinics.net/lists/linux-can/msg00847.html
>>> I may have read it wrong.  It sounds like the network stack is
>>> dropping them, not necessarily the "statistics" gathering.
>>>
>>> Still the driver is able to handle reception of 99.95% of all CAN fra=
mes
>>> of a 100% saturated 1MHz Can2.0 Bus with Frames with standard IDs and=

>>> DLC=3D0 on a Raspberry Pi 3. Note that this statistics is without inj=
ection
>>> into the network stack, which then drops about 60% of all frames.
>> To my understanding it's the networking stack that drops the CAN frame=
s
>> not the statistics itself.
>=20
> Yes, the problem is that there is little CPU time left for the upper
> layer to process the packets. SPI keeps the system busy! Anyway, this i=
s
> not a realistic CAN use-case but it clearly shows that you can overload=

> your system easily that way.
>=20
>>
>> However I've added a Kconfig option to the driver to switch off the
>> debugfs support:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git=
/log/?h=3Dmcp25xxfd
>=20
> I suggested to Martin to remove all the heavy debugging and statistics
> stuff... or at least to make it configurable (including incrementing of=

> the counters). I would use a dedicated CONFIG_CAN_MCP25XXFD_DEBUG_FS.
> CONFIG_DEBUG_FS is usually enabled.

I've done exactly that:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/co=
mmit/?h=3Dmcp25xxfd&id=3D0286079d7b1d0215f06f402523274448dda3d093

The updated driver is available at:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/lo=
g/?h=3Dmcp25xxfd

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--X06FnXjijwF1nlnsBwXcfabn4aULPkUIl--

--s5SA19xPCmwmbytQtIXXAjob4sREqLQXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1EJnYACgkQWsYho5Hk
nSCmNggAq0P4XGcztyApdJ3JWuiVYQTeeWIe86a3UYY5Z3XfSASSc9NBGo0r/Vf1
f5EQNUke63kSUbVMEBY7kmyFzTFRwZI6VPpo+2gtZVMTO1eAwRoMmjXT/QlvebR7
vD7mwsdV0bI7rZSjZGPOFyAbBMimYbRiOfDNx/yIJK1G6JQkhNFZOVYThWJG/i1a
n0FCDy64U/UYKLnqbcb5fSvP+LOCKHrTDr/B3+EogdztFC1wSnhqDp0HhuHvetn5
I9A+44bv4pHSlZqpq3pUxayPjSYaz39uky6GLLHzJX9r9WqNPHAMW3rctFMnc4eT
y8BV4tAKyasPKjqE8ZAO9FWq3tBt3w==
=OAk1
-----END PGP SIGNATURE-----

--s5SA19xPCmwmbytQtIXXAjob4sREqLQXg--
