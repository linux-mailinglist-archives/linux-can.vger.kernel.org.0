Return-Path: <linux-can+bounces-1989-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48CF9C5673
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 12:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7DF1F247A4
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 11:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E95D1CD212;
	Tue, 12 Nov 2024 11:15:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115891CD215
	for <linux-can@vger.kernel.org>; Tue, 12 Nov 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410117; cv=none; b=EtRzXctoh+OuZUxms1hxljkxRzYHRx3nHyYefhv05vufVIULL+bjlghTjPL7mRQb3TjPz8fxfvjfOsB9N9cRVYHu47plLTwx9XtHi38Cc4FAsuCfZJ7schnk1YyiLKjU7lNdGQNPwkCLWmyhTADL3GuXiUWB2IviFnNv6tfqLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410117; c=relaxed/simple;
	bh=kJxEQskVB7pr9rpq21BHIGNP254vQv63rZRhuoTGy4o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YZoKCqY4qUQs9rr0v51y9pz2j1leasiJWsRADoHg42DvjH5wBa79In6W6RnW0Hboy8NmmoDsAkTfj7PoIh02+Sj89lryInja22dz3Yh4oqyf3Mq0INjf78WGiQLAG4uEw9SjdGhKX71k0FfbSB6ops/PZDxtLA2ERdR7hktmyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:78de:3cf6:79c5:d375])
	by baptiste.telenet-ops.be with cmsmtp
	id bnF62D00N4mJWgD01nF6Hy; Tue, 12 Nov 2024 12:15:07 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tAorS-006owL-Js;
	Tue, 12 Nov 2024 12:15:06 +0100
Date: Tue, 12 Nov 2024 12:15:06 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jean Delvare <jdelvare@suse.de>, 
    Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
cc: linux-can@vger.kernel.org, kernel@pengutronix.de, 
    Marc Kleine-Budde <mkl@pengutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
    Masahiro Yamada <masahiroy@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] can: rockchip_canfd: Drop obsolete dependency on
 COMPILE_TEST
In-Reply-To: <CAMZ6RqJxb-52eSPqvaESjA-Wd_Jd-=gFO1HWbzxWe3gx7GWDmA@mail.gmail.com>
Message-ID: <dcced72-7be1-b44-432a-dac2ad7f4cc6@linux-m68k.org>
References: <20241022130439.70d016e9@endymion.delvare> <CAMZ6RqJxb-52eSPqvaESjA-Wd_Jd-=gFO1HWbzxWe3gx7GWDmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

 	Hi Jean, Vincent,

On Tue, 22 Oct 2024, Vincent MAILHOL wrote:
> On Tue. 22 Oct. 2024 at 20:06, Jean Delvare <jdelvare@suse.de> wrote:
>> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), OF
>> can be enabled on all architectures. Therefore depending on
>> COMPILE_TEST as an alternative is no longer needed.
>
> I understand the motivation behind this patch, but for me, as a
> maintainer, it becomes more work when I want to do a compile test.
> Before I would have needed to only select COMPILE_TEST but now, I
> would need to remember to also select OF for that driver to appear in
> the menuconfig.

IMHO these are two different things: to get a working driver, you need
to enable OF; to do (may be limited, i.e. may not give a working driver)
compile-testing, you need to enable COMPILE_TEST.

So I think commit 51e102ec23b25e6c ("can: rockchip_canfd: Drop obsolete
dependency on COMPILE_TEST") should be reverted.

> Well, I am not strongly against this simplification, but, wouldn't it
> be good to make COMPILE_TEST automatically select OF then? Looking at
> the description of COMPILE_TEST, I read:
>
> If you are a developer and want to build everything available, say Y here.
>
> So having COMPILE_TEST automatically select OF looks sane to me as it
> goes in the direction of "building everything". If this makes sense, I
> can send a patch for this. Thoughts?

Please don't do that! Merely enabling COMPILE_TEST should not enable
any additional code in the kernel.

>> --- linux-6.12-rc4.orig/drivers/net/can/rockchip/Kconfig
>> +++ linux-6.12-rc4/drivers/net/can/rockchip/Kconfig
>> @@ -2,7 +2,7 @@
>>
>>  config CAN_ROCKCHIP_CANFD
>>         tristate "Rockchip CAN-FD controller"
>> -       depends on OF || COMPILE_TEST
>> +       depends on OF
>>         select CAN_RX_OFFLOAD
>>         help
>>           Say Y here if you want to use CAN-FD controller found on
>>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

