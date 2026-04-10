Return-Path: <linux-can+bounces-7362-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHwFAg3K2GktiQgAu9opvQ
	(envelope-from <linux-can+bounces-7362-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Apr 2026 11:59:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF9D3D552A
	for <lists+linux-can@lfdr.de>; Fri, 10 Apr 2026 11:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD1423004D3B
	for <lists+linux-can@lfdr.de>; Fri, 10 Apr 2026 09:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80723AB285;
	Fri, 10 Apr 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rErJRG4Z"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653AB3AA4F5
	for <linux-can@vger.kernel.org>; Fri, 10 Apr 2026 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815175; cv=pass; b=hYjGcFtFBRYY3jspY/oOvjc7qOwFXiBSLmVYojYNO/Qx1t39JtBMcAE2vfL93kTqI28lon0XNVnhO60yxZhRbmdwVL6QRdJcK9bMJiNB8vocRBHlv0XapMfqWJupgThThuRzWE3ohQ1pFwIrDhSg+h2UZxnGxsNiJLoVwUdmP4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815175; c=relaxed/simple;
	bh=N2Ytf4PmH2myigvUKMqYUbjaDrOTgHCXnYH7NNPpZ9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+Xnu9SBFwS5xUJ4smqvjGKWUfHUCGisUg9tK4cl6iCPfPjsqseEVEmsg0+7P3mBm5oNull7p2ugO3can+5Mg4k2d3inq0o4ulh8AYrV3C9T7l+2yO+dNAahAAfdZ0vZFlVUf0a/DSWlf3ObMlgH6OWy0maRfsOyTPDFNcpBElY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rErJRG4Z; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79ab5fd969aso20382087b3.0
        for <linux-can@vger.kernel.org>; Fri, 10 Apr 2026 02:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775815173; cv=none;
        d=google.com; s=arc-20240605;
        b=K4yOoSYHijVXGMz6iVgCypIpt2N61xXu3D7BkFDuL2zCJ/rqkal0gKLJzuI/1vCgyk
         zD0aMuYDui4hC13ORFeR/k0zzftbWQ+6Z+GprEKtwj426gHV3dp9/FDjLMkOM0j756hg
         IND0tH7Kqmbf8lY/INJR0KBUECZ9+MCO7WRRZ6YCQEGVtfpSF3txX37xAQ5nOHm5+mai
         iEfHNkFRKqWqgPts4zOvscQ0kViqD/dE6q/JtPtaUhCVyrs8YfZypvAO71gN0nfdwG+A
         Eh8rps3LJuQqM0eL0z7sFp219sUnz8sT6bzQJRMVbxlegEjtN3h21v/A2lmWyw6z0U8F
         JFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N2Ytf4PmH2myigvUKMqYUbjaDrOTgHCXnYH7NNPpZ9Q=;
        fh=htr/9Tcff7QyIwk1Jh9q3zNm9rl8pbgddnMfKsblGpw=;
        b=ZIZK4sieaDgIiEK3XRA0s/qQmu03VV4JcSzozpiItNi9u4Cv12gJ/b9Z3cDac5SLa+
         9tYUPYnOTrNJt7uQARZDFjrotQf10u5BQnsGb0y1DIjy+vs+cm++iM+WqONcXcj1i00n
         hrrsNEIXB3fp3xrLSi+LjIOtn2qpGwu0wPpRd21UE1MpMpRgkzgfSv1AEoH9UePXWar9
         SYla5EigsfdLrwMPmINepd8tjoepUHYUiBY/zpg/d+KbUcMSEAQn4d8Jwld222K8c8u9
         n2ejwowMxlGf5Yu2xLsnuPyPjmQxfOD0hWhXvXXzEuL9nHDDvsEnzvDyGZaN+xZD6dkL
         gUtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815173; x=1776419973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2Ytf4PmH2myigvUKMqYUbjaDrOTgHCXnYH7NNPpZ9Q=;
        b=rErJRG4ZXVbUQMFbRFnmhepxOtcXBpodg5RLaOgBH+BoRSymMMJ7ImR40QJedCzbyW
         tMf1Kw0G48yG1WZj+bNeo4MywgSjIiHC6+mdUiWs/1trlCFn5wz1/AAEssiw7iJpV45I
         HfNU8cXmReN8Nsez829lTb/TBvUrr77OsqHawEgFSQ6vY1oOAVLWJ0U/Z4+fMTe/VFCg
         IR23/Yp54EUoq9dhxidWHZuyoQIaTlIzdzfge5/sD4+zoIksk5Yd0vqptdZ4fGSwlDMf
         y/S/uZCe8K9ouwDdws1zrrxjoze6PKxwMOQ8PgDitKmFK8vgUphQisVdc+pg/trHdpwt
         wTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815173; x=1776419973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N2Ytf4PmH2myigvUKMqYUbjaDrOTgHCXnYH7NNPpZ9Q=;
        b=mjpf6egRr6BJYvA3lrlZWZYI4RsQkie5Y8uCJ6Ymj/htSFaNFYcEi7pPpm6m31INgR
         8HZp84lGGasi2HBCaFRimepHlwTprue7TT4zlcYf+CjwXOqrxMe9gHtrJPHNV0CnaOCM
         AX9ilieFHuqDWbksPJNcz/+jEPVe7T+XOROwxZYjC0QavD3k7yrwrmVh+3DUtDnWkVZP
         ElyW+lgUUPX0k7sHitFVex3ZqvdE88amHStkmebYZJhH5VKgYWVJLgr3Afp7Gpx1kcDV
         vKi/NOlpuDD+mdqUE6jeRp2/YRdor6Kl3C5R7JMGDLJAOSEOXJtdwa5LECYXVVpj4+rn
         JG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUb/9iNonLYOzwyqEHJsgaXpBgMzpHEgGLkjHuIvU5KSHkVy8uvHiMOlW6GYpRQl002Bh3EVfiAtnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySLQVXjwlFme7sGWJqvkCUw225HI3NIdw/SodJ3yKXgc0snhXl
	DTtpvmWMR1S/50WU/4QUb9vPtxhRmBuVqHdpV8vB2qTi1mU7bf3u7RyOl0JPfF00pkMmsQ2+E28
	CbHEZzPKBa3H1vc0vYRclloKJa8sicAs=
X-Gm-Gg: AeBDieuHl/F9EKyrLLKaidpBD4B3ytPkI3bqOw8gwlwH1FD8Miw8QkTSAhGPcbJPFEe
	98tH5knSiMJ8N439S5QGm0+wotdWx/Zb+cCTRLdLbC5u6m2/bmhv2LCJ2ZXqSwZNDJZMuJQkze0
	EZz0BrYn42sqGQ3AoBF6cCE0SX9tN5PH6NYj3tA0DKN6ToyRXSh+AqbBBmonUkLZF2iIYFNmFYq
	7Klk9GG0fkEJTszEQJH8msMqcoOE/0N4mCAw7MmVoNG/l6F14VJtxAr61s/OCuNp0MPF6OrqurE
	dktqFn5B8t1olLkmgckiX/fbGfQtpt2Fn64xJzVLgg==
X-Received: by 2002:a05:690c:83:b0:79f:3715:1980 with SMTP id
 00721157ae682-7af6f907f77mr24281587b3.12.1775815173216; Fri, 10 Apr 2026
 02:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408053037.1867092-1-a0282524688@gmail.com>
 <20260408053037.1867092-2-a0282524688@gmail.com> <CAMRc=MeJL_po8HuBa4btVowR-e0i2FyzbDgNVo2u54iPKyuvWw@mail.gmail.com>
In-Reply-To: <CAMRc=MeJL_po8HuBa4btVowR-e0i2FyzbDgNVo2u54iPKyuvWw@mail.gmail.com>
From: Ming Yu <a0282524688@gmail.com>
Date: Fri, 10 Apr 2026 17:59:22 +0800
X-Gm-Features: AQROBzChhaENjKRgm1eiXEkKC5Ek3HBghHXiZXP2Ngye9h9-wWZ61ho7Hz-V2Tw
Message-ID: <CAOoeyxXqUbdd3Y0VorzVVOARVpoEkx033sYrv5Hs4tRfst2tOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mfd: nct6694: Switch to devm_mfd_add_devices() and
 drop IDA
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: tmyu0@nuvoton.com, linusw@kernel.org, linux@roeck-us.net, 
	andi.shyti@kernel.org, lee@kernel.org, mkl@pengutronix.de, mailhol@kernel.org, 
	alexandre.belloni@bootlin.com, wim@linux-watchdog.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7362-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0282524688@gmail.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9BF9D3D552A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bart, all,

Thanks for the review.

Bartosz Golaszewski <brgl@kernel.org> =E6=96=BC 2026=E5=B9=B44=E6=9C=888=E6=
=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:25=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Apr 8, 2026 at 7:31=E2=80=AFAM <a0282524688@gmail.com> wrote:
> >
> > From: Ming Yu <a0282524688@gmail.com>
> >
> > Currently, the nct6694 core driver uses mfd_add_hotplug_devices()
> > and an IDA to manage subdevice IDs.
> >
> > Switch the core implementation to use the managed
> > devm_mfd_add_devices() API, which simplifies the error handling and
> > device lifecycle management. Concurrently, drop the custom IDA
> > implementation and transition to using pdev->id.
> >
> > Signed-off-by: Ming Yu <a0282524688@gmail.com>
> > ---
>
> This does result in a nice code shrink but I'd split this commit into
> two: one switching to using MFD_CELL_BASIC() with hard-coded devices
> IDs and one completing the transition to devres.
>


You are right that this change is trying to do too much at once, and
splitting it as you suggested would make the series much cleaner.

After looking more closely at the ID handling and hotplug
implications, I realized that switching to devm_mfd_add_devices() and
dropping the IDA is not a good fit for this driver. The current
mfd_add_hotplug_devices() path uses PLATFORM_DEVID_AUTO, which gives
globally unique device IDs and avoids sysfs name collisions. If we
switch to devm_mfd_add_devices() with fixed IDs, multiple identical
NCT6694 devices can end up registering subdevices with the same
platform device names, which would break hotplug support when more
than one device is present.

So I think it is better not to pursue this direction further.

For the next revision, I will drop this part of the change and keep
the existing MFD core logic, including the IDA usage. The series will
focus on adding the nct6694-hif MFD driver only, and I will add the
IDA initialization there as needed.

Thanks again for the suggestion and review.


Best regards,
Ming

