Return-Path: <linux-can+bounces-5323-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D22C444A9
	for <lists+linux-can@lfdr.de>; Sun, 09 Nov 2025 18:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD25F4E1C89
	for <lists+linux-can@lfdr.de>; Sun,  9 Nov 2025 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0022A4E1;
	Sun,  9 Nov 2025 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XH9JvugV";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="IijAKF9b"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE1227B9F;
	Sun,  9 Nov 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762710060; cv=pass; b=lDjntBHRqcd6zJSQBZKFc5pl1qtNRNMPsBp7hNHQ3xZNhxUnlSG0wyuPD37T99OTWRJSrrMCtek3Qy0b/N0L7KsuvkZ3IkClefQVLHjci9Pu6I01B/zAIpTRCRoGG+R808KV1LrcZPq85c/wDqMJDYzbHxnXs7JeCCgM3WSn93g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762710060; c=relaxed/simple;
	bh=tegmH2B2Yl63pvMAO1R6dRbHPb7f04fN9G+050VWHFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onWk4wIyBz8MY2HCmIe9MdjSBAqGLn2rdZ3NFg//Jk4FsQjJdQV8sxCQXNBFik+c/gyGqsrOnQvGtQPM6Isv0JloMilGQ7g3WXMhN4lz3PgoLLqaOWIdYh82aHCIDhEGfcta4qcesgVyqrWmAgDPv9bLx6UJBDXn7uJLIweAI4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XH9JvugV; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=IijAKF9b; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762710048; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QkzKF4BJPs07Yi9pabuFqcnz5KH32xZTXK3eOJGitPzlkEgfRQoIfNcNpPaWSsnuFp
    Wa/wQ45z8mvxFpPUcVUb+l1hH+66QZe2pZ39itxsHfl6iFTeBY/+oDe5Kqi7c0YX5U04
    8D0QwujbVzcg5JkJHWMQ42xOwQkZJGFihQ6ltKthtP4R1KwtyFn3dIPfxDbYWpRL8tHF
    TnavMQ8yHFbW+T5ZYbVR3LnGS5QLksKDrqacaKckuGxRzwA4E9Orvt6VlALSL4g0y2zf
    J3fDsyYklsG+jbQji6iAt2k4lJdgS3ItJcpDDJZ/p4wqi1d9MjqW+84lzgCIv9OFxpMK
    xLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762710048;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=K01QPJmJXM63zrSXOqbrZaZyiLjZOa5zRGQfwrOjar0=;
    b=GmjEyFPCRgB6bA5BeawXFE/5D+LCqWu7kqAUThoMs+YerFliO+wWKbbd4gZ9xpLxuD
    rJP4fJW0aOUQwV78lvhM/ogMhtLqFQNSWzh219KRqirR9WZlaUgNXo0J9Tlmc9krXSgK
    87NlSSAGUTQEO9zRBfKKSSPWsQ9VhAD2Ws6HLpjUg8xHW1IpbT9M4kx5Da1cb2FO+j+M
    LOvbnew4vLNxQ1p3B6Ii9Rh4pANfke1qkw3QyQepaZxHAckvjKJ+nkxinmAywEUGriSB
    ysvpZDtEw+woijRbB1awA4WK1NHADyVN904xJk4QEGUUfisJdRfWl6gNf/PQ/pqs27kr
    nvBw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762710048;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=K01QPJmJXM63zrSXOqbrZaZyiLjZOa5zRGQfwrOjar0=;
    b=XH9JvugVurPE+v0AyrCTKmsyWy0J5Xvk2EHR/jIIheWyLEHMeVCMkXN+wa+dJI2AVd
    /AHdZNHxAnmCmpkMXBEyyJ/GTUwwQQOjH94US0flelJOY4X582xZwU22gdvnvinKvH+m
    SIQuQhRkaf7u7p4lEsJe1fonDNa4prjBnytfCK4LDFHFAMe5qkFNDcIVA7jwCrpEaX38
    JSRPHgVV/wnb1OEAldaX8OmJW11Kc/o9pX9+Okmqy49+reU/kLPCKPmI8LSRlN1v4lK1
    4UTbG6SqriiRlZ7AJ374tZ6halq8A9WsXsATmWG/uUmn0/p7v92I5qoAHNGwoZa2R44M
    y36Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1762710048;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=K01QPJmJXM63zrSXOqbrZaZyiLjZOa5zRGQfwrOjar0=;
    b=IijAKF9bEQncNtGSabjHsOO2y04QEaezHg2dB+zcMGeV+SZZz76WuqER8R3NElbiX1
    e9h/nwm2OT8YnBV++wBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461A9HemFDM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 9 Nov 2025 18:40:48 +0100 (CET)
Message-ID: <1154dfe5-1529-48d5-bfe9-bf77b6a4604b@hartkopp.net>
Date: Sun, 9 Nov 2025 18:40:42 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] can: netlink: add CAN_CTRLMODE_XL_TMS flag
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
 <20251021-canxl-netlink-v2-5-8b8f58257ab6@kernel.org>
 <a50a77c8-85ef-4ac8-b649-33b880ec4b17@hartkopp.net>
 <77daaf44-e75f-4adf-9d87-d2833a255748@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <77daaf44-e75f-4adf-9d87-d2833a255748@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 09.11.25 15:28, Vincent Mailhol wrote:
> Hello Oliver,
> 
> On 06/11/2025 at 09:42, Oliver Hartkopp wrote:
>> Hello Vincent,
>>
>> On 21.10.25 17:47, Vincent Mailhol wrote:
>>> The Transceiver Mode Switching (TMS) indicates whether the CAN XL
>>> controller shall use the PWM or NRZ encoding during the data phase.
>>>
>>> The term "transceiver mode switching" is used in both ISO 11898-1 and
>>> CiA 612-2 (although only the latter one uses the abbreviation TMS). We
>>> adopt the same naming convention here for consistency.
>>>
>>> Add the CAN_CTRLMODE_XL_TMS flag to the list of the CAN control modes.
>>>
>>> In the netlink interface, each boolean option is in reality a tristate
>>> in disguise: on, off or omitted. For the moment, TMS is implemented as
>>> below:
>>>
>>>     - CAN_CTRLMODE_XL_TMS is set to false: TMS is disabled.
>>>     - CAN_CTRLMODE_XL_TMS is set to true: TMS is enabled.
>>>     - CAN_CTRLMODE_XL_TMS is omitted: return -EOPNOTSUPP.
>>
>> I would propose to follow the usual pattern:
>>
>> - TMS off (default)
>> - TMS on (when selected on the command line)
> 
> OK. "TMS omitted" will be interpreted as "TMS off" in v2.
> 

Thx!

>>> For most of the other control modes, omitting a flag default to the
>>> option turned off. It could also be possible to provide a default
>>> behaviour if the TMS flag is omitted (i.e. either default to TMS off
>>> or on). However, it is not clear for the moment which default
>>> behaviour is preferable. If the usage shows a clear trend (for example
>>> if the vast majority of the users want TMS on by default), it is still
>>> possible to revisit that choice in the future. Whereas once a default
>>> option is provided, we can not change it back without breaking the
>>> interface.
>>>
>>> As a corollary, for the moment, the users will be forced to specify
>>> the TMS in the ip tool when using CAN XL.
>>>
>>> Add can_validate_xl_flags() to check the coherency of the TMS flag.
>>> That function will be reused in upcoming changes to validate the other
>>> CAN XL flags.
>>>
>>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>>> ---
>>> Question:
>>>
>>> Is it still possible to send Classical CAN frames when TMS is on? If
>>> not, we need to also add this filter in can_dev_dropped_skb():
>>
>> No.
>>
>> I've now learned there are two "CANXL-only" modes:
>>
>> 1. TMS on -> no CC/FD traffic
>> 2. TMS off and ERR_SIG off -> no CC/FD traffic, because CC/FD require ERR_SIG on
>> for a compliant transmission
> 
> I see. I was under the assumption that CC and FD could be used with error
> signalling off in mixed mode. Thanks!
> 
>> And there is a "mixed-mode" with CC/FD/XL with TMS off ('ERR_SIG on' is default
>> anyway).
>>
>> This "mixed-mode" requires all bitrates for CC/FD/XL to be set and all these CAN
>> protocols can be sent.
> 
> Why? Will your device reject the configuration if you omit the FD bitrate? I did
> not see anything in this direction in the ISO standard.
> 
> Did you have any source for this? Maybe the CiA provided some clarification
> which I am not aware of?

It wasn't clear to me either.

Please take a look into the X_CAN user manual here:

https://github.com/linux-can/can-doc/blob/master/x_can/xcan_user_manual_v350.pdf

1.5.5.3 Operating Mode

There you can see the valid (and invalid) modes & combinations.

When XL is on, FD also has to be on. Of course this is Bosch specific in 
the first place. But there are two modes (ERR_SIGNAL off either with TMS 
on or off) that are "CANXL-Only" which means no CC and no FD traffic as 
those need error-signalling. CAN XL is using the (CC) arbitration 
bitrate in this XL-only mode but CAN CC frames can not be sent.

I would recommend this CAN CiA Webinar from Dr. Arthur Mutter:
https://www.youtube.com/watch?v=OSEj6ISJKAM

As (only!) the CAN FD controllers are CAN XL tolerant (see video 
timestamp 18:53) the "mixed-mode" basically means "a mix of XL and FD 
controllers and protocols".

The fact that FD&XL controllers then can also send CC frames in this 
mixed-mode is just a side-effect IMO. The idea is FD & XL.

Therefore the two XL modes "XL-Only" and "mixed-mode" leads to FD on in 
the mixed-mode IMO. And this finally can be used in my "[PATCH 
b4/canxl-netlink v2] can: drop unsupported CAN frames on socket
and netdev level" patch.

Best regards,
Oliver

