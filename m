Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4213C18F02E
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2020 08:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCWHTP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 23 Mar 2020 03:19:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:41471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbgCWHTP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 23 Mar 2020 03:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584947950;
        bh=RCJyHiLzrQez05FSKflTKcMqVIDwt92g9SrNyWJLWes=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=KICCQt+ZaDUx6dW/0oAoldOSh2cBzdDkZU//BzaPbXP5X8BftfCdMvfGvwb36KTwv
         DYWnkQG8ONSZOdUsTN0nHpsLnuzei4mq+7Nl4v3vSeUxAiwMCYVzdB9nowD3EnH4QY
         wzxFpDvJ7jg9ZwDl5CApgI2txcSRdDa3h9j3UPVM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.103] ([84.176.144.33]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbirE-1jp4gC0V8Y-00dJ88; Mon, 23
 Mar 2020 08:19:10 +0100
Subject: Re: Need help in interpreting ip status output
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Alex Blasche <alexander.blasche@qt.io>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
 <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
 <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
 <75a1a6b5-141e-e741-f6c2-bab5e9e4e541@gmx.de>
 <fe141541-7e79-3bee-8c75-29e6f9f3bc4e@hartkopp.net>
From:   =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Message-ID: <42667b7b-59be-051b-eeca-da5b5b843221@gmx.de>
Date:   Mon, 23 Mar 2020 08:19:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fe141541-7e79-3bee-8c75-29e6f9f3bc4e@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CuOlBh7QNZHkmd1VcgRNRb0PA/i/MV1w+F3IVC2BqUu8pFxDfH5
 yqrU/03Bw7FZqPXz8MgUhV2k9EykZbALlEPFxV51GfkJSZ9w7Xy2IocET9lAm9e7XPfapU1
 q7iZBYo7eOH7y/skew921/bHukm0dZk2/IXlAZbWONEZBwmZAo8D8LZ1TrUwzWkOqpNO2Te
 Q2adruO2EiF6189x4V2Xw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pW9Vry20u4s=:kYU0Mlr9Ltqy17ibAJT2bm
 yrxHH0+CAul8iE2vID2MT2QZDaXWxtdov57CNWKIHqALLaSWb68pKAKJ6hx51WDPBtpANa6a2
 sXSTwSnkCwI9DmbS4/v7ZlyNVniGkJAm0KcV24Fk52JYmQkuakyBaQW1HOvjclF1Y7/zzjpHZ
 c1IhSU9PRy4rjFzZDOWfdDL+5IA2q+8y0tZQEnlz7lx6CxUijDWBm5i3a9woE6LxDTlX7LKns
 0t73FbJ6otdlugdh96ehDzTICI8NJoJBZO4GH3SSEMi2CPawh6nJ2VyhiDWpNzoAXmYfpVeyu
 EoCHNQ7/rsTDTHAsWyhvn+o7VUC+1ywOQtZ1IAzs0RR6UtNRn0T5E/DUKbMMrmV0OM2B2wN94
 fDh4p/UgUf4Dx/cpWPDxCLqGuw80Jzf19Cw7oiOl+EKjh3MsG90MygdqaockF0fNinD76h0Td
 eeN+bG/2EkwgWCPpwWruunxlYRM2nvxeTVmjKQGSgcBglvC55lQc/+qR3Q5ZDRipgWC8uxo+G
 3BHxldsFAqJzXS0LSBy6QBUYfxjTvAvLodkvCpkhYkmQTNy9w4d/oNFk95fyaB2GeJhRo7BX5
 63/GGTmb6BEGkly9dTnDnq5QVIoIpZG93GiBQFap7OlNjOb1WXJDrBELrVRmpIl7QNdQKh7Y2
 MK3TovKCpQUVvPgNN8D7jMf9/Zk3ZT5uGKBcNZaJysN5cInD3GXk7MKyzr5pRso4z0fLdRuRe
 39JnbNHM2jRA/WeMsgE2eMdn6D8xCyganeuoMcZfV9hcuGwMdaahCQWjyO1McapcQmKhmux6j
 m5bFcwjCB2VwBhU9+PIBdFQvb3x3J5LU+MVUbGSbCsenZhb1qNZ5P93jAJ+5zP+CgGgK7ukpC
 vsc9RMS+fTJKfdxzmnJxRk9bHZJx/Cr9fzya99TCCEeymp6wls+gNSbBqQHEOlbVPop/vM/1k
 axkTtlmOHT0QxhniDf0GipzqJQcGQQ+5HEXOZwBP0fgbWCnKT0XEEWSmflVRp8vkaGnenpkJd
 EMxLsaFgWKhjghiWfecHud1Ri04Ehxjwd2ujhZWF30jr52mXfSUlr7y65kHYFfI/VGtOk6iT6
 cOA3gVPHuIa+fPXc2MWD2oxuXrtV8dFQuZKokDG+wXkLwA/VuGrSrwOMh86lThnAZCyfNZzLN
 hMxoazbseU4niCyQZl8RG7jp9BPM6i5ic6Bisiu7idaemSRUcGyDM7fSUV9ZVxpIP5BCpYFYT
 vWc0jrQj5iy5QUagL
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks Oliver.

Reading the log it indeed seems a good idea to try a newer Kernel.

Marc, do you have any further comments?

Thanks and best regards,
Andr=C3=A9

On 21.03.20 18:04, Oliver Hartkopp wrote:
> + Marc
>
> Hi Andr=C3=A9,
>
> On 21/03/2020 16.19, Andr=C3=A9 Hartmann wrote:
>
>>> On 12/03/2020 18.43, Andr=C3=A9 Hartmann wrote:
>>>
>>>>> can someone help me interpreting the following ip output:
>
>>> The reason for the overrun error is a notification from the CAN
>>> controller itself. It tells us that the received CAN frame has not bee=
n
>>> read from the controller until the next CAN frame arrived.
>>
>> Ok, that's what I thought too, thanks for the confirmation.
>>
>>> The dropped counter usually indicates that the CAN driver did not get =
a
>>> skbuff data structure (e.g. out of memory condition).
>>>
>>> This is NOT good. What CAN hardware/setup are you using?
>>
>> Actually it's not my system. The report is from a customer doing a full
>> load test on an iMX8: https://bugreports.qt.io/browse/QTBUG-82610
>
> Thanks for the link!
>
>> I guess the customer should try a more recent Kernel than 4.14 first?
>
> The FlexCAN driver (which is used in the IMX8 AFAIK) had a remarkable
> number of changes last year:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/d=
rivers/net/can/flexcan.c
>
>
> So I would definitely suggest an update.
> I added Marc to this thread as he was very active on the FlexCAN
> improvements.
>
> Best,
> Oliver

