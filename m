Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B352372C41
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 16:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhEDOmL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 10:42:11 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:19958 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhEDOmL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 10:42:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620139093; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ExZW4I6enIkWSwtl8eTTT57Vnu2t5Inaz0RyNs/+PoHOpOqbHRGXmXU9R6AIlKvqDU
    PF+hecAuX/JHJX+5CAe3MPYtZSEhf/MkRhWaH+EKkK00HC7ztiDwVXXzwgjXjaCfRzlR
    kz3W3uXTMx88zFwfkvih9z65boapgus4/o1H9J/2HvAgnflIjzg1KbfFSsythqoFASCB
    LwzXR064dfcPfo5jWofiRtubToWfmmuxBFvotX1ys+jQjIV4TPNlOi8WS5DPAvmo116w
    b9HzFVkcOpZULeqeISKbZbiQJAk7gtUQTNaeFvsTmUKnbeEWUoXfcHD3gD1rThOxcj57
    /EBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620139093;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=3Mp36IuwsQ6kFjXLqZvOw+qKg4K9L6hdI7Dzy9ULXVI=;
    b=JZY3SgZlF1Jw3LIF/g8EBJnlkqzKyUqZg8oCJ4bAlnG6uX6h0fRZbpwTsGnuaO4pot
    HaGB6CfHAjyjZ7fHq+i0d1ng+7ZA1G5sTS2aJ/r6FQjWvgqXfQb2xhBBxxlzExpROSoH
    6yKKW7SmNwLGyo5OKivTnX29AeOGjNUm1cOq894CIeHtQTrvyUfOWneKrBOzrQplbA/u
    tnJ7C1DbG5Cx4wxRjIycQDY/CtmOc5FbQasmdP8bHDUUUk9fMmTHhxzg8f0Lg6aZRvfq
    rPS8CB855LDAIGvz1oHcmSFd9mUwMQvV/V3TPhyJu3cGHvhKwDFTbl8GefSFuv70IVlB
    oK4A==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620139093;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=3Mp36IuwsQ6kFjXLqZvOw+qKg4K9L6hdI7Dzy9ULXVI=;
    b=sfJ7bU6ICuXZd2BtjCtysJefGwcS0MrDMcsAtm62MOPmoIYeZe4p5R1bZxB0vEaPJG
    PiysqLpr5xnvCKy4Xo1S+bi5FDuly8QKvi+sY178j5+SCrw2KXKF0K/Vm41T0CLz/TGz
    GX6FmCGK0ieAHHv/QhDDKBvW9kyitrF1P0ALoyNsEezgJczWxDqoJ84PBn83CuNTDXLx
    KCmaI0J1uWzEJkoXY72U1krMTDKtzH0fy6lRayKHt+zY6hieCrPm4lqjSdll6bf+FuhX
    3K5Ae3sfVpQ2tuWF6TiWFI9hUekloOgD8TRUXK8UEmi15zjplq68nhzsbJkma4w2Lo4P
    J8yw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMIVsh7kyA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
    by smtp.strato.de (RZmta 47.25.6 DYNA|AUTH)
    with ESMTPSA id 40bb75x44EcD21L
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 4 May 2021 16:38:13 +0200 (CEST)
Subject: Re: More flags for logging
To:     Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
 <641804b4-733a-57b7-fdf1-b91293207f37@hartkopp.net>
 <DBBPR03MB7082C7E8FD22D0CA8C2DA99D9D5A9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <AM8PR08MB5698886555F8531B6CF65982B75A9@AM8PR08MB5698.eurprd08.prod.outlook.com>
 <AM8PR08MB5698052CEE5ABBD0B49D4A48B75A9@AM8PR08MB5698.eurprd08.prod.outlook.com>
 <a0d3b5ed-b8c0-f521-911d-a0d4e039bb04@hartkopp.net>
 <AM8PR08MB5698056272C3800B6BDCAE54B75A9@AM8PR08MB5698.eurprd08.prod.outlook.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <60f13f69-095e-ee5b-d143-6d04d5a85795@hartkopp.net>
Date:   Tue, 4 May 2021 16:38:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <AM8PR08MB5698056272C3800B6BDCAE54B75A9@AM8PR08MB5698.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 04.05.21 15:58, Ayoub Kaanich wrote:

> One solution is to mark a flag bit as 1/0 depending whether the frame was received using LINUX_SLL_P_CAN or LINUX_SLL_P_CANFD.
> 
> This may solve 90% of the cases, but I don't think it's the solution we want to go with, since it does not cover classical CAN over CAN-FD transmission.
> See
> https://www.can-cia.org/fileadmin/resources/documents/proceedings/2015_esparza.pdf
> https://can-newsletter.org/uploads/media/raw/35a48f1d88ddf2a198638c0a5be51761.pdf

A CAN segment can transfer CAN and CAN FD frames when all the nodes are 
capable to cope with CAN FD frames (having the former reserved FDF bit a 
recessive '1' value).

I don't see any problem here ... CAN frames and CAN FD can co-exist an 
use LINUX_SLL_P_CAN or LINUX_SLL_P_CANFD.

> I believe it would be better to have an FDF bit in the SocketCAN flags, that maps to (for example) MCP251XFD_OBJ_FLAGS_FDF

In fact I already posted a patch for that priblem in 2017:

https://lore.kernel.org/linux-can/20170411134343.3089-1-socketcan@hartkopp.net/

I had a similar idea behind it ;-)

Best regards,
Oliver

> 
> -----Original Message-----
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> Sent: Tuesday, May 4, 2021 12:14 PM
> To: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>; mkl@pengutronix.de; linux-can@vger.kernel.org
> Subject: Re: More flags for logging
> 
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> Hi Ayoub,
> 
> On 04.05.21 11:49, Ayoub Kaanich wrote:
> 
>> There seems to be a mis-conception about how WireShark/Libpcap handle SocketCAN:
>>
>> There is no ethertype involved, the data of the frame will directly start with the CAN ID.
>>
>> The socket CAN in PCAP format pre-date CAN-FD (Developed in 2011), so at the time, there was only "CAN" (Introduced in Oct, 2009).
>> See
>> https://github.com/the-tcpdump-group/libpcap/commit/86ed15cc8b4bd7dc14
>> 58559108e66a07ec6721ec The introduction of CAN-FD later on did not
>> change that.
> 
> Ah, now I got the problem.
> 
> I was heavily involved in introducing CAN FD into Wireshark here:
> 
> https://github.com/wireshark/wireshark/commit/7fad354a3e379382368cd1ef67b841315c29e050#diff-f0fd5f515da65110cd5c1231b43180693e1d46779765d65c997e32da11ae70d1
> 
> But this obviously had NO impact on libpcap :-/
> 
>> Libpcap library maps both LINUX_SLL_P_CAN and LINUX_SLL_P_CANFD (they are treated identically the same way) to DLT_CAN_SOCKETCAN and copy bytes as is (the only change is changing the endianness if ID if needed).
> 
> So this would mean, we need a separate handler for LINUX_SLL_P_CANFD ??
> 
> Best regards,
> Oliver
> 
>>
>> The MTU solution still not does provide a fix for the case of a normal CAN message being transported over a CAN-FD bus.
>> In this case, application cannot tell if frame was physically transported as CAN or CAN-FD.
>> See https://noelscher.com/blog/posts/compatibility-of-can-and-can-fd/
>>
>> Best Regards.
>>
>> Ayoub Kaanich.
>>
>> -----Original Message-----
>>
>> From: mailto:socketcan@hartkopp.net
>> Sent: Tuesday, May 4, 2021 10:49 AM
>> To: mailto:mkl@pengutronix.de; mailto:linux-can@vger.kernel.org
>> Cc: mailto:kayoub5@live.com
>> Subject: Re: More flags for logging
>>
>>
>>
>> On 03.05.21 12:08, Marc Kleine-Budde wrote:
>>> On 03.05.2021 12:02:46, Marc Kleine-Budde wrote:
>>>> The SocketCAN API is a great initiative for standardizing the CAN
>>>> interface API. This request tries to extend this initiative for more
>>>> use cases.
>>>>
>>>> Context:
>>>>
>>>> The SocketCAN was adopted by libpcap and tcpdump as the standard
>>>> format for logging CAN Frames in PCAP and PCAP-NG. See:
>>>>
>>>> https://www.tcpdump.org/linktypes/LINKTYPE_CAN_SOCKETCAN.html
>>>> https://github.com/wireshark/wireshark/blob/master/epan/dissectors/p
>>>> a cket-socketcan.c https://www.wireshark.org/docs/dfref/c/can.html
>>>>
>>>> Problem:
>>>> Applications that perform logging, usually need more details that
>>>> normal applications, for the sake of debugging later on. Flags needs
>>>> to be reserved/allocated in the SocketCAN API, so that logging
>>>> applications can make use of them in the PCAP format. The flags does
>>>> not need necessary need to be implemented by SocketCAN, they just
>>>> need to be marked as reserved for such use case.
>>>>
>>>> Needed Flags:
>>>> FDF Flag
>>>> - Since CAN Frames and CAN-FD frames can co-exist in the same bus,
>>>>       logging application needs to know if a normal CAN Frame was
>>>>       transmitted on a CAN-FD bus, namely was the FDF bit set or not.
>>>
>>> I think someone asked for that some time ago. But that was never
>>> mainlined. I'll look for that old mail.
>>>
>>
>> When you display CAN and CAN FD frames in Wireshark they are displayed as different "protocols" - as they also have different ethtypes.
>>
>> So the difference is provided by the 'protocol' field. Or did I miss something?
>>
>> Regards,
>> Oliver
>>
>>>> ACK bit in data frame
>>>> - Some logging hardware can act as a "spy", meaning that it records
>>>> CAN
>>>>       Frames, but does not set the ACK bit
>>>> - A way to know for a given frame (FD or not), was the ACK bit set or
>>>>       not.
>>>> - Current API allow detecting missing ACK, but it does not report
>>>> what
>>>>       Frame had a missing ACK.
>>>
>>> This means the driver has to set a flag if it's configured in
>>> listen-only mode. That should be possible.
>>>
>>> I think we can make use of flags in the struct canfd_frame for this:
>>>
>>> | struct canfd_frame {
>>> |      canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>>> |      __u8    len;     /* frame payload length in byte */
>>> |      __u8    flags;   /* additional flags for CAN FD */
>>> |      __u8    __res0;  /* reserved / padding */
>>> |      __u8    __res1;  /* reserved / padding */
>>> |      __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));  };
>>>
>>> The struct can_frame doesn't have the flags member yet, but we can
>>> add it there.
>>>
>>> regards,
>>> Marc
>>>
>>
