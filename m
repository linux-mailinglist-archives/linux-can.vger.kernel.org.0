Return-Path: <linux-can+bounces-2690-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4507A1A8AE
	for <lists+linux-can@lfdr.de>; Thu, 23 Jan 2025 18:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7553D7A0512
	for <lists+linux-can@lfdr.de>; Thu, 23 Jan 2025 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E486142E6F;
	Thu, 23 Jan 2025 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2QfbZTq"
X-Original-To: linux-can@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D393F9C5;
	Thu, 23 Jan 2025 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652562; cv=none; b=K1LNlokiyP64YyieI6aoZN+j4vVaS8edcjhe3JjjRglV1YXpf9RSFirlnOM/YWA353MWgG8P+Dq0U54PGwHNWT0rsSl3F75Yzomao9WZesnaE9ZbI9+REOlxhEQdXSOgJoD6AOXRpXZ5o/kloVLXlbyniBzdzpE96HYvVCVz2PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652562; c=relaxed/simple;
	bh=yNQRZnWuKsXXK1AYGUA2AefX8bsBey6q6K/HMCflImc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INpN9/aSTmVbcR9VMDN7j/s9ao50Fyu96wvczvSdOaqrd6RrPOCMGh9WYsvbwB7cWktIgQ3Qq3mn56tAz5mMkYlAV0WfHz/XdLMEQUKgsGsksEQJrc8Ar2anuOoab7kmMKEctpji4gCq62I+sLcyikqCWaF4kfFjkq7+v5t8h6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S2QfbZTq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=GLYJkHDOUuZ3o2Lb+FJZRPmgsp7LPG76z9WRN2s2jfU=; b=S2QfbZTqd32vxBdhMIvQhWSST5
	Mbdma79dxlCWjPgbyru8ws0z7gY4LNJfEtjtqN/6aUh3S/UXbMqR0Cs8XA/4bsPzT9E7MrgVr5cEM
	z8zjB1geYmmwmfIt8MjjuMyqqSc8KQLyrx7XKmVC8lwQjF39rFAwQ7YuWSXM2ueVD8g5iiF5gPecl
	PTKVOhZq5vGIlB/9srEoaAe4A3T5FHSHv13h0S6zaY7Sj3W507f47zycBRT/lC9WP7Sdz8VGyCaVa
	C8dE1K4721fDyzIY/zKXQMpwT/VdmVZPaNROxGTUGTYKzm79wQWTk1rA2t2539cVTOho09fZ4rGSV
	XjKegf7g==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tb0o2-00000009XYe-16oH;
	Thu, 23 Jan 2025 17:15:50 +0000
Message-ID: <07902f4e-e823-42bc-84fe-829a3e53dbc8@infradead.org>
Date: Thu, 23 Jan 2025 09:15:43 -0800
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] documentation: networking: fix spelling mistakes
To: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>, socketcan@hartkopp.net,
 mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net
Cc: shuah@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@vger.kernel.org
References: <20250123082521.59997-1-khaledelnaggarlinux@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250123082521.59997-1-khaledelnaggarlinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/25 12:25 AM, Khaled Elnaggar wrote:
> Fix a couple of typos/spelling mistakes in the documentation.
> 
> Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>


Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Hello, I hope the patch is self-explanatory. Please let me know if you
> have any comments.
> 
> Aside: CCing Shuah and linux-kernel-mentees as I am working on the mentorship
> application tasks.
> 
> Thanks
> Khaled
> ---
>  Documentation/networking/can.rst  | 4 ++--
>  Documentation/networking/napi.rst | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index 62519d38c58b..b018ce346392 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -699,10 +699,10 @@ RAW socket option CAN_RAW_JOIN_FILTERS
> 
>  The CAN_RAW socket can set multiple CAN identifier specific filters that
>  lead to multiple filters in the af_can.c filter processing. These filters
> -are indenpendent from each other which leads to logical OR'ed filters when
> +are independent from each other which leads to logical OR'ed filters when
>  applied (see :ref:`socketcan-rawfilter`).
> 
> -This socket option joines the given CAN filters in the way that only CAN
> +This socket option joins the given CAN filters in the way that only CAN
>  frames are passed to user space that matched *all* given CAN filters. The
>  semantic for the applied filters is therefore changed to a logical AND.
> 
> diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
> index 6083210ab2a4..f970a2be271a 100644
> --- a/Documentation/networking/napi.rst
> +++ b/Documentation/networking/napi.rst
> @@ -362,7 +362,7 @@ It is expected that ``irq-suspend-timeout`` will be set to a value much larger
>  than ``gro_flush_timeout`` as ``irq-suspend-timeout`` should suspend IRQs for
>  the duration of one userland processing cycle.
> 
> -While it is not stricly necessary to use ``napi_defer_hard_irqs`` and
> +While it is not strictly necessary to use ``napi_defer_hard_irqs`` and
>  ``gro_flush_timeout`` to use IRQ suspension, their use is strongly
>  recommended.
> 
> --
> 2.45.2
> 
> 

-- 
~Randy

