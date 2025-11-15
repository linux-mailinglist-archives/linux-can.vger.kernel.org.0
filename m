Return-Path: <linux-can+bounces-5423-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817EAC6067E
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 14:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16673AF9BC
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CE22FB0AE;
	Sat, 15 Nov 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="HDTuQtgt";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="E6SN/CZ4"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69027254B19;
	Sat, 15 Nov 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763215146; cv=pass; b=Hc4kuJuL3H0pGwD6pasOBu3nB0PQVJTpRnIS/myKebBTo8Qy5DjA6mnPEJecqypQRQRE8jX8jJkKp3cFY0vTkrfsJX4luRQNMEl1sKZInamNQE6PBQdtxxW+Hf0jrGwpJLn39GfJKpMObwiCuFRmRE79C1X1YZR2M8RP9XKj65s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763215146; c=relaxed/simple;
	bh=5lyel52ncBkdBxzx3QP1Q0Qyzg972vELbfTyoeaOigo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiEkw1aKyJLjKnB2ctmS+1To9FfpsXbfWdtssvfdOfx2Qyq/uxAuplR8YHU/351w8IgBaeyG41T4hlbXAmrM9sCevr/JB7O8/3PN+pYKfkOkgMAr2K9oQQomDOJx6sSPEQlw7JOsxy/bFVG0E72vcZUSQI6g2mYHSd7oswEGjDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=HDTuQtgt; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=E6SN/CZ4; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763215141; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BzjTX449M3lGuSHcDPJ65Cr3hiwVyAHF5rZGxS5y52m5tqLAPX0MGEy/ebMI1Ym9w4
    zP0JN2EOac0H0u0umkw29mKWlZi1ulZQ8m4RI3FcJMKkFr7fWwmQ+ePKUmRsq/x7Jwfl
    eV3mReiG0IH9CwLStHMTYDl5ro4pXkrmri3Iy1l7rHCkebC/Z17JiI3/LeVRrD7rBYPW
    Suq99oi7luDy1k2YoTqU3pXa3NQ8gPRfcvwKs0i4m7rgKXO0o/gvZUyHUsfaHZnVN2O4
    TzJFjdZ+d7updd3DkdV71oksBl8t7RpSQdEeNBwebF76r6aRd2chyhd3yPbx/Uwo8FhK
    eo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763215141;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5yEV4Og4FPxdRXqc3xTkyguXmDA6T64LiK63qus5iDw=;
    b=j7VzlG6zw7wEXlPkMkXGSXT2Y0rslxsz1p1QO7nfnfDmiVFqF4Ayz12PhxS57CodRW
    OGdZNLy5Q33d1+CdJKihuHMHq7/NOSwk2y4CbaA6SOyCpDZ14GXUQ7wy/rIYc/5N2pq4
    Q64laaEWcn2eseJ8qcBcc8y7+6KhYz1gYpOc6/hyqjyRqutYHkvomU7gPEKaT7XKk46o
    7sWh6b1u22tgwhrkzqAr1T7xg4yY+GbTfntzp9D5MWC/sXQ1bGXgib0v/TkBrnZmUNvh
    YRZqZCYLgu2xmzjOTJNmx44Of/aCyEFVxhSUyGPj10d8JKZDO2xrfbISMvU2j+nh6L1T
    j07Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763215141;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5yEV4Og4FPxdRXqc3xTkyguXmDA6T64LiK63qus5iDw=;
    b=HDTuQtgtP/KMDGtPyaFIrKYMjc4Gce043WjiNBY4kvZTi1kp5WffvYEMOCX47WrENv
    2G2hIqRRqDopyLotuxxixSP4dCSsXSAdcCPxbsgr9HR37uZ3VLxdiCl2DFHIDS5DfPkG
    VkykTPLzFjaY9cSQtGOG8eO8J9lh5zUYKiuES0T3Q7Ku233hHwhr86CZjh+YyQtj/j/2
    TiUyDbI9KitTa0BjlSIysdmxzPtf0CSjVjU/qe/r7xKNoRSO6fIblWQr4L45Nh2DJAlt
    Fy+2cHTMvZvwByzUkdcJKQUI2WFTDpcSILbFEAHJXKLRGk4IMLUTvZ/5926CuA+XOpZ0
    RK+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763215141;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5yEV4Og4FPxdRXqc3xTkyguXmDA6T64LiK63qus5iDw=;
    b=E6SN/CZ4jayegwG5A7XZInjikragau7XBMk4rex+xf5P/WfMkyrPj+SilHU7w0qbju
    Zb7oyEBKluPICs+i2RDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFDx0dnw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 14:59:00 +0100 (CET)
Message-ID: <0215c945-378d-4390-9110-c664857a4926@hartkopp.net>
Date: Sat, 15 Nov 2025 14:58:59 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] can: netlink: add initial CAN XL support
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
 <20251013-canxl-netlink-v1-3-f422b7e2729f@kernel.org>
 <e58c90a8-c9e3-4f9b-99cb-09b87c18d657@hartkopp.net>
 <72d2721c-6713-4e6a-b0d4-28f600715808@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <72d2721c-6713-4e6a-b0d4-28f600715808@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.11.25 14:35, Vincent Mailhol wrote:
> On 14/11/2025 at 14:19, Oliver Hartkopp wrote:
>> Hi Vincent,
>>
>> On 13.10.25 13:01, Vincent Mailhol wrote:
>>> CAN XL uses bittiming parameters different from Classical CAN and CAN
>>> FD. Thus, all the data bittiming parameters, including TDC, need to be
>>> duplicated for CAN XL.
>>>
>>> Add the CAN XL netlink interface for all the features which are common
>>> with CAN FD. Any new CAN XL specific features are added later on.
>>>
>>> Add a check that CAN XL capable nodes correctly provide
>>> CAN_CTRLMODE_RESTRIC_OP as mandated by ISO 11898-1:2024 §6.6.19.
>>>
>>> The first time CAN XL is activated, the MTU is set by default to
>>> CANXL_MAX_MTU. The user may then configure a custom MTU within the
>>> CANXL_MIN_MTU to CANXL_MIN_MTU range, in which case, the custom MTU
>>> value will be kept as long as CAN XL remains active.
>>>
>>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>>> ---
>>> Changelog:
>>>
>>> RFC -> v1:
>>>
>>>     - Correctly wipe out the CAN XL data bittiming and TDC parameters
>>>       when switching CAN_CTRLMODE_XL off.
>>>
>>>     - Add one level on nesting for xl parameters so that:
>>>
>>>        - bittiming are under priv->xl.data_bittiming{,_const}¨
>>>        - pwm are under priv->xl.pwm{,_const}
>>>
>>>     - Many other code refactors.
>>> ---
>>>    drivers/net/can/dev/dev.c        | 14 ++++++-
>>>    drivers/net/can/dev/netlink.c    | 87 ++++++++++++++++++++++++++++++++--------
>>>    include/linux/can/bittiming.h    |  6 ++-
>>>    include/linux/can/dev.h          |  7 +++-
>>>    include/uapi/linux/can/netlink.h |  7 ++++
>>>    5 files changed, 100 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
>>> index 3377afb6f1c4..32f11db88295 100644
>>> --- a/drivers/net/can/dev/dev.c
>>> +++ b/drivers/net/can/dev/dev.c
>>> @@ -117,6 +117,12 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
>>>            return "fd-tdc-manual";
>>>        case CAN_CTRLMODE_RESTRICTED:
>>>            return "restricted-operation";
>>> +    case CAN_CTRLMODE_XL:
>>> +        return "xl";
>>> +    case CAN_CTRLMODE_XL_TDC_AUTO:
>>> +        return "xl-tdc-auto";
>>> +    case CAN_CTRLMODE_XL_TDC_MANUAL:
>>> +        return "xl-tdc-manual";
>>>        default:
>>>            return "<unknown>";
>>>        }
>>> @@ -350,7 +356,13 @@ void can_set_default_mtu(struct net_device *dev)
>>>    {
>>>        struct can_priv *priv = netdev_priv(dev);
>>>    -    if (priv->ctrlmode & CAN_CTRLMODE_FD) {
>>> +    if (priv->ctrlmode & CAN_CTRLMODE_XL) {
>>> +        if (can_is_canxl_dev_mtu(dev->mtu))
>>> +            return;
>>> +        dev->mtu = CANXL_MTU;
>>> +        dev->min_mtu = CANXL_MIN_MTU;
>>> +        dev->max_mtu = CANXL_MAX_MTU;
>>> +    } else if (priv->ctrlmode & CAN_CTRLMODE_FD) {
>>>            dev->mtu = CANFD_MTU;
>>>            dev->min_mtu = CANFD_MTU;
>>>            dev->max_mtu = CANFD_MTU;
>>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>>> index f44b5dffa176..2405f1265488 100644
>>> --- a/drivers/net/can/dev/netlink.c
>>> +++ b/drivers/net/can/dev/netlink.c
>>> @@ -2,7 +2,7 @@
>>>    /* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
>>>     * Copyright (C) 2006 Andrey Volkov, Varma Electronics
>>>     * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
>>> - * Copyright (C) 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>> + * Copyright (C) 2021-2025 Vincent Mailhol <mailhol@kernel.org>
>>>     */
>>>      #include <linux/can/dev.h>
>>> @@ -22,6 +22,9 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
>>>        [IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
>>>        [IFLA_CAN_TDC] = { .type = NLA_NESTED },
>>>        [IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
>>> +    [IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
>>> +    [IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct
>>> can_bittiming_const) },
>>> +    [IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
>>>    };
>>>      static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
>>> @@ -70,7 +73,7 @@ static int can_validate_tdc(struct nlattr *data_tdc,
>>>            return -EOPNOTSUPP;
>>>        }
>>>    -    /* If one of the CAN_CTRLMODE_TDC_* flag is set then TDC
>>> +    /* If one of the CAN_CTRLMODE_{,XL}_TDC_* flags is set then TDC
>>>         * must be set and vice-versa
>>>         */
>>>        if ((tdc_auto || tdc_manual) && !data_tdc) {
>>> @@ -82,8 +85,8 @@ static int can_validate_tdc(struct nlattr *data_tdc,
>>>            return -EOPNOTSUPP;
>>>        }
>>>    -    /* If providing TDC parameters, at least TDCO is needed. TDCV
>>> -     * is needed if and only if CAN_CTRLMODE_TDC_MANUAL is set
>>> +    /* If providing TDC parameters, at least TDCO is needed. TDCV is
>>> +     * needed if and only if CAN_CTRLMODE_{,XL}_TDC_MANUAL is set
>>>         */
>>>        if (data_tdc) {
>>>            struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
>>> @@ -126,10 +129,10 @@ static int can_validate_databittiming(struct nlattr
>>> *data[],
>>>        bool is_on;
>>>        int err;
>>>    -    /* Make sure that valid CAN FD configurations always consist of
>>> +    /* Make sure that valid CAN FD/XL configurations always consist of
>>>         * - nominal/arbitration bittiming
>>>         * - data bittiming
>>> -     * - control mode with CAN_CTRLMODE_FD set
>>> +     * - control mode with CAN_CTRLMODE_{FD,XL} set
>>>         * - TDC parameters are coherent (details in can_validate_tdc())
>>>         */
>>>    @@ -139,7 +142,10 @@ static int can_validate_databittiming(struct nlattr
>>> *data[],
>>>            is_on = flags & CAN_CTRLMODE_FD;
>>>            type = "FD";
>>>        } else {
>>> -        return -EOPNOTSUPP; /* Place holder for CAN XL */
>>> +        data_tdc = data[IFLA_CAN_XL_TDC];
>>> +        tdc_flags = flags & CAN_CTRLMODE_XL_TDC_MASK;
>>> +        is_on = flags & CAN_CTRLMODE_XL;
>>> +        type = "XL";
>>>        }
>>>          if (is_on) {
>>> @@ -206,6 +212,11 @@ static int can_validate(struct nlattr *tb[], struct
>>> nlattr *data[],
>>>        if (err)
>>>            return err;
>>>    +    err = can_validate_databittiming(data, extack,
>>> +                     IFLA_CAN_XL_DATA_BITTIMING, flags);
>>> +    if (err)
>>> +        return err;
>>> +
>>>        return 0;
>>>    }
>>>    @@ -215,7 +226,8 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>>>    {
>>>        struct can_priv *priv = netdev_priv(dev);
>>>        struct can_ctrlmode *cm;
>>> -    u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing;
>>> +    const u32 xl_mandatory = CAN_CTRLMODE_RESTRICTED;
>>> +    u32 ctrlstatic, maskedflags, notsupp, ctrlstatic_missing, xl_missing;
>>>          if (!data[IFLA_CAN_CTRLMODE])
>>>            return 0;
>>> @@ -229,6 +241,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>>>        maskedflags = cm->flags & cm->mask;
>>>        notsupp = maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
>>>        ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
>>> +    xl_missing = (priv->ctrlmode_supported & xl_mandatory) ^ xl_mandatory;
>>>          if (notsupp) {
>>>            NL_SET_ERR_MSG_FMT(extack,
>>> @@ -248,21 +261,36 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>>>            return -EOPNOTSUPP;
>>>        }
>>>    +    if ((priv->ctrlmode_supported & CAN_CTRLMODE_XL) && xl_missing) {
>>> +        NL_SET_ERR_MSG_FMT(extack,
>>> +                   "bad device: CAN XL capable nodes must support the %s mode",
>>> +                   can_get_ctrlmode_str(xl_missing));
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +
>>
>> I'm not sure if it is our job to check for ISO 11898-1:2024 compliance of CAN
>> controllers when CAN_CTRLMODE_RESTRICTED is not supported.
>>
>> IMO an appropriate error message (only) when the user requests this feature
>> would be better and that is already the standard behaviour.
> 
> For this one, the initial logic was to avoid some incorrect configurations such
> as providing CAN_CTRLMODE_XL_TMS without CAN_CTRLMODE_XL_ERR_SIGNAL.
> 
> Contrarily to the other flags, CAN XL introduces some intricacies between some
> of the flags and giving full freedom on what must be set or not is asking for
> troubles.
> 
> That said, the CAN_CTRLMODE_RESTRICTED is different and does not depend on the
> other flags. I just added it at the end after adding the check logic for the
> other XL flags (this appears first in the series because of some rebase, but
> trust me, I implemented this last).
> 
> Then, should we go for this or not? The benefit I see to add this check would be
> less effort on the patch reviews for new devices (which I am mostly doing
> recently). I can foreseen that people will wrongly use CAN_CTRLMODE_LISTENONLY
> instead of CAN_CTRLMODE_RESTRICTED. This piece of code will make sure that they
> will implement CAN_CTRLMODE_RESTRICTED. And because this feature is mandatory, I
> thought this wasn't a too bad idea. This will also save me the effort to ask if
> to people submitting patches if this feature is supported or not.
> 
> If someone comes with a non-compliant device, we can still statically set the
> flag. So this isn't even a blocker for non compliant devices.

We had the same issue with non-iso CAN FD devices.

IMO we should provide the CAN_CTRLMODE_RESTRICTED feature like any other 
feature in the control modes (like e.g. triple-sampling). And when a 
device shows up that needs a special handling beyond our good working 
netlink API capabilities we talk about it in we will find a solution. As 
always.

Best regards,
Oliver
  >
> So, at the end, this is mostly a selfish feature to remove some patch reviewing
> effort (while still pushing toward ISO compliance, which isn't a bad thing either).
> 
> I prefer to have it like this, but this isn't a strong opinion either.
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 


