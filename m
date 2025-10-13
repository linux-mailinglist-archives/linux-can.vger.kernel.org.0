Return-Path: <linux-can+bounces-5153-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39945BD27C4
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 12:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 849634E19C7
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4282FE599;
	Mon, 13 Oct 2025 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbUHPfOg"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7D2FE594;
	Mon, 13 Oct 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350331; cv=none; b=eGwAjg6c1u4cc7Wx3/vY5hqPjSyjHTXJREO/QMxGZ+6/KZBguQAkJTaNbYIeUy6smZjQnRvwjB73u3C4l9X2jlPkodMGiAZDck8Z89qiSOlbebyDYHBiDR4HSoU7tmp1MsSUS7YtDB92xNrRxaOOM7TS3imHsEl+jnB1gV9uYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350331; c=relaxed/simple;
	bh=D685IFTElATHf+I2pgbQcF/yZIN1IETUvG4g5c+YtJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gyj4EK3QadZ9DF3DidX3qwS8G7arP8pzTk8GXP/VxuY6HVEmhN1UUbxQ5fII71wM+lW4wczyQdpdvVS1XRNkUPZFgdGXRbb/OKU34ysdXZU63E0YqKU7Wl/IORcSFdODeHltPbZInhxdNPb8Svb3+FpVuIvMvni3oqlGdaKJEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbUHPfOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A2BC4CEFE;
	Mon, 13 Oct 2025 10:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760350329;
	bh=D685IFTElATHf+I2pgbQcF/yZIN1IETUvG4g5c+YtJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JbUHPfOgDslajzzcY8/CZ1qXoIzIr7a1cQo+iC3FSXT2uNMgYIDhJR28R88RoS/If
	 CUkLPXmA5ls0RvaLzI1pz3vmKckVFbfHnALIqkRDXOCOGo/pAqJa0Tl2ONpb7cmvcB
	 J28M4IA4Y5eUQVThgm7nlg/EHQKlSFPYXjRd49mu+z/lIjbqMmoM7Mnj2GRDHJYLZ8
	 jNYQSsAiRFDU2qCWUzP3MRYVSh3ukrQW0XJu1FbkkkVFRt1wgFU20wWbKTT0rczlZN
	 ySN/pUVgHtSy0pgYiZZYPMCynS8HiXj8X6eFaxA01mi/hwyDhw+o8QDFbYWqxM+JJh
	 wTCbNVESxu9tA==
Message-ID: <60348755-be5e-4e64-82e7-98178ca73623@kernel.org>
Date: Mon, 13 Oct 2025 19:12:06 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 9/9] can: add Transmitter Delay Compensation (TDC)
 documentation
To: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
 netdev@vger.kernel.org
References: <20251012142836.285370-1-mkl@pengutronix.de>
 <20251012142836.285370-10-mkl@pengutronix.de>
 <1157f3fe-f88b-449f-a4c2-aac9d27c95ea@redhat.com>
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
In-Reply-To: <1157f3fe-f88b-449f-a4c2-aac9d27c95ea@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo and Simon,

Sorry for the build error.

(for the record, Simon separately reported the same issue here:
 https://lore.kernel.org/linux-can/aOzJZ1NsKxNMvIzJ@horms.kernel.org/)

On 13/10/2025 at 16:45, Paolo Abeni wrote:
> Ni,
> 
> On 10/12/25 4:20 PM, Marc Kleine-Budde wrote:
>> From: Vincent Mailhol <mailhol@kernel.org>
>>
>> Back in 2021, support for CAN TDC was added to the kernel in series [1]
>> and in iproute2 in series [2]. However, the documentation was never
>> updated.
>>
>> Add a new sub-section under CAN-FD driver support to document how to
>> configure the TDC using the "ip tool".
>>
>> [1] add the netlink interface for CAN-FD Transmitter Delay Compensation (TDC)
>> Link: https://lore.kernel.org/all/20210918095637.20108-1-mailhol.vincent@wanadoo.fr/
>>
>> [2] iplink_can: cleaning, fixes and adding TDC support
>> Link: https://lore.kernel.org/all/20211103164428.692722-1-mailhol.vincent@wanadoo.fr/
>>
>> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
>> Link: https://patch.msgid.link/20251012-can-fd-doc-v1-2-86cc7d130026@kernel.org
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  Documentation/networking/can.rst | 60 ++++++++++++++++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>
>> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
>> index ccd321d29a8a..402fefae0c2f 100644
>> --- a/Documentation/networking/can.rst
>> +++ b/Documentation/networking/can.rst
>> @@ -1464,6 +1464,66 @@ Example when 'fd-non-iso on' is added on this switchable CAN FD adapter::
>>     can <FD,FD-NON-ISO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>>  
>>  
>> +Transmitter Delay Compensation
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +At high bit rates, the propagation delay from the TX pin to the RX pin of
>> +the transceiver might become greater than the actual bit time causing
>> +measurement errors: the RX pin would still be measuring the previous bit.
>> +
>> +The Transmitter Delay Compensation (thereafter, TDC) resolves this problem
>> +by introducing a Secondary Sample Point (SSP) equal to the distance, in
>> +minimum time quantum, from the start of the bit time on the TX pin to the
>> +actual measurement on the RX pin. The SSP is calculated as the sum of two
>> +configurable values: the TDC Value (TDCV) and the TDC offset (TDCO).
>> +
>> +TDC, if supported by the device, can be configured together with CAN-FD
>> +using the ip tool's "tdc-mode" argument as follow::
                                                      ^
This is the culprit. There should have been as single colon here...

>> +
>> +- **omitted**: when no "tdc-mode" option is provided, the kernel will
>> +  automatically decide whether TDC should be turned on, in which case it
> 
> The above apparently makes htmldoc unhappy:
> 
> New errors added
> --- /tmp/tmp.ZsYbmUst3Y	2025-10-12 14:23:45.746737362 -0700
> +++ /tmp/tmp.8o1xOCQtDp	2025-10-12 14:58:29.920405220 -0700
> @@ -15,0 +16 @@
> +/home/doc-build/testing/Documentation/networking/can.rst:1484: ERROR:
> Unexpected indentation.
> 
> Could you please address the above and send a v2?

Here it is:

  https://lore.kernel.org/r/20251013-can-fd-doc-v2-0-5d53bdc8f2ad@kernel.org


Yours sincerely,
Vincent Mailhol


