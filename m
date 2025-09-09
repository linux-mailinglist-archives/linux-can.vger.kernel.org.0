Return-Path: <linux-can+bounces-4546-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0CB4A2BF
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 08:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5184E15F7
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 06:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F202FF652;
	Tue,  9 Sep 2025 06:58:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21F1FDA92;
	Tue,  9 Sep 2025 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401102; cv=none; b=nSCvFvoe7LD30rqw2VC/Zfs6yCwQDj/gq5ZwKTqtkhfTFdn/MrNHGQhNbkAD5+HOxbjiMADXwm0Rbv4ejxOxKwdldt7WVhXDUaxKCq3+ObZkQ31bLdtuL1TyZem4en59Z4jxv+dvl0PY6SoqL12LZqEJloQuRrPs6OtZvzGCeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401102; c=relaxed/simple;
	bh=NREHroOH60NmaadgGH506UtvqnStKKG2TNIcU7aXqNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNAKQlSqFNWf8T6kMrs0T5c4wCNu6HF4TnylsH0xIleMDYJBdRkvruqzZUEgq6Db3c2KElyO5j3ctUwhP5zmodAtP7HwkJOuquIPgdhvXvPdCoTdOTrmpglr0Y6ctFwXZntgaQjyq5bpCD+/0UwgsCrIPLtqzECk/V8mx4XKxg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-890190c7912so1282988241.2;
        Mon, 08 Sep 2025 23:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757401099; x=1758005899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2VrP7w7F8XuCqqty/grwfL2ktKoMV7G9zqcRVephDg=;
        b=gQ+RhakIN4MoudTwWmOQuhrxqAn2tP4a0PcRqS66MSkedZ85JOW7NdFjTWuhYs8b4e
         KVEOSFu6xkcMypzL7u+nMpTDdj2B38shvmZ6BTvIa2wcJnSSAaEmqfNwF/eDM49uWPC9
         nhJSTe05M0RFqL2INb8GrAknQFdhFhPVjw8tnCdd7wa78RSyNpAHiRD4LU4MAdpwN8jX
         ePxSttV2mxq08OdDBgunjOjtJqzAhL2i7ErtvB3uPPWeo5pwQ0chLbOHu8aDZ+fGxw3z
         t+ulR2u7IOUsjd4iwXkzUCnL8ceDlUMPQKAd7kgh2svfNp59YwaPKXUNB4WlmA/kWaQz
         0ENA==
X-Forwarded-Encrypted: i=1; AJvYcCUVuODs0OsaCPhUMrnEK9kJxTKR09JGkxOjUow7ThZaL66FrwRVRYfZJWyQrv3U9BMrVWNKTcdkrK2+EsEWlo1zSw0=@vger.kernel.org, AJvYcCVAWhYIIVVUQzUt6DOiBMZqalGMPBIAHVNceHZbqBsegFMrMaJYi/gDHPfDfGQbq2YfN+lRWYcRV8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNyzLQbjcvmfj11Ql2L/6sK12GBxWcO5ng13O7hslebp5u55s
	ifKxStY8tc4VG8Si1u7/p43dyyDTWnKs8RaUEN3HAOiwSiqN+YAWwzrEWbm0ZLsd
X-Gm-Gg: ASbGncsAuqGd0oGmGA9utKWCW9w92BLiR1hwLJ9gPrwvibfbUXafh7n3mxLdZt3F02Y
	7ZERFE42+DaWGmyQnRSNwn8AXKdyFr4iZUeHlE2t1mnfR5MmEMvspiw2MIIE9RIRhFzpxu/n6SJ
	I/F2Q0s9BxiUf4rO15QWU+CN+MCmS46y6lCheBi7GP6cpRLQjaXqBbwAfkOcnyJ/AYeDo9rb9fw
	DWf1RtKHX7co7nspOTIrYwfKHDZdGd0zDnS9cDJPEP/DMSU4Ra3U0QLZAViDSVaNp6yz5AO0CTI
	Q/fr5X3ZxYdVzjKiIg1/YDkzW3QGdjQ1Xbrh1EoUaU1IylEceb076n1kpex0zcqnC3InteeI3CQ
	iBBUJiDwGT58Grl2Q26UT6U53eKNoYryoeN19RkI7MNEZ8pdFNjubDb6C4+GgvHLgDU1p4FTRj3
	A=
X-Google-Smtp-Source: AGHT+IFnlL3Q/eRWiQEKxDUi1FozMMdrgOT77cjObX0v2RJvhR9xlWvWO2Cet6kYzh+JjGb/4aIM0w==
X-Received: by 2002:a05:6102:3048:b0:523:863d:ece1 with SMTP id ada2fe7eead31-53d1376b7ddmr3605421137.17.1757401099031;
        Mon, 08 Sep 2025 23:58:19 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-52af235c6b5sm11138900137.17.2025.09.08.23.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 23:58:18 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-544acb1f41dso2275745e0c.2;
        Mon, 08 Sep 2025 23:58:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHxw+0o8HcT+kJNPqL7AZUB9iKmuM5YIoU1pHgYG5kljiQpiAW3JkOApgZ2rcOgVVw38H7yKKpBYcAQs1xia/dg9M=@vger.kernel.org, AJvYcCWnep0uU7Vp1fGR531Ca+dvAKWs4jhDdb2QPRfrTe0cJ4ejRgjxEDJRqmElyM94f/y6x7BcTsAfcqE=@vger.kernel.org
X-Received: by 2002:a67:e7ca:0:b0:529:b446:1743 with SMTP id
 ada2fe7eead31-53d0dfbfdf5mr3429442137.11.1757401098290; Mon, 08 Sep 2025
 23:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755855779.git.geert+renesas@glider.be> <00ff7a4ad18bb26a74c77134182b4efd380ecc84.1755855779.git.geert+renesas@glider.be>
 <fa9a5a87-d91c-4d24-af76-432c0db59df8@kernel.org>
In-Reply-To: <fa9a5a87-d91c-4d24-af76-432c0db59df8@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Sep 2025 08:58:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWgDfRMPppsCUC-QmAUV86aXspL=w7t_i+=WcnMe3Wjqw@mail.gmail.com>
X-Gm-Features: AS18NWAWO75yosOBKGMCwLfsTTkfLQh-Pmrknf8WDD_cpPQpMlwF0hQsHjWzmCA
Message-ID: <CAMuHMdWgDfRMPppsCUC-QmAUV86aXspL=w7t_i+=WcnMe3Wjqw@mail.gmail.com>
Subject: Re: [PATCH 2/6] can: rcar_canfd: Invert global vs. channel teardown
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Tue, 9 Sept 2025 at 08:38, Vincent Mailhol <mailhol@kernel.org> wrote:
> On 22/08/2025 at 18:50, Geert Uytterhoeven wrote:
> > Global state is initialized and torn down before per-channel state.
> > Invert the order to restore symmetry.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Same comment as before. I assume this is only cosmetic, if not, Fixes: tag please!

Cosmetic only, TTBOMK.

> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

