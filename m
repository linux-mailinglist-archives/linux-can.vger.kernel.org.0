Return-Path: <linux-can+bounces-5979-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B28CED015
	for <lists+linux-can@lfdr.de>; Thu, 01 Jan 2026 13:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AAB13000B31
	for <lists+linux-can@lfdr.de>; Thu,  1 Jan 2026 12:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB8C19DF8D;
	Thu,  1 Jan 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wlh3JntF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4610745C0B
	for <linux-can@vger.kernel.org>; Thu,  1 Jan 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767270353; cv=none; b=RlMBZDPgd0w1jW6A0heAQQvXMMpR9Kv9mGnldxtFnSw8xfuafV/eItIBHNwnOC+EhOxKKGTlZzzoV7o0PT+SkKtK83G4wyOVwOhMbIiitX1ghxiqptJQI0W9q/uTDorXWPlxsiSJxnPCFj497xDJyfmc30m3WEWgS+DrP/h5Wh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767270353; c=relaxed/simple;
	bh=4wnQq/X6aSO35U3zVONslqooSHpT+ofmVO5VAZcIzKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsWHPktJhfUydbuwq686kyHqZqD6sZ1soxxyO4icnLhCUNAYQZMSXJTrfBAQoYM0rHDopOWyf7W4F1aRiCNzXf6trJxKDNZUFS2o0zMS7I9NoV5FVgZvSXDXCwdplGteK+zffxL0G5C0v+bWNYsJe4gBhb28pklzC6h+906NMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wlh3JntF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10E5C4CEF7;
	Thu,  1 Jan 2026 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767270352;
	bh=4wnQq/X6aSO35U3zVONslqooSHpT+ofmVO5VAZcIzKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wlh3JntFKAp4Ow+fF7RGyv27WBFHq80rIOuynF9U/DREdu1aDBWuyeQRIgfAt/tCv
	 F97txzJ71pm9bRrm640NMS+B7k++Ytti+IP73l8HnbH1Y82kApaBp5x027laXXid6p
	 +sJgsQc8HMkw3Bds7Gykn65el6VXz5jlLQf5MxzaxJscqUe75Sjs2a90DrJtlHLNoh
	 31EYZTO6wVUyO6mzHywkuyiYAmMMHO16PDNZAil1cEDEMYk1S1a8p7ljv0e9tyXKFU
	 JXNgrxrg57yYaICftE3YMLaX/g0sV5VpiYzJLjNAExiKtMZ4ovyEhjqpahQ4+VYV3P
	 zycPHp2XI8tKw==
Message-ID: <93df46ef-c1db-4df7-a90f-088dbacf12c6@kernel.org>
Date: Thu, 1 Jan 2026 13:25:49 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: propagate CAN device capabilities via ml_priv
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
References: <20251231165127.4206-1-socketcan@hartkopp.net>
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
In-Reply-To: <20251231165127.4206-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Oliver,

Happy new year to you and to all the members of the CAN mailing
list!(and also to Arnd who is listed in CC ;))

On 31/12/2025 at 17:51, Oliver Hartkopp wrote:
> Commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> caused a sequence of dependency and linker fixes starting with commit
> cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default").
> 
> The entire problem was caused by the requirement that a new network layer
> feature needed to know about the protocol capabilities of the CAN devices.
> Instead of accessing CAN device internal data structures which caused the
> dependency problems this patch introduces capabilty information into the
> CAN specific ml_priv data which is accessible from both sides.
> 
> With this change the CAN network layer can check the required features and
> the decoupling of the driver layer and network layer is restored.
> Therefore the Kconfig and Makefile changes/fixes are reverted too.
> 
> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> Fixes: cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/Kconfig       |  7 ++++--
>  drivers/net/can/Makefile      |  2 +-
>  drivers/net/can/dev/Makefile  |  5 ++--
>  drivers/net/can/dev/dev.c     | 19 +++++++++++++++
>  drivers/net/can/dev/netlink.c |  1 +
>  drivers/net/can/vcan.c        | 15 ++++++++++++
>  drivers/net/can/vxcan.c       | 15 ++++++++++++
>  include/linux/can/can-ml.h    | 24 +++++++++++++++++++
>  include/linux/can/dev.h       |  8 +------
>  net/can/raw.c                 | 45 ++++-------------------------------

This is a huge patch. I think it should be split in smaller pieces with
the reverts and the new code in different patches. What I would suggest
is to split it in 3 like this:

  Patch #1: revert 1a620a723853 ("can: raw: instantly reject unsupported
            CAN frames") and all the Kconfig subsequent fix attempts.

  Patch #2: Introduce the new logic.

  Patch #3: reintroduce 1a620a723853.


Reverting 1a620a723853 and reintroducing it later is kind of necessary
to have each patch of the series in a working state.


Yours sincerely,
Vincent Mailhol


