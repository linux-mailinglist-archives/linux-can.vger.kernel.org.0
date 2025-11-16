Return-Path: <linux-can+bounces-5455-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAF5C61DED
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 22:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFE33AEBCD
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 21:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9C2690C0;
	Sun, 16 Nov 2025 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6NV9CqH"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3D1F0E34
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763330087; cv=none; b=ErpI7UUb4kX+F/Eb6gaSOZSs2FOZSi+2CeIlkdv3GhUYH+9SyJ2cWB/2Sp44BMR7VUfvg3YIygtQI9CQQdkEhDN0odQy8kcGElmsAxjh8D6WWV0OMOQFBv9cgKWzH4NzhMhOdAFsIlWmV6FTlpbfITYIenL+wL7uUCXi3lZOWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763330087; c=relaxed/simple;
	bh=zn+2t3HCokrvlE3MNCZ2FC02ky/HjIw2Dr2SvVO/akw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltdQFznmtM2QYf8WtweObHWhacpyUqkg182Fpal5x703EMAWjev//TFE4M+mLeiPAK4xNYB03MI6iFNQAPLb+2kR4epqPEbzpGfL7PPPFxw7Q8bnps9P8PBl2eB8vxtx5bPO/cOIgUMMF9nLURvWubFdu1i6z13RDey1iHJMP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6NV9CqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4E4C4CEFB;
	Sun, 16 Nov 2025 21:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763330086;
	bh=zn+2t3HCokrvlE3MNCZ2FC02ky/HjIw2Dr2SvVO/akw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c6NV9CqHDQnSQjXcqZIkBMmSQjpsarRuMU+hmp1GBEOb31KMYOGLjBt2fRZfoZDhB
	 fq23pSUyhaCJVXjDyP+AmBjfDbcF8wumx+n6ALBdIhM0NUAKUuSEvEKrKfdNDaSns/
	 PlE3cPm4NOceLoVgL16Bc8sWSIjt1K1b8pU/ZfotkZLxO/pk+QZ7PGrv8m/jz/kC54
	 lltU5XWyzrT0ZjYNvMR3+yGKa2XVirgEKAV3Kkk31UKm93+y2KQdnIrwMwhyol0In2
	 PvhPLFZoABoOgKNgL5KIhGTkeoYqUtxlCPaVjLHNf9c2uoPX5/fyiXWg8ImLklrIst
	 5tHsE7l7UoWNw==
Message-ID: <8788fd27-8998-4dbc-98e9-1bd9557d15e9@kernel.org>
Date: Sun, 16 Nov 2025 22:54:44 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v2 05/15] can: netlink: add CAN_CTRLMODE_XL_TMS flag
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
References: <20251115163740.7875-1-socketcan@hartkopp.net>
 <20251115163740.7875-6-socketcan@hartkopp.net>
 <c77caed0-5d88-4b2c-b371-3e2870324b4d@hartkopp.net>
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
In-Reply-To: <c77caed0-5d88-4b2c-b371-3e2870324b4d@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver,

On 16/11/2025 à 20:31, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 15.11.25 17:37, Oliver Hartkopp wrote:
>> From: Vincent Mailhol <mailhol@kernel.org>
>>
>> The Transceiver Mode Switching (TMS) indicates whether the CAN XL
>> controller shall use the PWM or NRZ encoding during the data phase.
>>
>> The term "transceiver mode switching" is used in both ISO 11898-1 and
>> CiA 612-2 (although only the latter one uses the abbreviation TMS). We
>> adopt the same naming convention here for consistency.
>>
>> Add the CAN_CTRLMODE_XL_TMS flag to the list of the CAN control modes.
>>
>> Add can_validate_xl_flags() to check the coherency of the TMS flag.
>> That function will be reused in upcoming changes to validate the other
>> CAN XL flags.
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>> ---
>>   drivers/net/can/dev/dev.c        |  2 ++
>>   drivers/net/can/dev/netlink.c    | 48 ++++++++++++++++++++++++++++++--
>>   include/uapi/linux/can/netlink.h |  1 +
>>   3 files changed, 48 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
>> index 443692587217..9da3da8c6225 100644
>> --- a/drivers/net/can/dev/dev.c
>> +++ b/drivers/net/can/dev/dev.c
>> @@ -121,10 +121,12 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
>>           return "xl";
>>       case CAN_CTRLMODE_XL_TDC_AUTO:
>>           return "xl-tdc-auto";
>>       case CAN_CTRLMODE_XL_TDC_MANUAL:
>>           return "xl-tdc-manual";
>> +    case CAN_CTRLMODE_XL_TMS:
>> +        return "xl-tms";
>>       default:
>>           return "<unknown>";
>>       }
>>   }
>>   EXPORT_SYMBOL_GPL(can_get_ctrlmode_str);
>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>> index 26c25e660e31..5a628c629109 100644
>> --- a/drivers/net/can/dev/netlink.c
>> +++ b/drivers/net/can/dev/netlink.c
>> @@ -179,10 +179,36 @@ static int can_validate_databittiming(struct nlattr
>> *data[],
>>           return err;
>>         return 0;
>>   }
>>   +static int can_validate_xl_flags(struct netlink_ext_ack *extack,
>> +                 u32 masked_flags, u32 mask)
>> +{
>> +    if (masked_flags & CAN_CTRLMODE_XL) {
>> +        if (masked_flags & CAN_CTRLMODE_XL_TMS) {
>> +            const u32 tms_conflicts_mask = CAN_CTRLMODE_FD |
>> +                CAN_CTRLMODE_XL_TDC_MASK;
>> +            u32 tms_conflicts = masked_flags & tms_conflicts_mask;
>> +
>> +            if (tms_conflicts) {
>> +                NL_SET_ERR_MSG_FMT(extack,
>> +                           "TMS and %s are mutually exclusive",
>> +                           can_get_ctrlmode_str(tms_conflicts));
> 
> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 dbitrate 2000000 fd
> on xbitrate 4000000 xl on tms on
> Error: TMS and fd are mutually exclusive.
> 
> The error messages should look consistent in terms of capitalization.
> 
> Maybe can_get_ctrlmode_str() should deliver capitalized strings as we see it in
> the 'ip' tool output:

In a full English sentence, I tend to see ALL CAPITALIZED WORDS as kind of
aggressive. Whereas I find this to be OK in other things which are not sentences
(like the ip link show). So I opted for the lower case option in
can_get_ctrlmode_str(). And then, I messed up here by mixing both as you pointed
here…

This is not really something I care about. The thing is that
can_get_ctrlmode_str() is already upstream, so fixing this would require a
separate patch, which is a tiny bit more work, but not a blocker either.

> root@de1soc1:~# ./ip -det link show can0
> 11: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 2060 qdisc pfifo_fast state UP mode
> DEFAULT group default qlen 10
>     link/can  promiscuity 0 allmulti 0 minmtu 16 maxmtu 16
>     can <FD,TDC-AUTO,XL,XL-TDC-AUTO> state STOPPED restart-ms 0
> 
>> +                return -EOPNOTSUPP;
>> +            }
>> +        }
>> +    } else {
>> +        if (mask & CAN_CTRLMODE_XL_TMS) {
>> +            NL_SET_ERR_MSG(extack, "TMS requires CAN XL");
> 
> This looks good btw.
> 
>> +            return -EOPNOTSUPP;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int can_validate(struct nlattr *tb[], struct nlattr *data[],
>>               struct netlink_ext_ack *extack)
>>   {
>>       u32 flags = 0;
>>       int err;
>> @@ -199,10 +225,14 @@ static int can_validate(struct nlattr *tb[], struct
>> nlattr *data[],
>>               (flags & CAN_CTRLMODE_RESTRICTED)) {
>>               NL_SET_ERR_MSG(extack,
>>                          "Listen-only and restricted modes are mutually
>> exclusive");
> 
> IMO this should also be capitalized ...
> 
> "LISTEN-MODE and RESTRICTED modes are mutually exclusive");

This is typically the kind of thing where I prefer the lower case. The above
seems as if the error message is shouting at me.

Well, if you still prefer upper case after my explanation, I will change.

>>               return -EOPNOTSUPP;
>>           }
>> +
>> +        err = can_validate_xl_flags(extack, flags, cm->mask);
>> +        if (err)
>> +            return err;
>>       }
>>         err = can_validate_bittiming(data, extack, IFLA_CAN_BITTIMING);
>>       if (err)
>>           return err;
>> @@ -224,11 +254,11 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>>                      struct nlattr *data[],
>>                      struct netlink_ext_ack *extack)
>>   {
>>       struct can_priv *priv = netdev_priv(dev);
>>       struct can_ctrlmode *cm;
>> -    u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing;
>> +    u32 ctrlstatic, maskedflags, deactivated, notsupp, ctrlstatic_missing;
>>         if (!data[IFLA_CAN_CTRLMODE])
>>           return 0;
>>         /* Do not allow changing controller mode while running */
>> @@ -236,10 +266,11 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>>           return -EBUSY;
>>         cm = nla_data(data[IFLA_CAN_CTRLMODE]);
>>       ctrlstatic = can_get_static_ctrlmode(priv);
>>       maskedflags = cm->flags & cm->mask;
>> +    deactivated = ~cm->flags & cm->mask;
>>       notsupp = maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
>>       ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
>>         if (notsupp) {
>>           NL_SET_ERR_MSG_FMT(extack,
>> @@ -257,15 +288,25 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>>                      "missing required %s static control mode",
>>                      can_get_ctrlmode_str(ctrlstatic_missing));
>>           return -EOPNOTSUPP;
>>       }
>>   +    /* If FD was active and is not turned off, check for XL conflicts */
>> +    if (priv->ctrlmode & CAN_CTRLMODE_FD & ~deactivated) {
>> +        if (maskedflags & CAN_CTRLMODE_XL_TMS) {
>> +            NL_SET_ERR_MSG(extack,
>> +                       "TMS can not be activated while CAN FD is on");
> "TMS can not be activated while FD is on");
> 
> And this also.

Ack.


Yours sincerely,
Vincent Mailhol


