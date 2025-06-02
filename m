Return-Path: <linux-can+bounces-3752-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C1EACAE5C
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 14:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75381189FD92
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4615121B9C5;
	Mon,  2 Jun 2025 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="hMTyHcPG"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01EE1F461D;
	Mon,  2 Jun 2025 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748869046; cv=none; b=UdqDGwqnFKRoATRXYT/6rLofbv1Zrj5gIPEGiokSZ92Py5BeCG0RkaPGFxP/vKKwz/mMp+p4Q7Ei53VWjdYyPMyVm9VeEmnqyXNlo+ueOQ+BzPERGY1iXD09pPvT/ez7x61umKzNNBj9Szay1+C2t/3KEqMEDEiQZDgz23o29iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748869046; c=relaxed/simple;
	bh=1T+4SjlPktQEfdR3wxZEdOF+qZdvMuowjfd72KE39/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gfj0osIgjZvQAPmyr44hMmUKyQYpJmflmQZIRtLCqUjw8h6+bQgnQjK/Kv3eIJ7f8cKC2Z1wNJ7XM9Ej/f2IX+TLx2mkdiVk5xJ1IkihFkkG0jHK/YqLeP+nDUBZ4OwJS9BIiWVUqVTCXORKMdJbCbRESaITrZN9pZhSasqbss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=hMTyHcPG; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id M4hyu0vvBVLIhM4hzubQOb; Mon, 02 Jun 2025 14:56:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748868969;
	bh=tJpgnt56+6gsOzEu20toZVeHIgDQ2dRsyJW0tnHgKwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=hMTyHcPGlhHISDzQz5qTSzqnDykQUtWBMCIHzWUVj2pdesekSkWwhFfyMuuJwLfNa
	 UQaDLpOwEnOra0eVwbcoeXPA2VD6Tuz/XFbegSLffE2EXvWufC6f3rCVTsvLpXCYyS
	 gxWqq11aRkNodTBMMRdiqyTlCyVxfgql6CnE2lXt9rnxdAlQsqiuiKir8jHK4Cag7j
	 +Kmp4DqQOaLPeY7C2WGEJ09sL/qGDYQP3XZXlK05E5drY/TD3mkSDfPnMZbcxdlPAQ
	 wAyqk7Hn/XK70Fu8yuKqqL7uVT5cybD8bPOgcjnFVxRZscDpnZT+140aG2+BfCFrb+
	 OX5CSooo41hsw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 02 Jun 2025 14:56:09 +0200
X-ME-IP: 124.33.176.97
Message-ID: <ad3dbd97-eb25-41bc-a105-1fd328b53899@wanadoo.fr>
Date: Mon, 2 Jun 2025 21:56:05 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] can: netlink: add interface for CAN-FD Transmitter
 Delay Compensation (TDC)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Stefan_M=C3=A4tje?= <Stefan.Maetje@esd.eu>
References: <20210918095637.20108-1-mailhol.vincent@wanadoo.fr>
 <20210918095637.20108-5-mailhol.vincent@wanadoo.fr>
 <CAMuHMdVEBLoG084rhBtELcFO+3cA9_UrZrUfspOeLNo80zyb9g@mail.gmail.com>
 <10ed3ec2-ac66-494a-9d3f-bf2df459ebc0@wanadoo.fr>
 <CAMuHMdWDUpkwPVCm2Dha04F59MES4QvKFUVfvg70x5GPZHsxDA@mail.gmail.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <CAMuHMdWDUpkwPVCm2Dha04F59MES4QvKFUVfvg70x5GPZHsxDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/06/2025 at 16:23, Geert Uytterhoeven wrote:
> Hi Vincent,
> 
> On Sat, 31 May 2025 at 10:25, Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
>> On 30/05/2025 at 20:44, Geert Uytterhoeven wrote:

(...)

>> Let me first repost what I wrote but this time using numerals and letters
>> instead of the bullet points:
>>
>>   The TDC netlink logic works as follow:
>>
>>    1. CAN_CTRLMODE_FD is not provided:
>>       a) if any TDC parameters are provided: error.
>>
>>       b) TDC parameters not provided: TDC parameters unchanged.
>>
>>    2. CAN_CTRLMODE_FD is provided and is false:
>>       a) TDC is deactivated: both the structure and the
>>          CAN_CTRLMODE_TDC_{AUTO,MANUAL} flags are flushed.
>>
>>    3. CAN_CTRLMODE_FD provided and is true:
>>       a) CAN_CTRLMODE_TDC_{AUTO,MANUAL} and tdc{v,o,f} not provided: call
>>          can_calc_tdco() to automatically decide whether TDC should be
>>          activated and, if so, set CAN_CTRLMODE_TDC_AUTO and uses the
>>          calculated tdco value.
>>
>>       b) CAN_CTRLMODE_TDC_AUTO and tdco provided: set
>>          CAN_CTRLMODE_TDC_AUTO and use the provided tdco value. Here,
>>          tdcv is illegal and tdcf is optional.
>>
>>       c) CAN_CTRLMODE_TDC_MANUAL and both of tdcv and tdco provided: set
>>          CAN_CTRLMODE_TDC_MANUAL and use the provided tdcv and tdco
>>          value. Here, tdcf is optional.
>>
>>       d) CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive. Whenever
>>          one flag is turned on, the other will automatically be turned
>>          off. Providing both returns an error.
>>
>>       e) Combination other than the one listed above are illegal and will
>>          return an error.
>>
>> You can double check that it is the exact same as before.
>>
>>> By default, a CAN-FD interface comes up in TDC-AUTO mode (if supported),
>>> using a calculated tdco value.  However, enabling "tdc-mode auto"
>>> explicitly from userland requires also specifying an explicit tdco
>>> value.  I.e.
>>>
>>>     ip link set can0 type can bitrate 500000 dbitrate 8000000 fd on
>>                                                                 ^^^^^
>> Here:
>>
>>   - CAN_CTRLMODE_FD provided and is true: so we are in close 3.
>>
>>   - CAN_CTRLMODE_TDC_{AUTO,MANUAL} and tdc{v,o,f} not provided: so we *are* in
>>     sub-clause a)
>>
>> 3.a) tells that the framework will decide whether or not TDC should be
>> activated, and if activated, will set the TDCO.
>>
>>> gives "can <FD,TDC-AUTO>" and "tdcv 0 tdco 3", while
>>
>> Looks perfectly coherent with 3.a)
>>
>> Note that with lower data bitrate, the framework might have decided to set TDC off.
> 
> Yes, that case is fine for sure.
> 
>>>     ip link set can0 type can bitrate 500000 dbitrate 8000000 fd on
>>> tdc-mode auto
>>
>> This time:
>>
>>   - CAN_CTRLMODE_FD provided and is true: so we are in close 3.
>>
>>   - CAN_CTRLMODE_TDC_AUTO is provided, we are *not* in sub-clause a)
>>
>>   - tdco is not provided.
>>
>> No explicit clauses matches this pattern so it defaults to the last
>> sub-clause: e), which means an error.
>>
>>> gives:
>>>
>>>     tdc-mode auto: RTNETLINK answers: Operation not supported
>>
>> Looks perfectly coherent with 3.e)
> 
> Thanks, I misread this as clause 3.a being applicable (hasn't NOT a
> higher precedence than AND? ;-)

Now I see where your confusion comes from.

But if I read:

  Paul and Mary not present

I understand that both are absent. I do not see an ambiguity that Paul may be
present and only Mary absent.

Well, I guess this is what occurs when you write in English instead of C.

And I just realize that there was an actual mistake in my description: I forgot
to state the obvious and I omitted to mention that TDC_OFF means that TDC is
forcefully deactivated.

>>> unless I add an explicit "tdco 3".
>>
>> Yes, if you provide tcdo 3, then you are under 3.b).
>>
>>> According to your commit description, this is not the expected behavior?
>>> Thanks!
>>
>> Looking back to my commit, I admit that the explanation is convoluted and could
>> be hard to digest, but I do not see a mismatch between the description and the
>> behaviour.
> 
> OK, so the description and the behaviour do match.
> 
> However, I still find it a bit counter-intuitive that
> CAN_CTRLMODE_TDC_AUTO is not fully automatic, but automatic-with-one-
> manual-knob.

Fair enough. In truth, TDC_AUTO and TDC_MANUAL means respectively
TDC_ON_WITH_TDCV_AUTO and TDC_ON_WITH_TDCV_MANUAL.

The problem is that it makes close to no sense to allow the user to ask to have
TDC explicitly ON and TDCO automatically calculated. And if I recall, TDC_AUTO
and TDC_MANUAL is also consistent with what I found in the datasheets.

On a side note, I still have to update Documentation/networking/can.rst to add
some TDC explanations. I will of course not change the naming (this is part of
the UAPI, so now it is set in stone), but I will try to clarify the concerns you
raised here so that the documentation is more clear than my patch comments.

Also, I am not writing this documentation any soon. CAN-XL has a higher priority
in my TODO list :)


Yours sincerely,
Vincent Mailhol


