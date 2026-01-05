Return-Path: <linux-can+bounces-6000-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24329CF5856
	for <lists+linux-can@lfdr.de>; Mon, 05 Jan 2026 21:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C251300A902
	for <lists+linux-can@lfdr.de>; Mon,  5 Jan 2026 20:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597B1338590;
	Mon,  5 Jan 2026 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY5HXawX"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6FC3314DE;
	Mon,  5 Jan 2026 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767644837; cv=none; b=Dio0XIR0q/0/vFSvZ5Hh7PwcwaZ2G1+vehSQ6yC9nyNVLyS1QxDC/WBEvSVBH/i9Ve1+Mfl3Ba6qdpVGostbhLLjOgbWn5UyvsoJX0PlAkdgHYW+1OSvL/sTijADWrxUX7v9EXMziY3WekPPgjYQRii1J8VPNNoqPLvY0+dZHPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767644837; c=relaxed/simple;
	bh=YXz0nmm5+HrBCxqz9vmblcyiqkrmFZDacZ2BnXGn8FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifT+teO5uZ4nt7e/LRrR9AHGWJojh+N5LzcBQX8aTPm2xhNJfdVSP1+IeuW6Vz/S+6vWLxDrPD+17ExR5tPB0Lel2Tr6DyeHJBAriWW3Zv8cv/Y1EhahUmg7/GJwryHmMaB1TIV3x1u9Z6e7OJxloB6RUoCXBr/1ueyg9B5DXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY5HXawX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A651C116D0;
	Mon,  5 Jan 2026 20:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767644836;
	bh=YXz0nmm5+HrBCxqz9vmblcyiqkrmFZDacZ2BnXGn8FA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mY5HXawX4szDKq+1Z146LiVr0FgX8aQk9zFrsenGVppMfnkxGKXnW9BW7eSPSyT6h
	 OAxsf0Fqvcsc+0NhPVueO1si7c2+KyS/8mu/MBQsQf5KP87I3eIBDv/PYP0eNAdZpW
	 uEgLWP4udbrrwveryl6q0ZPcv8KzZ/S9fk6neW86UoOI/n2Qyt7nQDdcrFAeU/p6pF
	 vF1t/0KcjXksZ1XqSskfaPJ570B62u966KhrcMn1Pd6G6Fx10I6wIJK20dOSEnZxkX
	 vDg97TTaZDr7nBu6AaXLSINPEYKlKu5/U3wlS9Ge4H25Jrw9dvrR81fkJpO5xzqU9H
	 +N2t2vSxE14ew==
Message-ID: <c5851986-837b-4ffb-9bf7-3131cf9c05d1@kernel.org>
Date: Mon, 5 Jan 2026 21:27:11 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: ctucanfd: fix SSP_SRC in cases when bit-rate is
 higher than 1 MBit.
To: Pavel Pisa <pisa@fel.cvut.cz>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 David Laight <david.laight.linux@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andrea Daoud <andreadaoud6@gmail.com>,
 Wolfgang Grandegger <wg@grandegger.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Cc: Jiri Novak <jnovak@fel.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>
References: <20260105111620.16580-1-pisa@fel.cvut.cz>
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
In-Reply-To: <20260105111620.16580-1-pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 05/01/2026 à 12:16, Pavel Pisa a écrit :
> From: Ondrej Ille <ondrej.ille@gmail.com>
> 
> The Secondary Sample Point Source field has been
> set to an incorrect value by some mistake in the
> past
> 
>   0b01 - SSP_SRC_NO_SSP - SSP is not used.
> 
> for data bitrates above 1 MBit/s. The correct/default
> value already used for lower bitrates is

Where does this 1 MBit/s threshold come from? Is this an empirical value?

The check is normally done on the data BRP. For example we had some
problems on the mcp251xfd, c.f. commit 5e1663810e11 ("can: mcp251xfd:
fix TDC setting for low data bit rates").

Can you use the TDC framework? Not only would you get a correct
calculation for when to activate/deactivate TDC, you will also have the
netlink reporting (refer to the above commit for an example).

>   0b00 - SSP_SRC_MEAS_N_OFFSET - SSP position = TRV_DELAY
>          (Measured Transmitter delay) + SSP_OFFSET.
> 
> The related configuration register structure is described
> in section 3.1.46 SSP_CFG of the CTU CAN FD
> IP CORE Datasheet.
> 
> The analysis leading to the proper configuration
> is described in section 2.8.3 Secondary sampling point
> of the datasheet.
> 
> The change has been tested on AMD/Xilinx Zynq
> with the next CTU CN FD IP core versions:
> 
>  - 2.6 aka master in the "integration with Zynq-7000 system" test
>    6.12.43-rt12+ #1 SMP PREEMPT_RT kernel with CTU CAN FD git
>    driver (change already included in the driver repo)
>  - older 2.5 snapshot with mainline kernels with this patch
>    applied locally in the multiple CAN latency tester nightly runs
>    6.18.0-rc4-rt3-dut #1 SMP PREEMPT_RT
>    6.19.0-rc3-dut
> 
> The logs, the datasheet and sources are available at
> 
>  https://canbus.pages.fel.cvut.cz/
> 
> Signed-off-by: Ondrej Ille <ondrej.ille@gmail.com>
> Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>


Yours sincerely,
Vincent Mailhol


