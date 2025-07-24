Return-Path: <linux-can+bounces-4081-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F462B100FF
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348907A64CF
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 06:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055091E8324;
	Thu, 24 Jul 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs69tATu"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472272153EA
	for <linux-can@vger.kernel.org>; Thu, 24 Jul 2025 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339431; cv=none; b=f/zjt9RAPq34kMxzZQwp7tXlYb1LqHOPGCqfbj5YrFUuPwudxaeky8j2aREYAoEo2+/AA3vImhhXauGXrFtNo/HYYUpnWj7DvMXO8aOToIKFkYAgwKq5Ckb+9+35brDDmwuBa5HvoBQoez1j9pHr3UHSqyQC4Cz4YUpILPWHYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339431; c=relaxed/simple;
	bh=k9Xo9Y3TANjk7o1KPnAXzOX0qd5PFj3QaKhubCYkVuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wetfart8yZgNtpencFva2olIwWP61ndWO2fKMfQDpqb+huon0j2DH3eyiCQF8gHH+basgdM/2k3NVpJ0wlWsplIvTMPIIdjtKwbbGb+JGJZXW2pKmq59aQ+qac2IlC5C6wZf4gsAar2gcgI8KK4jtvgbt9MwJXj4sGrbgB7qwlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs69tATu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so1166801a12.2
        for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753339428; x=1753944228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAZkwxQzcYBy1Qma0byiBfOAij6E1PbH9hKAEv4kxfI=;
        b=Cs69tATuOeA3wymU6oTfH23MQ0lbnSllMAw3rydqGMNmYWmockHkHHFnWOWgEfh655
         Rb64GQTrZvFVLeAZnLLRdLNMc/Fqg7EAInSp254vdTHtCdEL/TE/sHVH42CNmIeVikXj
         rZ1gRlZwwzq8fQRWOvTDGnbRTU7MhsZyI3P4f5kv0ny9JPW0AU335iPe99Q7toqd1vHf
         T/sT1j/gwnpArISYNeepmeAbG9pvyuwNt3/s/v65md9LjVzQEDato3ohq9voh9NXVNSO
         uIHa0K38vl41xIWyg7smF+mxo9xzTIK5SC9nyi7qImIY4ns0EXKJAEo9Hoft1jdRlmjK
         A+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753339428; x=1753944228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAZkwxQzcYBy1Qma0byiBfOAij6E1PbH9hKAEv4kxfI=;
        b=bghzepmDtW3a7OerCnOFMWdDcm35ge8rvOmkh5ciWeIPsa+hIz8V7gfZUGQ3Dbz0SH
         HDO0aEQ+YTOTcbbYCMtbKRpxnR0LdIixNZTyGHjTkJLoH9JdnAsNr8WhmFwr/LKBAiXv
         b8d+z0AUUTOl6fXicf9+fuW2WZCZZfsLPPJYWnyKuiorMd87+2uByVdvataC1XJFd9az
         At12HhsHvmnMdh7EAK3BTOdUlWfiYxJHqQcwx8mbS81mHA6h5XYlzDXUJiXNHeNruTx1
         TQqgi6mUmT+6l3I8nvDHJSb/lSaFdfZP+97TvYtQZU219j422KJ8t7rLD6hJThjp6Xyn
         3abg==
X-Forwarded-Encrypted: i=1; AJvYcCVRKOqXEX/g346bN0/msdxptpdsuwCqXne5vyD4w86Zix/XJiiwdSGHp8QeSJKecIdjLoexh7i4Zzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvlNTPWJpDE95KF89miN1tnCU3a4jel4XGuFlKFQD8BPrAD6EU
	R28+qIpv4V1mKoTdAfqvbLVm2sZ10FKf5QgnTskV/oYCmcCOY1al09jMEonrvQ==
X-Gm-Gg: ASbGncu6wsijnCUMqZjc1f62ygAr36t5x4MeiXoihdVUamsMAPuAdawYQu0lhD9p5T/
	7TM382PcFfwyjLgDr+vpmtM6VTytr9nzO/nVZYQK7jn3eSCylf3gS1NxsudBlv6569C/mZ5rSNI
	FWhmxT33wn6KsWFLrw74dcjRAz3SblJIX/zjdoLafTlQ4K7SZDVOkg8qPPU12VTSqziTBmrZ9Ts
	bKIyTQcfuECkSYQpewaqLYdi9edrewwTkFLXymRcKIbfGMw4W0cCJiJ/RTmvjNjYsJ+7bBzdd21
	SwmsrfkRTuf7X4KG4Ao1j06smaL0eCSCymj0xzmzWHmEs0xe5tErZNSkrrZOIuXnGlfx5Da7X/I
	KA58V3CEBQZuw+N78U9i3QIz3XmL45G5EjvEW/geg9E/ZrxsJZr+2zflcFlDKqZrZCHZ2UpNsdX
	8y
X-Google-Smtp-Source: AGHT+IGTMXKCa9mMu/0bSqBbKd1a6oRzF/KRtBz97h/J6MOLNxDL6I4yEgC/2/LhwOZcXevaBS5SDw==
X-Received: by 2002:a17:907:6d1b:b0:ad5:27f5:7183 with SMTP id a640c23a62f3a-af2f885788emr526931066b.39.1753339428354;
        Wed, 23 Jul 2025 23:43:48 -0700 (PDT)
Received: from [192.168.66.199] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-af47c58bb1fsm67784166b.7.2025.07.23.23.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 23:43:47 -0700 (PDT)
Message-ID: <94bbe823-33b0-4b98-b37b-e53308bd425a@gmail.com>
Date: Thu, 24 Jul 2025 08:43:47 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] can: kvaser_usb: Simplify identification of physical
 CAN interfaces
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250723083508.40-1-extja@kvaser.com>
 <5cdca1d7-c875-40ee-b44d-51a161f42761@wanadoo.fr>
Content-Language: en-US
From: Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <5cdca1d7-c875-40ee-b44d-51a161f42761@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 2:44 PM, Vincent Mailhol wrote:
> On 23/07/2025 at 17:34, Jimmy Assarsson wrote:
>> This patch series simplifies the process of identifying which network
>> interface (can0..canX) corresponds to which physical CAN channel on
>> Kvaser USB based CAN interfaces.
> 
> This series mirrors the kvaser_pciefd one, so I will not repeat the same comment
> twice. I let you manage it directly :)
> 
> One last comment for both the kvaser_pciefd and the kvaser_usb: you may want to
> add an entry to the devlink documentation. Something like this:
> 
>    - https://git.kernel.org/torvalds/c/9f63f96aac92
>    - https://git.kernel.org/torvalds/c/115dd5469019
> 
> Yours sincerely,
> Vincent Mailhol

Hi Vincent,
Thanks for great review comments!

I think I've fixed all of them for kvaser_pciefd in v2 [1].
I'll send v2 of the kvaser_usb series once we've straighten out the usage of netdev.dev_{id,port}.

[1] https://lore.kernel.org/linux-can/20250724063651.8-1-extja@kvaser.com/T/#m8f7fa76d70b4c7c32c69f74035663cdb330fdf02

Best regards,
jimmy

