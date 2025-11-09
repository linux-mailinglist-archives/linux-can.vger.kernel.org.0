Return-Path: <linux-can+bounces-5320-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30259C43F20
	for <lists+linux-can@lfdr.de>; Sun, 09 Nov 2025 14:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8E4188BF86
	for <lists+linux-can@lfdr.de>; Sun,  9 Nov 2025 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215702E7BC9;
	Sun,  9 Nov 2025 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGiw7K2H"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03C626E715
	for <linux-can@vger.kernel.org>; Sun,  9 Nov 2025 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762695752; cv=none; b=H5NUg6VOXmVkmiC1vqh4k6Zaowa98G6+u6Wc7uAYF7gmx9b35RTTLg37r9bX6Ya+oP5FFszS0YychMkPsoI4JS7YSKcjyIwlGcJpzxBHSnO48Olfn7U1Qtuu2DXpNwTId4r1rNwjkJz6xUWcNekvuQONIXe7ZLm/tr5hUuDlGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762695752; c=relaxed/simple;
	bh=mXulvIQwnvf01MSB+jKzkJyYUMuQS79srD709QqHwJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W3A/XA8CBUWZcxaRQvzDS1lIwqesMUU8xPC6a8fQ5eO0vQD62D333lRbwf5jbAbl8VT61gBUPkaJ9ko7uvpALNVliS0VaRo3h6GQOFNFV9BMpwUgNtm7Tx6eby+jluID80IYVaVXnqRdaDlyTtvW/aSvSY2J6tgHTURvhnEtJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGiw7K2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3941C19422;
	Sun,  9 Nov 2025 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762695751;
	bh=mXulvIQwnvf01MSB+jKzkJyYUMuQS79srD709QqHwJg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=pGiw7K2HhjYN3YR/hWZIizzcUhFaFpDLleL1qRfBYqyIVts+CM7o5NRzlI4oM03fI
	 7z8XQVqh38xdErWi5j/GhKGTA1ULjy/UlKjyNm3rPZV9oIpxhWuuPa+gcC3IqvwXmv
	 ftPkhSXHCGdxet39JDx2ZJbn39bgUoon3lzwBjBbR4ZqVXvZ0Izq03zRV006PIFMVG
	 K780fJmKg4RUAJyf+M8aq/rnLNgmO9vW/fBw+FJWx2nwPCKEbm7D74IYLuHbY0vLVh
	 0qObVX6eHAMVjf+RHicCkxmiixt2hmW4zGWu9Y5UQkSWDmHh5fHdlWGFjL5OwcfhdF
	 pDgpBEAH8lKBA==
Message-ID: <a76a6805-d04a-44c0-9ccb-19fc2636ff7e@kernel.org>
Date: Sun, 9 Nov 2025 14:42:28 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH b4/canxl-netlink v2] can: drop unsupported CAN frames on
 socket and netdev level
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20251103185336.32772-1-socketcan@hartkopp.net>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20251103185336.32772-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 03/11/2025 at 19:53, Oliver Hartkopp wrote:
> Rework the checks for skbs containing CAN CC/FD/XL frames.
> 
> For real CAN interfaces the CAN_CTRLMODE_FD and CAN_CTRLMODE_XL control
> modes indicate whether an interface can handle those CAN FD/XL frames.
> 
> In the case a CAN XL interface is used with "TMS on" or "ERR_SIGNAL off"
> neither CAN CC nor CAN FD frames are supported to be sent. Add a check
> for the so-called 'mixed mode' (CC/FD/XL) in can_dev_cc_enabled().
> 
> CAN_CTRLMODE_FD is ensured to be disabled when TMS is enabled or
> ERR_SIGNAL is off.
> 
> The checks are performed on CAN_RAW sockets to give an instant feedback
> to the user when writing unsupported CAN frames to the interface.
> 
> Additionally we check for correct skbs on CAN netdev level in the case
> the CAN frames are provided via PF_PACKET sockets.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  include/linux/can/dev.h | 57 ++++++++++++++++++++++++++++++++++++++++-
>  net/can/raw.c           | 19 +++++++-------
>  2 files changed, 65 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 945c16743702..23743c44d300 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h
> @@ -129,10 +129,52 @@ int can_restart_now(struct net_device *dev);
>  void can_bus_off(struct net_device *dev);
>  
>  const char *can_get_state_str(const enum can_state state);
>  const char *can_get_ctrlmode_str(u32 ctrlmode);
>  
> +static inline bool can_dev_cc_enabled(struct net_device *dev)
> +{
> +	struct can_priv *priv = safe_candev_priv(dev);
> +
> +#define MIXED_MODE (CAN_CTRLMODE_FD | CAN_CTRLMODE_XL)
           ^^^^^^^^^^
If this is just used locally in one function, declare it as a u32:

	const u32 mixed_mode = CAN_CTRLMODE_FD | CAN_CTRLMODE_XL;

If you want to keep the #define, add a CAN_ prefix to avoid namespace pollution
and put it at the top of the file.

> +	/* When CAN XL is enabled but FD is disabled we are not running in the
> +	 * so-called 'mixed mode' (CC/FD/XL with TMS OFF and ERR_SIGNAL ON).
> +	 * Then either TMS is ON or ERR_SIGNAL is OFF in which cases the
> +	 * resulting XL-only mode does not allow the sending of CC/FD frames.
> +	 */

If we do this, then the user doing:

	ip link set can0 type can bitrate 1000000 \
		fd off \
		xl on xbitrate 10000000 tms off err-signal on

will get the Classical CAN disabled for no apparent reasons.

Even if the mixed mode is meant for CC + FD + XL, I think it is fair to allow
the end user to request mixed mode with FD disabled (i.e. just keep CC and XL).

> +	if (priv)
> +		return !((priv->ctrlmode & MIXED_MODE) == CAN_CTRLMODE_XL);

What about:

	if (priv)
		return !(priv->ctrlmode & CAN_CTRLMODE_XL) ||
			(priv->ctrlmode & CAN_CTRLMODE_XL_ERR_SIGNAL);

?

> +	/* virtual CAN interfaces always support CAN CC */
> +	return true;
> +}
> +
> +static inline bool can_dev_fd_enabled(struct net_device *dev)
> +{
> +	struct can_priv *priv = safe_candev_priv(dev);
> +
> +	/* check FD ctrlmode on real CAN interfaces */
> +	if (priv)
> +		return (priv->ctrlmode & CAN_CTRLMODE_FD);
> +
> +	/* check MTU for virtual CAN FD interfaces */
> +	return (READ_ONCE(dev->mtu) >= CANFD_MTU);
> +}
> +
> +static inline bool can_dev_xl_enabled(struct net_device *dev)
> +{
> +	struct can_priv *priv = safe_candev_priv(dev);
> +
> +	/* check XL ctrlmode on real CAN interfaces */
> +	if (priv)
> +		return (priv->ctrlmode & CAN_CTRLMODE_XL);
> +
> +	/* check MTU for virtual CAN XL interfaces */
> +	return (READ_ONCE(dev->mtu) >= CANXL_MIN_MTU);
> +}
> +
>  /* drop skb if it does not contain a valid CAN frame for sending */
>  static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *skb)
>  {
>  	struct can_priv *priv = netdev_priv(dev);
>  	u32 silent_mode = priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
> @@ -142,15 +184,28 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
>  		netdev_info_once(dev, "interface in %s mode, dropping skb\n",
>  				 can_get_ctrlmode_str(silent_mode));
>  		goto invalid_skb;
>  	}
>  
> -	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
> +	/* Classical CAN */
> +	if (can_is_can_skb(skb) && !can_dev_cc_enabled(dev)) {
> +		netdev_info_once(dev, "CAN CC with TMS on, dropping skb\n");
> +		goto invalid_skb;
> +	}
> +
> +	/* CAN FD */
> +	if (can_is_canfd_skb(skb) && !can_dev_fd_enabled(dev)) {
>  		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
>  		goto invalid_skb;
>  	}
>  
> +	/* CAN XL */
> +	if (can_is_canxl_skb(skb) && !can_dev_xl_enabled(dev)) {
> +		netdev_info_once(dev, "CAN XL is disabled, dropping skb\n");
> +		goto invalid_skb;
> +	}
> +

The can_dev_*_enabled() functions use safe_candev_priv(), but
can_dev_dropped_skb() is only called by the devices which have a valid priv
member. So, in this context, the safe_candev_priv() becomes useless and the FD
and XL MTU checks are dead code.

The can_dev_*_enabled() must be split in two:

  - the checks on the priv flags go into can_dev_dropped_skb().

  - the checks on the MTU go into can_dropped_invalid_skb()

>  	return can_dropped_invalid_skb(dev, skb);
>  
>  invalid_skb:
>  	kfree_skb(skb);
>  	dev->stats.tx_dropped++;
> diff --git a/net/can/raw.c b/net/can/raw.c
> index a53853f5e9af..645f1e0b2555 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -890,24 +890,23 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
>  		cxl->prio &= CANXL_PRIO_MASK;
>  		cxl->prio |= ro->tx_vcid_shifted;
>  	}
>  }
>  
> -static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
> +static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
> +				      struct net_device *dev)
>  {
> -	/* Classical CAN -> no checks for flags and device capabilities */
> -	if (can_is_can_skb(skb))
> +	/* Classical CAN */
> +	if (can_is_can_skb(skb) && can_dev_cc_enabled(dev))
>  		return CAN_MTU;
>  
> -	/* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
> -	if (ro->fd_frames && can_is_canfd_skb(skb) &&
> -	    (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
> +	/* CAN FD */
> +	if (ro->fd_frames && can_is_canfd_skb(skb) && can_dev_fd_enabled(dev))
>  		return CANFD_MTU;
>  
> -	/* CAN XL -> needs to be enabled and a CAN XL device */
> -	if (ro->xl_frames && can_is_canxl_skb(skb) &&
> -	    can_is_canxl_dev_mtu(mtu))
> +	/* CAN XL */
> +	if (ro->xl_frames && can_is_canxl_skb(skb) && can_dev_xl_enabled(dev))
>  		return CANXL_MTU;
>  
>  	return 0;
>  }
>  
> @@ -959,11 +958,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  		goto free_skb;
>  
>  	err = -EINVAL;
>  
>  	/* check for valid CAN (CC/FD/XL) frame content */
> -	txmtu = raw_check_txframe(ro, skb, READ_ONCE(dev->mtu));
> +	txmtu = raw_check_txframe(ro, skb, dev);
>  	if (!txmtu)
>  		goto free_skb;
>  
>  	/* only CANXL: clear/forward/set VCID value */
>  	if (txmtu == CANXL_MTU)


Yours sincerely,
Vincent Mailhol


