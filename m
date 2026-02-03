Return-Path: <linux-can+bounces-6478-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGm4NasQgmm9OwMAu9opvQ
	(envelope-from <linux-can+bounces-6478-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 16:13:47 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05473DB26B
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 16:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89E4630185E4
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF19330F925;
	Tue,  3 Feb 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpSyuDXo"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE430F80F
	for <linux-can@vger.kernel.org>; Tue,  3 Feb 2026 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131107; cv=none; b=RDmhHlOeycbZz65E2kJEn2bwbPWAZtRAfIU+MyIoAtD5kkV6ng7QdsQXis5r3IETtc28Jot9zGdpjJQ85NNxBTc9Ym5jFbaNFp1T3/alQub17gOhw6bvPjp6CcX+6D/wXFIP2ghPpAbmtPSXdRDZNqetUZp0Vxjj/S/nhvysENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131107; c=relaxed/simple;
	bh=dwdID4DDF4GDX1SlmcA+3fzCA+ycXbc62Ld/klzXumU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLWSMQiI96JkxPqNQ3udtTkueHKwAlNv97HHVnKbEBoCidkF2Q15EUQrJVlTbUCzxdXBYVXgNAFm2Red8T1Y/8S/iws9zo7a3t6EOEz8u0CPutITTv9GTGfH61K5asIFziQRABEw802z9bdC2yY2InHBI8qMCn+iOSPHdN/9s/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QpSyuDXo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso9941730a12.0
        for <linux-can@vger.kernel.org>; Tue, 03 Feb 2026 07:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770131104; x=1770735904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9PNsfQXg9zjxapzMuZRa/zLzG4m46Jh75ILxmkVsiiI=;
        b=QpSyuDXo4abof9JkO71XCU0L++sL4W1+wPJrJo7W48kuy7WOXHhZrQZj7eTlkvPt/r
         3EF48KIYISJTJf0dVDzcU03GLcWVwnutn/ZqKxcZWAIvyGfGJbH3OQmEC9zHKVx/3eIv
         1uTifqNKiZLo622FwwQET8TQ9CzNqaLQbpqlEcTxtTxdcXJpFnpeRmlk+U9QiLi9D9x4
         4SSHT3da5CfLVETraR88yINgZJ8QN233j/EuMTgUZme3bzkTwEAgE896M2Wge2tCYmS/
         9zB7LE7l7vP30fslwT/TUHL8yBp84Ub2EbiZOUWsX6FuvpJiKF3eF8Aavz8x1Ey8WR1o
         P/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770131104; x=1770735904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PNsfQXg9zjxapzMuZRa/zLzG4m46Jh75ILxmkVsiiI=;
        b=GowNsdfWjrc0RisVIb1JyrPUTOtlHGoruNux76bkhPgUcLIo9EklmiZEXjRCuTLF47
         6FyT4fyxRuEY3NwSCAIwnvkRBEZT6nJgFGhCQtp7Nh/Fm0vILOLw5uosxeylhp38bua3
         bRw9bANJIIUq3U+l2R4iilZoN15GIfN0L3HFOituM1gUuYwkhMG9wcibv26p+TdXtMwh
         eW2dvujyZLZr4TR8RakFTZacP1cw3m5Tg8HznRvX/8Mj4iKMu8aJL34vxAXPkkynd25G
         hG1kTrWkpAAiZNQj01hD8KYptjazVY91nlKeckunhiLyi6ebbDLJqeuoJ79HOYNq44DN
         wMIw==
X-Forwarded-Encrypted: i=1; AJvYcCXlud3G3BJ1Zl0ZwYnay+wNXDWGIkEV9cHzqFs3cO34FU4VQWrh+P6FDV2wAdJKQlBoSdkKabKrNns=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmr/RQbWqF4pcsMzXkw3h4+qG0zBo1TL7j72QzdMDdWlQeC7kU
	DuOmYTPnIDloAMk5gpmx9pivKT3zJCbQpSnwaf8BE/zGK/wq1lbVFHb0fs0no+gTM6o=
X-Gm-Gg: AZuq6aLyfPY8BjhNmB5yi55Bp/EEPWHWY81yo0QKcY6Ng5BsLUrJOx2Uvyv//9Jbl+U
	W1cXQwZ7TH0kkHLSAVmgtVPd7jpMfabEyvLw00T4nqphB4SFV2OWQmrqMkffPpeCOLi2lwkIU9F
	UlGhb8/jf0NIU8CPq2Boi7eBUgRO8FoPablmMUnXWXu8IjxGtQ264eip9qEl4xOnmeut4MKvH5w
	nGYPgBxnGc6UnsE+Udz4PiekMrQOjC8bOLYxV62kejmFrz3zLN7rNNjqGj4cII06svi1x4Js1r3
	cImYzFm8tQcQjkPNrQcxdIcT/onwc9kDj/bN+iN9bg1V/l6d9GhrgZnUXnnFaJX36AUI0IBzCIa
	wVLlNjapokvbct/CV3M1uEKRMhki7sP0mOslrrqsVJEuQvat3ZJfnDlakeHoIW6G7C0y07Aijak
	Oms5laKRfMNl7dc+J+
X-Received: by 2002:a17:907:96a8:b0:b87:65c5:602f with SMTP id a640c23a62f3a-b8dff7a30a8mr1000149366b.34.1770131104069;
        Tue, 03 Feb 2026 07:05:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2ed6f8sm1049398466b.65.2026.02.03.07.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 07:05:03 -0800 (PST)
Date: Tue, 3 Feb 2026 18:05:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Message-ID: <aYIOnErmiSZ6wnP1@stanley.mountain>
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6478-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:dkim,stanley.mountain:mid]
X-Rspamd-Queue-Id: 05473DB26B
X-Rspamd-Action: no action

Sorry about that, I just looked at the implementation in linux-next and
didn't read the code from the patch too closely.

On Wed, Jan 28, 2026 at 04:46:10PM +0200, Josua Mayer wrote:
> +/**
> + * mux_control_get_optional() - Get the optional mux-control for a device.
> + * @dev: The device that needs a mux-control.
> + * @mux_name: The name identifying the mux-control.
> + *
> + * Return: A pointer to the mux-control, an ERR_PTR with a negative errno.

I wish the documentation for these "optional" said it could return NULL.

> + */
> +struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name)
> +{
> +	return mux_get(dev, mux_name, NULL, true);
> +}
> +EXPORT_SYMBOL_GPL(mux_control_get_optional);
> +

regards,
dan carpenter


