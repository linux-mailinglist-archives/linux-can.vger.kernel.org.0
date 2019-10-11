Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F6ED3950
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2019 08:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfJKGZP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Oct 2019 02:25:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:33245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfJKGZP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 11 Oct 2019 02:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570775112;
        bh=HspOiZRsL3P0owu4eaRuBGh5Y8XKP91cEbuBSIbgBNE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=RZhxCg355iUBXtOqtM1dv6FverxYgnBJxr3t7ezJfTY6hfbbgb43/+U2/iqcFyW3E
         jXG4hNHW8X8QHh7WlipaNACtgOqx5wRJNeyvKnMfTxiCV5ogw6fzGUUhSwvFZR93p1
         /dUsceyQG3JswOeOFAvJfl8vTndGg943iV6FZrz4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.104] ([46.90.112.247]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1iSTOW3ne7-00RGOC; Fri, 11
 Oct 2019 08:25:12 +0200
Subject: Re: [PATCH v4] CAN FD data bitrate support
From:   =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Lars Susaas <larssusaas@gmail.com>
References: <1536255450-2417-1-git-send-email-aha_1980@gmx.de>
 <213f222c-bb0b-b9c0-c5ff-75ed663e65fb@gmx.de>
 <twjern.pimz4g.rte7db-qmf@gmx.com>
 <05127874-883b-36f8-63a3-11fac5c685c7@gmx.de>
Message-ID: <721e5a0d-2e55-97a4-13a9-641108d247f1@gmx.de>
Date:   Fri, 11 Oct 2019 08:25:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <05127874-883b-36f8-63a3-11fac5c685c7@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hr83Sc7O9MxybEghhfpEgENXzptDuYrPETLh2JCGYQOCthfY3N2
 PxFpfakuW5M2lvER3Uv6raUP7yEiBzIsq37BKTtDW/6RNk0VAlbyaW/fGbYKQbARmE/H98a
 +nN0O7HoQuW6z2ChHWz6UvFx+Vhg/TxOaIkEtt96/CtUAfI2yCvHZRZQ/nCy99IC1zT7FS7
 e5WhSJHsfB1KC2PrENxUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sR8Mx/bPuiY=:xxjrkn5bc9q0s9NXj8VzHt
 w6NCT4qqiECK2vedBgoUHICKGyYqaEfBZxVsmVIyP9aTL2PzUtUNIg642QwFKwtKZN2tEgiwt
 oGmF8SJJNHTPu4zDHWlfKxyfaDkX0Fwphy0xZX0JxzxLsARrLHoxo3ABO+9lckFTppU6oD1qT
 UbVK5amT/X0mzMUmg+WUbRTVqXtQTnx1IEjmrXo+xGjJNlFm+6JAQ12S4Jrt16mSXIjn552x5
 PohtOZrDi2EP2bRjSN8xx0pPCFC2Q9YyZxr8JbmfiY/qP7B1tWUEWSAXtkiRNTNAjLhqfnJZf
 s+wTrOk9jK2tFOrHLoNn/t48jWE3njZ4siuewB+6QABtqsQgApITcTaKZynleYaK3p06ZsN/S
 BKu5VI5miFyuT/VQA4gagfVaQmlUQ3cnlrdnwOG212fSaoqjERdhPym56q+Z9zMR9Vq1i0EME
 tYuNFXNYqAvmLMSb7BHgymSu8PLZAWWEIl+SjngFyiCwXLFSrZ6Hux9wNAgGk4AIGJE4pviKA
 tRc/YRFa7pM/NgF6HpGesZO0qDwEBFope6rQAGp2rohYOd2/aW+NlZEBjJoER/XBb0YW8AQPP
 722qpyVk89kmW8G8M7pKnYg9uVjfjqUpieN4AK4ptyiIl/3l0KA8OIEOAZr7nt9Unpk+GtczW
 +pjzQLuzBCzA+LaGv1voyIL5rECtgParRRqsBFg+23tWzT+lAbQVRgfaBYFFss/pPnaMgNrXk
 v/TefNzNu0VyfPxy0Ost4Gbx2NWRzqUWVQveBFSDwh4OkO5jnseuMRlX+Y6KRRjCFHYt8Knst
 VPJHY7h5CSSagjhvNFIc8fGN0w7dDasvL7qQrvcVQ0/vacWecgapOiiQ/qyb36NnEFotRUY3C
 4XF3cPRqLaltekQFdrdRmLY5c0TXL6/7D5xrP+THccDsCe81wf+BDjtDk4FftY2+pwTWgIP8M
 O0l4o9JbSiKFLCmIEm+nboCH0ZMeCC+yKW394dVeZHJCL73N4KJ9lqBQ7KzmMqoI1x8iTvLyD
 xnyKbAZhE/qhVGpGy5p4PhsgJlLNZe9AgGth1M2x/AcfmrRimqX2CjnGUNOevzOWmSfZHcvo+
 r951WVmyyJWXaeLGBMDYzGVox2zyoTkL0NkpVl/GGJttrX1dYYviYoZWF2r3P7ncAYJZoRkyp
 IvpLsGBpHU/Q6DKyn1DnGJlAe1tfol0VFjfSEzwOr1EoHVUs045trwOb4DQoZdt8h3D8RNXIO
 DCx1F517Kqh8oeS9r2FCzz7ct6AtpBAs7jbwnGE5fhG5Vk8VatpqUZ8z53As=
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

another ping.

I've already given up hope.

Best regards,
Andr=C3=A9

On 18.03.19 18:11, Andr=C3=A9 Hartmann wrote:
> Hi Marc,
>
> I almost forgot about this patch, it's now nearly a year since the first
> version.
>
> What is needed to push this forward?
>
> Thanks,
> Andr=C3=A9
>
> Am 23.11.18 um 08:50 schrieb Andre Hartmann:
>> Ping?
>>
>> Am Mittwoch, 10. Oktober 2018 schrieb Andr=C3=A9 Hartmann:
>>> Hi Marc,
>>>
>>> any news on my patch?
>>>
>>> Regards, Andr=C3=A9
>>>
>>> Am 06.09.2018 um 19:37 schrieb Andre Hartmann:
>>>> v4: - setup git-send-email :)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - changed can_set_bitrate() to keep da=
ta bitrate if set
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - some format fixes
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - use C99 designated initializers inst=
ead memset
>>>>
>>>> v3: only internal
>>>>
>>>> v2: only internal
>>>>
>>>> Lars Elgtvedt Susaas (1):
>>>> =C2=A0=C2=A0=C2=A0 Get and set CAN FD data bitrate
>>>>
>>>> =C2=A0=C2=A0 README=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
>>>> =C2=A0=C2=A0 include/libsocketcan.h |=C2=A0=C2=A0 5 ++
>>>> =C2=A0=C2=A0 src/libsocketcan.c=C2=A0=C2=A0=C2=A0=C2=A0 | 233
>>>> +++++++++++++++++++++++++++++++++++++++++++++++--
>>>> =C2=A0=C2=A0 3 files changed, 235 insertions(+), 5 deletions(-)
>>>>
>>>
>>>
>>
>

