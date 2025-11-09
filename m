Return-Path: <linux-can+bounces-5324-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9E0C444B2
	for <lists+linux-can@lfdr.de>; Sun, 09 Nov 2025 18:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42C094E1F25
	for <lists+linux-can@lfdr.de>; Sun,  9 Nov 2025 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8762B3A8F7;
	Sun,  9 Nov 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XAEElANX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="f4/B/Myn"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AFD219A8D;
	Sun,  9 Nov 2025 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762710381; cv=pass; b=u8KMunwooITgimHDjKwjufKqNMXa4iSb3B73/wRKviesKG/i41B4qdQHSOqRGMLddufpLgm1nYWg3PzskHxDog1K0WA/nnAFhvkBKeKkD9Q9ui/zU0arQWp0vl2kj73LCrFBup6Ui68qyq8oMoGLsDEvQi/qV1iMDENZL4XrOHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762710381; c=relaxed/simple;
	bh=kNtzX8qZGDVafArtUkNpaxILOLl1xsqsaCd2TnX/Azo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RR3NGn4jV+BOqAiRCXHruICHYjweuhNQISJPoX2qPQN7d22lr3eT3ac553yPASPele+eUjO+IigovI8iS085nKjE2w9S/RUDMNPg4rpGHIYXdeIXYYGyWfnmYtCK4SAoOvgMTeoNGOwcxmnneX6DLWWOpkFGDSy1jiTvTOBdcHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XAEElANX; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=f4/B/Myn; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762710370; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J7rtUFKrbfqG2dqt6di5BQeFp6iKwmK1Qt9V8h40RpP4QodvhIGpZdzaJMShQtSDuI
    TDACOkF/dZtnmv8f6p9OPl0iUqgEFG2ukuGs7smZrgOE0CoPJZBMbwIUefeeulPP1XWk
    5VNz+9HrzWsVMHbATHAST6HAvAg9XVEfWs1fJqMYu8qhuTB7F+8f+9jQd/HttsS4XqHS
    bWj1KpJmTI+cmAzgl44O5bIAQxMMSWj2EcIaRwaeRXrqHf7wvgNkLGFEEmjn9PDmLUQ6
    1W2wJAMPJ2av0u+0zVCeAD+nGdYqvJ3HvN4L13L0f13SJncnnnhyh80UkJLCRI7UDKYW
    kdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762710370;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QzdL4dmKiNVl4ZhtoI7/zrStiFZAFdN3mFcq/k7BHh4=;
    b=O0VDWREmwXGx6mf3yVdYnFSA9EHhbHjHh3ZxHuVAkUEP0/5/Fgv3gzs0v3WfzX2/WX
    ehf9u8sLY9l7jjidiGsT55YsXaqA+bDqYZ3+X6TA+wFI+DricQ7B0Uu9KpALtLg1yrtG
    9iZTcKDcuSU/Vg6a0gmyaYmUcW+CXOrfxkW1MnVMWV0Td7eIZYRvEz0X2sEccAW66lSv
    GvYQS9aXUg0n2eldNrFJKscA5XufDijwyB1JNw/f+XhadKvUTmJCXVaCiClUtNBgIMzJ
    y7RZWFivpxr8iv0PeHsB9LAJyMP2efWAumtLZpQTT0bEczAjtBwANlvX8Y6HyJJh+HMX
    nCCw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762710370;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QzdL4dmKiNVl4ZhtoI7/zrStiFZAFdN3mFcq/k7BHh4=;
    b=XAEElANX5uuzZvm64HYsrAGrgittLx7eLGzoazQ1/gjdw+ZeAU4pLZbGWrBt3MYihm
    HCFq2C0T77YIIk/IQJIs8H/WAKCIZJwtbvlVKYpwZYiYiN55CPPk8UGm5ycG0kX1Ngxr
    U0ba0nssIvpm1O62gYinH/+4wKghSdiIb75y7lYWlxvdK0HwCIXiHIBYlq90y4Zop/Ku
    WTIvIRFa//i5cK8Av8lAxiB31vsJGI3NceZzW5ouwq/izVtcabCccvUK7hHbNJoToCCg
    HiuszFbeIuKGpDNQ8mi+aLN3h9ZSzhwkbN/mThd8K2HzhttSycCwZAB9uKKDkiduFIYt
    FgNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1762710370;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QzdL4dmKiNVl4ZhtoI7/zrStiFZAFdN3mFcq/k7BHh4=;
    b=f4/B/MynFde51DtHtgrklpdCQWHEnJ8YhpqBhbZiB0zL8/NdeAbahQjFabtxYpCf+Q
    y7ArMdQrn95XBHHeMsAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461A9Hk9FDn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 9 Nov 2025 18:46:09 +0100 (CET)
Message-ID: <dd8302fe-d6fb-456d-ac9e-ceb9ea3ab0a6@hartkopp.net>
Date: Sun, 9 Nov 2025 18:46:09 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] can: netlink: add CAN_CTRLMODE_XL_ERR_SIGNAL
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
 <20251021-canxl-netlink-v2-6-8b8f58257ab6@kernel.org>
 <2c75aca3-a19a-4144-8be5-8fb7524e581e@hartkopp.net>
 <fc5e764d-3ef8-455e-9bae-bd50ea206ce2@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <fc5e764d-3ef8-455e-9bae-bd50ea206ce2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09.11.25 15:54, Vincent Mailhol wrote:
> On 06/11/2025 at 09:50, Oliver Hartkopp wrote:
>> On 21.10.25 17:47, Vincent Mailhol wrote:
>>> Classical CAN and CAN FD must generate error frames on the CAN bus
>>> when detecting a protocol violation.
>>>
>>> CAN XL's error signaling is different and works as follows:
>>>
>>>     - In interoperability mode (both FD and XL), error signaling must be
>>>       on.
>>>
>>>     - When operating a CAN controller in CAN XL only mode but with TMS
>>>       off, the user can decide whether the error signalling is enabled
>>>       or disabled.
>>>
>>>     - On the contrary, when using TMS, error signalling must be off.
>>>
>>> Introduce the new CAN_CTRLMODE_XL_ERR_SIGNAL control mode. This new
>>> option is only made available for CAN XL, so despite the error
>>> signalling being always on for Classical CAN and CAN FD, forbid the
>>> use of this flag when CAN XL is off.
>>>
>>> If the user provides the error signalling flag, check its validity. If
>>> the flag is omitted, activate error signalling by default whenever
>>> possible. This is summarized in below table:
>>>
>>>              CAN_CTRLMODE_XL_ERR_SIGNAL
>>>      -------------------------------------------
>>>      CC/FD        option not available
>>>      CC/FD/XL    on
>>
>> Yes. This is the 'mixed-mode'
>> I would propose to use the 'mixed-mode' expression in the patch description.
> 
> Ack!
> 
>>>      XL TMS off    configurable (default on)
>>
>> Good default.
>>
>>>      XL TMS on    off
>>>
>>> Suggested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>> Link: https://lore.kernel.org/linux-can/20250527195625.65252-9-
>>> socketcan@hartkopp.net/
>>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>>> ---
>>>    drivers/net/can/dev/dev.c        |  2 ++
>>>    drivers/net/can/dev/netlink.c    | 29 +++++++++++++++++++++++++++--
>>>    include/uapi/linux/can/netlink.h |  1 +
>>>    3 files changed, 30 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
>>> index 1de5babcc4f3..0c16d0174f7f 100644
>>> --- a/drivers/net/can/dev/dev.c
>>> +++ b/drivers/net/can/dev/dev.c
>>> @@ -125,6 +125,8 @@ const char *can_get_ctrlmode_str(u32 ctrlmode)
>>>            return "xl-tdc-manual";
>>>        case CAN_CTRLMODE_XL_TMS:
>>>            return "xl-tms";
>>> +    case CAN_CTRLMODE_XL_ERR_SIGNAL:
>>> +        return "xl-error-signalling";
>>>        default:
>>>            return "<unknown>";
>>>        }
>>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>>> index 8afd2baa03cf..6126b191fea0 100644
>>> --- a/drivers/net/can/dev/netlink.c
>>> +++ b/drivers/net/can/dev/netlink.c
>>> @@ -191,7 +191,8 @@ static int can_validate_xl_flags(struct netlink_ext_ack
>>> *extack,
>>>            }
>>>            if (masked_flags & CAN_CTRLMODE_XL_TMS) {
>>>                const u32 tms_conflicts_mask = CAN_CTRLMODE_FD |
>>> -                CAN_CTRLMODE_XL_TDC_MASK;
>>> +                CAN_CTRLMODE_XL_TDC_MASK |
>>> +                CAN_CTRLMODE_XL_ERR_SIGNAL;
>>>                u32 tms_conflicts = masked_flags & tms_conflicts_mask;
>>>                  if (tms_conflicts) {
>>> @@ -201,11 +202,23 @@ static int can_validate_xl_flags(struct netlink_ext_ack
>>> *extack,
>>>                    return -EOPNOTSUPP;
>>>                }
>>>            }
>>> +        if ((masked_flags & CAN_CTRLMODE_FD) &&
>>> +            (mask & CAN_CTRLMODE_XL_ERR_SIGNAL) &&
>>> +            !(masked_flags & CAN_CTRLMODE_XL_ERR_SIGNAL)) {
>>> +            NL_SET_ERR_MSG(extack,
>>> +                       "When using both CAN FD and XL, error signalling must
>>> be on");
> 
> I changed that error message to:
> 
> 	NL_SET_ERR_MSG(extack, "Mixed mode requires error signalling");
> 

Good!

>> This implicitly tells us that mixed-mode is CC/FD/XL ;-)
> 
> I was under the assumption that Classical CAN was always allowed, even under
> TMS. The arbitration still uses the nominal bittiming anyway, so I still have
> some issue understanding why an XL nodes operating under TMS wouldn't be able to
> send a classical CAN frame.

TMS is XL-Only and has error-signalling off. Therefore no CC/FD traffic.

> The restriction seems rather arbitrary to me. I would be curious to understand
> what the issue would be to allow Classical CAN under TMS.

I tried to clarify this in the other answer.

Best regards,
Oliver

