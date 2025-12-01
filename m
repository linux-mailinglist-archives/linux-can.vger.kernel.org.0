Return-Path: <linux-can+bounces-5796-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390AC99702
	for <lists+linux-can@lfdr.de>; Mon, 01 Dec 2025 23:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DAF3A2C01
	for <lists+linux-can@lfdr.de>; Mon,  1 Dec 2025 22:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC90B212FB3;
	Mon,  1 Dec 2025 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NglCFNYJ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874851E7C03
	for <linux-can@vger.kernel.org>; Mon,  1 Dec 2025 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629451; cv=none; b=sF5QZ+Y/eAkERoE+7mgFuLQw/ndZ0+yclfTAUhLN4kHA0A4qE/T+qFi6M5HYE/CN2XLtucci7CEPWdO+jtzPdIi2N6oJ69zmNrqNKjx4VCY2k+brPBHr1xg6FbuhrXjNxHiOM1Jy62wozjxaX0fcJHUBU77T0l9nPaFwwvZoSBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629451; c=relaxed/simple;
	bh=QK7wpghPychk6rAC+u/12HuF7GUy9jap0m32cHEAvJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBbMmD5ki6byPBG/hNdyuY54VfNrAok57m/OwDFRuOmKjmj48j+zXTkiu9n2DphxMwsqSaRSWdR2R7x1b0yRRbSyiCDjUpVY+MSjfx4qaIIv/HoJvgtMqvEvSsINonFCsUjB3DQR21lDacEE09f+1G4kd3YsARP3fYfWIuWMtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NglCFNYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E10C19421;
	Mon,  1 Dec 2025 22:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629451;
	bh=QK7wpghPychk6rAC+u/12HuF7GUy9jap0m32cHEAvJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NglCFNYJ2O1iarGy6GR0wkMprUYeJhWVzWd4GTaM/7aT3M2E8fLxzSuHF88riGSE2
	 sU8RS8YjqiLtN+qMCgpaD0zHETRmmq3otC6eDa8ODymEi/GzBGAKOedVm7T2Ru/5kB
	 V3LuFxruhJ+BdDAsV6swkbx/ggsL/0D3XXpJyc7afe0gB9mzN33GImJfIBJi/ugeKF
	 3tyl78Ad1eaop+jMB9I6IL9yZBS3AFYBN/6LyOt6pzQhM7oPCuR9r3GQSX2YoRqFEz
	 poVv1B0cdDb8XuKSguOLxL0eyrdfA7VtERx8Z3VFwImgb4ywV83SJTJXYQyKOX4WYw
	 s8IjI4Lj60jHg==
Message-ID: <d4a8d6bc-dcc2-4e93-b52d-72754821e450@kernel.org>
Date: Mon, 1 Dec 2025 23:50:48 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ip command using uninitialized flags?
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <49120f0f-d05d-471c-8e9a-fbce75161e4e@hartkopp.net>
 <931bc305-f575-47e2-a7f7-62e2f179e75d@hartkopp.net>
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
In-Reply-To: <931bc305-f575-47e2-a7f7-62e2f179e75d@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Oliver,

On 01/12/2025 at 18:01, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> when you are working on the next patch set for iproute2 can you please also take
> a look at this issue?
> 
> This wasn't a bit thing with CAN FD only - but now having FD/XL/TMS the
> initialization of those defaults to be "off" before parsing the command line
> would be better IMO.
> 
> Best regards,
> Oliver
> 
> On 16.11.25 20:42, Oliver Hartkopp wrote:
>> Hi all,
>>
>> switching from mixed-mode (FD/XL) to CANXL-only with TMS on the FD flag seems
>> to survive:
>>
>> Here FD is set to on:
>>
>> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 dbitrate 2000000
>> fd on xbitrate 4000000 xl on tms on
>> Error: TMS and fd are mutually exclusive.
>>
>> And here FD is not set but still seems to be active:
>>
>> root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 4000000
>> xl on tms on
>> Warning: TMS can not be activated while CAN FD is on.

The first thing is that under the current design, flags are kept on by default.

For example:

  # ip link set can0 type can bitrate 500000 fd on dbitrate 2000000
  # ip link set can0 type can bitrate 1000000
  (...)
    can <FD,TDC-AUTO> state STOPPED restart-ms 0
  (...)

Here, FD is still on despite not being specified the second time.

Then, for CAN XL, the same behavior is preserved:

  # ip link set can0 type can bitrate 1000000 fd on dbitrate 2000000 \
    xl on xbitrate 8000000
  # ip link set can0 type can bitrate 1000000 \
    xl on tms on xbitrate 20000000
  Warning: TMS can not be activated while CAN FD is on.

Here, the second command is the same as:

  # ip link set can0 type can bitrate 1000000 fd on dbitrate 2000000 \
    xl on tms on xbitrate 20000000

because FD is still active from the first one.

And then, there is your command:

  # modprobe -r dummy-can
  # modprobe dummy-can
  # ip link set can0 type can bitrate 1000000 dbitrate 2000000 fd on \
    xbitrate 4000000 xl on tms on
  Error: TMS and FD are mutually exclusive.
  $ ip --details link show can0
  (...)
    can state STOPPED restart-ms 0
  (...)
  # ip link set can0 type can bitrate 1000000 xbitrate 4000000 \
    xl on tms on
  # ip --details link show can
  (...)
    can <XL,TMS> state STOPPED restart-ms 0
  (...)

When I try what you did on a clean set-up (thus the "modprobe -r dummy-can"), I
can not reproduce. So it seems that the FD flag was still active from an earlier
command. Or maybe you fixed some behaviour in your last series? (sorry I did not
check the evolution of the code).

>> Is this a common pattern not to modify flags that are not explicitly defined?
>>
>> Or should the flags be zero-initialized with the defaults (0 = off) ??

My pick is that there is an establish behaviour that the flag should stay as-if
if not specified (c.f. my first example). So zeroing out all the parameters
would be a kind of API breaking change.

The exception is that setting off a "parent" option will forcefully reset any
child option because otherwise, these would become invalid. For example, doing
"fd off" will wipe all the fd bitrate parameters (dbitrate, dsample-point, dtq,
dprop-seg, dphase-seg1, dphase-seg2, dsjw,tdcv, tdco and tdcf). Same for "xl off".

>> ps. IMO the "Warning: TMS can not be activated while CAN FD is on." should be
>> an "Error: TMS ..."
Indeed… I will not be touching the kernel code for the next couple weeks because
of some other personal priorities, but this is a valid point.


Yours sincerely,
Vincent Mailhol


