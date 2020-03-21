Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF52A18E25B
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2020 16:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCUPTl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 21 Mar 2020 11:19:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:45859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgCUPTk (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 21 Mar 2020 11:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584803978;
        bh=6hqYK/njlyT4HT0MMB92HLeIhAAiSHmhe6s3KrtP6cI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=NujLa4gAANJfFFVdKeYKNwfvNm/uGso2vhZpwWaFS9/Hgw3dqkgNNifcsbkaRB15g
         GDS6NEoLV66Ji9UvH7x731lj69Cb7nexcIMf1c4zG0t7yR0tH3cQDCRZ/pX0UBMrc8
         DhDMKVWfzZ4Dres/qM2YERabJSFpgiolALVl6U6o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.103] ([84.176.144.33]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbkC-1izG3K02cG-00KyPJ; Sat, 21
 Mar 2020 16:19:38 +0100
Subject: Re: Need help in interpreting ip status output
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
 <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
 <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
From:   =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Cc:     Alex Blasche <alexander.blasche@qt.io>
Message-ID: <75a1a6b5-141e-e741-f6c2-bab5e9e4e541@gmx.de>
Date:   Sat, 21 Mar 2020 16:19:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bz3Qj3MG4DEmx78k7oAu/MosgHI29TsnikSjQ+xJ/OEiTWBxsZh
 /NnrhbnM29g3gQvalYThYRCrlDf0TXIdmJ0jgUUGEQ82JnkAxRz8QXSBUclbFCJBO4UEs3j
 lD+kF4+uVBKKQGDZPGu65kD0fmomjr8Bv1h6RC0zQiQRm37r2zHfPASTI6dVR7fUiknjTCN
 1HeStO3JqDadkx8nFbaig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2uRfJoxS2k4=:7+e2YrCQxnlZgLKETBTjFk
 E+/TzF6nDgd+9qIQ/vXrJ/JWZ79xDwyIevrJiFv0kp5wk9FK8g3gRajCFhEa5aAkccEgrdF2X
 Qw6is/p9PDrFOwJ/BpcKy+Uig9Yh6YqiZCyUySEa4TKmatkJ/X0sc1gI/ZSOTrb7+z6lngcw6
 WqMpEPz2KEH//sI63nrBu9E3+j+p0vJoQNHKfvpUEXbPYytQWeir88NkuWKIzGOg/GQ6IeWo5
 O/v/n6k+H/QvJtkUGf1hGIaI9YRQVTIEDn1jxp1WzdUvheAmskw0+jNMHF8ymE75ljPZiXG6z
 UgnNFQTzTgYYeicnAdMftJhxi5SvOqfZQA5E5G+Kbj52mjpgyAgzlns6IFtaWh+y7349l9Qcl
 0bCsF1EYH7IKxYJfx/PkEETeHOShrhbCtUyAfML2+cwD2iKVahLNYW46f9AhAKbdKD4BnNwb2
 MqeHqJQLewsknrNiBoY8Eit14jzpZ1ty/SQSnddn0vgLxhrZmKRtCj/ysv3mUbDZAkYBtCtvT
 gdLTmIcuZ7hiJJp0dSRBiPIQItvftBCE8wugLaLAu7cEKqREX/LYJesH+mUtT3usP6Z0fGWYq
 7O2nBvn1Kl80GoJkzFTk54WeZ9+/aOJzttwIz7HBj6ck4Mrk7O9EcwaEcA668h955hsn7CSAb
 PfftsHnlkcBbiUO0b0pZ4Nb5Oy+nC5uFT2YUCUU4CtvIyBZ9VNmRBv+2QFVWcnF5zq+19Skck
 EoHhDZUfoYAnSFT6xE/wuEqmT+LMB45jGGfnvXCc6AdMu9lMJ012PSavtP2FSOmlO9+grZ/Qu
 bNmJ4SSNeNB43NTCzq02JLXFB5LUTMOzu1h7vu3y7aUnU4xO7bTk+LY7uS3q9HDBslJdZM+0P
 OdcB3suMHGLHb0h4zh+qHDNsOHZFOlwC/0cZ4blyioZYfpDWL3zAXHLAX0mT3PHg2uiDnZBzW
 rpPmYuZyW9G7nGZBo/kIputCJzmdfVft7ztzhST9CNPmQ9Ku2dYNdYXFhONE18xx15MGTvvlX
 yR/nyjDgFCoqfAkbezR3SIasskbjDwIc6vV3RJ4m/1G9mWP4zJDZnsMht3RWhT84OGh5gaja1
 iIiaD7zAk662LLZ98g/I/ZToq4AUrXDSJE9O4/NWVTkXyerPbsF1muGhZx6beEZBFBout09IH
 QaKKL4RcwMUwa9cmHFoWHzZNNjrHfzpyj5uyShEk0kX7hJ8y2SYbZgc5qEZRfg0RguReJcmlU
 PiM2BEkhw2W74IqeA
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

thanks for your answer. I hope you are well.

> Hi Andr=C3=A9,
>
> I have an idea ;-)
>
> On 12/03/2020 18.43, Andr=C3=A9 Hartmann wrote:
>
>>> can someone help me interpreting the following ip output:
>>>
>>> ip -s link show can1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 1=
6 qdisc pfifo_fast state
>>> UNKNOWN mode DEFAULT group default qlen 100
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link/can
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX: bytes=C2=A0=
 packets=C2=A0 errors=C2=A0 dropped overrun mcast
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9987413=C2=A0 1=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 74=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX: bytes=C2=A0=
 packets=C2=A0 errors=C2=A0 dropped carrier collsns
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>
>>> I'm especially interested in the meaning of the
>>>
>>> * 1 errors
>>> * 74 dropped
>>> * 1 overrun
>
> E.g. if you look into
> linux/drivers/net/can/sja1000/sja1000.c
> you can see that an overrun error also triggers the error counter to
> increase - that's why both are set to 1.
>
> The reason for the overrun error is a notification from the CAN
> controller itself. It tells us that the received CAN frame has not been
> read from the controller until the next CAN frame arrived.

Ok, that's what I thought too, thanks for the confirmation.

> The dropped counter usually indicates that the CAN driver did not get a
> skbuff data structure (e.g. out of memory condition).
>
> This is NOT good. What CAN hardware/setup are you using?

Actually it's not my system. The report is from a customer doing a full
load test on an iMX8: https://bugreports.qt.io/browse/QTBUG-82610

I guess the customer should try a more recent Kernel than 4.14 first?

Thanks, and best regards,
Andr=C3=A9

>
> Regards,
> Oliver

