Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF1E38255B
	for <lists+linux-can@lfdr.de>; Mon, 17 May 2021 09:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhEQHbJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 May 2021 03:31:09 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:15493 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhEQHbG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 May 2021 03:31:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621236582; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IfWJcdlHZSC5mFb+P0P1sF7qJ3EANgkx9ZtH9xIJWNWSE9pG7khrLNtc8yxX3C44oN
    g3gELpkNwcanEGYNw3F+el1xkAfIKJColfFA0eZtdcAXt1PTLCheQ1O962sa5aRjTJsY
    Nbt7/eyCNc38TGUAIYVJv6ptjIdq3CKWG/ny08NUL5sGg8UEv+z85PtbbWqkEEYPkMxr
    SEBipC6Vrs+wSJNwGKCX2zjFg+cwyCds0N+fjEYNtqKBZgfa5LLGF0FGD5aiyNrZcJTj
    p5JjV33hEStmeaMaRTCS/tQVD/A3UQMj+SUDNjad5z28sK8oM4zk9W51s/kXSLVfon8o
    XqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621236582;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=G76H5DGkNmj6KKmfxl83JA9mDeXvXTQ3p1bsePoz0ms=;
    b=muEz/F1K+FbcLX2U3u6Skrb52hHsct9Dv0R1zAojFzirc875l4m2sM1nbYatU4Emix
    ek82vN+L037agS+uBoAZBqa73Na+SaY6hbweN6DGzn/W1u3dHwHXYuMbrHZcIgWyfym2
    AGdnMJE8TxXpLv0Z3Zc3aLwnDmW8Tqg1oRIjEthy6bXUoqrKXQSVv6v7I8zNHAulLACn
    9Z4rSGbLueZeAJBf7+Xa4YYn/DTuTM5/w4rKl2AHULhULF18HLMJHoaVwHq1YtvgWtNk
    iv0RN+hj4M/j818/hngTdr5rRS3cjQp1YegHmutrO+kxjH6T+KQuS2bXcksyKk10LJ+a
    j/Zw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621236582;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=G76H5DGkNmj6KKmfxl83JA9mDeXvXTQ3p1bsePoz0ms=;
    b=oyH8/or/jzs1OAuwC/yALuAMtOkF950BD4XtAAcBJcKv+Ncg0nXhfzRPnfbqWdVhz0
    gMyINiv8lExePWda3wixTuXfOvZVjEH9t43pIsBFkS8kcr/FPm7yoP6589z6hG6xGzRr
    OmYj+FkQizz/YEY3zqH6fw+qvnRNq1t6p2iaURJEHYbVxxOAG6mSMdhJdZ8KXBzGAyue
    h3h47NkccZWRuaLyfHy6LkyXix5+25LXFwJDVNsSJXftWQnIBOR0f8fdePIle4QbbUi+
    ZHyCc38WbbTA0kibLKnaE3X0W0Ruff1cz9QCKAxLFZN2vWM0XFa77F8zbVN4hD02E8vn
    vNiw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVxiOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.26.0 DYNA|AUTH)
    with ESMTPSA id C056fbx4H7Tg0wn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 May 2021 09:29:42 +0200 (CEST)
Subject: Re: More flags for logging
To:     Ayoub Kaanich <kayoub5@live.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
 <641804b4-733a-57b7-fdf1-b91293207f37@hartkopp.net>
 <DBBPR03MB70824BB82F7BB335928BE36A9D2F9@DBBPR03MB7082.eurprd03.prod.outlook.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <4af4cb68-66ec-57cf-7339-8e799bd6f156@hartkopp.net>
Date:   Mon, 17 May 2021 09:29:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <DBBPR03MB70824BB82F7BB335928BE36A9D2F9@DBBPR03MB7082.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 16.05.21 01:46, Ayoub Kaanich wrote:
> Hi,
> 
> Sorry for taking so long to reply, I wanted to check the FDF topic 
> thoroughly first.
> 

No problem ;-)

> 
> The documentation of the canfd_frame states that "The use of struct 
> canfd_frame implies the Extended Data Length (EDL) bit to be set in the 
> CAN frame bitstream on the wire."

Thanks for the hint. This comment in include/uapi/linux/can.h has been 
created before the renaming that bit to FDF and needs an update.

> There have been editorial changes when the FD Frame Format was 
> introduced into ISO 11898-1,the bit EDL is now named FDF (FD Format).
> 
> See 
> https://www.can-cia.org/fileadmin/resources/documents/proceedings/2013_hartwich_v2.pdf
> 
> I believe that the fact that "EDL" and "FDF" are the same thing should 
> be clarified to avoid future confusion.

I was personally involved in CAN FD standardization and suggested the 
renaming, as "extended data length" (EDL) did not completely catch the 
CAN FD features. This renaming EDL -> FDF is a replacement for 
clarification. No confusion here :-)

> According to 
> https://www.kernel.org/doc/html/latest/networking/can.html#raw-socket-option-can-raw-fd-frames
> 
> When performing a read operation on a socket that had CAN_RAW_FD_FRAMES 
> enabled, both CAN_MTU and CANFD_MTU are allowed.
> 
> I originally though that only one of them is allowed at a time, that was 
> a mistake from my side.

You might want to take a look into this slide deck (slide 48ff):

https://wiki.automotivelinux.org/_media/agl-distro/agl2017-socketcan-print.pdf

> So using MTU will work for FD, but will definitely be a problem in the 
> future with CAN XL due to its large size (more than 2KB)

Yes. But we should then thing about CAN_RAW_XL_FRAMES in the same manner.

> The last question would be, would libpcap keep the extra padding bytes 
> in, or remove them.
> 
> Since the document in 
> https://www.tcpdump.org/linktypes/LINKTYPE_CAN_SOCKETCAN.html is not 
> conclusive about the topic (the diagram makes it look like it's truncated)
> 
> I will have to check on an actual system during the work days, and push 
> a PR to tcpdump if it turns out it's just the diagram that was misleading.

In fact this documentation is outdated as we updated the struct 
can_frame for the 'Classical CAN' (not CAN FD) to contain a raw data 
length code (DLC) value in the formerly reserved space:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=ea7800565a128c1adafa1791ce80afd6016fe21c

Btw. I would still be interested to get the CANFD_FDF reservation for 
user space application programmers into Mainline:

https://lore.kernel.org/linux-can/20170411134343.3089-1-socketcan@hartkopp.net/

So let's see whether Marc can be excited on this patch ;-)

Best regards,
Oliver


> 
> 
> Best Regards.
> 
> 
> On 2021-05-04 10:49 AM, Oliver Hartkopp wrote:
>>
>>
>> On 03.05.21 12:08, Marc Kleine-Budde wrote:
>>> On 03.05.2021 12:02:46, Marc Kleine-Budde wrote:
>>>> The SocketCAN API is a great initiative for standardizing the CAN
>>>> interface API. This request tries to extend this initiative for more 
>>>> use
>>>> cases.
>>>>
>>>> Context:
>>>>
>>>> The SocketCAN was adopted by libpcap and tcpdump as the standard format
>>>> for logging CAN Frames in PCAP and PCAP-NG. See:
>>>>
>>>> https://www.tcpdump.org/linktypes/LINKTYPE_CAN_SOCKETCAN.html
>>>> https://github.com/wireshark/wireshark/blob/master/epan/dissectors/packet-socketcan.c 
>>>>
>>>> https://www.wireshark.org/docs/dfref/c/can.html
>>>>
>>>> Problem:
>>>> Applications that perform logging, usually need more details that 
>>>> normal
>>>> applications, for the sake of debugging later on. Flags needs to be
>>>> reserved/allocated in the SocketCAN API, so that logging applications
>>>> can make use of them in the PCAP format. The flags does not need
>>>> necessary need to be implemented by SocketCAN, they just need to be
>>>> marked as reserved for such use case.
>>>>
>>>> Needed Flags:
>>>> FDF Flag
>>>> - Since CAN Frames and CAN-FD frames can co-exist in the same bus,
>>>>    logging application needs to know if a normal CAN Frame was
>>>>    transmitted on a CAN-FD bus, namely was the FDF bit set or not.
>>>
>>> I think someone asked for that some time ago. But that was never
>>> mainlined. I'll look for that old mail.
>>>
>>
>> When you display CAN and CAN FD frames in Wireshark they are displayed 
>> as different "protocols" - as they also have different ethtypes.
>>
>> So the difference is provided by the 'protocol' field. Or did I miss 
>> something?
>>
>> Regards,
>> Oliver
>>
>>>> ACK bit in data frame
>>>> - Some logging hardware can act as a "spy", meaning that it records CAN
>>>>    Frames, but does not set the ACK bit
>>>> - A way to know for a given frame (FD or not), was the ACK bit set or
>>>>    not.
>>>> - Current API allow detecting missing ACK, but it does not report what
>>>>    Frame had a missing ACK.
>>>
>>> This means the driver has to set a flag if it's configured in
>>> listen-only mode. That should be possible.
>>>
>>> I think we can make use of flags in the struct canfd_frame for this:
>>>
>>> | struct canfd_frame {
>>> |     canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>>> |     __u8    len;     /* frame payload length in byte */
>>> |     __u8    flags;   /* additional flags for CAN FD */
>>> |     __u8    __res0;  /* reserved / padding */
>>> |     __u8    __res1;  /* reserved / padding */
>>> |     __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
>>> | };
>>>
>>> The struct can_frame doesn't have the flags member yet, but we can add
>>> it there.
>>>
>>> regards,
>>> Marc
>>>
