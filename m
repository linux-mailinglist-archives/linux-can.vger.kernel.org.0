Return-Path: <linux-can+bounces-408-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F5387FBBB
	for <lists+linux-can@lfdr.de>; Tue, 19 Mar 2024 11:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6678282C95
	for <lists+linux-can@lfdr.de>; Tue, 19 Mar 2024 10:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7F47E116;
	Tue, 19 Mar 2024 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VXhS4Gkv"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060077D3F4
	for <linux-can@vger.kernel.org>; Tue, 19 Mar 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843929; cv=none; b=oyUaHGSfRcmCWak6OTafR7MHdCY4PKA5soFtjU2cZcIiNIlxrZfzNV19HR7fyncyYdHWAP21Y/rZGBaZyBK1nwTbnq900q1iVKMjZ/52B6Mha3LMYxiFtgG8WAxehkcY20AlEqLSsFj7u97aZzQymHxyCcstoUGGFC8NNyq/T64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843929; c=relaxed/simple;
	bh=OnBNIG4DWvyES4WjoqSTtsh1i7tgE0uwjYJgRmeTR+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN0gHhIuBKpToE6/p37f7ZgFOIWhq8GOyTW/aJWxT1PMEVecnH0uEH7Jw4f53flynAVZDpEykDZwQBDUwAxWidM9GjQyaGGB3ZEQY+8c84/vXBLAh38ekyuMpjXLvvBd6q5GWcZz4dZ21YKph2ZE8mOUqgveOcdDtzsoe7n9kHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VXhS4Gkv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41466e01965so2042995e9.3
        for <linux-can@vger.kernel.org>; Tue, 19 Mar 2024 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710843924; x=1711448724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OnBNIG4DWvyES4WjoqSTtsh1i7tgE0uwjYJgRmeTR+M=;
        b=VXhS4Gkv3JpVyE0Jn3EMieo4GTcl8/33vRiFMufkr0q4oyPW/uxeH/AMhHNYYhpRLn
         40+WYzrxLHPL62UpHmVgTulielRsx/vdEIbuhbSa3ZZmCNqNKYuUQ/BJTnsLS0LpU0Mt
         vgfZBJ6Sch90t9/DMEzA7/vmuyA3S0zWmBGOEGphGLZkZg7NLlbG+6YTzf1ky/HIiumZ
         nT8lj6BjT+sojDywhI87dz0gFg4dHJ7bZqbfOWZ9BUexvOjAwFF48jRVEs65wvwCEN+Q
         f+AqgvwrBwnh5r7ImVDkRHoEfzPA3uNfZb7o8LLaN43kCqN3UAUz6oe3hWrFt/i6cJqi
         Ckaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843924; x=1711448724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnBNIG4DWvyES4WjoqSTtsh1i7tgE0uwjYJgRmeTR+M=;
        b=KA0wwzn1sfiPZqJAD3HF2YAbMwtyg9wk/AzPy7uf4nyBOLtIc2UNPfdQ/kcJtYTV76
         IWMJBKBWD4gYWXA5LGYDoEFsMJnsIqzo3PBCgvbXi3Q7eLmU3u38rLMXd9aElCogYPRS
         eORvg53bE9bBZCMfWfvVIE4MpIS62FQd2Yu6u6EAbPQl428uaa7PrRNcmfhjCgXJlpeK
         2Bd/xf3NX421dUdbEL4+Z2CtK538FI8VwLxmWqdI0H4kRX03/8n1mOegzHMr6IisHGuH
         5Dp5bk45e0o6qgZ+BBv+1AJp+l5WmUEwukF/+/yvfQNjIKhY47aA/wRbaE3gF40anPV+
         dc3Q==
X-Gm-Message-State: AOJu0YyVgAlLwYlFKCz0/7ddS0+JdRR77cujjHiyURUgimTBFUh7EN+u
	raiXknt0FOrgG/2mNd1X55ncGcogADQ/pQ1g2VnWcwJbIJ8S92tLr0hf8R9g5W4=
X-Google-Smtp-Source: AGHT+IHotenhFWM7P6vIUURB0jw7q6bTdPsEpzEoM54hT5u8Tjrs6OMB9+Q8kc7xsi832O6gONs24w==
X-Received: by 2002:a05:600c:4e89:b0:414:1fc:1081 with SMTP id f9-20020a05600c4e8900b0041401fc1081mr7799276wmq.36.1710843923987;
        Tue, 19 Mar 2024 03:25:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b004132901d73asm17626214wmb.46.2024.03.19.03.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:25:23 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:25:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] can: mcp251x: Fix up includes
Message-ID: <ZfloDwb0XMI7KryR@nanopsycho>
References: <20240318193410.178163-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318193410.178163-1-andriy.shevchenko@linux.intel.com>

Mon, Mar 18, 2024 at 08:34:10PM CET, andriy.shevchenko@linux.intel.com wrote:
>This driver is including the legacy GPIO header <linux/gpio.h>
>but the only thing it is using from that header is the wrong
>define for GPIOF_DIR_OUT.
>
>Fix it up by using GPIO_LINE_DIRECTION_* macros respectively.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

net-next is closed, send again next week.

