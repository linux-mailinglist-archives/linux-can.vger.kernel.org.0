Return-Path: <linux-can+bounces-471-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10518ADBD0
	for <lists+linux-can@lfdr.de>; Tue, 23 Apr 2024 04:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10918B2143D
	for <lists+linux-can@lfdr.de>; Tue, 23 Apr 2024 02:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E217545;
	Tue, 23 Apr 2024 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJbxLtj+"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E43FF4
	for <linux-can@vger.kernel.org>; Tue, 23 Apr 2024 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838552; cv=none; b=IAtrpa0mP7k6PQJwb5gd4dMQNLfB4wnO4oQA9My2NpfFnjzXRrxVcjHrWWxDhpqPzkwp7YxBgjWuFzG0vSN9gtZvJqCMzVkGgIAkHRV96oOwzSudY3c0DJFrq6Brp7Kf35AjaZLAKfmvzd98mMz6wdEj336pc2OoOSDpU8K9IdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838552; c=relaxed/simple;
	bh=Bpl9LVSvd1mo2fxhsmsJlfuOwyOJvrgqP+5dYwtZfkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZYvKAWGPAWUlE9YFp9Fek7rCpMeIP0fmess+Rg1yLLO+O9Eq4Rec5st/DfcB/tBGZOR8zwPNUSbOp/0gy7fc3ze1TsEBXlH7UF0kTMd4oBNll9Qlo8IsgPqKXZ6xmhgZpKEo+GL+Wel2E1jTrY0y57g6xM8zQrDt6SwlXIkfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJbxLtj+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e8b03fa5e5so35204315ad.1
        for <linux-can@vger.kernel.org>; Mon, 22 Apr 2024 19:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713838550; x=1714443350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UZi3xfpbmkAj8R72pl1ypwf+f/lgouGQAWrguEKXGL8=;
        b=mJbxLtj+LkaICznYi0G65cP/tBIs9H6lu9fFaGwo/y6Jm66m+ws2/3RpH2pawVGqor
         tcmBi8+/hbzT4V1zsTolX8BAS230T5w7CPBk/JQxPnCfBBMKTcs1rM1dwWAStwVN5MXR
         Fhu6fkH0aqfuYEIdZsMaLagrCZXgq413HyJ/o7kNn0N4ncC3adnYNkIfa3md1CJlWfMy
         vq5va6k9YMeGG0Ljz2reB8+WoXLpPJvbktk3/n7stKChHuoEPWT6jJsFEnaRT2+JvTjA
         mTiJulPM7pK7MOJMYOp7GnZQ5NbGa8NVfgJrsC9RB3hW07lFnfDbeTmIIDc5N8RDwso9
         45iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713838550; x=1714443350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZi3xfpbmkAj8R72pl1ypwf+f/lgouGQAWrguEKXGL8=;
        b=xG5XskdQRHK2mR0Fd2UFkyDpm3o0aYJBi/+cVcIoiBsiB+a/SP6pM7S5SoRQbxUwq2
         +psFISvysd49Gw6TcJeM7422uD935mSk3kXeEpEyeVwakjoINNqzyZIpr5pYbE/HM5NV
         +8cLHEfP46mZeJaJJRkDyhTrN1AWDLVi+2YgoH1tIkhTs6aR6YUDWmrORtY812pfmWoH
         EBIejDVJof+d5CrkuS6PTGfnP4S8bLvGZofQOMm16HEj2yJZkARRxApUuXPu0JnjeYov
         U2sGSdaqFmFq0L8M0lPhySH0NENIkjDac6zt8BdY7GaefenBGI3QGy8vP3MiExBG1Fv2
         rMqA==
X-Gm-Message-State: AOJu0YwdXrPvB5jP592ZgFjTYI6cMPfAL3Svh2XANXCZefSudmIqGg6v
	p/zLHxa5sZCqoKREAoi1/eqBnFTYjJ/jJ7KtrgyIQ1MprJKGRJiMTGMnzUKPd4ffOeRgEgz5GJT
	6uBvtviIU/x+0vY//B+7KDHFTXVxQYwMN
X-Google-Smtp-Source: AGHT+IE1oS+Lxe/4v6NLoDzZXGHfDlM7hKg8gOT5oJkfrDfCn8gxspQv3V+h950TkFgrznTujtskV+dTUxX9SAmAQxk=
X-Received: by 2002:a17:90a:df92:b0:2a5:16c2:8551 with SMTP id
 p18-20020a17090adf9200b002a516c28551mr10695888pjv.19.1713838550356; Mon, 22
 Apr 2024 19:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420194746.4885-1-socketcan@hartkopp.net> <CAMZ6Rq+3LJKcU5+nQmZ95AyLMqQe=y4_tCsBbuZ_j2cSuz9+3A@mail.gmail.com>
 <2a787ef1-de8b-44b0-b1d4-9d52180b6440@hartkopp.net>
In-Reply-To: <2a787ef1-de8b-44b0-b1d4-9d52180b6440@hartkopp.net>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Tue, 23 Apr 2024 11:15:38 +0900
Message-ID: <CAMZ6RqLM5bvrNXa2c=wkzk+w1EArMxD=epeDOSdjJYdFxJKUWQ@mail.gmail.com>
Subject: Re: [PATCH] can: isotp: remove ISO 15675-2 specification version
 where possible
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue. 23 Apr. 2024 at 02:41, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 22.04.24 07:50, Vincent Mailhol wrote:
> > On Sun. 21 Apr. 2024 at 04:48, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >> With the new ISO 15765-2:2024 release the former documentation and comments
> >> have to be reworked. This patch removes the ISO specification version/date
> >> where possible.
> >
> > The patch also renames "classical CAN" into "CAN CC", which is fine
> > but maybe add one sentence in the patch description for that.
>
> Hm, IMO this is an editorial update without any new information.

OK. That was a nitpick. See this as notwithstanding, I am fine for the
patch to be picked as-is.

> > Aside from that nitpick, one comment (see below). Meanwhile, I am
> > giving my acknowledgement in advance:
> >
> > Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > Thank you.
> >
> >> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >> ---
> >>   include/uapi/linux/can/isotp.h |  2 +-
> >>   net/can/Kconfig                | 11 +++++------
> >>   net/can/isotp.c                | 11 ++++++-----
> >>   3 files changed, 12 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
> >> index 6cde62371b6f..bd990917f7c4 100644
> >> --- a/include/uapi/linux/can/isotp.h
> >> +++ b/include/uapi/linux/can/isotp.h
> >> @@ -1,10 +1,10 @@
> >>   /* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
> >>   /*
> >>    * linux/can/isotp.h
> >>    *
> >> - * Definitions for isotp CAN sockets (ISO 15765-2:2016)
> >> + * Definitions for ISO 15765-2 CAN transport protocol sockets
> >>    *
> >>    * Copyright (c) 2020 Volkswagen Group Electronic Research
> >>    * All rights reserved.
> >>    *
> >>    * Redistribution and use in source and binary forms, with or without
> >> diff --git a/net/can/Kconfig b/net/can/Kconfig
> >> index cb56be8e3862..af64a6f76458 100644
> >> --- a/net/can/Kconfig
> >> +++ b/net/can/Kconfig
> >> @@ -54,20 +54,19 @@ config CAN_GW
> >>            by the netlink configuration interface known e.g. from iptables.
> >>
> >>   source "net/can/j1939/Kconfig"
> >>
> >>   config CAN_ISOTP
> >> -       tristate "ISO 15765-2:2016 CAN transport protocol"
> >> +       tristate "ISO 15765-2 CAN transport protocol"
> >>          help
> >>            CAN Transport Protocols offer support for segmented Point-to-Point
> >>            communication between CAN nodes via two defined CAN Identifiers.
> >> +         This protocol driver implements segmented data transfers for CAN CC
> >> +         (aka Classical CAN, CAN 2.0B) and CAN FD frame types which were
> >> +         introduced with ISO 15765-2:2016.
> >>            As CAN frames can only transport a small amount of data bytes
> >> -         (max. 8 bytes for 'classic' CAN and max. 64 bytes for CAN FD) this
> >> +         (max. 8 bytes for CAN CC and max. 64 bytes for CAN FD) this
> >>            segmentation is needed to transport longer Protocol Data Units (PDU)
> >>            as needed e.g. for vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN
> >>            traffic.
> >> -         This protocol driver implements data transfers according to
> >> -         ISO 15765-2:2016 for 'classic' CAN and CAN FD frame types.
> >> -         If you want to perform automotive vehicle diagnostic services (UDS),
> >> -         say 'y'.
> >
> > Not sure why that last sentence was removed. This is out of scope from
> > this patch and I think this can be helpful for the audience not aware
> > that UDS relies on ISO-TP. I suggest keeping that one.
>
> This is a repetition of ...
>
> "segmentation is needed to transport longer Protocol Data Units (PDU) as
> needed e.g. for vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN traffic."
>
> ... one sentence before.
>
> Therefore I thought it could be removed.

Oupsy, my deepest apologies, something did not click right in my head.

Sorry for the noise. Just in case, I am reiterating my previous message:

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Yours sincerely,
Vincent Mailhol

