Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E56F93BC
	for <lists+linux-can@lfdr.de>; Sat,  6 May 2023 21:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjEFTKt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 6 May 2023 15:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFTKs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 6 May 2023 15:10:48 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B0F19B3
        for <linux-can@vger.kernel.org>; Sat,  6 May 2023 12:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683400244; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YqBYNnT+kIfalLvvHpRIwY6nEsDlvMNOyf0Xzd8b5rny6npJXWaUW982W28Fdeui9G
    HZv9Ca3beIa/KyPX7r592Fv+37Ejrb9kbp+MsaYU4DO844WHl6v70gBdiZNZWaL50AnE
    p+SZYO76wq2Oo0o3BXbSIv195EGyXBXz0sBjsK2BRRrY+EBU/zHbTZeB+QqK5t69j5a4
    QXkjhz8i8cLwyaX8dkGDdRa1zxeP8Ni5rv796n2oGcP0VMs1tyi6i6E3Mm3ukGsIBzMD
    7iVcGg/ccWx8ngno7dG6hcsruA8/g4gOCWUWZ/QwudQXGnxPEa0ekSeyd4LV4qG4YUvm
    39rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683400244;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ki8fRXXM6JLPcYvuIQjhQaPS0cnhZSybwpDwTfMIPb8=;
    b=cgnBUZjN0Jr6x9nhn0tcgpKoUkkS1fX3V3o76g7ENL8hWCjaYbzZ+g9ZgETxMtI9hE
    VFzGfwS0dSohd/PvqODBLrJVIj+M76yp8BlXpUAd9UAXtYI5D6Fez/WU1rFDDyGXtZGI
    Z0DOKbLMlVTlsNRwq80Uc7Rd4OaWIJ7RGZkS0ueh3quW/3hKlMuXTMiFcjwTp6QFcR2O
    gS94dKkWyoSbgPs/SmsUmwGOItqTJRqTMDPuGDXHSaPeYxq/z+mhfn7Z0BI77hMkYLxF
    6J0n0deL3PhcJ7GGjyzuK3URkpe/jd4EvYYsKqUwxMY6DatRKXNYpWgFmqwpiKc2tn8y
    oq3Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683400244;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ki8fRXXM6JLPcYvuIQjhQaPS0cnhZSybwpDwTfMIPb8=;
    b=Uig/fjoIii19an6N04a2Dxze/oBDgOqme7P9BrQAtn3DATd2UkCtIIYbYL3MfWDHm4
    47aQkB2td6BgTUVpwzogyOnU0TOAsxB5dLvet+bsllHdnkKnqRkVeXf5qLDrnQxddGnC
    PENpLQBh+RoeXoPSdcB6QXGQK90DLCUShncK5osaIhbe+xk/clv/H7++saVqJakB+VDF
    BnmkvWxJYyQSL1QAA17sCzoUK9aPsqrtLSAViacHC+TmPSvJdwaBM8x3lJTYh1h5UCV3
    kqmxppzanAoZooS0WB4Hjb6ujFAQ5O6zrveWZ78A9VJzXgJENcQXp9JK6pckfNn8QTW8
    pjDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683400244;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ki8fRXXM6JLPcYvuIQjhQaPS0cnhZSybwpDwTfMIPb8=;
    b=5yjp9s6t6W6oKt0Cmo+NZiQ8xapfUAlKAAWJJxNBYnxsOnD7pNbBMmkNscltfd6Hic
    g7IPEj6muRRKn2e4FiAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.4.0 AUTH)
    with ESMTPSA id x06214z46JAhKjl
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 6 May 2023 21:10:43 +0200 (CEST)
Message-ID: <7e25ba42-4aa9-0d88-e708-18462bc7cc48@hartkopp.net>
Date:   Sat, 6 May 2023 21:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] can: kvaser_usb_leaf: Implement CAN 2.0 raw DLC
 functionality.
Content-Language: en-US
To:     Jimmy Assarsson <extja@kvaser.com>,
        Carsten Schmidt <carsten.schmidt-achim@t-online.de>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org
References: <20230506105529.4023-1-carsten.schmidt-achim@t-online.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20230506105529.4023-1-carsten.schmidt-achim@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks for your patch Carsten!

There should be at least one sentence in the commit message even when 
the subject almost covers the story ;-)

Can you also please change the subject to

can: kvaser_usb: add len8_dlc support for kvaser_usb_leaf

to follow up with the other len8_dlc patches?

@Jimmy: AFAIK Carsten only has a Kvaser USB Leaf for testing. Can you 
probably provide and test a similar improvement for the Kvaser USB Hydra 
hardware?

Many thanks,
Oliver

On 06.05.23 12:55, Carsten Schmidt wrote:
> Signed-off-by: Carsten Schmidt <carsten.schmidt-achim@t-online.de>
> ---
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index 1c2f99ce4c6c..713b633773b1 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -573,7 +573,7 @@ kvaser_usb_leaf_frame_to_cmd(const struct kvaser_usb_net_priv *priv,
>   			cmd->u.tx_can.data[1] = cf->can_id & 0x3f;
>   		}
>   
> -		cmd->u.tx_can.data[5] = cf->len;
> +		cmd->u.tx_can.data[5] = can_get_cc_dlc(cf, priv->can.ctrlmode);
>   		memcpy(&cmd->u.tx_can.data[6], cf->data, cf->len);
>   
>   		if (cf->can_id & CAN_RTR_FLAG)
> @@ -1349,7 +1349,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
>   		else
>   			cf->can_id &= CAN_SFF_MASK;
>   
> -		cf->len = can_cc_dlc2len(cmd->u.leaf.log_message.dlc);
> +		can_frame_set_cc_len(cf, cmd->u.leaf.log_message.dlc & 0xF, priv->can.ctrlmode);
>   
>   		if (cmd->u.leaf.log_message.flags & MSG_FLAG_REMOTE_FRAME)
>   			cf->can_id |= CAN_RTR_FLAG;
> @@ -1367,7 +1367,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
>   			cf->can_id |= CAN_EFF_FLAG;
>   		}
>   
> -		cf->len = can_cc_dlc2len(rx_data[5]);
> +		can_frame_set_cc_len(cf, rx_data[5] & 0xF, priv->can.ctrlmode);
>   
>   		if (cmd->u.rx_can_header.flag & MSG_FLAG_REMOTE_FRAME)
>   			cf->can_id |= CAN_RTR_FLAG;
> @@ -1702,6 +1702,7 @@ static int kvaser_usb_leaf_init_card(struct kvaser_usb *dev)
>   	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
>   
>   	card_data->ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
> +	card_data->ctrlmode_supported |= CAN_CTRLMODE_CC_LEN8_DLC;
>   
>   	return 0;
>   }
