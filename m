Return-Path: <linux-can+bounces-626-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C62F28C26B1
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 16:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7A41F21AE1
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D021708A5;
	Fri, 10 May 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lo1+duOd"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172F170888;
	Fri, 10 May 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350909; cv=none; b=l5wChpYvI4zQnUb6uRrT+FChZiZEd1uSRdApS28lRPf9lIiiMxkbmsFal80XxiLVrrxQmuJs8ZzF9ilp4jTMsJj8KYdfgp9DDDLIWjejSmDsQ/54xnktYB6OkHqtOrRcSmm90hWxM8g3HpJg2jwDgAIFDeVHrpORKb1Dfo51geo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350909; c=relaxed/simple;
	bh=GICVwXtl8OlmHpKHmRiiQuN8TAKF0PfLMJwLr6g0TPQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tUjaNGBExDnsodnLhYcHIQfzO9CgE2rzLBbpZcqYgriHROIMC+tpFhuDbVika+JUUcvC6CGGntvU74SZ19UlQQh2XGO1JrD0XxeGd+tkCP/5Qn7UUhKrBfefP6pPofmFUZ//BkptLcERreX51u/bcpincGNwbpCnFWuROUsog70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lo1+duOd; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350908; x=1746886908;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GICVwXtl8OlmHpKHmRiiQuN8TAKF0PfLMJwLr6g0TPQ=;
  b=lo1+duOdDm0Ud6NLgZqXTpRM1qQqjvTccMKxfK+n1MYoDQe8K4XI8OhB
   GaFkUKGKRSdcUvYMa6DSP4mWid6CrQuufQda84RELZD4ygkj+4lasvDep
   l4MhR6WD2GtFUAUJ+LwlPWm2pDHGcQ4g/WreWoR0+xJscD0MJKgGKhsZ7
   eWipKeS6kIavBDhsNx3MlfXwnCBSkWavsIhQsUQD2dfvc5xlIjw6goidU
   YGVUuXVgcZviG+EvoCjMWMUVwQDfhWrRysrcoTB5QSYcIoJY6pODRe+oj
   hiv4pX9qtsTbbAetw6t+qVEFDccZCAA8/e7z8monldbkoXNYAlhFld0UV
   g==;
X-CSE-ConnectionGUID: DVtBfXSmRFaiJx5KbzHQgA==
X-CSE-MsgGUID: UWJ6AlJLTxeRVKCSq1jlzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11459934"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11459934"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:21:48 -0700
X-CSE-ConnectionGUID: auXQFHKwRyS2NbOh/x1Gkw==
X-CSE-MsgGUID: rrf7dl4dQdutg4DpF62Clg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34071332"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:21:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 May 2024 17:21:36 +0300 (EEST)
To: Christoph Fritz <christoph.fritz@hexdev.de>
cc: Jiri Slaby <jirislaby@kernel.org>, Simon Horman <horms@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Marc Kleine-Budde <mkl@pengutronix.de>, 
    Oliver Hartkopp <socketcan@hartkopp.net>, 
    Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Sebastian Reichel <sre@kernel.org>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Andreas Lauser <andreas.lauser@mercedes-benz.com>, 
    Jonathan Corbet <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
    linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
    devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 04/11] tty: serdev: Add method to enable break flags
In-Reply-To: <20240509171736.2048414-5-christoph.fritz@hexdev.de>
Message-ID: <36b0d460-1d96-89d8-db4a-76d735f7ee6b@linux.intel.com>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de> <20240509171736.2048414-5-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 May 2024, Christoph Fritz wrote:

> The recently introduced callback function receive_buf_fp() brings flags
> buffer support. To allow signaling of TTY_BREAK flags, this patch
> introduces serdev_device_set_break_detection() and an implementation for
> ttyport. This enables serdev devices to configure their underlying tty
> port to signal or ignore break conditions.
> 
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  drivers/tty/serdev/core.c           | 11 +++++++++++
>  drivers/tty/serdev/serdev-ttyport.c | 17 +++++++++++++++++
>  include/linux/serdev.h              |  2 ++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 613cb356b918d..23a1e76cb553b 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -339,6 +339,17 @@ unsigned int serdev_device_set_baudrate(struct serdev_device *serdev, unsigned i
>  }
>  EXPORT_SYMBOL_GPL(serdev_device_set_baudrate);
>  
> +void serdev_device_set_break_detection(struct serdev_device *serdev, bool enable)
> +{
> +	struct serdev_controller *ctrl = serdev->ctrl;
> +
> +	if (!ctrl || !ctrl->ops->set_break_detection)
> +		return;

Why you need to test for !ctrl?

> +	ctrl->ops->set_break_detection(ctrl, enable);

I'd use positive logic here:

	if (ctrl->ops->set_break_detection)
		ctrl->ops->set_break_detection(ctrl, enable);

> +}
> +EXPORT_SYMBOL_GPL(serdev_device_set_break_detection);


-- 
 i.


