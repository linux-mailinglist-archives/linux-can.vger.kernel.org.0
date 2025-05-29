Return-Path: <linux-can+bounces-3730-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 937B3AC754F
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 03:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAC67AC4CB
	for <lists+linux-can@lfdr.de>; Thu, 29 May 2025 01:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CE72F37;
	Thu, 29 May 2025 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="X1TCfHlp"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BA2F3E
	for <linux-can@vger.kernel.org>; Thu, 29 May 2025 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748481483; cv=none; b=O+A42FFkI3KxuHo1+SKZPWjkguHdQFwcIY91ndc6TfYEZlxurOViWIxYHk1ldL9Wly5YMDZlgrE0pUSaH+qweZgk+Lid9js0Vr+W8R+w2EHxDPuGwboOsjXwrI52oCdq4u0qKpLJeTgtO3be/wsZ+5fp5LCn8uawpeYM8qdwmo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748481483; c=relaxed/simple;
	bh=w4Y/9xGKBsm888F+DVQttTfnl9hYltSZkw0qfy3YjHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=YeSGfI/62AVT+6iEaIh20tts0cmFCepzuDdqO821dfKqSDZJdl+5y5q2gBVxxSrAjGsfxvjYVvBgvNmSZi0hligi/qfY766c4Uwg9IZhi3iz12tW5UIxnxuba3ZBHMa603gyJGHw5H790juFUj3e+W1H/l39NG7U3GkVg3AdFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=X1TCfHlp; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id KRu5uIyBAdABIKRu6uVRVU; Thu, 29 May 2025 03:17:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748481476;
	bh=59yt0puZwFnTJ9fGmIKzI+iF07Hc+qzB0R4jl4ark34=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=X1TCfHlpU6A22ibUXbLWMXapYJx4mBumqPTVBFh8Vdoviw9pT0ZUcVz07xD1IBDR5
	 /yvZQhH/7JEqu1kwl1bAkcsPEnRqz9nMEzC1J0lIWG9KIWTmAodukVaUxeFL5JS9iF
	 GaQnQJjQduAgrEOZVfsWzLoJ2M4rAjEcEi3v/0WUEvXlndHaml94+Gtju+b5euVm1s
	 D1q3LV/JeQzb1z6OZOse98wIrAJ2v/0cRt7Q8hGVR7JxPUg0YLuh/2gqTvXorxnDJc
	 e+9d7IbZxNXSeaQ6TWCziBcOeTvQp03HxZZFpe2jKBVix80smRyTHB+9OJPyuj7i6A
	 C9PDUyjbEeKMQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 29 May 2025 03:17:56 +0200
X-ME-IP: 124.33.176.97
Message-ID: <de950905-ad60-453d-b2bc-d1115234e273@wanadoo.fr>
Date: Thu, 29 May 2025 10:17:52 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] can: canxl: add PWM config support
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20250527195625.65252-1-socketcan@hartkopp.net>
 <20250527195625.65252-10-socketcan@hartkopp.net>
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
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
In-Reply-To: <20250527195625.65252-10-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Oliver,

How do you want to move forward on this?

I stopped my work, waiting for my preparation patches to be merged and for the
PWM calculation to be clarified. Now that those two blockers are removed, I was
about to resume the work.

Do you plan to take over? It will be complicated if both of us work
simultaneously on the feature.


On 28/05/2025 at 04:56, Oliver Hartkopp wrote:
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev/netlink.c    | 31 ++++++++++++++++++++++++++++++-
>  include/linux/can/bittiming.h    | 25 +++++++++++++++++++++++++
>  include/linux/can/dev.h          |  1 +
>  include/uapi/linux/can/netlink.h | 15 +++++++++++++++
>  4 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 1b798a7dcd64..685cceb74048 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -23,10 +23,11 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
>  	[IFLA_CAN_TDC] = { .type = NLA_NESTED },
>  	[IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
>  	[IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
>  	[IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
>  	[IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
> +	[IFLA_CAN_XL_PWM] = { .type = NLA_NESTED },
>  };
>  
>  static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
>  	[IFLA_CAN_TDC_TDCV_MIN] = { .type = NLA_U32 },
>  	[IFLA_CAN_TDC_TDCV_MAX] = { .type = NLA_U32 },
> @@ -37,10 +38,16 @@ static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
>  	[IFLA_CAN_TDC_TDCV] = { .type = NLA_U32 },
>  	[IFLA_CAN_TDC_TDCO] = { .type = NLA_U32 },
>  	[IFLA_CAN_TDC_TDCF] = { .type = NLA_U32 },
>  };
>  
> +static const struct nla_policy can_pwm_policy[IFLA_CAN_PWM_MAX + 1] = {
> +	[IFLA_CAN_PWM_OFFSET] = { .type = NLA_U8 },
> +	[IFLA_CAN_PWM_LONG] = { .type = NLA_U8 },
> +	[IFLA_CAN_PWM_SHORT] = { .type = NLA_U8 },
> +};

ISO 11898-1 uses the accronyms PWML, PWMO and PWMS. I would prefer to keep the
exact same naming as the standard.

Also, +1 to what Marc said, u32 seems better here.

>  static int can_validate_bittiming(const struct can_bittiming *bt,
>  				  struct netlink_ext_ack *extack)
>  {
>  	/* sample point is in one-tenth of a percent */
>  	if (bt->sample_point >= 1000) {
> @@ -464,10 +471,29 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>  				 can_xl_tdc_is_enabled(priv),
>  				 CAN_CTRLMODE_XL_TDC_MASK, extack);
>  	if (err)
>  		return err;
>  
> +	/* CAN XL transceiver PWM configuration */
> +	if (data[IFLA_CAN_XL_PWM]) {
> +		struct nlattr *tb_pwm[IFLA_CAN_PWM_MAX + 1];
> +
> +		err = nla_parse_nested(tb_pwm, IFLA_CAN_PWM_MAX, data[IFLA_CAN_XL_PWM],
> +				       can_pwm_policy, extack);
> +		if (err)
> +			return err;
> +
> +		if (tb_pwm[IFLA_CAN_PWM_OFFSET])
> +			priv->pwm.pwm_offset = nla_get_u8(tb_pwm[IFLA_CAN_PWM_OFFSET]) & 0x3F;
> +
> +		if (tb_pwm[IFLA_CAN_PWM_LONG])
> +			priv->pwm.pwm_phase_long = nla_get_u8(tb_pwm[IFLA_CAN_PWM_LONG]) & 0x3F;
> +
> +		if (tb_pwm[IFLA_CAN_PWM_SHORT])
> +			priv->pwm.pwm_phase_short = nla_get_u8(tb_pwm[IFLA_CAN_PWM_SHORT]) & 0x3F;
> +	}
> +
>  	if (data[IFLA_CAN_TERMINATION]) {
>  		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
>  		const unsigned int num_term = priv->termination_const_cnt;
>  		unsigned int i;
>  
> @@ -573,10 +599,11 @@ static size_t can_get_size(const struct net_device *dev)
>  		size += nla_total_size(sizeof(*priv->xl.data_bitrate_const) *
>  				       priv->xl.data_bitrate_const_cnt);
>  	size += can_tdc_get_size(&priv->xl,			/* IFLA_CAN_XL_TDC */
>  				 can_xl_tdc_is_enabled(priv),
>  				 priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL);
> +	size += nla_total_size(sizeof(struct can_pwm));

This looks wrong. Does this work? The size of a nested NLA is the sum of its NLA
members. Look at can_tdc_get_size().

>  	return size;
>  }
>  
>  static int can_tdc_fill_info(struct sk_buff *skb,  const struct net_device *dev,
> @@ -734,11 +761,13 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  		     priv->xl.data_bitrate_const_cnt,
>  		     priv->xl.data_bitrate_const)) ||
>  
>  	    can_tdc_fill_info(skb, dev, &priv->xl, can_xl_tdc_is_enabled(priv),
>  			      priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL,
> -			      IFLA_CAN_XL_TDC)
> +			      IFLA_CAN_XL_TDC) ||
> +
> +	    nla_put(skb, IFLA_CAN_XL_PWM, sizeof(priv->pwm), &priv->pwm)

Same as above.

>  	    )
>  
>  		return -EMSGSIZE;
>  
>  	return 0;
> diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
> index 2053b9dff0ad..47e266ab7486 100644
> --- a/include/linux/can/bittiming.h
> +++ b/include/linux/can/bittiming.h
> @@ -114,10 +114,35 @@ struct can_tdc_const {
>  	u32 tdco_max;
>  	u32 tdcf_min;
>  	u32 tdcf_max;
>  };
>  
> +/*
> + * struct can_pwm - PWM configuration for switchable CAN XL transceivers
> + *
> + * -+-- init-offset -+------- one bit in CAN XL data mode --------+- TX pin
> + *  |<--- Offset --->|
> + *                   |<-------- Long 1 -------->|<--- Short 0 --->|  level_1
> + *                   |<--- Short 1 --->|<-------- Long 0 -------->|  level_0
> + *                                          |
> + *                                 (50/50 sample point)
> + *
> + * The duration of a complete PWM bit representation has to be < 200ns to
> + * reliably switch the CAN XL transceiver into the CAN XL data mode.
> + *
> + * @pwm_offset: Offset before first PWM bit trasmmission to fill the ADH bit
> + *
> + * @pwm_phase_long: PWM Phase Long (ideally 75% of PWM bit representation)
> + *
> + * @pwm_phase_short: PWM Phase Short (ideally 25% of PWM bit representation)
> + */
> +struct can_pwm {
> +	u8 pwm_offset;
> +	u8 pwm_phase_long;
> +	u8 pwm_phase_short;
> +};
> +
>  #ifdef CONFIG_CAN_CALC_BITTIMING
>  int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
>  		       const struct can_bittiming_const *btc, struct netlink_ext_ack *extack);
>  
>  void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 1ac98914f351..6b65b3fccfd2 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -60,10 +60,11 @@ struct can_priv {
>  	struct can_bittiming bittiming;
>  	struct data_bittiming_params fd, xl;
>  	unsigned int bitrate_const_cnt;
>  	const u32 *bitrate_const;
>  	u32 bitrate_max;
> +	struct can_pwm pwm;
>  	struct can_clock clock;
>  
>  	unsigned int termination_const_cnt;
>  	const u16 *termination_const;
>  	u16 termination;
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
> index 163a6167264e..bd3706b37e04 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -146,16 +146,31 @@ enum {
>  	IFLA_CAN_CTRLMODE_EXT,
>  	IFLA_CAN_XL_DATA_BITTIMING,
>  	IFLA_CAN_XL_DATA_BITTIMING_CONST,
>  	IFLA_CAN_XL_DATA_BITRATE_CONST,
>  	IFLA_CAN_XL_TDC,
> +	IFLA_CAN_XL_PWM,
>  
>  	/* add new constants above here */
>  	__IFLA_CAN_MAX,
>  	IFLA_CAN_MAX = __IFLA_CAN_MAX - 1
>  };
>  
> +/*
> + * CAN XL Transceiver data mode switching PWM configuration
> + */
> +enum {
> +	IFLA_CAN_PWM_UNSPEC,
> +	IFLA_CAN_PWM_OFFSET,	/* u8 */
> +	IFLA_CAN_PWM_LONG,	/* u8 */
> +	IFLA_CAN_PWM_SHORT,	/* u8 */
> +
> +	/* add new constants above here */
> +	__IFLA_CAN_PWM,
> +	IFLA_CAN_PWM_MAX = __IFLA_CAN_PWM - 1
> +};
> +
>  /*
>   * CAN FD/XL Transmitter Delay Compensation (TDC)
>   *
>   * Please refer to struct can_tdc_const and can_tdc in
>   * include/linux/can/bittiming.h for further details.

Yours sincerely,
Vincent Mailhol


