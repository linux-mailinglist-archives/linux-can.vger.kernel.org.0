Return-Path: <linux-can+bounces-3739-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F2AC9A0B
	for <lists+linux-can@lfdr.de>; Sat, 31 May 2025 10:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B39B9E1DF1
	for <lists+linux-can@lfdr.de>; Sat, 31 May 2025 08:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D962367BC;
	Sat, 31 May 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="O1YaF8uH"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDB156F28;
	Sat, 31 May 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748679914; cv=none; b=pgy78RSIwktjBGyeM9pnC746juHofKCVMtWlxwlSowZe1Wq9DmvnpdctvJ9vPH4iIoFWmt3C2JBA8kjWiGJeE91lkeI2oSJTxDKHEHCyahbIGx+SH5HsecM7CBJGwfeh12zzLbE4i6oCjD2iZcS/3BdRBxZZBD2V7TTVJXbv6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748679914; c=relaxed/simple;
	bh=MjVWmkwHnmmJoIjCB1pi36wZ5EN1mRelCrY/of1Y8Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pF8071ebZNmVdNPDjbldiXALCiq1P7BzEycUCuw+Jj2PJZi0Q19Vai/GjXvqqTYwgu2XsBWrG21EUKYEait/DO2J1VIRJTuU6ngnu5xj42jEiMvlnlbF9vId6uZHB2fvmGY+I/L1rxLP5X+Qwvl0+zLU/4DOjdNBzLUeEx0hsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=O1YaF8uH; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id LHWVuydzdyzRELHWWuLXT6; Sat, 31 May 2025 10:25:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748679902;
	bh=2UxUsLSI9cJnAR9lAWYLYOx2TiTSnICm96fYVIit21k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=O1YaF8uH8KMmQL8HJjbQO/2aipJ//smiKL0+vM2wf3cW3QdSrisft6Oh7elCmy9Sd
	 accSbF8BRyxbg32gAJAghDsmclcieke7o5kWWJAxp5Z6GHHhU4MJEd66Yl5YF1FjBZ
	 NuKweDCtBAFn5bVoMR5LWJv/33Za/W5dpV6gN4lkhNcfyKh8PeMASLrudi1ENMUZPA
	 vnoBR6RtXTybzsQlC4rhN+mlbpr+0Jxluo1vhi0d1LW/AH8sA6kFjFAXqTeOJYaQ1K
	 hGab/SegtEMaRU9+lrTv9vp/oRSA92Ryi8M3hbMdIrZWhZ8aLVzK1N9ULcEll0Ik3+
	 ceZFtSmOKCQ7w==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 31 May 2025 10:25:02 +0200
X-ME-IP: 124.33.176.97
Message-ID: <10ed3ec2-ac66-494a-9d3f-bf2df459ebc0@wanadoo.fr>
Date: Sat, 31 May 2025 17:24:58 +0900
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
In-Reply-To: <CAMuHMdVEBLoG084rhBtELcFO+3cA9_UrZrUfspOeLNo80zyb9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geert,

On 30/05/2025 at 20:44, Geert Uytterhoeven wrote:
> Hi Vincent,
> 
> Thanks for your patch, which is now commit d99755f71a80df33
> ("can: netlink: add interface for CAN-FD Transmitter Delay
> Compensation (TDC)") in v5.16.
> 
> On Sat, 18 Sept 2021 at 20:23, Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
>> Add the netlink interface for TDC parameters of struct can_tdc_const
>> and can_tdc.
>>
>> Contrary to the can_bittiming(_const) structures for which there is
>> just a single IFLA_CAN(_DATA)_BITTMING(_CONST) entry per structure,
>> here, we create a nested entry IFLA_CAN_TDC. Within this nested entry,
>> additional IFLA_CAN_TDC_TDC* entries are added for each of the TDC
>> parameters of the newly introduced struct can_tdc_const and struct
>> can_tdc.
>>
>> For struct can_tdc_const, these are:
>>         IFLA_CAN_TDC_TDCV_MIN
>>         IFLA_CAN_TDC_TDCV_MAX
>>         IFLA_CAN_TDC_TDCO_MIN
>>         IFLA_CAN_TDC_TDCO_MAX
>>         IFLA_CAN_TDC_TDCF_MIN
>>         IFLA_CAN_TDC_TDCF_MAX
>>
>> For struct can_tdc, these are:
>>         IFLA_CAN_TDC_TDCV
>>         IFLA_CAN_TDC_TDCO
>>         IFLA_CAN_TDC_TDCF
>>
>> This is done so that changes can be applied in the future to the
>> structures without breaking the netlink interface.
>>
>> The TDC netlink logic works as follow:
>>
>>  * CAN_CTRLMODE_FD is not provided:
>>     - if any TDC parameters are provided: error.
>>
>>     - TDC parameters not provided: TDC parameters unchanged.
>>
>>  * CAN_CTRLMODE_FD is provided and is false:
>>      - TDC is deactivated: both the structure and the
>>        CAN_CTRLMODE_TDC_{AUTO,MANUAL} flags are flushed.
>>
>>  * CAN_CTRLMODE_FD provided and is true:
>>     - CAN_CTRLMODE_TDC_{AUTO,MANUAL} and tdc{v,o,f} not provided: call
>>       can_calc_tdco() to automatically decide whether TDC should be
>>       activated and, if so, set CAN_CTRLMODE_TDC_AUTO and uses the
>>       calculated tdco value.
> 
> This is not reflected in the code (see below).

Let me first repost what I wrote but this time using numerals and letters
instead of the bullet points:

  The TDC netlink logic works as follow:

   1. CAN_CTRLMODE_FD is not provided:
      a) if any TDC parameters are provided: error.

      b) TDC parameters not provided: TDC parameters unchanged.

   2. CAN_CTRLMODE_FD is provided and is false:
      a) TDC is deactivated: both the structure and the
         CAN_CTRLMODE_TDC_{AUTO,MANUAL} flags are flushed.

   3. CAN_CTRLMODE_FD provided and is true:
      a) CAN_CTRLMODE_TDC_{AUTO,MANUAL} and tdc{v,o,f} not provided: call
         can_calc_tdco() to automatically decide whether TDC should be
         activated and, if so, set CAN_CTRLMODE_TDC_AUTO and uses the
         calculated tdco value.

      b) CAN_CTRLMODE_TDC_AUTO and tdco provided: set
         CAN_CTRLMODE_TDC_AUTO and use the provided tdco value. Here,
         tdcv is illegal and tdcf is optional.

      c) CAN_CTRLMODE_TDC_MANUAL and both of tdcv and tdco provided: set
         CAN_CTRLMODE_TDC_MANUAL and use the provided tdcv and tdco
         value. Here, tdcf is optional.

      d) CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive. Whenever
         one flag is turned on, the other will automatically be turned
         off. Providing both returns an error.

      e) Combination other than the one listed above are illegal and will
         return an error.

You can double check that it is the exact same as before.

> By default, a CAN-FD interface comes up in TDC-AUTO mode (if supported),
> using a calculated tdco value.  However, enabling "tdc-mode auto"
> explicitly from userland requires also specifying an explicit tdco
> value.  I.e.
> 
>     ip link set can0 type can bitrate 500000 dbitrate 8000000 fd on
                                                                ^^^^^
Here:

  - CAN_CTRLMODE_FD provided and is true: so we are in close 3.

  - CAN_CTRLMODE_TDC_{AUTO,MANUAL} and tdc{v,o,f} not provided: so we *are* in
    sub-clause a)

3.a) tells that the framework will decide whether or not TDC should be
activated, and if activated, will set the TDCO.

> gives "can <FD,TDC-AUTO>" and "tdcv 0 tdco 3", while

Looks perfectly coherent with 3.a)

Note that with lower data bitrate, the framework might have decided to set TDC off.

>     ip link set can0 type can bitrate 500000 dbitrate 8000000 fd on
> tdc-mode auto

This time:

  - CAN_CTRLMODE_FD provided and is true: so we are in close 3.

  - CAN_CTRLMODE_TDC_AUTO is provided, we are *not* in sub-clause a)

  - tdco is not provided.

No explicit clauses matches this pattern so it defaults to the last
sub-clause: e), which means an error.

> gives:
> 
>     tdc-mode auto: RTNETLINK answers: Operation not supported

Looks perfectly coherent with 3.e)

> unless I add an explicit "tdco 3".

Yes, if you provide tcdo 3, then you are under 3.b).

> According to your commit description, this is not the expected behavior?
> Thanks!

Looking back to my commit, I admit that the explanation is convoluted and could
be hard to digest, but I do not see a mismatch between the description and the
behaviour.


Yours sincerely,
Vincent Mailhol


