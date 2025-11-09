Return-Path: <linux-can+bounces-5325-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 169EFC445EA
	for <lists+linux-can@lfdr.de>; Sun, 09 Nov 2025 20:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C608C3AE8B8
	for <lists+linux-can@lfdr.de>; Sun,  9 Nov 2025 19:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514BE21D3F4;
	Sun,  9 Nov 2025 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lj9jjQxA";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lVLwiIhx"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2D4C81
	for <linux-can@vger.kernel.org>; Sun,  9 Nov 2025 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716098; cv=pass; b=iTySH39dFeTBSkWh7GmWNjZ3MZxD/KIjnmhwxrBpNbEfAchZVWvBzhNyGiB+adEeJeCcLyV1fEON1upFjXpVhob39HHQC0N3gqlel6lsqxHtgmpCS255mSkfvHOWTSaPgC9MKJwNHocsu6k4S7bykrF2ez3ycNYCcHwu5IUtCno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716098; c=relaxed/simple;
	bh=9dp3Z+Roye+8IHEN+gE5TEd1ojrdyWuWzDFHP0K7Lh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qYs1tvbVCgLsGidwRVASoJzstdCng2jOLisTyaVwaJppXUif+2lz17tMlUcUnrHW0e+0Uchazu6Hug8/Kn1yAjDmQ7BMe6GNA3WZkM35eq5WZA7vV80p3YOrZHQLAPE1lUj/TyXxuOqj+zhq4XoynqozTg7Za4rBGMnWiD0R1Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lj9jjQxA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lVLwiIhx; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762716086; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HmKqEqhbS9bRYi5NbgBtsGWOp2mXzroopu9dQTP9WVHF6H3gSRGTYgdc701QjXC1ir
    WINsfUPmfbPBWNXEP8bdqeO8GY/AZYWVJOL5syW8seDmgOAs8xLmwEoFG11+f/9YfxdO
    P/gKkmornVq+5n/qsak6eAfSLuvPiU4MiTn+SaA1XlOscNvRdvYHB1FeqQNxtASlOi9s
    umnm970mHS4TdIq8+jPsC/NzTLAOR6tvnPMxiEBRC+bznXm34rZ0k9r60jTTsgJgxI+5
    H1dyWvYYlg5TeZbDLjYpxaNWUrDPP0tOE9NW/PBnUNlk19u6G3KV7H/Knbszo2jQpVSA
    5+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762716086;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=sf7CqWD7/ixRHqkD2hPGJwJ1teHNR4M9VN7qhpDID0c=;
    b=Sspal2MzdyVCARamYjF6nt7y5/+pIf8ZxdHhHfRGEGxriIYOrXK54w6WvpweGjpr3C
    OhsSeupfu4QTvPjY/Beld5LqZJe8aZRQbvZ1mqNaHgxhcfzNI5WYnms8IN8Hydx6rqN1
    pUFR4LQnFhI7g8IGiRes7v3a/LUEIF4lwntTAxzDfLT8eaIdg5Up+biiQfyRa85ix9Ja
    5l86Jm0Omv1rZwgNQO6Zz5KT0t5eWQSXHSqjePEogpigXPxg/9/pXtGRwpr9giFOZjXv
    kqgehD8Ra8/3EL34tr+OXbfldH7zn2n0cI8vC7y6KdaBOgjSi1agzF6peeIxb4cr3x+P
    VdIw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762716086;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=sf7CqWD7/ixRHqkD2hPGJwJ1teHNR4M9VN7qhpDID0c=;
    b=lj9jjQxAEsOU4fS6Ek4Jyd0+kIVrWeXfNZuh5ijrP94b+T5N1MhzcwYL8K92CEx3Jx
    rBaBokwR5f3s1Z0+9z8HQFVhRvxrAnPuB+vapNfcB2qsiK4ui3N+JY8tPDlH69ROJNUD
    WpVSk9QdQ10rBJKIR4XiyRaMnmsTfBSjHVdodZ+hRr1LWt0gz/yQ2swERNuOXJdmm0hP
    vc9cvx/GPvquCoFxP4gbjWjR3ir0mljIQpNVwkEp8X9ng/HyQUz9RaM6lPc7v+L166MK
    dJyFEvjnPWMaHR7TczjWtTCktPMIryOeXi+1yLc/5lhJ4yIeIaXzxwV0S41ORVwPzorh
    gtgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1762716086;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=sf7CqWD7/ixRHqkD2hPGJwJ1teHNR4M9VN7qhpDID0c=;
    b=lVLwiIhxr4oqVVgRyItDvPCMu/AcNU3d6MWp8azOVmLmaGCPVLn+oDJtIwc2p1HfNM
    qeIYzkHBjRXwo1u5kgDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461A9JLQFLO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 9 Nov 2025 20:21:26 +0100 (CET)
Message-ID: <d20139f0-be38-428f-9205-dd85e59eb1d9@hartkopp.net>
Date: Sun, 9 Nov 2025 20:21:26 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH b4/canxl-netlink v2] can: drop unsupported CAN frames on
 socket and netdev level
To: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
References: <20251103185336.32772-1-socketcan@hartkopp.net>
 <a76a6805-d04a-44c0-9ccb-19fc2636ff7e@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <a76a6805-d04a-44c0-9ccb-19fc2636ff7e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 09.11.25 14:42, Vincent Mailhol wrote:

>> +static inline bool can_dev_cc_enabled(struct net_device *dev)
>> +{
>> +	struct can_priv *priv = safe_candev_priv(dev);
>> +
>> +#define MIXED_MODE (CAN_CTRLMODE_FD | CAN_CTRLMODE_XL)
>             ^^^^^^^^^^
> If this is just used locally in one function, declare it as a u32:
> 
> 	const u32 mixed_mode = CAN_CTRLMODE_FD | CAN_CTRLMODE_XL;

Not sure if a

#define CAN_XL_MIXED_MODE (CAN_CTRLMODE_FD | CAN_CTRLMODE_XL)

generally would make sense?!?

I will therefore go with your local const u32 solution.

> If you want to keep the #define, add a CAN_ prefix to avoid namespace pollution
> and put it at the top of the file.
> 
>> +	/* When CAN XL is enabled but FD is disabled we are not running in the
>> +	 * so-called 'mixed mode' (CC/FD/XL with TMS OFF and ERR_SIGNAL ON).
>> +	 * Then either TMS is ON or ERR_SIGNAL is OFF in which cases the
>> +	 * resulting XL-only mode does not allow the sending of CC/FD frames.
>> +	 */
> 
> If we do this, then the user doing:
> 
> 	ip link set can0 type can bitrate 1000000 \
> 		fd off \
> 		xl on xbitrate 10000000 tms off err-signal on
> 
> will get the Classical CAN disabled for no apparent reasons.

Btw. with the new defaults

ip link set can0 type can bitrate 1000000 xl on xbitrate 10000000

should create the same configuration ...

> Even if the mixed mode is meant for CC + FD + XL, I think it is fair to allow
> the end user to request mixed mode with FD disabled (i.e. just keep CC and XL).

But does it make sense when mixed-mode means XL & FD mixing?

Of course I don't want to argue for "FD on" just because is helps my v2 
patch :-D

But I tend to follow the Bosch spec that mixed-mode is XL/FD/CC until 
someone really shows up with a request to omit FD in the XL/FD mixed mode.

>> +	if (priv)
>> +		return !((priv->ctrlmode & MIXED_MODE) == CAN_CTRLMODE_XL);
> 
> What about:
> 
> 	if (priv)
> 		return !(priv->ctrlmode & CAN_CTRLMODE_XL) ||
> 			(priv->ctrlmode & CAN_CTRLMODE_XL_ERR_SIGNAL);
> 
> ?

Huh!

We need

CAN_CTRLMODE_XL off (no CAN XL)

OR

CAN_CTRLMODE_XL on && CAN_CTRLMODE_XL_ERR_SIGNAL on (mixed mode)

I needed some minutes to find these conditions in your code as I've seen 
more parenthesis' than you have written ;-)

But it looks good! Will add this condition with some comment and remove 
the former MIXED_MODE code.

This would also be a point for mixed-mode with FD off.
But I'm still not sure if the mixed-mode without FD makes sense.

E.g. I'm using a bitrate calculation tool from PEAK and one from Bosch 
which require all bitrates (CC/FD/XL) when error-signalling is on (and 
TMS off).

And as I have to enable FD when enabling XL in the Bosch X_CAN IP cores 
I also have to provide a valid FD bitrate setting for the mixed mode.

This could lead to a new ctrlmode option that FD bitrates are required 
when XL is on.

¯\_(ツ)_/¯
>> +	/* virtual CAN interfaces always support CAN CC */
>> +	return true;
>> +}
>> +
>> +static inline bool can_dev_fd_enabled(struct net_device *dev)
>> +{
>> +	struct can_priv *priv = safe_candev_priv(dev);
>> +
>> +	/* check FD ctrlmode on real CAN interfaces */
>> +	if (priv)
>> +		return (priv->ctrlmode & CAN_CTRLMODE_FD);
>> +
>> +	/* check MTU for virtual CAN FD interfaces */
>> +	return (READ_ONCE(dev->mtu) >= CANFD_MTU);
>> +}
>> +
>> +static inline bool can_dev_xl_enabled(struct net_device *dev)
>> +{
>> +	struct can_priv *priv = safe_candev_priv(dev);
>> +
>> +	/* check XL ctrlmode on real CAN interfaces */
>> +	if (priv)
>> +		return (priv->ctrlmode & CAN_CTRLMODE_XL);
>> +
>> +	/* check MTU for virtual CAN XL interfaces */
>> +	return (READ_ONCE(dev->mtu) >= CANXL_MIN_MTU);
>> +}
>> +
>>   /* drop skb if it does not contain a valid CAN frame for sending */
>>   static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *skb)
>>   {
>>   	struct can_priv *priv = netdev_priv(dev);
>>   	u32 silent_mode = priv->ctrlmode & (CAN_CTRLMODE_LISTENONLY |
>> @@ -142,15 +184,28 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
>>   		netdev_info_once(dev, "interface in %s mode, dropping skb\n",
>>   				 can_get_ctrlmode_str(silent_mode));
>>   		goto invalid_skb;
>>   	}
>>   
>> -	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
>> +	/* Classical CAN */
>> +	if (can_is_can_skb(skb) && !can_dev_cc_enabled(dev)) {
>> +		netdev_info_once(dev, "CAN CC with TMS on, dropping skb\n");
>> +		goto invalid_skb;
>> +	}
>> +
>> +	/* CAN FD */
>> +	if (can_is_canfd_skb(skb) && !can_dev_fd_enabled(dev)) {
>>   		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
>>   		goto invalid_skb;
>>   	}
>>   
>> +	/* CAN XL */
>> +	if (can_is_canxl_skb(skb) && !can_dev_xl_enabled(dev)) {
>> +		netdev_info_once(dev, "CAN XL is disabled, dropping skb\n");
>> +		goto invalid_skb;
>> +	}
>> +
> 
> The can_dev_*_enabled() functions use safe_candev_priv(), but
> can_dev_dropped_skb() is only called by the devices which have a valid priv
> member. So, in this context, the safe_candev_priv() becomes useless
Ok, what about

can_dev_*_enabled_safe() calling can_dev_*_enabled() then?

can_dev_*_enabled_safe() is only used from raw.c which must handle 
virtual CAN interfaces too.

> and the FD
> and XL MTU checks are dead code.
Right. For the code sections that have definitely a priv pointer.

> The can_dev_*_enabled() must be split in two:
> 
>    - the checks on the priv flags go into can_dev_dropped_skb().
> 
>    - the checks on the MTU go into can_dropped_invalid_skb()
Will re-check and send a v3 patch.

Best regards,
Oliver

