Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE55372790
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 10:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEDIuu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 04:50:50 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:18720 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhEDIus (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 04:50:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620118165; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pDVhNlhK9lX7xLpk7m50KOrehxBVza31cvCsKXYHzKUNH9H4nVkL336Rjyr3dQV2Zo
    xR/y6rgO9YhfO3xGpzMzBN1v4+t0YL8qpt6ukciSTMi1OSQC2BL4ewYhr/eiV8JiouHA
    VtFAU8FYPB+4ik72RK60x3cPaMz0TN0Tt81v2wUKWynBWfJRKJ0Cxc3MVwlfnbB2vsyq
    5SWLr095hirpv+VWSdMMt7ysmwCuXHMfyFtkLryxF5Bf1u8S0yU9D4w4Jz3PMzHjBr5g
    PISPTdoQ7W+pygUXOcug72adQDhER1B/6XIvryEtyu6DtcfkBZyWv4lLgbeSA/+wS/y9
    TetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620118165;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=oH2/dJSbmReCwivw2GQEVMJygPn61Tsh9fDBR7OzNV8=;
    b=CJTv618mJtJ3xtrXbMRxMg7LZOC8BTe9A6Yc0DDwhDnsWji0nxGt9IS98PD8bb17vv
    vxgncgeVBvAiNDGu/BQeFVFZHPvIt0GW/PNO1IVXVNZPAvfL4jBgJ7OjsBELkvpGu1Ql
    BBrkPOc9wtKYVENm69a+CemH+N1iK+HB4tCOG51kCv60YjhwrDAYSAUWDHtpSU/Lg/V2
    jiyWsR4eFmtSdS25n6kvAZSMXHAARLczDs6E7Z7IirR7rj7vJHtOJDdPZFO9+LgCWaO9
    XfdKX6LcBCWFZtWOlAVYbchqNi5V9AzwgDQx1GeCCQrP4LD0ZMTvOJKrNgKMPNAz6jA1
    KHaQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620118165;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=oH2/dJSbmReCwivw2GQEVMJygPn61Tsh9fDBR7OzNV8=;
    b=jtTpz9e5sDeOIprmLYbsDUjSHZ73GegoBIRkxZFi861HfA5XfYTavp+hN0OVix2hS5
    TW9mRn8DMkhdpic1XIRLU9TejrRoBwaa/Q6PDlR34yCl011AYID9LI/R+6mRpRtKsaIL
    fdNVRXSxhAOiZUcL5N4j9YQix+hUXwOfeJvuaIFoc/boqFXdjppvP2De4I6cxRaDb7Zr
    oW2mbyoedZX3NGSsvqjN/4m1Zwu2jyabDHKvhbyQ49TybRILbmvoVSNOLsVAO5bqwgdA
    XB6YTnfxF+z5zfk2L4wJUhGayntingct8/WCKBH3qP3JDoIle42S1DNb4cQsfSAzVf5x
    cT1Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMIVsh7kyA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
    by smtp.strato.de (RZmta 47.25.6 DYNA|AUTH)
    with ESMTPSA id 40bb75x448nP0SX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 4 May 2021 10:49:25 +0200 (CEST)
Subject: Re: More flags for logging
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
Cc:     kayoub5@live.com
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <641804b4-733a-57b7-fdf1-b91293207f37@hartkopp.net>
Date:   Tue, 4 May 2021 10:49:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 03.05.21 12:08, Marc Kleine-Budde wrote:
> On 03.05.2021 12:02:46, Marc Kleine-Budde wrote:
>> The SocketCAN API is a great initiative for standardizing the CAN
>> interface API. This request tries to extend this initiative for more use
>> cases.
>>
>> Context:
>>
>> The SocketCAN was adopted by libpcap and tcpdump as the standard format
>> for logging CAN Frames in PCAP and PCAP-NG. See:
>>
>> https://www.tcpdump.org/linktypes/LINKTYPE_CAN_SOCKETCAN.html
>> https://github.com/wireshark/wireshark/blob/master/epan/dissectors/packet-socketcan.c
>> https://www.wireshark.org/docs/dfref/c/can.html
>>
>> Problem:
>> Applications that perform logging, usually need more details that normal
>> applications, for the sake of debugging later on. Flags needs to be
>> reserved/allocated in the SocketCAN API, so that logging applications
>> can make use of them in the PCAP format. The flags does not need
>> necessary need to be implemented by SocketCAN, they just need to be
>> marked as reserved for such use case.
>>
>> Needed Flags:
>> FDF Flag
>> - Since CAN Frames and CAN-FD frames can co-exist in the same bus,
>>    logging application needs to know if a normal CAN Frame was
>>    transmitted on a CAN-FD bus, namely was the FDF bit set or not.
> 
> I think someone asked for that some time ago. But that was never
> mainlined. I'll look for that old mail.
> 

When you display CAN and CAN FD frames in Wireshark they are displayed 
as different "protocols" - as they also have different ethtypes.

So the difference is provided by the 'protocol' field. Or did I miss 
something?

Regards,
Oliver

>> ACK bit in data frame
>> - Some logging hardware can act as a "spy", meaning that it records CAN
>>    Frames, but does not set the ACK bit
>> - A way to know for a given frame (FD or not), was the ACK bit set or
>>    not.
>> - Current API allow detecting missing ACK, but it does not report what
>>    Frame had a missing ACK.
> 
> This means the driver has to set a flag if it's configured in
> listen-only mode. That should be possible.
> 
> I think we can make use of flags in the struct canfd_frame for this:
> 
> | struct canfd_frame {
> | 	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> | 	__u8    len;     /* frame payload length in byte */
> | 	__u8    flags;   /* additional flags for CAN FD */
> | 	__u8    __res0;  /* reserved / padding */
> | 	__u8    __res1;  /* reserved / padding */
> | 	__u8    data[CANFD_MAX_DLEN] __attribute__((aligned(8)));
> | };
> 
> The struct can_frame doesn't have the flags member yet, but we can add
> it there.
> 
> regards,
> Marc
> 
