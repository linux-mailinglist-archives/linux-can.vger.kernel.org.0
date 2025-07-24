Return-Path: <linux-can+bounces-4113-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D073B110D3
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 20:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DD63AAC19
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66292EBB81;
	Thu, 24 Jul 2025 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMw0bson"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8987054723;
	Thu, 24 Jul 2025 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381576; cv=none; b=V6yBWUzHOyWZZHSyrxfk9YqUinjwq44yPGyvn8rjsaGFIBL4DR94fNR4ECiTywHUFs5rPislKPdIzkbGU9vm0y7d8656PvhvzhPNKMiYVfbMAuW8t8k59Gh+86h7DQvP00+vwhTAuMaA8p1qn2430cJtv06WyPjBM3zaVywZx/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381576; c=relaxed/simple;
	bh=uZxpqiy9RYnUpyxVCBBeUpjPcCp+DX2Powuds3EtP9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WezJ4bYndCAzwkWKVAg8EfHLAiLpVqCmKPGPn6Bqwrx6qNPc02/g9gjBmGgu99oz//+XFmJ4lE2Wzb5IoMpFrNYtVcwgql0F8QLqMBaI6Gp66IfOld9Bk/T2kMeZP42drAz/jC/5SWyCc+yiGsU+lnUMINWEe6dT0kdne5Zn/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMw0bson; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37C0C4CEED;
	Thu, 24 Jul 2025 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753381575;
	bh=uZxpqiy9RYnUpyxVCBBeUpjPcCp+DX2Powuds3EtP9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMw0bsonIskMUxMWW1Oh4sXlAZ3xVEn9WH9sgAJKe8Jw7WgH51cgTzhCjNHQup6Z6
	 1UPyUxOcAIu/K7uAcMaZaWPow7h1fSa6oHd3re9j8ID5gtT9XFHKgRoMSZZzSVAZKs
	 cksw0LNvSmAENglw89ZOjGlpdpGfYjHy6CIWhJGNzvupZWNy20ANKSHgMDONu5KVcz
	 NmVpTnuWd2aFzIlXusNOyTPmqJxz0vuYzqnpJSlKFsZmiFgJB+wApkITUgsUlWOI1M
	 sNlxtgL8IDtUpJdYsGLeScvY3uUuNwJxxxKD0vuYKJGO1++PuX/VrJP5dS3tTgygke
	 7AiU2h3x0s5xw==
Date: Thu, 24 Jul 2025 19:26:11 +0100
From: Simon Horman <horms@kernel.org>
To: Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Jimmy Assarsson <jimmyassarsson@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 01/11] can: kvaser_usb: Add support to control CAN
 LEDs on device
Message-ID: <20250724182611.GC1266901@horms.kernel.org>
References: <20250724092505.8-1-extja@kvaser.com>
 <20250724092505.8-2-extja@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724092505.8-2-extja@kvaser.com>

On Thu, Jul 24, 2025 at 11:24:55AM +0200, Jimmy Assarsson wrote:
> Add support to turn on/off CAN LEDs on device.
> 
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>

...

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c

...

> +static int kvaser_usb_hydra_set_led(struct kvaser_usb_net_priv *priv,
> +				    enum kvaser_usb_led_state state,
> +				    u16 duration_ms)
> +{
> +	struct kvaser_usb *dev = priv->dev;
> +	struct kvaser_cmd *cmd;
> +	int ret;
> +
> +	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	cmd->header.cmd_no = CMD_LED_ACTION_REQ;
> +	kvaser_usb_hydra_set_cmd_dest_he(cmd, dev->card_data.hydra.sysdbg_he);
> +	kvaser_usb_hydra_set_cmd_transid(cmd, kvaser_usb_hydra_get_next_transid(dev));
> +
> +	cmd->led_action_req.duration_ms = cpu_to_le16(duration_ms);
> +	cmd->led_action_req.action = state |
> +				     FIELD_PREP(KVASER_USB_HYDRA_LED_IDX_MASK,
> +						KVASER_USB_HYDRA_LED_YELLOW_CH0_IDX +
> +						KVASER_USB_HYDRA_LEDS_PER_CHANNEL * priv->channel);
> +
> +	ret = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));

When building this file with GCC 15.1.0 with KCFLAGS=-Warray-bounds
I see the following:

  In file included from ./include/linux/byteorder/little_endian.h:5,
                   from ./arch/x86/include/uapi/asm/byteorder.h:5,
                   from ./include/linux/bitfield.h:12,
                   from drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:15:
  In function 'kvaser_usb_hydra_cmd_size',
      inlined from 'kvaser_usb_hydra_set_led' at drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:1993:38:
  drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:532:65: warning: array subscript 'struct kvaser_cmd_ext[0]' is partly outside array bounds of 'unsigned char[32]' [-Warray-bounds=]
    532 |                 ret = le16_to_cpu(((struct kvaser_cmd_ext *)cmd)->len);
  ./include/uapi/linux/byteorder/little_endian.h:37:51: note: in definition of macro '__le16_to_cpu'
     37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
        |                                                   ^
  drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:532:23: note: in expansion of macro 'le16_to_cpu'
    532 |                 ret = le16_to_cpu(((struct kvaser_cmd_ext *)cmd)->len);
        |                       ^~~~~~~~~~~
  In file included from ./include/linux/fs.h:46,
                   from ./include/linux/compat.h:17,
                   from ./arch/x86/include/asm/ia32.h:7,
                   from ./arch/x86/include/asm/elf.h:10,
                   from ./include/linux/elf.h:6,
                   from ./include/linux/module.h:19,
                   from ./include/linux/device/driver.h:21,
                   from ./include/linux/device.h:32,
                   from drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:17:
  In function 'kmalloc_noprof',
      inlined from 'kzalloc_noprof' at ./include/linux/slab.h:1039:9,
      inlined from 'kvaser_usb_hydra_set_led' at drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:1979:8:
  ./include/linux/slab.h:905:24: note: object of size 32 allocated by '__kmalloc_cache_noprof'
    905 |                 return __kmalloc_cache_noprof(
        |                        ^~~~~~~~~~~~~~~~~~~~~~~
    906 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
        |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    907 |                                 flags, size);
        |                                 ~~~~~~~~~~~~

	if (cmd->header.cmd_no == CMD_EXTENDED)
		ret = le16_to_cpu(((struct kvaser_cmd_ext *)cmd)->len);

GCC seems to know that:
* cmd was allocated sizeof(*cmd) = 32 bytes
* struct kvaser_cmd_ext is larger than this (96 bytes)

And it thinks that cmd->header.cmd_no might be CMD_EXTENDED.
This is not true, becuae .cmd_no is set to CMD_LED_ACTION_REQ
earlier in kvaser_usb_hydra_set_led. But still, GCC produces
a big fat warning.

On the one hand we might say this is a shortcoming in GCC,
a position I agree with. But on the other hand, we might follow
the pattern used elsewhere in this file for similar functions,
which seems to make GCC happy, I guess, and it is strictly a guess,
because less context is needed for it to analyse things correctly.

That is, do this:

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 758fd13f1bf4..a4402b4845c6 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1974,6 +1974,7 @@ static int kvaser_usb_hydra_set_led(struct kvaser_usb_net_priv *priv,
 {
 	struct kvaser_usb *dev = priv->dev;
 	struct kvaser_cmd *cmd;
+	size_t cmd_len;
 	int ret;
 
 	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
@@ -1981,6 +1982,7 @@ static int kvaser_usb_hydra_set_led(struct kvaser_usb_net_priv *priv,
 		return -ENOMEM;
 
 	cmd->header.cmd_no = CMD_LED_ACTION_REQ;
+	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
 	kvaser_usb_hydra_set_cmd_dest_he(cmd, dev->card_data.hydra.sysdbg_he);
 	kvaser_usb_hydra_set_cmd_transid(cmd, kvaser_usb_hydra_get_next_transid(dev));
 
@@ -1990,7 +1992,7 @@ static int kvaser_usb_hydra_set_led(struct kvaser_usb_net_priv *priv,
 						KVASER_USB_HYDRA_LED_YELLOW_CH0_IDX +
 						KVASER_USB_HYDRA_LEDS_PER_CHANNEL * priv->channel);
 
-	ret = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
+	ret = kvaser_usb_send_cmd(dev, cmd, cmd_len);
 	kfree(cmd);
 
 	return ret;

> +	kfree(cmd);
> +
> +	return ret;
> +}

...

