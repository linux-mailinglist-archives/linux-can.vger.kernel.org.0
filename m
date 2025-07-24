Return-Path: <linux-can+bounces-4082-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9454B1010E
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F477A20B2
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B75221F11;
	Thu, 24 Jul 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPoIxbN8"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A90272628
	for <linux-can@vger.kernel.org>; Thu, 24 Jul 2025 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339740; cv=none; b=coym0VBf8UbaIVwog8/yCcnoywCsLDUu9I66EUFBn0YI6WodX8Dq6B5MRcjbNW57wlYFJygQ41d5t1ylz5Z8k8rT65GKqcDFsPq39wlADha8wYwTDsb09dLgWPg3dPVi8cFWqos7vjUovuWL/6CGULWBrbPladCZi48zzWWqW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339740; c=relaxed/simple;
	bh=T1KfU6pGuYPmNmdCzmItFw+NfgE64IymlOy+JDFyvOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkKwXmnBzxdJvYsH2beT4beu6tzcBHM6lTO5fFqMpNQpTomr0XgsOAh14b0aTuWtA0qgtDqAE9/P0p128gY2hu7oT448+mAQ5EX/cy3npAtCIrq8rI8Wams65fl9HkkoNSDARvduuhowg1aW+c59KKoVC8BhNXH1+eKI863XIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPoIxbN8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55a27e6da1cso526784e87.3
        for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753339736; x=1753944536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oyPh5cWeu+zIoqsH9oSyDkfRDO0DsxpBt6dRBFZgT0o=;
        b=fPoIxbN8bBreQBruy0rAzS/althIaZPN2Rpknnn0+DEm/IHa+RN6uU46IsGjrJUlcG
         0rYkKyKUwxq3wu19A9LxwM81rx3p+LK9LvaBhYxAFVbk7uq4NLCzcSYUsOsdtXIjp/gX
         2h8kzx6Voj55FbOoJ5B1l1g6UiVKeJNZf8Ord0iViYtmnYAOtYiKp4/DEGVtFjDaSbHm
         BH1QuNhfjw3JjMzSNfXOJnZZzWsBRitd4HT00v/gjI2IdVXBGeA1v0tBhxHPmXZgWkKG
         2pA5dcBIRD5rjSdIEaQbALSm1tvtvO3NVb2UNaAPP+k8IQo1vB/koVXW9IhvfWiqWar0
         paZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753339736; x=1753944536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyPh5cWeu+zIoqsH9oSyDkfRDO0DsxpBt6dRBFZgT0o=;
        b=MP+yh7mGRadI+ITWwOwE/Kp4nvr+bbviKpRIYYPI71I58uFyovvoCW5dgxfg/BZ9pY
         KxVTe/3JkVJhxgSOCdyMWyGGbVtWC40pC3Tx/sRji6SR08Yj8BPmIiG0RlGKlPeMcajH
         WN+90RdJ4wwCm6gEd1ymJX8AqKbkqHflmcBRhAMUw9aJChjg6fT1nXOmDp7VGwDuZX4s
         teQ68wpXYaodAL7x7ET0X+QNhEVX6gZuzWJjAyPZ5UCaUO6Fjs0xKdQMkXLXowRR6Vmv
         ApgVugRRxPB/l3pztPyrfjsU3WENPA9OLYcDoq/dIIB8jaKf/9rSdu8kg71dKATSjJDz
         q45A==
X-Forwarded-Encrypted: i=1; AJvYcCUz2oGjDxmqC3wJzvhnLHKMh4JS2aYanHdsCPRTEgSpDdd/6xODKoDs9WF+mzos9cXrfuJJwa+u5bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPr7N1JQIXPD+JMN74/OE4nazotIHidxCdHP9oMsFlDp6ZExua
	N01KVXjyA2igCvDpKbIrJfLPzI5+/zV/IgMk7UZ4rVvUMjGWMk44+Mwf
X-Gm-Gg: ASbGncvD3gZ2+Foqg/MBuekwy24Q51O4Uh8AF48l1ONFqzguXiNvobMhwSaz6OKv5gA
	UzBSmxCBoPZgZl9IPg90/tgyHDwBZP2770jVTQygOvVcS3GzNW5iCZACgiD6gTYyHEnL9qde6NZ
	AmYfcg8gIjfJrhSt1akwMAQknFL3z9WiSAt76QvjSYSo1MK6vcUcJX34Z6mrL6nG20KcCNheCu+
	el2jsl+8HvhyifHouyc2S6Sv8k1F7TTZhBpfieGnhLHcVMDvq6sUnFNOf7jZm92TOfl4OIPnDbJ
	UHxz0Kaqasgr95BmfdjpnGN/0GrGdpnfFMm0kwqKh/qC8j1hJ8FpX6YOJeW70btdSOqQVYEfr1c
	rAP7kkcf3BggnlBo6YeHOw2A26BUoWaGBkbIuDTKuThkjkSaDHmGBgBKl+G2dRSyClAlS2uxo+U
	z+G+sAtGqpkxM=
X-Google-Smtp-Source: AGHT+IFVtzWOu0ty5EK+h7zEkUYUVcUaJw/CkJ11Eg5QapiQYgxXvxBUpYyrQ1gVCD7Z+msZ4/6D5w==
X-Received: by 2002:a05:6512:2344:b0:554:f74b:78ae with SMTP id 2adb3069b0e04-55a5137bb65mr2185750e87.31.1753339735326;
        Wed, 23 Jul 2025 23:48:55 -0700 (PDT)
Received: from [192.168.66.199] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-55b53c6ed15sm206271e87.92.2025.07.23.23.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 23:48:54 -0700 (PDT)
Message-ID: <c638bf61-ee7d-4f03-82f9-5fd3c6b7d11e@gmail.com>
Date: Thu, 24 Jul 2025 08:48:53 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] can: kvaser_pciefd: Add support to control CAN LEDs
 on device
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250723083236.9-1-extja@kvaser.com>
 <20250723083236.9-2-extja@kvaser.com>
 <d394ac75-09bb-4682-aa6d-0209688f5a6d@wanadoo.fr>
Content-Language: en-US
From: Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <d394ac75-09bb-4682-aa6d-0209688f5a6d@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 2:09 PM, Vincent Mailhol wrote:
> On 23/07/2025 at 17:32, Jimmy Assarsson wrote:
>> Add support to turn on/off CAN LEDs on device.
>> Turn off all CAN LEDs in probe, since they are default on after a reset or
>> power on.
>>
>> Reviewed-by: Axel Forsman <axfo@kvaser.com>
>> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
>> ---
>>   drivers/net/can/kvaser_pciefd.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
>> index 09510663988c..c8f530ef416e 100644
>> --- a/drivers/net/can/kvaser_pciefd.c
>> +++ b/drivers/net/can/kvaser_pciefd.c
>> @@ -66,6 +66,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
>>   #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
>>   #define KVASER_PCIEFD_KCAN_CTRL_REG 0x2c0
>>   #define KVASER_PCIEFD_KCAN_CMD_REG 0x400
>> +#define KVASER_PCIEFD_KCAN_IOC_REG 0x404
>>   #define KVASER_PCIEFD_KCAN_IEN_REG 0x408
>>   #define KVASER_PCIEFD_KCAN_IRQ_REG 0x410
>>   #define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG 0x414
>> @@ -136,6 +137,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
>>   /* Request status packet */
>>   #define KVASER_PCIEFD_KCAN_CMD_SRQ BIT(0)
>>   
>> +/* Control CAN LED, active low */
>> +#define KVASER_PCIEFD_KCAN_IOC_LED BIT(0)
>> +
>>   /* Transmitter unaligned */
>>   #define KVASER_PCIEFD_KCAN_IRQ_TAL BIT(17)
>>   /* Tx FIFO empty */
>> @@ -410,6 +414,7 @@ struct kvaser_pciefd_can {
>>   	struct kvaser_pciefd *kv_pcie;
>>   	void __iomem *reg_base;
>>   	struct can_berr_counter bec;
>> +	u32 ioc;
>>   	u8 cmd_seq;
>>   	u8 tx_max_count;
>>   	u8 tx_idx;
>> @@ -528,6 +533,16 @@ static inline void kvaser_pciefd_abort_flush_reset(struct kvaser_pciefd_can *can
>>   	kvaser_pciefd_send_kcan_cmd(can, KVASER_PCIEFD_KCAN_CMD_AT);
>>   }
>>   
>> +static inline void kvaser_pciefd_set_led(struct kvaser_pciefd_can *can, bool on)
>> +{
>> +	if (on)
>> +		can->ioc &= ~KVASER_PCIEFD_KCAN_IOC_LED;
>> +	else
>> +		can->ioc |= KVASER_PCIEFD_KCAN_IOC_LED;
>> +
>> +	iowrite32(can->ioc, can->reg_base + KVASER_PCIEFD_KCAN_IOC_REG);
>> +}
>> +
>>   static void kvaser_pciefd_enable_err_gen(struct kvaser_pciefd_can *can)
>>   {
>>   	u32 mode;
>> @@ -990,6 +1005,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>>   		/* Disable Bus load reporting */
>>   		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
>>   
>> +		can->ioc = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_IOC_REG);
> 
> Nitpick: shouldn't this line go into kvaser_pciefd_set_led() ?

If we read the register here, we only need to read KVASER_PCIEFD_KCAN_IOC_REG once,
and let the driver maintain the state.
So I prefer to keep it.

Best regards,
jimmy 
>> +		kvaser_pciefd_set_led(can, false);
>> +
>>   		tx_nr_packets_max =
>>   			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
>>   				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
> 
> Yours sincerely,
> Vincent Mailhol

