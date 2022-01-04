Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100CA4841B1
	for <lists+linux-can@lfdr.de>; Tue,  4 Jan 2022 13:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiADMh4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Jan 2022 07:37:56 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:22098 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiADMhz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Jan 2022 07:37:55 -0500
X-Greylist: delayed 68224 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 07:37:55 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641299873;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=kowAl4l6qSQP3J49nSbfFzFFQ6Vtn2AdsSvIV3Ul8B0=;
    b=BlUEA9vW0sdsSB3g9esWeBEpia9lUzt2dpkRrA4qYscKeIhZnoNMdwckEtWImIAF2/
    y8ONvxUK5w9Vk3ssnYo09tk3Pyl50E9gIGd4Wz4fMiQkdmvrD0dmTbKIBd1ZhN+DhByg
    z9TNsI9WxaLjfXVTliy7Ydu/SGCdiXbhW16NboF7n6aKDBye2UkaWnCKS2HyeU71X6II
    JpyU37UU8ttL21Svxoe8P4gK7nHEIFj+mJ9u6MBIqWZlc2Hn/RPpihv7v/0Cp2+0BFh6
    UUmnfb7RfXc2jXBYV7vh6ZIkIBHPH5Ouhq+YHN68xCaRhOs44G1FomeN3IJzO2NpzTIl
    f1IQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.35.3 AUTH)
    with ESMTPSA id k081c3y04Cbrvqe
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 4 Jan 2022 13:37:53 +0100 (CET)
Subject: Re: can-isotp: TX stmin violations
To:     Patrick Menschel <menschel.p@posteo.de>,
        =?UTF-8?Q?Maik_Allg=c3=b6wer?= <maik@llgoewer.de>
Cc:     linux-can@vger.kernel.org
References: <20220103155254.3htprmrdjur3ke3l@ganymed>
 <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>
 <27389f5f-1681-7440-15bd-3c67e4e5daa9@posteo.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <c20468e2-0f9f-bcca-da0f-f3f6470d91be@hartkopp.net>
Date:   Tue, 4 Jan 2022 13:37:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <27389f5f-1681-7440-15bd-3c67e4e5daa9@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Patrick,

On 04.01.22 13:06, Patrick Menschel wrote:
> Am 03.01.22 um 18:40 schrieb Oliver Hartkopp:
>>> In this example CF#2 is delayed by .5 ms on the wire while CF#3 is
>>> sent .5 ms too early
>>> when I look at the delta between CF#2 and CF#3 .
>>>
>>> To me it seems that, while the messages are put into some tx-queue at the
>>> correct time, they are not actually put on the wire at that exact time
>>> leading to CF#3
>>> being put on the wire too early.
>>
>> Yes. The CAN frames are sent with a 'minimum' gap which is defined with
>> STmin, see isotp_tx_timer_handler().
>>
>> Generally the handling and the sending of the frame is processed - and
>> *then* the offset gap of the current time is added. In your case it
>> should always be *slightly more* than 2ms, which is fine from the STmin
>> specification intention.
> 
> Hi,
> 
> actually spec says *average* gap time should not fall below STMIN.

I did not see this average gap recommendation so far.

Only:

9.6.5.4
SeparationTime minimum (STmin) parameter definition

The ST min parameter shall be encoded in byte #3 of the FC N_PCI.

This time is specified by the receiving entity. The STmin parameter 
value specifies the minimum time
gap allowed between the transmissions of two ConsecutiveFrame network 
protocol data units (CFs).

The term "average" can not be found in the entire ISO15765-2-2016 
specification ...

> 
> That .5 is actually not bad at all.
> I have seen some autosar manufacturers stretching the spec up to the
> point where you request stmin=5 and get st=10 by design.
> 

Best regards,
Oliver
