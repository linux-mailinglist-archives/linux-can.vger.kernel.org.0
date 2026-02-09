Return-Path: <linux-can+bounces-6529-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DDQAHQRimlrGAAAu9opvQ
	(envelope-from <linux-can+bounces-6529-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 17:55:16 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ACC112BD9
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 17:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDA9D300C016
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CFC38553D;
	Mon,  9 Feb 2026 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bd0YslLZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845FC3815E5
	for <linux-can@vger.kernel.org>; Mon,  9 Feb 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655835; cv=pass; b=ecDRsFRl15BpKc7N3oNPZkgjYn5BUVLL0Otp9VPwCpVWeVP9OllfT/ubGFN35/RZe5PMmJbKtOQoSpruUL6Hc2DUeuusorx1ZZe3eHRnBtc3WlZ332VeL6MgTBPwSEH6mKSdO91a2WX8KqKdw1y1YR6eBYPk5vJzHdghBgHEQL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655835; c=relaxed/simple;
	bh=MKH/BMQo6ZEQSBfwPQJ1yEwPkvmRFNFDphLlhHfoCFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhYbtv3Rr+Mk1qiP7lF8ZgeEoLLZGUDDra6TP4yziBU/2ZguxSPhtqnjaeb88PRPmK3DEqnGbra4bOWP3fU8M9X4xCYUF2gBeicIm0hB0S/4ZLae4Wgc16PKQlMEhugUGpfX+HLqHhj//Wi/ZqpUQFnDQD5xe1GlBTO+8oaYpeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bd0YslLZ; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59dcd9b89ecso6271989e87.1
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2026 08:50:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770655834; cv=none;
        d=google.com; s=arc-20240605;
        b=bijSgNjtokZsmE/uD7NG/KQxok7IuORrK1JaKfCWzLSc+y+Npb7abopePonr6FwwFE
         J+c9a/DByW4GCP2Ebto5pdauyXxFmVcZKvM5KinbP136zGLkhVgNPtPtMEqotuoC57jG
         ijC/fhD0w2w3tWQ5UO8vOtkLJpRWlzI4Pupk9eE0XYyGXGzTS53MN9w06XNStAZVap9w
         ziXfLGnFX7k4Wr7Qfa3ygvlLP8B1OmgYBhGls96iko1fj+4JXTQc60DdWXbh3ELw27i5
         fH3FDgfU9lvLZDXT+cv8kBFEESzEMuUPLVNwe6FB9yOZWaKbHootBR2sgoLpMVfSDd+s
         r4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MKH/BMQo6ZEQSBfwPQJ1yEwPkvmRFNFDphLlhHfoCFo=;
        fh=FMi3xgAL7XvaxxFmhb6SfEPjhZWjJLkdaPtywiFQ0A4=;
        b=iEv0cnV/3o0QMN9NhEp4Idor49n0NUansjjfx+Fg7Iu5i49Bu4uYr1+0AXvDDHQZxb
         macSRuJkjQfqgCHkkzZMdMesfKPtsV7bjdYV5IqKeU4KPpE0jjRbVz3Yql7mWY1QF2s2
         fUdBmDepL96Du6nyYWR2s3ANo6LYPPfrSh4f2jXqfpIvewMyOHhApfm5KvmERxp5uu5B
         tWI9MPdSG8HNoFmszgXKwlVsK4PeRvZDWn24D7Ubh9laDPZScBzIeXXBtIzuZvBmhkwo
         Tol+1Wn9ApwgtHG5z3jwQtLGvmo5W0b7uJ84+wrU4j3vfbcWqN2u/gS4ebqRj3Aezmql
         c60A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770655834; x=1771260634; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MKH/BMQo6ZEQSBfwPQJ1yEwPkvmRFNFDphLlhHfoCFo=;
        b=bd0YslLZKFA0AqfhMWqkF0xpNqGgg2NKEmE7dE2cye2xsPGqBNkqik4BwkSEsPb9eA
         nmauDKs8yxZKLTWYzQ3zMRZBypPs/rkVsf0jrVwUTDQ7o3nBTbDlTi/sTYLKlWXUfvXf
         azMBwgthmeVHZFNXpD13gofK/nfZ2jxeTCpMnE4XgZerDqBXRZBwiU40lsgxicdtvkQ3
         pL7QVnig1G58pueOmntY9CtGPK2RFFeC2PWIm76NoizJ6N1Kr0rp10P6MtpAhECKIamt
         YEl+Yl0dURQc8xGoLQPKJqm/CzJffy+0McPyxe84oZdODzuESF4mnq01EM3yiIUzoIIm
         hHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770655834; x=1771260634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKH/BMQo6ZEQSBfwPQJ1yEwPkvmRFNFDphLlhHfoCFo=;
        b=ealLqOcO/TSherIofubF0FnMlGqzUgu7WIxlkXoBr6a2uBYpFM2LGJFoDxffhN2niR
         vA7rya2PDNSv/T/uWnr8SvU/dxoWCOglEW7jRM00b52TUctYZiEoi6yOacDNlACHKQme
         aw5R9eDcvQnnVfUXkfLTWPzj3RfK0EGhZ8bFfux4msihCvtfeFABBZBPGM6cMFoQeO0C
         hZC3beVmxlFJYagUe8Wwrt8T40Ku0ftR8hqbzULCia+KjmKYowAzy/5bPB1Pvr47Y/gv
         /ST1XCOWKu3XKL1eKeZS6Mg5UJA0yCikXDYacQ/8RWCo5mlXboH4YQ+gztmbSwUHJdnV
         6tfw==
X-Forwarded-Encrypted: i=1; AJvYcCWQztz4ex2Uo9pOYc0r2Vsy1ieHylmUBi4+OZyJwRLWsSpseTi9eY/tBZiPGlD1HQ+P7JmthTPQN2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUGv7u0SMSBlJRAhk/jispxsrhvsof0XZI7JvEE13akg4ydfeq
	pP46PqeoDP3CfsXKjQcmnfoSD/5jFzfuUb1gh0fADH8RJrIyKOehOg9/Qzph2QbWSsvYX5RNsua
	CpBIsui6dFb4LxjhwFLwdON3yUtMZIjXkN4HjiAoqeQ==
X-Gm-Gg: AZuq6aJliDoclY+Mz2MmMaxn/8gEId2aEoUdekh/nOQDYDANq2kN2xygXlcxWovqvKC
	lMdNlMW0qUzLDR97QP9WIXoETUWDzAOPjl4mAGZO3ZsrEYLgNX6/1J0R6EwjGB65k5itsLsSKfb
	PdTohSiD2fZgO0d6XER7HeG1C0c+v9O3tydpOpDviOy71oLcpBThddRKjUrxaT14GpEMJpVQbKP
	mVVSN1KX/C6uAXSYh9gxeXvxq0l5c2Jsti+1eBVMKSlICY1XxJAOIUDrMwp0xs8mqQR6sk5figv
	LDfAmoV+Or1OiMtu/uYjzzqO4O7s
X-Received: by 2002:a05:6512:118c:b0:59e:4d85:d82d with SMTP id
 2adb3069b0e04-59e5437754cmr14477e87.13.1770655833649; Mon, 09 Feb 2026
 08:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
 <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se> <CAPDyKFo2Zm2LKP6=m=fJEbo1a2ZpBn10EGaucFS7zGfGJV_6tg@mail.gmail.com>
 <793644d5-4d4f-8ee5-7fcc-369536801683@axentia.se> <CAPDyKFqCveBs-_VcWCm8OCegbpwnW3=0iGa2e5KUNmSy3TMA+A@mail.gmail.com>
In-Reply-To: <CAPDyKFqCveBs-_VcWCm8OCegbpwnW3=0iGa2e5KUNmSy3TMA+A@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 17:49:57 +0100
X-Gm-Features: AZwV_Qh1nXgInou2tkuYLPeqnXQDy8RDhZJ2fx9TuiqfqWwczkYvBAKEQ3MJW4c
Message-ID: <CAPDyKFrDLEzKrFY0GeevptDdRe7JAUzXgqM7fVtQ_PnYDi+N_A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6529-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,axentia.se:email,linaro.org:email,linaro.org:dkim]
X-Rspamd-Queue-Id: 54ACC112BD9
X-Rspamd-Action: no action

On Mon, 9 Feb 2026 at 17:48, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 9 Feb 2026 at 14:50, Peter Rosin <peda@axentia.se> wrote:
> >
> > Hi!
> >
> > 2026-02-09 at 14:39, Ulf Hansson wrote:
> > > On Mon, 9 Feb 2026 at 14:16, Peter Rosin <peda@axentia.se> wrote:
> > >>
> > >> 2026-02-09 at 10:57, Ulf Hansson wrote:
> > >>> I have already applied for v8 and it's going to be in my pull-request
> > >>> for v7.0 in a few hours.
> > >>>
> > >>> Please send incremental fixes on top instead of a new version of the
> > >>> series, then I can pick them as fixes for v7.0.
> > >>
> > >> Hi!
> > >>
> > >> Sorry for being late with this, but as the mux maintainer I'm not
> > >> fond of
> > >>
> > >> 028ec00381f5 ("mux: add help text for MULTIPLEXER config option"
> > >>
> > >> and would not like to see it in rc1. Can you prevent that some way?
> > >
> > > Sorry, but my pull-request and branch was already prepared.
> > >
> > > Please send an incremental patch on top then I can pick it up as a fix
> > > for 7.0-rc1. Unless you want to manage this yourself via your tree.
> >
> > That unfortunate. The patch series has not yet made it to the next
> > tree since it has not seen any updates the last few days. What testing
> > has these patches received?
>
> The patches didn't make it to next, for some reason. I queued them up
> last week on the 4th Feb, definitely a bit of a stretch to pick them,
> I admit that, but I trust Josua to help with any kind of problem to
> show up.
>
> In regards to additional tests and reviews, lots of people have been
> helping out with this and we have also received patchbot reports that
> Josua fixed too, along the road. Moreover, the first version of the
> series was posted already in November last year.
>
> As I said, let's fix any of the problems on top, it should be that hard, right?

/s/should/should not

