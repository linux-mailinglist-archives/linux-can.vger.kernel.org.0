Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142DB536B5D
	for <lists+linux-can@lfdr.de>; Sat, 28 May 2022 09:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiE1Heh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 28 May 2022 03:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiE1Hef (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 28 May 2022 03:34:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141B827B16
        for <linux-can@vger.kernel.org>; Sat, 28 May 2022 00:34:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a28so5281568lfm.0
        for <linux-can@vger.kernel.org>; Sat, 28 May 2022 00:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=t2lzf8K9LIhbMSrsb1mnmZ8oZMw1QczwDQJGV0vktEo=;
        b=MiEKjeoYhuHognjz/t8DwsKvKfA3v2ARI8ntHo0Cb/q7x3tTFMlGYmAkiHjmpo/3aM
         aIYCTvHOoSN95dBACwAgthJ9eKY/vSYCO4d3/oqjruipDeM0In7BGAJiig2I2rXtoJRE
         9I+4lLkzivgTHge89hJCiJVS8anmQhWAFzFiXLJc4RTfcRAU+c6onIfKJ+eTu0Cw0rmq
         0qXeyaND7t4pWf/pM6yXxAS8fXfA9ow+ilpLkwAmQC41QG1bW56qbScVKvlYVumjE/Ic
         hr3aIMW92zKcFKiu5ONUr+r5kDtoN0hWcuvje7hHwtj035wEw2wk5TX7ZyVvEcUryNX5
         m/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=t2lzf8K9LIhbMSrsb1mnmZ8oZMw1QczwDQJGV0vktEo=;
        b=hucRmpjqM4u4qyVYtaGKaoJ+SHanPaasR7jlTI/uoKYuBCb74ekKo4d/vrk7dwHmR6
         AUXB38ovIoi+W2HVGJbicI6zo6IJV1lhOMgXXuGJWtpp/x5XnobJMmndMUuAn12XYJnj
         ZAaHwm9ArKANy1gVmcRs2iqkhBbl0wpXu7S0ISieDybBjtZOIdf/6EULQWc6lTchOqew
         hCtNfK23Z5/8do/0u95kdTI4siwM/yM9DxL12UHvYJMYSJtIB/N2wHP73ZdsBIXMXszO
         WkjMTZoR392AxoMiCYvq8UvP+7jI0UqCxMOkn7USvFj1wguHudJ4qet7aEOvsjNXmAGm
         SkBQ==
X-Gm-Message-State: AOAM531+2dENPUKrMZj1Avsdbgi4Aj0hZLpWp9HjO3AaMo9ssbna4qBN
        7G/0uKQqDI64W/dHKH0lcHQdqA==
X-Google-Smtp-Source: ABdhPJxvqpjrChid/beZBXnp91CAveI6IIJLEsZzanXlUWd7AiX7NgSikmvuZTGcB73uiS099IRuAQ==
X-Received: by 2002:a05:6512:2204:b0:478:68d9:bb45 with SMTP id h4-20020a056512220400b0047868d9bb45mr21694335lfu.453.1653723271271;
        Sat, 28 May 2022 00:34:31 -0700 (PDT)
Received: from [192.168.16.143] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id i40-20020a0565123e2800b0047866f9b642sm1205604lfv.224.2022.05.28.00.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 00:34:30 -0700 (PDT)
Message-ID: <20ae75a3-13a9-a7a2-6b0d-3df73703e001@kvaser.com>
Date:   Sat, 28 May 2022 09:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Jimmy Assarsson <extja@kvaser.com>
Subject: Re: [PATCH 01/12] can: kvaser_usb_leaf: Fix overread with an invalid
 command
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220516134748.3724796-1-anssi.hannula@bitwise.fi>
 <20220516134748.3724796-2-anssi.hannula@bitwise.fi>
Content-Language: en-US
In-Reply-To: <20220516134748.3724796-2-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 5/16/22 15:47, Anssi Hannula wrote:
> For command events read from the device,
> kvaser_usb_leaf_read_bulk_callback() verifies that cmd->len does not
> exceed the size of the received data, but the actual kvaser_cmd handlers
> will happily read any kvaser_cmd fields without checking for cmd->len.
> 
> This can cause an overread if the last cmd in the buffer is shorter than
> expected for the command type (with cmd->len showing the actual short
> size).
> 
> Maximum overread seems to be 22 bytes (CMD_LEAF_LOG_MESSAGE), some of
> which are delivered to userspace as-is.
> 
> Fix that by verifying the length of command before handling it.
> 
> This issue can only occur after RX URBs have been set up, i.e. the
> interface has been opened at least once.
> 
> Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>

Looks good to me.
Tested-by: Jimmy Assarsson <extja@kvaser.com>


> ---
> 
> A simpler option would be to just zero-pad the data into a
> stack-allocated struct kvaser_cmd without knowledge of the needed
> minimum size (so no tables needed), though that would mean incomplete
> commands would get passed on silently.
> 
>   .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 75 +++++++++++++++++++
>   1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index c805b999c543..d9f40b9702a5 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -320,6 +320,38 @@ struct kvaser_cmd {
>   	} u;
>   } __packed;
>   
> +#define CMD_SIZE_ANY 0xff
> +#define kvaser_fsize(field) sizeof_field(struct kvaser_cmd, field)
> +
> +static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
> +	[CMD_START_CHIP_REPLY]		= kvaser_fsize(u.simple),
> +	[CMD_STOP_CHIP_REPLY]		= kvaser_fsize(u.simple),
> +	[CMD_GET_CARD_INFO_REPLY]	= kvaser_fsize(u.cardinfo),
> +	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.tx_acknowledge_header),
> +	[CMD_GET_SOFTWARE_INFO_REPLY]	= kvaser_fsize(u.leaf.softinfo),
> +	[CMD_RX_STD_MESSAGE]		= kvaser_fsize(u.leaf.rx_can),
> +	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.leaf.rx_can),
> +	[CMD_LEAF_LOG_MESSAGE]		= kvaser_fsize(u.leaf.log_message),
> +	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.leaf.chip_state_event),
> +	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
> +	/* ignored events: */
> +	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
> +};
> +
> +static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
> +	[CMD_START_CHIP_REPLY]		= kvaser_fsize(u.simple),
> +	[CMD_STOP_CHIP_REPLY]		= kvaser_fsize(u.simple),
> +	[CMD_GET_CARD_INFO_REPLY]	= kvaser_fsize(u.cardinfo),
> +	[CMD_TX_ACKNOWLEDGE]		= kvaser_fsize(u.tx_acknowledge_header),
> +	[CMD_GET_SOFTWARE_INFO_REPLY]	= kvaser_fsize(u.usbcan.softinfo),
> +	[CMD_RX_STD_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
> +	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
> +	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.usbcan.chip_state_event),
> +	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
> +	/* ignored events: */
> +	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = CMD_SIZE_ANY,
> +};
> +
>   /* Summary of a kvaser error event, for a unified Leaf/Usbcan error
>    * handling. Some discrepancies between the two families exist:
>    *
> @@ -387,6 +419,43 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_32mhz = {
>   	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
>   };
>   
> +static int kvaser_usb_leaf_verify_size(const struct kvaser_usb *dev,
> +				       const struct kvaser_cmd *cmd)
> +{
> +	/* buffer size >= cmd->len ensured by caller */
> +	u8 min_size = 0;
> +
> +	switch (dev->card_data.leaf.family) {
> +	case KVASER_LEAF:
> +		if (cmd->id < ARRAY_SIZE(kvaser_usb_leaf_cmd_sizes_leaf))
> +			min_size = kvaser_usb_leaf_cmd_sizes_leaf[cmd->id];
> +		break;
> +	case KVASER_USBCAN:
> +		if (cmd->id < ARRAY_SIZE(kvaser_usb_leaf_cmd_sizes_usbcan))
> +			min_size = kvaser_usb_leaf_cmd_sizes_usbcan[cmd->id];
> +		break;
> +	}
> +
> +	if (min_size == CMD_SIZE_ANY)
> +		return 0;
> +
> +	if (min_size) {
> +		min_size += CMD_HEADER_LEN;
> +		if (cmd->len >= min_size)
> +			return 0;
> +
> +		dev_err_ratelimited(&dev->intf->dev,
> +				    "Received command %u too short (size %u, needed %u)",
> +				    cmd->id, cmd->len, min_size);
> +		return -EIO;
> +	}
> +
> +	dev_warn_ratelimited(&dev->intf->dev,
> +			     "Unhandled command (%d, size %d)\n",
> +			     cmd->id, cmd->len);
> +	return -EINVAL;
> +}
> +
>   static void *
>   kvaser_usb_leaf_frame_to_cmd(const struct kvaser_usb_net_priv *priv,
>   			     const struct sk_buff *skb, int *cmd_len,
> @@ -492,6 +561,9 @@ static int kvaser_usb_leaf_wait_cmd(const struct kvaser_usb *dev, u8 id,
>   end:
>   	kfree(buf);
>   
> +	if (err == 0)
> +		err = kvaser_usb_leaf_verify_size(dev, cmd);
> +
>   	return err;
>   }
>   
> @@ -1113,6 +1185,9 @@ static void kvaser_usb_leaf_stop_chip_reply(const struct kvaser_usb *dev,
>   static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
>   					   const struct kvaser_cmd *cmd)
>   {
> +	if (kvaser_usb_leaf_verify_size(dev, cmd) < 0)
> +		return;
> +
>   	switch (cmd->id) {
>   	case CMD_START_CHIP_REPLY:
>   		kvaser_usb_leaf_start_chip_reply(dev, cmd);
