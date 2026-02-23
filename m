Return-Path: <linux-can+bounces-6613-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNUAC9tZnGmzEgQAu9opvQ
	(envelope-from <linux-can+bounces-6613-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 14:44:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6D1772DB
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 14:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FF75302FB1A
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E4023EAA0;
	Mon, 23 Feb 2026 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mn6By/yF"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6444822F177
	for <linux-can@vger.kernel.org>; Mon, 23 Feb 2026 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854287; cv=pass; b=ZlgVxpdbnDLM4WPiExreprmTt01tuxVTzH5LNOA4k5l/ILDMrY5Fz8GwzCXsYqwCR4waIInvFpDKOQj/GgyQtfSc34ULBUNQdPKnxI0XQ+dvRnWU+JgoTrq+aYD5lICp8MSk3k7MtGaj25cYQrw39hgK1k1CfSvoALjMlSGWGMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854287; c=relaxed/simple;
	bh=sR1JFSsAon01OtvSAsV6/RGrd106y8rHwXlJpuS8MH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPj4CUG6qg2GjhD21clmtGicp13AI29R1edd25WSTiacOHF+ZOek69AAPEMknKsIcAcraKevTtrV4Nz4u1PHEFAhEVfVipvtrzB/yEK9iBEngiIf5A+0nDwxJuz6jnRD/v8IWggEMyEY5M6x0bCbNbBbeKLQ7ZKA3A3PjNb2oqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mn6By/yF; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e4989dacdso4476980e87.1
        for <linux-can@vger.kernel.org>; Mon, 23 Feb 2026 05:44:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771854285; cv=none;
        d=google.com; s=arc-20240605;
        b=C/ZFdIwznjYkCp4fNs9hqqRFzw/9/+42SPn7ADgiQ0IrP3paOJLRHp9CbvS2SNyvmn
         2JziZkz7s68tDPkyi1yqDRXaFSqvHGTZdC/1E1DQfXhxrwT+rrRl6GtAWHKAsIA2J3Xh
         kZ/XTLczcvV+E9pHlhWCmsfjmFa5t4ajnbZeJLcDQ2gwoB9iDhpqfRj9/7WCThiAV4S9
         Zdfyaav0UAqfk8eTlzg0sXYGVdIwKWljLvnrU0DvG8npH58vtGS1wfT1VGH/jXIlq9aQ
         oZQ/1wlp5EBQu1bOxo4kS4vcqm72yrCNqosF8dyD7y3iq6VrhF1I0wN0y89buhHmM9x1
         AeBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fhetx7uwtFJRgRkUexEhKn5KeWaKODjWdb8CIbVt7HA=;
        fh=ZMzpDqgNYfq4er7EFMo+kNYFGnQZa3wS9QzNh6+INeI=;
        b=GhkUo49WlRU496PUFmhYVVDwrIQQ8qxM0O3+Ley2m5GMlg6rnou1egpk3IIXXVNkcC
         RRdDldeDtSkj9WPBtzJ7hGsOZV3W7EG34rvp+48Fg1TMAcwGBpnl/h+NJ46CXV7Qqkt7
         J/kHmcuPZQRH+OA6kCrdgyWs0J81ZcubGR3hd1h8cE8kmteIgYS0/bI8Ou3Pm2rlG9fk
         pEVczlqUDqpzfDE3Llgpf++DrBprFPjY9ge+3ZwvWt6BGk0d0sxE5fYwGQE8DDVkeylt
         kRJKAXxK8HInVx1RF+7BKCUQBsMgprnbwc1wFrOLUEc5xln5h8DUaReyCptsgrXJy0hj
         7zgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771854285; x=1772459085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fhetx7uwtFJRgRkUexEhKn5KeWaKODjWdb8CIbVt7HA=;
        b=Mn6By/yFk66UzcpBhl82x6Y1icrzzwKx9TUqEq3avBMnSHH/WPGJyCzaC3X+5e5n2K
         7bDTmcVGAZib/lFAPpQS4zMhkeXu1HrYYx1cv3XLXC2baXFEJz0XfoQAvyESmb3L+kov
         m8dOcBWKh0Nd9Dk0z+OBiGcWj3EDk5E/1l49nKJqzfTmM0RsHFeSxMB2oY8IyO5gUP3i
         9tFtVAJdHs0MvdjgqSktkuXY9C5WkZah8ldRFmKDb+zeQaNPVhQ1wVnpYdTyKVqJFi0z
         k0hdwI1KdLLql/L472glJMnAZ1CMcfcaaKq/2ndxHwGkyetsnWfyB5b+Zi5aQxebeWze
         YszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854285; x=1772459085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fhetx7uwtFJRgRkUexEhKn5KeWaKODjWdb8CIbVt7HA=;
        b=DK3tnYGFUgaPpKAPC3mBPh5b1vmu5dHZgs0Sf6n46KHZSiNf1yHXwtLz4TUfJubnxb
         ATYRJbYyLSm9VoVt3tPMYhzT+pfx7a4fPiM5lC53jv4h+i4l9WJioob3dD/DmTHomaPJ
         N07FRvdpWA0UNI29odkbROvmxqlDa9t4HVHVaO8lq8ekD/KYp8UQHcEzxIjfXGiPUJ6b
         +Hm7kTLWblvnG+63ZTc9QJey/oU+i2COPHy6KTPvxsGKSOBxxL7Jys+QLlI7a3zeTDEn
         Nu+6yBykClvF28UAYdhQ6qrKbYl0aKybhQj0IeYcONd34v2qAd6hWtF4jtVnyAqBU+h9
         x8DA==
X-Forwarded-Encrypted: i=1; AJvYcCUHAziyO16y933Sad7QtQfJ8EzbjpsYEGA5tg6gQrfIJMqvMPjVDnfBlWujuUMXUizAIvsVgJUzYqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhZaXcjrLDHH/j/H1w4m+QDj7JfKZKLNjrSTSxOXTb7Q9kyu8A
	eSIC84U4Yj8Jd/cZHx8EL9XCjbwd6OV2LmZ704gLCdeAej9kRi0rrrrKmRXQ1jH3jqT9k/6msY5
	aQfhYh8HEAAOfSzDrawVxYtNIebQsQyw6Rxoq7hTGog==
X-Gm-Gg: AZuq6aIo0vEboiCMe8DpfrWozsFlFxybEjCgz5WHmewtWcQ6jeez5dXzJG1jDO5Zxd4
	BEmKHC5DNEBinyOCAKZUtkBAcTq4omg5NZUHwairyoUjBOHNelMgTrdcvk0bjOpJT8rd51t3108
	W2PwSTEXqHSui0dqaMmtlXAPPxYLWDLzTBR1H+odpLhXTRg8jR3MQ+G9agaXDrurQEI/x47wlUW
	jYyFj1hkUCeDGg/2YJwuNfStV5XYtY/tNvNmZQejd0XBNJudAVLukmccuFc2LUiw2SrgHTb6Lrd
	3IM3zeJl
X-Received: by 2002:a05:6512:318f:b0:59e:63b7:585e with SMTP id
 2adb3069b0e04-5a0ed99f1fcmr2755602e87.36.1771854284344; Mon, 23 Feb 2026
 05:44:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com> <20260212164823.mbeycqwzsy2dfq6e@skbuf>
 <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
 <f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com> <20260216092914.kmvl7aep7dantcsd@skbuf>
 <20260216162406.0121dd91@kemnade.info> <203a36fb-6ac9-41f6-80ce-b137b9db4ad1@solid-run.com>
In-Reply-To: <203a36fb-6ac9-41f6-80ce-b137b9db4ad1@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 14:44:07 +0100
X-Gm-Features: AaiRm53IT_Xzv6_ZjZsPbjTua3wzc0_3fH4fOJcUrcKMz5LLxYEEUcMyBCE8pyI
Message-ID: <CAPDyKFrtTaJ5fqqbGrE_K6SAdTZYUfp-BycGjtWs4SabwBysKA@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
To: Josua Mayer <josua@solid-run.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Vladimir Oltean <olteanv@gmail.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6613-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kemnade.info,gmail.com,linux-m68k.org,pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,baylibre.com,atomide.com,ti.com,glider.be,sang-engineering.com,solid-run.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:dkim,infradead.org:email]
X-Rspamd-Queue-Id: BCA6D1772DB
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 at 13:44, Josua Mayer <josua@solid-run.com> wrote:
>
> Am 16.02.26 um 16:24 schrieb Andreas Kemnade:
> > On Mon, 16 Feb 2026 11:29:14 +0200
> > Vladimir Oltean <olteanv@gmail.com> wrote:
> >
> >> Hi Josua,
> >>
> >> On Mon, Feb 16, 2026 at 08:19:27AM +0000, Josua Mayer wrote:
> >>>>> In the future, when you have a series with cross-tree dependencies,
> >>>>> please try to think of it as individual mini-series for each tree's
> >>>>> 'next' branch, and specify clearly that you need stable tags (to be
> >>>>> pulled into other trees).
> >>> I don't really understand how I could split my series up to avoid this
> >>> issue.
> >>>
> >>> Due to the fact that one (and now two) drivers implemented local
> >>> mux helpers, to undo that an atomic change must be made tree-wide.
> >>>
> >>> Meanwhile it must be avoided that while the mux core helpers are being
> >>> tested / reviewed, that any tree adds another driver-local mux helper
> >>> like appears to have happened here.
> >>>
> >>> Note that my patch-set did go to linux-phy@lists.infradead.org list, too.
> >>>
> >>> The second challenge for this series was that mux framework is being
> >>> enabled only by drivers Kconfig "select" - and not possible by menuconfig.
> >>> This is e.g. responsible for being unable to test =m build with arm64
> >>> defconfig - and lead to it only being detected through kernel robot
> >>> x86_64 allmodconfig.
> >> To avoid this, a combination of developer due diligence + maintainer due
> >> diligence is probably required.
> >>
> >> From linux-phy perspective, there will be some automated build testing
> >> (which did not exist at the time of your submission). This would have
> >> caught the 'hidden' devm_mux_state_get_optional() call present only in
> >> linux-phy/next, when testing patch 2/7.
> Excellent!
> >>
> >> But, to work, the build automation needs to be able to apply the entire
> >> patch set on linux-phy/next. So expect some pushback if it doesn't
> >> (hence the recommendation to send a mini-series to linux-phy first, and
> >> request a stable tag).
> It would help immensely if there was a way to get the patches renaming
> driver-local conflicting helper-functions very early, before anything else.
>
> Would this sort of patch be acceptable in linux-next now, so it can make
> it into v7.0-rc1?
>
> If not then that mini-patchset would be the first one I shall submit after
> v7.0-rc1 is released.
>
> Then I can treat the actual implementation of the devm_mux_* helpers
> as a second standalone patch-set.
>
> And finally patching all drivers with local helpers to use the new global ones
> can be patch-set number 3.
>
> Any opinions on this?
>
> > I do not think that is at all the duty of the patch submitter. I think as
> > long as every dependencies and side effects are documented, it is IMHO up to the
> > maintainers to decide how it can be merged best. They know best whether there
> > is any danger of conflicts in their working tree because that is an area
> > where people are working on. Especially this patchset is around for months.
> >
> >  In MFD where it is
> > more common practice to have cross-subsystem patchsets, once acks from
> > everyone are there, MFD Maintainer creates an immutable branch with a tag.
> > The maintainers of the affected subsystems pull it in.
> This seems like an option, if I can get the patch-set (or a partial one) ready early in the cycle.

I agree with this approach as it should provide less churns for all of
us. Especially since the changes to the consumer drivers here are few
and trivial.

I am willing to help with hosting the immutable branch (unless someone
else wants of course). Once all acks have been received for the
series, I can set it up. Then other subsystem maintainers can pull it
in if there is a need to avoid conflicts/build-errors.

Kind regards
Uffe

