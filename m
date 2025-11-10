Return-Path: <linux-can+bounces-5330-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BBEC49748
	for <lists+linux-can@lfdr.de>; Mon, 10 Nov 2025 22:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7318C3A603A
	for <lists+linux-can@lfdr.de>; Mon, 10 Nov 2025 21:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E73E2F6582;
	Mon, 10 Nov 2025 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJrWmxjY"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6D2E7F03
	for <linux-can@vger.kernel.org>; Mon, 10 Nov 2025 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811623; cv=none; b=Fxz4MHPjwU/KubBgeGmmlTzWY23ShaMYqHxEBJQn2LAVUIsnZwGrI610D2WXFPCg845x5MfPO8eX8dFDd5SyutxRMSPLYhJ7pkRdvHXAPg4pLWKCv81Aesn8ICGfl4DnAIdFtCk3tiPw6rhG8txbVdI6WvSMNJ3f1c7bEAaTsQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811623; c=relaxed/simple;
	bh=fxDprA51OQkdIrfBjwSPEfyre6suCvxIgBUB138lTkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OY1H0S45XfRnj07gQ9veoOz4K4hufObF9IF+E14QkzL0g6rJxyWs1Obl28s47Ir1P95fNZTndGbgGFBVc1+gRie2emkWeCZ/nJO8g3c8mOEG4evDn2o44UOOsHKEwKLsedrsKpDzZsO1o5QAlmu3T7aqS9UbecdaZ0uJ+pbpXtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJrWmxjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31117C116B1;
	Mon, 10 Nov 2025 21:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762811622;
	bh=fxDprA51OQkdIrfBjwSPEfyre6suCvxIgBUB138lTkY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=pJrWmxjYDW4IiA4huhEjmWE07+WcD1PvoGVjlCLJyklf8dttGhA+5S/q5o6bgwGap
	 JzxPgLZ7QsVyPkdaTyv9CewSeSq/G4wf8frCtPPCOXPYtKrFp7BvOTyMuDktWYJ4VN
	 6kimDfs7CKJkxl4VI1yWA6T/a7q/3yjBXcSFJyDknNtmtZaKhg3qoDeMui3m72KOQG
	 d7F5j/NjUQbfpv0jzxlr3JbUaPPomS75nHcWLw6mcW6o7+mHkUOi5krmYQsxToCGlm
	 LbOYyLncb823XUl4k6n8hvo4qtQ9WJUsU/W3np7E2kQug/ms2dkhPW4bJ5/yUcSpR/
	 6p2csofLYX5Kg==
Message-ID: <f7665b08-57cd-4b42-8a2f-7a86059eaee2@kernel.org>
Date: Mon, 10 Nov 2025 22:53:40 +0100
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
 <a76a6805-d04a-44c0-9ccb-19fc2636ff7e@kernel.org>
 <d20139f0-be38-428f-9205-dd85e59eb1d9@hartkopp.net>
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
In-Reply-To: <d20139f0-be38-428f-9205-dd85e59eb1d9@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver,

On 09/11/2025 at 20:21, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 09.11.25 14:42, Vincent Mailhol wrote:
> 
>>> +static inline bool can_dev_cc_enabled(struct net_device *dev)
>>> +{
>>> +    struct can_priv *priv = safe_candev_priv(dev);
>>> +
>>> +#define MIXED_MODE (CAN_CTRLMODE_FD | CAN_CTRLMODE_XL)
>>             ^^^^^^^^^^
>> If this is just used locally in one function, declare it as a u32:
>>
>>     const u32 mixed_mode = CAN_CTRLMODE_FD | CAN_CTRLMODE_XL;
> 
> Not sure if a
> 
> #define CAN_XL_MIXED_MODE (CAN_CTRLMODE_FD | CAN_CTRLMODE_XL)
> 
> generally would make sense?!?
> 
> I will therefore go with your local const u32 solution.

Ack. I also prefer it that way. My comment was more toward the fact that I am
not a huge fan of hanging #define in the middle of the code.

>> If you want to keep the #define, add a CAN_ prefix to avoid namespace pollution
>> and put it at the top of the file.
>>
>>> +    /* When CAN XL is enabled but FD is disabled we are not running in the
>>> +     * so-called 'mixed mode' (CC/FD/XL with TMS OFF and ERR_SIGNAL ON).
>>> +     * Then either TMS is ON or ERR_SIGNAL is OFF in which cases the
>>> +     * resulting XL-only mode does not allow the sending of CC/FD frames.
>>> +     */
>>
>> If we do this, then the user doing:
>>
>>     ip link set can0 type can bitrate 1000000 \
>>         fd off \
>>         xl on xbitrate 10000000 tms off err-signal on
>>
>> will get the Classical CAN disabled for no apparent reasons.
> 
> Btw. with the new defaults
> 
> ip link set can0 type can bitrate 1000000 xl on xbitrate 10000000
> 
> should create the same configuration ...

Yes, I just wanted to be explicit in my example.

>> Even if the mixed mode is meant for CC + FD + XL, I think it is fair to allow
>> the end user to request mixed mode with FD disabled (i.e. just keep CC and XL).
> 
> But does it make sense when mixed-mode means XL & FD mixing?
> 
> Of course I don't want to argue for "FD on" just because is helps my v2 patch :-D
> 
> But I tend to follow the Bosch spec that mixed-mode is XL/FD/CC until someone
> really shows up with a request to omit FD in the XL/FD mixed mode.

I am not strongly against forbidding the above use case. As I stated in another
patch, everything that we arbitrarily ban can easily be allowed again without
breaking the uapi (the opposite is not true, once something is allowed at uapi
level, it is set in stone).

I agree that I do not see the use case for production at the moment, but I can
foresee that I would be annoyed to have to provide an FD bitrate even if I am
testing on an environment in which I do not (yet) need CAN FD.

It goes to what I stated in my other message: even if the production use case
does not exists, I want to give freedom to the user to do whatever is allowed
within the boundaries of the standard.

>>> +    if (priv)
>>> +        return !((priv->ctrlmode & MIXED_MODE) == CAN_CTRLMODE_XL);
>>
>> What about:
>>
>>     if (priv)
>>         return !(priv->ctrlmode & CAN_CTRLMODE_XL) ||
>>             (priv->ctrlmode & CAN_CTRLMODE_XL_ERR_SIGNAL);
>>
>> ?
> 
> Huh!
> 
> We need
> 
> CAN_CTRLMODE_XL off (no CAN XL)
> 
> OR
> 
> CAN_CTRLMODE_XL on && CAN_CTRLMODE_XL_ERR_SIGNAL on (mixed mode)
> 
> I needed some minutes to find these conditions in your code as I've seen more
> parenthesis' than you have written ;-)
> 
> But it looks good! Will add this condition with some comment and remove the
> former MIXED_MODE code.

OK. I admit this one was tricky. It also took me a couple minutes to find the
correct formula.

It would probably be better to put this in its own helper function:

  /* Error signaling is only configurable when XL is selected. Otherwise,
   * it is always on. */
  static inline bool can_err_signal_is_enabled(const struct can_priv *priv)
  {
  	return !(priv->ctrlmode & CAN_CTRLMODE_XL) ||
  		(priv->ctrlmode & CAN_CTRLMODE_XL_ERR_SIGNAL);
  }

> This would also be a point for mixed-mode with FD off.
> But I'm still not sure if the mixed-mode without FD makes sense.
> 
> E.g. I'm using a bitrate calculation tool from PEAK and one from Bosch which
> require all bitrates (CC/FD/XL) when error-signalling is on (and TMS off).
> 
> And as I have to enable FD when enabling XL in the Bosch X_CAN IP cores I also
> have to provide a valid FD bitrate setting for the mixed mode.
> 
> This could lead to a new ctrlmode option that FD bitrates are required when XL
> is on.
> 
> ¯\_(ツ)_/¯
>>> +    /* virtual CAN interfaces always support CAN CC */
>>> +    return true;
>>> +}
>>> +
>>> +static inline bool can_dev_fd_enabled(struct net_device *dev)
>>> +{
>>> +    struct can_priv *priv = safe_candev_priv(dev);
>>> +
>>> +    /* check FD ctrlmode on real CAN interfaces */
>>> +    if (priv)
>>> +        return (priv->ctrlmode & CAN_CTRLMODE_FD);
>>> +
>>> +    /* check MTU for virtual CAN FD interfaces */
>>> +    return (READ_ONCE(dev->mtu) >= CANFD_MTU);
>>> +}
>>> +
>>> +static inline bool can_dev_xl_enabled(struct net_device *dev)
>>> +{
>>> +    struct can_priv *priv = safe_candev_priv(dev);
>>> +
>>> +    /* check XL ctrlmode on real CAN interfaces */
>>> +    if (priv)
>>> +        return (priv->ctrlmode & CAN_CTRLMODE_XL);
>>> +
>>> +    /* check MTU for virtual CAN XL interfaces */
>>> +    return (READ_ONCE(dev->mtu) >= CANXL_MIN_MTU);
>>> +}
>>> +
>>>   /* drop skb if it does not contain a valid CAN frame for sending */
>>>   static inline bool can_dev_dropped_skb(struct net_device *dev, struct
>>> sk_buff *skb)
>>>   {
>>>       struct can_priv *priv = netdev_priv(dev);
>>>       u32 silent_mode = priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
>>> @@ -142,15 +184,28 @@ static inline bool can_dev_dropped_skb(struct
>>> net_device *dev, struct sk_buff *s
>>>           netdev_info_once(dev, "interface in %s mode, dropping skb\n",
>>>                    can_get_ctrlmode_str(silent_mode));
>>>           goto invalid_skb;
>>>       }
>>>   -    if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
>>> +    /* Classical CAN */
>>> +    if (can_is_can_skb(skb) && !can_dev_cc_enabled(dev)) {
>>> +        netdev_info_once(dev, "CAN CC with TMS on, dropping skb\n");
>>> +        goto invalid_skb;
>>> +    }
>>> +
>>> +    /* CAN FD */
>>> +    if (can_is_canfd_skb(skb) && !can_dev_fd_enabled(dev)) {
>>>           netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
>>>           goto invalid_skb;
>>>       }
>>>   +    /* CAN XL */
>>> +    if (can_is_canxl_skb(skb) && !can_dev_xl_enabled(dev)) {
>>> +        netdev_info_once(dev, "CAN XL is disabled, dropping skb\n");
>>> +        goto invalid_skb;
>>> +    }
>>> +
>>
>> The can_dev_*_enabled() functions use safe_candev_priv(), but
>> can_dev_dropped_skb() is only called by the devices which have a valid priv
>> member. So, in this context, the safe_candev_priv() becomes useless
> Ok, what about
> 
> can_dev_*_enabled_safe() calling can_dev_*_enabled() then?

But then, the can_dev_*_enabled() would look something like:

	static inline bool can_dev_cc_enabled(struct can_priv *priv)
	{
		return can_err_signal_is_enabled(priv);
	}

	static inline bool can_dev_fd_enabled(struct can_priv *priv)
	{
		return priv->ctrlmode & CAN_CTRLMODE_FD;
	}

	static inline bool can_dev_fd_enabled(struct can_priv *priv)
	{
		return priv->ctrlmode & CAN_CTRLMODE_XL;
	}

Do we really need a function for that? This is how my draft
can_dev_dropped_skb() looks like at the moment:

  /* drop skb if it does not contain a valid CAN frame for sending */
  static inline bool can_dev_dropped_skb(struct net_device *dev,
  					 struct sk_buff *skb)
  {
  	struct can_priv *priv = netdev_priv(dev);
  	u32 silent_mode = priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
  					    CAN_CTRLMODE_RESTRICTED);

  	if (silent_mode) {
  		netdev_info_once(dev, "interface in %s mode, dropping skb\n",
  				 can_get_ctrlmode_str(silent_mode));
  		goto invalid_skb;
  	}

  	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
  		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
  		goto invalid_skb;
  	}

  	if (!can_err_signal_is_enabled(priv) && !can_is_canxl_skb(skb)) {
  		netdev_info_once(dev,
  				 "Error signaling is disabled, dropping skb\n");
  		goto invalid_skb;
  	}

  	return can_dropped_invalid_skb(dev, skb);

  invalid_skb:
  	kfree_skb(skb);
  	dev->stats.tx_dropped++;
  	return true;
  }

(refactored to use the new can_err_signal_is_enabled() as proposed above).

Also, if the above looks good to you, you can leave the can_dev_dropped_skb() to
me and just focus on the can_dropped_invalid_skb() and the raw.c.

> can_dev_*_enabled_safe() is only used from raw.c which must handle virtual CAN
> interfaces too.

Ack. And the can_dev_*enabled_safe() would also go to raw.c. As we so here,
using those functions in a context where of a real device could give strange
results. So I would rather have this hidden in raw.c to reduce the risk of misuse.

>> and the FD
>> and XL MTU checks are dead code.
> Right. For the code sections that have definitely a priv pointer.
> 
>> The can_dev_*_enabled() must be split in two:
>>
>>    - the checks on the priv flags go into can_dev_dropped_skb().
>>
>>    - the checks on the MTU go into can_dropped_invalid_skb()
> Will re-check and send a v3 patch.


Yours sincerely,
Vincent Mailhol


