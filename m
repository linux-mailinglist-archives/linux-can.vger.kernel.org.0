Return-Path: <linux-can+bounces-5226-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1BABEA90C
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 18:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A969458A7
	for <lists+linux-can@lfdr.de>; Fri, 17 Oct 2025 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB69335068;
	Fri, 17 Oct 2025 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE9ky3Jo"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF2332905;
	Fri, 17 Oct 2025 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715625; cv=none; b=B8WI3UgXudfo7rEUngvKmvsvFv52QpNzOHCkgd9cEjsKfxlAK3zpE9hK6NqoQkqGjzFeE77rE/LM9JHen6pZz08w74HnzOAKPeW/Uw66FUVxKVikw4FuBb1bRgPY6xlZCMUBUFmJmQK4+bRAAb4DET39SqZtvXzbz0d4/tJbVAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715625; c=relaxed/simple;
	bh=tIBihhto3yHLjwCtkr7qZV1vif9bLZjjrf1fWoABO2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4ZcBsueCSOvkjbIlJX29LHEGsG5F1OEFT+KOPJPBRbEEvfCL4LBc/1C1RkCJ6ObMmOOC3mGe9UqhbsNzcBNQBAwrFtW3oQmsdDcsngvKr7gu3ZL0mIC4iwM/zAZb8OlHfphaMJLClu4vKPJpuWPror7htTekc8aI7qlIzsA5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE9ky3Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3103C4CEFE;
	Fri, 17 Oct 2025 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760715624;
	bh=tIBihhto3yHLjwCtkr7qZV1vif9bLZjjrf1fWoABO2o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NE9ky3Jo9NBq8B11m0/dr+zVBACQCkA0BR45t8ECLH0jrEoDwgmksvpGjSZWuzTgI
	 nK5762ee42gfrrGGBl93EmOiwzW4AI7z5d6C+iEosL6Get7J3dJhIFJODA6VHtRNWJ
	 Va498OpPMOMxoSG3Cycb1mlQXKaW6gxBrmA1KaEGCRh3vz0+tj44dOnbLe9q2V1eQx
	 UKIqsnsxIkVd+Rw2C+R/kjVIdOrSufCBks8eFEURaoky2vJGxghl1ohuQ1ffuxXMpy
	 79V4lgMduBgq1TOvGlLWeLUfN6Ahlwo/OmRpaT4hexC6hMjj0I/IRX1L9kg4ZTkBlE
	 VNyGaLI4iLbiw==
Message-ID: <a729eeda-22d8-4f3e-bb6b-0cd2f3a06d2a@kernel.org>
Date: Sat, 18 Oct 2025 00:40:22 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] can: netlink: add CAN XL
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
 <20251017-spectacular-xanthic-swan-9427e8-mkl@pengutronix.de>
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
In-Reply-To: <20251017-spectacular-xanthic-swan-9427e8-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2025 at 22:53, Marc Kleine-Budde wrote:
> On 13.10.2025 20:01:22, Vincent Mailhol wrote:
>> Following all the refactoring on the CAN netlink done in series [1],
>> [2] and [3], this is now time to finally introduce the CAN XL netlink
>> interface.
>>
>> Similarly to how CAN FD reuses the bittiming logic of Classical CAN,
>> CAN XL also reuses the entirety of CAN FD features, and, on top of
>> that, adds new features which are specific to CAN XL.
>>
>> Patch #1 adds a check in can_dev_dropped_skb() to drop CAN FD frames
>> when CAN FD is turned off.
>>
>> Patch #2 adds CAN_CTRLMODE_RESTRICTED. Note that contrary to the other
>> CAN_CTRL_MODE_XL_* that are introduced in the later patches, this
>> control mode is not specific to CAN XL. The nuance is that because
>> this restricted mode was only added in ISO 11898-1:2024, it is made
>> mandatory for CAN XL devices but optional for other protocols. This is
>> why this patch is added as a preparation before introducing the core
>> CAN XL logic.
> 
> What about merging patches 1+2 now?

If patch 1 had to be squashed, it should probably be in patch 3
"can: netlink: add initial CAN XL support". The MTU workaround as
introduced in patch 1 does not share any of the logic of the
CAN_CTRLMODE_RESTRICTED as introduced in patch 2. Patch 1 is really
just a preparation for CAN XL. You could remove patch 2 from the
series and it will still work (aside from missing one of ISO mandatory
features). Remove patch 1, and the thing breaks apart because it is
required by patch 3.

If I were to squash 1 and 2, I am not sure how I would describe those
two different changes in a single patch message.


Yours sincerely,
Vincent Mailhol


