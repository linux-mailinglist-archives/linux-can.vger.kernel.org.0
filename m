Return-Path: <linux-can+bounces-4598-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B07B50D07
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 07:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805823B6678
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 05:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659D42773C0;
	Wed, 10 Sep 2025 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1FWWiFE"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A88243374
	for <linux-can@vger.kernel.org>; Wed, 10 Sep 2025 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481205; cv=none; b=G7hCg9jilhoXY1LlCbf0nYOXHgRKBuENhVWd2fqO9AclDvANrMVTsYKjFNXSNynzOO4EspB+qmLIDkeMtooUTKZqvfMTUvBOu2CHb3NicmEmmYs0qRDOVFmejbWQP1gVIYu6QLSOvZLquMmAweok3xbxAF5GUrqbGJrXS0rNAdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481205; c=relaxed/simple;
	bh=2aiKtUJSErVRoGeQyOfGXSqbBke4XjAWk6i1ZnnuYFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s0f94tyQ5kZRW96t3GIWkYrnZmRGXKXI2vcTcSkurVBuvMKwC768Msuq9WKXTmge73+BuBMkoVpdMs+RElJ4cw3dlDy8qLxdV+gjbNywYOKwyELCDYSHFQTRwPzhb7t9TrQwnnran5SkPR2L3iaKiaAqPHfitsq6AndO9yEelUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1FWWiFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2DAC4CEF0;
	Wed, 10 Sep 2025 05:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757481204;
	bh=2aiKtUJSErVRoGeQyOfGXSqbBke4XjAWk6i1ZnnuYFM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=c1FWWiFEzzm+1z1VokP6PFPE17ui7bqYGEhcISqE2q4QiYCF60PEHb4KKIY/d3PhE
	 FG3s4NfNAvIUBPsFM8YW1Vsgc2AWmYi9AfBexFTXU6Vo9Bg4Ot8gsx95QnzWPUqvhi
	 44qdJtHn+LIyP7ZqCu43toryKQvRJkQKuf/ITogNSLBlGWoG/jhCuwQ/leIVWq+1GF
	 thIsK9K2kJPjRfvlAin57qwc8s9mMvSi/004T+dlui0dKG315S9hIxPZu+wXBaksuA
	 WZ7O4FdF2kK95toP+rIP8jypK4bTQNsIZlu6l3aP3JkbbDOKWUaFMeaDURRsPlqk2g
	 PvMTmw2WRgc9g==
Message-ID: <7578f44d-d85c-473e-8e7a-65d1fc974e68@kernel.org>
Date: Wed, 10 Sep 2025 14:13:22 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 2/2] can: reject CAN FD content when disabled on
 CAN XL interfaces
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
References: <20250909092433.30546-1-socketcan@hartkopp.net>
 <20250909092433.30546-2-socketcan@hartkopp.net>
 <f7b59c7c-30ad-4cf4-ad0e-bff0e39b3337@hartkopp.net>
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
In-Reply-To: <f7b59c7c-30ad-4cf4-ad0e-bff0e39b3337@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/09/2025 at 01:36, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 09.09.25 11:24, Oliver Hartkopp wrote:
> 
> 
>> -static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff
>> *skb, int mtu)
>> +static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb,
>> +                      struct net_device *dev)
>>   {
>>       /* Classical CAN -> no checks for flags and device capabilities */
>>       if (can_is_can_skb(skb))
>>           return CAN_MTU;
>>   -    /* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
>> -    if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb) &&
>> -        (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
>> -        return CANFD_MTU;
>> +    /* CAN FD -> needs to be enabled in a CAN FD or CAN XL device */
>> +    if (ro->fd_frames && can_is_canfd_skb_mtu_len(skb)) {
>> +        /* real/virtual CAN FD interface */
>> +        if (dev->mtu == CANFD_MTU)
>> +            return CANFD_MTU;
>> +        if (can_is_canxl_dev_mtu(dev->mtu) &&
>> +            can_dev_ctrlmode_fd_on(dev))
>> +            return CANFD_MTU;
>> +    }
> 
> I've simplified the above code and rewrote the commit message in v6
> 
>>       /* CAN XL -> needs to be enabled and a CAN XL device */
>>       if (ro->xl_frames && can_is_canxl_skb(skb) &&
>> -        can_is_canxl_dev_mtu(mtu))
>> +        can_is_canxl_dev_mtu(dev->mtu))
>>           return CANXL_MTU;
> 
> We might also discuss if we create a can_dev_ctrlmode_xl_on(dev) function to
> check if the CAN XL interface has CAN_CTRLMODE_XL enabled.

I checked ISO 11898-1:2024 again and the relevant wording I can found is in
§6.6.21.4.1:

  When error signalling is disabled, the node shall transmit and
  receive only XLFF frames. It shall not transmit EF, OF and RF, nor
  DFs in CBFF, CEFF, FBFF and FEFF.

TLDR; Classical CAN is deactivated when error signaling is off.

So, I think that we also need the same logic for the Classical CAN. The nuance
is that instead of using CAN_CTRLMODE_CC (which does not exist), we can check
CAN_CTRLMODE_XL_ERR_SIGNAL. Note that CAN_CTRLMODE_XL_TMS implies that error
signalling is off, so no need for extra checks on TMS. This is what I have in
mind at the moment.

  static inline bool can_dev_cc_on(struct net_device *dev)
  {
  	struct can_priv *priv = safe_candev_priv(dev);

  	/* Classical CAN frames are always allowed on virtual interfaces */
  	if (!priv)
  		return true;

  	/* When error signalling is off only CAN XL frames are allowed */
  	return !(priv->ctrlmode & CAN_CTRLMODE_XL) ||
  		(priv->ctrlmode & CAN_CTRLMODE_XL_ERR_SIGNAL);
  }

  static inline bool can_dev_fd_on(struct net_device *dev)
  {
  	struct can_priv *priv = safe_candev_priv(dev);

	/* CAN FD is allowed on virtual interfaces if it fits the MTU */
  	if (!priv)
  		return dev->mtu == CANFD_MTU;

  	return can_dev_cc_on(dev) && (priv->ctrlmode & CAN_CTRLMODE_FD);
  }

  static inline bool can_dev_xl_on(struct net_device *dev)
  {
  	struct can_priv *priv = safe_candev_priv(dev);

	/* CAN XL is allowed on virtual interfaces if it fits the MTU */
  	if (!priv)
  		return dev->mtu == CANXL_MTU;

  	return priv->ctrlmode & CAN_CTRLMODE_XL;
  }

(the above is not yet tested, so beware of silly errors!)

> Currently my patches are based on Linus' rc5 tree where CAN_CTRLMODE_XL is not
> defined. But I can rebase it on your b4/canxl-netlink branch if you like it.

I still want to finish the XL preparation series before moving to the actual thing.

You can do what is convinient for you:

  1/ rebase on b4/canxl-netlink branch but I take no claims if your code breaks
     after one of my force push.

  2/ add the flags you need in netlink.h. I will then chery pick your patches in
     my series when ready and take care of any conflict for you!

I am going to send the v2 of my XL preparation series. Hopefully we can finalyse
it soon so that we can focus on one sigle topic :)


Yours sincerely,
Vincent Mailhol


