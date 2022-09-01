Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A262C5A96F2
	for <lists+linux-can@lfdr.de>; Thu,  1 Sep 2022 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiIAMds (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Sep 2022 08:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiIAMdr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Sep 2022 08:33:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE62D112
        for <linux-can@vger.kernel.org>; Thu,  1 Sep 2022 05:33:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g7so7231237lfe.11
        for <linux-can@vger.kernel.org>; Thu, 01 Sep 2022 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LBU8qJZwhz8IbJnj+frhSujVlVAyTchBpfSb4NROO4k=;
        b=EZICKe0fH2rjd0BHygHedTpMsxUTmTES2cOuj2xD4lD68fL8pF0TPyL8xabzQfiXDP
         7zm5FN8q2QcwLqwEnX6KjYvlf1Z4dvRHm3TXme0Z2tJUgaEQoJr/cNh9NjF6O+l51Prs
         7UtLa6d2ZLyh0tMhcorxnQ19zyrKRqeRjEE81xInftV8lYRcgXQ2b7+Q5Bx7M0ezxjQC
         aG/uyk5AYD2g4waVAYZQTadCvPkooyAql4EOoyHgh5LfxWyRev3twPo5Tefu0S6njt8M
         ki7+Slh+qUQy0U1XZSGtYnfJAKvNCPW3UcCsetB5n6IDBxpX0XZNcWt3cVySHmnH0VPH
         xHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LBU8qJZwhz8IbJnj+frhSujVlVAyTchBpfSb4NROO4k=;
        b=UFCfk+Cfbl54kHtdp/SdrrCc9PuO6y3n4zCke2I+Pw0yL2J9GemP4nNxf5EnSYwgeA
         XjyBXCOsaAVkHi9n1lKFOOVOxTDmlUoT6al2Ssqb99S56W2CBgV4bYx+NmcoRCgAo5IP
         LFFRHb07DTyghJw+sk/cI4VIGCUIRNVp04OoIlpsSQHuwWnK/UOpdwU8xio4H6OeC4/4
         6zjCzFnQsrsf86mSII1MlSInUwtu7ln2NxZSl5eh/vDXgZDMbmmC4VSpzFbBHum0ZpUq
         rvI+dEAQKp7M7wMR706t6Uvyw9XtvAZk/Ai3vwiTvRqfaHpwYqQw60Tkg9r5qGneiEiE
         odgA==
X-Gm-Message-State: ACgBeo1XgMH5vkbgA2QgAm4iMAxSOaS4qUXYiTj6WpIOuP6hFibuAbN/
        z83ur7+swrrzxLeZS1fpzbK/Mewh3jNZfQ==
X-Google-Smtp-Source: AA6agR43ztlA4+HeFzOiVlosIpuqCazPamJo+jroYefb0ea5k0VoNESToDUG0tGw43Wnz48YMP/okw==
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id y14-20020a0565123f0e00b0048a5edd99b2mr10091903lfa.124.1662035623453;
        Thu, 01 Sep 2022 05:33:43 -0700 (PDT)
Received: from [192.168.16.142] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id u8-20020a056512094800b0048b086f4fb0sm2331503lft.109.2022.09.01.05.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 05:33:43 -0700 (PDT)
Message-ID: <cce04ca3-1652-ff8a-5002-07ba5f8386fb@kvaser.com>
Date:   Thu, 1 Sep 2022 14:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 04/15] can: kvaser_usb: kvaser_usb_leaf: Get
 capabilities from device
Content-Language: en-US
From:   Jimmy Assarsson <extja@kvaser.com>
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        linux-can@vger.kernel.org
References: <20220708115709.232815-1-extja@kvaser.com>
 <20220708115709.232815-5-extja@kvaser.com>
 <b25bc059-d776-146d-0b3c-41aecf4bd9f8@bitwise.fi>
 <a9f3d870-3e63-6e6b-d9de-0eef1f40f38e@kvaser.com>
In-Reply-To: <a9f3d870-3e63-6e6b-d9de-0eef1f40f38e@kvaser.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 8/18/22 20:33, Jimmy Assarsson wrote:
> On 8/12/22 17:44, Anssi Hannula wrote:
>> Hi,
>>
>> Sorry about the delay due to vacation.
>>
>> On 8.7.2022 14.56, Jimmy Assarsson wrote:
>>> Use the CMD_GET_CAPABILITIES_REQ command to query the device for certain
>>> capabilities. We are only interested in LISTENONLY mode and wither the
>>> device reports CAN error counters.
>>>
>>> And remove hard coded capabilities for all Leaf devices.
>>>
>>> Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB 
>>> devices")
>>> Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
>>> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
>>> ---
>>> Changes in v2:
>>>    - New in v2. Replaces [PATCH 04/12] can: kvaser_usb: Mark Mini 
>>> PCIe 2xHS as supporting
>>>   error counters
>>>    - Fixed Anssi's comments; 
>>> https://lore.kernel.org/linux-can/9742e7ab-3650-74d8-5a44-136555788c08@bitwise.fi/ 
>>>
>>
>> Unfortunately this breaks error counters on "0bfd:0017 Kvaser Memorator
>> Professional HS/HS FW 2.0.50", which worked before this commit with the
>> hardcoded capabilities.
>>
>> I'm hitting the "No extended capability support. Upgrade device
>> firmware." case.
>> Personally I have no need for error counters on this specific HW, but it
>> is still a regression.
> 
> Hi Anssi,
> 
> Thanks for testing!
> 
> Right, FW 2.0.50 doesn't support the CMD_GET_CAPABILITIES_{REQ,RESP}.
> It was first introduced in FW 3.9.101 (released 2016-03-01) and was
> later improved in FW 4.2.452 (2017-02-15).
> 
> I can revert the removal of hard coded capabilities, to fix the
> behaviour for devices running older FW.
> Thanks for spotting this!
> 
> Best regards,
> jimmy

Hi Anssi,

Can you please test this again with v3 [1]?

Best regards,
jimmy

[1] https://lore.kernel.org/linux-can/20220901122729.271-5-extja@kvaser.com/
> 
>> On "0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778" this fixes the
>> error counters as expected.
>>
>>
>>>   .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  49 +++---
>>>   .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 144 +++++++++++++++++-
>>>   2 files changed, 160 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c 
>>> b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
>>> index 5caf6e802fc9..d1401a2d23e9 100644
>>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
>>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
>>> @@ -106,21 +106,6 @@ static const struct kvaser_usb_driver_info 
>>> kvaser_usb_driver_info_leaf = {
>>>       .ops = &kvaser_usb_leaf_dev_ops,
>>>   };
>>> -static const struct kvaser_usb_driver_info 
>>> kvaser_usb_driver_info_leaf_err = {
>>> -    .quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
>>> -          KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
>>> -    .family = KVASER_LEAF,
>>> -    .ops = &kvaser_usb_leaf_dev_ops,
>>> -};
>>> -
>>> -static const struct kvaser_usb_driver_info 
>>> kvaser_usb_driver_info_leaf_err_listen = {
>>> -    .quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
>>> -          KVASER_USB_QUIRK_HAS_SILENT_MODE |
>>> -          KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
>>> -    .family = KVASER_LEAF,
>>> -    .ops = &kvaser_usb_leaf_dev_ops,
>>> -};
>>> -
>>>   static const struct kvaser_usb_driver_info 
>>> kvaser_usb_driver_info_leafimx = {
>>>       .quirks = 0,
>>>       .ops = &kvaser_usb_leaf_dev_ops,
>>> @@ -133,41 +118,41 @@ static const struct usb_device_id 
>>> kvaser_usb_table[] = {
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_PRODUCT_ID),
>>>           .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_LS_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_SWC_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_LIN_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_LS_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_SWC_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_DEVEL_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_HSHS_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_UPRO_HSHS_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_GI_PRODUCT_ID),
>>>           .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_OBDII_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_HSLS_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_CH_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_BLACKBIRD_SPRO_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_OEM_MERCURY_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_OEM_LEAF_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_CAN_R_PRODUCT_ID),
>>> -        .driver_info = 
>>> (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
>>> +        .driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
>>>       /* Leaf i.MX28 USB product IDs */
>>>       { USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_V2_PRODUCT_ID),
>>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c 
>>> b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>>> index 4a82550bdda9..838e072d5d62 100644
>>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
>>> @@ -74,6 +74,8 @@
>>>   #define CMD_TX_ACKNOWLEDGE        50
>>>   #define CMD_CAN_ERROR_EVENT        51
>>>   #define CMD_FLUSH_QUEUE_REPLY        68
>>> +#define CMD_GET_CAPABILITIES_REQ    95
>>> +#define CMD_GET_CAPABILITIES_RESP    96
>>>   #define CMD_LEAF_LOG_MESSAGE        106
>>> @@ -83,6 +85,8 @@
>>>   #define KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK BIT(5)
>>>   #define KVASER_USB_LEAF_SWOPTION_FREQ_24_MHZ_CLK BIT(6)
>>> +#define KVASER_USB_LEAF_SWOPTION_EXT_CAP BIT(12)
>>> +
>>>   /* error factors */
>>>   #define M16C_EF_ACKE            BIT(0)
>>>   #define M16C_EF_CRCE            BIT(1)
>>> @@ -278,6 +282,28 @@ struct leaf_cmd_log_message {
>>>       u8 data[8];
>>>   } __packed;
>>> +/* Sub commands for cap_req and cap_res */
>>> +#define KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE 0x02
>>> +#define KVASER_USB_LEAF_CAP_CMD_ERR_REPORT 0x05
>>> +struct kvaser_cmd_cap_req {
>>> +    __le16 padding0;
>>> +    __le16 cap_cmd;
>>> +    __le16 padding1;
>>> +    __le16 channel;
>>> +} __packed;
>>> +
>>> +/* Status codes for cap_res */
>>> +#define KVASER_USB_LEAF_CAP_STAT_OK 0x00
>>> +#define KVASER_USB_LEAF_CAP_STAT_NOT_IMPL 0x01
>>> +#define KVASER_USB_LEAF_CAP_STAT_UNAVAIL 0x02
>>> +struct kvaser_cmd_cap_res {
>>> +    __le16 padding;
>>> +    __le16 cap_cmd;
>>> +    __le16 status;
>>> +    __le32 mask;
>>> +    __le32 value;
>>> +} __packed;
>>> +
>>>   struct kvaser_cmd {
>>>       u8 len;
>>>       u8 id;
>>> @@ -295,6 +321,8 @@ struct kvaser_cmd {
>>>               struct leaf_cmd_chip_state_event chip_state_event;
>>>               struct leaf_cmd_error_event error_event;
>>>               struct leaf_cmd_log_message log_message;
>>> +            struct kvaser_cmd_cap_req cap_req;
>>> +            struct kvaser_cmd_cap_res cap_res;
>>>           } __packed leaf;
>>>           union {
>>> @@ -324,6 +352,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
>>>       [CMD_LEAF_LOG_MESSAGE]        = kvaser_fsize(u.leaf.log_message),
>>>       [CMD_CHIP_STATE_EVENT]        = 
>>> kvaser_fsize(u.leaf.chip_state_event),
>>>       [CMD_CAN_ERROR_EVENT]        = kvaser_fsize(u.leaf.error_event),
>>> +    [CMD_GET_CAPABILITIES_RESP]    = kvaser_fsize(u.leaf.cap_res),
>>>       /* ignored events: */
>>>       [CMD_FLUSH_QUEUE_REPLY]        = CMD_SIZE_ANY,
>>>   };
>>> @@ -606,6 +635,9 @@ static void 
>>> kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
>>>       dev->fw_version = le32_to_cpu(softinfo->fw_version);
>>>       dev->max_tx_urbs = le16_to_cpu(softinfo->max_outstanding_tx);
>>> +    if (sw_options & KVASER_USB_LEAF_SWOPTION_EXT_CAP)
>>> +        dev->card_data.capabilities |= KVASER_USB_CAP_EXT_CAP;
>>> +
>>>       if (dev->driver_info->quirks & KVASER_USB_QUIRK_IGNORE_CLK_FREQ) {
>>>           /* Firmware expects bittiming parameters calculated for 16MHz
>>>            * clock, regardless of the actual clock
>>> @@ -693,6 +725,116 @@ static int kvaser_usb_leaf_get_card_info(struct 
>>> kvaser_usb *dev)
>>>       return 0;
>>>   }
>>> +static int kvaser_usb_leaf_get_single_capability(struct kvaser_usb 
>>> *dev,
>>> +                         u16 cap_cmd_req, u16 *status)
>>> +{
>>> +    struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
>>> +    struct kvaser_cmd *cmd;
>>> +    u32 value = 0;
>>> +    u32 mask = 0;
>>> +    u16 cap_cmd_res;
>>> +    int err;
>>> +    int i;
>>> +
>>> +    cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
>>> +    if (!cmd)
>>> +        return -ENOMEM;
>>> +
>>> +    cmd->id = CMD_GET_CAPABILITIES_REQ;
>>> +    cmd->u.leaf.cap_req.cap_cmd = cpu_to_le16(cap_cmd_req);
>>> +    cmd->len = CMD_HEADER_LEN + sizeof(struct kvaser_cmd_cap_req);
>>> +
>>> +    err = kvaser_usb_send_cmd(dev, cmd, cmd->len);
>>> +    if (err)
>>> +        goto end;
>>> +
>>> +    err = kvaser_usb_leaf_wait_cmd(dev, CMD_GET_CAPABILITIES_RESP, 
>>> cmd);
>>> +    if (err)
>>> +        goto end;
>>> +
>>> +    *status = le16_to_cpu(cmd->u.leaf.cap_res.status);
>>> +
>>> +    if (*status != KVASER_USB_LEAF_CAP_STAT_OK)
>>> +        goto end;
>>> +
>>> +    cap_cmd_res = le16_to_cpu(cmd->u.leaf.cap_res.cap_cmd);
>>> +    switch (cap_cmd_res) {
>>> +    case KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE:
>>> +    case KVASER_USB_LEAF_CAP_CMD_ERR_REPORT:
>>> +        value = le32_to_cpu(cmd->u.leaf.cap_res.value);
>>> +        mask = le32_to_cpu(cmd->u.leaf.cap_res.mask);
>>> +        break;
>>> +    default:
>>> +        dev_warn(&dev->intf->dev, "Unknown capability command %u\n",
>>> +             cap_cmd_res);
>>> +        break;
>>> +    }
>>> +
>>> +    for (i = 0; i < dev->nchannels; i++) {
>>> +        if (BIT(i) & (value & mask)) {
>>> +            switch (cap_cmd_res) {
>>> +            case KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE:
>>> +                card_data->ctrlmode_supported |=
>>> +                        CAN_CTRLMODE_LISTENONLY;
>>> +                break;
>>> +            case KVASER_USB_LEAF_CAP_CMD_ERR_REPORT:
>>> +                card_data->capabilities |=
>>> +                        KVASER_USB_CAP_BERR_CAP;
>>> +                break;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +end:
>>> +    kfree(cmd);
>>> +
>>> +    return err;
>>> +}
>>> +
>>> +static int kvaser_usb_leaf_get_capabilities_leaf(struct kvaser_usb 
>>> *dev)
>>> +{
>>> +    int err;
>>> +    u16 status;
>>> +
>>> +    if (!(dev->card_data.capabilities & KVASER_USB_CAP_EXT_CAP)) {
>>> +        dev_info(&dev->intf->dev,
>>> +             "No extended capability support. Upgrade device 
>>> firmware.\n");
>>> +        return 0;
>>> +    }
>>> +
>>> +    err = kvaser_usb_leaf_get_single_capability(dev,
>>> +                            KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE,
>>> +                            &status);
>>> +    if (err)
>>> +        return err;
>>> +    if (status)
>>> +        dev_info(&dev->intf->dev,
>>> +             "KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE failed %u\n",
>>> +             status);
>>> +
>>> +    err = kvaser_usb_leaf_get_single_capability(dev,
>>> +                            KVASER_USB_LEAF_CAP_CMD_ERR_REPORT,
>>> +                            &status);
>>> +    if (err)
>>> +        return err;
>>> +    if (status)
>>> +        dev_info(&dev->intf->dev,
>>> +             "KVASER_USB_LEAF_CAP_CMD_ERR_REPORT failed %u\n",
>>> +             status);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int kvaser_usb_leaf_get_capabilities(struct kvaser_usb *dev)
>>> +{
>>> +    int err = 0;
>>> +
>>> +    if (dev->driver_info->family == KVASER_LEAF)
>>> +        err = kvaser_usb_leaf_get_capabilities_leaf(dev);
>>> +
>>> +    return err;
>>> +}
>>> +
>>>   static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb 
>>> *dev,
>>>                          const struct kvaser_cmd *cmd)
>>>   {
>>> @@ -1479,7 +1621,7 @@ const struct kvaser_usb_dev_ops 
>>> kvaser_usb_leaf_dev_ops = {
>>>       .dev_get_software_info = kvaser_usb_leaf_get_software_info,
>>>       .dev_get_software_details = NULL,
>>>       .dev_get_card_info = kvaser_usb_leaf_get_card_info,
>>> -    .dev_get_capabilities = NULL,
>>> +    .dev_get_capabilities = kvaser_usb_leaf_get_capabilities,
>>>       .dev_set_opt_mode = kvaser_usb_leaf_set_opt_mode,
>>>       .dev_start_chip = kvaser_usb_leaf_start_chip,
>>>       .dev_stop_chip = kvaser_usb_leaf_stop_chip,
>>
>>
