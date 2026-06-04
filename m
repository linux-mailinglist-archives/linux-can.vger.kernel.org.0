Return-Path: <linux-can+bounces-7757-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PiaMBcoSIWqR+wAAu9opvQ
	(envelope-from <linux-can+bounces-7757-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 04 Jun 2026 07:53:14 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA7D63D170
	for <lists+linux-can@lfdr.de>; Thu, 04 Jun 2026 07:53:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Zdm8MWNv;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7757-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7757-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 541793009B05
	for <lists+linux-can@lfdr.de>; Thu,  4 Jun 2026 05:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558DC38836D;
	Thu,  4 Jun 2026 05:53:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4103CD8AC
	for <linux-can@vger.kernel.org>; Thu,  4 Jun 2026 05:53:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552391; cv=pass; b=EHOTnsCR+bP3EYtc/K0FtyhVnFyQ2XAdu5MKe+/Vzd7sZWywFrPy5fh6kZP1k91hbRjgeMTAiHUZRdk4YMAf+/5VrThEdLATzAklKk33RHWGBlZ7evLPJ7SmrD+wqS9M1MWyHAUGFL96qzk7+QhQwv2kDZY49lUW1x+Ft+Vw1bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552391; c=relaxed/simple;
	bh=TLSpcxtgDeJBIXPHc/zgfPpJqeFc/XjZXKIQU+6j4Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyFg+VylTfiLy/cPNwUGhW0kfgLuDTmzJ4sXoEv6PhSMMKQeePScDwus/WKGwsUDPQw+uMIPVDtW/DgMdC6j4UV3x4hcqtpa9wRygKEjRpHCtGMJswrwiEGaI0yc8C9KsepHlRHLFScw+xBcslL1+XYjXKXoRmtIzC4iAWM9kzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdm8MWNv; arc=pass smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68c19f1f3ceso391757a12.2
        for <linux-can@vger.kernel.org>; Wed, 03 Jun 2026 22:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780552388; cv=none;
        d=google.com; s=arc-20240605;
        b=KPVdJecKnASplzwgIw9VJB1L5KYCxwGwqEPgpnUnygeJNsP4vgZkqYFEpr93yR30aw
         ps3MQHPvTM7XrG8z1oAjJ3CldIkpHEb4cgNJcTZ65RCubUGEGdLCKzOKNSffZ0M0/p86
         ll8B/Os+7ozFwEtJ+bCJ9sN+c/EyaA6FLeaznZw0ZOdY+E33xV5xF9EoAb70RzKmymrX
         UryRItnVhVA70kaERJV1QMXGIUedFS51hXGHQNfFkML1i+2Mbo45qtrTuiuBSQbzMNMo
         zvD6+SsoXsDqflmaQDbtioBmhDLiIkGGIHbveApO+ELDhIgGLbgtabkR40piiivvlA/q
         xVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ghFlsP350/NvZ7Hzmhk2+1q0DGzMho+/JxGVwW5E1Gg=;
        fh=A5daGtlwruRpfTeUXnnitNu4af19e9UfwS62x47akvo=;
        b=YDAxBtD9mNCc9Q+S5ELVfgyEu/h/36RkHR8544N8gckoavvuvlgsxH3Bc7tHFlwb5u
         i5y6QQ9fJVubf9eYV2RvE16bxi8NdQt2KGOkXri/bJCyoob6ayPqOs4uvvenUaa1O+o/
         58CcecjPmOHJAcSLtRuCjpwDSSr2+mPpyQON8/aGWGOlrJmuHq+EJ0rZ7efU4aLBj4Oe
         HYD1XbfdHSQvsQ9WC27JU/r37l9h+cB8b8aMWrY+EV+MvK8b5Lbc1bNIr3YE1o6IHmfB
         t3HkJc37H48yx5h0G+kzIakOPbMW/tY02iLZBDKHGohAyof83e2Q3lqy15PFCi7hWHYp
         zV1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780552388; x=1781157188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghFlsP350/NvZ7Hzmhk2+1q0DGzMho+/JxGVwW5E1Gg=;
        b=Zdm8MWNvBdzryuY/CHHH2VJeE5HSwAUg5sSqVtOjFi4MY1fFzKTQvtvEg9PEreisWl
         ZTAPTw1LLqW/UhMoepg8sjmeO7hMvq8t8xQG58Jif/QDYyzgtlAhipAmI+du+QWEqGj+
         hcpZaPZJl9men+luRwIsH+fq6jBlMSxFQl4QbPRabYsdSD0SGqInuik9AnoHi1opg7wD
         k3w607ZQh2JuYWcaCjvJp0phnZxe/c8Iy9RRLg+5iYJayuBsFJC81re6qIl8mwOiOWM+
         kGCY6auNr2Ieza3zQ56MRba83hNTz/fCYWW5m0YPZB08/L6CN44bmniXfcEJXYk7udMF
         BJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780552388; x=1781157188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ghFlsP350/NvZ7Hzmhk2+1q0DGzMho+/JxGVwW5E1Gg=;
        b=hs1ZKsTBwZkf4mEstkoXE9eMYjcD7FKYMjPqzwBod1yqPrnEoS0ohpuR7yOA4372wd
         ++L/BOhNBOMLpb7esafo5GHPQeWVLBXScSSXUNj8cF0XAYUIgtbL5Bwq1k3bcdtuv/kH
         +/LO55cZy2mOZUSz1bRUQNnFwGaNkdIfXq/ZKuTc8sYdWExC+nfL159LwEJjvIFkwXVz
         sXBw9T2KiSZ83EEeWgNs5ilpx/Ae9EL5vkBCyKiNUxAo8K9KIDN16AaVF0sTk0D0Xit9
         /oiBqslTcL2iaO4CREtDGizu7dTdy8LAHzvF1KxSevXhRb/4CT1uziu73cUre3wxH5RX
         BSuw==
X-Forwarded-Encrypted: i=1; AFNElJ96E3rP+hsTxMHLNzyVC9u3B86f+EZnlVl3Qi/YHVKvyg94xTVTzAlQ4NHVYfO0JiLi9Frce7P7wFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzucjd1GBVyGGOn5AUIDBFQ52UtyRzGr90M72M33XwKaf3UqAeP
	f4MNCOHK1pp4m4ztEgPmQgU5XIzvL3t2M8JzD5p0jLJc0jzzhCMJ+5kR/wCp/vvd1Cr6/y+FJpC
	kVWLNPe/CBVCAwdYMqOwjQy8bHGn2qKM=
X-Gm-Gg: Acq92OHnCG+9TkEx86Ne3oCX1qhc2L9Iw5KECuGKWboH0jkZgIlKcg5HKJ4LLIiflQr
	e4bClAcrUivczOOWYBUXo/LEU4W9P/mI/v84ztxIYAwN9HhLUvZIg5Ibrc1NtBsdLcEdCKn3vm0
	f3ksW2FXCU6tjK+wna8XMfjfy5SCuH2umm/07fnaV7oukkpdeqIpTZ70L70pLn3Y/JkWr3qV+qt
	H5igDEt4nSOGlJnRNoR5A3oLfHSd8qVnhuEPVI3gvyXJ0qFiKqpU/nFn9EM4Yx0TxsX4nHQ1THQ
	S/CaObezb1D/GZS5oWp/
X-Received: by 2002:a17:907:6e89:b0:beb:f71c:63a with SMTP id
 a640c23a62f3a-bf0ac304ccfmr362950766b.2.1780552387749; Wed, 03 Jun 2026
 22:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777273055.git.zhoubinbin@loongson.cn> <d7b19f6c1e634ffe4454809e73fb03058e7a1a9d.1777273055.git.zhoubinbin@loongson.cn>
 <709ef711-4af1-413e-9662-08892b18fca5@kernel.org> <CAMpQs4K5Q_vC=wnGp3gf=F5RU8t61PLh4dLEmcLMMbM4mR+Wnw@mail.gmail.com>
 <6ea756bf-d776-4eff-b0ca-eeaa6737e035@kernel.org>
In-Reply-To: <6ea756bf-d776-4eff-b0ca-eeaa6737e035@kernel.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 4 Jun 2026 13:52:53 +0800
X-Gm-Features: AVHnY4KGRyyIWLI06LGNy87w7s_XYI73IEIXy_xKoOqPwgPelZOiqr8t8gAYaxU
Message-ID: <CAMpQs4KfLP9z6TVx+xGzuW7KEXMRAC0Y59hMBUmq57x6U33t7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] can: Add Loongson CAN-FD controller support
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Bingxiong Li <libingxiong@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-can@vger.kernel.org, jeffbai@aosc.io, gongyifu@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7757-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mailhol@kernel.org,m:zhoubinbin@loongson.cn,m:chenhuacai@loongson.cn,m:mkl@pengutronix.de,m:libingxiong@loongson.cn,m:chenhuacai@kernel.org,m:kernel@xen0n.name,m:loongarch@lists.linux.dev,m:linux-can@vger.kernel.org,m:jeffbai@aosc.io,m:gongyifu@loongson.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[zhoubbaaron@gmail.com,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhoubbaaron@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AA7D63D170

Hi Vincent:

Sorry for the late reply.

On Tue, May 26, 2026 at 11:58=E2=80=AFPM Vincent Mailhol <mailhol@kernel.or=
g> wrote:
>
> On 21/05/2026 at 05:24, Binbin Zhou wrote:
> > Hi Vincent:
> >
> > On Thu, May 7, 2026 at 1:50=E2=80=AFAM Vincent Mailhol <mailhol@kernel.=
org> wrote:
>
> (...)
>
> >> Use the CAN TDC framework to get the SSP value (c.f. struct can_tdc,
> >> struct can_tdc_const and can_fd_tdc_is_enabled())
> >
> > Last question:
> >
> > In the general framework, the calculation condition for tdco is
> > (dbt->brp =3D=3D 1 || dbt->brp =3D=3D 2), which does not seem to corres=
pond to
> > the current condition (dbt->bitrate > 1000000).
>
> Where does the current condition comes from? Is it some empirical test?
>
> FYI, the
>
>   (dbt->brp =3D=3D 1 || dbt->brp =3D=3D 2)
>
> check comes from ISO 11898.
>
> > Although for CANFD, rates below 1 Mbit/s would negate the primary
> > advantages of FD, from a controller hardware design perspective, I
> > would still prefer to retain the condition (dbt->bitrate > 1000000).
> >
> > Do you have any other suggestions?
>
> Using TDC on low bitrates is indeed unstable and can lead to bus errors.
> But the condition which you suggest
>
>   (dbt->bitrate > 1000000)
>
> is indirectly linked with the brp values. That's why the brp check is
> sufficient (and more precise than the empirical 1 Mbit/s threshold value)=
.
>
> Are you able to trigger any bus errors when using TDC with a brp value
> of 1 or 2 and a bitrate below 1 Mbit/sec? If no, there is no reason to
> add this extra check and we can continue to rely on the framework test.

After offline discussions with our hardware engineers, we have decided
to retain the existing decision criteria.

The threshold is set to `1 Mbit/s` primarily based on the CAN 2.0
physical layer protocol, which supports a maximum rate of 1 Mbit/s;
this decision also takes into account that at low baud rates, the bit
duration is sufficiently long, so there is generally no need to enable
the second sampling point. Conversely, if the CAN controller=E2=80=99s time
quanta clock frequency is very high, causing the BRP to consistently
exceed 2 while traversing parameters, TDC may not be enabled.

Additionally, there is a low probability of bus errors occurring during tes=
ting.

So, in your opinion, should we keep it as is?
>
>
> Yours sincerely,
> Vincent Mailhol
>

--
Thanks.
Binbin

