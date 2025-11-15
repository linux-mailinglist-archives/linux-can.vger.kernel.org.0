Return-Path: <linux-can+bounces-5420-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C51C6060C
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 14:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3496934CAC1
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4202BDC09;
	Sat, 15 Nov 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mqf+BM3X"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641F274B23;
	Sat, 15 Nov 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763213763; cv=none; b=IpATURXinCrjQZSsE8vElfZd960R+oDkk7jjEtN+Y2ZKj3gaJ/aegj2rT3QR7HhmlKzheTnH+gvyDW1XFs6Y1PAeqeywoXjcf90KXuuIyTaDQ0H1QXJU4aRiNIvSQXW+JnHBNUFTrLt+bLEEM6l+VOq9zGJ5ZBRmk0vHdua9Ghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763213763; c=relaxed/simple;
	bh=ZlVoVNKvuba/qD1GCk03j1zusSHqzgwZaYH4b6H2P04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8PsIECyB8wzSdDkfQIAWYZCCedjWGe/Vl+auhFnxqjX1GlIZHJ2Q+/SPqpGuswfQKn5FKAQX0fydcM9sjpkmAwghsqSg/9SOYswqBlD+0T0qcYR9gaOJYCvE23jv0RBWZFX0d7ROdd5KMyVFSbW0Si9QAe6wpVOcVi4glAv1h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mqf+BM3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A510C116B1;
	Sat, 15 Nov 2025 13:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763213762;
	bh=ZlVoVNKvuba/qD1GCk03j1zusSHqzgwZaYH4b6H2P04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mqf+BM3XwMPihOyqdr/AXXwNI/kG6UlX44zvKT6c3vDILUR9DwhwcP8/3hN14V8Zv
	 8il0Ypzi6O6f1NlIunnA6JPOjBvv01Af/km2Ztw1MVOGpQAeU1snUhVS8PCK0Ne8Ow
	 7NNJqqf3rLgiTWHwUNlSV3X71dCViBsEHa/K8vxYdDFYBAVsD5Zqj9lQMZh/FvSLNB
	 +2y0gIuqZJuCw3QtstiJSl/rxCX0D45Iq6ASYrvUOTBnSO401sAszFf/rX1nz+AIvt
	 bplnZ3OJzY3TDzi/sGkgT6C+xCFjBt9WAcB1JTvawWex34howc4WOJrt5NFevOflVr
	 Gj4UGyZwoZIDA==
Message-ID: <72d2721c-6713-4e6a-b0d4-28f600715808@kernel.org>
Date: Sat, 15 Nov 2025 14:35:58 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] can: netlink: add initial CAN XL support
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
 <20251013-canxl-netlink-v1-3-f422b7e2729f@kernel.org>
 <e58c90a8-c9e3-4f9b-99cb-09b87c18d657@hartkopp.net>
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
In-Reply-To: <e58c90a8-c9e3-4f9b-99cb-09b87c18d657@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/11/2025 at 14:19, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 13.10.25 13:01, Vincent Mailhol wrote:
>> CAN XL uses bittiming parameters different from Classical CAN and CAN
>> FD. Thus, all the data bittiming parameters, including TDC, need to be
>> duplicated for CAN XL.
>>
>> Add the CAN XL netlink interface for all the features which are common
>> with CAN FD. Any new CAN XL specific features are added later on.
>>
>> Add a check that CAN XL capable nodes correctly provide
>> CAN_CTRLMODE_RESTRIC_OP as mandated by ISO 11898-1:2024 §6.6.19.
>>
>> The first time CAN XL is activated, the MTU is set by default to
>> CANXL_MAX_MTU. The user may then configure a custom MTU within the
>> CANXL_MIN_MTU to CANXL_MIN_MTU range, in which case, the custom MTU
>> value will be kept as long as CAN XL remains active.
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>> ---
>> Changelog:
>>
>> RFC -> v1:
>>
>>    - Correctly wipe out the CAN XL data bittiming and TDC parameters
>>      when switching CAN_CTRLMODE_XL off.
>>
>>    - Add one level on nesting for xl parameters so that:
>>
>>       - bittiming are under priv->xl.data_bittiming{,_const}¨
>>       - pwm are under priv->xl.pwm{,_const}
>>
>>    - Many other code refactors.
>> ---
>>   drivers/net/can/dev/dev.c        | 14 ++++++-
>>   drivers/net/can/dev/netlink.c    | 87 ++++++++++++++++++++++++++++++++--------
>>   include/linux/can/bittiming.h    |  6 ++-
>>   include/linux/can/dev.h          |  7 +++-
>>   include/uapi/linux/can/netlink.h |  7 ++++
>>   5 files changed, 100 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
>> index 3377afb6f1c4..32f11db88295 100644
>> --- a/drivers/net/can/dev/dev.c
>> +++ b/drivers/net/can/dev/dev.c
>> @@ -117,6 +117,12 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
>>           return "fd-tdc-manual";
>>       case CAN_CTRLMODE_RESTRICTED:
>>           return "restricted-operation";
>> +    case CAN_CTRLMODE_XL:
>> +        return "xl";
>> +    case CAN_CTRLMODE_XL_TDC_AUTO:
>> +        return "xl-tdc-auto";
>> +    case CAN_CTRLMODE_XL_TDC_MANUAL:
>> +        return "xl-tdc-manual";
>>       default:
>>           return "<unknown>";
>>       }
>> @@ -350,7 +356,13 @@ void can_set_default_mtu(struct net_device *dev)
>>   {
>>       struct can_priv *priv = netdev_priv(dev);
>>   -    if (priv->ctrlmode & CAN_CTRLMODE_FD) {
>> +    if (priv->ctrlmode & CAN_CTRLMODE_XL) {
>> +        if (can_is_canxl_dev_mtu(dev->mtu))
>> +            return;
>> +        dev->mtu = CANXL_MTU;
>> +        dev->min_mtu = CANXL_MIN_MTU;
>> +        dev->max_mtu = CANXL_MAX_MTU;
>> +    } else if (priv->ctrlmode & CAN_CTRLMODE_FD) {
>>           dev->mtu = CANFD_MTU;
>>           dev->min_mtu = CANFD_MTU;
>>           dev->max_mtu = CANFD_MTU;
>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>> index f44b5dffa176..2405f1265488 100644
>> --- a/drivers/net/can/dev/netlink.c
>> +++ b/drivers/net/can/dev/netlink.c
>> @@ -2,7 +2,7 @@
>>   /* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
>>    * Copyright (C) 2006 Andrey Volkov, Varma Electronics
>>    * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
>> - * Copyright (C) 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> + * Copyright (C) 2021-2025 Vincent Mailhol <mailhol@kernel.org>
>>    */
>>     #include <linux/can/dev.h>
>> @@ -22,6 +22,9 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
>>       [IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
>>       [IFLA_CAN_TDC] = { .type = NLA_NESTED },
>>       [IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
>> +    [IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
>> +    [IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct
>> can_bittiming_const) },
>> +    [IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
>>   };
>>     static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
>> @@ -70,7 +73,7 @@ static int can_validate_tdc(struct nlattr *data_tdc,
>>           return -EOPNOTSUPP;
>>       }
>>   -    /* If one of the CAN_CTRLMODE_TDC_* flag is set then TDC
>> +    /* If one of the CAN_CTRLMODE_{,XL}_TDC_* flags is set then TDC
>>        * must be set and vice-versa
>>        */
>>       if ((tdc_auto || tdc_manual) && !data_tdc) {
>> @@ -82,8 +85,8 @@ static int can_validate_tdc(struct nlattr *data_tdc,
>>           return -EOPNOTSUPP;
>>       }
>>   -    /* If providing TDC parameters, at least TDCO is needed. TDCV
>> -     * is needed if and only if CAN_CTRLMODE_TDC_MANUAL is set
>> +    /* If providing TDC parameters, at least TDCO is needed. TDCV is
>> +     * needed if and only if CAN_CTRLMODE_{,XL}_TDC_MANUAL is set
>>        */
>>       if (data_tdc) {
>>           struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
>> @@ -126,10 +129,10 @@ static int can_validate_databittiming(struct nlattr
>> *data[],
>>       bool is_on;
>>       int err;
>>   -    /* Make sure that valid CAN FD configurations always consist of
>> +    /* Make sure that valid CAN FD/XL configurations always consist of
>>        * - nominal/arbitration bittiming
>>        * - data bittiming
>> -     * - control mode with CAN_CTRLMODE_FD set
>> +     * - control mode with CAN_CTRLMODE_{FD,XL} set
>>        * - TDC parameters are coherent (details in can_validate_tdc())
>>        */
>>   @@ -139,7 +142,10 @@ static int can_validate_databittiming(struct nlattr
>> *data[],
>>           is_on = flags & CAN_CTRLMODE_FD;
>>           type = "FD";
>>       } else {
>> -        return -EOPNOTSUPP; /* Place holder for CAN XL */
>> +        data_tdc = data[IFLA_CAN_XL_TDC];
>> +        tdc_flags = flags & CAN_CTRLMODE_XL_TDC_MASK;
>> +        is_on = flags & CAN_CTRLMODE_XL;
>> +        type = "XL";
>>       }
>>         if (is_on) {
>> @@ -206,6 +212,11 @@ static int can_validate(struct nlattr *tb[], struct
>> nlattr *data[],
>>       if (err)
>>           return err;
>>   +    err = can_validate_databittiming(data, extack,
>> +                     IFLA_CAN_XL_DATA_BITTIMING, flags);
>> +    if (err)
>> +        return err;
>> +
>>       return 0;
>>   }
>>   @@ -215,7 +226,8 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>>   {
>>       struct can_priv *priv = netdev_priv(dev);
>>       struct can_ctrlmode *cm;
>> -    u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing;
>> +    const u32 xl_mandatory = CAN_CTRLMODE_RESTRICTED;
>> +    u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing, xl_missing;
>>         if (!data[IFLA_CAN_CTRLMODE])
>>           return 0;
>> @@ -229,6 +241,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>>       maskedflags = cm->flags & cm->mask;
>>       notsupp = maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
>>       ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
>> +    xl_missing = (priv->ctrlmode_supported & xl_mandatory) ^ xl_mandatory;
>>         if (notsupp) {
>>           NL_SET_ERR_MSG_FMT(extack,
>> @@ -248,21 +261,36 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>>           return -EOPNOTSUPP;
>>       }
>>   +    if ((priv->ctrlmode_supported & CAN_CTRLMODE_XL) && xl_missing) {
>> +        NL_SET_ERR_MSG_FMT(extack,
>> +                   "bad device: CAN XL capable nodes must support the %s mode",
>> +                   can_get_ctrlmode_str(xl_missing));
>> +        return -EOPNOTSUPP;
>> +    }
>> +
> 
> I'm not sure if it is our job to check for ISO 11898-1:2024 compliance of CAN
> controllers when CAN_CTRLMODE_RESTRICTED is not supported.
> 
> IMO an appropriate error message (only) when the user requests this feature
> would be better and that is already the standard behaviour.

For this one, the initial logic was to avoid some incorrect configurations such
as providing CAN_CTRLMODE_XL_TMS without CAN_CTRLMODE_XL_ERR_SIGNAL.

Contrarily to the other flags, CAN XL introduces some intricacies between some
of the flags and giving full freedom on what must be set or not is asking for
troubles.

That said, the CAN_CTRLMODE_RESTRICTED is different and does not depend on the
other flags. I just added it at the end after adding the check logic for the
other XL flags (this appears first in the series because of some rebase, but
trust me, I implemented this last).

Then, should we go for this or not? The benefit I see to add this check would be
less effort on the patch reviews for new devices (which I am mostly doing
recently). I can foreseen that people will wrongly use CAN_CTRLMODE_LISTENONLY
instead of CAN_CTRLMODE_RESTRICTED. This piece of code will make sure that they
will implement CAN_CTRLMODE_RESTRICTED. And because this feature is mandatory, I
thought this wasn't a too bad idea. This will also save me the effort to ask if
to people submitting patches if this feature is supported or not.

If someone comes with a non-compliant device, we can still statically set the
flag. So this isn't even a blocker for non compliant devices.

So, at the end, this is mostly a selfish feature to remove some patch reviewing
effort (while still pushing toward ISO compliance, which isn't a bad thing either).

I prefer to have it like this, but this isn't a strong opinion either.


Yours sincerely,
Vincent Mailhol


