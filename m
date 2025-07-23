Return-Path: <linux-can+bounces-4060-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8503AB0F1ED
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 14:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A42E1AA663A
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE632E4989;
	Wed, 23 Jul 2025 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Fed5ilfl"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-73.smtpout.orange.fr [193.252.22.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D91DE3C8
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272564; cv=none; b=dd8DRX49Ol17QQQOuS65Q718yzoFzgnYj/LkvKEvMwOgDQxzV6SLs6y0Dxs+7Zj7MNrel5HohoHFh1ATxtmxZaBdN5HIY5I/Pv/F0Vnrgf1Gp0AZ9dBHSNRslBMYvCaYtpaLo3ljP39meZK81KLt1RmDpCm8YqwNEzLycggnILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272564; c=relaxed/simple;
	bh=qo+7DASpDKWmwhC72u9fR85+jV9e24ogfzQWgfHT3X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHZr687KoPS0t8KXoconOl0ywRNdc5sx9mcujHGQwdRx0yITcYA2x2AiA8YrFwsyLec6Ek/5UrbgKXE/O+VpObqYdYoo+wDiuovcjmYngJRr4n1Kn5m4HxpU5RUU8UWwwBRtIwrXOfQL2GdLiZ4fzEbxQ2dQWQqCtg2w3eE3VGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Fed5ilfl; arc=none smtp.client-ip=193.252.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eYHZulh94P16reYHauAf4Q; Wed, 23 Jul 2025 14:09:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753272556;
	bh=btH24E1AmvXvA9ydQSmWKgNcyq3bXZXBzarHA2TYbwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Fed5ilfllynKMiTGgeq+993ezGdn1M/xlCOyo6qbIqa3TrA0zY9aNAORJnYJNiOpz
	 y+IwStsTPvqNIBNMger5/Qs4vycrusEPnj8rUZ8vpsSAEWhC0FOxdRzTFOhU0ydMtj
	 KKc/d1xnLgrZDP6kfMcG7r4rhr9cj1sbZ/CXlssuOTIHesUITL1HT2HU6Vo4TgjdiQ
	 5A2FkQAiAGbAtY/p0AQtwSSYTsyvlkabXgOGK2QGZ7ZcXzvq9wtzimnTtKiWVWa/1k
	 dTSXUc8s4ptwzdTAxSUQOszOw/HCuz4lg5iXQkmJ6wBEBVADnRL35OOSKxRfoy5b7n
	 1T9DRMce969PQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Jul 2025 14:09:16 +0200
X-ME-IP: 124.33.176.97
Message-ID: <d394ac75-09bb-4682-aa6d-0209688f5a6d@wanadoo.fr>
Date: Wed, 23 Jul 2025 21:09:11 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] can: kvaser_pciefd: Add support to control CAN LEDs
 on device
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Axel Forsman <axfo@kvaser.com>
References: <20250723083236.9-1-extja@kvaser.com>
 <20250723083236.9-2-extja@kvaser.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250723083236.9-2-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 at 17:32, Jimmy Assarsson wrote:
> Add support to turn on/off CAN LEDs on device.
> Turn off all CAN LEDs in probe, since they are default on after a reset or
> power on.
> 
> Reviewed-by: Axel Forsman <axfo@kvaser.com>
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/kvaser_pciefd.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
> index 09510663988c..c8f530ef416e 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -66,6 +66,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
>  #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
>  #define KVASER_PCIEFD_KCAN_CTRL_REG 0x2c0
>  #define KVASER_PCIEFD_KCAN_CMD_REG 0x400
> +#define KVASER_PCIEFD_KCAN_IOC_REG 0x404
>  #define KVASER_PCIEFD_KCAN_IEN_REG 0x408
>  #define KVASER_PCIEFD_KCAN_IRQ_REG 0x410
>  #define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG 0x414
> @@ -136,6 +137,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
>  /* Request status packet */
>  #define KVASER_PCIEFD_KCAN_CMD_SRQ BIT(0)
>  
> +/* Control CAN LED, active low */
> +#define KVASER_PCIEFD_KCAN_IOC_LED BIT(0)
> +
>  /* Transmitter unaligned */
>  #define KVASER_PCIEFD_KCAN_IRQ_TAL BIT(17)
>  /* Tx FIFO empty */
> @@ -410,6 +414,7 @@ struct kvaser_pciefd_can {
>  	struct kvaser_pciefd *kv_pcie;
>  	void __iomem *reg_base;
>  	struct can_berr_counter bec;
> +	u32 ioc;
>  	u8 cmd_seq;
>  	u8 tx_max_count;
>  	u8 tx_idx;
> @@ -528,6 +533,16 @@ static inline void kvaser_pciefd_abort_flush_reset(struct kvaser_pciefd_can *can
>  	kvaser_pciefd_send_kcan_cmd(can, KVASER_PCIEFD_KCAN_CMD_AT);
>  }
>  
> +static inline void kvaser_pciefd_set_led(struct kvaser_pciefd_can *can, bool on)
> +{
> +	if (on)
> +		can->ioc &= ~KVASER_PCIEFD_KCAN_IOC_LED;
> +	else
> +		can->ioc |= KVASER_PCIEFD_KCAN_IOC_LED;
> +
> +	iowrite32(can->ioc, can->reg_base + KVASER_PCIEFD_KCAN_IOC_REG);
> +}
> +
>  static void kvaser_pciefd_enable_err_gen(struct kvaser_pciefd_can *can)
>  {
>  	u32 mode;
> @@ -990,6 +1005,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>  		/* Disable Bus load reporting */
>  		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
>  
> +		can->ioc = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_IOC_REG);

Nitpick: shouldn't this line go into kvaser_pciefd_set_led() ?

> +		kvaser_pciefd_set_led(can, false);
> +
>  		tx_nr_packets_max =
>  			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
>  				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));

Yours sincerely,
Vincent Mailhol


