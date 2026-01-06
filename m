Return-Path: <linux-can+bounces-6016-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ABDCFB3A0
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 23:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40D033044201
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 22:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E652130EF90;
	Tue,  6 Jan 2026 22:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIRL00bp"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B33431195F;
	Tue,  6 Jan 2026 22:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737693; cv=none; b=Tz6qAvLjKKrMgsF8tfwL1o3+os8YE6WTTa/VSCQBSf+DL1yKn2iuG8jqbwKvLg0fgYVZfV7BZGrcT+lkiiyVVJKrA8Z6PRUtdCxTCbhgRX0Mu1gpIystITBE8Dz2AEY7W52tQWqGBhihQW4XQoyO20jTvY6lnZbvDbD+xq1cu10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737693; c=relaxed/simple;
	bh=nbmr59PqQ9dbfXlHOVrQowsAVDe2+R1bvbdbICTa28s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoP8322YNb8lRFgU5J2Ffa25izqK1jAfZSXK1m6OYAnqDCyWdBGYqqD0ls1MWLjtTObwarUGMAqEDXkyy/gUvU75KEmjQY4JrlZ4b5LHHpdwiBQtpNwb2yFtGnTxwGpohG3H9LrHddsVCCosdYsmQ2qW0A5ii+d0IsU4Zw49eoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIRL00bp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F72C116C6;
	Tue,  6 Jan 2026 22:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767737692;
	bh=nbmr59PqQ9dbfXlHOVrQowsAVDe2+R1bvbdbICTa28s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YIRL00bpVfUjo9Lz2oKceSjk+gNbeVKsr34Pyens3FMUD7nqqZUgsvXTbP/7r/yKb
	 dcxcFxm/fNdvHXkLKj2cC/sKRuzJRAYmpLyc+yzJHJIv6FfrAeH3JdNwGw1XViP0kg
	 JccGySaDSEHklr2oNDbpWXfbLjNq993nEGvKAtxNxKLn4IwGC0dfE5gHkC3y2IwWDD
	 5M+FrLEdw4O12cyu52B0ML9ji+nrmg7PoLjBo1HM10ERh0ezJ1X5QZjxUjmsKF3mS8
	 JUiqCIZ4pO7oMPoK9yEy1JSqhynAFzEPQksdqE2JgbuWRXlxnc9Qt3j/LlKKHOgNQA
	 W6vx0bhjRp4gA==
Message-ID: <c3dd8234-3a7e-4277-89cf-1f4ccb2c0317@kernel.org>
Date: Tue, 6 Jan 2026 23:14:47 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: ctucanfd: fix SSP_SRC in cases when bit-rate is
 higher than 1 MBit.
To: Pavel Pisa <pisa@fel.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 David Laight <david.laight.linux@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andrea Daoud <andreadaoud6@gmail.com>,
 Wolfgang Grandegger <wg@grandegger.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Jiri Novak <jnovak@fel.cvut.cz>
References: <20260105111620.16580-1-pisa@fel.cvut.cz>
 <c5851986-837b-4ffb-9bf7-3131cf9c05d1@kernel.org>
 <202601060153.21682.pisa@fel.cvut.cz>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <202601060153.21682.pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/01/2026 at 01:53, Pavel Pisa wrote:
> Dear Vincent Mailhol,
> 
> thanks for pointing to Transmission Delay Compensation
> related code introduced in 5.16 kernel. I have noticed it
> in the past but not considered it yet and I think
> that we need minimal fixes to help users and
> allow change to propagate into stable series now.
> 
> More details inline
> 
> On Monday 05 of January 2026 21:27:11 Vincent Mailhol wrote:
>> Le 05/01/2026 à 12:16, Pavel Pisa a écrit :
>>> From: Ondrej Ille <ondrej.ille@gmail.com>
>>>
>>> The Secondary Sample Point Source field has been
>>> set to an incorrect value by some mistake in the
>>> past
>>>
>>>   0b01 - SSP_SRC_NO_SSP - SSP is not used.
>>>
>>> for data bitrates above 1 MBit/s. The correct/default
>>> value already used for lower bitrates is
>>
>> Where does this 1 MBit/s threshold come from? Is this an empirical value?
>>
>> The check is normally done on the data BRP. For example we had some
>> problems on the mcp251xfd, c.f. commit 5e1663810e11 ("can: mcp251xfd:
>> fix TDC setting for low data bit rates").
> 
> The CTU CAN FD check is done on data bitrate
> 
> https://elixir.bootlin.com/linux/v6.18.3/source/drivers/net/can/ctucanfd/ctucanfd_base.c#L290
> 
>   if (dbt->bitrate > 1000000)
> 
> the line expands to
> 
>   if (priv->can.fd.data_bittiming.bitrate > 1000000)
> 
> The value computation has been defined by Ondrej Ille, main author
> of the CTU CAN FD IP core. The main driver author has been
> Martin Jerabek and there seems that we have made some mistake,
> flip in value in the past. But Ondrej Ille is the most competent
> for the core limits and intended behavior and SW support.
> He has invested to complete iso-16845 compliance testing
> framework re-implementation for detailed timing testing.
> There is even simulated environment with clocks jitters
> and delays equivalent to linear, start and other typologies
> run at each core update. The kudos for idea how to implement
> this without unacceptable time required for simulation
> goes to Martin Jerabek. But lot of scenarios are tested
> and Ondrej Ille can specify what is right and has been
> tested. May it be, even Jiri Novak can provide some input
> as well, because he uses CTU CAN FD to deliver more generations
> of CTU tester systems to car makers (mainly SkodaAuto)
> and the need of configurable IP core for these purposes was initial
> driver for the CTU CAN FD core design.
> 
> The function of SSP is described in the datasheet and implementation
> in the CTU CAN FD IP CORE System Architecture manual or we can go
> to HDL design as well.
> 
> I extrapolate that 1 Mbit/s has been chosen as the switching point,
> because controller and transceivers are expected to support
> arbitration bit rate to at least 1 Mbit/s according to CAN and CAN FD
> standards and there is no chance to use SSP during nominal bitrate.
> 
>> Can you use the TDC framework?
> 
> In longer term it would be right direction. But TRV_DELAY
> measurement is and should be considered as default for
> data bit rate and BRS set and then the transceiver delay
> should be fully compensated on CTU CAN FD.
> 
> Problem was that the compensation was switched off by mistake
> in the encoded value.
> 
> But when I study manuals and implementation again, I think that
> there is problem with data bitrate < 1 Mbit/s, because for these
> the compensation should be switched off or the data rate sample_point
> should be recomputed to SSP_OFFET because else sampling is done
> too early. Delay is not added to sampling point. So we should
> correct this to make case with BRS and switching to
> higher data rate (but under 1 Mbit/s) to be more reliable.

Any issue that we witnessed in the past with low bitrates were only on
the drivers which had an hand coded TDC logic. Migrating those drivers
to the kernel TDC framework solved those issues without the need of an
additional check on the bitrate.

If you can show me a bus off condition in your device when using the
kernel TDC framework or if you can point me to publications from CAN in
Automation or similar which supports the idea of the 1 Mbit/s check,
then I can add that extra check to the framework. Otherwise, I would
like to drop this idea.

> There are some limitations in maximal values which can be
> set to SSP_OFFET field. It resolution is high, 10 ns typically
> for our IP CORE FPGA targets with the 100 MHz IP core clock.
> On silicon version, as I know, 80 MHz has been used in the
> last integration. So again, limit is around 2.5 usec or a little
> more for 80 MHz. This matches again mode switch at 1 Mbit/s
> or the other option could be switch when SSP_OFFET exceeds
> 250 or some such value.

Do you see any actual incompatibilities with the kernel TDC framework on
the offset maximum value?

>> Not only would you get a correct 
>> calculation for when to activate/deactivate TDC, you will also have the
>> netlink reporting (refer to the above commit for an example).
> 
> Yes, I agree that availability of tuning and monitoring over
> netlink is nice added value. But at this moment I (personally)
> prefer the minimal fix to help actual users.

We can also backport the fix if using the TDC framework. The ctucanfd
driver was introduced after the TDC framework so it will apply smoothly
to stable.

> I add there links to current CAN FD Transmission Delay Compensation
> support and definition in the Linux kernel code for future integration
> into CTU CAN FD IP core driver
> 
> https://elixir.bootlin.com/linux/v6.18.3/source/include/linux/can/bittiming.h#L25
> 
> https://elixir.bootlin.com/linux/v6.18.3/source/drivers/net/can/dev/calc_bittiming.c#L174
> 
> https://elixir.bootlin.com/linux/v6.18.3/source/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c#L595
> 
> and in the controller features announcement
> 
> priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
> 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
> 		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
> 		CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO |
> 		CAN_CTRLMODE_TDC_MANUAL;
> 
> Best wishes,
> 
> Pavel
> 
>>>   0b00 - SSP_SRC_MEAS_N_OFFSET - SSP position = TRV_DELAY
>>>          (Measured Transmitter delay) + SSP_OFFSET.
>>>
>>> The related configuration register structure is described
>>> in section 3.1.46 SSP_CFG of the CTU CAN FD
>>> IP CORE Datasheet.
>>>
>>> The analysis leading to the proper configuration
>>> is described in section 2.8.3 Secondary sampling point
>>> of the datasheet.
>>>
>>> The change has been tested on AMD/Xilinx Zynq
>>> with the next CTU CN FD IP core versions:
>>>
>>>  - 2.6 aka master in the "integration with Zynq-7000 system" test
>>>    6.12.43-rt12+ #1 SMP PREEMPT_RT kernel with CTU CAN FD git
>>>    driver (change already included in the driver repo)
>>>  - older 2.5 snapshot with mainline kernels with this patch
>>>    applied locally in the multiple CAN latency tester nightly runs
>>>    6.18.0-rc4-rt3-dut #1 SMP PREEMPT_RT
>>>    6.19.0-rc3-dut
>>>
>>> The logs, the datasheet and sources are available at
>>>
>>>  https://canbus.pages.fel.cvut.cz/


Yours sincerely,
Vincent Mailhol


