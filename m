Return-Path: <linux-can+bounces-229-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCCF8518B2
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 17:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD861C20DB5
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A73D0C1;
	Mon, 12 Feb 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="g66ieMNv";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QouAC0dM"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464CC3CF79
	for <linux-can@vger.kernel.org>; Mon, 12 Feb 2024 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754226; cv=pass; b=i2bETBqwZOXHxOKrWhTFXocOUsjnSx4zGif2J9kBZEis0rvA+llFXvzrZ5L+nYsufZ3xq46DgSzGRkOHM9X5gPl0AgaApSONxu1bOtZ20r+0jPY4lpSTorCLj8Bzh8Fsk5qWf2GN/gOIoG15YZpLrjQgzFBCUwRO7IQmKF3Vo+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754226; c=relaxed/simple;
	bh=ZXzLgfsA+0ZwQ+Z/me94iMubOQL7zpToUMJ/F5aiAeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxxsT3IXMCDkevfkkmYaXK4cH9FSJQQ2yXwAes9MgKQ60XPy0wMaALondYzef7+lZBjCHBRuw2eilvlooJ3YrsnkRWlpCY6fNjyiZ2xc6TAVCkUpiHxYt6UxGQJrDOlPGfUvGt7jKJc32fz9UyXBnlmmBhZg2lcVt9cRHPIfmbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=g66ieMNv; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QouAC0dM; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1707754220; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Zial/nrCL0NxUe2KWqgl9Y9ua+PoFyRfSTrOlIf+WOdejNl4kVTI4SgAbpOSYkaHYc
    EgPfua7myMigBP8EU+iaroZANMO5Cua3cczRm6ApEcAhNprgWWPuUx0nPw4PkxTSXuGd
    OC+vVBL0FshnX3X2xcdxKmM7aFxgaSNx+3XqylCqkKwXkqLVWE31mypIJfDV1mkPhw0A
    NB0P+oo7jl9t1H5cuyUcfrAoVp0Tnh7xDhg0/nZdB0XQia/Wj1dbyYymrbPzJIOZxbcQ
    IQJRo2zzSfxgFCP2k35LlKiIRp2Zk0qUn19tXTOAtr0YoN9KaKaQjabCToPa8ClQEeKh
    3++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707754220;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5Zzv3+OrchOKMSobEfAts+H92KwPpdE2OkqhsWj2ydU=;
    b=hbqEAB6d10+sSNOgwntEffHfoJsAjTjYhqf92OflSgSm1KSQk8EqIQ8/zsbmeJDsP0
    xoNq2CURyN+8V2s08/LEZ5pf9TdRXxQxbWB/b0u+cfClyM5a3pIhz7hL1IpxE/yfDZKW
    E4G7I9EmqMo7fLLwmB+/zy4dv4csFbx92panHQp+7IFLTZxE9/7pFlK103TTJJ8WkCO1
    MqGbYtNaBGr8e+Kf0pceIMllp2tMnZmK9vwNaFEd5+NzzIWPdwhTkMyf9KvbrBHzcZzf
    tCkSN436VXxFLd3nzmaHGiRpiombSt5H1r8ral+tRVXX789eZjDQX6laA1rmQgsbHK32
    u1hA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707754220;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5Zzv3+OrchOKMSobEfAts+H92KwPpdE2OkqhsWj2ydU=;
    b=g66ieMNvmNgJ/AB7AhHX5sN00EMQduTx3RqwCvSCafh8F3J0ZCiBV4q8gW+MmoUXe+
    f7wQEYUXRsOhXltbo8MlziQcJW1reb3l3EOsJHuCnacSYlbPYd0RPsgaS4MMvjvcpXeC
    XIlIg/Qeimaid40sfH7E75JdkNtqfJsqXyK40z+tSzTCDhZFfBCTRbZQaaT3r7fyEjIf
    Vs1wdBO+BbLMRjcL/uRZxKQLzCcBXp2TMWQAlTxLbt23wWx707zAew0tU7yK3wGruUwb
    Tx6i4Whu8vd6WbYVEUn7MqfXAKYhwTzcvOqGlg3fpkd8kxmBmP5XWBrP6EbHN8eBF9DB
    QdfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707754220;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=5Zzv3+OrchOKMSobEfAts+H92KwPpdE2OkqhsWj2ydU=;
    b=QouAC0dMD2ILxLuyJ6FM68UdRpZ+hkcgbNBtAYjg7z4+dqgLB5F8JN9Db1wnF2OGvm
    HkY8zJZJbc/d+CVX7iBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0UTaZHwzdhXLrLeFZYH4OzH3Acp84Q=="
Received: from [IPV6:2a00:6020:4a8e:5010:d1cb:da5c:d3c0:9ade]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01CGAKpkk
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Feb 2024 17:10:20 +0100 (CET)
Message-ID: <81082bd5-069f-4686-aa6e-08744cf16ff4@hartkopp.net>
Date: Mon, 12 Feb 2024 17:10:14 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rework v1] canxl: add virtual CAN network identifier
 support
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Guy Harris <gharris@sonic.net>,
 Vincent Mailhol <vincent.mailhol@gmail.com>, linux-can@vger.kernel.org
References: <20240212151404.60828-1-socketcan@hartkopp.net>
 <4a3f3605-6a54-4ca0-9581-eff900e6b169@hartkopp.net>
 <20240212-curry-aspire-408b56e4ef6f-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20240212-curry-aspire-408b56e4ef6f-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024-02-12 16:53, Marc Kleine-Budde wrote:
> On 12.02.2024 16:26:34, Oliver Hartkopp wrote:
>> I'm currently in discussion with Guy Harris who's working on the Linux-CAN
>> support in Wireshark.
>>
>> We current have two approaches how to integrate the VCID into the struct
>> canxl_frame:
>>
>> 1. Add the VCID at a specific 16 bit offset (above the 11 bit Prio ID)
>> 2. Create a endian-dependent data structure with a separate uint8 VCID
>>
>> 1: https://lore.kernel.org/linux-can/20240212151404.60828-1-socketcan@hartkopp.net/
>> 2: https://lore.kernel.org/linux-can/20240128183758.68401-1-socketcan@hartkopp.net/
>>
>> The endian-dependent data structure looks like this:
>>
>> struct canxl_frame {
>> #if defined(__LITTLE_ENDIAN)
>>          __u16 prio;   /* 11 bit priority for arbitration */
>>          __u8  vcid;   /* virtual CAN network identifier */
>>          __u8  __res0; /* reserved / padding must be set to zero */
>> #elif defined(__BIG_ENDIAN)
>>          __u8  __res0; /* reserved / padding must be set to zero */
>>          __u8  vcid;   /* virtual CAN network identifier */
>>          __u16 prio;   /* 11 bit priority for arbitration */
>> #else
>> #error "Unknown endianness"
>> #endif
>>          __u8  flags;  /* additional flags for CAN XL */
>>          __u8  sdt;    /* SDU (service data unit) type */
>>          __u16 len;    /* frame payload length in byte */
>>          __u32 af;     /* acceptance field */
>>          __u8  data[CANXL_MAX_DLEN];
>> };
>>
>> @Guy: Besides the fact that suggestion 2 does not win a design prize I'm not
>> sure whether solution 1 or 2 are better to maintain over lifetime.
>>
>> Feedback about the two suggestions is highly appreciated.
> 
> Then I'll skip the virtual CAN network identifier support patches for
> now.

I assume the discussion to be resolved within a day or two.

Do you have a favorite patch?

Best regards,
Oliver

