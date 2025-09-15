Return-Path: <linux-can+bounces-4699-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C0DB57707
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 12:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3218B7A6B24
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 10:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7482FDC58;
	Mon, 15 Sep 2025 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8GUuZND"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD82DA776;
	Mon, 15 Sep 2025 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933222; cv=none; b=dD1gYCyxOL7IB87HR4w6rlpLsbehOZxmsnfoCeuyjqnU/CSNHVW2a6BsTfZJIHOY+l23QS0iQrhMAI0ktRK7weAPeSCyW+NVJGZ/qeppUOC0oDFzuA6L+EasDJX/LKKmlkZQwDYOMhXO9rh4PEGpLpN1V0B+qE1Bl6FOFd50SrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933222; c=relaxed/simple;
	bh=avsto3QNk6qIWfGwz4s5xOHibcyjdg9CFwNBjQsN5dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNtOMwY3IkmfR+TmH+3GN7AdJ050/wfM/mjgLZNEHJcAIU8DOEvY8jpAlj3kZ1TFeCtsCpfYeMhPH3rsUhGEQ9L9xVTw1A4AxnXeVZDPydRsrMlWNXfRRYHmxB5afnoPaedDSw9RxMzqqBH3cWgtFlauYDk+kv9Gyf77smP1tkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8GUuZND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8DCC4CEF1;
	Mon, 15 Sep 2025 10:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757933222;
	bh=avsto3QNk6qIWfGwz4s5xOHibcyjdg9CFwNBjQsN5dQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V8GUuZNDRXJWH+csFpxRySlEaGxHPM1wv2EB4Q2EiTEtWYe6vRrtznX8TBjYg6+Kc
	 EYGZP31esjXS511n24JlKdPKKEh4PhVuyJVonhaA+OnjQDxMHO/hiAIoD3OocIRDS7
	 /DHxTpNwq0zDYrKd3mr9ByHnvtsrkNSiRYhRKEC+u/Ll7aIbbQXDRKw0R15nd0IE2j
	 YWon+KVteNNHpC+H9ElCVIs/ogx+ARDcmRk55ciThwnvEnZ3jscpl5N41PobwGS/UJ
	 VZHLFiMhoaqXlrcwycy0xMmjxbkeoR2ABmqryCrPnYqBig4meuPGwYi0wzkkzm2SeP
	 patWrdkfYenVQ==
Message-ID: <f0a34514-19da-4c73-9cd4-ae220fed6447@kernel.org>
Date: Mon, 15 Sep 2025 19:47:00 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] can: raw: use bitfields to store flags in struct
 raw_sock
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
 <20250915-can-raw-repack-v1-2-5ea293bc6d33@kernel.org>
 <f96cd163-0364-4c14-882b-48c3f8e0f05a@hartkopp.net>
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
In-Reply-To: <f96cd163-0364-4c14-882b-48c3f8e0f05a@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/09/2025 at 19:16, Oliver Hartkopp wrote:
> On 15.09.25 11:23, Vincent Mailhol wrote:
>> The loopback, recv_own_msgs, fd_frames and xl_frames fields of struct
>> raw_sock just need to store one bit of information.
>>
>> Declare all those members as a bitfields of type unsigned int and
>> width one bit.
>>
>> Add a temporary variable to raw_setsockopt() and raw_getsockopt() to
>> make the conversion between the stored bits and the socket interface.
>>
>> This reduces struct raw_sock by eight bytes.
>>
>> Statistics before:
>>
>>    $ pahole --class_name=raw_sock net/can/raw.o
>>    struct raw_sock {
>>        struct sock                sk __attribute__((__aligned__(8))); /*    
>> 0   776 */
>>
>>        /* XXX last struct has 1 bit hole */
>>
>>        /* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
>>        int                        bound;                /*   776     4 */
>>        int                        ifindex;              /*   780     4 */
>>        struct net_device *        dev;                  /*   784     8 */
>>        netdevice_tracker          dev_tracker;          /*   792     0 */
>>        struct list_head           notifier;             /*   792    16 */
>>        int                        loopback;             /*   808     4 */
>>        int                        recv_own_msgs;        /*   812     4 */
>>        int                        fd_frames;            /*   816     4 */
>>        int                        xl_frames;            /*   820     4 */
>>        struct can_raw_vcid_options raw_vcid_opts;       /*   824     4 */
>>        canid_t                    tx_vcid_shifted;      /*   828     4 */
>>        /* --- cacheline 13 boundary (832 bytes) --- */
>>        canid_t                    rx_vcid_shifted;      /*   832     4 */
>>        canid_t                    rx_vcid_mask_shifted; /*   836     4 */
>>        int                        join_filters;         /*   840     4 */
>>        int                        count;                /*   844     4 */
>>        struct can_filter          dfilter;              /*   848     8 */
>>        struct can_filter *        filter;               /*   856     8 */
>>        can_err_mask_t             err_mask;             /*   864     4 */
>>
>>        /* XXX 4 bytes hole, try to pack */
>>
>>        struct uniqframe *         uniq;                 /*   872     8 */
>>
>>        /* size: 880, cachelines: 14, members: 20 */
>>        /* sum members: 876, holes: 1, sum holes: 4 */
>>        /* member types with bit holes: 1, total: 1 */
>>        /* forced alignments: 1 */
>>        /* last cacheline: 48 bytes */
>>    } __attribute__((__aligned__(8)));
>>
>> ...and after:
>>
>>    $ pahole --class_name=raw_sock net/can/raw.o
>>    struct raw_sock {
>>        struct sock                sk __attribute__((__aligned__(8))); /*    
>> 0   776 */
>>
>>        /* XXX last struct has 1 bit hole */
>>
>>        /* --- cacheline 12 boundary (768 bytes) was 8 bytes ago --- */
>>        int                        bound;                /*   776     4 */
>>        int                        ifindex;              /*   780     4 */
>>        struct net_device *        dev;                  /*   784     8 */
>>        netdevice_tracker          dev_tracker;          /*   792     0 */
>>        struct list_head           notifier;             /*   792    16 */
>>        unsigned int               loopback:1;           /*   808: 0  4 */
>>        unsigned int               recv_own_msgs:1;      /*   808: 1  4 */
>>        unsigned int               fd_frames:1;          /*   808: 2  4 */
>>        unsigned int               xl_frames:1;          /*   808: 3  4 */
> 
> This means that the former data structures (int) are not copied but bits are set
> (shifted, ANDed, ORed, etc) right?
> 
> So what's the difference in the code the CPU has to process for this
> improvement? Is implementing this bitmap more efficient or similar to copy the
> (unsigned ints) as-is?

It will indeed have to add a couple assembly instructions. But this is peanuts.
In the best case, the out of order execution might very well optimize this so
that not even a CPU tick is wasted. In the worst case, it is a couple CPU ticks.

On the other hands, reducing the size by 16 bytes lowers the risk to have a
cache miss. And removing one cache miss outperforms by an order of magnitude the
penalty of adding a couple assembly instructions.

Well, I did not benchmark it, but this is a commonly accepted trade off.


Yours sincerely,
Vincent Mailhol


