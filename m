Return-Path: <linux-can+bounces-1721-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D2C9AA2EF
	for <lists+linux-can@lfdr.de>; Tue, 22 Oct 2024 15:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F35B20BAF
	for <lists+linux-can@lfdr.de>; Tue, 22 Oct 2024 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F9319ABD5;
	Tue, 22 Oct 2024 13:22:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABC41C27
	for <linux-can@vger.kernel.org>; Tue, 22 Oct 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603341; cv=none; b=fR0Vh0jXJrTGQ+SJkYAnkvy0lA5sv6T8+nlRbMAiqX6vZtbbpU/xdMihJjDqL0IO7tf2ULCXEhEhD/RxyC9udG2lh2iY61NTOIEo59EUEPeSOWrjgduDIRkwV8rcqLlJpBLCQObhvvXpM/n2uWWpftKCp97/95aNYwTZ11C11rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603341; c=relaxed/simple;
	bh=3kP7YSsV1Kn4G3PKROScgishfWtmgQPZXox/LbC6d+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amgrA9FqKCYhWQnXB83fThJgCe3oEdavvO9Z4NT6G7If5gp1gi/W10dvxyzxBemNnqVktDzpBRSt/Z8ShUsmXehJJ5dCh3indEcpTa8pGam7xE7HI3Xe6Bot4y7Ob/PSvQ4H+vLTe/+Y+WshrTnUcKyXe45vW279IhM2t7CtnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9aa8895facso177748766b.2
        for <linux-can@vger.kernel.org>; Tue, 22 Oct 2024 06:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729603337; x=1730208137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8vFMNPZeyK2PR9pGhloOiUVmPbNCcnk3i6LVOi3UqA=;
        b=Z2pq+nb28qACPbogI2B9x4skzha8HabHQt+RkAaR1pv01lCa9/j4ZMvithTEbfajNb
         g2nYjU/+yRrSGci16AD9TUFPgwt48ECv6nkif987yorYX+eLLMhDx4IbaHrjs/kcwI+k
         i3OHuRp+yBqNjiZVAM6iLE0R1WXqzZlIV8y9m6fxKIhnZOb3qnCRk4jYeA1HBdiUtobW
         x0BfN3GH9N9jq2fiV6HZAYK7GYzTi0kNB/8LwHRQsb4AJ96pb0PrJ7sHyqCdAQYv5Npa
         vknw5NVUNPcQSVJdrVb2z8aTXmY3mk35/BLcsFgbpZN+EM5MasfXLcVBQuVd7Tt0MiQd
         KIgA==
X-Gm-Message-State: AOJu0Yzo66ZzyTTQqY9wKdKfEhPMZMuvYExAk2X3WfpW5L6FKewUXqDz
	ArNMUWidBv2j1fXi2MgiiiktGPD+AFDPLm64J6IbvgD5ZvytVU6g1jXvL+paNonIaLmcITwf8fJ
	9/qxlCJOB5Ws0u3H1bWCmL3ofZAo=
X-Google-Smtp-Source: AGHT+IFsm0AbjLF1nLMCpnpXEwhXuLnVS9AWjnaq++UvtVG89i5qw0763YZSKolYh6ItRVe2KPTcaVY+WMP0R7OegLM=
X-Received: by 2002:a17:907:3f09:b0:a9a:8a4:e090 with SMTP id
 a640c23a62f3a-a9a69c8fcf9mr1479457766b.50.1729603336508; Tue, 22 Oct 2024
 06:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022130439.70d016e9@endymion.delvare>
In-Reply-To: <20241022130439.70d016e9@endymion.delvare>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Tue, 22 Oct 2024 22:22:05 +0900
Message-ID: <CAMZ6RqJxb-52eSPqvaESjA-Wd_Jd-=gFO1HWbzxWe3gx7GWDmA@mail.gmail.com>
Subject: Re: [PATCH] can: rockchip_canfd: Drop obsolete dependency on COMPILE_TEST
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jean,

+cc: Miguel Ojeda <ojeda@kernel.org>
+cc: Masahiro Yamada <masahiroy@kernel.org>
+cc: Andrew Morton <akpm@linux-foundation.org>

On Tue. 22 Oct. 2024 at 20:06, Jean Delvare <jdelvare@suse.de> wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), OF
> can be enabled on all architectures. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.

I understand the motivation behind this patch, but for me, as a
maintainer, it becomes more work when I want to do a compile test.
Before I would have needed to only select COMPILE_TEST but now, I
would need to remember to also select OF for that driver to appear in
the menuconfig.

Well, I am not strongly against this simplification, but, wouldn't it
be good to make COMPILE_TEST automatically select OF then? Looking at
the description of COMPILE_TEST, I read:

 If you are a developer and want to build everything available, say Y here.

So having COMPILE_TEST automatically select OF looks sane to me as it
goes in the direction of "building everything". If this makes sense, I
can send a patch for this. Thoughts?

> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
>  drivers/net/can/rockchip/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-6.12-rc4.orig/drivers/net/can/rockchip/Kconfig
> +++ linux-6.12-rc4/drivers/net/can/rockchip/Kconfig
> @@ -2,7 +2,7 @@
>
>  config CAN_ROCKCHIP_CANFD
>         tristate "Rockchip CAN-FD controller"
> -       depends on OF || COMPILE_TEST
> +       depends on OF
>         select CAN_RX_OFFLOAD
>         help
>           Say Y here if you want to use CAN-FD controller found on
>
>
> --
> Jean Delvare
> SUSE L3 Support
>

