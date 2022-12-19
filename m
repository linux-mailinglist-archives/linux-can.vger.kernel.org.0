Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DFB650CD0
	for <lists+linux-can@lfdr.de>; Mon, 19 Dec 2022 14:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiLSNs7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 19 Dec 2022 08:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiLSNs6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 19 Dec 2022 08:48:58 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EB765E5
        for <linux-can@vger.kernel.org>; Mon, 19 Dec 2022 05:48:56 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id cf42so13754862lfb.1
        for <linux-can@vger.kernel.org>; Mon, 19 Dec 2022 05:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZU30zHG3ERwUbIm3zRdx4MfSZLdB8Gimo0F8FKq1kn4=;
        b=xQXmmwmD8EMjBGpHfvoT9+vRe4EwRIc7KCgH6R3IAUtLxBjVEHFEiyGkxWsvlTPkPy
         wZCoah3Giye9DunT1nO5yngfCUMkkbdvPXFi3/Y32Sg7VqKN1qxKJJcEGq+qPSrOGxG/
         XW211yKSgCy3Yw/WKzXn4Xj2dmY3vLTuMTN+PkAviXpVa5MODsofTzcs/YyHGRDiKayR
         SiefcdUOEsavhbgC4/AOjUFtdjsBNxpI80LUrT5mRxK3Z3jZdte9IyBGJR0Q0dnKpwnC
         uIIsaqbEORqvWydgITj9v3fpx9OyyP/g0lS3lEzZjIvOnvg1f8YM891SIEvDSiclPsfD
         3UGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU30zHG3ERwUbIm3zRdx4MfSZLdB8Gimo0F8FKq1kn4=;
        b=jvmDd1ekiD/7/RFvhyHr38YmBaNRA0cf8NbcvA2wZIJw4Fqs/XWyDRkzpEUyhQv9M5
         svfJTUoiU9j9Kd5ze9DH93nWvFPmUjt4EQDQV30tX8xRUTNAzO1+4s13I8Z8BjpvCqHM
         i5am7dLThp28BUIR9byl+CzTtblmKlAmt3vGGELz+cYwvpzWEYIcLEx9Ook14LsxB5oC
         iFEj04Bl0OdTLLY8LR67PEoTv0vHmE6JvU8yhOJBrAk2Jy/pc2QMld7dBk96GaY86mPY
         AmuKhPaCnzWwuDMIOo3IbT5BZBbAMKqg42sXdFFdTC5qAbWkxPtYeKOLZbwJNQOghEUr
         KMpA==
X-Gm-Message-State: ANoB5pns1Aqnum0dKqhbRvTuw9GmKpb8BzFmJ/GkgHnM6d6hSPlLaQkY
        kzAE3T7AqKGeP+GAEDybHk3Ktg==
X-Google-Smtp-Source: AA0mqf4mkuwwDQjzv9PR4v+nSyCjng3KXWhFM6iuvlsXq9HQdBUJdRWRJcjpOWCwACAubEPuRHsVtQ==
X-Received: by 2002:a05:6512:13a2:b0:4a4:68b7:d61d with SMTP id p34-20020a05651213a200b004a468b7d61dmr14424612lfa.4.1671457735274;
        Mon, 19 Dec 2022 05:48:55 -0800 (PST)
Received: from [192.168.16.142] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id z9-20020a056512376900b004b5785b1d9csm1119143lft.302.2022.12.19.05.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 05:48:54 -0800 (PST)
Message-ID: <85b15eee-1f34-4590-063b-6e59eb6bf15a@kvaser.com>
Date:   Mon, 19 Dec 2022 14:48:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] can: kvaser_usb: hydra: help gcc-13 to figure out cmd_len
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        kernel@pengutronix.de
Cc:     Anssi Hannula <anssi.hannula@bitwise.fi>
References: <20221219110104.1073881-1-mkl@pengutronix.de>
From:   Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <20221219110104.1073881-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 12/19/22 12:01, Marc Kleine-Budde wrote:
> Debian's gcc-13 [1] throws the following error in
> kvaser_usb_hydra_cmd_size():
> 
> [1] gcc version 13.0.0 20221214 (experimental) [master r13-4693-g512098a3316] (Debian 13-20221214-1)
> 
> | drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:502:65: error:
> | array subscript ‘struct kvaser_cmd_ext[0]’ is partly outside array
> | bounds of ‘unsigned char[32]’ [-Werror=array-bounds=]
> |   502 |                 ret = le16_to_cpu(((struct kvaser_cmd_ext *)cmd)->len);
> 
> kvaser_usb_hydra_cmd_size() returns the size of given command. It
> depends on the command number (cmd->header.cmd_no). For extended
> commands (cmd->header.cmd_no == CMD_EXTENDED) the above shown code is
> executed.
> 
> Help gcc to recognize that this code path is not taken in all cases,
> by calling kvaser_usb_hydra_cmd_size() directly after assigning the
> command number.
> 
> Cc: Jimmy Assarsson <extja@kvaser.com>
> Cc: Anssi Hannula <anssi.hannula@bitwise.fi>
> Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> 
> Hello,
> 
> Jimmy, Anssi can you test this patch on real hardware?

Hi Marc,

Yes. Now I've tested it and it's working.
Tested-by: Jimmy Assarsson <extja@kvaser.com>

Thanks for fixing this!

Best regards,
jimmy

> regards,
> Marc
> 
>   .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 33 ++++++++++++++-----
>   1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index f688124d6d66..ef341c4254fc 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -545,6 +545,7 @@ static int kvaser_usb_hydra_send_simple_cmd(struct kvaser_usb *dev,
>   					    u8 cmd_no, int channel)
>   {
>   	struct kvaser_cmd *cmd;
> +	size_t cmd_len;
>   	int err;
>   
>   	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
> @@ -552,6 +553,7 @@ static int kvaser_usb_hydra_send_simple_cmd(struct kvaser_usb *dev,
>   		return -ENOMEM;
>   
>   	cmd->header.cmd_no = cmd_no;
> +	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
>   	if (channel < 0) {
>   		kvaser_usb_hydra_set_cmd_dest_he
>   				(cmd, KVASER_USB_HYDRA_HE_ADDRESS_ILLEGAL);
> @@ -568,7 +570,7 @@ static int kvaser_usb_hydra_send_simple_cmd(struct kvaser_usb *dev,
>   	kvaser_usb_hydra_set_cmd_transid
>   				(cmd, kvaser_usb_hydra_get_next_transid(dev));
>   
> -	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
> +	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
>   	if (err)
>   		goto end;
>   
> @@ -584,6 +586,7 @@ kvaser_usb_hydra_send_simple_cmd_async(struct kvaser_usb_net_priv *priv,
>   {
>   	struct kvaser_cmd *cmd;
>   	struct kvaser_usb *dev = priv->dev;
> +	size_t cmd_len;
>   	int err;
>   
>   	cmd = kzalloc(sizeof(*cmd), GFP_ATOMIC);
> @@ -591,14 +594,14 @@ kvaser_usb_hydra_send_simple_cmd_async(struct kvaser_usb_net_priv *priv,
>   		return -ENOMEM;
>   
>   	cmd->header.cmd_no = cmd_no;
> +	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
>   
>   	kvaser_usb_hydra_set_cmd_dest_he
>   		(cmd, dev->card_data.hydra.channel_to_he[priv->channel]);
>   	kvaser_usb_hydra_set_cmd_transid
>   				(cmd, kvaser_usb_hydra_get_next_transid(dev));
>   
> -	err = kvaser_usb_send_cmd_async(priv, cmd,
> -					kvaser_usb_hydra_cmd_size(cmd));
> +	err = kvaser_usb_send_cmd_async(priv, cmd, cmd_len);
>   	if (err)
>   		kfree(cmd);
>   
> @@ -742,6 +745,7 @@ static int kvaser_usb_hydra_get_single_capability(struct kvaser_usb *dev,
>   {
>   	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
>   	struct kvaser_cmd *cmd;
> +	size_t cmd_len;
>   	u32 value = 0;
>   	u32 mask = 0;
>   	u16 cap_cmd_res;
> @@ -753,13 +757,14 @@ static int kvaser_usb_hydra_get_single_capability(struct kvaser_usb *dev,
>   		return -ENOMEM;
>   
>   	cmd->header.cmd_no = CMD_GET_CAPABILITIES_REQ;
> +	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
>   	cmd->cap_req.cap_cmd = cpu_to_le16(cap_cmd_req);
>   
>   	kvaser_usb_hydra_set_cmd_dest_he(cmd, card_data->hydra.sysdbg_he);
>   	kvaser_usb_hydra_set_cmd_transid
>   				(cmd, kvaser_usb_hydra_get_next_transid(dev));
>   
> -	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
> +	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
>   	if (err)
>   		goto end;
>   
> @@ -1578,6 +1583,7 @@ static int kvaser_usb_hydra_get_busparams(struct kvaser_usb_net_priv *priv,
>   	struct kvaser_usb *dev = priv->dev;
>   	struct kvaser_usb_net_hydra_priv *hydra = priv->sub_priv;
>   	struct kvaser_cmd *cmd;
> +	size_t cmd_len;
>   	int err;
>   
>   	if (!hydra)
> @@ -1588,6 +1594,7 @@ static int kvaser_usb_hydra_get_busparams(struct kvaser_usb_net_priv *priv,
>   		return -ENOMEM;
>   
>   	cmd->header.cmd_no = CMD_GET_BUSPARAMS_REQ;
> +	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
>   	kvaser_usb_hydra_set_cmd_dest_he
>   		(cmd, dev->card_data.hydra.channel_to_he[priv->channel]);
>   	kvaser_usb_hydra_set_cmd_transid
> @@ -1597,7 +1604,7 @@ static int kvaser_usb_hydra_get_busparams(struct kvaser_usb_net_priv *priv,
>   
>   	reinit_completion(&priv->get_busparams_comp);
>   
> -	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
> +	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
>   	if (err)
>   		return err;
>   
> @@ -1624,6 +1631,7 @@ static int kvaser_usb_hydra_set_bittiming(const struct net_device *netdev,
>   	struct kvaser_cmd *cmd;
>   	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
>   	struct kvaser_usb *dev = priv->dev;
> +	size_t cmd_len;
>   	int err;
>   
>   	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
> @@ -1631,6 +1639,7 @@ static int kvaser_usb_hydra_set_bittiming(const struct net_device *netdev,
>   		return -ENOMEM;
>   
>   	cmd->header.cmd_no = CMD_SET_BUSPARAMS_REQ;
> +	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
>   	memcpy(&cmd->set_busparams_req.busparams_nominal, busparams,
>   	       sizeof(cmd->set_busparams_req.busparams_nominal));
>   
> @@ -1639,7 +1648,7 @@ static int kvaser_usb_hydra_set_bittiming(const struct net_device *netdev,
>   	kvaser_usb_hydra_set_cmd_transid
>   				(cmd, kvaser_usb_hydra_get_next_transid(dev));
>   
> -	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
> +	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
>   
>   	kfree(cmd);
>   
> @@ -1652,6 +1661,7 @@ static int kvaser_usb_hydra_set_data_bittiming(const struct net_device *netdev,
>   	struct kvaser_cmd *cmd;
>   	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
>   	struct kvaser_usb *dev = priv->dev;
> +	size_t cmd_len;
>   	int err;
>   
>   	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
> @@ -1659,6 +1669,7 @@ static int kvaser_usb_hydra_set_data_bittiming(const struct net_device *netdev,
>   		return -ENOMEM;
>   
>   	cmd->header.cmd_no = CMD_SET_BUSPARAMS_FD_REQ;
> +	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
>   	memcpy(&cmd->set_busparams_req.busparams_data, busparams,
>   	       sizeof(cmd->set_busparams_req.busparams_data));
>   
> @@ -1676,7 +1687,7 @@ static int kvaser_usb_hydra_set_data_bittiming(const struct net_device *netdev,
>   	kvaser_usb_hydra_set_cmd_transid
>   				(cmd, kvaser_usb_hydra_get_next_transid(dev));
>   
> -	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
> +	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
>   
>   	kfree(cmd);
>   
> @@ -1804,6 +1815,7 @@ static int kvaser_usb_hydra_get_software_info(struct kvaser_usb *dev)
>   static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
>   {
>   	struct kvaser_cmd *cmd;
> +	size_t cmd_len;
>   	int err;
>   	u32 flags;
>   	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
> @@ -1813,6 +1825,7 @@ static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
>   		return -ENOMEM;
>   
>   	cmd->header.cmd_no = CMD_GET_SOFTWARE_DETAILS_REQ;
> +	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
>   	cmd->sw_detail_req.use_ext_cmd = 1;
>   	kvaser_usb_hydra_set_cmd_dest_he
>   				(cmd, KVASER_USB_HYDRA_HE_ADDRESS_ILLEGAL);
> @@ -1820,7 +1833,7 @@ static int kvaser_usb_hydra_get_software_details(struct kvaser_usb *dev)
>   	kvaser_usb_hydra_set_cmd_transid
>   				(cmd, kvaser_usb_hydra_get_next_transid(dev));
>   
> -	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
> +	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
>   	if (err)
>   		goto end;
>   
> @@ -1938,6 +1951,7 @@ static int kvaser_usb_hydra_set_opt_mode(const struct kvaser_usb_net_priv *priv)
>   {
>   	struct kvaser_usb *dev = priv->dev;
>   	struct kvaser_cmd *cmd;
> +	size_t cmd_len;
>   	int err;
>   
>   	if ((priv->can.ctrlmode &
> @@ -1953,6 +1967,7 @@ static int kvaser_usb_hydra_set_opt_mode(const struct kvaser_usb_net_priv *priv)
>   		return -ENOMEM;
>   
>   	cmd->header.cmd_no = CMD_SET_DRIVERMODE_REQ;
> +	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
>   	kvaser_usb_hydra_set_cmd_dest_he
>   		(cmd, dev->card_data.hydra.channel_to_he[priv->channel]);
>   	kvaser_usb_hydra_set_cmd_transid
> @@ -1962,7 +1977,7 @@ static int kvaser_usb_hydra_set_opt_mode(const struct kvaser_usb_net_priv *priv)
>   	else
>   		cmd->set_ctrlmode.mode = KVASER_USB_HYDRA_CTRLMODE_NORMAL;
>   
> -	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
> +	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
>   	kfree(cmd);
>   
>   	return err;
