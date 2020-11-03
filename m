Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256262A4F40
	for <lists+linux-can@lfdr.de>; Tue,  3 Nov 2020 19:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgKCSpc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Nov 2020 13:45:32 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:13779 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbgKCSpb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Nov 2020 13:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604429130;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=h6P7B1Wx1MJzgXs8e+yMOibB+DNkzfBKg6E/3FuhAbo=;
        b=c6IaTqo5PiBvSDMYIa61W3fG+pIJ0rxPE/Xd0wzqJig/Do+waoC/TQjpgM2dQ6cirJ
        dyOLPyY82MP9ALdLe0F1rFtsiXENlfeBi2cUZBGufdhk6r6ouWXSBW7Qf8TdtXIQEE5m
        lqC9Wuncn5NKv5SA0WxsT2nEMRLwipXy53bRs9TbYQVibMqjImdKChZ2w1Kq5d6pj0Na
        tV6XLWfEOswR8Txf6udPoStwCsp5ixGGLiwMdSPuoDR8BLL4GBAynaqYu25XEjZIyfJ6
        scGYVdMf0oLa4E6lBV2gtT0cvjFhThxk1dlUkTaiUyoUpK/8gxABhQde5Mmy1Z/qDdMk
        +eHg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rnbMYliT57T0lTwqN2w="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bewA3IjRGPb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 3 Nov 2020 19:45:27 +0100 (CET)
Subject: Re: [PATCH v3 2/4] can: rename get_can_dlc() macro with
 can_get_cc_len()
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
References: <20201029083218.41505-1-socketcan@hartkopp.net>
 <20201029083218.41505-3-socketcan@hartkopp.net>
 <CAMZ6RqL4LTtBJrEnRXzz7wTmGu+8B5D=ZM=PRPjfaR=raXGDhw@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <efc3e914-1048-33ad-4795-a705156d71d6@hartkopp.net>
Date:   Tue, 3 Nov 2020 19:45:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqL4LTtBJrEnRXzz7wTmGu+8B5D=ZM=PRPjfaR=raXGDhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 03.11.20 16:17, Vincent MAILHOL wrote:
> On 29.10.20 17:32, Oliver Hartkopp wrote:
>> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
>> index 41ff31795320..0a51f3c9cfec 100644
>> --- a/include/linux/can/dev.h
>> +++ b/include/linux/can/dev.h
>> @@ -96,17 +96,17 @@ static inline unsigned int can_bit_time(const struct can_bittiming *bt)
>>   {
>>          return CAN_SYNC_SEG + bt->prop_seg + bt->phase_seg1 + bt->phase_seg2;
>>   }
>>
>>   /*
>> - * get_can_dlc(value) - helper macro to cast a given data length code (dlc)
>> + * can_get_cc_len(value) - helper macro to cast a given data length code (dlc)
>>    * to u8 and ensure the dlc value to be max. 8 bytes.
> 
>   * can_get_cc_len(value) - convert a given data length code (dlc) of a
>   * Classical CAN frame into a valid data length of max. 8 bytes.
> 
> The comment is a leftover. It still mentioned DLC of max. 8 bytes. I
> tried to rephrase it to better highlight the nuance.
> 
>>    *
>>    * To be used in the CAN netdriver receive path to ensure conformance with
>>    * ISO 11898-1 Chapter 8.4.2.3 (DLC field)
>>    */
>> -#define get_can_dlc(i)         (min_t(u8, (i), CAN_MAX_DLC))
>> +#define can_get_cc_len(i)      (min_t(u8, (i), CAN_MAX_DLEN))
> 
> #define can_get_cc_len(dlc)      (min_t(u8, (dlc), CAN_MAX_DLEN))
> 
> It is easier to read and understand if the input is named "dlc", not "i".
> 

I will take these suggestions and also the one from the other review 
reply for the v4.

Thanks!

Oliver

>>   #define get_canfd_dlc(i)       (min_t(u8, (i), CANFD_MAX_DLC))
>>
>>   /* Check for outgoing skbs that have not been created by the CAN subsystem */
>>   static inline bool can_skb_headroom_valid(struct net_device *dev,
>>                                            struct sk_buff *skb)
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 
