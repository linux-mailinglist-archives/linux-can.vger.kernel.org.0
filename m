Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD94293BDE
	for <lists+linux-can@lfdr.de>; Tue, 20 Oct 2020 14:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406208AbgJTMiX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Oct 2020 08:38:23 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:21036 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406115AbgJTMiW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Oct 2020 08:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603197495;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+8wMNFg6oOyFcN1aZX1xslh+bIZPBYuHBdkX/Y8UK8w=;
        b=hbJ0JDyriequv/wJjEhKEPBY33F4/TcMNRKu+MXM7LQc6O4zPvge+TA3eBpwOimD2Q
        wceiYiQAWEucDHEk3PS/wsyMuNjOyYfnIu+F0mBHFoG6B0zla9ZkUoxCmdcmQTNIMtPq
        JYN8cjkCRaFZVbXa+E67KX9DokH6AV6rhUboN/Xm1Np7hFbqj6gBySDNDBRRbyqag1lg
        kWGFFgMxmXG54yejSQ9JhFMTQA3Bhwnm/GESh4F+931hh2leLggnmI/PhhBh41QOx0kr
        eFAMr7AWE+2bq5rTv4YHKYh9z5uwj/CIWUk+1GuItZYKFtb/ZVAwjQ0MeVc93zfT6lsH
        67rg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR/J89rw10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9KCcFnQ7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 20 Oct 2020 14:38:15 +0200 (CEST)
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20201019190524.1285319-1-mkl@pengutronix.de>
 <20201019190524.1285319-5-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net>
 <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net>
Date:   Tue, 20 Oct 2020 14:38:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 20.10.20 13:30, Vincent Mailhol wrote:
>> On 19.10.20 21:05, Marc Kleine-Budde wrote:
>>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>>
>>> In classical CAN, the length of the data (i.e. CAN payload) is not
>>> always equal to the DLC! If the frame is a Remote Transmission Request
>>> (RTR), data length is always zero regardless of DLC value and else, if
>>> the DLC is greater than 8, the length is 8. Contrary to common belief,
>>> ISO 11898-1 Chapter 8.4.2.3 (DLC field) do allow DLCs greater than 8
>>> for Classical Frames and specifies that those DLCs shall indicate that
>>> the data field is 8 bytes long.
>>>
>>> Above facts are widely unknown and so many developpers uses the "len"
>>> field of "struct canfd_frame" to get the length of classical CAN
>>> frames: this is incorrect!

No it is not. This is intentional.

When implementing the CAN FD support we mainly fixed the problem that 
the DLC (data length *CODE*) and the plain data length have often been 
used as a synonym by the programmers.

As the can_dlc value inside the Linux world is always 0..8 it was in 
fact always a 'length in byte' value. And it was safe to use it in this way.

When CAN FD showed up we decided NOT to provide the DLC value but a 
nominal 'len' value 0..64 which allows to maintain the existing access 
patterns (e.g. with a for() statement).

See:

https://wiki.automotivelinux.org/_media/agl-distro/agl2017-socketcan-print.pdf

page 56ff

>>>
>>> This patch introduces function get_can_len() which can be used in
>>> remediation. The function takes the SKB as an input in order to be
>>> able to determine if the frame is classical or FD.
>>>
>>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>> Link: https://lore.kernel.org/r/20201002154219.4887-4-mailhol.vincent@wanadoo.fr
>>> [mkl: renamed get_can_len() -> can_get_len()]
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>>    include/linux/can/dev.h | 23 +++++++++++++++++++++++
>>>    1 file changed, 23 insertions(+)
>>>
>>> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
>>> index 41ff31795320..2bb132fc6d88 100644
>>> --- a/include/linux/can/dev.h
>>> +++ b/include/linux/can/dev.h
>>> @@ -192,6 +192,29 @@ u8 can_dlc2len(u8 can_dlc);
>>>    /* map the sanitized data length to an appropriate data length code */
>>>    u8 can_len2dlc(u8 len);
>>>    
>>> +/*
>>> + * can_get_len(skb) - get the length of the CAN payload.
>>> + *
>>> + * In classical CAN, the length of the data (i.e. CAN payload) is not
>>> + * always equal to the DLC! If the frame is a Remote Transmission
>>> + * Request (RTR), data length is always zero regardless of DLC value
>>> + * and else, if the DLC is greater than 8, the length is 8. Contrary
>>> + * to common belief, ISO 11898-1 Chapter 8.4.2.3 (DLC field) do allow
>>> + * DLCs greater than 8 for Classical Frames and specifies that those
>>> + * DLCs shall indicate that the data field is 8 bytes long.
>>> + */
>>> +static inline u8 can_get_len(const struct sk_buff *skb)
>>> +{
>>> +     const struct canfd_frame *cf = (const struct canfd_frame *)skb->data;
>>> +
>>> +     if (can_is_canfd_skb(skb))
>>> +             return min_t(u8, cf->len, CANFD_MAX_DLEN);
>>> +     else if (cf->can_id & CAN_RTR_FLAG)
>>> +             return 0;
>>> +     else
>>> +             return min_t(u8, cf->len, CAN_MAX_DLEN);
>>> +}
>>
>> The main idea behind this patch and patch 05/16 is to provide a correct
>> statistic in the tx bytes, right?
>>
>> A simple test for the CAN_RTR_FLAG will do the job as all the length
>> sanitizing is already done in the tx path by can_dropped_invalid_skb()
>> in all known drivers right *before* the skb is stored in the echo skb array.
>>
>> IMO there's no need for a separate helper function. Maybe a macro which
>> should have something with 'payload' in its name - to determine the tx
>> byte statistics based on CAN_RTR_FLAG ...
> 
> Actually, the main idea is not only to provide a valid length for the
> tx statistics.
> 
> First fact is that many of the drivers (if not all?) will have the
> same issue for the rx statistics as well, so this helper function can
> be beneficial in other locations as well but that is not yet the main
> point.

Many drivers do not use the the return value of can_get_echo_skb() - and 
yes, THAT should be fixed.


> What bugs me the most, is that there is a global misunderstanding of
> the definition of the Classical CAN frame's DLC in the kernel.

No it is not (as described above).

There is a clear separation that the DLC is only available in the driver 
for putting the DLC into the CAN controller and retrieving it from there.

Everything else (starting from the skb content) is a plain length 
information.

> ISO 11898-1:2015 tells us in section 8.4.2.4 "DLC field" that, I
> quote: "[...]  *This DLC shall consist of 4 bit*. The admissible
> number of data bytes for Classical Frames shall range from 0 to
> 8. DLCs in the range of 0 to 7 shall indicate data fields of length of
> 0 byte to 7 byte. In Classical Frames, *all other DLCs shall indicate
> that the data field is 8 bytes long*. [...]"
> 
> So the DLC is a 4 bits value (meaning from 0 to 15) and all values
> from 8 to 15 designate a data length of 8.
> 
> The real idea is to have an ISO 11898-1 compliant function to retrieve
> the length.

This is done on driver level using several helper functions like:

https://elixir.bootlin.com/linux/latest/source/include/linux/can/dev.h#L92

get_can_dlc()
get_canfd_dlc()

and conversions like

https://elixir.bootlin.com/linux/latest/source/include/linux/can/dev.h#L174

can_dlc2len()
can_len2dlc()


> 
> That said, I hear your comment that the DLC is sanitized in
> can_dropped_invalid_skb(). However, what bothers me is that this
> sanitazation is done on false assumptions: Classical frames with DLC
> greater than 8 and lower or equal to 15, which are valid by the
> standard, are being discarded.

Yes. But we don't talk about a DLC value here. We talk about a plain 
length value.

> To give you the full picture, I plan to send a RFC to fix this DLC
> issue to allow Classical CAN frame with DLCs between 9 and 15 to be
> sent and received in Socket CAN.

Ehm - no. This is a pointless feature to allow values that have no 
effect and might only happen on the wire (not even on the CAN controller 
register level).

The standard only defined how the CAN controller should react when it 
gets these out-of-range values from the wire. The values 9 - 15 are not 
distinguishable. Everything means 8.

>  This can_get_len() function is one
> piece of it, however, because I also found the bad RTR length issue, I
> thought to introduce this one in advance. Sorry for the lack of
> context.
> 
> The RFC I am thinking of will not be trivial. The main reason is that
> the macro CAN_MAX_DLC which is incorrectly set to 8 instead of 15 is
> exposed to the user land in include/linux/can.h. Modifying it would be
> a no-go because we do not want to break user space. The direction
> would be to have a socket option to set the maximum DLC to 15 on
> demand and to keep it to 8 by default (this way, niche users who needs
> this can do so but other people are not impacted).
> 
> One question you might ask is: "why should be allow DLC greater than
> 8?". One concrete use case is security testing. In order to check for
> vulnerabilities, we want to send such frames for test coverage
> (especially during fuzz testing). Aside of that I do not know other
> use cases. I am not aware of any OEM that would use this in production
> but I still want to push to have this option in the kernel just for
> the security testing reason.

??? Sorry but no.

You can create a DLC of 13 for Classical CAN. And your CAN controller 
gets 8 bytes from it and says to the network layer: Here is a CAN frame 
with 8 bytes payload.

Have you ever read out a CAN controller register and found a value 
greater than 8 on the register of the DLC value?

I believe you didn't. The CAN controller sees the DLC but provides 8 
bytes as DLC=8.

> I hope that you now understand the full idea behind this patch. If you
> agree with my comments, please reconsider adding that patch.

I don't believe it would be a good idea.

> If I
> failed to convince you and if you prefer to first see the full
> picture, then I am OK to go with the simple test for the CAN_RTR_FLAG
> as you suggested in your other patch and will come back to you later
> on the MAX DLC topic when ready.

I hope I was able to convince you :-)

> Thanks for reading me until the end!

I did my very best.

Best regards,
Oliver
