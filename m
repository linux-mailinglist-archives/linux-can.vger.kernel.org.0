Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3F76FF644
	for <lists+linux-can@lfdr.de>; Thu, 11 May 2023 17:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbjEKPm2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 11 May 2023 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbjEKPm1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 May 2023 11:42:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590731A4
        for <linux-can@vger.kernel.org>; Thu, 11 May 2023 08:42:26 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2ac826a1572so89994621fa.0
        for <linux-can@vger.kernel.org>; Thu, 11 May 2023 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1683819744; x=1686411744;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahMi3XvObS5rBvCrn/EABKH0wmLSR9nuTXDDbTjqAno=;
        b=f04MD/JPAT9Aq4hHbWybcWfZdd9lTRrH6Kf7my7IZADLkjAy9IgnsTX20EKY6/sfWx
         UXjFmxca2/h0YJ9D5ExgXOAdCVj3LY60/hr0YwkcouNv/7lzmYHFLyfz2z22f2E5EztQ
         UWd0cbufe55DFaJD/16eisoCPywzMhdA0NhMNM2gSEUJxy3dFEX4BKuGoYXQEjDC6ayY
         7OO6Pe70lhRTQS8XCgAR4vtqhHo0ItR1dAjYBmQdWt7NxAehv3mRFBja3BZHjPHqbLsR
         r/w3flBCsy+FDWsYN4lsySXov4MZGNdnGvLFY42gwxCENk5IN/yiFWSf3+Re2hc4nzHz
         wO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683819744; x=1686411744;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahMi3XvObS5rBvCrn/EABKH0wmLSR9nuTXDDbTjqAno=;
        b=eWdLCLPopIVWc6rU8nKpA/6SaxZ5eFCtmCfjeMm258cY0Zy8OXTjegjdkTNMeOBWpB
         CGeevMTibLooxoVaFik6Hd1IZDVov5vuCff8EB1Mqh6B763HYvJCNxqV8zzLa8aTGDEd
         tBOpQu6Ac8pDsNAhziDalH0eMXcYOHrRYmSvFDW+pG+V6W0ML4S7t1DEuHydoqoor+uO
         /UJYSYGo2uek7tb/27BUi+GTBp6puZzkgue+PNdup0xg+YlRYiw1naseo6jS2OQtRjt1
         Bsj2PCBoGmAgEhg/cNBQUK3y+1ZTrYDVEa1xsbZLrXcaQvrPcNFWAONylbwRPAtoc4pi
         GPTA==
X-Gm-Message-State: AC+VfDxBWG+ksMB/Mx2q/b+P1Tx3KWCkkn+EuufcaApKC7m3htgbpemY
        J7m27E3Zv391VUwRkvsdmuSkkoYfSEnrCwWrcns=
X-Google-Smtp-Source: ACHHUZ5Rn8hBomMLdX4hIlKCXxSXiJbeT2jPC8PWDuylvZoDT1g5vIaPPuxWiGFQ9ACSs1RLGUv30A==
X-Received: by 2002:a2e:9bd7:0:b0:2a8:ea1e:bde9 with SMTP id w23-20020a2e9bd7000000b002a8ea1ebde9mr3420172ljj.45.1683819744609;
        Thu, 11 May 2023 08:42:24 -0700 (PDT)
Received: from [10.8.0.3] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id b2-20020a2e8482000000b002adb98fdf81sm610354ljh.7.2023.05.11.08.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 08:42:24 -0700 (PDT)
Subject: Re: [PATCH] can: kvaser_usb_leaf: Implement CAN 2.0 raw DLC
 functionality.
From:   Jimmy Assarsson <extja@kvaser.com>
To:     Carsten Schmidt <carsten.schmidt-achim@t-online.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org
References: <20230506105529.4023-1-carsten.schmidt-achim@t-online.de>
 <7e25ba42-4aa9-0d88-e708-18462bc7cc48@hartkopp.net>
 <d4eb5d98-f62b-be58-58fb-9e9736d476bd@kvaser.com>
Message-ID: <a81e55c3-66b9-1f84-b1a3-dd5184478da3@kvaser.com>
Date:   Thu, 11 May 2023 17:42:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d4eb5d98-f62b-be58-58fb-9e9736d476bd@kvaser.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2023-05-08 18:40, Jimmy Assarsson wrote:
> Hi Carsten,
> Hi Oliver,
> 
> On 5/6/23 21:10, Oliver Hartkopp wrote:
>> Thanks for your patch Carsten!
>>
>> There should be at least one sentence in the commit message even when the 
>> subject almost covers the story ;-)
> 
> @Carsten, thanks for the patch!
> 
> Acked-by: Jimmy Assarsson <extja@kvaser.com>
> Tested-by: Jimmy Assarsson <extja@kvaser.com>
> 
>> Can you also please change the subject to
>>
>> can: kvaser_usb: add len8_dlc support for kvaser_usb_leaf
>>
>> to follow up with the other len8_dlc patches?
>>
>> @Jimmy: AFAIK Carsten only has a Kvaser USB Leaf for testing. Can you 
>> probably provide and test a similar improvement for the Kvaser USB Hydra 
>> hardware?
> 
> 
> @Oliver, yes, I'll fix this for the remaining Kvaser USB devices.
> I'll try to send a patch for it by the end of the week.
> 
> Best regards,
> jimmy

Hi Carsten,

I've implemented cc-len8-dlc support for the Kvaser USB Hydra devices.
Is it OK if I add my changes to your patch, and send it is as a V2?

Best regards,
jimmy

>> Many thanks,
>> Oliver
>>
>> On 06.05.23 12:55, Carsten Schmidt wrote:
>>> Signed-off-by: Carsten Schmidt <carsten.schmidt-achim@t-online.de>
>>> ---
>>>   drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c 
>>> b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>>> index 1c2f99ce4c6c..713b633773b1 100644
>>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>>> @@ -573,7 +573,7 @@ kvaser_usb_leaf_frame_to_cmd(const struct 
>>> kvaser_usb_net_priv *priv,
>>>               cmd->u.tx_can.data[1] = cf->can_id & 0x3f;
>>>           }
>>> -        cmd->u.tx_can.data[5] = cf->len;
>>> +        cmd->u.tx_can.data[5] = can_get_cc_dlc(cf, priv->can.ctrlmode);
>>>           memcpy(&cmd->u.tx_can.data[6], cf->data, cf->len);
>>>           if (cf->can_id & CAN_RTR_FLAG)
>>> @@ -1349,7 +1349,7 @@ static void kvaser_usb_leaf_rx_can_msg(const 
>>> struct kvaser_usb *dev,
>>>           else
>>>               cf->can_id &= CAN_SFF_MASK;
>>> -        cf->len = can_cc_dlc2len(cmd->u.leaf.log_message.dlc);
>>> +        can_frame_set_cc_len(cf, cmd->u.leaf.log_message.dlc & 0xF, 
>>> priv->can.ctrlmode);
>>>           if (cmd->u.leaf.log_message.flags & MSG_FLAG_REMOTE_FRAME)
>>>               cf->can_id |= CAN_RTR_FLAG;
>>> @@ -1367,7 +1367,7 @@ static void kvaser_usb_leaf_rx_can_msg(const 
>>> struct kvaser_usb *dev,
>>>               cf->can_id |= CAN_EFF_FLAG;
>>>           }
>>> -        cf->len = can_cc_dlc2len(rx_data[5]);
>>> +        can_frame_set_cc_len(cf, rx_data[5] & 0xF, priv->can.ctrlmode);
>>>           if (cmd->u.rx_can_header.flag & MSG_FLAG_REMOTE_FRAME)
>>>               cf->can_id |= CAN_RTR_FLAG;
>>> @@ -1702,6 +1702,7 @@ static int kvaser_usb_leaf_init_card(struct 
>>> kvaser_usb *dev)
>>>       struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
>>>       card_data->ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
>>> +    card_data->ctrlmode_supported |= CAN_CTRLMODE_CC_LEN8_DLC;
>>>       return 0;
>>>   }
