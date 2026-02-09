Return-Path: <linux-can+bounces-6528-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCoABSERimnUGQAAu9opvQ
	(envelope-from <linux-can+bounces-6528-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 17:53:53 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDFB112B8B
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 17:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 506B6304914C
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 16:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D243859CA;
	Mon,  9 Feb 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fp6d+grA"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD63859C4
	for <linux-can@vger.kernel.org>; Mon,  9 Feb 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655747; cv=pass; b=EztUCwMK4b61NCKf1rWNrm+F8jPn2/TMj8N3FP81Uxx8L4kC/eoANSXgS+LslcLHOEgjh1CiuqJYcaeVB2mBJs6AMbkhyqsBj/mmzHh/86iRIwAS3zd2o3RGb1FlzYNItxMYTnxP4OgoZLnRoHR7oCU0zCasboss8SSyEnyJMx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655747; c=relaxed/simple;
	bh=e972ACE1KBb81KyEkGcx+64PEjeQZgX4SBpIgZiZ/gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SC9jicYuA3cjaJPjraW+Q6S1beFPiji8CKVYNzofEjTznsprxQav27NxR5s4lulyo+thUIX+0j1lkJveM0+knDIuXRcXcfuNDU1ZqQEVrqXCPxLnsz63dVuOAac/Qv14hzkAYQcCvDRAtPa0/2SU2SwSnxaNASCdikRv5ngaJTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fp6d+grA; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59de6abf324so3848937e87.3
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 08:49:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770655746; cv=none;
        d=google.com; s=arc-20240605;
        b=GqACbOVCOpyFfrWnyCBFU+XYV+4wAVr+zDG106O+bfY6k9Po2fJiOADomfBk3/tM4y
         JsJNKgSwM6NVHjelW8NJzimH8rjpMnX1jQRqxHzcZOvyM/iZT9picvvbdwmJHkjyP8VH
         9G1ht1wa0Rmec3sVWp/vLvyRXtAozwIAnCv0u/u77QjS9UBHao8zvw6o18fK3eqZj867
         /vz9g5pXOkigJ2iB+ewaVYPI1/CZiCzBJGW+pbE9lWqojf+ZpS8UKxPbH0vKGxYQ1Fhu
         JjqlfOyjBiPobj0QP1hkv1H+4A2Uc/E1qpn+EEl891/VXkEmY5xH2jlOH4pGxLFtppd3
         GiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e972ACE1KBb81KyEkGcx+64PEjeQZgX4SBpIgZiZ/gI=;
        fh=9hJqgyoupLudlMgn6/JrsOEhBTmNqU0yPlFLUj0wANM=;
        b=hMwlUemVYjwuMXz05uu3k4qL2F7jriI6ha7zctY/1gNDDl6Enq1+qYFBoVddivQTfD
         QHAyYrCHK8/vP6d8iUCThWZfrdBRvIkb5MShRixcA1Z5Fnk9kwZRw7aI53mrwlxRF23T
         dNO19Sq2K5mhkkYEZvUhuShtwMZYT9RZDLwLqu7jiGZR3L9Yvl/xlSCh+Ace3tPSlNX6
         MHLOInIY4O8nhTUuMbXiSKb9LdMucGn0TJ35Q/kx/8aRb88F+g3wDtI2XiE/spgpDwQC
         nvryGFo9CPBrH8YNd8cPb8pgph6upVnjOIeWDp6shqLNiwqtpNQq+892CIxKeE9K5av4
         5AAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770655746; x=1771260546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e972ACE1KBb81KyEkGcx+64PEjeQZgX4SBpIgZiZ/gI=;
        b=fp6d+grAQEAUXI+9d4iDRz+MxzAqT7bV0sjxYFmSEfcykDarYrVxvozFsS6xn3NPla
         D13NVlYbrEpOUt6Fgfw2Hhg3EAQ3P5LztjmtSeVMKZrgLHpSEnBh+X4vcA0FiEvHsT4b
         GIt0L89iAoauEaCRY72qO76frNlCS72jtKXqSvbAwhd9hb6M+l/INDa9QADMeJCi6DSE
         jF1LrxcY7EBHBSDAkxKjszvskMnKrUpJEnuIV5xRQFSWPDNxQrrEP584vq2KsYwO+0jd
         3VDN+ewqwdYGbI6WqCFwWWsiHiH+9P2+ynsnm6YSFrvoYtKKWSJ0RwMSdbwVhRzTqyVA
         2MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770655746; x=1771260546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e972ACE1KBb81KyEkGcx+64PEjeQZgX4SBpIgZiZ/gI=;
        b=qfnhjGgBE0L9DjD/qYm8lJqdCqWII+pPdkL2Rbgi9KTekQJY3gsNNb8P8sYTb2Z3sr
         cP1MnYVEXXgLKHO1/KG1ucb4q1sie0Y7sk5FkBy4yyi+ABGK+v8trD1kCF/dQxWToM0L
         Ui2IkmRxEHh+GIDgdVJoPZWEaCYhcWKBa/3T3WPMIosS7VEFvat8ZlYVbGsxRLeu/sAW
         Ht4nm623IOTgQeBm1E61CgTUqNhu1Df3kvSsN7BHMhS3DneFsDM7pKPfc0vvmeXe/Mgm
         esuAsStgk5Bzb32Tio8TyXaGRI2QIfKpyLJBZf6woIXgWi9awW4DqaN1QWUcAyTh9WBg
         GGjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUSk0bTVsjSuNxS/6Ols3Nx6GN78oaWi4OMKatHG9J7pIK73yBSEx8YlUNdNIovdQxznAvOwksph0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYwtsFIPocldjmUrkqOGVy8iuIRNnJWzTMWjFUVwABd26iiMX
	RrITC3jA22S9DhQ+AV9/fJKmT5DPsOYNuoW2cXxl5qSD6HFptEkQicvPDSV1RQVbFmOtHtv9Jej
	1jFz1SDKYp3YvN9TsAzXEZxEj7S2smDtyWtBE6xKgqQ==
X-Gm-Gg: AZuq6aJi31xlBytE+6v7EfitRL4PCYk1Xu4ik3cd8YPnj1gVsi6/gPvv89rkd0w6Qrs
	gDEyUe8cGyebTKh+ZdIal+V9Xvf8WYGRIeQVgaNIkTbq59plQ/D89qDZBEplOofxHakYMwxrl6t
	3zOVJXdUl6YbecUtqsEtXo6wURXI1CuBeAfFqI/SKBMDVyeJCsZweBesk3+1YuKOqcz3y85GvVf
	G4I7z5NJHkl/+nL/lWLFEDhbeCY8yRHUktnZ2+zSjDfnWjnn9Pxl6Ib6tetLrpwvoLdvOYqQq3k
	+AqpVQlGG5qst6UX29Gbtp70zXtn
X-Received: by 2002:a05:6512:3c86:b0:59d:e589:c977 with SMTP id
 2adb3069b0e04-59e4515c13cmr3221840e87.26.1770655745469; Mon, 09 Feb 2026
 08:49:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
 <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se> <CAPDyKFo2Zm2LKP6=m=fJEbo1a2ZpBn10EGaucFS7zGfGJV_6tg@mail.gmail.com>
 <793644d5-4d4f-8ee5-7fcc-369536801683@axentia.se>
In-Reply-To: <793644d5-4d4f-8ee5-7fcc-369536801683@axentia.se>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 17:48:29 +0100
X-Gm-Features: AZwV_QiQvQ7mrYQqbOHRiTV98ZgKaltKf6NrojsLO3GMYCFwqcEgvdtufeaSCsk
Message-ID: <CAPDyKFqCveBs-_VcWCm8OCegbpwnW3=0iGa2e5KUNmSy3TMA+A@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Peter Rosin <peda@axentia.se>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
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
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6528-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-can@vger.kernel.org];
	FREEMAIL_CC(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: BCDFB112B8B
X-Rspamd-Action: no action

On Mon, 9 Feb 2026 at 14:50, Peter Rosin <peda@axentia.se> wrote:
>
> Hi!
>
> 2026-02-09 at 14:39, Ulf Hansson wrote:
> > On Mon, 9 Feb 2026 at 14:16, Peter Rosin <peda@axentia.se> wrote:
> >>
> >> 2026-02-09 at 10:57, Ulf Hansson wrote:
> >>> I have already applied for v8 and it's going to be in my pull-request
> >>> for v7.0 in a few hours.
> >>>
> >>> Please send incremental fixes on top instead of a new version of the
> >>> series, then I can pick them as fixes for v7.0.
> >>
> >> Hi!
> >>
> >> Sorry for being late with this, but as the mux maintainer I'm not
> >> fond of
> >>
> >> 028ec00381f5 ("mux: add help text for MULTIPLEXER config option"
> >>
> >> and would not like to see it in rc1. Can you prevent that some way?
> >
> > Sorry, but my pull-request and branch was already prepared.
> >
> > Please send an incremental patch on top then I can pick it up as a fix
> > for 7.0-rc1. Unless you want to manage this yourself via your tree.
>
> That unfortunate. The patch series has not yet made it to the next
> tree since it has not seen any updates the last few days. What testing
> has these patches received?

The patches didn't make it to next, for some reason. I queued them up
last week on the 4th Feb, definitely a bit of a stretch to pick them,
I admit that, but I trust Josua to help with any kind of problem to
show up.

In regards to additional tests and reviews, lots of people have been
helping out with this and we have also received patchbot reports that
Josua fixed too, along the road. Moreover, the first version of the
series was posted already in November last year.

As I said, let's fix any of the problems on top, it should be that hard, right?

Kind regards
Uffe

