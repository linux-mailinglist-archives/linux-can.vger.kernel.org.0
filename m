Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36B76FB563
	for <lists+linux-can@lfdr.de>; Mon,  8 May 2023 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjEHQlR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 May 2023 12:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjEHQlI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 May 2023 12:41:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1846E9B
        for <linux-can@vger.kernel.org>; Mon,  8 May 2023 09:40:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso5330875e87.0
        for <linux-can@vger.kernel.org>; Mon, 08 May 2023 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1683564039; x=1686156039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCkdmMjI1O+RAc2VzWyTB1ysipWka8FiyL8cMh+T6Go=;
        b=RrbxUzRTNFmhsXoBivFUPotJZBKjPOe2fOKxCBiT5v1EtO4GadgYro+QoBv9dN59FQ
         7D/BhMBMmYjguM9Qa+9aTcOj9CHzH4gW8FcSufl7JvMygHgiaDvQC5B+EKI3uojlxMLH
         ILGZoGN4GP3H9wfwYWP5607ZodazEvjmQhoc7HGolz1toPaW1LTEorbpxQ3jenMFpSpu
         oPlRAvSqjSUK/sLhhu7Ca+f9Hg2xlmKSP00GOhSsodl0qlIbWEJ3MsG+T1jnUL/F1KKs
         7nK4NBXbqz1mjIQ+KMyrV8s5BNEnbB3AekgS9D0sckpLUwsy5oAyK6bVO4vZ0azWL2aI
         65sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683564039; x=1686156039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCkdmMjI1O+RAc2VzWyTB1ysipWka8FiyL8cMh+T6Go=;
        b=Kq3IAM0ODq+WQMumZH0spMx6HB/z3aBUbnt1m44YvlfPeahpt0wAq8DE7eraD4QOLM
         BvHYXISeL4dPD2xDSgQdgNvM2ZrA0OlLTgOOLw7CTvYynqE9Rw1yyAmsFQFwDnCJ+jWY
         UgxBuOR9SlbMSwDOEx1I5jofpNXKLPjpaEmJA56JH9NqPgjajW6fMn1NugT5/giGuN4p
         j23u2fsPc6tYgwLrgTrzTz+urpTHOg9sy6j7UaeHNrvmEIc1GnA8qt+4TiEvR45FyCyy
         8Y/0hztAIaODa3fLkuAM0Dtzj1sRQVuF4o4R8uFTcWREcHXRnMb/MM9nQx6FyVZ4k/s4
         L/Ng==
X-Gm-Message-State: AC+VfDw2+W+txLswwLLzrH56e9HZ9Y+jggvyQePg214pOYQomTHsq935
        cg58qkk+BJqdicur07V826jfJQ==
X-Google-Smtp-Source: ACHHUZ5HHgeSBHdhYgZlpPzU/xmIsIXKM7XxtO99dI804vZAXdI6/7GayZI+EVQiyyngserLoIr7LA==
X-Received: by 2002:ac2:494a:0:b0:4f2:4fa5:4bcc with SMTP id o10-20020ac2494a000000b004f24fa54bccmr941835lfi.24.1683564039400;
        Mon, 08 May 2023 09:40:39 -0700 (PDT)
Received: from [192.168.16.142] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id l10-20020ac2554a000000b004f195cc3918sm39196lfk.176.2023.05.08.09.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 09:40:38 -0700 (PDT)
Message-ID: <d4eb5d98-f62b-be58-58fb-9e9736d476bd@kvaser.com>
Date:   Mon, 8 May 2023 18:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] can: kvaser_usb_leaf: Implement CAN 2.0 raw DLC
 functionality.
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Carsten Schmidt <carsten.schmidt-achim@t-online.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org
References: <20230506105529.4023-1-carsten.schmidt-achim@t-online.de>
 <7e25ba42-4aa9-0d88-e708-18462bc7cc48@hartkopp.net>
Content-Language: en-US
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <7e25ba42-4aa9-0d88-e708-18462bc7cc48@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Carsten,
Hi Oliver,

On 5/6/23 21:10, Oliver Hartkopp wrote:
> Thanks for your patch Carsten!
> 
> There should be at least one sentence in the commit message even when 
> the subject almost covers the story ;-)

@Carsten, thanks for the patch!

Acked-by: Jimmy Assarsson <extja@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>

> Can you also please change the subject to
> 
> can: kvaser_usb: add len8_dlc support for kvaser_usb_leaf
> 
> to follow up with the other len8_dlc patches?
> 
> @Jimmy: AFAIK Carsten only has a Kvaser USB Leaf for testing. Can you 
> probably provide and test a similar improvement for the Kvaser USB Hydra 
> hardware?


@Oliver, yes, I'll fix this for the remaining Kvaser USB devices.
I'll try to send a patch for it by the end of the week.

Best regards,
jimmy

> Many thanks,
> Oliver
> 
> On 06.05.23 12:55, Carsten Schmidt wrote:
>> Signed-off-by: Carsten Schmidt <carsten.schmidt-achim@t-online.de>
>> ---
>>   drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c 
>> b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>> index 1c2f99ce4c6c..713b633773b1 100644
>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>> @@ -573,7 +573,7 @@ kvaser_usb_leaf_frame_to_cmd(const struct 
>> kvaser_usb_net_priv *priv,
>>               cmd->u.tx_can.data[1] = cf->can_id & 0x3f;
>>           }
>> -        cmd->u.tx_can.data[5] = cf->len;
>> +        cmd->u.tx_can.data[5] = can_get_cc_dlc(cf, priv->can.ctrlmode);
>>           memcpy(&cmd->u.tx_can.data[6], cf->data, cf->len);
>>           if (cf->can_id & CAN_RTR_FLAG)
>> @@ -1349,7 +1349,7 @@ static void kvaser_usb_leaf_rx_can_msg(const 
>> struct kvaser_usb *dev,
>>           else
>>               cf->can_id &= CAN_SFF_MASK;
>> -        cf->len = can_cc_dlc2len(cmd->u.leaf.log_message.dlc);
>> +        can_frame_set_cc_len(cf, cmd->u.leaf.log_message.dlc & 0xF, 
>> priv->can.ctrlmode);
>>           if (cmd->u.leaf.log_message.flags & MSG_FLAG_REMOTE_FRAME)
>>               cf->can_id |= CAN_RTR_FLAG;
>> @@ -1367,7 +1367,7 @@ static void kvaser_usb_leaf_rx_can_msg(const 
>> struct kvaser_usb *dev,
>>               cf->can_id |= CAN_EFF_FLAG;
>>           }
>> -        cf->len = can_cc_dlc2len(rx_data[5]);
>> +        can_frame_set_cc_len(cf, rx_data[5] & 0xF, priv->can.ctrlmode);
>>           if (cmd->u.rx_can_header.flag & MSG_FLAG_REMOTE_FRAME)
>>               cf->can_id |= CAN_RTR_FLAG;
>> @@ -1702,6 +1702,7 @@ static int kvaser_usb_leaf_init_card(struct 
>> kvaser_usb *dev)
>>       struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
>>       card_data->ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
>> +    card_data->ctrlmode_supported |= CAN_CTRLMODE_CC_LEN8_DLC;
>>       return 0;
>>   }
