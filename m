Return-Path: <linux-can+bounces-6513-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOUdMr6wiWndAgUAu9opvQ
	(envelope-from <linux-can+bounces-6513-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 11:02:38 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 265BA10DEB1
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 11:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 690803011588
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63CA326924;
	Mon,  9 Feb 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHe4hmOl"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255543093CF
	for <linux-can@vger.kernel.org>; Mon,  9 Feb 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631067; cv=pass; b=W5GZg2vdt+V5u9/hexf/TdKsP5CuFLvm/maWKqS9xoha4uMxdWJ566rNBL+qnuZXvqAtHuQRrQrwww1cFRKoRbYcAiDBoeNhErzqW71G1yaJ7NeM8b4Q8R4v3qgRm0uci0NFxG6nA1kKEVDuCPwVMGQvWkzjjGv/xOajKXqJxHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631067; c=relaxed/simple;
	bh=bC10K83OlDdfvr2htwpjLlKwvpR995Jtaa8b2VaNWRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pelnN6p0TO+3pxMJzpSjm2UEZPDv7RxWymocfdU3PZkP2rdiTIG5fZ+S2hPPvXhNfU19UJvI0eKQjTV6JLCtI04APcO9ywf/yKYQXUB9wQfzod0+gyvrZlRjOGCReagSJIdj/Uffibwh4T3mTAJdLGW7OXhuXsminVq3eakNuZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IHe4hmOl; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59deec3d8dcso3874595e87.3
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 01:57:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770631065; cv=none;
        d=google.com; s=arc-20240605;
        b=SBhgzA8UcM3iSy4Y41QZ72BgKe6h/9LHXvV0PF+z74sciLo2mRZe895G+AwAgvvyKH
         LTzgR33zNXjofyYMbCQE1N7A86Xb45sN0QvO0F8fMZKM4+2CnNpXJvQgtgpzuZNkRG10
         aNXR5qTgOxosYzlQgcVZ/tMS9KNQOG7YRNpXymPfzt9vfNaxBqdEukgpJTSv2iVc9R1o
         KX0oYDWJotk8YVHjLSQZzU4bmoJOyoj028d8j3Ncuj4aUMxRp1MIW780cLL5I2op2J0d
         RDsoXUqFeXp3N1JUaX7oQgeZrPxRT1Zv10YNZYx3CtCBiWnpnpGq5K6YLC4SWKXA430y
         kaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fzG/baFh/xjTaP0Ii0cvwWmrEVxPL+eR3yu7Xbk6kuo=;
        fh=EhO73IsTZ6mXEGflh5GLjw5gxqY0fuia846u59RKu5A=;
        b=O+IBJmL08jae/3HQSj7WQKgUIri72oyRc7q9dRta+yVBAMg3eAGYcSry89VoX+gnfa
         wwqGWpSaLgYdPErFpYxWLK3UXRvJ8XoM43Q0odKPg7XF3tr+GgcgH1XO2tzc5riWUCpi
         6L0mcimDOpDTTs0InNTZp88dJzEbxcKzKhwPofpJL9lE6ioBnMwkEhawHd7QGy4siK3J
         Yhvog88iW7hzud9M9qlImoKEyNkDuurxP/n1MmX7wmqQqdiDD0sn/L3dhvDWHouoJGOM
         t3eAP/kreKxZ2mAjdVEInW10gjUWUW6zc2q08rAOiB2gWdchf4j+j8a4lX0Vwp/9k8uL
         r3/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770631065; x=1771235865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fzG/baFh/xjTaP0Ii0cvwWmrEVxPL+eR3yu7Xbk6kuo=;
        b=IHe4hmOl9w7pUpUQyLkq/OgztYofxuV5/j5kZqVf8IuLW8jsfSkKju7oFLOuFmO+Ok
         OuFB7tI5XhFwXmudwca2G0nYRBQ7eEr59JH2p9nQqOTDdW7Y2gLLMsCnKuWV4LpK8sMg
         QEhJgWugZkGH8AlPG3KIjl+KmD0zJUnuheHF85f1h7T24sKIswi0tGubJyQrgfXVOHcH
         068szk1RA7QB0OCEWzd4kP3VEp4dtKPFLkidYA4mXBpOOysC+6s4HXG+8zne7P8+mUJC
         0JfCkcMfokYv8neInNUS7ZSf0KHQvK4NmCQEumO+4rTfN36qUquObsdAu9osKWCZSwzx
         gwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770631065; x=1771235865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzG/baFh/xjTaP0Ii0cvwWmrEVxPL+eR3yu7Xbk6kuo=;
        b=GSmx9jighl3rU3W7vIo3iTjLr5hvIP/AfBDHdBhE0OrfQ1fk3wjRa88oMwJPKgsS9s
         PNShTbK/InMWN5SinLZrTqN+1fMTaBuGDcCvGNuG3Y6owvD2vGaWXuF00EKhcBUkssn/
         K9SxwbjbZlGgYPV2WGXnckETFEFPXM9bJd8Z6t2bPokRE7Kkf8YZe6mg4THk3SLKy/H7
         FcVTzn2aRvtSUhfuXKCeLs8nk18LXbVCpVpF+RJsVVWAontdyDDf6RQLqigwYcNs2yC6
         OKfgAk+VvZjPyz9iVxJSib+b9ayWdtBs8X+wTRrIVJWLNVvLiPgc+dlPpmH73SrBA5hh
         ejdg==
X-Forwarded-Encrypted: i=1; AJvYcCUvMPp5dNQK2szfAy6TllptKukt/ozvy75UIuq7uIYY1fWalJFhPrZ7ugdiAmqpWGxlpZk7tt20wxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWawXJ0RpIgImnGBrJcsIeFoXRmUsKX/k7cWSq7mOSkChmHJN2
	WOFRF7kU80jpcb8fMI0evyjnEdl727jieFJKZTJ6GYCak/TCH5hQb1tTW6BDJ5WtD+2FL6xhqkD
	Gu9i+1UVAwURNxUSNfGPyZJXZYwfo3UDnxoq6PKyZNg==
X-Gm-Gg: AZuq6aK3EpzK5BgqqhgKnSe7HCiGbD2Vn0TIhm9BhWybhNtExmFxkfFwdVD0VrDQrF9
	Vez6HG9bdEFR7GrIg7wOP6Wo8GCGSdYCSpX8klERLkuU78X7ef/HKufGfKYO1ZBtXcSx5ArBwEW
	b19Iu/rran6Tq7vFamDq+9IJRqp2vDBcP8miv4CuCk8hiCnT3G04NCB4xvGeV/nqanpPq8I3FGR
	6KOFS5VNqWcupAM/rpesWNiPosHU64DolKPPVZXIWbwEqVKZ7P6GQSyUI35kLHtnfALOKum
X-Received: by 2002:a05:6512:230e:b0:59e:25a7:e46e with SMTP id
 2adb3069b0e04-59e4517351bmr3165761e87.36.1770631065180; Mon, 09 Feb 2026
 01:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
In-Reply-To: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 10:57:09 +0100
X-Gm-Features: AZwV_QjtuvXehDumL81rfo3XecEhBGMIVZdeTW9qGb9n_Rk2fTCxSh0YYaQSYSY
Message-ID: <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6513-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:email]
X-Rspamd-Queue-Id: 265BA10DEB1
X-Rspamd-Action: no action

On Sun, 8 Feb 2026 at 16:39, Josua Mayer <josua@solid-run.com> wrote:
>
> Some Renesas SoC based boards mux SD and eMMC on a single sdio
> controller, exposing user control by dip switch and software control by
> gpio.
>
> Purpose is to simplify development and provisioning by selecting boot
> media at power-on, and again before starting linux.
>
> Add binding and driver support for linking a (gpio) mux to renesas sdio
> controller.
>
> Introduce generic helper functions for getting managed and selected
> mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v9:
> - compile-tested on x86 with MULTIPLEXER=m/y/unset.
> - fixed Kconfig changes so that CONFIG_MULTIPLEXER can be selected.
>   through menuconfig / .config as intended.
> - updated trailers
> - document null return value for mux_control_get_optional.
> - fix build error for CONFIG_MULTIPLEXER=m, found with x86_64
>   allmodconfig: replaced ifdef ... with if IS_ENABLED(...).
>   (Reported-by: Mark Brown <broonie@kernel.org>)
> - Link to v8: https://lore.kernel.org/r/20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com

[...]

I have already applied for v8 and it's going to be in my pull-request
for v7.0 in a few hours.

Please send incremental fixes on top instead of a new version of the
series, then I can pick them as fixes for v7.0.

Kind regards
Uffe

