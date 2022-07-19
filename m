Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F413E579761
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 12:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiGSKOT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiGSKOT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 06:14:19 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADCFDF17
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1658225655;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=UGBa5TgoN/AoHRoh0VveLPr05k/02Z0fQWYkgtlY7c8=;
    b=tRxnAdQzcKsiMDYY3HyqO8CDQutRx4sdBRwJu4HfcmTWh09rycSs7k48/cqzlgI3rC
    iUNBiXh+Dj1xdFD4sksfw1uXHrV5Jw4ILeoeb70F8Gmddlt151Du24LAFxu/B+AP7ugt
    ARga9d4HYV0takGcpWWnlxIXlw4bJv4gP+ZepypA/O1F83MaYA/xGLAb5OyNIFzR5PMw
    HJs0tG02T1uzGJzut85sL5tOsPkdyet8+YE6Mi+uVW1timLlCERGc+TVGg8ZNhlPcjKe
    f1RNe1WzYGlL9f/UgvIBVyqJ8Egahgshuq1JwFAmXywrCeYb5qZy6wN6gZ5YM576zauV
    Xkiw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6JAEFGLc
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 19 Jul 2022 12:14:15 +0200 (CEST)
Message-ID: <3dcc85f8-2c02-dfe5-de23-d022f3fc56be@hartkopp.net>
Date:   Tue, 19 Jul 2022 12:14:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v4 5/5] can: raw: add CAN XL support
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>
Cc:     linux-can@vger.kernel.org
References: <20220719054204.29061-1-socketcan@hartkopp.net>
 <20220719054204.29061-6-socketcan@hartkopp.net>
 <CAMZ6RqJQ2ue7tdT+bxQimeVNDLrDJZBZZM35yAbQ1NZPTVbGiA@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqJQ2ue7tdT+bxQimeVNDLrDJZBZZM35yAbQ1NZPTVbGiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 19.07.22 09:45, Vincent Mailhol wrote:
> On Tue. 19 Jul. 2022 at 14:46, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> Enable CAN_RAW sockets to read and write CAN XL frames analogue to the
>> CAN FD extension (new CAN_RAW_XL_FRAMES sockopt).
>>
>> A CAN XL network interface is capable to handle Classical CAN, CAN FD and
>> CAN XL frames. When CAN_RAW_XL_FRAMES is enabled, the CAN_RAW socket checks
>> whether the addressed CAN network interface is capable to handle the
>> provided CAN frame.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   include/uapi/linux/can/raw.h |  6 +++
>>   net/can/raw.c                | 97 +++++++++++++++++++++++++++++++-----
>>   2 files changed, 90 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
>> index 3386aa81fdf2..5a0e480887ff 100644
>> --- a/include/uapi/linux/can/raw.h
>> +++ b/include/uapi/linux/can/raw.h
>> @@ -60,8 +60,14 @@ enum {
>>          CAN_RAW_ERR_FILTER,     /* set filter for error frames       */
>>          CAN_RAW_LOOPBACK,       /* local loopback (default:on)       */
>>          CAN_RAW_RECV_OWN_MSGS,  /* receive my own msgs (default:off) */
>>          CAN_RAW_FD_FRAMES,      /* allow CAN FD frames (default:off) */
>>          CAN_RAW_JOIN_FILTERS,   /* all filters must match to trigger */
>> +       CAN_RAW_XL_FRAMES,      /* allow CAN XL frames (default:off) */
>>   };
>>
>> +/* CAN XL data transfer modes for CAN_RAW_XL_FRAMES sockopt */
>> +#define CAN_RAW_XL_ENABLE (1 << 0) /* enable CAN XL frames on this socket */
>> +#define CAN_RAW_XL_RX_DYN (1 << 1) /* enable truncated data[] for read() */
>> +#define CAN_RAW_XL_TX_DYN (1 << 2) /* enable truncated data[] for write() */
> 
> This change leaves me perplexed. If I understand correctly, the only
> purpose is to provide those two APIs is to have:
>    * one for the beginner users: fixed packet size in order to keep the
> approach of CAN(-FD).
>    * one the advanced users: variable packet size.

I did not think about beginners or advances users.
To me it was like:

When I know that I often get 'shorter' CAN XL frames, I can enable this 
option.

In fact the usage pattern with the truncated data is pretty handy:

https://github.com/hartkopp/can-tests/blob/canxl/raw/canxl-rx.c#L70

> I don’t think that there are any precedent cases where the kernel
> exposed two differents APIs for the sake of pleasing both beginner and
> advanced users. Sending packets of variable sizes between the kernel
> and the userland is a solved problem and I feel uncomfortable
> introducing custom solutions in order to prevent hypothetical misuses.
> 
> I am not even convinced that this solution is safer than the V2. If
> you introduce different options, there will always be someone who will
> mix up things by copy pasting some random code snippets and get an
> unsafe result. IMHO, it is better to build a simple interface and give
> a reference implementation rather than trying to add complexity to
> anticipate misuses.

Yes. Then I would vote for selecting the 'truncated' option only - and 
therefore remove CAN_RAW_XL_[R|T]X_DYN flags that would be 'always on'.

Best regards,
Oliver
