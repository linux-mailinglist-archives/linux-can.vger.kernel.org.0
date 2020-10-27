Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EEB29AD2E
	for <lists+linux-can@lfdr.de>; Tue, 27 Oct 2020 14:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbgJ0NXj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 27 Oct 2020 09:23:39 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:20583 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbgJ0NXj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Oct 2020 09:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603805013;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=spNV5huCsFu67lY7pPRof/XbonIqms0HV4x2mzlPH50=;
        b=VVz0u22HunlfrG+lkJxvalLnlsxUITshdikpwfFezgrvVHRRb8CxvpcB9oPZROfO2N
        8iuJ2ovtxyE9sC5JGjnXzWnhOOLVVnJ6ngQDiwMj6mU/VepPx5OqNc1RQ5u5rojOsGwq
        ZvoskN2ds/qnvMbbo+CbKmutdSy34BhyBTV5gXvxToPawufaf3Z0/0h/fRRhWv/z6fBC
        G3IJYO5LWeYX0KXRqjoypZpflQZUPaYAsIcaIXz44SVYhwRZWflOdI2y0xn1LnzGlm/M
        tCfGHg1ZF7/LIiQOpWZbER16Uews5J907dhkOpgGxV2HpGbesp+OHl5dSvUIsV6/qhqG
        MUJw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xvyl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.2 SBL|AUTH)
        with ESMTPSA id j075f4w9RDNU31A
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 27 Oct 2020 14:23:30 +0100 (CET)
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
To:     Marc Kleine-Budde <mkl@pengutronix.de>, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201023203017.3485-1-socketcan@hartkopp.net>
 <d5ad34b5-7232-eadb-94a0-c58c111fa443@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <8c142aa4-78a2-1291-b5a8-d4af9ba41338@hartkopp.net>
Date:   Tue, 27 Oct 2020 14:23:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d5ad34b5-7232-eadb-94a0-c58c111fa443@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 27.10.20 14:06, Marc Kleine-Budde wrote:
> On 10/23/20 10:30 PM, Oliver Hartkopp wrote:
>> ISO 11898-1 Chapter 8.4.2.3 defines a 4 bit data length code (DLC) table which
>> maps the DLC to the payload length of the CAN frame in bytes:
>>
>>      DLC      ->  payload length
>>      0 .. 8   ->  0 .. 8
>>      9 .. 15  ->  8
>>
>> Although the DLC values 8 .. 15 in Classical CAN always result in a payload
>> length of 8 bytes these DLC values are transparently transmitted on the CAN
>> bus. As the struct can_frame only provides a 'len' element (formerly 'can_dlc')
>> which contains the plain payload length ( 0 .. 8 ) of the CAN frame, the raw
>> DLC is not visible to the application programmer, e.g. for testing use-cases.
>>
>> To access the raw DLC values 9 .. 15 the len8_dlc element is introduced, which
>> is only valid when the payload length 'len' is 8 and the DLC is greater than 8.
>>
>> The len8_dlc element is filled by the CAN interface driver and used for CAN
>> frame creation by the CAN driver when the CAN_CTRLMODE_CC_LEN8_DLC flag is
> 
> CC stands for Classic CAN? Is this the "official" name?

No. It is 'Classical CAN'. I'm not very happy with that naming as there 
was already a 'CAN2.0B' specification to separate from the first version 
which only had 11 Bit identifiers. This could be Ancient CAN now :-D

> For example there was a press release to harmonize the CAN transceiver nameing
> recently:
> 
> https://can-cia.org/news/press-releases/view/harmonized-transceiver-naming/2020/7/16/

Yes, there you can find:

"CAN high-speed transceivers might be used in Classical CAN, CAN FD, or 
CAN XL networks"

Maybe we could update some comments and documentation for CAN2.0 -> 
Classical CAN later.

> 
>> supported by the driver and enabled via netlink configuration interface.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   include/uapi/linux/can.h         | 36 ++++++++++++++++++++------------
>>   include/uapi/linux/can/netlink.h |  1 +
>>   2 files changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
>> index 6a6d2c7655ff..bcf28ae7f14c 100644
>> --- a/include/uapi/linux/can.h
>> +++ b/include/uapi/linux/can.h
>> @@ -82,34 +82,44 @@ typedef __u32 canid_t;
>>    */
>>   typedef __u32 can_err_mask_t;
>>   
>>   /* CAN payload length and DLC definitions according to ISO 11898-1 */
>>   #define CAN_MAX_DLC 8
>> +#define CAN_MAX_RAW_DLC 15
>>   #define CAN_MAX_DLEN 8
>>   
>>   /* CAN FD payload length and DLC definitions according to ISO 11898-7 */
>>   #define CANFD_MAX_DLC 15
>>   #define CANFD_MAX_DLEN 64
>>   
>>   /**
>>    * struct can_frame - basic CAN frame structure
>> - * @can_id:  CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
>> - * @can_dlc: frame payload length in byte (0 .. 8) aka data length code
>> - *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a 1:1
>> - *           mapping of the 'data length code' to the real payload length
>> - * @__pad:   padding
>> - * @__res0:  reserved / padding
>> - * @__res1:  reserved / padding
>> - * @data:    CAN frame payload (up to 8 byte)
>> + * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
>> + * @len:      CAN frame payload length in byte (0 .. 8)
>> + * @can_dlc:  deprecated name for CAN frame payload length in byte (0 .. 8)
>> + * @__pad:    padding
>> + * @__res0:   reserved / padding
>> + * @len8_dlc: optional DLC value (9 .. 15) at 8 byte payload length
>> + *            len8_dlc contains values from 9 .. 15 when the payload length is
>> + *            8 bytes but the DLC value (see ISO 11898-1) is greater then 8.
>> + *            CAN_CTRLMODE_CC_LEN8_DLC flag has to be enabled in CAN driver.
>> + * @data:     CAN frame payload (up to 8 byte)
>>    */
>>   struct can_frame {
>>   	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
>> -	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
>> -	__u8    __pad;   /* padding */
>> -	__u8    __res0;  /* reserved / padding */
>> -	__u8    __res1;  /* reserved / padding */
>> -	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
>> +	union {
>> +		/* CAN frame payload length in byte (0 .. CAN_MAX_DLEN)
>> +		 * was previously named can_dlc so we need to carry that
>> +		 * name for legacy support
>> +		 */
>> +		__u8 len;
>> +		__u8 can_dlc; /* deprecated */
>> +	};
> 
> There was an old compiler version, which struggled with C99 initialized unions
> within structs.....So this change would break existing source, but I think that
> old compilers are long gone (for good).

Good to know. Do you know 'version numbers', so that we may place a 
warning somewhere?

I still have a 2.6.28 system here (gcc 2.95) - but I would not know why 
updating the can-utils there today. Maybe for the cansniffer ;-)

Btw. when it is only about the initialization of static struct 
can_frame's, I can also check for these cases in can-utils.

Best,
Oliver
