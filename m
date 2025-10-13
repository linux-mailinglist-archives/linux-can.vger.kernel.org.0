Return-Path: <linux-can+bounces-5167-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B73B2BD2D40
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 13:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63A5434B05A
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7F264A7F;
	Mon, 13 Oct 2025 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sww275n2"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5326463B;
	Mon, 13 Oct 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355902; cv=none; b=RYdTdtXxpfAvzttt4mgVA81Sh2WBBomaRko8+uZmsBeS6g1vtOjVz0ZW+axe9H2vltn0EUCZowFI5chD4r7BXZgBsyHXnWc95QoMWdP5ChOEP51Hly7NCLogAigMyvvAmcVIBoAIaYY4db9n/eN3z+VHNpiVNcba7hmn+EMJaF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355902; c=relaxed/simple;
	bh=zuhK6RhM0NvTiKfZF7CmXJBASTipPPGDGdDjCXE2Gow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqdPcKEyKUf1YRpoylpLrPmQJI/fU9c3hBH1huaZVF/K3reTMOpEf9y1SYEShHNceuiKvrilZTt8YBl+SlHBexeiuK8EkFutofThq/Xp3hGyscXf6n8P4CM7jzds4UHKaYnd9tzXJCB+rAczalytdN6Ygvw21xYsbZz3MVsL6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sww275n2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEC9C4CEE7;
	Mon, 13 Oct 2025 11:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760355902;
	bh=zuhK6RhM0NvTiKfZF7CmXJBASTipPPGDGdDjCXE2Gow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sww275n21mv+GCkMclyU+wzSUkg8/hW4s6qi2bjA/MlJt+snPvrjvfYcN40tXtQUO
	 7Ajrdn+BaxJZdEEQbkLio9LqFsNwMRCmpsUpxqWH4P87nH79Rruy7csI+Ka2oALbkd
	 0iZcd8jW26WaYOeIac0B+B6yTdlVGpTd6G8hK7wAP9wH3A+g7c9E1q+Ue3uq9C36PI
	 orYNNFQd6ZdGRdGBiOvC4ffCywBHR4Te+32XxckTD8ZZeCMRLUy539E5Xq0NWUWRnO
	 yarnbW4aIVzT2UMXfl/KcuhTBdLLnikM/taqSJIQ+d80H/tErCuCGwIdt1f/7KFeFS
	 3E4cXzl5INREw==
Message-ID: <0a56ad59-d83c-4697-a1ee-db25585050e3@kernel.org>
Date: Mon, 13 Oct 2025 20:44:59 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] can: netlink: add CAN XL
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
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
In-Reply-To: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/2025 at 20:01, Vincent Mailhol wrote:
> Following all the refactoring on the CAN netlink done in series [1],
> [2] and [3], this is now time to finally introduce the CAN XL netlink
> interface.

I am sending this extra message to give a few additional hints on how
to test.

In addition to the mailing list, I also push this series and the
dummy_can driver to:

  https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/log/?h=b4/canxl-netlink

I also have a work in progress for iproute2 here:

  https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/iproute2-next.git/log/?h=canxl-netlink

I will submit the iproute2 series later on, after receiving comments
on this series. For the moment, the iproute2 canxl is only available
through the link above.

To test, after cloning and compiling above branches, do:

  modprobe dummy-can

to load the driver. Then configure it, for example, this is a 500 KB/s
nominal bittiming and a 10 MB/s XL databittiming with TMS on:

  ./ip/ip link set can0 up type can bitrate 500000 xl on xbitrate 10000000 tms on

If you have debug log enabled (e.g. with CONFIG_CAN_DEBUG_DEVICES),
this is what you should see in the kernel log:

  can0: Clock frequency: 160000000
  can0: Maximum bitrate: 20000000
  can0: MTU: 2060
  can0: 
  can0: Control modes:
  can0: 	supported: 0x0001ba22
  can0: 	enabled: 0x00009000
  can0: 	list:
  can0: 		listen-only: off
  can0: 		fd: off
  can0: 		fd-tdc-auto: off
  can0: 		restricted-operation: off
  can0: 		xl: on
  can0: 		xl-tdc-auto: off
  can0: 		xl-tms: on
  can0: 		xl-error-signalling: off
  can0: 
  can0: Classical CAN nominal bittiming:
  can0: 	bitrate: 500000
  can0: 	sample_point: 875
  can0: 	tq: 12
  can0: 	prop_seg: 69
  can0: 	phase_seg1: 70
  can0: 	phase_seg2: 20
  can0: 	sjw: 10
  can0: 	brp: 2
  can0: 
  can0: 
  can0: CAN XL databittiming:
  can0: 	bitrate: 10000000
  can0: 	sample_point: 750
  can0: 	tq: 6
  can0: 	prop_seg: 5
  can0: 	phase_seg1: 6
  can0: 	phase_seg2: 4
  can0: 	sjw: 2
  can0: 	brp: 1
  can0: 	CAN XL PWM:
  can0: 		pwms: 4
  can0: 		pwml: 12
  can0: 		pwmo: 0
  can0: 
  can0: dummy-can is up

Finally, you can use a recent version of can-utils to generate some
traffic. The driver will echo back anything it receives.

I will continue to update the above branches according to the comments
received. See these as work in progress. Use the series as posted on
the mailing if you want something more stable.


Yours sincerely,
Vincent Mailhol

