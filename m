Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7179AC353F
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2019 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfJANMb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Oct 2019 09:12:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59921 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387648AbfJANMb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Oct 2019 09:12:31 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iFHx7-0001GB-Bt
        for linux-can@vger.kernel.org; Tue, 01 Oct 2019 15:12:29 +0200
Received: from [IPv6:2001:67c:670:202:8d54:a7be:bff4:2a07] (unknown [IPv6:2001:67c:670:202:8d54:a7be:bff4:2a07])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 760B345E008
        for <linux-can@vger.kernel.org>; Tue,  1 Oct 2019 13:12:28 +0000 (UTC)
To:     linux-can@vger.kernel.org
References: <1569871843-28655-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <1569871843-28655-3-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <6aa6d0f0-e424-0874-19c8-73a8344a1458@pengutronix.de>
 <20191001102217.GA25141@x1.vandijck-laurijssen.be>
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
Subject: Re: [PATCH 2/3] net can c_can: replace napi-hanlder with irqthread
Message-ID: <54551082-b309-41f4-57eb-4d42118326d3@pengutronix.de>
Date:   Tue, 1 Oct 2019 15:12:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001102217.GA25141@x1.vandijck-laurijssen.be>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Zj1hwqB9f2keTnvkiXlgXI41wcPbf7Kwy"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zj1hwqB9f2keTnvkiXlgXI41wcPbf7Kwy
Content-Type: multipart/mixed; boundary="DtLGZ0SCE4UQtIeGT1YmZQAvSPZTsw8BD";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org
Message-ID: <54551082-b309-41f4-57eb-4d42118326d3@pengutronix.de>
Subject: Re: [PATCH 2/3] net can c_can: replace napi-hanlder with irqthread
References: <1569871843-28655-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <1569871843-28655-3-git-send-email-dev.kurt@vandijck-laurijssen.be>
 <6aa6d0f0-e424-0874-19c8-73a8344a1458@pengutronix.de>
 <20191001102217.GA25141@x1.vandijck-laurijssen.be>
In-Reply-To: <20191001102217.GA25141@x1.vandijck-laurijssen.be>

--DtLGZ0SCE4UQtIeGT1YmZQAvSPZTsw8BD
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 10/1/19 12:22 PM, Kurt Van Dijck wrote:
> On di, 01 okt 2019 11:40:09 +0200, Marc Kleine-Budde wrote:
>> On 9/30/19 9:30 PM, Kurt Van Dijck wrote:
>>> The napi-handler defers c_can reception to softirq, but it is hard to=

>>> control the RT priority of the CAN recv end inside a softirq.
>>> Using an irqthread allows precise control of it's RT priority.
>>> Having the quota still around in the IRQ thread allows to restrict
>>> the work_done per cycle.
>>>
>>> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>>
>> NACK, not pushing CAN frames though NAPI results in very strange thing=
s,
>> such like package reordering.
>=20
> This becomes interesting.
> Would you mind elaborating a bit on that.
>=20
> I'm currently trying to avoid CAN overflows on an RT system, where
> I eleveated the can irq thread above the others.

RT with PREEMPT_RT?

> Then I discovered that the softirqd waits a lot before being scheduled,=

> but this one deal with all others too, so I started to question the who=
le
> softirq thing because its a garbage can for all postponed work.
> Mirgrating to a threaded irq seems wise to me then.

AFAIC you're only allowed to use netif_receive_skb() from softirq, i.e.
the NAPI context, see the documentation:

    https://elixir.bootlin.com/linux/latest/source/net/core/dev.c#L5265

I'm not sure about threated IRQ handlers....but from hard-IRQ context,
you should use netif_rx():

    https://elixir.bootlin.com/linux/latest/source/net/core/dev.c#L4544

and netif_rx_ni() from threaded IRQ context:

    https://elixir.bootlin.com/linux/latest/source/net/core/dev.c#L4557

Please switch on all lockdep stuff and watch out for "softirq abc
pending" messages.

> If a single thread reads all the incoming messages from the chip,
> the are received in order, I assume. Who would reorder the packets?
> Is synchronizing rx/tx paths handled in napi? they depend on different
> softirqs, if I remember well.

If, for the above reasons you have to use netif_rx(_ni)() and are on a
multicore system, the packets might be delivered on different CPUs and
processed in the wrong order. I have to google for more details...

What about reading the packet from the hardware in IRQ context and
putting them into the networking stack in NAPI. The rx-offload does
basically this.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DtLGZ0SCE4UQtIeGT1YmZQAvSPZTsw8BD--

--Zj1hwqB9f2keTnvkiXlgXI41wcPbf7Kwy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2TULEACgkQWsYho5Hk
nSBAdgf/fJh2giflkRk8TJYK3BMRhUxBTm0IDSNErUUuVcIHT7KTs/2kJHPsv0mz
y7xMU0EfUx+hTf8UuNSBeJlMbIrcCtb+PTqG43UlwZ1fCQOdmPmU316/rXKoirDR
HDP79LfoDUZLgjo1BdRH2NRkwj6H/aX1QEimuxdcaUP6JjmBNK3YTy7/p6xpdnL2
uMs2cYh9VjR+8Yy45NXFQVRNb7IqMvlHHb/aMDA1zT/0+9N+qHmsJzX0tQ44nV8/
UNLH9ksBICpb6VUq/sAGrXChUxdo+uOZuWA7idqmXXNST7r4j9B8k0Cbv8sCciWl
AAbmRT6bPECR4fV03n421p7RIyBx2w==
=UyYc
-----END PGP SIGNATURE-----

--Zj1hwqB9f2keTnvkiXlgXI41wcPbf7Kwy--
