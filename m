Return-Path: <linux-can+bounces-4621-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FECBB50E65
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C72F563348
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AAB303C8A;
	Wed, 10 Sep 2025 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grmD5Ryy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188CE3064AB;
	Wed, 10 Sep 2025 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486584; cv=none; b=K030HNxGSFAIBiP+HcnKy2qCJ6OdvFVn6klvIIVu+9tZ2TVLA9uvNWNl594qziJ+3ab7XgDcBP9WFVwQ7HZptcYvNoE2wrLsHW9tJDRM2oopFw4w9AID6BPt/OzsVSjz77XrIV1gCBMBp7qUM8WPhSGJqoMgtaSOCFjtw95FPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486584; c=relaxed/simple;
	bh=TrzdffNFbFHjCc7us2UtS8xJB2U43lIWnmmO0qVYK4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiOGGU0m600kllomi2PY2INYHaFH4bsOY64rpjUpWRciNJPI4VguN3vniqRlTvdsDAqtpYlR+sNgU3vWKpcS2bNhOlVO4tAMt/d2W2h38CCZ9HtBgKveCnJYj4Kzjs+ntra55OG8+N/yX9p5OgWefyaTTghmVbmTUoJbQ3x5xB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grmD5Ryy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80124C4CEF0;
	Wed, 10 Sep 2025 06:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757486582;
	bh=TrzdffNFbFHjCc7us2UtS8xJB2U43lIWnmmO0qVYK4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=grmD5Ryysghnc3fkZcBbJke8sLgG2Vx5AKUlLHugs5tOCCMh3qB6sNp+YgzW9nRlx
	 hAsamxqm3fDhIz6VpHfV7wmPx2uMQN4MH6ApoNHD27MzUsDmRr/ZLhoqrC2liTdf+F
	 3j2gpHCiz93DBAwnc88VdKPxPE50WBt16WBcCiYWxrNZY/Cx1LqcO5g9ylrjkDp3uV
	 p1zw4tM+grCywI7YHTrrUfAyxkwOid81vSQFOt4aZxoHLze6fh8yVH5lz9gx+nlkZX
	 /9M17/Meo4++tsqrsVnHvfWfVrG4mHEAod+rTYBspiXYODK/6cRprqvCeyoE+U7Lds
	 Sozrh19iSsePQ==
Message-ID: <1c7024ba-60fc-472d-982a-ab45b4f23748@kernel.org>
Date: Wed, 10 Sep 2025 15:43:00 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/20] can: netlink: refactor can_validate_bittiming()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
 <20250910-canxl-netlink-prep-v2-4-f128d4083721@kernel.org>
 <20250910-outrageous-liberal-falcon-9215d3-mkl@pengutronix.de>
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
In-Reply-To: <20250910-outrageous-liberal-falcon-9215d3-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/09/2025 at 15:13, Marc Kleine-Budde wrote:
> On 10.09.2025 15:03:29, Vincent Mailhol wrote:
>> Whenever can_validate_bittiming() is called, it is always preceded by
>> some boilerplate code which was copy pasted all over the place. Move
>> that repeated code directly inside can_validate_bittiming().
>>
>> Finally, the mempcy() is not needed. Just use the pointer returned by
>> nla_data() as-is.
> 
> The memcpy()'ed struct is guaranteed to be properly aligned, is this
> also the case for the casted nla_data() pointer?

The NLA attributes are aligned on 4 bytes, c.f. NLA_ALIGNTO:

https://elixir.bootlin.com/linux/v6.16.5/source/include/uapi/linux/netlink.h#L248

Which is sufficient for struct can_bittiming which also requires just 4 bytes of
alignment as proven by the fact the the code would still compile if I add this
static assert:

  static_assert(_Alignof(typeof(*bt)) <= NLA_ALIGNTO);

But I have to admit that you caught me off guard. I did not think of that. Maybe
I should add above static assertions to the code to document that what we are
doing is correct?


Yours sincerely,
Vincent Mailhol


