Return-Path: <linux-can+bounces-936-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF15B91E4B3
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 18:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D021C21835
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8731E502;
	Mon,  1 Jul 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWUsmUjI"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F716D4E4
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849631; cv=none; b=dcnF21/rfMhq61I8fI+xLvlkxsH9zlBhKoFqeBjmu2OU7Gw1nzWQaFCM9EO7En8sC5dxl6aIFguh+hIlswUDrb34ZUO8zF86rZzNALMvUldyqjjuuOa16Oz/TLVt/e3euaVfhTLpS4kjaN8lgvoyQowmvPudzRw9NBvDH1HwHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849631; c=relaxed/simple;
	bh=3a0m7ucIpj249yheZ181DCMViGrEXLaRdQMOp2u/PNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJPkK62MCRGNraNHnen7YSz3TtwMc3eizR2jL1X6FQa+ejNMVFx5VAZsZ8PsZZoDhBJO9QX55kC66M5GI3NTFGBQKEAQI6XOJf6Vwpc3E/9PfOnz2caBToKAi2gKfPgYoOZ/HivcCD6IUlPk/y0UOtnEbhB8XSv0yZxUOd49OAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWUsmUjI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e764bb3fbso4079412e87.3
        for <linux-can@vger.kernel.org>; Mon, 01 Jul 2024 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719849628; x=1720454428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJUUfzRM2Mb3ZzxflGJ7G6RrwQ+Ssgh4zUH7i+AGYkg=;
        b=jWUsmUjI5Hzk87GeyYabtzKQ62pFy78ZP0Hn2ZS6GV8GxReAraoZuEbp89OVl/tohR
         v3spcvYVMBDWpZidVV3bLyAgq+tPbAEaQpPwMMfs/WK9q8hSpb2uk788yGNtQvoRpBFy
         /fOiaE3hUi3pMzMcjAt2ED6frUeuseSTjy0F3kZAhw9wyFq23z2lrVz7xx5ptVuGA06V
         NOjthVx4etKohl+qlOfv4E6PWEtw+oT+DQ3astodE1YiilnCD/plGc/XFk2MwTQuoevS
         YCEEPVGv1kAjEk1W8UgClHUVywOUIKnPeBlcQrXzkaYETE90iNaiPPe0nPdyG0rPWhTD
         IU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719849628; x=1720454428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJUUfzRM2Mb3ZzxflGJ7G6RrwQ+Ssgh4zUH7i+AGYkg=;
        b=KXoOiqIb9z/rmAyqeBay3ZKuyDfq790yeBGM2XS3GO0uFmwfr7aIplVM7YH7nRdTA2
         KY96JPuGy1sHvBaDCFAPXCVkMjyRRuL+TO/kHCynRohpPkZbMXoAycBfX4lOidPW1sZw
         fTh8P3cMO64USVxL/v5JVRou8awnEFdNF2tSP46971Qoz6uJRcSD9LQ60nTqtFqWpXRu
         KvqbxQjKF2TyBgZVKJBt5gNwSUc4N3aFA2gBHCIgz1kBFnAYUhGFzWGx6+/1dVGJrfkj
         uDgesN8ewoLs2EtUe5BDn5e6K/WIEE0hEyc9VBXi/VJhfUKAe4BV49pQ8iCYh8C6NoUh
         8k9g==
X-Gm-Message-State: AOJu0YyXCfGY896MXEjrc5/yCBWx4sdLirUD1H3bfpqaUCaw+uBneHYZ
	74yjjmq39LVIUjvNTJzuMKnGWoVhkpIO4hcYYUKZAwG54FHQtO8z
X-Google-Smtp-Source: AGHT+IHaR2xmwO4mSkCxphmZP3jBjS0dU0AJprdusO4At723ISIKGcFVxtS8VR5p4PHSA+CFt7nCpg==
X-Received: by 2002:a05:6512:6c7:b0:52c:dfa0:dca0 with SMTP id 2adb3069b0e04-52e826fb988mr4248349e87.43.1719849627888;
        Mon, 01 Jul 2024 09:00:27 -0700 (PDT)
Received: from [192.168.66.194] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b263sm1451526e87.268.2024.07.01.09.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 09:00:27 -0700 (PDT)
Message-ID: <104ad074-52fb-ceda-4634-e6f718c1313f@gmail.com>
Date: Mon, 1 Jul 2024 18:00:26 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH can-next 10/15] can: kvaser_usb: leaf: Add structs for Tx
 ACK and clock overflow commands
Content-Language: en-US
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
 Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20240628195514.316895-1-extja@kvaser.com>
 <20240628195514.316895-11-extja@kvaser.com>
 <CAMZ6RqKqJX6eqogS2598BFm-AN1uOBbBGL+MkoJtR=-z379Q=w@mail.gmail.com>
From: Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <CAMZ6RqKqJX6eqogS2598BFm-AN1uOBbBGL+MkoJtR=-z379Q=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/29/24 11:55, Vincent MAILHOL wrote:
> On Sat. 29 June 2024 at 04:56, Jimmy Assarsson <extja@kvaser.com> wrote:
>> For usbcan devices (M16C), add struct usbcan_cmd_tx_acknowledge for Tx ACK
>> commands and struct usbcan_cmd_clk_overflow_event for clock overflow event
>> commands.
>>
>> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
>> ---
>>   .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 22 +++++++++++++++----
>>   1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>> index c0a8713d8cf2..98bd6cfca2ca 100644
>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>> @@ -242,6 +242,13 @@ struct leaf_cmd_tx_acknowledge {
>>          u8 padding[2];
>>   } __packed;
>>
>> +struct usbcan_cmd_tx_acknowledge {
>> +       u8 channel;
>> +       u8 tid;
>> +       __le16 time;
>> +       u8 padding[2];
>> +} __packed;
>> +
>>   struct leaf_cmd_can_error_event {
>>          u8 tid;
>>          u8 flags;
>> @@ -288,6 +295,12 @@ struct usbcan_cmd_error_event {
>>          __le16 padding;
>>   } __packed;
>>
>> +struct usbcan_cmd_clk_overflow_event {
>> +       u8 tid;
>> +       u8 padding;
>> +       __le32 time;
>> +} __packed;
>> +
>>   struct kvaser_cmd_ctrl_mode {
>>          u8 tid;
>>          u8 channel;
>> @@ -363,6 +376,8 @@ struct kvaser_cmd {
>>                          struct usbcan_cmd_chip_state_event chip_state_event;
>>                          struct usbcan_cmd_can_error_event can_error_event;
>>                          struct usbcan_cmd_error_event error_event;
>> +                       struct usbcan_cmd_tx_acknowledge tx_ack;
>> +                       struct usbcan_cmd_clk_overflow_event clk_overflow_event;
>>                  } __packed usbcan;
>>
>>                  struct kvaser_cmd_tx_can tx_can;
>> @@ -396,15 +411,14 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
>>          [CMD_START_CHIP_REPLY]          = kvaser_fsize(u.simple),
>>          [CMD_STOP_CHIP_REPLY]           = kvaser_fsize(u.simple),
>>          [CMD_GET_CARD_INFO_REPLY]       = kvaser_fsize(u.cardinfo),
>> -       [CMD_TX_ACKNOWLEDGE]            = kvaser_fsize(u.tx_acknowledge_header),
>> +       [CMD_TX_ACKNOWLEDGE]            = kvaser_fsize(u.usbcan.tx_ack),
>>          [CMD_GET_SOFTWARE_INFO_REPLY]   = kvaser_fsize(u.usbcan.softinfo),
>>          [CMD_RX_STD_MESSAGE]            = kvaser_fsize(u.usbcan.rx_can),
>>          [CMD_RX_EXT_MESSAGE]            = kvaser_fsize(u.usbcan.rx_can),
>>          [CMD_CHIP_STATE_EVENT]          = kvaser_fsize(u.usbcan.chip_state_event),
>>          [CMD_CAN_ERROR_EVENT]           = kvaser_fsize(u.usbcan.can_error_event),
>>          [CMD_ERROR_EVENT]               = kvaser_fsize(u.usbcan.error_event),
>> -       /* ignored events: */
>> -       [CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = CMD_SIZE_ANY,
>> +       [CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = kvaser_fsize(u.usbcan.clk_overflow_event),
>>   };
>>
>>   /* Summary of a kvaser error event, for a unified Leaf/Usbcan error
>> @@ -1608,12 +1622,12 @@ static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
>>                  kvaser_usb_leaf_get_busparams_reply(dev, cmd);
>>                  break;
>>
>> -       /* Ignored commands */
>>          case CMD_USBCAN_CLOCK_OVERFLOW_EVENT:
>>                  if (dev->driver_info->family != KVASER_USBCAN)
>>                          goto warn;
>>                  break;
> 
> I did not understand this part. If the overflow event is now handled,
> why do you still have the
> 
>    goto warn
> 
> ?

The warning is for non-usbcan device (leaf), where this command is unexpected.

> Shouldn't you dispatch the command here?

It's dispatched in the succeeding patch
can: kvaser_usb: leaf: Store MSB of timestamp [1]
I'll fix this in v2. I keep the "ignored events/commands" comments in this patch,
and move them to the proper patch.

Regards,
/jimmy

[1] https://lore.kernel.org/linux-can/20240701154936.92633-12-extja@kvaser.com/T/#u

  
>> +       /* Ignored commands */
>>          case CMD_FLUSH_QUEUE_REPLY:
>>                  if (dev->driver_info->family != KVASER_LEAF)
>>                          goto warn;
>> --
>> 2.45.2
>>
>>

