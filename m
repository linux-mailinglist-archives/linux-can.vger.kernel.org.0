Return-Path: <linux-can+bounces-4477-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C64B3B436D8
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 11:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CD064E54DA
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFBA2EF64E;
	Thu,  4 Sep 2025 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvsExAI0"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCEB2EE619;
	Thu,  4 Sep 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977504; cv=none; b=gabaEzitV0vWvLCOuReawiFVtIPbk83pUg/yFYiEWUNx2u9fnF6expBdZ3Xp9+108jWA6OlmgA3yxTUWk6jB2INhjQFR8Nr14X4BeYS4maMUW+iKu6breh2vQweIf6WR/qTjubAqNduFQcfTJaKOJ271bnE8C05EUZWe3dhdnlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977504; c=relaxed/simple;
	bh=oiH56HFyh3YApM55UWszrvr1kP+5rJLu6fEiL1b1Xc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1NTdCbeOuFRl0VX9BfJ4OxUA2/L4d9Tp02Ra6XefHR/osGtVCsHH/PbRChofDCH5w1vmyIwUuPHoo26KmNyaTd1DSZIy+wcJ8NgGz82Sb0tq/TL4SCR/49TY4JySNIbUknQFqzbqWxchwkQDKBEmjYQzgcsbJKCaa1082u4b+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvsExAI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734E6C4CEF0;
	Thu,  4 Sep 2025 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756977503;
	bh=oiH56HFyh3YApM55UWszrvr1kP+5rJLu6fEiL1b1Xc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qvsExAI0HKXYBVVwlDK3kP2k+9J+afY9CO4t/g+HauMZSBTj3vNAyoqjlvkHrv5qe
	 4LfLQZoXcrSnBf8b9zVwywRtSKqrXN9M4sPQwS7pDCQJP/qiDyeEwsMMIiib9Vmit5
	 F7CQe/iDP9ajw3JHrrFLF2Ju9b1e/IfssyIc10uj4XraLne+AnLziUdsKVpLBlo4g4
	 fUZ5ylPp8wrDz8gkgBAd7PlcX+T5/9WYg+PZHfBnwkvsFidL0U5zMMwN/ah/Qae29R
	 IWQnhpPYUSaNgYDbNeRDMXIz2zJkx0eoie8pFvZQJ584kqu/b0SfVhkQo66coJuQJF
	 YKioc93lT3eXQ==
Message-ID: <88d2836b-2702-481f-b504-20c6efa5cb1a@kernel.org>
Date: Thu, 4 Sep 2025 18:18:21 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] can: netlink: preparation before introduction of
 CAN XL step 2/2
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Vincent Mailhol <mailhol@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
 <6e4dcab9-d3d7-4c8b-99c1-f472bb7caa07@kernel.org>
 <e37c9890-823f-4a38-bdcc-c170dbe67e13@hartkopp.net>
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
In-Reply-To: <e37c9890-823f-4a38-bdcc-c170dbe67e13@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/09/2025 at 15:36, Oliver Hartkopp wrote:
> On 03.09.25 11:26, Vincent Mailhol wrote:
>> On 03/09/2025 à 17:49, Vincent Mailhol wrote:
>>
>> (...)
>>
>>> The follow up series which introduces CAN XL is nearly completed but
>>> will be sent only once this one is approved: one thing at a time, I do
>>> not want to overwhelm people (including myself).
>>
>> If you want a preview of the full CAN XL, you can have a look at my work in
>> progress here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/
>> log/?h=b4/canxl-netlink
>> https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/iproute2-next.git/
>> log/?h=canxl-netlink
>>
>> The kernel part is nearly completed, but I am still playing some whack-a-mole to
>> find potential gaps in the configuration validation. I also need to rewrite or
>> fine tune the commit description.
>>
>> The iproute2 part is still under development. It has the PWM interface but I
>> have not added all the control modes yet.
>>
> 
> Thanks Vincent!
> 
> The repos are very helpful.
> 
> With "missing" control modes you refer to CAN_CTRLMODE_XL_ERR_SIGNAL,
> CAN_CTRLMODE_XL_RRS and CAN_CTRLMODE_RESTRICTED, right?

Yes, I only added the CAN_CTRLMODE_XL_TMS so far in iproute2. The kernel has all
of the four flags (but because I did not finish testing, I highly suspect that
there are still some bugs somewhere).

Concerning the CAN_CTRLMODE_XL_RRS, I am not sure if that one is needed. I still
have it in my WIP series but I am recently considering to remove it. The reason
is that when reading ISO 11898-1 having RRS configurable looks mandatory to me.

In the logical Link control (LLC) this RRS bit is named FTYP (for Frame Type).
For example, CiA only mentions FTYP in their CAN XL knowledge page:

  https://www.can-cia.org/can-knowledge/can-xl

Contrarily to CAN FD's RRS which is indeed specified as being dominant and which
is just ignored in the LLC, the CAN XL FTYP/RRS is part of the LLC interface and
is meant to be configurable.

Nothing in the standard tells us that this should be a dominant bit. I think
your intention was to add CAN_CTRLMODE_XL_RRS as a quirk for the devices which
expose this flag. But as far as I can see, it seems that a device which does not
expose it is just not compliant.

If some day a device which can not set the FTYP/RRS flag appears in the wild,
then maybe we can add a flag which would specify that RRS is not configurable
(opposite logic as what you suggested). But as long as such a device do not
exist, it is better to add nothing.


Yours sincerely,
Vincent Mailhol


