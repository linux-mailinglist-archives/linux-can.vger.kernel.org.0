Return-Path: <linux-can+bounces-2046-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B86E9C8624
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444261F20B68
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ABB1F5842;
	Thu, 14 Nov 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvmgsPyb"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417091E04BE
	for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576550; cv=none; b=Fq8htI88fMvq49ejwlYvTz9OcgwsTGMYPjhCH+N/uzfqmMJX30aJ5yIiOClnWb+1Os3nuy4MXQz5XUGvZfzbKgMg9Mq8LMsZ3uLhtMw6YT14VVfchVP8KIgtXQDUk+zAT7iamrUi/8n5U7fi583bHWujfEeG0+D2pG+QbJ4fqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576550; c=relaxed/simple;
	bh=SunWVLxZJU191an+c75kTT6SIArlemY5vm2v+U03SGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/taCwQoauQ4vcjlxU/rWHnfQUXlw0MgyWoULndZVzRhJtCSD6FoBDKDfHJEPE49uHvEwYrN2q8jQxUUKjBQ28DbFO5XCTlSSgWGOHMJ/0gfcPJHPGtoOoURNCeywy8G/GyTJGwIx1yEZ96mNiNl0a3kUTys3FsqzBGJs/bVlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvmgsPyb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-432d9bb168cso3009965e9.1
        for <linux-can@vger.kernel.org>; Thu, 14 Nov 2024 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731576547; x=1732181347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nS1EJqfWpVBxhs4KFRyVItEivrNNryuQ6Ge6sLEQQzg=;
        b=rvmgsPybBABEfCgrfeczr90Z3zLDGWvaDlGrPsDGEZ7cT+yIBwyXSQxjywJZQK467v
         LvPyGCisaSo8U87xyA88aUW5MnXzDo6ChTK9l7tjB2CeB0YH4CLcAgicWWwmaHhB6V3G
         gJsc6uPChCYdtGs1o1eZ1zt+cRblivoqBUWFendyuZd2xMF5g7dFzadY3ZxWeI8kFPT+
         avNei5N4jBFiVisYUlZZESAcKPL7sfqYYItO+O6A3WM68KoO+IgbnXGuRQ4fR3tIb+Mt
         /97rnym+1dDTZ5Y4lqBfan1m3ydiM7YjbUaaMbNPePLsfg4e/LMDDnc0XtjqNGCw0EMa
         7AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731576547; x=1732181347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS1EJqfWpVBxhs4KFRyVItEivrNNryuQ6Ge6sLEQQzg=;
        b=Z/ZNJyRsQChz04Q0O5A2F8h7QWtp9l7GmpXWwQxwdGyut0YCh5k3IVNQaT1Psr4BGH
         Grju2XuTKdMJfCDkoRpxt2pz6rKorqjTOqX9NQoH4uFwWXvgild1KDLm1SHU7WVZp4g6
         no0GG14ZZIi270wxVcmt6T9ewmaj1FS54MvJCE+q2K4wsPWEA7uYJtPvmTuuw9+02AU2
         YfuE/ziPXa8R6vKNPqgXRYaiZG3sl74qLv+dzgu8dEpu60hFGkNX4bf/pjcIssqMKs0+
         20hxFhlpemjiBIZ1aRqYfAolGk1WLXxYwJNx24JTunFoiXanS6LIj/M478s0ES9bbISR
         a0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3wqjRsnxg9P5K1r6q9YjWnfiufyh+9RGnGgPEND/GxQdxo54U90gsn6sIOB1tHhl96G1S41nHj9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUW5RIglaAnYZ2fxBYFJxlDp0MY7xPWZsVizhlRddR1XZcj48
	U/PI0YSUvJkL9RzvHygR+Xf/FIK8jB3GC33lzjfsbiWCnJjnOldQZ0fKS3q7SQc=
X-Google-Smtp-Source: AGHT+IHa+GwPw1XMCZ+cH9jSTN1XwUkHTtzXZGQ1rcTxNIzhWEEEwnyYXS3SOYBkd1TsYzhe+styJQ==
X-Received: by 2002:a05:600c:a4c:b0:42c:b991:98bc with SMTP id 5b1f17b1804b1-432d95ad53cmr21357685e9.0.1731576547571;
        Thu, 14 Nov 2024 01:29:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d48a7cf1sm47674685e9.1.2024.11.14.01.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:29:07 -0800 (PST)
Date: Thu, 14 Nov 2024 12:29:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Max Staudt <max@enpas.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Message-ID: <033f74e6-2706-439a-9c02-158df11a3192@stanley.mountain>
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <22e388b5-37a1-40a6-bb70-4784e29451ed@enpas.org>
 <1f9f5994-8143-43a2-9abf-362eec6a70f7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f9f5994-8143-43a2-9abf-362eec6a70f7@stanley.mountain>

To be honest, I was afraid that someone was going to suggest using on of the
helper functions that dumps hex.  (I don't remember then names of them so that's
why I didn't do that).

regards,
dan carpenter


