Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E1829D3EF
	for <lists+linux-can@lfdr.de>; Wed, 28 Oct 2020 22:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgJ1VsI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Oct 2020 17:48:08 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:29017 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgJ1VsH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Oct 2020 17:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603921685;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=6OQTJnOtC/pEmgcx9+63kRM0NRxJAJ9gxOnRdcZj/6g=;
        b=bHrEwFtIa0CNPk783PxfchhN5smdCFG8BKZlLEjeuRXPJUxOqUS6sERw9zKI163Glq
        R/OQ9Kv3KiIdIsSFTFkLhk1AhOeom3Xiz8VseVp1CdprGwpnPR6yjf7iZOONYjWlG5uG
        IRdhlEYBU+ULNehjK696ooApsHL5vEHQ1rqQYCZfRialEXt9Av3or2z7O/Dbz/RPOWkh
        iftT8ZH4AH73d7NSKWFRtorEFLgv0Kam05FkdUQi1HdO8O7QrdjwQqezIkRpfy64b1Dm
        4wdRQGWISJrb6a8+H6MQt/F7uNSvD6bQG0jvIrBbT42vWUtnfvRcvp4zUPFOijpITSAt
        Utiw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hYNd5YsYfzMFI2y1mvrC6tJ0qV6vjIz8/x7DMw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cf5:5d00:7f6c:26b3:e573:28b8]
        by smtp.strato.de (RZmta 47.2.3 AUTH)
        with ESMTPSA id J01b14w9SJI01wv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 28 Oct 2020 20:18:00 +0100 (CET)
Subject: Re: [PATCH v2 3/4] can: remove obsolete get_canfd_dlc() macro
To:     Marc Kleine-Budde <mkl@pengutronix.de>, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201028180940.2071-1-socketcan@hartkopp.net>
 <20201028180940.2071-4-socketcan@hartkopp.net>
 <9eac8c67-694d-9fb7-5d44-272df37d0946@pengutronix.de>
 <674a183a-ab3c-a916-c5bd-9cc3d0a37de4@hartkopp.net>
 <49fc0520-5786-c94a-2004-4703663b0a41@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <23169516-3609-b42c-85f6-9e62f6c6142c@hartkopp.net>
Date:   Wed, 28 Oct 2020 20:18:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <49fc0520-5786-c94a-2004-4703663b0a41@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 28.10.20 20:00, Marc Kleine-Budde wrote:
> On 10/28/20 7:55 PM, Oliver Hartkopp wrote:
>>
>>
>> On 28.10.20 19:34, Marc Kleine-Budde wrote:
>>> On 10/28/20 7:09 PM, Oliver Hartkopp wrote:
>>>> The macro was always used together with can_dlc2len() which sanitizes the
>>>> given dlc value on its own.
>>>>
>>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>>> ---
>>>>    drivers/net/can/flexcan.c                         | 2 +-
>>>>    drivers/net/can/peak_canfd/peak_canfd.c           | 2 +-
>>>>    drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c    | 2 +-
>>>>    drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 2 +-
>>>>    drivers/net/can/usb/peak_usb/pcan_usb_fd.c        | 2 +-
>>>>    include/linux/can/dev.h                           | 1 -
>>>>    include/linux/can/dev/peak_canfd.h                | 2 +-
>>>>    7 files changed, 6 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>>> index b30e3171cbd0..137f46705814 100644
>>>> --- a/drivers/net/can/flexcan.c
>>>> +++ b/drivers/net/can/flexcan.c
>>>> @@ -996,11 +996,11 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
>>>>    		cfd->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
>>>>    	else
>>>>    		cfd->can_id = (reg_id >> 18) & CAN_SFF_MASK;
>>>>    
>>>>    	if (reg_ctrl & FLEXCAN_MB_CNT_EDL) {
>>>> -		cfd->len = can_dlc2len(get_canfd_dlc((reg_ctrl >> 16) & 0xf));
>>>> +		cfd->len = can_dlc2len((u8)((reg_ctrl >> 16) & 0xf));
>>>
>>> Where does the u8 come from? The can_dlc2len() only takes an u8, so the cast is
>>> not needed.
>>
>> But reg_ctrl is u32. No need for a cast here?
> 
> No, not needed.

Ok, thanks. Still something to learn every day ;-)

Will send a v3 with a removed cast tomorrow.

Best,
Oliver
