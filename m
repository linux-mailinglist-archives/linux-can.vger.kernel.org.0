Return-Path: <linux-can+bounces-5454-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3650C61D60
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 22:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53AF44E0233
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 21:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3946F21FF2E;
	Sun, 16 Nov 2025 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB9VB8hi"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4DE1DD9AD
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763328861; cv=none; b=BTYxlJ935tQAb4AzlQrb+VRiyNR6LPgS64veERGSLUaseEbmprdzblpi4gAQlM+ZB5RXAw7h4eeHqpXEtOSNojXdpbH+UYji37opKko3Ibz+zyhZIv79BSu38xTQCRePaYMMtLh1TaQ5HMfX/LuooeR+AO8y1T1J9+L0tWOaxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763328861; c=relaxed/simple;
	bh=DuluFJLeP1A0bpVywv9rZXwtLK1PdcHZ8yFpRGM2r9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ft2c5aPrtPM9vnS/Sb/pp9FTwWFJGv/OL7MbUSHz43Je1hlNQZ5bwBULbSChCXu1xpmVfD9Vtxx9Tps9jIBOU2G+CmpiHk70T9BWiPJitkihnFkwe1n9tdwl6Aq6OlmIJ74Ony9BXHsDu/WvMahe8xJK0QUGPbtnMzEDnVmk1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB9VB8hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE540C4CEF1;
	Sun, 16 Nov 2025 21:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763328860;
	bh=DuluFJLeP1A0bpVywv9rZXwtLK1PdcHZ8yFpRGM2r9E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mB9VB8hirGtLm7D198KMcLrMWdPoVQ0DKdQyWgymMu0sqpks677j3ZMj18bGb6MVz
	 cxENWvSizxbtcnWNnkpFbjbyBeIi4jIN4DF4iSugZsCiGZDKy1QC/RWoTOOuwtzmlK
	 0uVVNmd3ZfQgntIxDji7CNjJvL38UUraf6gmd9pBTY/YclgTRKWIhiDzIxSVdR01xq
	 //ONH6XMsAVmRRiW2Ls9dYcYsyQoGGgMddcAu+e2Wl9v2VRlvWf5fMmGwRhv2pKAVT
	 sEuUTTCE1FV4GiFGX388tskMPDyCmvsRfCgsIbVzbLpJDBA2i/N9nTZYBXEwnLAYjS
	 8pj69vquMYzCQ==
Message-ID: <48fae6ee-94cf-444a-a6f1-53dc6fb44c34@kernel.org>
Date: Sun, 16 Nov 2025 22:34:17 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC remove CAN_CTRLMODE_XL_ERR_SIGNAL
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
Cc: linux-can@vger.kernel.org
References: <84cb473f-be5b-464b-a5d9-10c6f643f145@hartkopp.net>
 <ee2ecbeb-eb88-45a5-b13d-0616383e0987@kernel.org>
 <13906d6a-34be-47ff-bedf-c25a2d755aba@hartkopp.net>
 <67564299-c929-4eed-991c-90c311d6b90d@kernel.org>
 <61f731ac-3876-45e8-a5dc-6cfa24f2739d@hartkopp.net>
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
In-Reply-To: <61f731ac-3876-45e8-a5dc-6cfa24f2739d@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver,

On 15/11/2025 at 14:52, Oliver Hartkopp wrote:

(...)

>>>> Why isn't
>>>>
>>>>     4. Providing only CC/XL bitrates => ES on, TMS off
>>>>
>>>> a valid option?
>>>
>>> I had an off-list discussion with Stéphane and other PEAK System experts in June
>>> and the outcome was that CC/XL bitrates with ES on and TMS off is possible (only
>>> with the PEAK CAN XL IP core!) but will result in a nightmare for support teams.
>>
>> I will start by challenging this assertion.
>>
>> Looking at the X_CAN datasheet, I see:
>>
>>    1.4.5.22.2 Classical CAN
>>
>>    All Classical CAN TX messages are either accepted or rejected, see
>>    TX_FILTER_CTRL0.CC_CAN bit register. There is no other option for such
>>    Classical CAN protocol. The TX filter elements are only used
>>    for the CAN XL protocol.
>>
>>    1.4.5.22.3 CAN FD
>>
>>    All CAN FD messages are either accepted or rejected, see
>>    TX_FILTER_CTRL0.CAN_FD bit register. There is no other option for the CAN FD
>>    protocol. The TX filter elements are only used for the CAN XL
>>    protocol.
>>
>> Did you try those?
>>
> 
> For what reason? This is a detail of how Bosch creates there filtering but has
> nothing to do with what makes sense on the bus.

The reason is that we are discussing how to deactivate CAN FD on your device
when it is in mixed mode and it appears that your device has a CAN XL specific
feature to filter out CAN FD frames.

Why does your device have a CAN FD filter which can be used only under CAN XL
then? If it is not to disable CAN FD under mixed mode, what is it for?

(...)

>>> This setup covers all Bosch use-case slides and Bosch CAN XL IP core
>>> documentations (e.g. with the 1.5.5.3 Operating Mode table).
>>
>> You are referring to those slides, right?
>>
>> https://www.bosch-semiconductors.com/media/ip_modules/pdf_2/
>> can_xl_1/20230717_can_xl_overview.pdf
>>
>> I see in slide 16:
>>
>>    Error Signaling: Software Configurable: ON/OFF
> 
> Yes. Of course! As CAN XL can be used in mixed-mode together with CAN FD and in
> CANXL-only mode. And for those two cases you need to set that bit in the
> controller accordingly.
> 
> But you are mixing different thing here:
> 
> 1. The API to configure CAN FD and CAN XL in Linux
> 2. The API of the CAN XL controller
> 
> Item 1 is on a different level.
No, 1. and 2. are on the same layer. It is just that 1. is an abstraction of 2.
Also TMS and error signaling are at the same layer so if error signaling is only
at 2., where does TMS configuration go?

>> If you are just referring to the example use cases of slide 24, then no. You
>> should not be tunnel-visioned on a single slide when some other slide clearly
>> states differently.
> 
> It does not. And please do not name me tunnel-visioned.
> You have no such system on your desk to work with and you are over-engineering
> the CANXL-support with useless options trying to interpret the ISO specification.
> 
> Also the fact that the restricted mode is required for the CAN XL controller.
> The Linux kernel is not an ISO 11898 compliance checking tool.
> 
>> And in which world does an *example* use case in a slide deck take precedence on
>> the ISO standard? I am sorry, but taking a random slide to disprove what the
>> standard requires is not a receivable argument.
>>
>>> And we can omit the introduction of the CAN_CTRLMODE_XL_ERR_SIGNAL flag as this
>>> can be retrieved internally from CTRLMODE_XL and CAN_CTRLMODE_FD to be set into
>>> the controller registers.
>>>
>>> Not defining the FD bitrate in the mixed-mode causes more harm (to the system
>>> and the CAN bus itself) than urging the user to define it. Even if he doesn't
>>> use CAN FD frames.
>>
>> I also want to challenge this. You are claiming that the error signaling should
>> be an implicit value. What if someone requires error signaling because of some
>> safety requirements?
>>
>> Here you are just silently turning off a safety feature. How is the end user
>> meant to see the connection between disabling CAN FD and error signaling? By
>> dropping the flag, we also loss the reporting. No more way to see in the netlink
>> interface if error signaling is on or off.
> 
> You have no idea what you are talking about when you reference a safety feature
> here. There is a mixed mode with error-signalling and we have a CANXL-only mode
> which used an improved error recognition.
> 
> https://can-cia.org/fileadmin/cia/documents/proceedings/2020_mutter.pdf

You are saying that the CANXL *only* mode uses an improved error recognition?
Can you quote the relevant text in the paper?

The new error detection features are introduced at the CAN XL frame level,
namely: Header CRC, Frame CRC and fixed stuff bits. You do not have to disable
error signaling nor to be in "XL-only mode" to enable the new CAN XL safety
features. The only requirement is to send a CAN XL frame.

To me, the relevant paragraph is:

  §2.1 Bit Monitoring

  (...)

  A detailed explanation of the bit monitoring in CAN FD can be found in [10].
  If error signaling (via Error Frames) is enabled in CAN XL, bit monitoring is
  nearly equal to that in CAN FD. For the case that error signaling is disabled,
  bit monitoring is not yet fully specified in the current CiA610-1 draft.

I do not have access to CiA610-1, but my understanding here is that once error
signaling is disabled, you lose that bit monitoring (as defined in §2.1). And
so, the user is given the option to enable the error signaling on top of the
other CAN XL new error detection features.

It is not a

  error signaling
  vs.
  Header CRC + Frame CRC + fixed stuff bits

but rather:

  error signaling + Header CRC + Frame CRC + fixed stuff bits
  vs.
  Header CRC + Frame CRC + fixed stuff bits

Which brings us to my point: the CAN XL mode with error signaling has one
additional safety feature when compared to without error signaling. I never said
that CAN XL without error signaling is unsafe. I mean that it is less safe when
error signaling is turned off than it is when turned on.

And silently turning off *a* safety feature is bad (note the singular here and
in my previous message: I never claimed that turning off error signaling will
turn off all the other features).

> And this has nothing to do with safety.

In my research, I was looking at the AUTOSAR specification for CAN XL driver:

https://www.autosar.org/fileadmin/standards/R22-11/CP/AUTOSAR_SWS_CANXLDriver.pdf

In §7.2.3 "BusOff Handling without error signaling", they have a requirement to
emulate a error counter when error signaling is off.

  [CP_SWS_CanXL_00005] If error signaling is disabled, a basic CAN busoff
  handling with TEC (Transmission Error Counter) and REC (Reception
  Error Counter) shall be emulated in software.

If this is not related to safety, why is AUTOSAR requiring some software
workaround to compensate when error signaling is off?

>> The more I think about it, the more I am getting convinced that silently turning
>> off a safety feature and hiding its value is nothing but a bad decision.
> 
> No.
> 

(...)

>> What is not clear here is the 1.5.5.3 Operating Mode table, not the standard.
>>
> 
> No, but it clearly shows invalid configurations. Maybe you can focus on those.

Then explain me why:

  FDOE = 0, XLOE = 1, XLTR = 1, EFDI = 1

is invalid and why you must do:

  FDOE = 1, XLOE = 1, XLTR = 1, EFDI = 1

instead. We know that FD must be turned off when TMS is on, yet FDOE must be set
to 1.


The reality is that in your datasheet, FDOE = 1 does not mean that FD is on.

So:

  FDOE = 0, XLOE = 1, XLTR = 0, EFDI = 0

is invalid the same way

  FDOE = 0, XLOE = 1, XLTR = 1, EFDI = 1

is invalid.

>>> What is your interpretation of the standard here?
>>
>> It is not an interpretation. The standard clearly require that error signaling
>> should be configurable.
>>
>>> What do you think has to be supported beyond the features that Stéphane and I
>>> suggest?
>>
>> FD off + XL on + error signaling on.
> 
> This is mixed-mode. Mixed-mode is FD/XL controllers sharing the same segment and
> can talk CC/FD (FD-controllers) and CC/FD/XL (XL-controllers).
> 
> Removing the FD bitrate in this setup leads to problems, when BRS is used by
> anyone.

And one more time, why do you want to send FD frames when FD is off? It is
*normal* to get errors when receiving FD frames while FD is turned off. If FD is
off, there should be no FD nodes on the bus, period. Everything else is bogus.

This is really what I can not understand in your reasoning.


Yours sincerely,
Vincent Mailhol


