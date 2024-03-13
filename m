Return-Path: <linux-can+bounces-376-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B6287A62B
	for <lists+linux-can@lfdr.de>; Wed, 13 Mar 2024 11:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2ADD282E48
	for <lists+linux-can@lfdr.de>; Wed, 13 Mar 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6183D3B3;
	Wed, 13 Mar 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1553wrsl"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9FF3F8E0
	for <linux-can@vger.kernel.org>; Wed, 13 Mar 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327358; cv=none; b=J8wjtjQ/DSPERr/315/rMtRsQJVW6zXelQro+N5VAVTTBGoND5QPlWArMjBhSR1sicjRVmDWwzx6soBL6WNraGt5a6FcN5YrPENP6kicfT2ZB7laLnvnRzi9WvukXOfgO9DTprSwny7KbTEmMV2DCfG3GKFD6+8v25xyOQkcu6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327358; c=relaxed/simple;
	bh=lb/fxTau6774fMOnijhMJw5iOwqc/gtg8hNyEEqyOVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5+M0vnRNNTu+KcnvjD4atYdveeCB05rw/d5zJYSXufni8IFMANem0KwdKPTZyFszrjLx8/r+mdmuFKpfJ1lU37xX0spm0lEN2vxJD0q4yAs1T0d5Ce0EIwrmKxff8MFwU74KB0fCGSipurtXk/EbS8ZR/ZPIeSuAc1uoX9p12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1553wrsl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5687ebddd8eso15359a12.0
        for <linux-can@vger.kernel.org>; Wed, 13 Mar 2024 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710327355; x=1710932155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUbDfP+sLUXM48nDyVWIk/glEsJoVRqxJc+rC78QgaM=;
        b=1553wrsl2b8c/TdPnqq4O2k03ALxVyO4IUt6Dsas092iycU1s8wjoHbp53r/CreTzQ
         qieJ4qrhHKBWw7roD5eKjLh2LEYGOkx1PODcR66CQ98UKZ7XO26b+UW9ZLmQ1Bv9IHXm
         63LWxaONTXcyTDXl353XWTTrXAuk/Vtwl6UB/i7hTkWeYaG1zkfkB2URkUVk/NVODlzG
         GNyR8ReRUmW07OmJGtHINH0iaL5ugukvDMQf+u24CRXLZMMuN3xFrR0VkbN0Emz07POY
         bTSLcRWhIezruy1QxP6U+JRzOJ8BKTcB13kGfN927GffC/egaMakzch3BdBvijwSCgnV
         EN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327355; x=1710932155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUbDfP+sLUXM48nDyVWIk/glEsJoVRqxJc+rC78QgaM=;
        b=oDKjqRdlh3FIMUzdDvjlSyb6TU57+mRL7RZ3iPkUcOZVylMQZP5VdhV8EAYjxxuk8m
         qorwwVmmtzh8b5/ScC3LvIxAfKs22+Lq23w5l+/MYJUTmsAQ8WdPv6MtM8rzfcE+bBH4
         zXov2NtBr6UZ+LEAM3FGJZqdh9cgnJNPsgSs96Zjrs3AYCKdyf4NTq3yN+loYjwExT87
         Ko9U52X1o+PpXvBGciEYbiPH90zX1eFbOkBgXalALWD0KWFizE6da6ROeTevdRl6NgQA
         EtCqb8cdsJk2M5F8nPtXFlp1MYJcOtsVZDRDVHKxmU/qjpNj6UKjKqZkKGSF8pLr9PhF
         vmxg==
X-Forwarded-Encrypted: i=1; AJvYcCWDUeYJ9KZq7djZL2LMCyFkjVddMcLY67NeG7ZhrqKwoSE9nEfPTRD6j7EYICP/j+Q0adjQQLKCegPYqHvEwhy792wHh0BLgoV1
X-Gm-Message-State: AOJu0YyG3WTlAhSLzDCVhC0PadxtCYfRWqvSYhUJoAob/QIkPxOfUJlp
	jBgmww9OTDgex4FEKeALrhmyoKdqW9nREpsFZQJnU9EpZtf+61XRa2suISyfFFQQAANKgmwRR4h
	f0L/z3Ps2yFZlmtZeC8Bw+rLoctI92WguC6dk
X-Google-Smtp-Source: AGHT+IHrRNQakJc4w7wh8Shn67Mfj+lyANmSwpYj0TzUp00xofQNBBhIPzQSMsCSrME7frjeeFuK5ZbFKFpyMEgJV3k=
X-Received: by 2002:aa7:cccd:0:b0:568:271a:8c0f with SMTP id
 y13-20020aa7cccd000000b00568271a8c0fmr125966edt.7.1710327354472; Wed, 13 Mar
 2024 03:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313094207.70334-1-dmantipov@yandex.ru> <CANn89iLCK10J_6=1xSDquYpToZ-YNG3TzjS60L-g5Cyng92gFw@mail.gmail.com>
 <aa191780-c625-4e13-8dc0-6ea3760b6104@yandex.ru>
In-Reply-To: <aa191780-c625-4e13-8dc0-6ea3760b6104@yandex.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Mar 2024 11:55:40 +0100
Message-ID: <CANn89iJNBHnCPNovYE9tjQT1eN4DE-OFOhE9P86xX_F0HxWfrQ@mail.gmail.com>
Subject: Re: [PATCH] can: gw: prefer kfree_rcu() over call_rcu() with cgw_job_free_rcu()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 11:28=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>
> On 3/13/24 13:18, Eric Dumazet wrote:
>
> > kmem_cache_free() is not the same than kfree()
> >
> > Unless I have missed something in mm territory , your patch is not
> > going to work.
>
> Hm... it seems that you're better to check include/linux/rcupdate.h
> and the comment before kfree_rcu() definition in particular.
>

Replacing call_rcu() + free()  by kfree_rcu() is what is documented.

Again, kfree() is different from kmem_cache_free().

kmem_cache_free(struct kmem_cache *s, void *x) has additional checks
to make sure the object @x was allocated
from the @s kmem_cache.

Look for SLAB_CONSISTENCY_CHECKS and CONFIG_SLAB_FREELIST_HARDENED

Your patch is not 'trivial' as you think.

Otherwise, we will soon have dozen of patches submissions replacing
kmem_cache_free() with kfree()

