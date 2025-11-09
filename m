Return-Path: <linux-can+bounces-5322-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0966AC44109
	for <lists+linux-can@lfdr.de>; Sun, 09 Nov 2025 15:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D9D3AB02E
	for <lists+linux-can@lfdr.de>; Sun,  9 Nov 2025 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9201A25C6E2;
	Sun,  9 Nov 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l416BI9h"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DFA1AAE13;
	Sun,  9 Nov 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762700092; cv=none; b=qr8MqhUaATEB1gcRSuM3618tKtJALKxrLNFusyVMXVWwaipTTnG7W+OSBLSl5H2WVB/HZiiEwv8dlSIr/s8Peq09lxyrnprkDu31qoJUVQ5VFDu5QaqhlckBaoxUvxYdzT/9h9OCgDG8nuqBXsvhwEiRDxCxZhjXWqpR7f+H+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762700092; c=relaxed/simple;
	bh=/4Yv/jaV9Z8e+gGtUJNrzGUWkGMtfx6KB72mTqnb5+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVsLMIdMb9z8/rI85LJWa6mpsyKvT1Cib5CjmzRB+gtLxUscj3ujN8oGjfjYaLCiOiGwTVFkgiyWoy/EYehqbT5YlslR8nRBeDXVKSuhZlom5BMEdaij84UTr+DbSbdqh+pnXO0iEmtZkpKLgsngXQfA/xtHNFIV0uhwLMHDwn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l416BI9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E083C4CEFB;
	Sun,  9 Nov 2025 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762700091;
	bh=/4Yv/jaV9Z8e+gGtUJNrzGUWkGMtfx6KB72mTqnb5+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l416BI9h0PQAqwmg7hJBaP1fEgj0bY/4YejQcAztocsXXtHYKyPWq5AZL4obiVorT
	 YOsheJVcBVEI2/BQTbPcXVOy/45qGXgAnfAwbso6pHuP8dR8Elvcnf8na7jGu9x8XW
	 +/SsWjgJP4Zr0EAhWMqvPBeyYQi7LV1Wc6QvH8N4enETAIB7Q1KvRi0DYLLIZSnbS+
	 SHfq4S5GEmeqf2U7BwHYfmHAaSTcI2WTWBt+o3nz68G792SKhTqEdLlfLU14fzxR/D
	 9o07WMWwd1IV5C+ICIk22RwhLHlCDzHtbZ2YzYsUiykU0diAn4tAOWmo8M3lB7iuJH
	 et0kQTOlQFOqQ==
Message-ID: <fc5e764d-3ef8-455e-9bae-bd50ea206ce2@kernel.org>
Date: Sun, 9 Nov 2025 15:54:48 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] can: netlink: add CAN_CTRLMODE_XL_ERR_SIGNAL
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
 <20251021-canxl-netlink-v2-6-8b8f58257ab6@kernel.org>
 <2c75aca3-a19a-4144-8be5-8fb7524e581e@hartkopp.net>
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
In-Reply-To: <2c75aca3-a19a-4144-8be5-8fb7524e581e@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/11/2025 at 09:50, Oliver Hartkopp wrote:
> On 21.10.25 17:47, Vincent Mailhol wrote:
>> Classical CAN and CAN FD must generate error frames on the CAN bus
>> when detecting a protocol violation.
>>
>> CAN XL's error signaling is different and works as follows:
>>
>>    - In interoperability mode (both FD and XL), error signaling must be
>>      on.
>>
>>    - When operating a CAN controller in CAN XL only mode but with TMS
>>      off, the user can decide whether the error signalling is enabled
>>      or disabled.
>>
>>    - On the contrary, when using TMS, error signalling must be off.
>>
>> Introduce the new CAN_CTRLMODE_XL_ERR_SIGNAL control mode. This new
>> option is only made available for CAN XL, so despite the error
>> signalling being always on for Classical CAN and CAN FD, forbid the
>> use of this flag when CAN XL is off.
>>
>> If the user provides the error signalling flag, check its validity. If
>> the flag is omitted, activate error signalling by default whenever
>> possible. This is summarized in below table:
>>
>>             CAN_CTRLMODE_XL_ERR_SIGNAL
>>     -------------------------------------------
>>     CC/FD        option not available
>>     CC/FD/XL    on
> 
> Yes. This is the 'mixed-mode'
> I would propose to use the 'mixed-mode' expression in the patch description.

Ack!

>>     XL TMS off    configurable (default on)
> 
> Good default.
> 
>>     XL TMS on    off
>>
>> Suggested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Link: https://lore.kernel.org/linux-can/20250527195625.65252-9-
>> socketcan@hartkopp.net/
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>> ---
>>   drivers/net/can/dev/dev.c        |  2 ++
>>   drivers/net/can/dev/netlink.c    | 29 +++++++++++++++++++++++++++--
>>   include/uapi/linux/can/netlink.h |  1 +
>>   3 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
>> index 1de5babcc4f3..0c16d0174f7f 100644
>> --- a/drivers/net/can/dev/dev.c
>> +++ b/drivers/net/can/dev/dev.c
>> @@ -125,6 +125,8 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
>>           return "xl-tdc-manual";
>>       case CAN_CTRLMODE_XL_TMS:
>>           return "xl-tms";
>> +    case CAN_CTRLMODE_XL_ERR_SIGNAL:
>> +        return "xl-error-signalling";
>>       default:
>>           return "<unknown>";
>>       }
>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>> index 8afd2baa03cf..6126b191fea0 100644
>> --- a/drivers/net/can/dev/netlink.c
>> +++ b/drivers/net/can/dev/netlink.c
>> @@ -191,7 +191,8 @@ static int can_validate_xl_flags(struct netlink_ext_ack
>> *extack,
>>           }
>>           if (masked_flags & CAN_CTRLMODE_XL_TMS) {
>>               const u32 tms_conflicts_mask = CAN_CTRLMODE_FD |
>> -                CAN_CTRLMODE_XL_TDC_MASK;
>> +                CAN_CTRLMODE_XL_TDC_MASK |
>> +                CAN_CTRLMODE_XL_ERR_SIGNAL;
>>               u32 tms_conflicts = masked_flags & tms_conflicts_mask;
>>                 if (tms_conflicts) {
>> @@ -201,11 +202,23 @@ static int can_validate_xl_flags(struct netlink_ext_ack
>> *extack,
>>                   return -EOPNOTSUPP;
>>               }
>>           }
>> +        if ((masked_flags & CAN_CTRLMODE_FD) &&
>> +            (mask & CAN_CTRLMODE_XL_ERR_SIGNAL) &&
>> +            !(masked_flags & CAN_CTRLMODE_XL_ERR_SIGNAL)) {
>> +            NL_SET_ERR_MSG(extack,
>> +                       "When using both CAN FD and XL, error signalling must
>> be on");

I changed that error message to:

	NL_SET_ERR_MSG(extack, "Mixed mode requires error signalling");

> This implicitly tells us that mixed-mode is CC/FD/XL ;-)

I was under the assumption that Classical CAN was always allowed, even under
TMS. The arbitration still uses the nominal bittiming anyway, so I still have
some issue understanding why an XL nodes operating under TMS wouldn't be able to
send a classical CAN frame.

The restriction seems rather arbitrary to me. I would be curious to understand
what the issue would be to allow Classical CAN under TMS.

>  > +            return -EOPNOTSUPP;
>> +        }
>>       } else {
>>           if (mask & CAN_CTRLMODE_XL_TMS) {
>>               NL_SET_ERR_MSG(extack, "TMS requires CAN XL");
>>               return -EOPNOTSUPP;
>>           }
>> +        if (mask & CAN_CTRLMODE_XL_ERR_SIGNAL) {
>> +            NL_SET_ERR_MSG(extack,
>> +                       "Error signalling is only configurable with CAN XL");
>> +            return -EOPNOTSUPP;
>> +        }
>>       }
>>         return 0;
>> @@ -310,6 +323,11 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>>                          "TMS can not be activated while CAN FD is on");
>>               return -EOPNOTSUPP;
>>           }
>> +        if (deactivated & CAN_CTRLMODE_XL_ERR_SIGNAL) {
>> +            NL_SET_ERR_MSG(extack,
>> +                       "Error signalling can not be deactivated while CAN FD
>> is on");
>> +            return -EOPNOTSUPP;
>> +        }
>>       }
>>         /* If a top dependency flag is provided, reset all its dependencies */
>> @@ -317,12 +335,19 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>>           priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
>>       if (cm->mask & CAN_CTRLMODE_XL)
>>           priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK |
>> -                    CAN_CTRLMODE_XL_TMS);
>> +                    CAN_CTRLMODE_XL_TMS |
>> +                    CAN_CTRLMODE_XL_ERR_SIGNAL);
>>         /* clear bits to be modified and copy the flag values */
>>       priv->ctrlmode &= ~cm->mask;
>>       priv->ctrlmode |= maskedflags;
>>   +    /* If omitted, set error signalling on if possible */
>> +    if ((maskedflags & CAN_CTRLMODE_XL) &&
>> +        !(cm->mask & CAN_CTRLMODE_XL_ERR_SIGNAL) &&
>> +        !(priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
>> +        priv->ctrlmode |= CAN_CTRLMODE_XL_ERR_SIGNAL;
>> +
>>       /* Wipe potential leftovers from previous CAN FD/XL config */
>>       if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {
>>           memset(&priv->fd.data_bittiming, 0,
>> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
>> index ebafb091d80f..30d446921dc4 100644
>> --- a/include/uapi/linux/can/netlink.h
>> +++ b/include/uapi/linux/can/netlink.h
>> @@ -108,6 +108,7 @@ struct can_ctrlmode {
>>   #define CAN_CTRLMODE_XL_TDC_AUTO    0x2000    /* XL transceiver
>> automatically calculates TDCV */
>>   #define CAN_CTRLMODE_XL_TDC_MANUAL    0x4000    /* XL TDCV is manually set
>> up by user */
>>   #define CAN_CTRLMODE_XL_TMS        0x8000    /* Transceiver Mode Switching */
>> +#define CAN_CTRLMODE_XL_ERR_SIGNAL    0x10000    /* XL error signalling */
>>     /*
>>    * CAN device statistics
>>
> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks!


Yours sincerely,
Vincent Mailhol

