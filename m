Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A6D296356
	for <lists+linux-can@lfdr.de>; Thu, 22 Oct 2020 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898688AbgJVRHI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Oct 2020 13:07:08 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:8135 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898691AbgJVRHI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Oct 2020 13:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603386420;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=NN+d3Kv/EDsvALztMTfOzD1gbBV7FOzVKJ7Rh0j9xKg=;
        b=MU8uXZGaE90TF45TvsZxlo/fGp+Mz+QDJDzxP98VJwwHLbXgLJo1nuHuBkNH0CsAWb
        cE0EqmpSlomCi7w8i5kSRamsT4VUthT9GJZPwPjA/a3/6EXgA7uyP9Oh36+kgMGx24/6
        aWjPAT17H5dnuldh7EyBbpAbYhO+l/3011rVdieIsrRX9BYID7DEmiS+hFJ04rUaP7DT
        erTbPUJ1V6LMzN9TzQQndwkFGkMZOwDHUTQV3oT8CoPstEx8X3qDu6qjwttRfNKJ80YG
        VKTTAO8kMplokeVBS7qUuVeqXfGObEHlUy3dN1F1Kesoib+rqpcQwI8/rwZuwqOa3o64
        oRgw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8Rrpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9MH6ww0F
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 22 Oct 2020 19:06:58 +0200 (CEST)
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net>
 <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
 <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net>
 <20201020160739.104686-1-mailhol.vincent@wanadoo.fr>
 <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
 <20201021005226.2727-1-mailhol.vincent@wanadoo.fr>
 <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
 <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net>
 <CAMZ6RqK2RCGLFmjiHTQAxZSGn-HQaAh_nHHGwKdODanZK5oJbg@mail.gmail.com>
 <727e4845-63bd-659b-5344-97eb54121624@hartkopp.net>
 <CAMZ6RqJ8=T8CAhYaa8PZs5-d2zhx1_15wMe7ohUZovvqTcgW0w@mail.gmail.com>
 <0087f8a4-c77c-cc13-b17d-bd9666837ee3@hartkopp.net>
 <CAMZ6Rq+nHk1ZNzAGbwetEBULq8u_rsUYCd7FYj2HcQ-ejNC+Tw@mail.gmail.com>
 <d3dda30a-3f22-4824-71be-f8520b3714b2@hartkopp.net>
 <CAMZ6RqJrpwOkFPNDNdUU=g=p_VwuPW5erGfj-bk0quKQYsCcXQ@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <adabe4ca-7065-0aa7-7654-51f77d9b2916@hartkopp.net>
Date:   Thu, 22 Oct 2020 19:06:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqJrpwOkFPNDNdUU=g=p_VwuPW5erGfj-bk0quKQYsCcXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 22.10.20 17:46, Vincent MAILHOL wrote:
> On 22.10.20 22:28, Oliver Hartkopp wrote:
>> On 22.10.20 14:23, Vincent MAILHOL wrote:

>>>> The above pseudo code together with CAN_CTRLMODE_RAW_DLC seems to be a
>>>> pretty safe option to me. Even if 'legacy' applications with
>>>> uninitialized raw_dlc send CAN frames or AF_PACKET users enable
>>>> CAN_CTRLMODE_RAW_DLC we always end up with a proper can_dlc == 8  and a
>>>> fitting valid raw_dlc.
>>>
>>> But what if that "fitting valid raw_dlc" is greater than 8?
>>
>> This is the plan!
>>
>>> The kernel
>>
>> the CAN driver
>>
>>> would see that frame as valid, a frame with a DLC greater than 8 will
>>> be sent on the wire and received by the other devices than might be
>>> connected on the CAN bus.
>>
>> Exactly.
> 
> And this is my point. The legacy application intended to send a frame
> of 8 bytes with a DLC of 8 but on the wire, there is a frame of 8
> bytes with a DLC greater than 8. The other devices on the CAN bus
> might ignore it (if the device has a DLC filter) or might crash if
> there is a vulnerability in DLC handling.

But this is your intention, right?

You wanted to test this behaviour. This is no normal operation - it's a 
*test* mode to detect said vulnerabilities in DLC handling.

And what do you mean with "if the device has a DLC filter"?

You told me the DLCs from 9..15 are correct from the ISO standpoint. 
That a good programmer checks the DLC and makes sure he only processes 
max. 8 bytes is a common thing and no 'filtering'.

You might introduce CAN_RAW_RAW_DLC sockopt for CAN_RAW sockets but when 
you use packet sockets e.g. with Wireshark and forge some CAN frames 
there your only chance to have proper 0..8 DLCs is to disable 
CAN_CTRLMODE_RAW_DLC.

Btw. do you really see any legacy SocketCAN applications (*together* 
with your testing application on the same Linux host) where you don't 
have the source code to check whether they properly initialize the 
reserved/padding bytes?

You can also use the can-gw to let 'malicious' CAN apps run on a private 
virtual CAN. Forwarded modified CAN frames definitely initialize the 
reserved/padding bytes.

>>> Basically, that would replace the use of the can_len2dlc() function.
>>>
>>> I also think it should be extended to CAN-FD, but no need to elaborate
>>> more on this at the moment: let's keep the discussion focused on
>>> classical CAN and tackle this later.
>>
>> Why do you want this?
>>
>> You get of the bike and push your bicycle for what reason?
>>
>> No.
> 
> Pushing the bike: yes, that was actually my motivation. One more time,
> I am not telling you are wrong, just that I would do it in a different
> way. I explained my view and you read it. I do not have more arguments
> to bring.

/me either ...

https://youtu.be/aKnX5wci404?t=34

>>>> Ok, let me rephrase: Filling can_dlc with something else than a plain
>>>> length information 0..8 ;-)
>>>
>>> Got it :-)
>>>
>>>   From my preliminary study, not so much changes or sanity check would
>>> need to be added:
>>>
>>>     1. The current can_dlc sanity checks in can_send() and can_rcv() in
>>>        net/can/af_can.c definitely needs to be adjusted (but this would
>>>        also be the case for the raw_dlc field solution).
>>>
>>>     2. In the kernel Rx and Tx paths: the length should not be accessed
>>>        directly anymore but through a getter function.
>>>
>>>     3. In the kernel: drivers "DLC aware" need to adapt their code and
>>>        use the length getter function.
>>>
>>>     4. In user land: new "DLC aware" code should always use struct
>>>        can_frame for classical CAN and check whether can_dlc is greater
>>>        that CAN_MAX_DLEN before accessing data.
>>>
>>> That's mostly all that would have to be adjusted.
>>>
>>
>> No, it is not.
>> You have to go through all protocols, e.g. raw.c, bcm.c, gw.c, j1939,
>> isotp.c which get a skb to be (sometimes) cloned by them. And when they
>> need to modify the can_dlc value to send it to the userspace or
>> whatever, you need to modify skb->data - and then you can't clone it
>> anymore but need to skbcopy() them.
>> HERE you will get a really big effort. Occasionally I was also thinking
>> using can_dlc would be nice but then I looked into above code and your
>> use-case does not justify that effort/ risk and performance impact.
> 
> I naively thought this part would not get impacted. I have yet to
> understand the full impact in detail but you made your point clear.
> 
> You won :-)
> Sorry for the long exchange and thank you for your patience.

I really don't want to 'win'. But by the time the features and 
functionalities have been grown and many people rely on its 
functionality and performance.

The discussion helps to find the hopefully best solution and brings all 
of us to new insights.

The difference is to make a new door into a house or to replace its 
entire water system. You need a VERY good reason to replace the water 
system ... when you want a new door.

>>>> The approach with CAN_CTRLMODE_RAW_DLC and the described testing would
>>>> be even robust against unintended miss-use.
>>>
>>> Exception: can_dlc == 8 and a non-initialed raw_dlc gets a garbage
>>> value between 9 and 15 from the stack (c.f. above comment).
>>
>> Right, and what would be the effect of this?
>>
>> You know the answer: Nothing breaks.
> 
> A frame of 8 bytes and DLC between 9 and 15 is sent on the wire and
> this has the potential to crash the other devices on the bus as
> explained in my initial e-mails.

Yes. But that is what you wanted to archive when you enable 
CAN_CTRLMODE_RAW_DLC ¯\_(ツ)_/¯
(see my comment above)

Regards,
Oliver
