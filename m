Return-Path: <linux-can+bounces-5460-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDDDC63117
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 10:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4B004EFB17
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B7C27E060;
	Mon, 17 Nov 2025 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Nl4LGwOk";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="f8TURlGu"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C931B82B
	for <linux-can@vger.kernel.org>; Mon, 17 Nov 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370417; cv=pass; b=aCyeGQ6Q+r0GhWYWf0jJcG9/n1yvQmPqO+Ba1PTfPkqOp48LYgSWkFVszFH6A6ZIzh+PQeKIxfUH75J2IHtvYNS2n1SU3RXOQlCU+4B0kWXBMUoCPYRuHBhfb9+HZC1but/YQXLEatxD0/e7m+3ERifCVFDUO1QIFXMgXVnU5A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370417; c=relaxed/simple;
	bh=utZOTE2KCkT0rrjNZLN0Z0YIffADtfAizcSBXMocGqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbHGE7/as2WqWsmdlbLwOYrlxsBrkFve+i5ibYpeoa94JvMEElJdOCfDkjTckaZssmsjagGU5y2RFTRFmWEbB8pwrCrtdVfgbtCCFnjQoH4TXmtTZvXgbvmZ0sP04XHWQ7PlBAbaclbZwjjbs8ckBZGw7VYWkqPpfEtqOjbueeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Nl4LGwOk; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=f8TURlGu; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763370413; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BHzRzQnDFyc3cuQHq9sahK5yrvlxiwiIxhKYw/26uLnNawghWwQ73o91jxgvkPW/Sc
    jnjCKFf8unHjQPBcMicqcp8yLdIzjRcbhY4h4TtgMt9DuKxac9YOc6q1pbe4mqAdCFDX
    ZW+rMgQbB+PBjHK9YlS1P1Zjo4+pFetrhFUf+KkoNeITyHQ5QCw0Q9PlKw68UCcqQcOI
    bp+a6YKdfp8jK9qsDbK7dfKsvg8fNIguZywYtnTbDyp/H61Grf9hyuBLVkDkKXgsReVd
    80914CD4iw6v0Ey+NPmxkaFiaj6Z8sYpKkf8BNkmD0ajaW1NUsf3kzJMRbPzsnYMVN88
    aVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763370413;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YaeWgMD0WR5aGlBqwKoEFosB0zT0NsOoxqpV4EGHlzo=;
    b=hLIXEVGsrL3HmgiNkKbY/esd0FCcA9VcrObWVr/EtINZsKfGbG2EiEKG9WwCT9QiA6
    b82SeBifU63rHokwHR2rpLgzhf2Tt1hjTeBS9w0anNIaoQke7wqC1C6itR6ZwcYU377x
    d8AXhJ5ijouBn8rivzg75nYgL4inLsHk+7iANVnxsWxMGdE6ALb7d63WM30og0ILspKD
    PlLL46tSt0dYap4JvAPBZ1zs2Utgkt3AjIYUgLH8/9f8Akvty/mZcl7fXT+B1i0+NdFE
    IudtA5n4BvrhaEQ0BitJdf6tUKmvuBKGpv2FKRLW4DSiHCVrnNEyC1nZGOSRtwCmm3R6
    4aOQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763370413;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YaeWgMD0WR5aGlBqwKoEFosB0zT0NsOoxqpV4EGHlzo=;
    b=Nl4LGwOkPyfzc5nbg+RYE1bLTdjZAJu5oexphz27y5DJBRn+sILbxvug5JYdyi5A+Q
    NL5HfBDFpuRIrz4kqutfMo82W+4m3dKJC/3gCDTgQBv2o6hChMSFsU2Vhm8TrKOnS9sC
    scr+f9SCS0JDXOHrKQz/Q8O/4ra9NVNATWizOFijWG/w6Qq9Tj4NvhWKYceLfqMq1mcS
    P7A42N/09fSp5JdNp4WWXNHOjDzxPm6Q3Ye4QuD6pSjVAkwdW/9YucbI0QOHmp86J0Ht
    sFKUoaknIF+lWU9SIRjbGmnlWPOiRsXnOUwUsU4y0PD4ZH66mXG1D4UMKiDaknkwXBwq
    MJ/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763370413;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=YaeWgMD0WR5aGlBqwKoEFosB0zT0NsOoxqpV4EGHlzo=;
    b=f8TURlGu3z56SYbWQ0mzaaU1nkyFj7fTEhbla7yAZlNfiLcxIHdfSwtpCACBhwwnb/
    eYfQIE3CK5OgQTZkn/AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AH96rjl2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Nov 2025 10:06:53 +0100 (CET)
Message-ID: <c66798e7-ef66-4bb3-932a-0db4ba88a921@hartkopp.net>
Date: Mon, 17 Nov 2025 10:06:53 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v2 05/15] can: netlink: add CAN_CTRLMODE_XL_TMS flag
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20251115163740.7875-1-socketcan@hartkopp.net>
 <20251115163740.7875-6-socketcan@hartkopp.net>
 <c77caed0-5d88-4b2c-b371-3e2870324b4d@hartkopp.net>
 <8788fd27-8998-4dbc-98e9-1bd9557d15e9@kernel.org>
 <48b61f49-ad1b-485a-bac0-de3924cb30f0@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <48b61f49-ad1b-485a-bac0-de3924cb30f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 16.11.25 23:53, Vincent Mailhol wrote:

> 
> I just remembered that there are a couple more reasons why I preferred to use
> lower case here:
> 
>    - can_get_state_str() which is just above can_get_ctrlmode_str() also uses
>      lower case. Because can_get_ctrlmode_str() may be used by for things other
>      than the netlink error reporting, consistency with can_get_state_str() also
>      matters.
> 
>    - the ip tool command line also use lower case (xl on tms on…). So better to
>      match what the user just entered on the command line just above the error
>      message rather than the output of "ip link show".

Of course I expected this argument of the command line.
But the string becomes hard to read as I stated in my previous answer.

What about a wrapper can_get_ctrlmode_str_cap() that delivers 
capitalized control mode key words for the defines?

Best regards,
Oliver


