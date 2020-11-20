Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E52BA8D8
	for <lists+linux-can@lfdr.de>; Fri, 20 Nov 2020 12:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgKTLSS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Nov 2020 06:18:18 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:17505 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgKTLSR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Nov 2020 06:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1605871095;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=BHYMxmmWzvow9dqia7xW8st5COpTFQT355GvKSbyn7w=;
        b=I1UoL8f8ir6e2grIloQ4BP2H8Le61xrFy4c2vOau8uKWe0fVLsBnmyq+F7uFwdhSkv
        DU97vlV8Cu/DCxxPR7X27ebGLtaFSiha4f5sf4z32Tm5IvWotgoTlMPeKwoKaTqjQjc7
        6OwVU/0L08zvjccRgbXO4bJFuTvoXW6W1WzTEtInBIFMRf6NbFCgxAn+YYoGXGBl1FGr
        m9z5SBlRkt8LqVwXjkhIQfIsTdIe3JBPVZBYixDhYX+oHFIlON3xDNM8aS5iYiaMoGvt
        LXRUAC3GQ8KNnwfXsgYegGbC6EOpyZNNymvhDEInZoKk/mQB3nCW1BNkAtUZC8ywGb8W
        XV2g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGV1iOMlqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwAKBIEX4J
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 20 Nov 2020 12:18:14 +0100 (CET)
Subject: Re: [PATCH v6 4/8 rebased] can: replace can_dlc as variable/element
 for payload length
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20201120100444.3199-1-socketcan@hartkopp.net>
 <1003aa33-7717-c7a9-dbe2-0b4c6561bf85@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <4f32923c-4fad-4b63-4d9a-562e7879c153@hartkopp.net>
Date:   Fri, 20 Nov 2020 12:18:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1003aa33-7717-c7a9-dbe2-0b4c6561bf85@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 20.11.20 11:49, Marc Kleine-Budde wrote:
> On 11/20/20 11:04 AM, Oliver Hartkopp wrote:
>> The naming of can_dlc as element of struct can_frame and also as variable
>> name is misleading as it claims to be a 'data length CODE' but in reality
>> it always was a plain data length.
>>
>> With the indroduction of a new 'len' element in struct can_frame we can now
>> remove can_dlc as name and make clear which of the former uses was a plain
>> length (-> 'len') or a data length code (-> 'dlc') value.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> [...]
> 
>> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
>> index b1729b208788..940589667a7f 100644
>> --- a/drivers/net/can/usb/gs_usb.c
>> +++ b/drivers/net/can/usb/gs_usb.c
>> @@ -133,11 +133,11 @@ struct gs_device_bt_const {
>>   
>>   struct gs_host_frame {
>>   	u32 echo_id;
>>   	u32 can_id;
>>   
>> -	u8 can_dlc;
>> +	u8 len;
> 
> At least in the candleLight firmware, this is the dlc value from the CAN
> controller, not a sanitized len value.

Oh, yes! You are right.

In fact it looks like that all USB adapters I've checked so far provide 
the raw DLC value on the USB communication layer - which is really fine!

As the gs_host_frame struct defines the USB content, can_dlc is the 
better naming here.

Thanks for the review.

Best,
Oliver

> 
>>   	u8 channel;
>>   	u8 flags;
>>   	u8 reserved;
> 
> https://github.com/candle-usb/candleLight_fw/blob/master/src/can.c#L152
> 
>>>          if (can_is_rx_pending(hcan)) {
>>>                  CAN_FIFOMailBox_TypeDef *fifo = &can->sFIFOMailBox[0];
>>>
>>>                  if (fifo->RIR &  CAN_RI0R_IDE) {
>>>                          rx_frame->can_id = CAN_EFF_FLAG | ((fifo->RIR >> 3) & 0x1FFFFFFF);
>>>                  } else {
>>>                          rx_frame->can_id = (fifo->RIR >> 21) & 0x7FF;
>>>                  }
>>>
>>>                  if (fifo->RIR & CAN_RI0R_RTR)  {
>>>                          rx_frame->can_id |= CAN_RTR_FLAG;
>>>                  }
>>>
>>>                  rx_frame->can_dlc = fifo->RDTR & CAN_RDT0R_DLC;
>>>
>>>                  rx_frame->data[0] = (fifo->RDLR >>  0) & 0xFF;
>>>                  rx_frame->data[1] = (fifo->RDLR >>  8) & 0xFF;
>>>                  rx_frame->data[2] = (fifo->RDLR >> 16) & 0xFF;
>>>                  rx_frame->data[3] = (fifo->RDLR >> 24) & 0xFF;
>>>                  rx_frame->data[4] = (fifo->RDHR >>  0) & 0xFF;
>>>                  rx_frame->data[5] = (fifo->RDHR >>  8) & 0xFF;
>>>                  rx_frame->data[6] = (fifo->RDHR >> 16) & 0xFF;
>>>                  rx_frame->data[7] = (fifo->RDHR >> 24) & 0xFF;
>>>
>>>                  can->RF0R |= CAN_RF0R_RFOM0; // release FIFO
> 
> I think we should keep the variable name can_dlc.
> 
> regards,
> Marc
> 
