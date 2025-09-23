Return-Path: <linux-can+bounces-4827-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9F6B93F4E
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 04:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CD3448712
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 02:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6EB2D0606;
	Tue, 23 Sep 2025 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBhH6kjC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D66E2C3768;
	Tue, 23 Sep 2025 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758593265; cv=none; b=vBCOGs8usUEDnhcFvJBOHqupZX7ohVyNu0/0IbJZznknQV/id288czYa7iq9TkW9CG51wuMTStz7iBrhCNeeEaXBFYwoEwBjG+6+8KiaPLustz9REk+Td13ZAd4o4lQ4Xbv3lOnjSBjuZ1HcG4nzehdV52Tuy7hrTCTN9B6H5CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758593265; c=relaxed/simple;
	bh=iL+AF0GksdOP1DP3GUyIPV2gmGmSVCBoBNx1d5RI61k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRCa8OHb4e1D1xy23yDlskJAkBO4jcfGkY6bYE8x2+peFlrB0SET8nbZHoEfrgwj1vLbseDaQgzAJ8SiZnyOi+jUCE5XaV6290bX3bfvUWo+8GndJBpWE35YAGO3vbIXvynwp48XnDpM5wbkqQvQTaQTPmZpfB6zAwa7Pdxo84Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBhH6kjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4F2C113D0;
	Tue, 23 Sep 2025 02:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758593264;
	bh=iL+AF0GksdOP1DP3GUyIPV2gmGmSVCBoBNx1d5RI61k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LBhH6kjCk1GPLhR00gca2hjzJsNE7StDYSl4b4xY60i2H3uCgZ3HFLo2PGT3GR3E9
	 GzscgJ5Z59134MWJ+iFy8mFwkOSovWkZTG/MJ9dWHZAZDTzzpsfFNi+Z+wRtKnhskx
	 2q7VNt1xER7FCkx8anEACthb8kIz6xRXUys56m2u9QEjtmy04536BhYlw3A80UyRvm
	 JtqDoXyGaq3zfXWe7J8ehfph9/v5792HZzSlaDE4TxX0Wl2rqYt7NytE46V2qUCeDQ
	 YnBHXMRkNUQ/MFmwuhV/8dpvBY7HHNUx4u5RRD4kipD9JhL7rTYicfEkzSBKOWOi/O
	 H2OhiMek3s4nA==
Message-ID: <5fa23787-70a8-47b0-b127-4c6ede546f69@kernel.org>
Date: Tue, 23 Sep 2025 11:07:42 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 1/3] iplink_can: fix coding style for
 pointer format
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
 <20250921-iplink_can-checkpatch-fixes-v1-1-1ddab98560cd@kernel.org>
 <20250922151008.25c7a19b@hermes.local>
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
In-Reply-To: <20250922151008.25c7a19b@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/2025 at 07:10, Stephen Hemminger wrote:
> On Sun, 21 Sep 2025 16:32:30 +0900
> Vincent Mailhol <mailhol@kernel.org> wrote:
> 
>> checkpatch.pl complains about the pointer symbol * being attached to the
>> type instead of being attached to the variable:
>>
>>   ERROR: "foo* bar" should be "foo *bar"
>>   #85: FILE: ip/iplink_can.c:85:
>>   +		       const char* name)
>>
>>   ERROR: "foo* bar" should be "foo *bar"
>>   #93: FILE: ip/iplink_can.c:93:
>>   +static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
>>
>> Fix those two warnings.
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>> ---
> 
> This is ok, to fix. 

With the other two patches being Nack-ed, we are only left with this one in the
series.

Do you want me to resend or do you prefer to directly cherry pick this one?


Yours sincerely,
Vincent Mailhol


