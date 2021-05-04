Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDB4372892
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 12:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhEDKPF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 06:15:05 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:17208 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhEDKPB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 06:15:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620123235; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dIXhGPFAgbYevOFcJxeQXqUg0XgvJUWq3uSlYANC0EydR2LXoXlJoI5pMWR+EyYKOs
    5giYZ6RF8d6n18cjjL+sr5Q7ENl0B3ZAEXTYkQd26OKcmnDmew+Rz9HlAAyQVALjSyPW
    FVes/3EZCziHIIcmOILXMMfzK8TRPj+gFxepdkcxMzoQE3nlvxoCnSYPqVS7RkO8BjzG
    RqltVBaEhDIBwcWzFFhrqjYQ6snCO2BdPHp9T4wxGyV0E1KVbMWEVsdCRXWErHl1b/vU
    Bx6OOMEd7QQcwI8RfSoD3adwE4sKihQRFB1/rzTb1Fzow5yypI0q9zK6Kn/DRcaR3YSE
    hwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620123235;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=RDwKekAImI2N7QaXSoh0/JH9x9k3fg45boMq7vdVZWQ=;
    b=RTc+HuaqW3wXa0lU7tjA/MXsRS0XGUWC5kMqnWc0MylWixbw4mTl477wbGbAJ1V7vT
    Z0rsq9N7BK3J6otOaLTLzFtCwAraCxMSFTjM/A1ASb46Z++MwbFuMZmq9xjT4wbzh4LZ
    H9INZKhlIECvQYwvPKHCxaM84EA8QLm5CQMfXcqENIJ+qB3v++jbeMM7Fq3XAfoXjrMP
    7PTfCg4rFHOWNrOqWxyUjh7ltmwj7r3EhQ0oiw2wfnORIsZezvdWZXvHqrOXbYRk36cF
    3MBgQIHFRybAZCwwnX1g33vVz5O2oYWgJ34Qw9s08HKFwNPC1pGebzVUH0P1bWBzHN8P
    Ux+g==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620123235;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=RDwKekAImI2N7QaXSoh0/JH9x9k3fg45boMq7vdVZWQ=;
    b=gnzEvSx5sBP6faPbvh1Z1hTwr0FD8TQe8ViF2ukjTnvMGOpDh+BOfewxo/Hzb9K2SS
    2aTYnHDfSy00mmYwkLDYnm8W1DCWcfhrlSZ1F8V9kURUJrce3sTC7v/BH7BP4F3HV/65
    hWpJ3PC9VzOjplV2lSa3Q7OqHSZ9uWPYjImNIv7PjI28RZBzbL6gw3hZgAhN5LhAnqPT
    MCF79FVBrrBLASAww5yHxAgucDM2IsMNYGT5QEyxCb1wRTmOad0FkbZCibIYHeQALcEX
    yNroJzeJLz7YuM7yaZMWuPq8KTc2+9zc0HCADCba2s8FLF99Ms+JHEfGEMSuo80J8ay4
    U75g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMIVsh7kyA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
    by smtp.strato.de (RZmta 47.25.6 DYNA|AUTH)
    with ESMTPSA id 40bb75x44ADs0vR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 4 May 2021 12:13:54 +0200 (CEST)
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
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <a0d3b5ed-b8c0-f521-911d-a0d4e039bb04@hartkopp.net>
Date:   Tue, 4 May 2021 12:13:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <AM8PR08MB5698052CEE5ABBD0B49D4A48B75A9@AM8PR08MB5698.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Ayoub,

On 04.05.21 11:49, Ayoub Kaanich wrote:

> There seems to be a mis-conception about how WireShark/Libpcap handle SocketCAN:
> 
> There is no ethertype involved, the data of the frame will directly start with the CAN ID.
> 
> The socket CAN in PCAP format pre-date CAN-FD (Developed in 2011), so at the time, there was only "CAN" (Introduced in Oct, 2009).
> See https://github.com/the-tcpdump-group/libpcap/commit/86ed15cc8b4bd7dc1458559108e66a07ec6721ec
> The introduction of CAN-FD later on did not change that.

Ah, now I got the problem.

I was heavily involved in introducing CAN FD into Wireshark here:

https://github.com/wireshark/wireshark/commit/7fad354a3e379382368cd1ef67b841315c29e050#diff-f0fd5f515da65110cd5c1231b43180693e1d46779765d65c997e32da11ae70d1

But this obviously had NO impact on libpcap :-/

> Libpcap library maps both LINUX_SLL_P_CAN and LINUX_SLL_P_CANFD (they are treated identically the same way) to DLT_CAN_SOCKETCAN and copy bytes as is (the only change is changing the endianness if ID if needed).

So this would mean, we need a separate handler for LINUX_SLL_P_CANFD ??

Best regards,
Oliver

> 
> The MTU solution still not does provide a fix for the case of a normal CAN message being transported over a CAN-FD bus.
> In this case, application cannot tell if frame was physically transported as CAN or CAN-FD.
> See https://noelscher.com/blog/posts/compatibility-of-can-and-can-fd/
> 
> Best Regards.
> 
> Ayoub Kaanich.
> 
> -----Original Message-----
> 
> From: mailto:socketcan@hartkopp.net
> Sent: Tuesday, May 4, 2021 10:49 AM
> To: mailto:mkl@pengutronix.de; mailto:linux-can@vger.kernel.org
> Cc: mailto:kayoub5@live.com
> Subject: Re: More flags for logging
> 
> 
> 
> On 03.05.21 12:08, Marc Kleine-Budde wrote:
>> On 03.05.2021 12:02:46, Marc Kleine-Budde wrote:
>>> The SocketCAN API is a great initiative for standardizing the CAN
>>> interface API. This request tries to extend this initiative for more
>>> use cases.
>>>
>>> Context:
>>>
>>> The SocketCAN was adopted by libpcap and tcpdump as the standard
>>> format for logging CAN Frames in PCAP and PCAP-NG. See:
>>>
>>> https://www.tcpdump.org/linktypes/LINKTYPE_CAN_SOCKETCAN.html
>>> https://github.com/wireshark/wireshark/blob/master/epan/dissectors/pa
>>> cket-socketcan.c https://www.wireshark.org/docs/dfref/c/can.html
>>>
>>> Problem:
>>> Applications that perform logging, usually need more details that
>>> normal applications, for the sake of debugging later on. Flags needs
>>> to be reserved/allocated in the SocketCAN API, so that logging
>>> applications can make use of them in the PCAP format. The flags does
>>> not need necessary need to be implemented by SocketCAN, they just
>>> need to be marked as reserved for such use case.
>>>
>>> Needed Flags:
>>> FDF Flag
>>> - Since CAN Frames and CAN-FD frames can co-exist in the same bus,
>>>      logging application needs to know if a normal CAN Frame was
>>>      transmitted on a CAN-FD bus, namely was the FDF bit set or not.
>>
>> I think someone asked for that some time ago. But that was never
>> mainlined. I'll look for that old mail.
>>
> 
> When you display CAN and CAN FD frames in Wireshark they are displayed as different "protocols" - as they also have different ethtypes.
> 
> So the difference is provided by the 'protocol' field. Or did I miss something?
> 
> Regards,
> Oliver
> 
>>> ACK bit in data frame
>>> - Some logging hardware can act as a "spy", meaning that it records
>>> CAN
>>>      Frames, but does not set the ACK bit
>>> - A way to know for a given frame (FD or not), was the ACK bit set or
>>>      not.
>>> - Current API allow detecting missing ACK, but it does not report
>>> what
>>>      Frame had a missing ACK.
>>
>> This means the driver has to set a flag if it's configured in
>> listen-only mode. That should be possible.
>>
>> I think we can make use of flags in the struct canfd_frame for this:
>>
>> | struct canfd_frame {
>> |      canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>> |      __u8    len;     /* frame payload length in byte */
>> |      __u8    flags;   /* additional flags for CAN FD */
>> |      __u8    __res0;  /* reserved / padding */
>> |      __u8    __res1;  /* reserved / padding */
>> |      __u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));  };
>>
>> The struct can_frame doesn't have the flags member yet, but we can add
>> it there.
>>
>> regards,
>> Marc
>>
> 
